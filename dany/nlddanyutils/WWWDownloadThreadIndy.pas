// Dany Rosseel

unit WWWDownloadThreadIndy;

{ History of this unit:
  01-09-2003: * Initial version (Indy version)
  10-10-2003: * Adaptions made to meet coding conventions
  26-10-2003: * Simplified the usage of the unit:
                - Use "DownloadFile(Url, LocalFile: string; TerminateProc: TNotifyEvent);"
                  in stead of using the downloadthread directly.
}


interface

uses
  Classes, IdHTTP, IdHTTPHeaderInfo;

procedure DownloadFile(Url, LocalFile: string; TerminateProc: TNotifyEvent;
  UserName: string = ''; Password: string = '');

procedure SetProxyParams(UseProxy: Boolean;
  ProxyServer, ProxyPort: string;
  UseProxyAuthorisation: Boolean;
  ProxyUserName, ProxyPassword: string);

type
  TDownloadThread = class(TThread)
  private
    { Private declarations }
    procedure SetHTTPRequest(Request: TIdHttpRequest);
    procedure SetHTTPProxyParams(Params: TIdProxyConnectionInfo);
  protected
    procedure Execute; override;
  public
    FileOnNet, LocalFileName: string; // Input

    UseAuthentication: Boolean; // for web page access if needed
    Username, Password: string;

    UseProxy: Boolean; // Proxy settings
    ProxyServer: string;
    ProxyPort: string;
    UseProxyAuthentication: Boolean;
    ProxyuserName: string;
    ProxyPassword: string;

    Success: Boolean; // result after termination
    Error: {short}string; // result after termination

    constructor Create(Suspended: Boolean);
  end;

implementation

uses SimpleRegistry, SysUtils, Windows, IdException, Dialogs, ProxySetup;

var
  UserAgent: string;
  DownloadUseProxy: Boolean;
  DownloadProxyServer: string;
  DownloadProxyPort: string;
  DownloadUseProxyAuthorisation: Boolean;
  DownloadProxyUserName: string;
  DownloadProxyPassword: string;
  Initialized: Boolean;

constructor TDownloadThread.Create(Suspended: Boolean);
begin
  FileOnNet := '';
  LocalFileName := '';

  UseAuthentication := False;
  Username := '';
  Password := '';

  UseProxy := False;
  ProxyServer := '';
  ProxyPort := '8080';

  UseProxyAuthentication := False;
  ProxyuserName := '';
  ProxyPassword := '';

  Success := False;
  Error := '';

  inherited Create(Suspended);
end;

procedure TDownloadThread.SetHTTPRequest(Request: TIDHttpRequest);
begin

  Request.BasicAuthentication := UseAuthentication;
  Request.Username := UserName;
  Request.Password := Password;

  Request.UserAgent := UserAgent;

  Request.Accept :=
    'image/gif, image/x-bitmap, image/jpeg, image/pjpeg, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*';
  Request.AcceptEncoding := 'gzip, deflate';
  Request.Connection := 'Keep-Alive';
  Request.Host := 'localhost';

  Request.ProxyConnection := 'Keep-Alive';
  Request.CacheControl := 'no-cache';
end;

procedure TDownloadThread.SetHTTPProxyParams(Params: TIdProxyConnectionInfo);
var
  P: Word;
  Err: Integer;
begin
  if UseProxy then
  begin
    Params.ProxyServer := ProxyServer;
    Val(Proxyport, P, Err);
    if Err = 0 then
      Params.ProxyPort := P
    else
      Params.ProxyPort := 8080;

    Params.BasicAuthentication := UseproxyAuthentication;
    Params.ProxyUsername := ProxyuserName;
    Params.ProxyPassword := ProxyPassword;
  end;
end;

procedure TDownloadThread.Execute;
var
  Http: TIdHttp;
  F: TFileStream;
begin
  Success := True;
  Error := '';

  Http := TIdHttp.Create(nil);
  try
    Http.ProtocolVersion := pv1_0;
    Http.HandleRedirects := True;
    //http.HTTPOptions      := [hoInProcessAuth];

    SetHTTPRequest(Http.Request);
    SetHTTPProxyParams(Http.ProxyParams);

    F := TFileStream.Create(LocalFilename, fmCreate);
    try
      try
        Http.Get(FileOnNet, F);
      except
        on E: EIdException do
          Error := E.Message;
      end;
    finally
      F.free;
    end;
  finally
    Http.Free;
  end;

  if Error > '' then
    Success := False;
end;

function GetDefaultUserAgent: string;
var
  Reg: TSimpleRegistry;
begin
  Reg := TSimpleRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Result :=
      Reg.ReadString('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\',
      'User Agent', 'Test');
  finally
    Reg.Free;
  end;
end;

procedure Initialize;
begin
  if not Initialized then
    GetProxyValues(DownloadUseProxy, DownloadProxyServer, DownloadProxyPort,
      DownloadUseproxyAuthorisation, DownloadProxyUserName,
      DownloadProxyPassword);
end;

procedure DownloadFile(Url, LocalFile: string; TerminateProc: TNotifyEvent;
  UserName: string = ''; Password: string = '');
var
  Th: TDownloadThread;
begin
  { get the default proxy parameters if necessary }
  Initialize;

  { create the thread }
  Th := TDownloadThread.Create(True); { create the thread in suspend mode }
  Th.FreeOnTerminate := True;

  { set thread main variables }
  Th.FileOnNet := Url;
  Th.LocalFileName := LocalFile;
  Th.Onterminate := TerminateProc;

  { set the authentication parameters }
  if (Username > '') or (Password > '') then
  begin
    Th.UseAuthentication := True;
    Th.UserName := UserName;
    Th.Password := Password;
  end;

  { set the thread proxy parameters }
  Th.Useproxy := DownloadUseProxy;
  Th.ProxyServer := DownloadProxyServer;
  Th.ProxyPort := DownloadProxyPort;
  Th.UseProxyAuthentication := DownloadUseProxyAuthorisation;
  Th.ProxyUserName := DownloadProxyUserName;
  Th.ProxyPassword := DownloadProxyPassword;

  Th.resume; {start the thread}
end;

procedure SetProxyParams(UseProxy: Boolean;
  ProxyServer, ProxyPort: string;
  UseProxyAuthorisation: Boolean;
  ProxyUserName, ProxyPassword: string);
begin
  DownloadUseProxy := UseProxy;
  DownloadProxyServer := ProxyServer;
  DownloadProxyPort := ProxyPort;
  DownloadUseProxyAuthorisation := UseProxyAuthorisation;
  DownloadProxyUserName := ProxyUserName;
  DownloadProxyPassword := ProxyPassword;
  Initialized := true; {no automatic getting of the proxy params any more }
end;

begin
  UserAgent := GetDefaultUserAgent;
  Initialized := false;
end.
