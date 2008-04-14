unit HTTPSClient;

interface

uses
  Classes, Wininet, Windows, SysUtils;

type
  EHTTPSException = class(Exception);
  EHTTPSThreadTerminated = class(EHTTPSException);
  EHTTPSDownloadFailed = class(EHTTPSException);

type
  THTTPSClientThread = class;

  THTTPSClient = class(TObject)
  private
    FThread: THTTPSClientThread;
    FOnError: TNotifyEvent;
    FOnSuccess: TNotifyEvent;
    FHeaders: TStringList;
    FHeaderData: String;
    FStatusCode: Integer;
  protected
    procedure DoErrorEvent;
    procedure DoSuccessEvent;
    procedure ThreadDone;
  public
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnSuccess: TNotifyEvent read FOnSuccess write FOnSuccess;
    property Headers: TStringList read FHeaders;
    property HeaderData: String read FHeaderData;
    property StatusCode: Integer read FStatusCode;

    constructor Create;
    destructor Destroy; override;

    procedure GetHeader(Server, Filename: String);
    procedure Abort;
  end;

  THTTPSClientThread = class(TThread)
  private
    FHTTPSClient: THTTPSClient;
    FServer: String;
    FFilename: String;
    FSuccess: Boolean;
    FHeaderData: String;
    FStatusCode: Integer;
    procedure GetHeader;
    procedure AddHeaders(RequestHandle: HInternet);
    procedure AddHeader(RequestHandle: HInternet; HeaderData: String);
    procedure SendHTTPRequest(RequestHandle: HInternet);
    procedure GetStatusCode(RequestHandle: HInternet);
    procedure GetHeaderData(RequestHandle: HInternet);
    function GetInternetHandle: HInternet;
    function GetConnectHandle(InternetHandle: HInternet): HInternet;
    function GetRequestHandle(ConnectHandle: HInternet): HInternet;
    procedure CheckForTerminate;
  protected
    procedure Execute; override;
  public
    constructor Create(HTTPSClient: THTTPSClient; Server, Filename: String);
    property Success: Boolean read FSuccess;
    property HeaderData: String read FHeaderData;
    property StatusCode: Integer read FStatusCode;
  end;

implementation

{ THTTPSClient }

procedure THTTPSClient.GetHeader(Server, Filename: String);
begin
  if not Assigned(FThread) then
  begin
    FThread := THTTPSClientThread.Create(Self, Server, Filename);
    FThread.FreeOnTerminate := True;
    FThread.Resume;
  end;
end;

destructor THTTPSClient.Destroy;
begin
  if Assigned(FThread) then
  begin
    FThread.Terminate;
    FThread.WaitFor;
  end;

  FHeaders.Free;
  inherited;
end;

procedure THTTPSClient.DoErrorEvent;
begin
  if Assigned(FOnError) then
    FOnError(Self);
end;

procedure THTTPSClient.DoSuccessEvent;
begin
  if Assigned(FOnSuccess) then
    FOnSuccess(Self);
end;

procedure THTTPSClient.ThreadDone;
var
  Success: Boolean;
begin
  Success := FThread.Success;
  FHeaderData := FThread.HeaderData;
  FStatusCode := FThread.StatusCode;

  FThread := nil;

  if Success then
    DoSuccessEvent
  else
    DoErrorEvent;
end;

constructor THTTPSClient.Create;
begin
  FHeaders := TStringList.Create;
  FHeaderData := '';
end;

procedure THTTPSClient.Abort;
begin
  if Assigned(FThread) then
    FThread.Terminate;
end;

{ THTTPSClientThread }

procedure THTTPSClientThread.AddHeader(RequestHandle: HInternet;
  HeaderData: String);
var
  Success: Boolean;
begin
  Success := HttpAddRequestHeaders(RequestHandle, PAnsiChar(HeaderData),
    Length(HeaderData), HTTP_ADDREQ_FLAG_REPLACE  or HTTP_ADDREQ_FLAG_ADD);
  if not Success then
    raise EHTTPSDownloadFailed.Create('HTTP add request headers failed');
end;

procedure THTTPSClientThread.AddHeaders(RequestHandle: HInternet);
begin
  AddHeader(RequestHandle, 'Host: ' + FServer);
  if FHTTPSClient.Headers.Count > 0 then
    AddHeader(RequestHandle, FHTTPSClient.Headers.Text);
  FHTTPSClient.Headers.Clear;
end;

procedure THTTPSClientThread.CheckForTerminate;
begin
  if Terminated then
    raise EHTTPSThreadTerminated.Create('Terminated');
end;

