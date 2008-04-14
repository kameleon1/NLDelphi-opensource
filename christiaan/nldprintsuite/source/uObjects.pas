unit uObjects;
{

  NLDPrinter objects unit

  =========
  [ v1.00 ]
  =========

  [13-11-2002 ]
  Christiaan ten Klooster:

    * Added TNLDPrinterInfo
}

interface
uses Classes, Windows, SysUtils, Printers, WinSpool,Synchro;

type
  TNLDJobInfo = class(TObject)
  public
    FJobInfo: PJobInfo2;
    constructor Create(AJobInfo: PJobInfo2);
  end;

  TPaperSize = record
    WidthPx,
    HeightPx,
    WidthMM,
    HeightMM: Integer;
  end;

  TNLDPrinterMonitor = class(TThread)
  private
    FOnJobChange: TNotifyEvent;
    FNotifier: TPrinterChangeNotify;
    procedure Execute; override;
  public
    constructor Create;
    procedure Start(ANotifier: TPrinterChangeNotify);
    procedure Stop;
    property OnJobChange: TNotifyEvent read FOnJobChange write FOnJobChange;
  end;

  TDriverVersion = (dvWindows9xME, dvWindowsNT4, dvWindows2000XP);

  TbaseNLDPrinterInfo = class(TObject)
  private
    FPrinterChangeNotifier: TPrinterChangeNotify;
    FPrinterMonitorThread: TNLDPrinterMonitor;
    FMonitorHandle: Cardinal;
    FPrinterIndex: integer;
    FPrinterName: String;
    FResolutionX: integer;
    FResolutionY: integer;
    FJobQueueCount: integer;
    FJobList: TStrings;
    FPapersize: TPaperSize;
    FOnJobChange: TNotifyEvent;
    FDriverVersion: TDriverVersion;
    FDriverName: String;
    procedure ReadPrinterInfo;
    function GetJobInfo(AIndex: Integer): TNLDJobInfo;
    procedure SetOnJobChange(const Value: TNotifyEvent);
  public
    constructor Create(APrinterIndex: Integer);
    destructor Destroy; override;

    procedure Refresh;

    property PrinterIndex: integer read FPrinterIndex;
    property PrinterName: String read FPrinterName;
    property ResolutionX: integer read FResolutionX;
    property ResolutionY: integer read FResolutionY;
    property JobQueueCount: integer read FJobQueueCount;
    property JobInfo[AIndex: Integer]: TNLDJobInfo read GetJobInfo;
    property Papersize: TPaperSize read FPapersize;
    property DriverName: String read FDriverName;
    property DriverVersion: TDriverVersion read FDriverVersion;
    property OnJobChange: TNotifyEvent read FOnJobChange write SetOnJobChange;
  end;

  TNLDPrintersInfo = class(TObject)
  private
    FPrinter: TPrinter;
    function GetCount: Integer;
    function GetPrinterInfo(AIndex: Integer): TbaseNLDPrinterInfo;
  public
    constructor Create;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Info[ AIndex: Integer ]: TbaseNLDPrinterInfo read GetPrinterInfo;
  end;

implementation

{ TbaseNLDPrinterInfo }

constructor TbaseNLDPrinterInfo.Create(APrinterIndex: Integer);
begin
  inherited Create;

  FPrinterIndex:= APrinterIndex;
  FJobList:= TStringList.Create;
  ReadPrinterInfo;
end;

destructor TbaseNLDPrinterInfo.Destroy;
begin
  FreeAndNil(FJobList);
  ClosePrinter(FMonitorHandle);
  inherited;
end;

function TbaseNLDPrinterInfo.GetJobInfo(AIndex: Integer): TNLDJobInfo;
begin
  Result:= TNLDJobInfo(FJobList.Objects[AIndex]);
end;

procedure TbaseNLDPrinterInfo.ReadPrinterInfo;
var
  VPrinter: TPrinter;
  VEnum: PChar;
  Count, Jobs, NumInfo: DWord;
  AHandle: Cardinal;

const
  DPM_TO_DPI = 25.4; // 1 inch = 2.54 cm = 25.4 mm, 100dpm=2540dpi
  DPI_TO_DPM = 1/DPM_TO_DPI;
