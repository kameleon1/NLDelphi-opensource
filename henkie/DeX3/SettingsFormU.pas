unit SettingsFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, ExtCtrls, ComCtrls, Buttons, JvDialogs, NLDNotifier, jpeg, SettingsUnit, ButtonGroup,
  JvExControls, JvGradient, JvExStdCtrls, JvEdit, JvTabBar, JvSpin, Mask, JvExMask, JvCombobox, JvColorCombo;

type
  TSettingsForm = class(TForm)
    ActionList1: TActionList;
    OKAction: TAction;
    CancelAction: TAction;
    OpenSoundDialog: TJvOpenDialog;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    Image1: TImage;
    OkButton: TButton;
    CancelButton: TButton;
    BottomBevel: TBevel;
    PageControl: TPageControl;
    GeneralSheet: TTabSheet;
    PopupSheet: TTabSheet;
    TrackerSheet: TTabSheet;
    GeneralGroup: TGroupBox;
    StartWithWindowsCheck: TCheckBox;
    AlignTabbarToTopCheck: TCheckBox;
    UseTDeXHintCheck: TCheckBox;
    PopupGroup: TGroupBox;
    Label16: TLabel;
    Label2: TLabel;
    PopupColorsGroup: TGroupBox;
    TopColorLabel: TLabel;
    BottomColorlabel: TLabel;
    LinkLabel: TLabel;
    TopColorBox: TColorBox;
    BottomColorBox: TColorBox;
    LinkColorBox: TColorBox;
    ShowPopupCheck: TCheckBox;
    DeleteMessageCheck: TCheckBox;
    TrackerGroup: TGroupBox;
    Label17: TLabel;
    Label1: TLabel;
    AutoSaveCheck: TCheckBox;
    IgnoreGroup: TGroupBox;
    NamesList: TListBox;
    AddButton: TButton;
    DeleteButton: TButton;
    CategoriesGroup: TGroupBox;
    ButtonGroup: TButtonGroup;
    SiteColorsGroup: TRadioGroup;
    NameEdit: TJvEdit;
    IntervalEdit: TJvSpinEdit;
    DurationEdit: TJvSpinEdit;
    FontGroup: TGroupBox;
    PreviewLabel: TLabel;
    FontCombobox: TJvFontComboBox;
    PlaySoundCheck: TCheckBox;
    SoundEdit: TJvEdit;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    PlaySoundButton: TSpeedButton;
    Notifier: TNLDNotifier;
    Label4: TLabel;
    TextColorbox: TColorBox;
    TestPopupButton: TSpeedButton;
    AddAction: TAction;
    ClearButton: TButton;
    MessagesSheet: TTabSheet;
    GroupBox2: TGroupBox;
    DeleteMessagesAfterBeingReadCheck: TCheckBox;
    DeleteItemsCheck: TCheckBox;
    MultipleItemsDeletionCheck: TCheckBox;
    GroupDeletionCheck: TCheckBox;
    HideGroup: TGroupBox;
    MinimizeToTrayCheck: TCheckBox;
    CloseToTrayCheck: TCheckBox;
    HideOnStartCheck: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure ButtonGroupButtonClicked(Sender: TObject; Index: Integer);
    procedure ClearButtonClick(Sender: TObject);
    procedure AddActionUpdate(Sender: TObject);
    procedure AddActionExecute(Sender: TObject);
    procedure TestPopupButtonClick(Sender: TObject);
    procedure FontComboboxChange(Sender: TObject);
    procedure NamesListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PlaySoundButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure OKActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
  private
    procedure SetAlignTabbarToTop(const Value: boolean);
    procedure SetAutoSave(const Value: boolean);
    procedure SetColorStyle(const Value: TColorStyle);
    procedure SetConfirmGroupDeletion(const Value: boolean);
    procedure SetConfirmMultipleItemsDeletion(const Value: boolean);
    procedure SetDeleteNodesAfterAddingTofavorites(const Value: boolean);
    procedure SetFontName(const Value: string);
    procedure SetMinimizeTotray(const Value: boolean);
    procedure SetNotifySound(const Value: boolean);
    procedure SetNotifySoundFileName(const Value: string);
    procedure SetPopupBottomColor(const Value: TColor);
    procedure SetPopupDeleteOnOpen(const Value: boolean);
    procedure SetPopupDuration(const Value: integer);
    procedure SetPopupLinkColor(const Value: TColor);
    procedure SetPopupPopup(const Value: boolean);
    procedure SetPopupTextColor(const Value: TColor);
    procedure SetPopupTopColor(const Value: TColor);
    procedure SetStartWithWindows(const Value: boolean);
    procedure SetTrackerInterval(const Value: integer);
    procedure SetUseTDeXHint(const Value: boolean);
    procedure SetDeleteMessagesAfterBeingRead(const Value: boolean);
    procedure SetCloseToTray(const Value: boolean);
    procedure SetHideOnStart(const Value: boolean);
    function GetAlignTabbarToTop: boolean;
    function GetAutoSave: boolean;
    function GetColorStyle: TColorStyle;
    function GetConfirmGroupDeletion: boolean;
    function GetConfirmMultipleItemsDeletion: boolean;
    function GetDeleteNodesAfterAddingTofavorites: boolean;
    function GetFontName: string;
    function GetMinimizeTotray: boolean;
    function GetNotifySound: boolean;
    function GetNotifySoundFileName: string;
    function GetPopupBottomColor: TColor;
    function GetPopupDeleteOnOpen: boolean;
    function GetPopupDuration: integer;
    function GetPopupLinkColor: TColor;
    function GetPopupPopup: boolean;
    function GetPopupTextColor: TColor;
    function GetPopupTopColor: TColor;
    function GetStartWithWindows: boolean;
    function GetTrackerInterval: integer;
    function GetUseTDeXHint: boolean;
    function GetDeleteMessagesAfterBeingRead: boolean;
    function GetCloseToTray: boolean;
    function GetHideOnStart: boolean;
  public
    property AlignTabbarToTop: boolean read GetAlignTabbarToTop write SetAlignTabbarToTop;
    property AutoSave: boolean read GetAutoSave write SetAutoSave;
    property CloseToTray: boolean read GetCloseToTray write SetCloseToTray;
    property ColorStyle: TColorStyle read GetColorStyle write SetColorStyle;
    property ConfirmGroupDeletion: boolean read GetConfirmGroupDeletion write SetConfirmGroupDeletion;
    property ConfirmMultipleItemsDeletion: boolean read GetConfirmMultipleItemsDeletion write SetConfirmMultipleItemsDeletion;
    property DeleteNodesAfterAddingTofavorites: boolean read GetDeleteNodesAfterAddingTofavorites write SetDeleteNodesAfterAddingTofavorites;
    property DeleteMessagesAfterBeingRead: boolean read GetDeleteMessagesAfterBeingRead write SetDeleteMessagesAfterBeingRead;
    property FontName: string read GetFontName write SetFontName;
    property HideOnStart: boolean read GetHideOnStart write SetHideOnStart;
    property MinimizeTotray: boolean read GetMinimizeTotray write SetMinimizeTotray;
    property NotifySound: boolean read GetNotifySound write SetNotifySound;
    property NotifySoundFileName: string read GetNotifySoundFileName write SetNotifySoundFileName;
    property PopupBottomColor: TColor read GetPopupBottomColor write SetPopupBottomColor;
    property PopupDeleteOnOpen: boolean read GetPopupDeleteOnOpen write SetPopupDeleteOnOpen;
    property PopupDuration: integer read GetPopupDuration write SetPopupDuration;
    property PopupLinkColor: TColor read GetPopupLinkColor write SetPopupLinkColor;
    property PopupPopup: boolean read GetPopupPopup write SetPopupPopup;
    property PopupTextColor: TColor read GetPopupTextColor write SetPopupTextColor;
    property PopupTopColor: TColor read GetPopupTopColor write SetPopupTopColor;
    property StartWithWindows: boolean read GetStartWithWindows write SetStartWithWindows;
    property TrackerInterval: integer read GetTrackerInterval write SetTrackerInterval;
    property UseTDeXHint: boolean read GetUseTDeXHint write SetUseTDeXHint;
  end;

