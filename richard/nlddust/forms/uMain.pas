{**** To Do ******************************************************************}

{ - Deling in Avarage veranderen in een / ipv een DIV.}
{ - notitie op site maken, indien iemand vergeten in credit's lijst te zetten, ff mailen.}
{ideen}
{ - set forground wanneer een 2e sessie opgestart wordt.}
{ - Tab volgorde op elk form checken}
{ - eventueel Ip adress achter adapter tonen.}

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, JvComponent, JvTrayIcon, ImgList, JPEG,
  uMibIfRow, shellapi, Menus, JvEdit, ComCtrls;

const
  {Common Consts}
  cAPPLICATIETITELNLD = ' NLD Down & Up Stream Traffic ';
  cAPPLICATIETITEL = ' Down & Up Stream Traffic ';
  cAPPLICATIEVERSIE = 'v1.02';
  cDATELASTCHANGED = '07-10-02';
  cRUNYEAR: Integer = 2003;
  cRUNMONTH: Integer = 10;
  cRUNDAY: Integer = 07;

  {Ini File Consts}
  cINIFILENAME = '\NldDust.ini';
  cCOMMONSECTION = 'COMMON';
  cLAYOUTSECTION = 'LAYOUT';
  cCOLORSSECTION = 'COLORS';
  cPROGRAMSECTION = 'PROGRAM';
  cALARMSSECTION = 'ALARMS';

  {Seconds Converting Consts}
  cYEARS = 'year(s)';
  cDAYS = 'day(s)';
  cHOURSPERDAY = 24;
  cMINSPERDAY = cHOURSPERDAY * 60;
  cSECSPERDAY = cMINSPERDAY * 60;
  cSECSPERMIN = 60;
  cSECSPERHOUR = cSECSPERMIN * 60;

type
  TfrmMain = class(TForm)
    GbAdapter: TGroupBox;
    GbUnits: TGroupBox;
    GbDecimal: TGroupBox;
    GbStandard: TGroupBox;
    GbReceived: TGroupBox;
    GbSent: TGroupBox;

    CmbAdapterLijst: TComboBox;

    RbBits: TRadioButton;
    RbBytes: TRadioButton;
    RbStandardBinary: TRadioButton;
    RbStandartDecimal: TRadioButton;
    Rb1Decimaal: TRadioButton;
    Rb2Decimaal: TRadioButton;
    Rb3Decimaal: TRadioButton;
    Rb4Decimaal: TRadioButton;

    EdtSessionCurrentReceived: TJvEdit;
    EdtSessionAverageReceived: TJvEdit;
    EdtSessionMaxReceived: TJvEdit;
    EdtSessionTotalReceived: TJvEdit;
    EdtWindowsTotalReceived: TJvEdit;
    EdtSessionCurrentSent: TJvEdit;
    EdtSessionAverageSent: TJvEdit;
    EdtSessionMaxSent: TJvEdit;
    EdtSessionTotalSent: TJvEdit;
    EdtWindowsTotalSent: TJvEdit;

    LblSessionCurrentReceived: TLabel;
    LblSessionAverageReceived: TLabel;
    LblSessionMaxReceived: TLabel;
    LblSessionTotalReceived: TLabel;
    LblWindowsTotalReceived: TLabel;
    LblWindowsTotalSent: TLabel;
    LblSessionTotalSent: TLabel;
    LblSessionMaxSent: TLabel;
    LblSessionAverageSent: TLabel;
    LblSessionCurrentSent: TLabel;
    MnufrmMain: TMainMenu;

    FFile1: TMenuItem;
    Minimize1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Settings1: TMenuItem;
    Layout1: TMenuItem;
    Colors1: TMenuItem;
    Program1: TMenuItem;
    Alarms1: TMenuItem;
    Runtime1: TMenuItem;
    ResetCounters1: TMenuItem;
    StopDust1: TMenuItem;
    StartTimer1: TMenuItem;
    ShowAlarm11: TMenuItem;
    ShowAlarm21: TMenuItem;
    Help1: TMenuItem;
    History1: TMenuItem;
    About1: TMenuItem;

    JvTray: TJvTrayIcon;

    TmrSequence: TTimer;
    TmrAlarm1: TTimer;
    TmrAlarm2: TTimer;

    BvDevider: TBevel;
    BvMainMenu: TBevel;

    LblDummy: TLabel;
    CbDummy: TCheckBox;
    StatusbarMain: TStatusBar;

    procedure FormCreate(Sender: TObject);
    procedure TmrSequenceTimer(Sender: TObject);
    procedure JvTrayClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnMinimize(Sender: TObject);
    procedure SetLayOutApplication;
    procedure SetColorsApplication;
    procedure SetProgramApplication;
    procedure Exit1Click(Sender: TObject);
    procedure Minimize1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Layout1Click(Sender: TObject);
    procedure Colors1Click(Sender: TObject);
    procedure Program1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ResetCounters1Click(Sender: TObject);
    procedure StopDust1Click(Sender: TObject);
    procedure StartTimer1Click(Sender: TObject);
    procedure History1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TmrAlarm1Timer(Sender: TObject);
    procedure TmrAlarm2Timer(Sender: TObject);
    procedure ShowAlarm11Click(Sender: TObject);
    procedure ShowAlarm21Click(Sender: TObject);
    procedure Alarms1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  {var om 1 malig bij het opstarten een initialisatie te doen.}
  vInitializeDone: Boolean;
  {var om session tijdsduur bij te houden.}
  vSessionActive: Longword;
  {var om huidige applicatie path bij te houden.}
  vCurrentPath: string;
  {var om bij te houden of de SetColor procedure uitgevoerd MAG worden, ivm Color setten als dust stil staat.}
  vRunning: Boolean;
  {var om bij te houden of er momenteel een alarm geraised is, zoja dan GEEN alarm raisen.}
  vAlarmRaised: Boolean;
  {var om bij te houden of er een FORM open staat, zoja dan GEEN alarm raisen.}
  vFormOpen: Boolean;
  {var om bij te houden of ALARM1 of ALARM2 nog een keer geraised mag worden.}
  vDontShowAlarm1Again: Boolean;
  vDontShowAlarm2Again: Boolean;
  {var om bij te houden of Alarm Timer 1 klaar is.}
  vAlarmTimerDone1: Boolean;
  {var om bij te houden of Alarm Timer 2 klaar is.}
  vAlarmTimerDone2: Boolean;
  {var tbv indentificatie van welk alarm er geraised moet worden.}
  vAlarmID: Integer;
  {string waar referenced alarm in wordt gezet, tbv alarm dialog wat geraised wordt.}
  vAlarmString: string;
  {Dynamische Array om de Adapternamen in op te slaan.}
  vAdapterArray: array of string;

implementation

uses uCommon, uDataArray, uLayout, uReadIniFile, uWriteIniFile, uColors, uProgram, uAbout, uHistory, uAlarms;

{$R *.dfm}

{=====================================================================================================}
{= FormCreate Procedure, initialisatie's etc. ========================================================}
{=====================================================================================================}
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  {Lees eerst ALLE ini instellingen uit.}
  ReadIniFileSectionSetVar('All');

  {Controleer of applicatie direct in Tray moet draaien.}
  if vMinimizeOnRun then
    begin
      Application.ShowMainForm := False;
      frmMain.Hide;
      JvTray.DoCheckCrash;
      JvTray.Active := True;
    end
  else
    begin
      JvTray.DoCheckCrash;
      Application.ShowMainForm := True;
    end;

  {Initialisatie van de vVariablen, om een Hint / Warning te voorkomen !}
  vInitializeDone := False;
  vSessionActive := 0;
  vRunning := True;
  vAlarmRaised := False;
  vFormOpen := False;
  vDontShowAlarm1Again := False;
  vDontShowAlarm2Again := False;
  vAlarmTimerDone1 := True;
  vAlarmTimerDone2 := True;

  {Set diversen Captions, Hints, Title's.}
  JvTray.Hint := cAPPLICATIETITELNLD + cAPPLICATIEVERSIE;
  Application.Title := cAPPLICATIETITELNLD + cAPPLICATIEVERSIE;
  frmMain.Caption := cAPPLICATIETITELNLD + cAPPLICATIEVERSIE;

  {Pas de Default Hint tijden van de applicatie aan, toon hint na 250 ms. laat verdwijnen na 5seconen.}
  Application.HintPause := 250;
  Application.HintHidePause := 5000;

  {Koppel Onminimize (bordericon) click aan een procedure.}
  Application.OnMinimize := OnMinimize;

  {Haal het path op waar de applicatie zich in bevindt.}
  vCurrentPath := ExtractFileDir(Application.ExeName);

  {Haal Data Op !}
  uCommon.GetData;

  {Roep 1 malig voor de eerste keer de Initialize procedure aan.}
  if not vInitializeDone then uCommon.Initialize;

  {Set de Layout van de applicatie.}
  SetLayOutApplication;

  {Set de Colors van de applicatie.}
  SetColorsApplication;

  {Set de Program instellingen van de applicatie.}
  SetProgramApplication;
end;

{=====================================================================================================}
{= FormShow Procedure, Deze dient alleen maar om de CbDummy CheckBox de Focus te geven. ==============}
{=====================================================================================================}
procedure TfrmMain.FormShow(Sender: TObject);
begin
 {Set Focus op DUMMY Checkbox, deze heeft een Size van 0,0 dus niet zichtbaar. !!!}
  CbDummy.SetFocus;
end;

{=====================================================================================================}
{= FormCloseQuery Procedure, bij het afsluiten eventueel een bevestiging vragen en INI File saven. ===}
{=====================================================================================================}
procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  {Als er volgens de INI FILE een bevestiging gevraagd moet worden...}
  if uReadIniFile.vConfirmExit then
    begin
      {Vraag bevestiging.}
      if MessageDlg('Are you sure you want to quit ?', mtConfirmation, [mbYes, mbNo], 0) in [mrYes] then
        begin
          CanClose := True;
          {Als er volgens de INI FILE gesaved moet worden bij afsluiten...}
          if vSaveOnExit then
            begin
              uWriteIniFile.WriteIniFileSection('SaveOnExit');
            end;
        end
      else
        {Afsluiten geannuleerd.}
        CanClose := False;
    end;
end;

{=====================================================================================================}
{= Timer Event Procedure, deze wordt elke seconden getriggerd om nieuwe data op te halen. ============}
{=====================================================================================================}
procedure TfrmMain.TmrSequenceTimer(Sender: TObject);
begin
  {Verhoog SessieActief teller, hiermee wordt oa. de Sessie Average berekend.}
  Inc(vSessionActive);

  {Geeft de current uptime van D.U.S.T in de statusbar weer.}
  StatusbarMain.Panels[1].Text := uCommon.SecondsToString(vSessionActive);

  {Haal Data Op !}
  uCommon.GetData;

  {Bereken / Muteer Data !}
  uCommon.CalculateData;

  {Plaats Data op scherm !}
  uCommon.SetData;

  {Controleer of er een Alarm Geraised moet worden.}
  uCommon.CheckAlarms(nil);

  {Als applicatie in Tray draaid toon dan de Up en Download speed in de hint van het Icon.}
  if JvTray.Active then
    JvTray.Hint := 'Current Down: ' + frmMain.EdtSessionCurrentReceived.Text + '   Current Up: ' + frmMain.EdtSessionCurrentSent.Text;
end;

{=====================================================================================================}
{= Alarm 1 Timer Event, deze wordt getriggerd als het alarm gereset wordt, indien timer active is. ===)
{=====================================================================================================}
procedure TfrmMain.TmrAlarm1Timer(Sender: TObject);
begin
  vAlarmTimerDone1 := True;
  TmrAlarm1.Enabled := False;
end;

{=====================================================================================================}
{= Alarm 2 Timer Event, deze wordt getriggerd als het alarm gereset wordt, indien timer active is. ===)
{=====================================================================================================}
procedure TfrmMain.TmrAlarm2Timer(Sender: TObject);
begin
  vAlarmTimerDone2 := True;
  TmrAlarm2.Enabled := False;
end;

{=====================================================================================================}
{= Procedure om de Applicatie te maximalizeren na een klik op het Tray Icoon. ========================}
{=====================================================================================================}
procedure TfrmMain.JvTrayClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  {Restore's Tray Icoon na een IE Crash}
  JvTray.DoCheckCrash;

  {Toon Applicatie.}
  frmMain.Show;

  {Dirty one, zorgt ervoor dat de Minimize button MEER als 1x gebruikt kan worden. !!!}
  Application.Restore;

  {Haal de applicatie naar de voorgrond.}
  SetForegroundWindow(Handle);

  {Zorg er voor dat TrayIcoon NIET zichtbaar is in de tray.}
  JvTray.Active := False;
end;

{=====================================================================================================}
{= Procedure om de Applicatie te minimalizeren na een klik op het minimize border Icoon. =============}
{=====================================================================================================}
procedure TfrmMain.OnMinimize(Sender: TObject);
begin
  {Restore's Tray Icoon na een IE Crash}
  JvTray.DoCheckCrash;

  {Verberg Applicatie.}
  frmMain.Hide;

  {Zorg er voor dat TrayIcoon zichtbaar is in de tray.}
  JvTray.Active := True;
end;

{=====================================================================================================}
{= Procedure om de Layout van de Applicatie te setten a.d.v. de Ini File Instellingen. ===============}
{= Met speciale dank aan Matthijs. (voor het maken / meedenken van deze procedure) ===================}
{=====================================================================================================}
procedure TfrmMain.SetLayOutApplication;
var
  {Array om de Groupbox Namen in op te slaan.}
  vGbArray: array[0..3] of TGroupBox;

  {Array om de Boolean's of Groupboxen getoond moet worden in op te slaan.}
  vLayoutShowArray: array[0..3] of Boolean;

  {Globale Counter}
  vICounter: Byte;

  {Variabele met de start hoogte van de eerst getoonde Groupbox.}
  vStartTop: Integer;

  {Var om bij te houden of de Bevel > BvDevider wel of niet getoond moet worden.}
  vAantalBoxenZichtbaar: Byte;
begin
  vAantalBoxenZichtbaar := 0;
  vStartTop := 8;

  {Vul de Groupbox Array met de namen van de 4 Groupboxen.}
  vGbArray[0] := GbAdapter;
  vGbArray[1] := GbUnits;
  vGbArray[2] := GbStandard;
  vGbArray[3] := GbDecimal;

  {Vul de Boolean Array met de Boolean's om te indiceren welke box getoond moet worden.}
  vLayoutShowArray[0] := vLayOutAdapterBoxShow;
  vLayoutShowArray[1] := vLayOutUnitsBoxShow;
  vLayoutShowArray[2] := vLayOutStandardBoxShow;
  vLayoutShowArray[3] := vLayOutDecimalsBoxShow;

  for vICounter := 0 to 3 do
    begin
      if vLayoutShowArray[vICounter] then
        {indien Boolean in Array True is..}
        begin
          {Maak Groupbox visible.}
          vGbArray[vICounter].Visible := True;

          {Set de Top propertie van de Groupbox gelijk aan de variable.}
          vGbArray[vICounter].Top := vStartTop;

          {Verhoog de Top variabele met de hoogte van de getoonde Groupbox + 6 voor de ruimte er tussen.}
          vStartTop := vStartTop + vGbArray[vICounter].Height + 6;

          {Verhoog aantalal zichtbare Groupboxen.}
          Inc(vAantalBoxenZichtbaar);
        end
      else
       {indien Boolean in Array False is..}
        begin
          {Maak Groupbox invisible.}
          vGbArray[vICounter].Visible := False;
        end;
    end;

  if vAantalBoxenZichtbaar > 0 then
    {Indien er minimaal 1 Groupbox zichtbaar is..}
    begin
      {Verhoog Top variable met 6 voor de ruimte er tussen.}
      vStartTop := vStartTop + 6;

      {Toon de bevel tussen de 1..4 Groupboxen en de (Received & Sent) Groupbox.}
      BvDevider.Visible := True;

      {Set de Top propertie van de Bevel gelijk aan de variable.}
      BvDevider.Top := vStartTop;

      {Verhoog de Top variabele met de hoogte van de Bevel + 6 voor de ruimte er tussen.}
      vStartTop := vStartTop + BvDevider.Height + 6;
    end
    {Indien er GEEN Groupbox zichtbaar is..}
  else BvDevider.Visible := False;

  {Set de Top propertie's van de Receive en Sent Groupbox gelijk aan de variable.}
  GbReceived.Top := vStartTop;
  GbSent.Top := vStartTop;

  {Vergroot of verklein form lengte, ivm het aantal zichtbare Groupboxen.
   Hier ClientHeigt gebruik omdat Height geen rekening houd met het menu op het form.}
  frmMain.ClientHeight := GbSent.Top + GbSent.Height + StatusbarMain.Height + 10;

  {Toon / Set Adapter Groupbox Caption ?}
  if vLayOutAdapterBoxCaptionShow then GbAdapter.Caption := 'Adapter ' else GbAdapter.Caption := '';

  {Toon / Set Units Groupbox Caption ?}
  if vLayOutUnitsBoxCaptionShow then GbUnits.Caption := 'Units ' else GbUnits.Caption := '';

  {Toon / Set Standard Groupbox Caption ?}
  if vLayOutStandardBoxCaptionShow then GbStandard.Caption := 'Standard ' else GbStandard.Caption := '';

  {Toon / Set Decimals Groupbox Caption ?}
  if vLayOutDecimalsBoxCaptionShow then GbDecimal.Caption := 'Decimal ' else GbDecimal.Caption := '';
end;

{=====================================================================================================}
{= Procedure om de Colors van de Applicatie te setten a.d.v. de Ini File Instellingen. ===============}
{=====================================================================================================}
procedure TfrmMain.SetColorsApplication;
begin
  {Hier wordt de Font Color van de Edit's gezet en eventueel text op BOLD gezet}
  EdtSessionCurrentReceived.Font.Color := StringToColor(vSessionCurrentReceivedColor);
  if vSessionCurrentReceivedBold then EdtSessionCurrentReceived.Font.Style := [fsbold]
  else EdtSessionCurrentReceived.Font.Style := [];

  EdtSessionAverageReceived.Font.Color := StringToColor(vSessionAverageReceivedColor);
  if vSessionAverageReceivedBold then EdtSessionAverageReceived.Font.Style := [fsbold]
  else EdtSessionAverageReceived.Font.Style := [];

  EdtSessionMaxReceived.Font.Color := StringToColor(vSessionMaxReceivedColor);
  if vSessionMaxReceivedBold then EdtSessionMaxReceived.Font.Style := [fsbold]
  else EdtSessionMaxReceived.Font.Style := [];

  EdtSessionTotalReceived.Font.Color := StringToColor(vSessionTotalReceivedColor);
  if vSessionTotalReceivedBold then EdtSessionTotalReceived.Font.Style := [fsbold]
  else EdtSessionTotalReceived.Font.Style := [];

  EdtWindowsTotalReceived.Font.Color := StringToColor(vWindowsTotalReceivedColor);
  if vWindowsTotalReceivedBold then EdtWindowsTotalReceived.Font.Style := [fsbold]
  else EdtWindowsTotalReceived.Font.Style := [];

  EdtSessionCurrentSent.Font.Color := StringToColor(vSessionCurrentSentColor);
  if vSessionCurrentSentBold then EdtSessionCurrentSent.Font.Style := [fsbold]
  else EdtSessionCurrentSent.Font.Style := [];

  EdtSessionAverageSent.Font.Color := StringToColor(vSessionAverageSentColor);
  if vSessionAverageSentBold then EdtSessionAverageSent.Font.Style := [fsbold]
  else EdtSessionAverageSent.Font.Style := [];

  EdtSessionMaxSent.Font.Color := StringToColor(vSessionMaxSentColor);
  if vSessionMaxSentBold then EdtSessionMaxSent.Font.Style := [fsbold]
  else EdtSessionMaxSent.Font.Style := [];

  EdtSessionTotalSent.Font.Color := StringToColor(vSessionTotalSentColor);
  if vSessionTotalSentBold then EdtSessionTotalSent.Font.Style := [fsbold]
  else EdtSessionTotalSent.Font.Style := [];

  EdtWindowsTotalSent.Font.Color := StringToColor(vWindowsTotalSentColor);
  if vWindowsTotalSentBold then EdtWindowsTotalSent.Font.Style := [fsbold]
  else EdtWindowsTotalSent.Font.Style := [];
end;

{=====================================================================================================}
{= Procedure om de Programma Settings van de Applicatie te setten a.d.v. de Ini File Instellingen. ===}
{=====================================================================================================}
procedure TfrmMain.SetProgramApplication;
begin
  CmbAdapterLijst.ItemIndex := vAdapterBoxIndex;
  RbBits.Checked := vUnitsInBits;
  RbBytes.Checked := vUnitsInBytes;
  RbStandardBinary.Checked := vStandardInBinary;
  RbStandartDecimal.Checked := vStandardInDecimal;
  Rb1Decimaal.Checked := vDecimals1Decimal;
  Rb2Decimaal.Checked := vDecimals2Decimal;
  Rb3Decimaal.Checked := vDecimals3Decimal;
  Rb4Decimaal.Checked := vDecimals4Decimal;

  Application.ShowHint := vShowHints;
  if vStayOnTop then frmMain.FormStyle := fsStayOnTop else frmMain.FormStyle := fsNormal;
end;

{=====================================================================================================}
{=============================== Menu Procedure's (in menu volgorde.) ================================}
{=====================================================================================================}

{=====================================================================================================}
{= Menu Keuze : File -> Minimize. ====================================================================}
{=====================================================================================================}
procedure TfrmMain.Minimize1Click(Sender: TObject);
begin
  {Forceer een border minimize click.}
  frmMain.OnMinimize(nil);
end;

{=====================================================================================================}
{= Menu Keuze : File -> Exit. ========================================================================}
{=====================================================================================================}
procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  {Sluit Main Form, en daarmee ook de Applicatie.}
  frmMain.Close;
end;

{=====================================================================================================}
{= Menu Keuze : Settings -> Layout. ==================================================================}
{=====================================================================================================}
procedure TfrmMain.Layout1Click(Sender: TObject);
begin
  try
    try
      {Creeër dynamisch het Layout Form.}
      frmLayout := TfrmLayout.Create(Self);
      vFormOpen := True;
      frmLayout.ShowModal;
    except
      Beep;
      MessageDlg('Error raised while creating Layout Form.' + #13 + #10 + 'Procedure : TfrmMain.Layout1Click.', mtError, [mbOK], 0);
    end;
  finally
    {Geef Layout Form weer vrij.}
    frmLayout.Free;
    vFormOpen := False;
  end;
  {Lees de Layout Section van de Ini file in.}
  uReadIniFile.ReadIniFileSectionSetVar('Layout');

  {Roep de procedure om de Layout van de Applicatie te setten aan.}
  SetLayOutApplication;
end;

{=====================================================================================================}
{= Menu Keuze : Settings -> Colors. ==================================================================}
{=====================================================================================================}
procedure TfrmMain.Colors1Click(Sender: TObject);
begin
  try
    try
      {Creeër dynamisch het Colors Form.}
      frmColors := TfrmColors.Create(Self);
      vFormOpen := True;
      frmColors.ShowModal;
    except
      Beep;
      MessageDlg('Error raised while creating Colors Form.' + #13 + #10 + 'Procedure : TfrmMain.Colors1Click.', mtError, [mbOK], 0);
    end;
  finally
    {Geef Colors Form weer vrij.}
    frmColors.Free;
    vFormOpen := False;
  end;
  {Lees de Colors Section van de Ini file in.}
  uReadIniFile.ReadIniFileSectionSetVar('Colors');

  {Roep de procedure om de Colors van de Applicatie te setten aan.}
  if vRunning then SetColorsApplication;
end;

{=====================================================================================================}
{= Menu Keuze : Settings -> Program. ==================================================================}
{=====================================================================================================}
procedure TfrmMain.Program1Click(Sender: TObject);
begin
  try
    try
      {Creeër dynamisch het Program Form.}
      frmProgram := TfrmProgram.Create(Self);
      vFormOpen := True;
      frmProgram.ShowModal;
    except
      Beep;
      MessageDlg('Error raised while creating Program Form.' + #13 + #10 + 'Procedure : TfrmMain.Program1Click.', mtError, [mbOK], 0);
    end;
  finally
    {Geef Program Form weer vrij.}
    frmProgram.Free;
    vFormOpen := False;
  end;
  {Lees de Colors Section van de Ini file in.}
  uReadIniFile.ReadIniFileSectionSetVar('Program');

  {Roep de procedure om de Program Settings van de Applicatie te setten aan.}
  SetProgramApplication;
end;

{=====================================================================================================}
{= Menu Keuze : Settings -> Alarms. ==================================================================}
{=====================================================================================================}
procedure TfrmMain.Alarms1Click(Sender: TObject);
begin
  try
    try
      {Creeër dynamisch het Alarms Form.}
      frmAlarms := TfrmAlarms.Create(Self);
      vFormOpen := True;
      frmAlarms.ShowModal;
    except
      Beep;
      MessageDlg('Error raised while creating Alarms Form.' + #13 + #10 + 'Procedure : TfrmMain.Alarms1Click.', mtError, [mbOK], 0);
    end;
  finally
    {Geef Alarms Form weer vrij.}
    frmAlarms.Free;
    vFormOpen := False;
  end;
   {Lees de Colors Section van de Ini file in.}
  uReadIniFile.ReadIniFileSectionSetVar('Alarms');
end;

{=====================================================================================================}
{= Menu Keuze : Runtime -> ResetCounters. ============================================================}
{=====================================================================================================}
procedure TfrmMain.ResetCounters1Click(Sender: TObject);
begin
  {Stop de timer.}
  TmrSequence.Enabled := False;

  {Reset alle getallen behalve de windows TOTAL up en download.}
  CountersReset;
end;

{=====================================================================================================}
{= Menu Keuze : Runtime -> Stop Dust. ================================================================}
{=====================================================================================================}
procedure TfrmMain.StopDust1Click(Sender: TObject);
begin
  {Stop de timer.}
  TmrSequence.Enabled := False;
  vRunning := False;
  StatusbarMain.Panels[1].Text := 'Stopped ';

  {Disable menu : Runtime -> Stop Reset Counters.}
  MnufrmMain.Items[2].Items[0].Enabled := False;

  {Disable menu : Runtime -> Stop Dust.}
  MnufrmMain.Items[2].Items[1].Enabled := False;

  {Enable menu : Runtime -> Start Dust.}
  MnufrmMain.Items[2].Items[2].Enabled := True;

  {Set alle velden op disabled.}
  uCommon.AllDisabled;
end;

{=====================================================================================================}
{= Menu Keuze : Runtime -> Start Dust.================================================================}
{=====================================================================================================}
procedure TfrmMain.StartTimer1Click(Sender: TObject);
begin
  {Start de timer.}
  TmrSequence.Enabled := True;
  vRunning := True;

  {Enable menu : Runtime -> Stop Reset Counters.}
  MnufrmMain.Items[2].Items[0].Enabled := True;

  {Enable menu : Runtime -> Stop Dust.}
  MnufrmMain.Items[2].Items[1].Enabled := True;

  {Disable menu : Runtime -> Start Dust.}
  MnufrmMain.Items[2].Items[2].Enabled := False;

  {Set alle velden op enabled.}
  uCommon.AllEnabled;
end;

{=====================================================================================================}
{= Menu Keuze : Runtime -> Show Alarm 1.==============================================================}
{=====================================================================================================}
procedure TfrmMain.ShowAlarm11Click(Sender: TObject);
begin
  {Reset de variabele.}
  vDontShowAlarm1Again := False;

  {Disable menu : Runtime -> Show Alarm 1.}
  frmMain.MnufrmMain.Items[2].Items[4].Enabled := False;
end;

{=====================================================================================================}
{= Menu Keuze : Runtime -> Show Alarm 2.==============================================================}
{=====================================================================================================}
procedure TfrmMain.ShowAlarm21Click(Sender: TObject);
begin
  {Reset de variabele.}
  vDontShowAlarm2Again := False;

  {Disable menu : Runtime -> Show Alarm 1.}
  frmMain.MnufrmMain.Items[2].Items[5].Enabled := False;
end;

{=====================================================================================================}
{= Menu Keuze : Help -> History. =====================================================================}
{=====================================================================================================}
procedure TfrmMain.History1Click(Sender: TObject);
begin
  try
    try
      {Creeër dynamisch het History Form.}
      frmHistory := TfrmHistory.Create(Self);
      vFormOpen := True;
      frmHistory.ShowModal;
    except
      Beep;
      MessageDlg('Error raised while creating Program Form.' + #13 + #10 + 'Procedure : TfrmMain.History1Click.', mtError, [mbOK], 0);
    end;
  finally
    {Geef History weer vrij.}
    frmHistory.Free;
    vFormOpen := False;
  end;
end;

{=====================================================================================================}
{= Menu Keuze : Help -> About. =======================================================================}
{=====================================================================================================}
procedure TfrmMain.About1Click(Sender: TObject);
begin
  try
    try
      {Creeër dynamisch het About Form.}
      frmAbout := TfrmAbout.Create(Self);
      vFormOpen := True;
      frmAbout.ShowModal;
    except
      Beep;
      MessageDlg('Error raised while creating Program Form.' + #13 + #10 + 'Procedure : TfrmMain.About1Click.', mtError, [mbOK], 0);
    end;
  finally
    {Geef About Form weer vrij.}
    frmAbout.Free;
    vFormOpen := False;
  end;
end;

end.

