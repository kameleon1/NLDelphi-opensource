unit uAlarmDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, JvLabel, JvBlinkingLabel;

type
  TfrmAlarmDialog = class(TForm)
    BtAlarmReset: TBitBtn;
    LblAttachedTo: TLabel;
    LblAlarmId: TLabel;
    CbDontShowAgain: TCheckBox;
    Bevel1: TBevel;
    JvBlAlarm: TJvBlinkingLabel;
    procedure FormShow(Sender: TObject);
    procedure BtAlarmResetClick(Sender: TObject);
    procedure CbDontShowAgainClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlarmDialog: TfrmAlarmDialog;

implementation

uses uMain, uCommon;

{$R *.dfm}
{=====================================================================================================}
{= FormShow Event, Set Captions en labels. ===========================================================}
{=====================================================================================================}
procedure TfrmAlarmDialog.FormShow(Sender: TObject);
begin
  {Set Form Caption}
  frmAlarmDialog.Caption := cAPPLICATIETITELNLD + ' - [ Alarm ]';

  {Set juiste alarm Id in blinking text.}
  JvBlAlarm.Caption := 'Alarm ' + IntToStr(vAlarmID) + '.';

  {Set juiste text in labels.}
  LblAttachedTo.Caption := '[ ' + vAlarmString + ' ]';
  LblAlarmId.Caption := 'has reached the [ Alarm ' + IntToStr(vAlarmID) + ' ] limit.';
end;

{=====================================================================================================}
{= Alarm Reset Button Click Procedure, Sluit het Alarm Dialog. =======================================}
{=====================================================================================================}
procedure TfrmAlarmDialog.BtAlarmResetClick(Sender: TObject);
begin
  {Sluit Program Form.}
  frmAlarmDialog.Close;
end;

{=====================================================================================================}
{= Don't show again Click Procedure, zorgt ervoor dat alarm maar 1 malig geraised kan worden. ========}
{=====================================================================================================}
procedure TfrmAlarmDialog.CbDontShowAgainClick(Sender: TObject);
begin
  if CbDontShowAgain.Checked then
    begin
      {Indien alarm 1 en checkbox gechecked zijn.}
      if vAlarmID = 1 then vDontShowAlarm1Again := True;

      {Enable menu : Runtime -> Show Alarm 1.}
      if vAlarmID = 1 then frmMain.MnufrmMain.Items[2].Items[4].Enabled := True;

      {Indien alarm 2 en checkbox gechecked zijn.}
      if vAlarmID = 2 then vDontShowAlarm2Again := True;

      {Enable menu : Runtime -> Show Alarm 2.}
      if vAlarmID = 2 then frmMain.MnufrmMain.Items[2].Items[5].Enabled := True;
    end
  else
    begin
      if vAlarmID = 1 then vDontShowAlarm1Again := False;
      if vAlarmID = 2 then vDontShowAlarm2Again := False;
    end;
end;

end.