implementation

{$R *.dfm}

uses
  MMSystem;

procedure TSettingsForm.OKActionExecute(Sender: TObject);
begin
  Settings.SettingsForm.ActivePage := ButtonGroup.ItemIndex;
//general
  Settings.MainForm.TabBar.AlignToTop := AlignTabbarToTop;
  Settings.MinimizeToTray := MinimizeTotray;
  Settings.CloseToTray := CloseToTray;
  Settings.HideOnStart := HideOnStart;
//  Settings.UseTDeXHint := UseTDeXHint;
  Settings.AutoStart := StartWithWindows;
  Settings.FontName := FontName;
  Settings.MainForm.Site.ColorStyle := ColorStyle;
//messages
  Settings.MainForm.Forum.DeleteNodesAfterAddingToFavorites := DeleteNodesAfterAddingTofavorites;
  Settings.MainForm.ConfirmMultipleItemsDeletion := ConfirmMultipleItemsDeletion;
  Settings.MainForm.Favorites.ConfirmGroupDeletion := ConfirmGroupDeletion;
  Settings.MainForm.DeleteItemsAfterBeingRead := DeleteMessagesAfterBeingRead;
//Popup
  Settings.Popup.Popup := PopupPopup;
  Settings.Popup.DeleteOnOpen := PopupDeleteOnOpen;
  Settings.Popup.Duration := PopupDuration;
  Settings.Popup.TopColor := PopupTopColor;
  Settings.Popup.BottomColor := PopupBottomColor;
  Settings.Popup.LinkColor := PopupLinkColor;
  Settings.Popup.TextColor := PopupTextColor;
