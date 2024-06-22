unit StopIce;

{ Anti debug unit. Detect SoftIce and shutdown Windows.

  Freware with source. 

  Copyright (c) 1998 Soft House Labs, Andre N Belokon
  Web     http://softlab.od.ua/
  Email   support@softlab.od.ua

  THIS SOFTWARE AND THE ACCOMPANYING FILES ARE DISTRIBUTED 
  "AS IS" AND WITHOUT WARRANTIES AS TO PERFORMANCE OF MERCHANTABILITY OR 
  ANY OTHER WARRANTIES WHETHER EXPRESSED OR IMPLIED.
  NO WARRANTY OF FITNESS FOR A PARTICULAR PURPOSE IS OFFERED.
  THE USER MUST ASSUME THE ENTIRE RISK OF USING THE ACCOMPANYING CODE.
}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

Function IsSoftIce95Loaded: boolean;
Function IsSoftIceNTLoaded: boolean;

implementation

uses Windows;

Function IsSoftIce95Loaded: boolean;
Var hFile: Thandle;
Begin
  result := false;
  hFile := CreateFileA('\\.\SICE', GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL, 0);
  if( hFile <> INVALID_HANDLE_VALUE ) then begin
    CloseHandle(hFile);
    result := TRUE;
  end;
End;

Function IsSoftIceNTLoaded: boolean;
Var hFile: Thandle;
Begin
  result := false;
  hFile := CreateFileA('\\.\NTICE', GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL, 0);
  if( hFile <> INVALID_HANDLE_VALUE ) then begin
    CloseHandle(hFile);
    result := TRUE;
  end;
End;

function WinExit(flags: integer): boolean;
  function SetPrivilege(privilegeName: string; enable: boolean): boolean;
  var tpPrev,
      tp         : TTokenPrivileges;
      token      : THandle;
      dwRetLen   : DWord;
  begin
    result := False;
    OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, token);
    tp.PrivilegeCount := 1;
    if LookupPrivilegeValue(nil, pchar(privilegeName), tp.Privileges[0].LUID) then
    begin
      if enable then
        tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
      else
        tp.Privileges[0].Attributes := 0;
      dwRetLen := 0;
      result := AdjustTokenPrivileges(token, False, tp, SizeOf(tpPrev), tpPrev, dwRetLen);
    end;
    CloseHandle(token);
  end;
begin
  if SetPrivilege('SeShutdownPrivilege', true) then begin
    ExitWindowsEx(flags, 0);
    Result := SetPrivilege('SeShutdownPrivilege', False)
  end else Result := false;
end;

initialization
  if IsSoftIce95Loaded or IsSoftIceNTLoaded then begin
    WinExit(EWX_SHUTDOWN or EWX_FORCE);
    Halt;
  end;
end.
