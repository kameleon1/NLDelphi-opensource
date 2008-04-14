unit SettingsFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, ExtCtrls, ComCtrls, Mask, DeXSettingsU,
  Buttons, JvDialogs, NLDNotifier;

type
  TSettingsForm = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    ActionList1: TActionList;
    OKAction: TAction;
    CancelAction: TAction;
    GeneralSheet: TTabSheet;
    PopupCheck: TCheckBox;
    PopupGroup: TGroupBox;
    PopupColorSelect: TColorBox;
    Label1: TLabel;
    Label2: TLabel;
    PopupTimeEdit: TMaskEdit;
    Label3: TLabel;
    IgnoreselfCheck: TCheckBox;
    SelfNameEdit: TEdit;
    Label4: TLabel;
    AutoSaveCheck: TCheckBox;
    DeleteOnPopClickCheck: TCheckBox;
    Label5: TLabel;
    LinkColorSelect: TColorBox;
    Label6: TLabel;
    TextColorSelect: TColorBox;
    Bevel1: TBevel;
    TestPopupButton: TButton;
    IntervalEdit: TMaskEdit;
    Label7: TLabel;
    Label8: TLabel;
    RunOnStartupCheck: TCheckBox;
    Label9: TLabel;
    NotifySoundEdit: TEdit;
    NotifySoundCheck: TCheckBox;
    OpenSoundButton: TSpeedButton;
    PlayWavButton: TSpeedButton;
    OpenWavDialog: TJvOpenDialog;
    Notifier: TNLDNotifier;
    procedure OKActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure TestPopupButtonClick(Sender: TObject);
    procedure OpenSoundButtonClick(Sender: TObject);
    procedure PlayWavButtonClick(Sender: TObject);
  private
    FSettings: IXMLSettingsType;
    procedure SaveSettings;
  protected
    procedure DoShow; override;
  public
    property Settings: IXMLSettingsType read FSettings write FSettings;
  end;

implementation

{$R *.dfm}

uses
  MMSystem;

procedure TSettingsForm.OKActionExecute(Sender: TObject);
begin
  SaveSettings;
  ModalResult := mrOk;
end;

procedure TSettingsForm.CancelActionExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSettingsForm.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  PopupGroup.Enabled := PopupCheck.Checked;
  SelfNameEdit.Enabled := IgnoreselfCheck.Checked;
  NotifySoundEdit.Enabled := NotifySoundCheck.Checked;
  OpenSoundButton.Enabled := NotifySoundCheck.Checked;
  PlayWavButton.Enabled := NotifySoundEdit.Text <> '';
end;

procedure TSettingsForm.SaveSettings;
var
  ColorString: string;
begin
  FSettings.Popup.Enabled := PopupCheck.Checked;

  ColorToIdent(PopupColorSelect.Selected, ColorString);
  FSettings.Popup.Color := ColorString;

  ColorToIdent(TextColorSelect.Selected, ColorString);
  FSettings.Popup.TextColor := ColorString;

  ColorToIdent(LinkColorSelect.Selected, ColorString);
  FSettings.Popup.LinkColor := ColorString;

  FSettings.Popup.Time := StrToInt(PopupTimeEdit.Text);
  FSettings.AutoSave := AutoSaveCheck.Checked;
  FSettings.Popup.DeleteOnClick := DeleteOnPopClickCheck.Checked;

  FSettings.IgnoreSelf.Enabled := IgnoreselfCheck.Checked;
  FSettings.IgnoreSelf.Username := SelfNameEdit.Text;
  FSettings.Interval := StrToInt(IntervalEdit.Text);
{ TODO : AutoRun regelen }
//  RunOnStartup.SetRunOnStartup('DeX', Application.ExeName, False,
//    RunOnStartupCheck.Checked);
  FSettings.NotifySound.Enabled := NotifySoundCheck.Checked and
    (NotifySoundEdit.Text <> '');
  FSettings.NotifySound.FileName := NotifySoundEdit.Text;

  if FSettings.Interval < 1 then
    FSettings.Interval := 1;
end;

procedure TSettingsForm.DoShow;
var
  Color: Longint;
begin
  inherited;
  PopupCheck.Checked := FSettings.Popup.Enabled;

  IdentToColor(FSettings.Popup.Color, Color);
  PopupColorSelect.Selected := Color;

  IdentToColor(FSettings.Popup.TextColor, Color);
  TextColorSelect.Selected := Color;

  IdentToColor(FSettings.Popup.LinkColor, Color);
  LinkColorSelect.Selected := Color;

  PopupTimeEdit.Text := IntToStr(FSettings.Popup.Time);
  DeleteOnPopClickCheck.Checked := FSettings.Popup.DeleteOnClick;

  IgnoreselfCheck.Checked := FSettings.IgnoreSelf.Enabled;
  SelfNameEdit.Text := FSettings.IgnoreSelf.Username;

  AutoSaveCheck.Checked := FSettings.AutoSave;
  IntervalEdit.Text := IntToStr(FSettings.Interval);
{ TODO : AutoRun regelen }
//  RunOnStartupCheck.Checked := RunOnStartup.GetRun('DeX');
  NotifySoundCheck.Checked := FSettings.NotifySound.Enabled;
  NotifySoundEdit.Text := FSettings.NotifySound.FileName;
end;

procedure TSettingsForm.TestPopupButtonClick(Sender: TObject);
begin
  Notifier.Color := PopupColorSelect.Selected;
  Notifier.TextColor := TextColorSelect.Selected;
  Notifier.LinkColor := LinkColorSelect.Selected;
  Notifier.Timeout := StrToInt(PopupTimeEdit.Text);
  Notifier.Execute('Test, click om naar NLDelphi te gaan',
    'www.NLDelphi.com');
end;

procedure TSettingsForm.OpenSoundButtonClick(Sender: TObject);
begin
  OpenWAVDialog.FileName := NotifySoundEdit.Text;

  if OpenWAVDialog.Execute then
    NotifySoundEdit.Text := OpenWAVDialog.FileName;
end;

procedure TSettingsForm.PlayWavButtonClick(Sender: TObject);
begin
  sndPlaySound(PChar(NotifySoundEdit.Text), 0);
end;

end.