//tracker
  Settings.Tracker.Interval := TrackerInterval;
  Settings.NotifySound.Enabled := NotifySound;
  Settings.NotifySound.FileName := NotifySoundFileName;
  Settings.AutoSave := AutoSave;
  ModalResult := mrOk;
end;

procedure TSettingsForm.CancelActionExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSettingsForm.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  DeleteButton.Enabled := NamesList.SelCount > 0;
  PlaySoundButton.Enabled := SoundEdit.Text <> '';
  UseTDeXHintCheck.Checked := true;
  UseTDeXHintCheck.Enabled := false;
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
var
  Index: integer;
begin
  for Index := 0 to Pred(PageControl.PageCount) do
    PageControl.Pages[Index].TabVisible := false;
  Index := Settings.SettingsForm.ActivePage;
  if (Index < 0) or (Index > Buttongroup.Items.Count) then
    Index := 0;
  ButtonGroup.ItemIndex := Index;
  ButtonGroupButtonClicked(ButtonGroup, 0);
end;

procedure TSettingsForm.ButtonGroupButtonClicked(Sender: TObject; Index: Integer);
begin
  ActiveControl := PageControl;
  PageControl.ActivePageIndex := Index;
end;

procedure TSettingsForm.DeleteButtonClick(Sender: TObject);
begin
  NamesList.DeleteSelected;
end;

procedure TSettingsForm.SpeedButton1Click(Sender: TObject);
begin
  OpenSoundDialog.FileName := SoundEdit.Text;
  if OpenSoundDialog.Execute then
    SoundEdit.Text := OpenSoundDialog.FileName;
end;

procedure TSettingsForm.PlaySoundButtonClick(Sender: TObject);
begin
  sndPlaySound(pChar(SoundEdit.Text), SND_ASYNC)
end;

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  AlignTabbarToTop := Settings.MainForm.TabBar.AlignToTop;
  MinimizeTotray := Settings.MinimizeToTray;
  CloseToTray := Settings.CloseToTray;
  HideOnStart := Settings.HideOnStart;
//  UseTDeXHint := Settings.UseTDeXHint;
  DeleteNodesAfterAddingTofavorites := Settings.MainForm.Forum.DeleteNodesAfterAddingToFavorites;
  StartWithWindows := Settings.AutoStart;
  ConfirmMultipleItemsDeletion := Settings.MainForm.ConfirmMultipleItemsDeletion;
  ConfirmGroupDeletion := Settings.mainForm.Favorites.ConfirmGroupDeletion;
  DeleteMessagesAfterBeingRead := Settings.MainForm.DeleteItemsAfterBeingRead;
  ColorStyle := Settings.mainForm.Site.ColorStyle;
  PopupPopup := Settings.Popup.Popup;
  PopupDeleteOnOpen := Settings.Popup.DeleteOnOpen;
  PopupDuration := Settings.Popup.Duration;
  PopupTopColor := Settings.Popup.TopColor;
  PopupBottomColor := Settings.Popup.BottomColor;
  PopupLinkColor := Settings.Popup.LinkColor;
  PopupTextColor := Settings.Popup.TextColor;
  TrackerInterval := Settings.Tracker.Interval;
  NotifySound := Settings.NotifySound.Enabled;
  NotifySoundFileName := Settings.NotifySound.FileName;
  AutoSave := Settings.AutoSave;
  FontName := Settings.FontName;
  Settings.Tracker.AssignIgnoreUsersTo(NamesList.Items);
  ButtonGroupButtonClicked(Buttongroup, Settings.SettingsForm.ActivePage);
  Left := Settings.SettingsForm.Left;
  Top := Settings.SettingsForm.Top;
