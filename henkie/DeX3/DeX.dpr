program DeX;

uses
  Windows, XPMan, Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  GetDataU in 'GetDataU.pas',
  FetchDateTimeFormU in 'FetchDateTimeFormU.pas' {FetchDateTimeForm},
  AboutFormU in 'AboutFormU.pas' {AboutForm},
  DeXSettingsU in 'DeXSettingsU.pas',
  SettingsFormU in 'SettingsFormU.pas' {SettingsForm},
  LoginFormU in 'LoginFormU.pas' {LoginForm},
  NLDXMLData in 'Componenten\NLDXMLData.pas',
  NLDXMLIntf in 'Componenten\NLDXMLIntf.pas',
  FavoritesUnit in 'FavoritesUnit.pas',
  SettingsUnit in 'SettingsUnit.pas';

{$R *.res}

const
  CFileMapping  = 'DeX.3.Instance';
var
  MappingHandle: THandle;
  pMappingHandle: ^THandle;
begin
  MappingHandle  := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, SizeOf(THandle), CFileMapping);
  if GetLastError() = ERROR_ALREADY_EXISTS then
  begin
    pMappingHandle  := MapViewOfFile(MappingHandle, FILE_MAP_READ, 0, 0, 0);
    if pMappingHandle^ <> 0 then
      PostMessage(pMappingHandle^, WM_NEWDeX3INSTANCE, 0, 0);
    UnmapViewOfFile(pMappingHandle);
    CloseHandle(MappingHandle);
    exit;
  end else
  pMappingHandle  := MapViewOfFile(MappingHandle, FILE_MAP_WRITE, 0, 0, 0);
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  pMappingHandle^ := MainForm.Handle;
  Application.Run;
  UnmapViewOfFile(pMappingHandle);
  CloseHandle(MappingHandle);
end.

