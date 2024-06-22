// URLMon WinInet

unit WWWDownloadThreadURLMon;

interface

uses
  Classes;

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
    function GetInetFile(const fileURL, FileName: String): boolean;
  protected
    procedure Execute; override;
  public
    FileOnNet, LocalFileName : string;  // Input

    UseAuthentication  : boolean;       // for web page access if needed
    Username, Password : string;

    UseProxy      : boolean;            // Proxy settings
    ProxyServer   : string;
    ProxyPort     : string;
    UseProxyAuthentication : boolean;
    ProxyuserName : string;
    ProxyPassword : string;

    success : boolean;                  // result after termination
    error   : {short}string;              // result after termination

    constructor create(suspended: boolean);
  end;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TDownloadThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ DownloadThread }

uses SimpleRegistry, SysUtils, Windows, Dialogs, ProxySetup, URLMon;

var
  DownloadUseProxy: Boolean;
  DownloadProxyServer: string;
  DownloadProxyPort: string;
  DownloadUseProxyAuthorisation: Boolean;
  DownloadProxyUserName: string;
  DownloadProxyPassword: string;
  Initialized: Boolean;

constructor TDownloadThread.Create(suspended: boolean);
begin
  FileOnNet     := '';
  LocalFileName := '';

  UseAuthentication := false;
  Username      := '';
  Password      := '';

  UseProxy      := false;
  ProxyServer   := '';
  ProxyPort     := '8080';

  UseProxyAuthentication := false;
  ProxyuserName := '';
  ProxyPassword := '';

  success       := false;
  error         := '';

  inherited Create(suspended);
end;

function TDownloadThread.GetInetFile(const fileURL, FileName: String): boolean;
begin
  Result := (UrlDownloadToFile(nil, PChar(fileURL), PChar(FileName), 0, nil) = S_OK);
end;

procedure TDownloadThread.Execute;
begin
  { Place thread code here }
  error   := '';
  success := false;
  if terminated then exit;

  success := GetInetFile(FileOnNet, LocalFileName);
  if not success then exit;

  //Terminate;
  //exit;

  if terminated then
  begin
    success := false;
    exit;
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
  Initialized := false;
end.