end;

procedure TSettingsForm.NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    AddButton.Click;
end;

procedure TSettingsForm.NamesListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) or (Key = VK_BACK) then
    DeleteButton.Click;
end;

procedure TSettingsForm.FontComboboxChange(Sender: TObject);
begin
  PreviewLabel.Font.Name := FontCombobox.FontName;
end;

procedure TSettingsForm.FormDestroy(Sender: TObject);
begin
  Settings.SettingsForm.Left := Left;
  Settings.SettingsForm.Top := Top;
  Settings.Tracker.AssignIgnoreUsers(NamesList.Items);
end;

procedure TSettingsForm.TestPopupButtonClick(Sender: TObject);
begin
  Notifier.TopColor := PopupTopColor;
  Notifier.BottomColor := PopupBottomColor;
  Notifier.LinkColor := PopupLinkColor;
  Notifier.TextColor := PopupTextColor;
  Notifier.Timeout := PopupDuration;
  Notifier.Execute('Dit is een voorbeeld van de DeX popup.', 'Klik hier om naar de site te gaan.', Settings.SiteURL);
end;

procedure TSettingsForm.AddActionExecute(Sender: TObject);
begin
  if NamesList.Items.IndexOf(NameEdit.Text) = -1 then
    NamesList.Items.Add(NameEdit.Text);
  NameEdit.Clear;
  NameEdit.SetFocus;
end;

procedure TSettingsForm.AddActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Length(Trim(NameEdit.Text)) > 0;
end;

procedure TSettingsForm.ClearButtonClick(Sender: TObject);
begin
  NamesList.Clear;
end;

procedure TSettingsForm.SetPopupLinkColor(const Value: TColor);
begin
  LinkColorBox.Selected := Value;
end;

procedure TSettingsForm.SetMinimizeTotray(const Value: boolean);
begin
  MinimizeToTrayCheck.Checked := Value;
end;

procedure TSettingsForm.SetColorStyle(const Value: TColorStyle);
begin
  SiteColorsGroup.ItemIndex := Ord(value);
end;

procedure TSettingsForm.SetPopupBottomColor(const Value: TColor);
begin
  BottomColorBox.Selected := Value;
end;

procedure TSettingsForm.SetConfirmGroupDeletion(const Value: boolean);
begin
  GroupDeletionCheck.Checked := Value;
end;

procedure TSettingsForm.SetConfirmMultipleItemsDeletion(const Value: boolean);
begin
  MultipleItemsDeletionCheck.Checked := Value;
end;

procedure TSettingsForm.SetNotifySound(const Value: boolean);
begin
  PlaySoundCheck.Checked := Value;
end;

procedure TSettingsForm.SetNotifySoundFileName(const Value: string);
begin
  SoundEdit.Text := Value;
end;

procedure TSettingsForm.SetUseTDeXHint(const Value: boolean);
begin
  UseTDeXHintCheck.Checked := Value;
end;

procedure TSettingsForm.SetFontName(const Value: string);
begin
  FontCombobox.Fontname := FontCombobox.Items[FontCombobox.Items.IndexOf(Value)];
  if FontCombobox.FontName = '' then
    FontCombobox.FontName := Value;
  FontComboboxChange(FontCombobox);
end;

procedure TSettingsForm.SetDeleteNodesAfterAddingTofavorites(const Value: boolean);
begin
  DeleteItemsCheck.Checked := Value;
end;

procedure TSettingsForm.SetAlignTabbarToTop(const Value: boolean);
begin
  AlignTabbarToTopCheck.Checked := Value;
end;

procedure TSettingsForm.SetPopupTextColor(const Value: TColor);
begin
  TextColorbox.Selected := Value;
end;

procedure TSettingsForm.SetPopupTopColor(const Value: TColor);
begin
  TopColorBox.Selected := Value;
