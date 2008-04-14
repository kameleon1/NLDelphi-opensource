unit uAlarms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RXSpin;

type
  TfrmAlarms = class(TForm)
    BtCancel: TBitBtn;
    BtOk: TBitBtn;
    BtDefault: TBitBtn;
    Panel1: TPanel;
    GbAlarmSettings1: TGroupBox;
    CmbAlarmUnits1: TComboBox;
    CmbAlarmAttachedTo1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CbAlarmTimerActive1: TCheckBox;
    CbAlarmOnTop1: TCheckBox;
    CbAlarmActive1: TCheckBox;
    CbAlarmSound1: TCheckBox;
    Bevel1: TBevel;
    GbAlarmSettings2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel2: TBevel;
    CmbAlarmUnits2: TComboBox;
    CmbAlarmAttachedTo2: TComboBox;
    CbAlarmTimerActive2: TCheckBox;
    CbAlarmOnTop2: TCheckBox;
    CbAlarmActive2: TCheckBox;
    CbAlarmSound2: TCheckBox;
    SpeAlarmLimit1: TRxSpinEdit;
    SpeAlarmTimer1: TRxSpinEdit;
    SpeAlarmLimit2: TRxSpinEdit;
    SpeAlarmTimer2: TRxSpinEdit;
    procedure BtDefaultClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure ObjectClick(Sender: TObject);
    procedure SetAlarm1;
    procedure SetAlarm2;
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlarms: TfrmAlarms;

  {Var om bij te houden of FormShow Event getriggert en klaar is.
  (ivm checkbox die een ongewenst click event genereerd indien deze codematig gezet wordt.}
  vFormShowDone: Boolean;

  {Var om bij te houden of DefaultClick Event getriggert en klaar is.
  (ivm Colorbox / Checkbox die een ongewenst click event genereerd indien deze codematig gezet wordt.}
  vSetDefaultDone: Boolean;
implementation

uses uProgram, uMain, uCommon, uReadIniFile, uWriteIniFile;

{$R *.dfm}

{=====================================================================================================}
{= FormShow Event, Lees Ini File in en adv. de ingezen waardes de checkboxen setten. =================}
{=====================================================================================================}
procedure TfrmAlarms.FormShow(Sender: TObject);
begin
  {Set Form Caption}
  frmAlarms.Caption := cAPPLICATIETITELNLD + ' - [ Alarms ]';

  {Lees Ini file in, alleen de sectie's voor het setten van de layout}
  uReadIniFile.ReadIniFileSectionSetObject('Alarms');

  {Maakt alle velden m.b.t Alarm1 Enabled of Disabled, dit a.d.v de INI FILE instelling.}
  SetAlarm1;

  {Maakt alle velden m.b.t Alarm2 Enabled of Disabled, dit a.d.v de INI FILE instelling.}
  SetAlarm2;

  {Set var op true, formshow event is klaar.}
  vFormShowDone := True;

  {Set var op true, DefaultClick event is klaar.}
  vSetDefaultDone := False;
end;

{=====================================================================================================}
{= Procedure om het Alarms Form te sluiten na een klik op het close border Icoon. =====================}
{=====================================================================================================}
procedure TfrmAlarms.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  {Forceer een Button Click op de Cancel button.}
  BtCancelClick(nil);
end;

{=====================================================================================================}
{= Form Close Procedure, wordt door de Cancel en Ok button aangeroepen.===============================}
{=====================================================================================================}
procedure TfrmAlarms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {Set var terug op false, om er voor te zorgen dat deze nog een keer gebruikt kan worden.}
  vFormShowDone := False;

  {Set var terug op false, om er voor te zorgen dat deze nog een keer gebruikt kan worden.}
  vSetDefaultDone := False;

  {Toon Main Form.}
  frmMain.Show;
end;

{=====================================================================================================}
{= Cancel Button Click Procedure, Lees Ini File opnieuw in en maak wijzigingen daar mee ongedaan. ====}
{=====================================================================================================}
procedure TfrmAlarms.BtCancelClick(Sender: TObject);
begin
  {Sluit Program Form.}
  frmAlarms.Close;
end;

{=====================================================================================================}
{= Ok Button Click Procedure, Schrijf Ini File weg en sluit scherm. ==================================}
{=====================================================================================================}
procedure TfrmAlarms.BtOkClick(Sender: TObject);
begin
  {Schrijf Ini file weg, alleen de sectie's voor het setten van de Alarmen}
  uWriteIniFile.WriteIniFileSection('Alarms');

  {Sluit Program Form.}
  frmAlarms.Close;
end;

{=====================================================================================================}
{= Default Button Click Procedure, Set alle Colorboxen en Checkboxen op RICHARD's Default instelling.=}
{=====================================================================================================}
procedure TfrmAlarms.BtDefaultClick(Sender: TObject);
begin
  {Set Default button disabled, omdat er toch al op geklickt is.}
  BtDefault.Enabled := False;

  {Set var op false, DefaultClick event is bezig...}
  vSetDefaultDone := False;

  {Set alle Colorboxen en Checkboxen op RICHARD's Default instelling.}
  {Bij wijzigingen, denk dan ook aan de Default Property's van de INI File. !!!}
  with frmAlarms do
    begin
      frmAlarms.SpeAlarmLimit1.Value := 55;
      frmAlarms.CmbAlarmUnits1.ItemIndex := 5;
      frmAlarms.CmbAlarmAttachedTo1.ItemIndex := 0;
      frmAlarms.CbAlarmActive1.Checked := False;
      frmAlarms.CbAlarmTimerActive1.Checked := True;
      frmAlarms.SpeAlarmTimer1.Value := 60;
      frmAlarms.CbAlarmOnTop1.Checked := False;
      frmAlarms.CbAlarmSound1.Checked := True;

      frmAlarms.SpeAlarmLimit2.Value := 12;
      frmAlarms.CmbAlarmUnits2.ItemIndex := 5;
      frmAlarms.CmbAlarmAttachedTo2.ItemIndex := 4;
      frmAlarms.CbAlarmActive2.Checked := False;
      frmAlarms.CbAlarmTimerActive2.Checked := True;
      frmAlarms.SpeAlarmTimer2.Value := 60;
      frmAlarms.CbAlarmOnTop2.Checked := False;
      frmAlarms.CbAlarmSound2.Checked := True;
    end;

  {Set var op True, DefaultClick event is Klaar !}
  vSetDefaultDone := True;

  {Set BtOk op enabled, omdat er iets gewijzigt KAN zijn.}
  BtOk.Enabled := True;
end;

{=====================================================================================================}
{= Event wat bij ELKE Combobox & Checkbox click getriggerd wordt, doel: setten v/d Ok en Default Btn =}
{=====================================================================================================}
procedure TfrmAlarms.ObjectClick(Sender: TObject);
begin
 {Dankzij deze var, wordt routine alleen uitgevoerd indien het formshow of setdefault event klaar is.}
  if vFormShowDone or vSetDefaultDone then
    begin
      {Maakt alle velden m.b.t Alarm1 Enabled of Disabled, dit a.d.v de INI FILE instelling.}
      SetAlarm1;

      {Maakt alle velden m.b.t Alarm1 Enabled of Disabled, dit a.d.v de INI FILE instelling.}
      SetAlarm2;

      {Wijziging heeft plaatsgevonden dus, de Ok en Default button moeten GeEnabled worden.}
      BtOk.Enabled := True;

      if vSetDefaultDone then BtDefault.Enabled := True;
    end;
end;

{=====================================================================================================}
{= Procedure om alle instellingen van Alarm 1 te disablen of enablen. ================================}
{=====================================================================================================}
procedure TfrmAlarms.SetAlarm1;
begin
  if not CbAlarmActive1.Checked then
    begin
      SpeAlarmLimit1.Enabled := False;
      SpeAlarmLimit1.Color := clBtnFace;
      CmbAlarmUnits1.Enabled := False;
      CmbAlarmUnits1.Color := clBtnFace;
      CmbAlarmAttachedTo1.Enabled := False;
      CmbAlarmAttachedTo1.Color := clBtnFace;
      SpeAlarmTimer1.Enabled := False;
      SpeAlarmTimer1.Color := clBtnFace;
      CbAlarmTimerActive1.Enabled := False;
      CbAlarmOnTop1.Enabled := False;
      CbAlarmSound1.Enabled := False;
      Label1.Enabled := False;
      Label2.Enabled := False;
      Label3.Enabled := False;
      Label4.Enabled := False;
    end
  else
    begin
      SpeAlarmLimit1.Enabled := True;
      SpeAlarmLimit1.Color := clWindow;
      CmbAlarmUnits1.Enabled := True;
      CmbAlarmUnits1.Color := clWindow;
      CmbAlarmAttachedTo1.Enabled := True;
      CmbAlarmAttachedTo1.Color := clWindow;
      CbAlarmOnTop1.Enabled := True;
      CbAlarmSound1.Enabled := True;
      Label1.Enabled := True;
      Label2.Enabled := True;
      Label3.Enabled := True;
      CbAlarmTimerActive1.Enabled := True;

      {Als Timer Active 1 enabled is dan ...}
      if CbAlarmTimerActive1.Checked then
        begin
          SpeAlarmTimer1.Enabled := True;
          SpeAlarmTimer1.Color := clWindow;
          Label4.Enabled := True;
        end
      else
        begin
          SpeAlarmTimer1.Enabled := False;
          SpeAlarmTimer1.Color := clBtnFace;
          Label4.Enabled := False;
        end;
    end;
end;

{=====================================================================================================}
{= Procedure om alle instellingen van Alarm 2 te disablen of enablen. ================================}
{=====================================================================================================}
procedure TfrmAlarms.SetAlarm2;
begin
  if not CbAlarmActive2.Checked then
    begin
      SpeAlarmLimit2.Enabled := False;
      SpeAlarmLimit2.Color := clBtnFace;
      CmbAlarmUnits2.Enabled := False;
      CmbAlarmUnits2.Color := clBtnFace;
      CmbAlarmAttachedTo2.Enabled := False;
      CmbAlarmAttachedTo2.Color := clBtnFace;
      SpeAlarmTimer2.Enabled := False;
      SpeAlarmTimer2.Color := clBtnFace;
      CbAlarmTimerActive2.Enabled := False;
      CbAlarmOnTop2.Enabled := False;
      CbAlarmSound2.Enabled := False;
      Label5.Enabled := False;
      Label6.Enabled := False;
      Label7.Enabled := False;
      Label8.Enabled := False;
    end
  else
    begin
      SpeAlarmLimit2.Enabled := True;
      SpeAlarmLimit2.Color := clWindow;
      CmbAlarmUnits2.Enabled := True;
      CmbAlarmUnits2.Color := clWindow;
      CmbAlarmAttachedTo2.Enabled := True;
      CmbAlarmAttachedTo2.Color := clWindow;
      CbAlarmOnTop2.Enabled := True;
      CbAlarmSound2.Enabled := True;
      Label5.Enabled := True;
      Label6.Enabled := True;
      Label7.Enabled := True;
      CbAlarmTimerActive2.Enabled := True;

      {Als Timer Active 2 enabled is dan ...}
      if CbAlarmTimerActive2.Checked then
        begin
          SpeAlarmTimer2.Enabled := True;
          SpeAlarmTimer2.Color := clWindow;
          Label8.Enabled := True;
        end
      else
        begin
          SpeAlarmTimer2.Enabled := False;
          SpeAlarmTimer2.Color := clBtnFace;
          Label8.Enabled := False;
        end;
    end;
end;

end.