begin
  VPrinter:= TPrinter.Create;
  OpenPrinter(PChar(VPrinter.Printers[VPrinter.PrinterIndex]), AHandle, nil);
  try
    try
      VPrinter.PrinterIndex:= FPrinterIndex;
    except
      on E:Exception do
      begin
        raise Exception.Create('Unable to set Printerindex: '#13+E.Message);
      end;
    end;

    FPrinterName:= VPrinter.Printers[VPrinter.PrinterIndex];
    FResolutionX := GetDeviceCaps(VPrinter.Handle, LOGPIXELSX);
    FResolutionY := GetDeviceCaps(VPrinter.Handle, LOGPIXELSY);

    Count:= 0;
    Jobs:= 9999;
    EnumJobs(AHandle, 0, Jobs, 2, nil, Count, Count, NumInfo);
    GetMem(VEnum, Count);
    if EnumJobs(AHandle, 0, Jobs, 2, VEnum, Count, Count, NumInfo) then
    begin
      FJobQueueCount:= NumInfo;
      if NumInfo <> 0 then
      begin
        FJobList.AddObject(IntToStr(PJobInfo2(VEnum).JobId), TNLDJobInfo.Create(PJobInfo2(VEnum)));
        Inc(VEnum, sizeof(TJobInfo2));
      end;  
    end;

    FPapersize.WidthPx:= VPrinter.PageWidth;
    FPapersize.HeightPx:= VPrinter.PageHeight;
    FPapersize.WidthMM := GetDeviceCaps(Printer.Handle, HORZSIZE);
    FPapersize.HeightMM := GetDeviceCaps(Printer.Handle, VERTSIZE);

    Count:= 0;
    GetPrinterDriver(AHandle, nil, 2, nil, Count, Count);
    GetMem(VEnum, Count);
    if GetPrinterDriver(AHandle, nil, 2, VEnum, Count, Count) then
    begin
      FDriverVersion:= TDriverVersion(PDriverInfo2(VEnum).cVersion-1);
      FDriverName:= PDriverInfo2(VEnum).pName;
    end
    else
      raise Exception.Create(SysErrorMessage(GetLastError));

    if not Assigned(FPrinterMonitorThread) then
    begin
      OpenPrinter(PChar(VPrinter.Printers[VPrinter.PrinterIndex]), FMonitorHandle, nil);
      FPrinterChangeNotifier:= TPrinterChangeNotify.Create(FMonitorHandle, PRINTER_CHANGE_JOB, nil);

      FPrinterMonitorThread:= TNLDPrinterMonitor.Create;
      FPrinterMonitorThread.Start(FPrinterChangeNotifier);
    end;

  finally
    ClosePrinter(AHandle);
    FreeAndNil(VPrinter);
  end;
end;

procedure TbaseNLDPrinterInfo.Refresh;
begin
  ReadPrinterInfo;
end;

procedure TbaseNLDPrinterInfo.SetOnJobChange(const Value: TNotifyEvent);
begin
  FOnJobChange := Value;
  FPrinterMonitorThread.OnJobChange:= FOnJobChange; 
end;

{ TNLDPrintersInfo }

constructor TNLDPrintersInfo.Create;
begin
  inherited Create;

  FPrinter:= TPrinter.Create;
end;

destructor TNLDPrintersInfo.Destroy;
begin
  FreeAndNil(FPrinter);
  inherited;
end;

function TNLDPrintersInfo.GetCount: Integer;
begin
  try
    FPrinter.Refresh;
    Result:= FPrinter.Printers.Count;
  except
    on E:Exception do
    begin
      raise Exception.Create('Error while reading number of printers:'#13#13+E.Message);
    end;
  end;
end;

function TNLDPrintersInfo.GetPrinterInfo(AIndex: Integer): TbaseNLDPrinterInfo;
begin
  try
    Result:= TbaseNLDPrinterInfo.Create(AIndex);
  except
    on E:Exception do
    begin
      raise Exception.Create('Cannot get printer information for printer with index '+IntToStr(AIndex)+#13#13+E.Message);
    end;
  end;
end;

{ TNLDJobInfo }

constructor TNLDJobInfo.Create(AJobInfo: PJobInfo2);
begin
  inherited Create;
  FJobInfo:= AJobInfo;
end;

{ TNLDPrinterMonitor }

constructor TNLDPrinterMonitor.Create;
begin
  inherited Create(true);
  Priority:= tpIdle;
  FreeOnTerminate:= true;
end;

procedure TNLDPrinterMonitor.Execute;
begin
  while not Terminated do
  begin
    try
      if not Suspended then
        if FNotifier.Signaled then
        begin
          if Assigned(FOnJobChange) then
            FOnJobChange(nil);
        end;
    except
    end;
  end;
end;

procedure TNLDPrinterMonitor.Start(ANotifier: TPrinterChangeNotify);
begin
  FNotifier:= ANotifier;
  Resume;
end;

procedure TNLDPrinterMonitor.Stop;
begin
  Suspend;
  Terminate;
end;

end.
