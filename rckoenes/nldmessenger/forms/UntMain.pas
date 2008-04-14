{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntMain;

interface

uses
  {TSIM Units}
  UntScreenHandler, UntServer, UntConnect, UntBaseForm, UntConfig, UntRoster,
  UntJRosterNodes, JabberCOM_TLB,
  {Delphi Units}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLXForms, ExtCtrls, Menus, TntMenus, TntExtCtrls, TntForms,
  XPMan, ComCtrls, StdCtrls, TntStdCtrls, ImgList, TntControls,
  TntComCtrls, StdActns, TntStdActns, ActnList, TntActnList, NLDTrayIcon ;

type
  TFrmMain = class(TTntForm)
    MainMenu: TTntMainMenu;
    mmServer: TTntMenuItem;
    mmLogOn: TTntMenuItem;
    mmLogOff: TTntMenuItem;
    N1: TTntMenuItem;
    mmProfile: TTntMenuItem;
    N2: TTntMenuItem;
    mmExit: TTntMenuItem;
    mmView: TTntMenuItem;
    mmHelp: TTntMenuItem;
    mmShowHelp: TTntMenuItem;
    N3: TTntMenuItem;
    mmAbot: TTntMenuItem;
    mmStatus: TTntMenuItem;
    XPManifest: TXPManifest;
    ImgLsTray: TImageList;
    PopTrayIcon: TTntPopupMenu;
    N4: TTntMenuItem;
    TrayExit: TTntMenuItem;
    StatusBar: TTntStatusBar;
    N5: TTntMenuItem;
    mmStayOnTop: TTntMenuItem;
    mmOnlineOnly: TTntMenuItem;
    N6: TTntMenuItem;
    mmServerInfo: TTntMenuItem;
    PMTrayShow: TTntMenuItem;
    mmShowdebug: TTntMenuItem;
    EdtPopup: TTntPopupMenu;
    Cut1: TTntMenuItem;
    Copy1: TTntMenuItem;
    Paste1: TTntMenuItem;
    Delete1: TTntMenuItem;
    ActionListEdt: TTntActionList;
    EditCut: TTntEditCut;
    EditCopy: TTntEditCopy;
    EditPaste: TTntEditPaste;
    EditSelectAll: TTntEditSelectAll;
    EditDelete: TTntEditDelete;
    SelectAll1: TTntMenuItem;
    ImgLsAnimate: TImageList;
    mmTools: TTntMenuItem;
    N7: TTntMenuItem;
    mmSettings: TTntMenuItem;
    mmAddUser: TTntMenuItem;
    mmGroupChat: TTntMenuItem;
    stOnline: TTntAction;
    stFreeForChat: TTntAction;
    stAway: TTntAction;
    stXA: TTntAction;
    stDND: TTntAction;
    stCustom: TTntAction;
    Online1: TTntMenuItem;
    Away1: TTntMenuItem;
    FreeForChat1: TTntMenuItem;
    ExtendedAway1: TTntMenuItem;
    DoNotDisturb1: TTntMenuItem;
    Custom1: TTntMenuItem;
    TrayStatus: TTntMenuItem;
    N8: TTntMenuItem;
    Online2: TTntMenuItem;
    FreeForChat2: TTntMenuItem;
    Away2: TTntMenuItem;
    ExtendedAway2: TTntMenuItem;
    DoNotDisturb2: TTntMenuItem;
    Custom2: TTntMenuItem;
    ChangeAccount1: TTntMenuItem;
    N9: TTntMenuItem;
    mmPassword: TTntMenuItem;
    TrayIcon: TNLDTrayIcon;
    procedure TntFormLXCreate(Sender: TObject);
    procedure mmAbotClick(Sender: TObject);
    procedure mmViewClick(Sender: TObject);
    procedure mmStayOnTopClick(Sender: TObject);
    procedure mmExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TrayExitClick(Sender: TObject);
    procedure PopTrayIconPopup(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure TntFormDestroy(Sender: TObject);
    procedure mmServerInfoClick(Sender: TObject);
    procedure mmShowdebugClick(Sender: TObject);
    procedure mmSettingsClick(Sender: TObject);
    procedure mmLogOnClick(Sender: TObject);
    procedure mmLogOffClick(Sender: TObject);
    procedure mmGroupChatClick(Sender: TObject);
    procedure mmAddUserClick(Sender: TObject);
    procedure stDNDExecute(Sender: TObject);
    procedure stOnlineExecute(Sender: TObject);
    procedure stFreeForChatExecute(Sender: TObject);
    procedure stAwayExecute(Sender: TObject);
    procedure stXAExecute(Sender: TObject);
    procedure stCustomExecute(Sender: TObject);
    procedure mmOnlineOnlyClick(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure mmPasswordClick(Sender: TObject);
    procedure ChangeAccount1Click(Sender: TObject);
  private
    { Private declarations }
    SessionEnding : Boolean;
    FStayOnTop : boolean;
    Procedure SetStayOnTop(Value : boolean);
    procedure WMQueryEndSession(var Message: TMessage); message WM_QUERYENDSESSION;
  public
    { Public declarations }
    property StayOnTop : Boolean read FStayOnTop write SetStayOnTop default false;
    procedure OnlineControls(Value : Bool);
    procedure ShowConnect;
    procedure ShowRoster;
    procedure ResetConnect;
  end;

var
  FrmMain       : TFrmMain;
  ScreenHandler : TScreenHandler;
  JRoster       : TJRoster;
  ProgSettings  : TProgSettings;

implementation

uses
  UntXmlOutPut, UntBrowser, UntUtil, UntPassword, UntJabber;


{$R *.dfm}

procedure TFrmMain.TntFormLXCreate(Sender: TObject);
begin
  SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);

  JRoster := TJRoster.Create();

  ScreenHandler := TScreenHandler.Create(Self);
  ProgSettings  := TProgSettings.Create();

  //Temp. testing only
  ProgSettings.OpenSettings;

  FrmRoster := TFrmRoster.Create(self);
  FrmRoster.Parent := self;
  FrmRoster.Align := alClient;

  JRoster.Contacts.ShowOffline := False;

  SessionEnding := False;

  HintWindowClass := TTntHintWindow;

  ShowConnect;

  TrayIcon.ImageIndex := 5;

  self.Caption := Application.Title;

end;

procedure TFrmMain.mmAbotClick(Sender: TObject);
begin
  Screenhandler.ShowAbout;
end;

procedure TFrmMain.mmViewClick(Sender: TObject);
begin
  MMStayonTop.Checked := Self.StayOnTop;
  mmOnlineOnly.Checked := not ProgSettings.ShowOffline;
end;

procedure TFrmMain.mmStayOnTopClick(Sender: TObject);
begin
  Self.StayOnTop := not Self.StayOnTop;
end;



procedure TFrmMain.mmExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.WMQueryEndSession(var Message: TMessage);
{ This method is a hack. It intercepts the WM_QUERYENDSESSION message.
  This way we can decide if we want to ignore the "Close to tray" option.
  Otherwise, when selected, the option would make Windows unable to shut down. }
begin
  SessionEnding := True;
  beep;
  Message.Result := Integer(CloseQuery and CallTerminateProcs);
  inherited;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := SessionEnding;
  if not CanClose then
  begin
    self.Hide;
  end;
end;

procedure TFrmMain.TrayExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.PopTrayIconPopup(Sender: TObject);
begin
  if FrmMain.Visible then
      PMTrayShow.Caption := '&Hide'
  else
      PMTrayShow.Caption := '&Show';
end;

procedure TFrmMain.SetStayOnTop(Value: boolean);
begin
  if Value then
    With Self Do
      SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height,
                    SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE)
  else
    With Self Do
      SetWindowPos(Handle, HWND_NOTOPMOST, Left, Top, Width, Height,
                    SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

  FStayOnTop := Value;
end;

procedure TFrmMain.FormPaint(Sender: TObject);
begin
  SetZOrder(True);
end;

procedure TFrmMain.TrayIconClick(Sender: TObject);
begin
  if self.Visible then
    self.show;
end;

procedure TFrmMain.ShowConnect;
begin
   if not assigned(FrmConnect) then
      begin
         FrmRoster.vtRoster.Clear;
         FrmConnect := TFrmConnect.Create(self);
         FrmConnect.Parent := self;
         FrmConnect.Align := alClient;
         FrmConnect.show;
      end
   else
      FrmConnect.ResetConnect;
end;

procedure TFrmMain.ShowRoster;
begin
    if assigned(FrmConnect) then
    begin
      FrmRoster.show;
      FrmConnect.Close;
      FreeAndNil(FrmConnect);
    end;
end;

procedure TFrmMain.TntFormDestroy(Sender: TObject);
begin
  if Assigned(FrmConnect) then
    FrmConnect.Close;

  if Assigned(FrmRoster) then
    FrmRoster.Close;

  FreeAndNil(JRoster);
end;

procedure TFrmMain.mmServerInfoClick(Sender: TObject);
begin
  ScreenHandler.ShowServer;
end;

procedure TFrmMain.mmShowdebugClick(Sender: TObject);
begin
  FrmXml.show;
end;



procedure TFrmMain.mmSettingsClick(Sender: TObject);
begin
  ScreenHandler.ShowSettings;
end;

procedure TFrmMain.ResetConnect;
begin
  if assigned(FrmConnect) then
    FrmConnect.ResetConnect;
end;

procedure TFrmMain.OnlineControls(Value: Bool);
begin
  { This procedure will turn on/off some menu options
    Which can/can't be used if the user is Online/offline}
  mmLogOn.Enabled       := not Value;
  mmLogOff.Enabled      := Value;
  mmAddUser.Enabled     := Value;
  mmGroupChat.Enabled   := Value;
  mmStatus.Enabled      := Value;
  mmOnlineOnly.Enabled  := Value;
  mmPassword.Enabled    := Value;
  mmServerInfo.Enabled  := Value;
  mmSettings.Enabled    := Value;
  trayStatus.Enabled    := Value;
end;

procedure TFrmMain.mmLogOnClick(Sender: TObject);
begin
   DMJabber.JabberSession.DoConnect(false, jatAuto);
end;

procedure TFrmMain.mmLogOffClick(Sender: TObject);
begin
  DmJabber.JabberSession.DoDisconnect(False);
end;

procedure TFrmMain.mmGroupChatClick(Sender: TObject);
begin
  ScreenHandler.ShowConnectGroupChat;
end;

procedure TFrmMain.mmAddUserClick(Sender: TObject);
begin
  ScreenHandler.ShowAddUser;
end;

{ standaard status actions }

procedure TFrmMain.stOnlineExecute(Sender: TObject);
begin
  DmJabber.SetStatus( jshowNone,'Online');
end;

procedure TFrmMain.stFreeForChatExecute(Sender: TObject);
begin
  DmJabber.SetStatus( jshowChat,'Free For Chat');
end;

procedure TFrmMain.stAwayExecute(Sender: TObject);
begin
  DmJabber.SetStatus( jshowAway,'Away');
end;

procedure TFrmMain.stXAExecute(Sender: TObject);
begin
  DmJabber.SetStatus( jshowXA,'Extended Away');
end;

procedure TFrmMain.stDNDExecute(Sender: TObject);
begin
  DmJabber.SetStatus( jshowDND,'Do Not Disturb');
end;

procedure TFrmMain.stCustomExecute(Sender: TObject);
begin
  ScreenHandler.ShowChangeStatus;
end;

{ end standaard status actions }

procedure TFrmMain.mmOnlineOnlyClick(Sender: TObject);
begin
  ProgSettings.ShowOffline := not ProgSettings.ShowOffline; 
end;

procedure TFrmMain.TrayIconDblClick(Sender: TObject);
begin
  if self.Visible then
    self.Hide
  else
    self.Show;
end;


procedure TFrmMain.mmPasswordClick(Sender: TObject);
begin
  ScreenHandler.ShowPassword;
end;

procedure TFrmMain.ChangeAccount1Click(Sender: TObject);
begin
  ScreenHandler.ShowProfileManager;
end;

end.