end;

procedure TSettingsForm.SetAutoSave(const Value: boolean);
begin
  AutoSaveCheck.Checked := Value;
end;

procedure TSettingsForm.SetStartWithWindows(const Value: boolean);
begin
  StartWithWindowsCheck.Checked := Value;
end;

procedure TSettingsForm.SetPopupPopup(const Value: boolean);
begin
  ShowPopupCheck.Checked := Value;
end;

procedure TSettingsForm.SetPopupDeleteOnOpen(const Value: boolean);
begin
  DeleteMessageCheck.Checked := Value;
end;

procedure TSettingsForm.SetTrackerInterval(const Value: integer);
begin
  IntervalEdit.AsInteger := Value;
end;

procedure TSettingsForm.SetPopupDuration(const Value: integer);
begin
  DurationEdit.AsInteger := Value;
end;

function TSettingsForm.GetPopupLinkColor: TColor;
begin
  Result := LinkColorBox.Selected;
end;

function TSettingsForm.GetMinimizeTotray: boolean;
begin
  Result := MinimizeToTrayCheck.Checked;
end;

function TSettingsForm.GetColorStyle: TColorStyle;
begin
  Result := TColorStyle(SiteColorsGroup.ItemIndex);
end;

function TSettingsForm.GetPopupBottomColor: TColor;
begin
  Result := BottomColorBox.Selected;
end;

function TSettingsForm.GetConfirmGroupDeletion: boolean;
begin
  Result := GroupDeletionCheck.Checked;
end;

function TSettingsForm.GetConfirmMultipleItemsDeletion: boolean;
begin
  Result := MultipleItemsDeletionCheck.Checked;
end;

function TSettingsForm.GetNotifySound: boolean;
begin
  Result := PlaySoundCheck.Checked;
end;

function TSettingsForm.GetNotifySoundFileName: string;
begin
  Result := SoundEdit.Text;
end;

function TSettingsForm.GetUseTDeXHint: boolean;
begin
  Result := UseTDeXHintCheck.Checked;
end;

function TSettingsForm.GetFontName: string;
begin
  Result := FontCombobox.FontName;
end;

function TSettingsForm.GetDeleteNodesAfterAddingTofavorites: boolean;
begin
  Result := DeleteItemsCheck.Checked;
end;

function TSettingsForm.GetAlignTabbarToTop: boolean;
begin
  Result := AlignTabbarToTopCheck.Checked;
end;

function TSettingsForm.GetPopupTextColor: TColor;
begin
  Result := TextColorbox.Selected;
end;

function TSettingsForm.GetPopupTopColor: TColor;
begin
  Result := TopColorBox.Selected;
end;

function TSettingsForm.GetAutoSave: boolean;
begin
  Result := AutoSaveCheck.Checked;
end;

function TSettingsForm.GetStartWithWindows: boolean;
begin
  Result := StartWithWindowsCheck.Checked;
end;

function TSettingsForm.GetPopupPopup: boolean;
begin
  Result := ShowPopupCheck.Checked;
end;

function TSettingsForm.GetPopupDeleteOnOpen: boolean;
begin
  Result := DeleteMessageCheck.Checked;
end;

function TSettingsForm.GetTrackerInterval: integer;
begin
  Result := IntervalEdit.AsInteger;
end;

function TSettingsForm.GetPopupDuration: integer;
begin
  Result := DurationEdit.AsInteger;
end;

procedure TSettingsForm.SetDeleteMessagesAfterBeingRead(const Value: boolean);
begin
  DeleteMessagesAfterBeingReadCheck.Checked := Value;
end;

function TSettingsForm.GetDeleteMessagesAfterBeingRead: boolean;
begin
  Result := DeleteMessagesAfterBeingReadCheck.Checked;
end;

function TSettingsForm.GetCloseToTray: boolean;
begin
  Result := CloseToTrayCheck.Checked;
end;

procedure TSettingsForm.SetCloseToTray(const Value: boolean);
begin
  CloseToTrayCheck.Checked := Value;
end;

function TSettingsForm.GetHideOnStart: boolean;
begin
  Result := HideOnStartCheck.Checked;
end;

procedure TSettingsForm.SetHideOnStart(const Value: boolean);
begin
  HideOnStartCheck.Checked := Value;
end;

end.
