unit MainFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, StdCtrls, Controls, Forms, ComCtrls, ActnList, ImgList,
  ExtCtrls, Menus, AppEvnts, JvTrayIcon, ActnMan, ActnCtrls, ToolWin, ActnMenus, XMLDoc, JvComponent,
  NLDXMLIntf, NLDXMLData, DeXTree, NLDNotifier, XPStyleActnCtrls, VirtualTrees, JvComponentBase, JvTabBar,
  FavoritesUnit, XMLIntf, ActnPopup, ActiveX, StdStyleActnCtrls, Buttons, JvExStdCtrls, JvEdit;

type
  TMainForm = class(TForm)
    ForumList: TDeXTree;
    ActionManager: TActionManager;
    TrayIcon: TJvTrayIcon;
    FetchDataAction: TAction;
    DeleteAction: TAction;
    DeleteThreadAction: TAction;
    CloseAction: TAction;
    OpenAction: TAction;
    InfoAction: TAction;
    StatusBar: TStatusBar;
    SettingsAction: TAction;
    HideAction: TAction;
    SaveAction: TAction;
    ActionImagesSmallDisabled: TImageList;
    TreesPopupMenu: TPopupMenu;
    DeleteMenu: TMenuItem;
    DeleteThreadMenu: TMenuItem;
    LoginAction: TAction;
    PageControl: TPageControl;
    ForumSheet: TTabSheet;
    PMSheet: TTabSheet;
    LinkSheet: TTabSheet;
    NewsSheet: TTabSheet;
    PMList: TDeXTree;
    LinkList: TDeXTree;
    NewsList: TDeXTree;
    TabSheet1: TTabSheet;
    SiteTree: TVirtualStringTree;
    TabBar: TJvTabBar;
    ActionImagesSmall: TImageList;
    MainPanel: TPanel;
    JvModernTabBarPainter1: TJvModernTabBarPainter;
    PostImages: TImageList;
    Favorieten: TTabSheet;
    FavoritesList: TVirtualStringTree;
    ErrorTimer: TTimer;
    OpenMenu: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    AddToFavoritesAction: TAction;
    FavoritesMenu: TMenuItem;
    AddToGroupMenu: TMenuItem;
    AddToFavoritesMenu: TMenuItem;
    N5: TMenuItem;
    NewGroupAction: TAction;
    NewGroupMenu: TMenuItem;
    StatusTimer: TTimer;
    ApplicationEvents1: TApplicationEvents;
    TrayPopup: TPopupMenu;
    TrayFetchMenuItem: TMenuItem;
    TraySettingsMenuItem: TMenuItem;
    N4: TMenuItem;
    TrayCloseMenuItem: TMenuItem;
    ExpandCollapseGroupAction: TAction;
    ExpandCollapseMenu: TMenuItem;
    Notifier: TNLDNotifier;
    Tracker: TNLDXMLData;
    SelectForumTabAction: TAction;
    SelectPMTabAction: TAction;
    SelectLinkTabAction: TAction;
    SelectNewsTabAction: TAction;
    SelectFavoritesTabAction: TAction;
    SelectWebsiteTabAction: TAction;
    MainMenu1: TMainMenu;
    Server1: TMenuItem;
    Regel1: TMenuItem;
    Help1: TMenuItem;
    Info1: TMenuItem;
    Lezen1: TMenuItem;
    N1: TMenuItem;
    Verwijderen1: TMenuItem;
    Verwijderthread1: TMenuItem;
    Aanmelden1: TMenuItem;
    Ophalenvanaf1: TMenuItem;
    N6: TMenuItem;
    Opslaan1: TMenuItem;
    Bestand1: TMenuItem;
    Instellingen1: TMenuItem;
    N7: TMenuItem;
    Verbergen1: TMenuItem;
    Afsluiten1: TMenuItem;
    Toevoegen1: TMenuItem;
    TopPanel: TPanel;
    CommandsPageScroller: TPageScroller;
    CommandsToolbar: TToolBar;
    OpenToolbutton: TToolButton;
    FetchToolbutton: TToolButton;
    SaveToolbutton: TToolButton;
    DeleteToolbutton: TToolButton;
    ToolButton6: TToolButton;
    NewGroupToolbutton: TToolButton;
    ToolButton7: TToolButton;
    SettingsToolbutton: TToolButton;
    InfoToolbutton: TToolButton;
    Panel1: TPanel;
    MenuPageScroller: TPageScroller;
    MenuToolbar: TToolBar;
    ServerToolButton: TToolButton;
    FileToolbutton: TToolButton;
    NodeToolButton: TToolButton;
    HelpToolButton: TToolButton;
    SearchPanel: TPanel;
    SearchEdit: TJvEdit;
    EraseButton: TSpeedButton;
    procedure EraseButtonClick(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure ForumListIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure SecondaryDeleteActionExecute(Sender: TObject);
    procedure SelectWebsiteTabActionExecute(Sender: TObject);
    procedure SelectFavoritesTabActionExecute(Sender: TObject);
    procedure SelectNewsTabActionExecute(Sender: TObject);
    procedure SelectLinkTabActionExecute(Sender: TObject);
    procedure SelectPMTabActionExecute(Sender: TObject);
    procedure SelectForumTabActionExecute(Sender: TObject);
    procedure TreesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FavoritesListCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
      var Result: Integer);
    procedure FavoritesListHeaderClick(Sender: TVTHeader; Column: TColumnIndex; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FavoritesListContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FavoritesListExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FavoritesListCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure ExpandCollapseGroupActionExecute(Sender: TObject);
    procedure FavoritesListDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject;
      Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure FavoritesListGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure AddToFavoritesActionUpdate(Sender: TObject);
    procedure TabBarTabSelecting(Sender: TObject; Item: TJvTabBarItem; var AllowSelect: Boolean);
    procedure DeleteActionUpdate(Sender: TObject);
    procedure ApplicationEvents1ShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
    procedure FavoritesListDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      var Allowed: Boolean);
    procedure FavoritesListInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure NewGroupActionUpdate(Sender: TObject);
    procedure NewGroupActionExecute(Sender: TObject);
    procedure OpenActionUpdate(Sender: TObject);
    procedure FavoritesListEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      var Allowed: Boolean);
    procedure TreesGetPopupMenu(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; const P: TPoint;
      var AskParent: Boolean; var PopupMenu: TPopupMenu);
    procedure AddToFavoritesActionExecute(Sender: TObject);
    procedure TreesPopupMenuPopup(Sender: TObject);
    procedure FavoritesListGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure NewsListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
    procedure FavoritesListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
    procedure LinkListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
    procedure PMListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
    procedure FavoritesListPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure FavoritesListBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; CellRect: TRect);
    procedure FavoritesListNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      NewText: WideString);
    procedure FavoritesListDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState;
      Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure TabBarDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ForumListDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState;
      Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure FavoritesListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: WideString);
    procedure ErrorStatusTimerTimer(Sender: TObject);
    procedure SiteTreeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SiteTreePaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure SiteTreeBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; CellRect: TRect);
    procedure ForumListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
    procedure LinkLabelLinkClick(Sender: TObject; LinkNumber: Integer; LinkText, LinkParam: string);
    procedure SiteTreeHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
    procedure SiteTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: WideString);
    procedure SiteTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure TabBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure TrackerNewData(Sender: TObject;
      NewData: IXMLNLDelphiDataType);
    procedure FetchDataActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure TreesDblClick(Sender: TObject);
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
    procedure TrayIconRightButtonDown(Sender: TObject);
    procedure HideActionExecute(Sender: TObject);
    procedure NotifierClick(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
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
    procedure LinkListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure LinkListFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure NewsListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure NewsListFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
  private
    FIcon: TIcon;
    FLoading: Boolean;
    fStatusOutputting: boolean;
    FSaved: Boolean;
    FClosing: Boolean;
    FUpdating: Boolean;
    FBaseUrl: string;
    fSiteList: TStringList;
    fFavorites: TFavoritesList;
    fGroups: TGroupsList;
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
    procedure GroupsFavoritesDataChange(Sender: TObject);
    procedure SortFavorites(aHeader: TVTHeader);
    procedure InitSettings;
    procedure Init;
    procedure ToggleVisible;
    procedure DoLogin(ForceNew: Boolean = False);
    procedure Sort(SortType: TSortType; Direction: Integer);
    procedure InitSiteTree;
    procedure OutputStatus(const Text: string);
    procedure OutputError(const Error: string);
    function ForumURL(ForumID: Integer): string;
    function GetBaseUrl: string;
    procedure AlignTabbarToTop(AlignToTop: boolean);
    procedure AddToFavoritesGroup(aGroupID: integer);
    function ActiveTab: integer;
    function SelectedCount(FavoritesOnly: boolean): integer;
    procedure FilterNodes(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
  protected
    procedure UpdateTabBar(aTab: TJvTabBarItem; aCaption: string; aCount: integer);
    procedure WMSyscommand(var Message: TWmSysCommand); message WM_SYSCOMMAND;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function CloseQuery: Boolean; override;

    property BaseUrl: string read GetBaseUrl;
  end;

  pSiteNodeData = ^TSiteNodeData;
  TSiteNodeData = record
    ListIndex: integer;
    ID: integer;
  end;

var
  MainForm: TMainForm;


implementation

{$R *.dfm}

uses
  DateUtils, FetchDateTimeFormU, AboutFormU, SettingsFormU, MMSystem,  JclFileUtils, LoginFormU, Dialogs,
  ShellAPI, Types, GraphUtil, ContNrs, SettingsUnit, Registry, StrUtils;

const
  //tabs in tabbar
  ForumTab = 0;
  PMTab = 1;
  LinkTab = 2;
  NieuwsTab = 3;
  FavorietenTab = 4;
  WebsiteTab = 5;

  //panels in statusbar
  StatusPanel = 0;
  ErrorPanel = 1;

  //teksten in tabbar (inclusief &)!!!!
  ForumTabcaption = ' &Forum';
  PMTabCaption = ' &PM';
  LinkTabCaption = ' &Link';
  NieuwsTabCaption = ' &Nieuws';
  FavorietenTabCaption = ' F&avorieten';
  WebsiteTabCaption = ' &Website';

  //imagelist index
  CollapsedFolder = 15;
  ExpandedFolder = 16;

  //xml encoding
  xmlAmp   = '&amp;';   // &
  xmlLT    = '&lt;';    // <
  xmlGT    = '&gt;';    // >
  xmlQuote = '&quot;';  // "
  xmlApos  = '&apos;';  // '

function xmlSafeText(Txt: string): WideString;

  procedure ReplaceText(aFrom, aTo: string);
  var
    Index: integer;
  begin
    Index := 1;
    Index := PosEx(aFrom, Txt, Index);
    while Index > 0 do
    begin
      Delete(Txt, Index, Length(aFrom));
      Insert(aTo, Txt, Index);
      Index := PosEx(aFrom, Txt, Succ(Index));
    end;
  end;

begin
{
  Raar maar waar, StringReplace doet het niet, dus we maken onze eigen ReplaceText en die doet het dan wel :s
}
//  StringReplace(Txt, xmlAmp, '&', [rfReplaceAll]);
//  StringReplace(Txt, xmlLT, '<', [rfReplaceAll]);
//  StringReplace(Txt, xmlGT, '>', [rfReplaceAll]);
//  StringReplace(Txt, xmlQuote, '"', [rfReplaceAll]);
//  StringReplace(Txt, xmlAPos, '''', [rfReplaceAll]);
  ReplaceText(xmlAmp, '&');
  ReplaceText(xmlLt, '<');
  ReplaceText(xmlGT, '>');
  ReplaceText(xmlQuote, '"');
  ReplaceText(xmlApos, '''');
  Result := Txt;
end;


{ Geleend uit (een oude versie van) JVCL }
function OpenObject(Value: string): Boolean;
begin
  if Value[Length(Value)] = '/' then
    Value := Copy(Value, 1, Pred(length(Value)));
  Result := ShellExecute(0, 'open', PChar(Value), nil, nil, SW_SHOWNORMAL) > HINSTANCE_ERROR;
end;

constructor TMainForm.Create(AOwner: TComponent);

  procedure InitStatusbar;
  var
    Breedte, Index: integer;
  begin
    Breedte := Statusbar.ClientWidth;
    //-2 omdat we de breedte van het laatste panel willen zetten,
    //dat moeten we dus niet meerekenen
    for index := 0 to (Statusbar.Panels.Count - 2) do
      Dec(Breedte, StatusBar.Panels[Index].Width);
    StatusBar.Panels[pred(StatusBar.Panels.Count)].Width := Breedte;
  end;

  procedure InitPagecontrolAndTabbar;
  var
    TabIndex: integer;
  begin
    for TabIndex := 0 to Pred(Pagecontrol.PageCount) do
      TTabSheet(Pagecontrol.Pages[TabIndex]).TabVisible := false;
    PageControl.ActivePageIndex := 0;
    Tabbar.Tabs[ForumTab].Selected := true;
    TJvModernTabbarpainter(Tabbar.Painter).Color := GetHighlightColor(clBtnFace, 22)
  end;

  procedure MakeVistaReady;
  begin
    SetWindowLong(Application.Handle, GWL_EXSTYLE,
      GetWindowLong(Application.Handle, GWL_EXSTYLE) and not WS_EX_APPWINDOW
      or WS_EX_TOOLWINDOW);
  end;

  procedure SetBounds;
  begin
    Left := Settings.MainForm.Left;
    Top := Settings.MainForm.Top;
    Width := Settings.MainForm.Width;
    Height := Settings.MainForm.Height;
    WindowState := Settings.MainForm.WindowState;
  end;

begin
  inherited;
  SetWindowPos(Application.Handle, 0, High(integer), Low(integer), 0, 0, SW_SHOW);
  MakeVistaReady;

  //Hide PM tab
  Tabbar.Tabs[PMTab].Visible := false;
  PageControl.Pages[PMTab].Visible := false;

  FIcon := TIcon.Create;
  FIcon.Assign(TrayIcon.Icon);
  fSiteList := TStringList.Create;
  fGroups := TGroupsList.Create(true);
  fFavorites := TFavoritesList.Create(true);
  fGroups.OnDataChange := GroupsfavoritesDataChange;
  fGroups.LoadFromFile(XMLFileName);
  fFavorites.OnDataChange := GroupsFavoritesDataChange;
  fFavorites.LoadFromFile(XMLFileName);
  Tracker.UserAgent := 'DeX 3';
  PageControl.ActivePageIndex := ForumTab;
  InitStatusbar;
  InitPagecontrolAndTabbar;
  Init;
  InitSettings;
  SetBounds;
end;

procedure TMainForm.TrackerNewData(Sender: TObject;
  NewData: IXMLNLDelphiDataType);
begin
  Notify(NewData);
  SearchEdit.Text := Settings.SearchText;
end;

procedure TMainForm.UpdateTabBar(aTab: TJvTabBarItem; aCaption: string; aCount: integer);
begin
  if aCount = 0 then
    aTab.Caption := aCaption
  else
    aTab.Caption := Format('%s [%d]', [aCaption, aCount]);
end;

procedure TMainForm.UpdateData;
begin
  FUpdating := True;
  try
    ForumList.RootNodeCount := Tracker.Posts.Count;
    PMList.RootNodeCount := Tracker.Data.PM.Count;
    LinkList.RootNodeCount := Tracker.Data.Link.Count;
    NewsList.RootNodeCount := Tracker.Data.News.Count;
    UpdateIcon;

    if not FLoading then
    begin
      FSaved := False;
      if Settings.AutoSave then
        Save;
    end;

    UpdateTabBar(Tabbar.Tabs[ForumTab], ForumTabCaption, Tracker.Posts.Count);
    UpdateTabBar(Tabbar.Tabs[PMTab], PMTabCaption, Tracker.Data.PM.Count);
    UpdateTabBar(Tabbar.Tabs[Linktab], LinkTabCaption, Tracker.Data.Link.Count);
    UpdateTabBar(Tabbar.Tabs[NieuwsTab], NieuwsTabCaption, Tracker.Data.News.Count);
    UpdateTabBar(TabBar.Tabs[WebsiteTab], WebSiteTabCaption, 0);
  finally
    FUpdating := False;
  end;
end;

procedure TMainForm.UpdateIcon;
var
  BMP: TBitmap;
  IconText: string;
  TextLeft, TextTop: integer;
  Icon: TIcon;

  function CreateIconFromBitmap(Bitmap: TBitmap; TransparentColor: TColor): TIcon;
  begin
    with TImageList.CreateSize(Bitmap.Width, Bitmap.Height) do
    begin
      try
        AllocBy := 1;
        AddMasked(Bitmap, TransparentColor);
        Result := TIcon.Create;
        try
          GetIcon(0, Result);
        except
          Result.Free;
          raise;
        end;
      finally
        Free;
      end;
    end;
  end;

begin
  TrayIcon.Icon.Assign(FIcon);

  BMP := TBitmap.Create;
  try
    BMP.Transparent := False;
    Bmp.Width := FIcon.Width;
    Bmp.Height := fIcon.Height;
    Bmp.Canvas.Draw(0, 0, fIcon);
    BMP.Canvas.Font.Name := 'Small Fonts';
    BMP.Canvas.Font.Size := 6;
    BMP.Canvas.Pixels[0,31] := clBlack;

    if ForumList.RootNodeCount < 1000 then
      IconText := IntToStr(ForumList.RootNodeCount)
    else
    begin
      IconText := 'r'; //kruisje in sluitknop (#72)
      Bmp.Canvas.Font.Size := 9;
      Bmp.Canvas.Font.Name := 'Marlett';
    end;

    TrayIcon.Hint := Format('Dex 3'#13#10'Aantal berichten: %d ', [ForumList.RootNodeCount]);

    SetBkMode(BMP.Canvas.Handle, TRANSPARENT);

    TextLeft := (Bmp.Width - Bmp.Canvas.TextWidth(IconText)) div 2;
    textTop := (Bmp.Height - bmp.Canvas.TextHeight(IconText)) div 2;
    BMP.Canvas.TextOut(TextLeft, TextTop, IconText);

    Icon := TICon.Create;
    try
      Icon := CreateIconFromBitmap(Bmp, clFuchsia);
      TrayIcon.Icon.Assign(Icon);
    finally
      Icon.Free;
    end;
  finally
    BMP.Free;
  end;
end;

procedure TMainForm.ExecuteItem;
var
  Node: pVirtualNode;
  FavoritesNodeData: pFavoritesNodeData;
  ActieveTab: integer;
  Lijst: TVirtualStringTree;
begin
  Lijst := nil;
  ActieveTab := ActiveTab;
//Forum
  if ActieveTab = ForumTab then
  begin
    Node := ForumList.GetFirstSelected;
    while Assigned(Node) do
    begin
      OpenObject(PostURL(Tracker.Posts[Node.Index].Post.ID));
      Node := ForumList.GetNextSelected(Node);
    end;
    Lijst := ForumList;
  end
//PM
  else if ActieveTab = PMTab then
  begin
    Node := PMList.GetFirstSelected;
    while Assigned(Node) do
    begin
      OpenObject(PMURL(Tracker.Data.PM[Node.Index].ID));
      Node := PMList.GetNextSelected(Node);
    end;
    Lijst := PMList;
  end
//Link
  else if ActieveTab = LinkTab then
  begin
    Node := LinkList.GetFirstSelected;
    while Assigned(Node) do
    begin
    OpenObject(LinkURL(Tracker.Data.Link[LinkList.FocusedNode.Index]));
      Node := LinkList.GetNextSelected(Node);
    end;
    Lijst := LinkList;
  end
//Nieuws
  else if ActieveTab = NieuwsTab then
  begin
    Node := NewsList.GetFirstSelected;
    while Assigned(Node) do
    begin
    OpenObject(NewsURL(Tracker.Data.News[NewsList.FocusedNode.Index]));
      Node := NewsList.GetNextSelected(Node);
    end;
    Lijst := NewsList;
  end
//Favorieten
  else if ActieveTab = FavorietenTab then
  begin
    Node := FavoritesList.GetFirstSelected;
    while Assigned(Node) do
    begin
      FavoritesNodeData := FavoritesList.GetNodeData(Node);
      OpenObject(PostURL(fFavorites[FavoritesNodeData.ListIndex].ID));
      Node := FavoritesList.GetNextSelected(Node);
    end;
    Lijst := FavoritesList;
  end;

  if Lijst <> FavoritesList then
    if Settings.MainForm.DeleteItemsAfterBeingRead then
      Lijst.DeleteSelectedNodes;
end;

procedure TMainForm.FetchDataActionExecute(Sender: TObject);
var
  aDateTime: integer;
begin
  if TFetchDateTimeForm.FetchDateTime(aDateTime) then
    Tracker.Update(aDateTime);
end;

procedure TMainForm.DeleteActionExecute(Sender: TObject);
var
  GroupSelected, MultipleNodesSelected: boolean;

  procedure DeleteChildren(aParent: pVirtualNode);
  var
    NodeData: pFavoritesNodeData;
    Node: pVirtualNode;
  begin
    Node := FavoritesList.GetFirstChild(aParent);
    while Assigned(Node) do
    begin
      NodeData := FavoritesList.GetNodeData(Node);
      fFavorites[NodeData.ListIndex].Deleted := true;
      Node := FavoritesList.GetNextSibling(Node);
    end;
  end;

  function UserConfirmedDeletion: boolean;
  const
    Tekst: array[boolean] of string =
      ('Weet u zeker dat u deze groep(en) wil verwijderen?', 'Weet u zeker dat u deze node(s) wil verwijderen?');
  var
    NeedToAskUser: boolean;
  begin
    {
    bevestiging vragen aan gebruiker bij :
      1: Verwijderen groep
      2: verwijderen meerdere items
    }
    Result := true;
    NeedToAskUser := GroupSelected and Settings.MainForm.Favorites.ConfirmGroupDeletion;
    NeedToAskUser := NeedToAskUser or (MultipleNodesSelected and Settings.MainForm.ConfirmMultipleItemsDeletion);
    if NeedToAskUser then
      Result := Application.MessageBox(pChar(Tekst[TVirtualStringTree(ActiveControl).SelectedCount > 1]),
        pChar('Verwijderen bevestigen'), MB_YESNO) = mrYes;
  end;

  procedure CheckSelectedNodes;
  var
    NodeData: pFavoritesNodeData;
    Node: pVirtualNode;
  begin
    MultipleNodesSelected := TDeXTree(ActiveControl).SelectedCount > 1;
    if ActiveControl = FavoritesList then
    begin
      GroupSelected := false;
      MultipleNodesSelected := FavoritesList.SelectedCount > 1;
      Node := FavoritesList.GetFirstSelected;
      while Assigned(Node) do
      begin
        NodeData := FavoritesList.GetNodeData(Node);
        if NodeData.NodeType = ntGroup then
          GroupSelected := true;
        Node := FavoritesList.GetNextSelected(Node);
      end;
    end;
  end;

var
  Node: pVirtualNode;
  NodeData: pFavoritesNodeData;
begin
  if (tsEditing in FavoritesList.TreeStates) then
    Exit;
  GroupSelected := false;
  MultipleNodesSelected := false;
  Tracker.BeginUpdate;
  fGroups.BeginUpdate;
  fFavorites.BeginUpdate;
  try
    if Screen.ActiveControl is TDeXTree then
    begin
      with TDeXTree(Screen.ActiveControl) do
      begin
        MultipleNodesSelected := SelectedCount > 1;
        if UserConfirmedDeletion then
          DeleteSelectedNodes;
        if TDeXTree(Screen.ActiveControl) = ForumList then
          Tracker.Posts.Sort;
      end;
    end else if ActiveControl = FavoritesList then
    begin
      CheckSelectedNodes;
      if UserConfirmedDeletion then
      begin
        Node := FavoritesList.GetFirstSelected;
        while Assigned(Node) do
        begin
          NodeData := FavoritesList.GetNodeData(Node);
          if NodeData.NodeType = ntGroup then
          begin
            DeleteChildren(Node);
            fGroups[NodeData.ListIndex].Deleted := true;
          end else
            fFavorites[NodeData.ListIndex].Deleted := true;
          Node := FavoritesList.GetNextSelected(Node);
        end;
        FavoritesList.DeleteSelectedNodes;
      end;
    end;
  finally
    Tracker.EndUpdate;
    fGroups.EndUpdate;
    fFavorites.EndUpdate;
    UpdateTabBar(Tabbar.Tabs[FavorietenTab], FavorietenTabCaption, fFavorites.Count);
  end;
end;

function TMainForm.XMLFileName: string;
begin
  Result := ChangeFileExt(Application.ExeName, '.xml');
end;

procedure TMainForm.TreesDblClick(Sender: TObject);
begin
  OpenAction.Execute;
end;

procedure TMainForm.DeleteThreadActionExecute(Sender: TObject);
begin
  Tracker.DeleteThread(Tracker.Posts[ForumList.FocusedNode.Index].Post);
end;

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
  UpdateData;
end;

procedure TMainForm.ActionManagerUpdate(Action: TBasicAction;
  var Handled: Boolean);
const
  SelectieString = '%s: %d item(s) geselecteerd';
var
  Tekst: string;
  Aantal: integer;
begin
  Aantal := 0;
  if fStatusOutputting then
    Exit;
  DeleteThreadAction.Enabled := (ActiveTab = Forumtab) and (ForumList.SelectedCount = 1);
  FetchDataAction.Enabled := Tracker.Connected;
  EraseButton.Enabled := not SearchEdit.IsEmpty;
  SaveAction.Enabled := not FSaved;
  LoginAction.Enabled := True;
  case ActiveTab of
    ForumTab:
    begin
      Tekst := 'Forum';
      Aantal := ForumList.SelectedCount;
    end;
    PMTab:
    begin
      Tekst := 'PM';
      Aantal := PMList.SelectedCount;
    end;
    LinkTab:
    begin
      Tekst := 'Links';
      Aantal := LinkList.SelectedCount;
    end;
    NieuwsTab:
    begin
      Tekst := 'Nieuws';
      Aantal := NewsList.SelectedCount;
    end;
    FavorietenTab:
    begin
      Tekst := 'Favorieten';
      Aantal := FavoritesList.SelectedCount;
    end;
    WebsiteTab:
    begin
      OutputStatus('Kies een forum');
      Exit;
    end;
  end;
  OutputStatus(Format(SelectieString, [Tekst, Aantal]));
end;

procedure TMainForm.InfoActionExecute(Sender: TObject);
begin
  TAboutForm.ShowIt;
end;

destructor TMainForm.Destroy;

  procedure AutoStartWithWindows;
  const
    DeX = 'DeX';
    Key = 'Software\Microsoft\Windows\CurrentVersion\Run';
  var
    Registry: TRegistry;
  begin
    Registry := TRegistry.Create;
    try
      Registry.RootKey := HKEY_LOCAL_MACHINE;
      Registry.OpenKey(Key, True);
      if Settings.AutoStart then
        Registry.WriteString(DeX, Application.ExeName)
      else
      begin
        if Registry.ValueExists(DeX) then
          Registry.DeleteValue(DeX);
      end;
    finally
      Registry.CloseKey;
      Registry.Free;
    end;
  end;

begin
  fGroups.SaveToFile(XMLFileName);
  fFavorites.SaveToFile(XMLFileName);
  fGroups.Free;
  fFavorites.Free;
  fSiteList.Free;
  FIcon.Free;
  AutoStartWithWindows;
  inherited;
end;

procedure TMainForm.TrackerError(Sender: TObject; const Error: String);
begin
  OutputError(Error);
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
  Notifier.Timeout := Settings.Popup.Duration;
  Notifier.LinkColor := Settings.Popup.LinkColor;
  Notifier.TextColor := Settings.Popup.TextColor;
  Notifier.TopColor := Settings.Popup.TopColor;
  Notifier.BottomColor := Settings.Popup.BottomColor;
  if (NewData.RowCount > 0) and (Settings.Popup.Popup) then
  begin
    if NewData.RowCount > 4 {10} then
      Notifier.Execute(Format('Er zijn %d nieuwe berichten.', [NewData.RowCount]), '')
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
            Notifier.Execute(Format('Nieuw bericht van %s in %s.', [Post.Member.Name, Forum.Title]),
              XmlSafeText(Thread.Title), PostURL(Post.ID), Post.ID);
            Application.ProcessMessages;
          end;
        end;
      end;

    for i := 0 to NewData.PM.Count - 1 do
    begin
      Notifier.Execute(Format('Nieuwe PM van %s', [NewData.PM[i].Member.Name]),
         XmlSafeText(NewData.PM[i].Title), PMURL(NewData.PM[i].ID));
    end;


    for i := 0 to NewData.Link.Count - 1 do
    begin
      Notifier.Execute(Format('Nieuwe Link: %s', [XmlSafeText(NewData.Link[i].Title)]), '');;
    end;
  end;

  if NewData.RowCount > 0 then
  begin
    if Settings.NotifySound.Enabled then
      sndPlaySound(PChar(string(Settings.NotifySound.FileName)), 0);
  end;
end;

procedure TMainForm.TrackerBeforeUpdate(Sender: TObject);
begin
  OutputStatus('Gegevens worden opgehaald...');
end;

procedure TMainForm.TrackerAfterUpdate(Sender: TObject);
begin
  OutputStatus('');
  SearchEdit.Text := Settings.SearchText;
end;

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

  procedure MakeAllNodesVisible;
  var
    Node: pVirtualNode;
  begin
    Node := ForumList.GetFirst;
    while Assigned(Node) do
    begin
      ForumList.IsVisible[Node] := true;
      Node := ForumList.GetNext(Node);
    end;
  end;

begin
  FBaseUrl := Settings.SiteURL;
//  MakeAllNodesVisible;
  Tracker.URL := FBaseUrl + '/cgi-bin/xmldata2.exe/tracker2/';
  AlignTabbarToTop(Settings.MainForm.TabBar.AlignToTop);
  ForumList.Font.Name := Settings.FontName;
  PMList.Font.Name := Settings.FontName;
  LinkList.Font.Name := Settings.FontName;
  NewsList.Font.Name := Settings.FontName;
  FavoritesList.Font.Name := Settings.FontName;
  SiteTree.Font.Name := Settings.FontName;
  SiteTree.Invalidate;

  Notifier.TopColor := Settings.Popup.TopColor;
  Notifier.BottomColor := Settings.Popup.BottomColor;
  Notifier.TextColor := Settings.Popup.TextColor;
  Notifier.LinkColor := Settings.Popup.LinkColor;
  Notifier.Timeout := Settings.Popup.Duration * 1000;
  Notifier.Enabled := Settings.Popup.Popup;
  Tracker.UpdateTimer := Settings.Tracker.Interval * 60000;

  ForumList.Header.SortColumn := Settings.MainForm.ForumSorting.Column;
  ForumList.Header.SortDirection := TSortDirection(Settings.MainForm.ForumSorting.Direction);
  fFavorites.SortDirection := Settings.MainForm.FavoritesSorting.Direction;
  fFavorites.SortType := TfavoritesSortType(Settings.MainForm.FavoritesSorting.Column);
  FavoritesList.Header.SortDirection := TSortDirection(fFavorites.SortDirection);
  FavoritesList.Header.SortColumn := Ord(fFavorites.SortType);
  SortFavorites(FavoritesList.Header);
  Sort(TSortType(Settings.MainForm.ForumSorting.Column), Settings.MainForm.ForumSorting.Direction);
end;

procedure TMainForm.SettingsActionExecute(Sender: TObject);
begin
  with TSettingsForm.Create(Self) do
  try
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
  aWindowPlacement: TWindowPlacement;
  Rect: TRect;
begin
  Tracker.SaveToFile(XMLFileName);
  aWindowPlacement.length := SizeOf(TWindowPlacement);
  GetWindowPlacement(Handle, @aWindowPlacement);
  Rect := aWindowPlacement.rcNormalPosition;
  Settings.MainForm.Left := Rect.Left;
  Settings.MainForm.Top := Rect.Top;
  Settings.MainForm.Width := Rect.Right - Rect.Left;;
  Settings.MainForm.Height := Rect.Bottom - Rect.Top;
  Settings.MainForm.WindowState := WindowState;
  Settings.SaveToFile(SettingsFile);
  FSaved := True;
end;

procedure TMainForm.Init;
begin
  { Lokaal bestand inlezen}
  FLoading := True;
  try
    Settings.LoadFromFile(SettingsFile);
    FBaseUrl := Settings.SiteURL;
    Tracker.URL := FBaseUrl + '/cgi-bin/xmldata2.exe/tracker2/';
    Tracker.LoadFromFile(XMLFileName);
  finally
    FLoading := False;
  end;
  FSaved := True;
  DoLogin;
  Tracker.Update;
end;

procedure TMainForm.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
  if not FSaved then
    Save;
  Msg.Result := 1;
end;

procedure TMainForm.TrayIconRightButtonDown(Sender: TObject);
var
  pCursor: TPoint;
begin
  GetCursorPos(pCursor);
  SetForegroundWindow(Self.Handle);
  TrayPopup.Popup(pCursor.x, pCursor.y);
  SendMessage(Self.Handle, WM_NULL, 0, 0);
end;

procedure TMainForm.HideActionExecute(Sender: TObject);
begin
  ToggleVisible;
end;

procedure TMainForm.ToggleVisible;
begin
  Visible := not Visible;
  WindowState := wsMinimized;
  if Visible then
  begin
    ShowWindow(Self.Handle, SW_SHOW);
    WindowState := wsNormal;
  end;
end;

procedure TMainForm.NotifierClick(Sender: TObject);
var
  Post: IXMLPostType;
begin
  if Settings.Popup.DeleteOnOpen and (TForm(Sender).Tag > -1) then
  begin
    Post := Tracker.FindPost(TForm(Sender).Tag);
    Tracker.DeletePost(Post);
  end;
end;


procedure TMainForm.SaveActionExecute(Sender: TObject);
begin
  Save;
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

procedure TMainForm.InitSiteTree;

  procedure AddForum(Index: integer; ParentNode: pVirtualNode);
  var
    Node: pVirtualNode;
    j: integer;
    ID: integer;
    Foruminfo: IXMLForumInfoTypeList;
    NodeData: pSiteNodeData;
  begin
    ForumInfo := Tracker.Data.ForumInfo;
    ID := Foruminfo[index].ID;
    Node := SiteTree.AddChild(ParentNode);
    NodeData := SiteTree.GetNodeData(Node);
    NodeData.ListIndex := fSiteList.Add(Foruminfo[Index].Name);
    NodeData.ID := Foruminfo[Index].ID;
    for j := 0 to Pred(ForumInfo.Count) do
    begin
      if Foruminfo[j].ParentID = ID then
        AddForum(j, Node);
    end;
    SiteTree.Expanded[Node] := false;
  end;

var
  i: Integer;
  ForumInfo: IXMLForumInfoTypeList;
begin
  Sitetree.BeginUpdate;
  try
    ForumInfo := Tracker.Data.ForumInfo;
    for i := 0 to ForumInfo.Count - 1 do
    begin
      if ForumInfo[i].ParentID = -1 then
        AddForum(i, nil);
    end;
    SiteTree.FullExpand;
  finally
    SiteTree.EndUpdate;
  end;
end;

procedure TMainForm.DoLogin(ForceNew: Boolean = False);
var
  s: string;
  LoginForm: TLoginForm;
begin
  try
    try
      if (ForceNew or (not Tracker.Login(Settings.User.Name,
        Settings.User.Password, Settings.User.Location, s)))then
      begin
        LoginForm := TLoginForm.Create(Self);
        try
          repeat
            LoginForm.UserName := Settings.User.Name;
            LoginForm.Location := Settings.User.Location;
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
            Settings.User.Name := LoginForm.UserName;
            Settings.User.Location := LoginForm.Location;

            if LoginForm.SavePassword then
              Settings.User.Password := LoginForm.Password
            else
              Settings.User.Password := '';
          end;
        finally
          LoginForm.Free;
        end;
      end;
    except
      on E: Exception do
        ShowMessage(Format('Inloggen is niet gelukt.'#10'Er wordt overgeschakeld naar offline modus.'#10#13#10 +
          'Foutmelding = %s', [E.Message]));
    end;
  finally
    if Tracker.Connected then
    begin
      Caption := 'DeX 3 (' + Settings.User.Name;
      if Settings.User.Location <> '' then
        Caption := Format('%s@%s)', [Caption, Settings.User.Location]);
      InitSiteTree;
    end else
      Caption := 'DeX 3 - [offline modus]';
  end;
end;

procedure TMainForm.ForumListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
begin
  if not Sender.Showing then
    Exit;
  if Column = 0 then
    CellText := DateTimeToStr(UnixToDateTime(Tracker.Posts[Node.Index].DateTime))
  else if Column = 1 then
    CellText := Tracker.Posts[Node.Index].ForumName
  else if Column = 2 then
    CellText := Tracker.Posts[Node.Index].MemberName
  else if Column = 3 then
    CellText := XMLSafetext(Tracker.Posts[Node.Index].ThreadName);
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
    SortDirection := Tracker.Posts.SortDirection;
  Sort(TSortType(Column), SortDirection);
  Settings.MainForm.ForumSorting.Column := Column;
  Settings.MainForm.ForumSorting.Direction := SortDirection;
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
  if not Sender.Showing then
    Exit;
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
  if not Sender.Showing then
    Exit;
  PM := Tracker.Data.PM[Node.Index];

  if Column = 0 then
    CellText := DateTimeToStr(UnixToDateTime(PM.DateTime))
  else if Column = 1 then
    CellText := PM.Member.Name
  else if Column = 2 then
    CellText := XMLSafetext(PM.Title);
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

procedure TMainForm.LinkListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Link: IXMLLinkType;
begin
  if not Sender.Showing then
    Exit;
  Link := Tracker.Data.Link[Node.Index];

  if Column = 0 then
    CellText := DateTimeToStr(UnixToDateTime(Link.DateTime))
  else if Column = 1 then
    CellText := Link.Forum.Title
  else if Column = 2 then
    CellText := XMLSafetext(Link.Title);
end;

procedure TMainForm.LinkListFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if not (FClosing or FUpdating) then
    Tracker.Data.Link.Delete(Node.Index);
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
  if not Sender.Showing then
    Exit;
  News := Tracker.Data.News[Node.Index];

  if Column = 0 then
    CellText := DateTimeToStr(UnixToDateTime(News.DateTime))
  else if Column = 1 then
    CellText := XMLSafetext(News.Title);
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

function TMainForm.GetBaseUrl: string;
begin
  Result := FBaseUrl;
end;

procedure TMainForm.TabBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
begin
  PageControl.ActivePageIndex := Item.Index;
  if (Item.Index = WebsiteTab) and (SiteTree.TotalCount = 0) then
    InitSiteTree;
  fStatusOutputting := false;
  case ActiveTab of
    ForumTab: ActiveControl := ForumList;
    PMTab: ActiveControl := PMList;
    LinkTab: ActiveControl := LinkList;
    NieuwsTab: ActiveControl := NewsList;
    FavorietenTab: ActiveControl := FavoritesList;
    WebsiteTab: ActiveControl := SiteTree;
  end;
end;

procedure TMainForm.SiteTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TSiteNodeData);
end;

procedure TMainForm.SiteTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: WideString);
var
  NodeData: pSiteNodeData;
begin
  if not Sender.Showing then
    Exit;
  if not Assigned(Node) or (fSiteList.Count = 0) then
    Exit;
  NodeData := Sender.GetNodeData(Node);
  Celltext := fSiteList[NodeData.ListIndex];
end;

procedure TMainForm.SiteTreeHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);

  function GetNodePath: string;
  const
    Separator = '/'; //' > '
  var
    aNode: pVirtualNode;
    NodeData: pSiteNodeData;
  begin
    Result := '';
    aNode := NewNode;
    if not Assigned(aNode) then
      aNode := OldNode;
    repeat
      NodeData := Sender.GetNodeData(aNode);
      if not Assigned(NodeData) then
        Break;
      Result := Format('%s' + Separator  + '%s', [fSiteList[NodeData.ListIndex], Result]);
      aNode := aNode.Parent;
    until not Assigned(aNode);
    Result := Copy(Result, 1, Pred(Length(Result)));
    Result := Format('NLDelphi' + Separator + '%s', [Result]);
  end;

begin
  Sender.Cursor := crDefault;
  if Assigned(NewNode) then
    Sender.Cursor := crHandPoint;
  fStatusOutputting := true;
  OutputStatus(GetNodePath);
end;

procedure TMainForm.LinkLabelLinkClick(Sender: TObject; LinkNumber: Integer; LinkText, LinkParam: string);
begin
  OpenObject(LinkText)
end;

procedure TMainForm.AlignTabbarToTop(AlignToTop: boolean);
const
  Orientation: array[boolean] of TJvTabBarOrientation = (toBottom, toTop);
  Align: array[boolean] of TAlign = (alBottom, alTop);
begin
  Tabbar.Align := Align[AlignToTop];
  Tabbar.Orientation := Orientation[AlignToTop];
end;

procedure TMainForm.ForumListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
var
  aBitmap: TBitmap;
  TheNode: pVirtualNode;
begin
  TheNode := NewNode;
  if not Assigned(TheNode) then
    Exit;
  with DexHintData do
  begin
    DateTime := UnixToDateTime(Tracker.Posts[TheNode.Index].DateTime);
    Forumname := Tracker.Posts[TheNode.Index].ForumName;
    Threadname := XmlSafetext(Tracker.Posts[TheNode.Index].ThreadName);
    MemberName := Tracker.Posts[TheNode.Index].MemberName;
    HintType := htForum;
    aBitmap := TBitmap.Create;
    try
      PostImages.GetBitmap(Tracker.Posts[TheNode.Index].Post.IconID, aBitmap);
      Bitmap.Assign(aBitmap);
      ContainsBitmap := Tracker.Posts[TheNode.Index].Post.IconID > 0;
    finally
      aBitmap.Free;
    end;
  end;
end;

procedure TMainForm.SiteTreeBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellRect: TRect);
var
  //kleuren zoals op het forum (heb je geen zonnebril voor nodig) :D
  DonkereKleur, LichteKleur: TColor;
begin
//  NLDelphi vBulletin 3 Style
  if Settings.MainForm.Site.ColorStyle = csNLDelphiVB3Style then
  begin
    DonkereKleur := RGB(138, 137, 254);
    LichteKleur := RGB(166, 166, 255);
  end else
//  Wit Paars Style
  begin
    DonkereKleur := RGB(206, 206, 255);
    LichteKleur := RGB(234, 234, 255);
  end;
  if (Node.Parent = Sender.RootNode) then
    TargetCanvas.Brush.Color := DonkereKleur
  else if (Node <> Sender.RootNode) and (Node.ChildCount > 0) then
      TargetCanvas.Brush.Color := LichteKleur;
  TargetCanvas.FillRect(Cellrect);
end;

procedure TMainForm.SiteTreePaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
const
  FontStyle: array[boolean] of TFontStyles = ([], [fsBold]);
begin
  TargetCanvas.Font.Style := FontStyle[Node.ChildCount > 0];
  if Node = Sender.HotNode then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsUnderline];
end;

procedure TMainForm.SiteTreeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NodeData: pSiteNodeData;
  HitInfo: THitInfo;
begin
  if not (Button = mbLeft) then
    Exit;
  TBaseVirtualTree(Sender).GetHitTestInfoAt(X, Y, true, HitInfo);
  //enkel verder doen als er op de nodetekst geklikt is
  if HitInfo.HitPositions * [hiOnItemLabel] = [] then
    Exit;
  if not Assigned(HitInfo.HitNode) or (fSiteList.Count = 0) then
    Exit;
  NodeData := TBaseVirtualTree(Sender).GetNodeData(HitInfo.HitNode);
  OpenObject(ForumURL(NodeData.ID));
end;

procedure TMainForm.ErrorStatusTimerTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := false;
  if Sender = ErrorTimer then
    StatusBar.Panels[ErrorPanel].Text := ''
  else
  begin
    if not fStatusOutputting then
    begin
      StatusBar.Panels[StatusPanel].Text := '';
      ActionManager.UpdateAction(nil);
    end;
    fStatusOutputting := false;
  end;
end;

procedure TMainForm.GroupsFavoritesDataChange(Sender: TObject);

  function FindParentNode(aParentID: integer): pVirtualNode;
  var
    Node: pvirtualNode;
    NodeData: pFavoritesNodeData;
  begin
    Result := nil;
    Node := FavoritesList.GetFirstChild(nil);
    while Assigned(Node) do
    begin
      NodeData := FavoritesList.GetNodeData(Node);
      //dbl check
      if NodeData.NodeType = ntFavorite then
      begin
        Node := FavoritesList.GetNextSibling(Node);
        Continue;
      end;
      if fGroups[NodeData.ListIndex].ID = aParentID then
      begin
        Result := Node;
        Break;
      end;
      Node := FavoritesList.GetNextSibling(Node)
    end;
  end;

  procedure AddGroups;
  var
    Index: integer;
    Node: pVirtualNode;
    NodeData: pFavoritesNodeData;
  begin
    for Index := 0 to Pred(fGroups.Count) do
    begin
      if fGroups[Index].Deleted then
        Continue;
      Node := FavoritesList.AddChild(nil);
      NodeData := FavoritesList.GetNodeData(Node);
      NodeData.ListIndex := Index;
      NodeData.NodeType := ntGroup;
    end;
  end;

  procedure AddFavorite(Index: integer; ParentNode: pVirtualNode);
  const
    InsertionPlace: array[boolean] of TVTNodeAttachMode = (amAddChildFirst, amAddChildLast);
  var
    Node: pVirtualNode;
    j: integer;
    ID: integer;
    NodeData: pFavoritesNodeData;
    Favorite: TFavorite;
  begin
    Favorite := fFavorites[Index];
    if Favorite.Deleted then
      Exit;
    ID := Favorite.ID;
    Node := FavoritesList.InsertNode(ParentNode, InsertionPlace[Assigned(ParentNode)]);
    NodeData := FavoritesList.GetNodeData(Node);
    NodeData.NodeType := ntFavorite;
    NodeData.ListIndex := Index;
    for j := 0 to pred(fFavorites.Count) do
    begin
      if fFavorites[j].GroupID = ID then
        AddFavorite(j, Node);
    end;
  end;

  procedure RememberFavoritesState;
  var
    Node: pVirtualNode;
    NodeData: pFavoritesNodeData;
  begin
    Node := FavoritesList.GetFirst;
    while Assigned(Node) do
    begin
      NodeData := FavoritesList.GetNodeData(Node);
      case NodeData.NodeType of
        ntGroup:
        begin
          fGroups[NodeData.ListIndex].Selected := FavoritesList.Selected[Node];
          fGroups[NodeData.ListIndex].Expanded := FavoritesList.Expanded[Node];
        end;
        ntFavorite:
          fFavorites[NodeData.ListIndex].Selected := FavoritesList.Selected[Node]
      end;
      Node := FavoritesList.GetNext(Node);
    end;
  end;

  procedure SetfavoritesState;
  //om een of andere duistere reden moeten we de "state" zelf terugzetten,
  //want de "state" wordt niet goed gezet in OnInitNode
  var
    Node: pVirtualNode;
    NodeData: pFavoritesNodeData;
  begin
    Node := FavoritesList.GetFirst;
    while Assigned(Node) do
    begin
      NodeData := FavoritesList.GetNodeData(Node);
      case NodeData.NodeType of
        ntGroup:
        begin
          FavoritesList.Selected[Node] := fGroups[NodeData.ListIndex].Selected;
          FavoritesList.Expanded[Node] := fGroups[NodeData.ListIndex].Expanded;
        end;
        ntFavorite:
          FavoritesList.Selected[Node] :=fFavorites[NodeData.ListIndex].Selected
      end;
      Node := FavoritesList.GetNext(Node);
    end;
  end;

var
  Index: Integer;
begin
  FavoritesList.BeginUpdate;
  try
    RememberFavoritesState;
    FavoritesList.Clear;
    AddGroups;
    for Index := 0 to Pred(fFavorites.Count) do
    begin
      if fFavorites[Index].GroupID = -1 then
        AddFavorite(Index, nil)
      else
        AddFavorite(Index, FindParentNode(fFavorites[Index].GroupID));
    end;
  finally
    FavoritesList.EndUpdate;
  end;
  SetFavoritesState;
  SortFavorites(FavoritesList.Header);
  UpdateTabBar(Tabbar.Tabs[FavorietenTab], FavorietenTabCaption, fFavorites.Count);
end;

procedure TMainForm.FavoritesListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: WideString);
var
  NodeData: pFavoritesNodeData;

  procedure FillWithFavoritesData;
  begin
    CellText := '';
    if TextType = ttStatic then
      Exit;
    CellText := '';
    case Column of
      0:
        CellText := XMLSafetext(fFavorites[NodeData.ListIndex].ThreadName);
      1:
        CellText := fFavorites[NodeData.ListIndex].MemberName;
      2:
        CellText := fFavorites[NodeData.ListIndex].ForumName;
      3:
        CellText := DateTimeToStr(UnixToDateTime(fFavorites[NodeData.ListIndex].DateTime));
      else
    end;
  end;

  procedure FillWithGroupsData;
  var
    Aantal: integer;
  begin
    CellText := '';
    if (Column = TVirtualStringTree(Sender).Header.Columns.ColumnFromPosition(Point(0, 0), false)) then
      case TextType of
        ttStatic:
        begin
          Aantal := Node.ChildCount;
          case Aantal of
            0: Exit;
            1: CellText := Format('(%d item)', [Aantal]);
          else
            CellText := Format('(%d items)', [Aantal]);
          end;
          Exit;
        end;
        ttNormal: CellText := fGroups[NodeData.ListIndex].Caption;
      end;
  end;

begin
  if not Sender.Showing then
    Exit;
  NodeData := Sender.GetNodeData(Node);
  if not Assigned(Node) then
    Exit;
  case NodeData.NodeType of
    ntFavorite:
      FillWithFavoritesData;
    ntGroup:
      FillWithGroupsData;
  end;
end;

procedure TMainForm.ForumListDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState;
  Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  Accept := Sender = Source;
end;

procedure TMainForm.TabBarDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Tab: TJvTabbarItem;
begin
  Accept := Source is TDeXTree;
  if not Accept then
    Exit;
  Tab := TabBar.TabAt(X, Y);
  if not Assigned(Tab) then
    Exit;
  TabBar.SelectedTab := Tab;
end;

procedure TMainForm.FavoritesListDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState;
  State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
  Node: pVirtualNode;
  NodeData: pFavoritesNodeData;
  HitInfo: THitInfo;
begin
  //enkel draggen vanuit ForumList of FavoritesList
  Accept := (Source = ForumList) or (Source = Sender);
  if not Accept then
    Exit;
  TBaseVirtualTree(Sender).GetHitTestInfoAt(Pt.X, Pt.Y, true, HitInfo);
  Node := HitInfo.HitNode;
  if not Assigned(Node) then
    Exit;
  NodeData := Sender.GetNodeData(Node);
  case NodeData.NodeType of
    ntGroup:
      //groepen kunnen geen child worden van andere groepen of favorieten,
      //enkel van de rootnode
      Accept:= Mode <> dmNoWhere;
    ntFavorite:
      Accept := true;
  end;
end;

procedure TMainForm.FavoritesListNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  NewText: WideString);
var
  NodeData: pFavoritesNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  //enkel groepen van naam wijzigen
  if not Assigned(Node) or (NodeData.NodeType = ntFavorite) then
    Exit;
  fGroups[NodeData.ListIndex].Caption := NewText;
end;

procedure TMainForm.FavoritesListBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellRect: TRect);
const
  AchtergrondKleur: array[boolean] of TColor = (clWindow, clBtnFace);
  Richting: array[boolean] of TGradientDirection = (gdHorizontal, gdVertical);
var
  NodeData: pFavoritesNodeData;
  Startkleur, EindKleur, RandKleur: TColor;
  KleurVerloopVerticaal: boolean;
begin
  NodeData := Sender.GetNodeData(Node);
  if not Assigned(Node) then
    Exit;
  KleurVerloopVerticaal := true;
  StartKleur := GetShadowColor(clBtnFace, -30);
  EindKleur := GetHighLightColor(clBtnFace);
  if (NodeData.NodeType = ntGroup) and
    (Column = TVirtualStringTree(Sender).Header.Columns.ColumnFromPosition(Point(0, 0), false)) then
  begin
    InflateRect(CellRect, -2, -2);
    GradientFillCanvas(TargetCanvas, StartKleur, EindKleur, CellRect, Richting[KleurVerloopVerticaal]);
    RandKleur := clBtnShadow;
    TargetCanvas.Brush.Color := RandKleur;
    InflateRect(CellRect,1, 1);
    TargetCanvas.FrameRect(CellRect);
  end else
  begin
    //geleend uit TDexTree, maar dan aangepast zodat eerste item clWindow heeft, dan de grijze kleur
    //In TDexTree is het eerst grijs, dan clWindow
    if Node.Index mod 2 <> 0 then
      TargetCanvas.Brush.Color := StringToColor('$00F0F0F0');
    TargetCanvas.FillRect(CellRect);
  end;
end;

procedure TMainForm.FavoritesListPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
const
  GroupFontStyle: array[boolean] of TFontStyles = ([], [fsBold]);
  StaticTextFontSize: array[boolean] of integer = (8, 7);
var
  NodeData: pFavoritesNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if not Assigned(Node) then
    Exit;
  TargetCanvas.Font.Style := [];
  //groepen krijgen bold caption en statictext
  TargetCanvas.Font.Style := GroupFontStyle[(NodeData.NodeType = ntGroup) and (TextType = ttNormal)];
  TargetCanvas.Font.Size := StatictextFontSize[(NodeData.NodeType = ntGroup) and (TextType = ttStatic)];
end;

procedure TMainForm.PMListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
var
  TheNode: pVirtualNode;
begin
  TheNode := NewNode;
  if not Assigned(TheNode) then
    Exit;
  with DexHintData do
  begin
    DateTime := UnixToDateTime(Tracker.Data.PM[TheNode.Index].DateTime);
    Forumname := '';
    Threadname := XmlSafetext(Tracker.Data.PM[TheNode.Index].Title);
    MemberName := Tracker.Data.PM[TheNode.Index].Member.Name;
    HintType := htPM;
    ContainsBitmap := false;
  end;
end;

procedure TMainForm.LinkListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
var
  TheNode: pVirtualNode;
begin
  TheNode := NewNode;
  if not Assigned(TheNode) then
    Exit;
  with DexHintData do
  begin
    DateTime := UnixToDateTime(Tracker.Data.Link[TheNode.Index].DateTime);
    Forumname := Tracker.Data.Link[TheNode.Index].Forum.Title;
    Threadname := XmlSafetext(Tracker.Data.Link[TheNode.Index].Title);
    MemberName := '';
    HintType := htLink;
    ContainsBitmap := false;
  end;
end;

procedure TMainForm.FavoritesListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
var
  aBitmap: TBitmap;
  TheNode: pVirtualNode;
  NodeData: pFavoritesNodeData;
  IconID: integer;
begin
  TheNode := NewNode;
  if not Assigned(TheNode) then
    Exit;
  NodeData := Sender.GetNodeData(TheNode);
  if NodeData.NodeType = ntGroup then
  begin
    Application.HideHint;//CancelHint;
    Exit;
  end;
  with DexHintData do
  begin
    DateTime := UnixToDateTime(fFavorites[NodeData.ListIndex].DateTime);
    Forumname := fFavorites[NodeData.ListIndex].ForumName;
    Threadname := XmlSafetext(fFavorites[NodeData.ListIndex].ThreadName);
    MemberName := fFavorites[NodeData.ListIndex].Membername;
    HintType := htFavorite;
    TheNode := TheNode.Parent;
    if TheNode = Sender.RootNode then
      GroupName := '<Behoort niet toe aan een groep>'
    else
    begin
      NodeData := Sender.GetNodeData(TheNode);
      GroupName := fGroups[NodeData.ListIndex].Caption;
    end;
    aBitmap := TBitmap.Create;
    try
      IconID := 0;
      if Nodedata.NodeType = ntFavorite then
        IconID := fFavorites[nodeData.ListIndex].IconID;
      PostImages.GetBitmap(IconID, aBitmap);
      Bitmap.Assign(aBitmap);
      ContainsBitmap := (NodeData.NodeType = ntFavorite) and (IconID > 0);
    finally
      aBitmap.Free;
    end;
  end;
end;

procedure TMainForm.NewsListHotChange(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode);
var
  TheNode: pVirtualNode;
begin
  TheNode := NewNode;
  if not Assigned(TheNode) then
    Exit;
  with DexHintData do
  begin
    DateTime := UnixToDateTime(Tracker.Data.News[TheNode.Index].DateTime);
    Forumname := '';
    Threadname := XmlSafetext(Tracker.Data.News[TheNode.Index].Title);
    MemberName := '';
    HintType := htNews;
    ContainsBitmap := false;
  end;
end;

procedure TMainForm.FavoritesListGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  NodeData: pFavoritesNodeData;
begin
  if not Sender.Showing then
    Exit;
  NodeData := Sender.GetNodeData(Node);
  if not Assigned(Node) then
    Exit;
  ImageIndex := 0;
  if (NodeData.NodeType = ntfavorite) and (Column = TVirtualStringTree(Sender).Header.MainColumn) then
    ImageIndex := fFavorites[NodeData.ListIndex].IconID;
  if (NodeData.NodeType = ntGroup) and
    (Column = TVirtualStringTree(Sender).Header.Columns.ColumnFromPosition(Point(0, 0), false)) then
  begin
    if Sender.Expanded[Node] then
      ImageIndex := ExpandedFolder
    else
      ImageIndex := CollapsedFolder;
  end;
end;

procedure TMainForm.TreesPopupMenuPopup(Sender: TObject);
var
  PopupComponent: TComponent;

  procedure AddMenuItem(acaption: string; aID: integer);
  var
    MenuItem: TMenuItem;
  begin
    MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := aCaption;
    MenuItem.Tag := aID;
    MenuItem.OnClick := AddToFavoritesActionExecute;
    AddToGroupMenu.Add(MenuItem);
  end;

var
  Index: integer;
begin
  PopupComponent := TPopupMenu(Sender).PopupComponent;
  NewGroupMenu.Visible := PopupComponent = FavoritesList;
  DeleteThreadMenu.Visible := PopupComponent = ForumList;
  FavoritesMenu.Visible := PopupComponent = ForumList;
  AddToGroupMenu.Visible := PopupComponent <> FavoritesList;
  if PopupComponent <> FavoritesList then
  begin
    AddToGroupMenu.Clear;
    AddToGroupMenu.Enabled := fGroups.Count > 0;
    for Index := 0 to Pred(fGroups.Count) do
      if not fGroups[Index].Deleted then
        AddMenuItem(fGroups[Index].Caption, fGroups[Index].ID);
  end;
end;

procedure TMainForm.AddToFavoritesGroup(aGroupID: integer);
var
  Favorite: TFavorite;
  Node: pVirtualNode;
begin
  fFavorites.BeginUpdate;
  fGroups.BeginUpdate;
  try
    Node := ForumList.GetFirstSelected;
    while Assigned(Node) do
    begin
      Favorite := TFavorite.Create;
      Favorite.DateTime := Tracker.Posts[Node.Index].DateTime;
      Favorite.Forumname := Tracker.Posts[Node.Index].ForumName;
      Favorite.GroupID := aGroupID;
      Favorite.IconID := Tracker.Posts[Node.Index].Post.IconID;
      Favorite.MemberName := Tracker.Posts[Node.Index].MemberName;
      Favorite.ThreadName := Tracker.Posts[Node.Index].ThreadName;
      Favorite.ID := Tracker.Posts[Node.Index].Post.ID;
      fFavorites.Add(Favorite);
      Node := ForumList.GetNextSelected(Node);
    end;
    if Settings.MainForm.Forum.DeleteNodesAfterAddingToFavorites then
      ForumList.DeleteSelectedNodes;
  finally
    fFavorites.EndUpdate;
    fGroups.EndUpdate;
  end;
end;

procedure TMainForm.AddToFavoritesActionExecute(Sender: TObject);
begin
  AddToFavoritesGroup(TControl(Sender).Tag);
end;

procedure TMainForm.TreesGetPopupMenu(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  const P: TPoint; var AskParent: Boolean; var PopupMenu: TPopupMenu);
begin
  if Sender.SelectedCount > 0 then
    PopupMenu := TreesPopupMenu;
end;

procedure TMainForm.FavoritesListEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  var Allowed: Boolean);
var
  NodeData: pFavoritesNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if not Assigned(Node) then
    Exit;
  Allowed := NodeData.NodeType = ntGroup;
end;

procedure TMainForm.OpenActionUpdate(Sender: TObject);
begin
    TAction(Sender).Enabled := SelectedCount(true) > 0;
end;

procedure TMainForm.NewGroupActionExecute(Sender: TObject);
var
  Group: TGroup;
  Index: integer;

  function FindGroupNodeWithID(aID: integer): pVirtualNode;
  var
    NodeData: pFavoritesNodeData;
  begin
    Result := FavoritesList.GetFirstChild(nil);
    while Assigned(Result) do
    begin
      NodeData := FavoritesList.GetNodeData(Result);
      if (NodeData.NodeType = ntGroup) then
      begin
        if fGroups[NodeData.ListIndex].ID = aID then
          Break;
      end;
      Result := FavoritesList.GetNext(Result);
    end
  end;

begin
  fGroups.BeginUpdate;
  try
    Group := TGroup.Create;
    Group.Caption := 'Nieuwe groep';
    Index := fGroups.Add(Group);
  finally
    fGroups.EndUpdate;
  end;
  FavoritesList.EditNode(FindGroupNodeWithID(fGroups[Index].ID), FavoritesList.Header.MainColumn);
end;

procedure TMainForm.NewGroupActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := ActiveTab = FavorietenTab;
end;

procedure TMainForm.FavoritesListInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
const
  NodeHeight: array[boolean] of integer = (18, 25);
var
  NodeData: pFavoritesNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if not Assigned(Node) then
    Exit;
  Sender.NodeHeight[Node] := NodeHeight[NodeData.NodeType = ntGroup];
  Sender.VerticalAlignment[Node] := 100 div (FavoritesList.NodeHeight[Node] - PostImages.Height);
  if NodeData.NodeType = ntGroup then
  begin
    Sender.Expanded[Node] := fGroups[NodeData.ListIndex].Expanded;
    Sender.Selected[Node] := fGroups[Nodedata.ListIndex].Selected;
  end else
  begin
    Sender.Selected[Node] := fFavorites[NodeData.ListIndex].Selected;
  end;
end;

procedure TMainForm.FavoritesListDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  var Allowed: Boolean);
begin
  Allowed := true;
end;

procedure TMainForm.ApplicationEvents1ShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
var
  Node: pVirtualNode;
  NodeData: pFavoritesNodeData;
begin
  if HintInfo.HintControl = FavoritesList then
  begin
    CanShow := false;
    HintInfo.HintWindowClass := TDexHint;
    Node := FavoritesList.HotNode;
    if not Assigned(Node) then
      Exit;
    NodeData := FavoritesList.GetNodeData(Node);
    CanShow := NodeData.NodeType = ntFavorite;
  end;
end;

procedure TMainForm.DeleteActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (SelectedCount(false) > 0) and (not (tsEditing in FavoritesList.TreeStates));
end;

procedure TMainForm.TabBarTabSelecting(Sender: TObject; Item: TJvTabBarItem; var AllowSelect: Boolean);
begin
  AllowSelect := Item.Index <> PMTab;
end;

procedure TMainForm.OutputStatus(const Text: string);
begin
  StatusBar.Panels[StatusPanel].Text := ' ' + Text;
  StatusTimer.Enabled := true;
end;

procedure TMainForm.OutputError(const Error: string);
begin
  StatusBar.Panels[ErrorPanel].Text := ' ' + Error;
  ErrorTimer.Enabled := true;
end;

procedure TMainForm.AddToFavoritesActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (ActiveTab = ForumTab) and (Forumlist.SelectedCount > 0);
end;

procedure TMainForm.FavoritesListGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := Sizeof(FavoritesUnit.TFavoritesNodeData);
end;

procedure TMainForm.FavoritesListDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject;
  Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  BestemmingsGroep: pVirtualNode;
  NodeData: pFavoritesNodeData;

  function ParentGroupID: integer;
  var
    Node: pVirtualNode;
    NodeData: pFavoritesNodeData;
    HitInfo: THitInfo;
  begin
    Result := -1;
    Sender.GetHitTestInfoAt(Pt.X, Pt.Y, true, HitInfo);
    Node := HitInfo.HitNode;
    if not Assigned(Node) then
      Exit;
    if Sender.GetNodeLevel(Node) = 2 then
      Node := Node.Parent;
    NodeData := Sender.GetNodeData(Node);
    if NodeData.NodeType = ntGroup then
      Result := fGroups[NodeData.ListIndex].ID;
  end;

  procedure MoveItems;
  var
    Node: pVirtualNode;
    HitInfo: THitInfo;
    DestinationGroupID: integer;

    procedure MoveAllFavoritesFromgroup(aGroupID: integer);
    var
      Index: integer;
    begin
      for Index := 0 to Pred(fFavorites.Count) do
      begin
        if fFavorites[Index].GroupID = aGroupID then
          fFavorites[Index].GroupID := DestinationGroupID;
      end;
    end;

    function ShiftKeyPressed : Boolean;
    var
      State: TKeyboardState;
    begin
      GetKeyboardState(State);
      Result := ((State[vk_Shift] and 128) <> 0);
    end;


  begin
    Sender.GetHitTestInfoAt(Pt.X, Pt.Y, true, HitInfo);
    BestemmingsGroep := HitInfo.HitNode;
    if not Assigned(HitInfo.HitNode) then
      DestinationGroupID := -1
    else
    begin
      Node := Hitinfo.HitNode;
      NodeData := Sender.GetNodeData(Node);
      if NodeData.NodeType = ntFavorite then
      begin
        if Node.Parent = Sender.RootNode then
          DestinationGroupID := -1
        else
        begin
          Node := Node.Parent;
          NodeData := Sender.GetNodeData(Node);
          DestinationGroupID := fGroups[NodeData.ListIndex].ID;
        end;
      end else
      begin //groep
        DestinationGroupID := fGroups[NodeData.ListIndex].ID;
      end;
    end;
    Node := Sender.GetFirstSelected;
    while Assigned(Node) do
    begin
      NodeData := Sender.GetNodeData(Node);
      if (NodeData.NodeType = ntGroup) and ShiftKeyPressed then
        MoveAllFavoritesFromgroup(fGroups[NodeData.ListIndex].ID)
      else
        fFavorites[NodeData.ListIndex].GroupID := DestinationGroupID;
      Node := Sender.GetNextSelected(Node);
    end;
    if Assigned(BestemmingsGroep) then
    begin
      NodeData := Sender.GetNodeData(BestemmingsGroep);
      if NodeData.NodeType = ntFavorite then
        BestemmingsGroep := BestemmingsGroep.Parent
      else
      begin
        fGroups[NodeData.ListIndex].Expanded := true;
        BestemmingsGroep.States := BestemmingsGroep.States + [vsExpanded];
      end;
      Sender.Update;
    end;
  end;

begin
  fGroups.BeginUpdate;
  fFavorites.BeginUpdate;
  try
    if Source = ForumList then
      AddToFavoritesGroup(ParentGroupID)
    else if Source =  Sender then
      MoveItems;
  finally
    fFavorites.EndUpdate;
    fGroups.EndUpdate;
  end;
end;

procedure TMainForm.ExpandCollapseGroupActionExecute(Sender: TObject);
var
  Node: pVirtualNode;
begin
  Node := FavoritesList.GetFirstSelected;
  while Assigned(Node) do
  begin
    FavoritesList.ToggleNode(Node);
    Node := FavoritesList.GetNextSelected(Node);
  end;
end;

procedure TMainForm.FavoritesListExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  NodeData: pFavoritesNodeData;
begin
  if not Assigned(Node) then
    Exit;
  NodeData := Sender.GetNodeData(Node);
  if NodeData.NodeType = ntGroup then
    fGroups[NodeData.ListIndex].Expanded := true;
end;

procedure TMainForm.FavoritesListCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  NodeData: pFavoritesNodeData;
begin
  if not Assigned(Node) then
    Exit;
  NodeData := Sender.GetNodeData(Node);
  if NodeData.NodeType = ntGroup then
    fGroups[NodeData.ListIndex].Expanded := false;
end;

procedure TMainForm.CreateParams(var Params: TCreateParams);
begin
  //Vista-ready
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle and not WS_EX_TOOLWINDOW or
    WS_EX_APPWINDOW;
end;

procedure TMainForm.WMSyscommand(var Message: TWmSysCommand);
begin
  //Vista-ready
  case (Message.CmdType and $FFF0) of
    SC_MINIMIZE:
    begin
      ShowWindow(Handle, SW_MINIMIZE);
      if Settings.MinimizeToTray then
        HideAction.Execute;
      Message.Result := 0;
    end;
    SC_RESTORE:
    begin
      ShowWindow(Handle, SW_RESTORE);
      Message.Result := 0;
    end;
    SC_CLOSE:
    begin
      Message.Result := 0;
      if Settings.CloseToTray then
        HideAction.Execute
      else
        CloseAction.Execute;
    end;
  else
    inherited;
  end;
end;

procedure TMainForm.FavoritesListContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
const
  ExpandCollapseCaption: array[boolean] of string = ('Uitklappen', 'Inklappen');
  ExpandCollapseImageIndex: array[boolean] of integer = (8, 9);
var
  Node: pVirtualNode;
  NodeData: pFavoritesNodeData;
begin
  Node := TVirtualStringTree(Sender).GetNodeAt(MousePos.X, MousePos.Y);
  if not Assigned(Node) then
    Exit;
  ExpandCollapseGroupAction.Visible := false;
  NodeData := TVirtualStringTree(Sender).GetNodeData(Node);
  if NodeData.NodeType = ntGroup then
  begin
    ExpandCollapseGroupAction.Caption := ExpandCollapseCaption[TVirtualStringTree(Sender).Expanded[Node]];
    ExpandCollapseGroupAction.Visible := true;
    ExpandCollapseGroupAction.Enabled := Node.ChildCount > 0;
    ExpandCollapseGroupAction.ImageIndex := ExpandCollapseImageIndex[TVirtualStringTree(Sender).Expanded[Node]];
  end;
end;

procedure TMainForm.FavoritesListHeaderClick(Sender: TVTHeader; Column: TColumnIndex; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Node: pVirtualNode;
  NodeData: pFavoritesNodeData;
begin
  if tsEditing in FavoritesList.TreeStates then
  begin
    FavoritesList.EndEditNode;
    Exit;
  end;
  if Column = Ord(fFavorites.SortType) then
  begin
    if fFavorites.SortDirection = Ord(sdAscending) then
      fFavorites.SortDirection := Ord(sdDescending)
    else
      fFavorites.SortDirection := Ord(sdAscending);
  end;
  fFavorites.SortType := TFavoritesSortType(Column);
  Sender.SortColumn := Column;
  Sender.SortDirection := TSortDirection(fFavorites.SortDirection);
  SortFavorites(Sender);
  Settings.MainForm.FavoritesSorting.Column := Column;
  Settings.MainForm.FavoritesSorting.Direction := fFavorites.SortDirection;
end;

procedure TMainForm.FavoritesListCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
  Column: TColumnIndex; var Result: Integer);
var
  NodeData1, NodeData2: pFavoritesNodeData;

  procedure SortOnDate;
  var
    Date1, Date2: integer;
  begin
    Date1 := fFavorites[NodeData1.ListIndex].DateTime;
    Date2 := fFavorites[NodeData2.ListIndex].DateTime;
    if Date1 = Date2 then
      Result  := 0
    else if Date1 > Date2 then
      Result := 1
    else
      Result := -1;
  end;

  procedure SortOnThreadName;
  var
    Threadname1, ThreadName2: string;
  begin
    ThreadName1 := fFavorites[NodeData1.ListIndex].ThreadName;
    ThreadName2 := fFavorites[NodeData2.ListIndex].ThreadName;
    Result := AnsiCompareText(ThreadName1, ThreadName2);
    if Result = 0 then
      SortOnDate;
  end;

  procedure SortOnMemberName;
  var
    MemberName1, MemberName2: string;
  begin
    MemberName1 := fFavorites[NodeData1.ListIndex].MemberName;
    MemberName2 := fFavorites[NodeData2.ListIndex].MemberName;
    Result := AnsiCompareText(MemberName1, MemberName2);
  end;

  procedure SortOnForumName;
  var
    Forumname1, ForumName2: string;
  begin
    Forumname1 := fFavorites[NodeData1.ListIndex].ForumName;
    ForumName2 := fFavorites[NodeData2.ListIndex].ForumName;
    Result := AnsiCompareText(ForumName1, ForumName2);
  end;

begin
  Result := 0;
  if (not Assigned(Node1)) or (not Assigned(Node2)) then
    Exit;
  NodeData1 := Sender.GetNodeData(Node1);
  NodeData2 := Sender.GetNodeData(Node2);
  if (NodeData1.NodeType = ntGroup) or (NodeData2.NodeType = ntGroup) then
    Exit;
  case Column of
    0: SortOnThreadName;
    1: SortOnMemberName;
    2: SortOnForumName;
    3: SortOnDate;
    -1: Exit;
  end;
end;

procedure TMainForm.SortFavorites(aHeader: TVTHeader);
var
  Node: PVirtualNode;
  NodeData: pFavoritesNodeData;
begin
  Node := FavoritesList.GetFirst;
  while Assigned(Node) do
  begin
    NodeData := FavoritesList.GetNodeData(Node);
    if NodeData.NodeType = ntGroup then
      FavoritesList.Sort(Node, aHeader.SortColumn, aHeader.SortDirection)
    else if (NodeData.NodeType = ntFavorite) and (Node.Parent = FavoritesList.RootNode) then
      FavoritesList.Sort(FavoritesList.RootNode, aHeader.SortColumn, aHeader.SortDirection);
    Node := FavoritesList.GetNext(Node);
  end;
  fFavorites.SortType := TFavoritesSortType(aHeader.SortColumn);
end;

function TMainForm.ActiveTab: integer;
begin
  Result := TabBar.SelectedTab.Index;
end;

procedure TMainForm.TreesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  function CanDeleteItem: boolean;
  begin
    Result := true;
    if Sender <> FavoritesList then
      Exit;
    Result := not (tsEditing in FavoritesList.TreeStates);
  end;

begin
  if (Key = VK_BACK) and CanDeleteItem then
    DeleteAction.Execute;
end;

procedure TMainForm.SelectForumTabActionExecute(Sender: TObject);
begin
  TabBar.Tabs[ForumTab].Selected := true;
end;

procedure TMainForm.SelectPMTabActionExecute(Sender: TObject);
begin
  TabBar.Tabs[PMTab].Selected := true;
end;

procedure TMainForm.SelectLinkTabActionExecute(Sender: TObject);
begin
  TabBar.Tabs[LinkTab].Selected := true;
end;

procedure TMainForm.SelectNewsTabActionExecute(Sender: TObject);
begin
  TabBar.Tabs[NieuwsTab].Selected := true;
end;

procedure TMainForm.SelectFavoritesTabActionExecute(Sender: TObject);
begin
  TabBar.Tabs[FavorietenTab].Selected := true;
end;

procedure TMainForm.SelectWebsiteTabActionExecute(Sender: TObject);
begin
  TabBar.Tabs[WebsiteTab].Selected := true;
end;

procedure TMainForm.SecondaryDeleteActionExecute(Sender: TObject);
begin
  if ActiveControl is TBaseVirtualTree then
    DeleteAction.Execute;
end;

function TMainForm.SelectedCount(FavoritesOnly: boolean): integer;

  function OnlyFavoritesSelected: boolean;
  var
    NodeData: pFavoritesNodeData;
    Node: pVirtualNode;
  begin
    Result := false;
    Node := FavoritesList.GetFirstSelected;
    while Assigned(Node) do
    begin
      NodeData := FavoritesList.GetNodeData(Node);
      Result := NodeData.NodeType = ntFavorite;
      if Result then
        Break;
      Node := FavoritesList.GetNextSelected(Node);
    end;
  end;

const
  Aantal: array[boolean] of integer = (0, 1);
begin
  Result := 0;
  case Activetab of
    ForumTab: Result := ForumList.SelectedCount;
    PMTab: Result := PMList.SelectedCount;
    LinkTab: Result := LinkList.SelectedCount;
    NieuwsTab: Result := NewsList.SelectedCount;
    FavorietenTab:
    begin
      if FavoritesOnly then
        Result := Aantal[OnlyFavoritesSelected]
      else
        result := FavoritesList.SelectedCount;
    end;
    WebsiteTab: Result := SiteTree.SelectedCount;
  end;
end;

procedure TMainForm.ForumListIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode;
  const SearchText: WideString; var Result: Integer);
var
  S, PropText: string;
begin
  if not Assigned(Node) then
    Exit;
  PropText := Tracker.Posts[Node.Index].ThreadName;
  S := SearchText;
end;

procedure TMainForm.SearchEditChange(Sender: TObject);
begin
  ForumList.BeginUpdate;
  ForumList.IterateSubtree(nil, FilterNodes, Pointer(SearchEdit.Text), [], true);
  ForumList.EndUpdate;
  Settings.SearchText := SearchEdit.Text;
end;

procedure TMainForm.EraseButtonClick(Sender: TObject);
begin
  SearchEdit.Clear;
end;

procedure TMainForm.FilterNodes(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  ZoekTekst, NodeTekst: string;
begin
  Zoektekst := string(Data);
  NodeTekst := Tracker.Posts[Node.Index].ThreadName;
  if ZoekTekst = '' then
    Sender.IsVisible[Node]  := true
  else
    Sender.IsVisible[Node] := AnsiContainsText(NodeTekst, ZoekTekst);
end;

end.

