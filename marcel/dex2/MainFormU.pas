unit MainFormU;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, StdCtrls,
  Controls, Forms, ComCtrls, ActnList, ImgList, ExtCtrls, Menus,
  AppEvnts, JvTrayIcon, ActnMan,
  ActnCtrls, JvImage, ToolWin, ActnMenus,
  DeXSettingsU, XMLDoc, JvComponent, JvGIF,
  NLDXMLIntf, NLDXMLData, JvLookOut, DeXTree, NLDNotifier,
  XPStyleActnCtrls, VirtualTrees ;

type
  TMainForm = class(TForm)
    ForumList: TDeXTree;
    ActionManager: TActionManager;
    TrayIcon: TJvTrayIcon;
    Tracker: TNLDXMLData;
    ApplicationEvents: TApplicationEvents;
    FetchDataAction: TAction;
    DeleteAction: TAction;
    DeleteThreadAction: TAction;
    Notifier: TNLDNotifier;
    ActionMainMenuBar1: TActionMainMenuBar;
    CloseAction: TAction;
    OpenAction: TAction;
    InfoAction: TAction;
    StatusBar: TStatusBar;
    SettingsAction: TAction;
    TrayPop: TPopupMenu;
    Ophalenvanaf1: TMenuItem;
    Afsluiten1: TMenuItem;
    Instellingen1: TMenuItem;
    N1: TMenuItem;
    StartupTimer: TTimer;
    HideAction: TAction;
    SaveAction: TAction;
    ActionImages: TImageList;
    DeletePop: TPopupMenu;
    Verwijderen1: TMenuItem;
    Verwijderthread1: TMenuItem;
    ActionToolBar1: TActionToolBar;
    Image1: TImage;
    Panel1: TPanel;
    LoginAction: TAction;
    PostImages: TImageList;
    PageControl: TPageControl;
    ForumSheet: TTabSheet;
    PMSheet: TTabSheet;
    LinkSheet: TTabSheet;
    NewsSheet: TTabSheet;
    PMList: TDeXTree;
    LinkList: TDeXTree;
    NewsList: TDeXTree;
    TabSheet1: TTabSheet;
    ForumTree: TTreeView;
    procedure TrackerNewData(Sender: TObject;
      NewData: IXMLNLDelphiDataType);
    procedure TrayIconLeftButtonDown(Sender: TObject);
    procedure FetchDataActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure ForumListDblClick(Sender: TObject);
    procedure DeleteThreadActionExecute(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure OpenActionExecute(Sender: TObject);
    procedure ActionManagerUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure InfoActionExecute(Sender: TObject);
    procedure TrackerError(Sender: TObject; const Error: String);
    procedure TrackerDataChange(Sender: TObject);
    procedure TrackerBeforeUpdate(Sender: TObject);
    procedure TrackerAfterUpdate(Sender: TObject);
    procedure SettingsActionExecute(Sender: TObject);
    procedure StartupTimerTimer(Sender: TObject);
    procedure TrayIconRightButtonDown(Sender: TObject);
    procedure HideActionExecute(Sender: TObject);
    procedure NotifierClick(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure ForumListData(Sender: TObject; Item: TListItem);
    procedure Image1Click(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LoginActionExecute(Sender: TObject);
    procedure ForumListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure ForumListHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ForumListFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure ForumListGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PMListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure PMListFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure PMListDblClick(Sender: TObject);
    procedure LinkListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure LinkListFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure LinkListDblClick(Sender: TObject);
    procedure NewsListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure NewsListDblClick(Sender: TObject);
    procedure NewsListFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure ForumTreeDblClick(Sender: TObject);
  private
    FIcon: TIcon;
    FLoading: Boolean;
    FSettings: IXMLSettingsType;
    FSaved: Boolean;
    FClosing: Boolean;
    FUpdating: Boolean;
    FBaseUrl: string;
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession);
      message WM_QUERYENDSESSION;
    procedure UpdateData;
    procedure Notify(NewData: IXMLNLDelphiDataType);
    procedure UpdateIcon;
    procedure ExecuteItem;
    function XMLFileName: string;
    function PMURL(PMID: Integer): string;
    function PostURL(PostID: Integer): string;
    function LinkURL(Link: IXMLLinkType): string;
    function NewsURL(News: IXMLNewsType): string;
    function SettingsFile: string;
    procedure Save;
    procedure InitSettings;
    procedure Init;
    procedure ToggleVisible;
    procedure DoLogin(ForceNew: Boolean = False);
    procedure Sort(SortType: TSortType; Direction: Integer);
    procedure InitForumTree;
    function ForumURL(ForumID: Integer): string;
    function GetBaseUrl: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CloseQuery: Boolean; override;

    property BaseUrl: string read GetBaseUrl;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  JclGraphics, DateUtils, FetchDateTimeFormU, AboutFormU,
{$IFDEF Log}
  UDbg,
{$ENDIF}
  SettingsFormU, XMLIntf, MMSystem,  JclFileUtils, LoginFormU, Dialogs,
  ShellAPI;

{ Geleend uit (een oude versie van) JVCL }
function OpenObject(Value: string): Boolean;
begin
  Result := ShellExecute(0, 'open', PChar(Value), nil, nil, SW_SHOWNORMAL) > HINSTANCE_ERROR;
end;

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited;
  { Icon kopieren zodat we die later op de trayicon kunnen tekenen }
  FIcon := TIcon.Create;
  FIcon.Assign(TrayIcon.Icon);

  with TJclFileVersionInfo.Create(Application.ExeName) do
  begin
    Tracker.UserAgent := 'DeX [' + FileVersion + ']';
  end;

  PageControl.ActivePageIndex := 0;
end;

procedure TMainForm.TrackerNewData(Sender: TObject;
  NewData: IXMLNLDelphiDataType);
begin
  Notify(NewData);
end;

{ Data wordt opnieuw ingelezen van de interface naar de listview }
procedure TMainForm.UpdateData;
  procedure UpdateSheet(Sheet: TTabSheet; Caption: string; Count: Integer);
  begin
    if Count = 0 then
      Sheet.Caption := Caption
    else
      Sheet.Caption := Format('%s [%d]', [Caption, Count]);
  end;

begin
{$IFDEF Log}
  Debugger.EnterProc('TMainForm.UpdateData');
  Debugger.AddCheckPoint('UpdateData');
{$ENDIF}

  FUpdating := True;
  try
    ForumList.RootNodeCount := Tracker.Posts.Count;
    PMList.RootNodeCount := Tracker.Data.PM.Count;
    LinkList.RootNodeCount := Tracker.Data.Link.Count;
    NewsList.RootNodeCount := Tracker.Data.News.Count;

    UpdateIcon;
{$IFDEF Log}
    Debugger.LeaveProc('TMainForm.UpdateData');
{$ENDIF}

    if not FLoading then
    begin
      FSaved := False;
      if FSettings.AutoSave then
        Save;
    end;

    UpdateSheet(ForumSheet, 'Forum', Tracker.Posts.Count);
    UpdateSheet(PMSheet, 'PM', Tracker.Data.PM.Count);
    UpdateSheet(LinkSheet, 'Link', Tracker.Data.Link.Count);
    UpdateSheet(NewsSheet, 'Nieuws', Tracker.Data.News.Count);
  finally
    FUpdating := False;
  end;
end;

{ Trayicon wordt opnieuw getekend met het aantal items in de lijst }
procedure TMainForm.UpdateIcon;
var
  BMP: TBitmap;
  IconText: string;
begin
  TrayIcon.Icon.Assign(FIcon);

  BMP := TBitmap.Create;
  try
    BMP.Handle := jclGraphics.IconToBitmap(TrayIcon.Icon.Handle);
    BMP.Transparent := False;

    BMP.Canvas.Font.Name := 'Small Fonts';
    BMP.Canvas.Font.Size := 7;
    BMP.Canvas.Pixels[0,31] := clBlack;

    if ForumList.RootNodeCount < 1000 then
      IconText := IntToStr(ForumList.RootNodeCount)
    else
      IconText := 'X';

    TrayIcon.Hint := Format('%d bericht(en) in de lijst',
      [ForumList.RootNodeCount]);

    SetBkMode(BMP.Canvas.Handle, TRANSPARENT);
    BMP.Canvas.TextOut(1, 3, IconText);

    TrayIcon.Icon.Handle := BitmapToIcon(BMP.Handle, 16, 16);
  finally
    BMP.Free;
  end;
end;

{ Geselecteerde item wordt geopend in browser }
procedure TMainForm.ExecuteItem;
begin
  if ForumList.Focused then
  begin
    if (ForumList.FocusedNode = nil) then
      Exit;

    OpenObject(PostURL(Tracker.Posts[ForumList.FocusedNode.Index].Post.ID));
  end
  else if PMList.Focused then
  begin
    if (PMList.FocusedNode = nil) then
      Exit;

    OpenObject(PMURL(Tracker.Data.PM[PMList.FocusedNode.Index].ID));
  end
  else if LinkList.Focused then
  begin
    if (LinkList.FocusedNode = nil) then
      Exit;

    OpenObject(LinkURL(Tracker.Data.Link[LinkList.FocusedNode.Index]));
  end
  else if NewsList.Focused then
  begin
    if (NewsList.FocusedNode = nil) then
      Exit;

    OpenObject(NewsURL(Tracker.Data.News[NewsList.FocusedNode.Index]));
  end;
end;

{ Klik op de trayicon, programma verbergen of laten zien }
procedure TMainForm.TrayIconLeftButtonDown(Sender: TObject);
begin
  ToggleVisible;
end;

{ Met TFetchDateTimeForm wordt datum/tijd gevraagd en items vanaf dat tijdstip
  worden opgehaald }
procedure TMainForm.FetchDataActionExecute(Sender: TObject);
begin
  with TFetchDateTimeForm.Create(Self) do
  try
    if ShowModal = mrOK then
      Tracker.Update(DateTime);
  finally
    Free;
  end;
end;

{ Geselecteerde items worden verwijderd }
procedure TMainForm.DeleteActionExecute(Sender: TObject);
begin
  Tracker.BeginUpdate;
  try
  if Screen.ActiveControl is TDeXTree then
    with TDeXTree(Screen.ActiveControl) do
      DeleteSelectedNodes;
  finally
    Tracker.EndUpdate;
  end;
end;

{ XML Bestandsnaam is executable, maar dan met een XML extensie }
function TMainForm.XMLFileName: string;
begin
  Result := ChangeFileExt(Application.ExeName, '.xml');
end;

procedure TMainForm.ForumListDblClick(Sender: TObject);
begin
  ExecuteItem;
end;

{ Geselecteerde threads worden verwijderd}
procedure TMainForm.DeleteThreadActionExecute(Sender: TObject);
begin
  Tracker.DeleteThread(Tracker.Posts[ForumList.FocusedNode.Index].Post);
end;

{ Retourneerde de te openen URL aan de hand van de threadid }
function TMainForm.PostURL(PostID: Integer): string;
begin
  Result := BaseUrl + '/forum/showthread.php?s=&postid=' +
    IntToStr(PostID) + '#post' + IntToStr(PostID);
end;

function TMainForm.ForumURL(ForumID: Integer): string;
begin
  Result := BaseUrl + '/forum/forumdisplay.php?s=&forumid=' +
    IntToStr(ForumID);
end;

procedure TMainForm.CloseActionExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.OpenActionExecute(Sender: TObject);
begin
  ExecuteItem;
end;

procedure TMainForm.ActionManagerUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  if Screen.ActiveControl is TDeXTree then
    with TDeXTree(Screen.ActiveControl) do
    begin
      DeleteAction.Enabled :=  SelectedCount > 0;
      OpenAction.Enabled :=  SelectedCount > 0;
    end;

  DeleteThreadAction.Enabled :=
    ForumList.Focused and (ForumList.SelectedCount = 1);

  FetchDataAction.Enabled := Tracker.Connected;

  SaveAction.Enabled := not FSaved;
  LoginAction.Enabled := True;
end;

procedure TMainForm.InfoActionExecute(Sender: TObject);
begin
  with TAboutForm.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

destructor TMainForm.Destroy;
begin
  FIcon.Free;
  inherited;
end;

procedure TMainForm.TrackerError(Sender: TObject; const Error: String);
begin
  Notifier.Execute(Error);
end;

procedure TMainForm.TrackerDataChange(Sender: TObject);
begin
  UpdateData;
end;

procedure TMainForm.Notify(NewData: IXMLNLDelphiDataType);
var
  i, ForumIndex, ThreadIndex, PostIndex: Integer;
  Forum: IXMLForumType;
  Thread: IXMLThreadType;
  Post: IXMLPostType;
begin
  if NewData.RowCount > 10 then
    Notifier.Execute(Format('Er zijn %d nieuwe berichten', [NewData.RowCount]))
  else
    for ForumIndex := 0 to NewData.Forum.Count - 1 do
    begin
      Forum := NewData.Forum[ForumIndex];
      for ThreadIndex := 0 to Forum.Thread.Count -1 do
      begin
        Thread := Forum.Thread[ThreadIndex];
        for PostIndex := 0 to Thread.Post.Count - 1 do
        begin
          Post := Thread.Post[PostIndex];
          Notifier.Execute(Format('Nieuw bericht van %s op %s: %s',
            [Post.Member.Name, Forum.Title, Thread.Title]),
            PostURL(Post.ID),
            Post.ID);
          Application.ProcessMessages;
        end;
      end;
    end;

  for i := 0 to NewData.PM.Count - 1 do
  begin
    Notifier.Execute(Format('Nieuwe PM van %s: %s.',
      [NewData.PM[i].Member.Name,
       NewData.PM[i].Title]),
       PMURL(NewData.PM[i].ID));
  end;


  for i := 0 to NewData.Link.Count - 1 do
  begin
    Notifier.Execute(Format('Nieuwe Link: %s',
      [NewData.Link[i].Title]));
  end;

  if NewData.RowCount > 0 then
  begin
    if FSettings.NotifySound.Enabled then
      sndPlaySound(PChar(string(FSettings.NotifySound.FileName)), 0);
  end;
end;

procedure TMainForm.TrackerBeforeUpdate(Sender: TObject);
begin
  StatusBar.Panels[0].Text := 'Gegevens worden opgehaald...';
  Application.ProcessMessages;
end;

procedure TMainForm.TrackerAfterUpdate(Sender: TObject);
begin
  StatusBar.Panels[0].Text := '';
end;

{ Bestand wordt opgeslagen }
function TMainForm.CloseQuery: Boolean;
begin
  Result := inherited CloseQuery;

  if Result then
    Save;
end;

function TMainForm.SettingsFile: string;
begin
  Result := ExtractFileDir(Application.ExeName) + '\Settings.xml';
end;

procedure TMainForm.InitSettings;
var
  Color: LongInt;
begin
  if FSettings.Version = '' then
  begin
    FSettings.Popup.Color := 'clInfoBk';
    FSettings.Popup.Time := 5;
    FSettings.Popup.Enabled := True;

    FSettings.IgnoreSelf.Enabled := True;
    FSettings.IgnoreSelf.Username := '';

    FSettings.Version := '1.3';
  end;

  if FSettings.Version = '1.3' then
  begin
    FSettings.AutoSave := False;
    FSettings.Version := '1.4';
  end;

  if FSettings.Version = '1.4' then
  begin
    FSettings.Popup.DeleteOnClick := False;
    FSettings.Popup.TextColor := 'clInfoText';
    FSettings.Popup.LinkColor := 'clHotLight';
    FSettings.Interval := 1;
    FSettings.Version := '1.5';
  end;

  if FSettings.Version = '1.5' then
  begin
    FSettings.NotifySound.Enabled := False;
    FSettings.NotifySound.FileName := '';
    FSettings.Version := '1.6';
  end;

  if FSettings.Version = '1.6' then
  begin
    FSettings.User.Name := '';
    FSettings.User.Password := '';
    FSettings.Version := '2.0';
    FSettings.Sort.SortType := 0;
    FSettings.Sort.Direction := 1;
  end;

  if FSettings.SiteURL = '' then
    FSettings.SiteURL := 'http://www.nldelphi.com';

  FBaseUrl := FSettings.SiteURL;
  Tracker.URL := FBaseUrl + '/cgi-bin/xmldata2.exe/tracker2/';

  Sort(TSortType(FSettings.Sort.SortType), FSettings.Sort.Direction);

  IdentToColor(FSettings.Popup.Color, Color);
  Notifier.Color := Color;

  IdentToColor(FSettings.Popup.TextColor, Color);
  Notifier.TextColor := Color;

  IdentToColor(FSettings.Popup.LinkColor, Color);
  Notifier.LinkColor := Color;

  Notifier.Timeout := FSettings.Popup.Time;
  Notifier.Enabled := FSettings.Popup.Enabled;
  Tracker.UpdateTimer := FSettings.Interval * 60000;

  if FSettings.IgnoreSelf.Enabled then
    Tracker.IgnoreUser := FSettings.IgnoreSelf.Username
  else
    Tracker.IgnoreUser := '';
end;

procedure TMainForm.SettingsActionExecute(Sender: TObject);
begin
  with TSettingsForm.Create(Self) do
  try
    Settings := FSettings;
    if ShowModal = mrOK then
    begin
      InitSettings;
      FSaved := False;
    end;
  finally
    Free;
  end;
end;

procedure TMainForm.Save;
var
  SaveDocument: TXMLDocument;
begin
{$IFDEF Log}
  Debugger.EnterProc('TMainForm.Save');
{$ENDIF}

  Tracker.SaveToFile(XMLFileName);

  SaveDocument := TXMLDocument.Create(self);
  try
    SaveDocument.LoadFromXML(FSettings.XML);

    if not SaveDocument.IsEmptyDoc then
    begin
      DeleteFile(SettingsFile);
      SaveDocument.SaveToFile(SettingsFile);
    end;
  finally
    SaveDocument.Free;
  end;

  FSaved := True;
{$IFDEF Log}
  Debugger.LeaveProc('TMainForm.Save');
{$ENDIF}
end;

procedure TMainForm.StartupTimerTimer(Sender: TObject);
begin
  StartupTimer.Enabled := False;
  Init;
end;

procedure TMainForm.Init;
begin
  { Lokaal bestand inlezen}
  FLoading := True;
  try
    Tracker.LoadFromFile(XMLFileName);
  finally
    FLoading := False;
  end;

  FSaved := True;

  if FileExists(SettingsFile) then
    FSettings := LoadSettings(SettingsFile)
  else
    FSettings := NewSettings;

  InitSettings;

  DoLogin;
  Tracker.Update;
end;

procedure TMainForm.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
  if not FSaved then
    Save;

  Msg.Result := 1;
end;

{ Gewoon de popup koppelen werkt niet, het menu verdwijnt dan niet als er
  buiten het menu wordt geklikt. Dankjewel PsychoMark ;) }
procedure TMainForm.TrayIconRightButtonDown(Sender: TObject);
var
  pCursor: TPoint;
begin
  GetCursorPos(pCursor);
  SetForegroundWindow(Self.Handle);
  TrayPop.Popup(pCursor.x, pCursor.y);
  SendMessage(Self.Handle, WM_NULL, 0, 0);
end;

procedure TMainForm.HideActionExecute(Sender: TObject);
begin
  ToggleVisible;
end;

procedure TMainForm.ToggleVisible;
begin
  Visible := not Visible;

  if Visible then
  begin
    Application.Restore;
    Application.BringToFront;
  end;
end;

procedure TMainForm.NotifierClick(Sender: TObject);
var
  Post: IXMLPostType;
begin
  if FSettings.Popup.DeleteOnClick and (TForm(Sender).Tag > -1) then
  begin
    Post := Tracker.FindPost(TForm(Sender).Tag);
    { TODO : DeletePost bij klik opnieuw maken }
//    Tracker.DeletePost(Post.ParentNode as IXMLThreadType, Post.ID);
  end;
end;

procedure TMainForm.SaveActionExecute(Sender: TObject);
begin
  Save;
end;

procedure TMainForm.ForumListData(Sender: TObject; Item: TListItem);
begin
  if Item.Index > Tracker.Posts.Count - 1 then
    Exit;

  Item.Caption := DateTimeToStr(UnixToDateTime(Tracker.Posts[Item.Index].DateTime));
  Item.SubItems.Add(Tracker.Posts[Item.Index].ForumName);
  Item.SubItems.Add(Tracker.Posts[Item.Index].MemberName);
  Item.SubItems.Add(Tracker.Posts[Item.Index].ThreadName);
end;

procedure TMainForm.Image1Click(Sender: TObject);
begin
  OpenObject('http://www.NLDelphi.com');
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ToggleVisible;
end;

procedure TMainForm.LoginActionExecute(Sender: TObject);
begin
  DoLogin(True);
end;

procedure TMainForm.InitForumTree;

  procedure AddForum(Index: Integer; ParentNode: TTreeNode);
  var
    Node: TTreeNode;
    j: Integer;
    ID: Integer;
    ForumInfo: IXMLForumInfoTypeList;
  begin
    ForumInfo := Tracker.Data.ForumInfo;

    Node := ForumTree.Items.AddChild(ParentNode, ForumInfo[Index].Name);

    ID := ForumInfo[Index].ID;
    Node.Data := Pointer(ID);

    for j := 0 to ForumInfo.Count - 1 do
    begin
      if ForumInfo[j].ParentID = ID then
        AddForum(j, Node);
    end;

    Node.Expand(False);
  end;

var
  i: Integer;
  ForumInfo: IXMLForumInfoTypeList;
begin
  ForumInfo := Tracker.Data.ForumInfo;

  for i := 0 to ForumInfo.Count - 1 do
  begin
    if ForumInfo[i].ParentID = -1 then
      AddForum(i, nil);
  end;

end;

procedure TMainForm.DoLogin(ForceNew: Boolean = False);
var
  s: string;
  LoginForm: TLoginForm;
begin

  if ForceNew or (not Tracker.Login(FSettings.User.Name,
    FSettings.User.Password, FSettings.User.Location, s)) then
  begin
    LoginForm := TLoginForm.Create(Self);
    try
      repeat
        LoginForm.UserName := FSettings.User.Name;
        LoginForm.Location := FSettings.User.Location;

        if LoginForm.ShowModal <> mrOK then
          Exit;

        Tracker.Disconnect;
        s := '';

        if not Tracker.Login(LoginForm.UserName, LoginForm.Password,
          LoginForm.Location, s) then
          if MessageDlg(s + #13#10 + 'Nogmaals proberen?',
            mtConfirmation, [mbYes,mbNo], 0) <> mrYes then
            Exit;
      until Tracker.Connected;

      if Tracker.Connected then
      begin
        FSettings.User.Name := LoginForm.UserName;
        FSettings.User.Location := LoginForm.Location;

        if LoginForm.SavePassword then
          FSettings.User.Password := LoginForm.Password
        else
          FSettings.User.Password := '';
      end;
    finally
      LoginForm.Free;
    end;
  end;

  if Tracker.Connected then
  begin
    Caption := 'NLDelphi XML client (' + FSettings.User.Name;

    if FSettings.User.Location <> '' then
      Caption := Caption + '@' + FSettings.User.Location;

    Caption := Caption + ')';
    InitForumTree;
  end;
end;

procedure TMainForm.ForumListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
begin
  if Column = 0 then
    CellText := DateTimeToStr(UnixToDateTime(Tracker.Posts[Node.Index].DateTime))
  else if Column = 1 then
    CellText := Tracker.Posts[Node.Index].ForumName
  else if Column = 2 then
    CellText := Tracker.Posts[Node.Index].MemberName
  else if Column = 3 then
    CellText := Tracker.Posts[Node.Index].ThreadName;
end;

procedure TMainForm.ForumListHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  SortDirection: Integer;
begin
  if TSortType(Column) = Tracker.Posts.SortType then
    SortDirection := -Tracker.Posts.SortDirection
  else
    SortDirection := 1;

  Sort(TSortType(Column), SortDirection);
end;

procedure TMainForm.Sort(SortType: TSortType; Direction: Integer);
begin
  Tracker.Posts.SortDirection := Direction;
  Tracker.Posts.SortType := SortType;
  Tracker.Posts.Sort;

  ForumList.Header.SortColumn := Ord(SortType);

  if Direction = 1 then
    ForumList.Header.SortDirection := sdAscending
  else
    ForumList.Header.SortDirection := sdDescending;

  ForumList.Invalidate;

  FSettings.Sort.SortType := Ord(SortType);
  FSettings.Sort.Direction := Direction;
end;

procedure TMainForm.ForumListFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if not (FClosing or FUpdating) then
    Tracker.DeletePost(Tracker.Posts[Node.Index].Post);
end;

procedure TMainForm.ForumListGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if Column = 0 then
    ImageIndex := Tracker.Posts[Node.Index].Post.IconID;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FClosing := True;
end;

procedure TMainForm.PMListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  PM: IXMLPMType;
begin
  PM := Tracker.Data.PM[Node.Index];

  if Column = 0 then
    CellText := DateTimeToStr(UnixToDateTime(PM.DateTime))
  else if Column = 1 then
    CellText := PM.Member.Name
  else if Column = 2 then
    CellText := PM.Title;
end;

procedure TMainForm.PMListFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if not (FClosing or FUpdating) then
    Tracker.Data.PM.Delete(Node.Index);
end;

function TMainForm.PMURL(PMID: Integer): string;
begin
  Result := BaseURL + '/forum/private.php?s=&action=show&privatemessageid=' +
    IntToStr(PMID);
end;

procedure TMainForm.PMListDblClick(Sender: TObject);
begin
  OpenAction.Execute;
end;

procedure TMainForm.LinkListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Link: IXMLLinkType;
begin
  Link := Tracker.Data.Link[Node.Index];

  if Column = 0 then
    CellText := DateTimeToStr(UnixToDateTime(Link.DateTime))
  else if Column = 1 then
    CellText := Link.Forum.Title
  else if Column = 2 then
    CellText := Link.Title;
end;

procedure TMainForm.LinkListFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if not (FClosing or FUpdating) then
    Tracker.Data.Link.Delete(Node.Index);
end;

procedure TMainForm.LinkListDblClick(Sender: TObject);
begin
  OpenAction.Execute;
end;

function TMainForm.LinkURL(Link: IXMLLinkType): string;
begin
  Result := BaseUrl +
    Format('/cgi-bin/active.exe/Links?P=%0:d&Highlight=%1:d#%1:d',
    [Link.Forum.ID, Link.ID]);
end;

procedure TMainForm.NewsListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  News: IXMLNewsType;
begin
  News := Tracker.Data.News[Node.Index];

  if Column = 0 then
    CellText := DateTimeToStr(UnixToDateTime(News.DateTime))
  else if Column = 1 then
    CellText := News.Title;
end;

procedure TMainForm.NewsListDblClick(Sender: TObject);
begin
  OpenAction.Execute;
end;

function TMainForm.NewsURL(News: IXMLNewsType): string;
begin
  Result := BaseUrl +
    Format('/nws/#%0:d',
    [News.ID]);
end;

procedure TMainForm.NewsListFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if not (FClosing or FUpdating) then
    Tracker.Data.News.Delete(Node.Index);
end;

procedure TMainForm.ForumTreeDblClick(Sender: TObject);
begin
  if ForumTree.Selected <> nil then
    OpenObject(ForumURL(Integer(ForumTree.Selected.Data)));
end;

function TMainForm.GetBaseUrl: string;
begin
  Result := FBaseUrl;
end;

end.
