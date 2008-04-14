{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntUtil;

interface

uses
  Windows, SysUtils, Forms, ShlObj;

  Function GetOperatingSystem: String;
  Function GetSystemDir : WideString;
  Function FileVersion: String;
  Function GetAppDataDir : WideString;
  Function GetJID(JID: WideString): WideString;
  Function GetUserNameFromJID(JID : WideString) : WideString;
  Function GetResource(JID: WideString):WideString;

  Function SslAviable : Boolean;

implementation
{other usefull functions and procudures}

Function GetOperatingSystem: String;
var
  osVerInfo: TOSVersionInfo;                
  majorVer, minorVer: Integer;
begin
  Result := 'Unknown';
  { set operating system type flag }
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(osVerInfo) then
  begin
    majorVer := osVerInfo.dwMajorVersion;
    minorVer := osVerInfo.dwMinorVersion;
    case osVerInfo.dwPlatformId of
      VER_PLATFORM_WIN32_NT: { Windows NT/2000 }
        begin
          if majorVer <= 4 then
            Result := 'Windows NT'
          else if (majorVer = 5) and (minorVer = 0) then
            Result := 'Windows 2000'
          else if (majorVer = 5) and (minorVer = 1) then
            Result := 'Windows XP'
          else
            Result := 'Unknown';
        end;
      VER_PLATFORM_WIN32_WINDOWS:  { Windows 9x/ME }
        begin
          if (majorVer = 4) and (minorVer = 0) then
            Result := 'Windows 95'
          else if (majorVer = 4) and (minorVer = 10) then
          begin
            if osVerInfo.szCSDVersion[1] = 'A' then
              Result := 'Windws 98SE'
            else
              Result := 'Windows 98';
          end
          else if (majorVer = 4) and (minorVer = 90) then
            Result := 'Windows ME'
          else
            Result := 'Unknown';
        end;
      else
        Result := 'Unknown';
    end;
  end
  else
    Result := 'Unknown';
end;

Function FileVersion : String;
var
  S : String;
  n, Len : Cardinal;
  Buf : PChar;
  Value : PChar;
begin
  Try
    S := Application.ExeName;
    n := GetFileVersionInfoSize(PChar (S),n);
    If n > 0 Then
    Begin
      Buf := AllocMem(n);
      GetFileVersionInfo(PChar(S),0,n,Buf);
      If VerQueryValue(Buf,PChar ('StringFileInfo\040904E4\FileVersion'
                                  ),Pointer(Value),Len) Then
        Begin
          If Length(Value) > 0 Then
            Result := Value;
        End;
      FreeMem(Buf,n);
    End else
        Result := 'Unknow';

  Except
    Result := 'Unknow';
  End;
End;

Function GetAppDataDir : WideString;
var
  Path : pchar;
  idList : PItemIDList;
begin
  GetMem(Path, MAX_PATH);
  SHGetSpecialFolderLocation(0, CSIDL_APPDATA, idList);
  SHGetPathFromIDList(idList, Path);

  Result := IncludeTrailingPathDelimiter(WideString(Path));

  if Result = '' then
    Result := ExtractFileDir(Application.ExeName);
    
  FreeMem(Path);
end;

{********************************************************
 Some misc Jabber Util functions en procedures
********************************************************}

Function GetJID(JID: WideString): WideString;
var
 Position : integer;
begin
 Position := pos('/', JID);
 if Position > 0 then
  Result := copy(JID, 0, Position - 1)
 else
  Result := JID;
end;

Function GetUserNameFromJID(JID : WideString) : WideString;
var
 Position : integer;
begin
 Position := pos('@', JID);
 if Position > 0 then
  Result := copy(JID, 0, Position - 1)
 else
  Result := JID;
end;

Function GetResource(JID: WideString):WideString;
var
 Position : integer;
begin
 Position := Pos('/', JID);
 if Position > 0 then
  Result := copy(JID, Position +1,length(JID))
 else
  Result := '';
end;


Function GetSystemDir : WideString;
var
  chrSystemDir : array [0..255] of Char;
begin
  GetSystemDirectory(chrSystemDir, 254);
  result := WideString(chrSystemDir);
end;

Function SslAviable : Boolean;
var
  strSystemDir, strAppDir : WideString;
begin
 strSystemDir := GetSystemDir + '\libeay32.dll';
 strAppDir := ExtractFilePath(Application.EXEName) + 'libeay32.dll';

 result := FileExists(strAppDir) or FileExists(strSystemDir);

 strSystemDir := GetSystemDir + '\ssleay32.dll';
 strAppDir := ExtractFilePath(Application.EXEName) + 'ssleay32.dll';

 result := FileExists(strAppDir) or FileExists(strSystemDir);

end;

end.

