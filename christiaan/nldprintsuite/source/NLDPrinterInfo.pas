unit NLDPrinterInfo;

interface

uses
  SysUtils, Classes, uObjects;

type
  TNLDPrinterInfo = class(TComponent)
  private
    function GetInfo(AIndex: Integer): TbaseNLDPrinterInfo;
    function GetCount: Integer;
    function GetDefaultPrinterInfo: TbaseNLDPrinterInfo;
    { Private declarations }
  protected
    FPrinterInfo: TNLDPrintersInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Info[AIndex: Integer]: TbaseNLDPrinterInfo read GetInfo;
    property DefaultPrinterInfo: TbaseNLDPrinterInfo read GetDefaultPrinterInfo;
    property Count: Integer read GetCount;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDPrinterInfo]);
end;

{ TNLDPrinterInfo }

constructor TNLDPrinterInfo.Create(AOwner: TComponent);
begin
  inherited;
  FPrinterInfo:= TNLDPrintersInfo.Create;
end;

destructor TNLDPrinterInfo.Destroy;
begin
  FreeAndNil(FPrinterInfo);
  inherited;
end;

function TNLDPrinterInfo.GetCount: Integer;
begin
  Result:= FPrinterInfo.Count;
end;

function TNLDPrinterInfo.GetDefaultPrinterInfo: TbaseNLDPrinterInfo;
begin
  Result:= FPrinterInfo.Info[-1];
end;

function TNLDPrinterInfo.GetInfo(AIndex: Integer): TbaseNLDPrinterInfo;
begin
  Result:= FPrinterInfo.Info[AIndex];
end;

end.
 