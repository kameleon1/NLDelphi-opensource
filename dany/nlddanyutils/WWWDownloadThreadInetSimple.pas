// Simple WinInet

unit WWWDownloadThreadInetSimple;

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

uses WinInet, SimpleRegistry, SysUtils, Windows, Dialogs, ProxySetup;

var
  UserAgent: string;
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
const BufferSize = 1024 * 10;
var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: LongWord;
  f: File;
  s1, s2 : string;
  res : boolean;
begin
 Result   :=False;

 if NOT UseProxy
 then hSession := InternetOpen( PChar(UserAgent),
                                INTERNET_OPEN_TYPE_PRECONFIG,
                                nil, nil, 0)
 else
 begin
   s1 := ProxyServer + ':' + ProxyPort;
   s2 := '<local>';
   hSession := InternetOpen( PChar(UserAgent),
                             INTERNET_OPEN_TYPE_PROXY,
                             PChar(s1), PChar(s2), 0);
 end;

 if (hSession <> nil) then
 begin
   if UseProxy and UseProxyAuthentication then
   begin
     InternetSetOption( hSession, INTERNET_OPTION_PROXY_USERNAME,
                        PChar(ProxyUserName), length(ProxyUserName) + 1);
     InternetSetOption( hSession, INTERNET_OPTION_PROXY_PASSWORD,
                        PChar(ProxyPassword), length(ProxyPassword) + 1);
   end;
 end else
 begin
   error := 'Error on InternetOpen';
   exit;
 end;

 hURL := InternetOpenURL( hSession, PChar(fileURL), nil, 0,
                          INTERNET_FLAG_KEEP_CONNECTION +
                          INTERNET_FLAG_NO_CACHE_WRITE +
                          INTERNET_FLAG_RELOAD,
                          0);

 if (hURL <> nil) then
 begin
   if UseAuthentication then
   begin
     res := InternetSetOption( hURL, INTERNET_OPTION_USERNAME,
                        PChar(UserName), length(UserName) + 1);

     if not res then
     begin
       InternetCloseHandle(hURL);
       InternetCloseHandle(hSession);
       error := 'Error on InternetSetOption Username';
       exit;
     end;

     res := InternetSetOption( hURL, INTERNET_OPTION_PASSWORD,
                        PChar(Password), length(Password) + 1);
                        
     if not res then
     begin
       InternetCloseHandle(hURL);
       InternetCloseHandle(hSession);
       error := 'Error on InternetSetOption Password';
       exit;
     end;

   end;
 end else
 begin
   InternetCloseHandle(hSession);
   error := 'Error on InternetOpenURL';
   exit;
 end;

 AssignFile(f, FileName);
 Rewrite(f,1);
 repeat
   InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
   BlockWrite(f, Buffer, BufferLen)
 until (BufferLen = 0) or terminated;
 CloseFile(f);
 Result:=True;

 InternetCloseHandle(hURL);
 InternetCloseHandle(hSession);

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

function GetDefaultUserAgent: string;
var
  reg: TSimpleRegistry;
begin
  Reg := TSimpleRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Result := Reg.ReadString( '\Software\Microsoft\Windows\CurrentVersion\Internet Settings\',
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
