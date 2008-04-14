program DeX;

uses
  XPMan,
  Forms,
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

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
