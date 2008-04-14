unit GetDataU;

interface

uses
  Classes, SysUtils;

type
  TGetData = class(TThread)
  private
    FXMLText: string;
    FURL: string;
    FError: string;
    FAfterGet: TNotifyEvent;
    FUserAgent: string;
    procedure DoAfterGet;
  protected
    procedure Execute; override;
  public
    constructor Create;
    property XMLText: string read FXMLText;
    property URL: string read FURL write FURL;
    property Error: string read FError;
    property AfterGet: TNotifyEvent read FAfterGet write FAfterGet;
    property UserAgent: string read FUserAgent write FUserAgent;
  end;

implementation

uses IdHTTP;

{ GetData }

constructor TGetData.Create;
begin
  inherited Create(True);
  FreeOnTerminate := True;
end;

procedure TGetData.Execute;
begin
  FError := '';

  with TIdHTTP.Create(nil) do
  try
    Request.UserAgent := FUserAgent;
    Request.Referer := 'http://www.nldelphi.com/dex';

    try
      FXMLText := Get(FURL);
    except
      on e: Exception do
        FError := e.Message;
    end;
  finally
    Free;
  end;

  Synchronize(DoAfterGet);
end;

procedure TGetData.DoAfterGet;
begin
  if Assigned(FAfterGet) then
    FAfterGet(Self);
end;

end.
