{
1.1
- Aantal posts > 999 pastte niet in trayicon
- XML file werd niet opgeslagen bij afsluiten Windows
- Extra debugmessages toegevoegd

1.2
- AV of abstract error bij klikken op notifywindow opgelost
- DeX kreeg bij sommige Windowsversies onterecht focus als popup verscheen
- Op het forum wordt nu het juiste bericht geselecteerd bij openen vanuit DeX
- Extra debugmessages in verband met Dr Watson op Windows NT

1.3
- Trayicon heeft nu een popupmenu
- Instellingenscherm toegevoegd met popupkleur en tijd
- Mogelijkheid toegevoegd om eigen berichten te negeren

1.4
- Berichten van mijzelf worden ook weer doorgegeven

1.5
- Mogelijkheid om berichten automatisch op te slaan
- Mogelijkheid om berichten handmatig op te slaan
- Notify window nu zonder WS_EX_NOACTIVATE, mogelijke oplossing voor Dr Watson op NT
- Popup verdwijnt nu goed als buiten popup wordt geklikt
- & in threadtitle wordt nu juist weergegeven
- Met rechtermuisklik wordt notify window gesloten zonder thread te openen
- Bij wijzigingen in de lijst blijft de focus nu op het juiste item staan
- Mogelijkheid om bericht te verwijder bij openen vanuit notifywindow
- Tekst op popup wordt pas een link als muis er overheen gaat
- Kleur van tekst en link kunnen worden aangepast

1.6
- User interface uitgebreid
- Mogelijkheid om automatisch op te starten
- Mogelijkheid om WAV af te spelen bij nieuw bericht

1.6.1
- Sorteerbug uit 1.6 opgelost

1.7
- Gebruikt nu virtual data. Verwijderen gaat *veel* sneller

}
program DeX;

uses
  Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  GetDataU in 'GetDataU.pas',
  FetchDateTimeFormU in 'FetchDateTimeFormU.pas' {FetchDateTimeForm},
  AboutFormU in 'AboutFormU.pas' {AboutForm},
  DeXSettingsU in 'DeXSettingsU.pas',
  SettingsFormU in 'SettingsFormU.pas' {SettingsForm},
  LoginFormU in 'LoginFormU.pas' {LoginForm},
  NLDXMLData in 'Componenten\NLDXMLData.pas',
  NLDXMLIntf in 'Componenten\NLDXMLIntf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