constructor THTTPSClientThread.Create(HTTPSClient: THTTPSClient;
  Server, Filename: String);
begin
  inherited Create(True);
  FHTTPSClient := HTTPSClient;
  FServer := Server;
  FFilename := Filename;
end;

procedure THTTPSClientThread.Execute;
begin
  FHeaderData := '';
  FSuccess := False;
  try
    GetHeader;
    FSuccess := True;
  except

  end;
  Synchronize(FHTTPSClient.ThreadDone);
end;

function THTTPSClientThread.GetConnectHandle(
  InternetHandle: HInternet): HInternet;
begin
  CheckForTerminate;
  Result := InternetConnect(InternetHandle, PAnsiChar(FServer),
    INTERNET_DEFAULT_HTTPS_PORT, nil, nil, INTERNET_SERVICE_HTTP, 0, 0);
  if Result = nil then
    raise EHTTPSDownloadFailed.Create('Internet connect failed');
end;

procedure THTTPSClientThread.GetHeader;
var
  InternetHandle: HInternet;
  ConnectHandle: HInternet;
  RequestHandle: HInternet;
begin
  InternetHandle := GetInternetHandle; //InternetOpen
  try
    ConnectHandle := GetConnectHandle(InternetHandle); //InternetConnect
    try
      RequestHandle := GetRequestHandle(ConnectHandle); //HttpOpenRequest
      try
        AddHeaders(RequestHandle); //HttpAddRequestHeaders
        SendHTTPRequest(RequestHandle); //HttpSendRequest
        GetStatusCode(RequestHandle); //HttpQueryInfo
        GetHeaderData(RequestHandle); //HttpQueryInfo
      finally
        InternetCloseHandle(RequestHandle);
      end;
    finally
      InternetCloseHandle(ConnectHandle);
    end;
  finally
    InternetCloseHandle(InternetHandle);
  end;
end;

procedure THTTPSClientThread.GetHeaderData(RequestHandle: HInternet);
var
  Buffer: String;
  BufferSize: DWORD;
  dwParam: DWORD;
  Success: Boolean;
begin
  CheckForTerminate;
  dwParam := 0;
  BufferSize := 32768;
  SetLength(Buffer, BufferSize);
  Success := HttpQueryInfo(RequestHandle, HTTP_QUERY_RAW_HEADERS_CRLF,
    @Buffer[1], BufferSize, dwParam);
  if not Success then
    raise EHTTPSDownloadFailed.Create('HTTP query info failed');
  FHeaderData := Buffer;
end;

function THTTPSClientThread.GetInternetHandle: HInternet;
begin
  CheckForTerminate;
  Result := InternetOpen('MSMSGS', INTERNET_OPEN_TYPE_PRECONFIG,
    nil, nil, INTERNET_FLAG_NO_COOKIES + INTERNET_FLAG_NO_UI +
    INTERNET_FLAG_PRAGMA_NOCACHE + INTERNET_FLAG_SECURE);
  if Result = nil then
    raise EHTTPSDownloadFailed.Create('Internet open failed');
end;

function THTTPSClientThread.GetRequestHandle(
  ConnectHandle: HInternet): HInternet;
begin
  CheckForTerminate;
  Result := HttpOpenRequest(ConnectHandle, 'GET', PAnsiChar(FFilename),
    'HTTP/1.1', nil, nil, INTERNET_FLAG_RELOAD + INTERNET_FLAG_SECURE +
    INTERNET_FLAG_NO_AUTO_REDIRECT + INTERNET_FLAG_NO_COOKIES, 0);
  if Result = nil then
    raise EHTTPSDownloadFailed.Create('HTTP open request failed');
end;

procedure THTTPSClientThread.GetStatusCode(RequestHandle: HInternet);
var
  Buffer: String;
  BufferSize: DWORD;
  dwParam: DWORD;
  Success: Boolean;
begin
  CheckForTerminate;
  dwParam := 0;
  BufferSize := 32768;
  SetLength(Buffer, BufferSize);
  Success := HttpQueryInfo(RequestHandle, HTTP_QUERY_STATUS_CODE,
    @Buffer[1], BufferSize, dwParam);
  if not Success then
    raise EHTTPSDownloadFailed.Create('HTTP query info failed');
  FStatusCode := StrToInt(Buffer);
end;

procedure THTTPSClientThread.SendHTTPRequest(RequestHandle: HInternet);
var
  Success: Boolean;
begin
  CheckForTerminate;
  Success := HttpSendRequest(RequestHandle, nil, 0, nil, 0);
  if not Success then
    raise EHTTPSDownloadFailed.Create('HTTP send request failed');
end;

end.
