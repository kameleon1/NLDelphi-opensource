unit WWWDownloadThread;

interface

uses
  Classes;

type
  TDownloadThread = class(TThread)
  private
    { Private declarations }
    function GetInetFile(const fileURL, FileName: String): boolean;
  protected
    procedure Execute; override;
  public
    FileOnNet, LocalFileName : string;  // Input
    success : boolean;                  // result after termination
    error   : shortstring;              // result after termination
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

uses WinInet, SysUtils, TypeDefs, StrEncDec, Registry, Windows;

var UserAgent : string;

function TDownloadThread.GetInetFile(const fileURL, FileName: String): boolean;
const BufferSize = 1024;
      proxyfile  = 'Proxy';

var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: LongWord;
  f: File;
  proxyinfo : TProxyInfo;
  pf : file of TProxyInfo;
  s1, s2 : shortstring;

begin
 Result   :=False;

 if fileexists(proxyfile) then
 begin
   assignfile(pf, proxyfile);
   reset(pf);
   read(pf, proxyinfo);
   closefile(pf);

   proxyinfo.proxy_address := str_decode(proxyinfo.proxy_address);
   proxyinfo.proxy_port    := str_decode(proxyinfo.proxy_port);
   proxyinfo.user_name     := str_decode(proxyinfo.user_name);
   proxyinfo.password      := str_decode(proxyinfo.password);
 end else
 begin
   proxyinfo.use_proxy               := false;
   proxyinfo.use_proxy_authorization := false;
 end;

 if NOT proxyinfo.use_proxy
 then hSession := InternetOpen( PChar(UserAgent),
                                INTERNET_OPEN_TYPE_PRECONFIG,
                                nil, nil, 0)
 else
 begin
   s1 := 'http://'+ proxyinfo.proxy_address + ':' + proxyinfo.proxy_port;
   s2 := '<local>';
   hSession := InternetOpen( PChar(UserAgent),
                                INTERNET_OPEN_TYPE_PROXY,
                                PChar(String(s1)), PChar(String(s2)), 0);
 end;
 if (hSession <> nil) then
 begin
   if proxyinfo.use_proxy_authorization then
   begin
     InternetSetOption( hSession, INTERNET_OPTION_PROXY_USERNAME,
                        PChar(String(proxyinfo.user_name)), length(proxyinfo.user_name) + 1);
     InternetSetOption( hSession, INTERNET_OPTION_PROXY_PASSWORD,
                        PChar(String(proxyinfo.password)), length(proxyinfo.password) + 1);
   end;
 end else
 begin
   error := 'Error on InternetOpen';
   exit;
 end;

 hURL := InternetOpenURL( hSession, PChar('http://'+ fileURL), nil, 0,
                          INTERNET_FLAG_KEEP_CONNECTION +
                          INTERNET_FLAG_NO_CACHE_WRITE +
                          INTERNET_FLAG_RELOAD,
                          0);
 if (hURL = nil) then
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
  error := '';
  success := false;
  if terminated then exit;

  success := GetInetFile(FileOnNet, LocalFileName);
  if not success then exit;
  if terminated then
  begin
    success := false;
    exit;
  end;
end;

function GetDefaultUserAgent: string;
var
  reg: TRegistry;
begin
  Result := '';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\', FALSE)
    then Result := Reg.ReadString('User Agent');
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
  if Result = '' then Result := 'Test';
end;

begin
  UserAgent := GetDefaultUserAgent;
end.
