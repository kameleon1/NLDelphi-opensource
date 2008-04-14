unit SettingsUnit;

interface

uses
  Classes, Graphics, Forms, VirtualTrees, XMLIntf, XMLDoc, NLDXMLData;

type
//2 Colorstyles die op NLDelphi gebruikt worden
  TColorStyle = (csNLDelphiVB3Style, csWhiteAndPurple);

 TUserSettings = class
  private
    fLocation: string;
    fName: string;
    fPassword: string;
    procedure LoadDefaults;
  public
    property Name: string read fName write fName;
    property Password: string read fPassword write fPassword;
    property Location: string read fLocation write fLocation;
    procedure Load;
    procedure Save;
  end;

  TNotifySoundSettings = class
  private
    fFileName: string;
    fEnabled: boolean;
    procedure LoadDefaults;
  public
    property Enabled: boolean read fEnabled write fEnabled;
    property FileName: string read fFileName write fFileName;
    procedure Load;
    procedure Save;
  end;

  TAboutFormSettings = class
  private
    fTop: integer;
    fLeft: integer;
    procedure LoadDefaults;
  public
    property Left: integer read fLeft write fLeft;
    property Top: integer read fTop write fTop;
    procedure Load;
    procedure Save;
  end;

  TFetchDateTimeFormSettings = class
  private
    fTop: integer;
    fLeft: integer;
    procedure LoadDefaults;
  public
    property Left: integer read fLeft write fLeft;
    property Top: integer read fTop write fTop;
    procedure Load;
    procedure Save;
  end;

  TSettingsFormSettings = class
  private
//    fWidth: integer;
    fTop: integer;
//    fHeight: integer;
    fLeft: integer;
    fActivePage: integer;
    procedure LoadDefaults;
  public
    property Left: integer read fLeft write fLeft;
    property Top: integer read fTop write fTop;
    property ActivePage: integer read fActivePage write fActivePage;
//    property Width: integer read fWidth write fWidth;
//    property Height: integer read fHeight write fHeight;
    procedure Load;
    procedure Save;
  end;

  TLoginFormSettings = class
  private
    fTop: integer;
    fLeft: integer;
    procedure LoadDefaults;
  public
    property Left: integer read fLeft write fLeft;
    property Top: integer read fTop write fTop;
    procedure Load;
    procedure Save;
  end;

  TPopupSettings = class
  private
    fTopColor: TColor;
    fDuration: integer;
    fDeleteOnOpen: boolean;
    fPopup: boolean;
    fLinkColor: TColor;
    fBottomColor: TColor;
    fTextColor: TColor;
    procedure LoadDefaults;
  public
    property TopColor: TColor read fTopColor write fTopColor;
    property BottomColor: TColor read fBottomColor write fBottomColor;
    property LinkColor: TColor read fLinkColor write fLinkColor;
    property TextColor: TColor read fTextColor write fTextColor;
    property Duration: integer read fDuration write fDuration;//seconden
    property Popup: boolean read fPopup write fPopup;
    property DeleteOnOpen: boolean read fDeleteOnOpen write fDeleteOnOpen;
    procedure Load;
    procedure Save;
  end;

  TTrackerSettings = class
  private
    fNames: TStringList;
    fInterval: integer;
    procedure LoadDefaults;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AssignIgnoreUsers(Source: TStrings);
    procedure AssignIgnoreUsersTo(Destination: TStrings);
    property Interval: integer read fInterval write fInterval;
    procedure Load;
    procedure Save;
  end;

  TTabbarSettings = class
  private
    fAlignToTop: boolean;
    procedure LoadDefaults;
  public
    property AlignToTop: boolean read fAlignToTop write fAlignToTop;
    procedure Load;
    procedure Save;
  end;

  TForumListSettings = class
  private
    fDeleteNodesAfterAddingToFavorites: boolean;
    procedure LoadDefaults;
  public
    property DeleteNodesAfterAddingToFavorites: boolean
      read fDeleteNodesAfterAddingToFavorites write fDeleteNodesAfterAddingToFavorites;
    procedure Load;
    procedure Save;
  end;

  TFavoritesListSettings = class
  private
    fConfirmGroupDeletion: boolean;
    procedure LoadDefaults;
  public
    property ConfirmGroupDeletion: boolean read fConfirmGroupDeletion write fConfirmGroupDeletion;
    procedure Load;
    procedure Save;
  end;

  TSiteTreeSettings = class
  private
    fColorStyle: TColorStyle;
    procedure LoadDefaults;
  public
    property ColorStyle: TColorStyle read fColorStyle write fColorStyle;
    procedure Load;
    procedure Save;
  end;

  TSortSettings = class
  private
    fColumn: integer;
    fDirection: integer;
    fSection: string;
    procedure LoadDefaults;
  public
    constructor Create(Section: string);
    property Column: integer read fColumn write fColumn;
    property Direction: integer read fDirection write fDirection;
    procedure Load;
    procedure Save;
  end;

  TMainFormSettings = class
  private
    fWidth: integer;
    fTop: integer;
    fHeight: integer;
    fLeft: integer;
    fWindowState: TWindowState;
    fConfirmMultipleItemsDeletion: boolean;
    fTabbar: TTabbarSettings;
    fForum: TForumListSettings;
    fFavorites: TFavoritesListSettings;
    fSite: TSiteTreeSettings;
    fPMSorting: TSortSettings;
    fNewsSorting: TSortSettings;
    fLinkSorting: TSortSettings;
    fForumSorting: TSortSettings;
    fFavoritesSorting: TSortSettings;
    fDeleteItemsAfterBeingRead: boolean;
    procedure LoadDefaults;
  public
    constructor Create;
    destructor Destroy; override;
    property Left: integer read fLeft write fLeft;
    property Top: integer read fTop write fTop;
    property Width: integer read fWidth write fWidth;
    property Height: integer read fHeight write fHeight;
    property WindowState: TWindowState read fWindowState write fWindowState;
    property ConfirmMultipleItemsDeletion: boolean
      read fConfirmMultipleItemsDeletion write fConfirmMultipleItemsDeletion;
    property DeleteItemsAfterBeingRead: boolean read fDeleteItemsAfterBeingRead write fDeleteItemsAfterBeingRead;
    property TabBar: TTabbarSettings read fTabbar write fTabbar;
    property Forum: TForumListSettings read fForum write fForum;
    property Favorites: TFavoritesListSettings read fFavorites write ffavorites;
    property Site: TSiteTreeSettings read fSite write fSite;
    property ForumSorting: TSortSettings read fForumSorting write fForumSorting;
    property PMSorting: TSortSettings read fPMSorting write fPMSorting;
    property LinkSorting: TSortSettings read fLinkSorting write fLinkSorting;
    property NewsSorting: TSortSettings read fNewsSorting write fNewsSorting;
    property FavoritesSorting: TSortSettings read fFavoritesSorting write fFavoritesSorting;
    procedure Load;
    procedure Save;
  end;


  TDexSettings = class(TObject)
  private
    fXmlDocument: IXmlDocument;
    fFileName: string;
    fUser: TUserSettings;
    fVersion: single;
    fAutoSave: boolean;
//    fUseTDeXHint: boolean;
    fAutoStart: boolean;
    fFontName: TFontName;
    fNotifySound: TNotifySoundSettings;
    fAboutForm: TAboutFormSettings;
    fFetchDateTimeForm: TFetchDateTimeFormSettings;
    fSettingsForm: TSettingsFormSettings;
    fLoginForm: TLoginFormSettings;
    fPopup: TPopupSettings;
    fTracker: TTrackerSettings;
    fMainForm: TMainFormSettings;
    fSiteURL: string;
    fSearchtext: string;
    fMinimizeToTray: boolean;
    fCloseToTray: boolean;
    fHideOnStart: boolean;
    function InitXMLDocument: boolean;
  protected
    procedure LoadDefaults;
  public
    constructor Create;
    destructor Destroy; override;
    property Version: single read fVersion write fVersion;
//    property UseTDeXHint: boolean read fUseTDeXHint write fUseTDeXHint;
    property FontName: TFontName read fFontName write fFontName;
    property AutoSave: boolean read fAutoSave write fAutoSave;
    property AutoStart: boolean read fAutoStart write fAutoStart;
    property SearchText: string read fSearchtext write fSearchText;
    property SiteURL: string read fSiteURL write fSiteURL;
    property MinimizeToTray: boolean read fMinimizeToTray write fMinimizeToTray;
    property CloseToTray: boolean read fCloseToTray write fCloseToTray;
    property HideOnStart: boolean read fHideOnStart write fHideOnStart;
    property User: TUserSettings read fUser write fUser;
    property NotifySound: TNotifySoundSettings read fNotifySound write fNotifySound;
    property AboutForm: TAboutFormSettings read fAboutForm write fAboutForm;
    property FetchDateTimeForm: TFetchDateTimeFormSettings read fFetchDateTimeForm write fFetchDateTimeForm;
    property SettingsForm: TSettingsFormSettings read fSettingsForm write fSettingsForm;
    property LoginForm: TLoginFormSettings read fLoginForm write fLoginForm;
    property MainForm: TMainFormSettings read fMainForm write fMainForm;
    property Popup: TPopupSettings read fPopup write fPopup;
    property Tracker: TTrackerSettings read fTracker write fTracker;
    procedure LoadFromFile(FileName: string);
    procedure SaveToFile(FileName: string);
  end;

  function Settings: TDeXSettings;

implementation

uses
  SysUtils;

var
  fSettings: TDeXSettings = nil;

  SettingsNode, UserNode, NotifySoundNode,
  AboutFormNode, FetchDateTimeFormNode, SettingsFormNode, LoginFormNode,
  PopupNode, TrackerNode, MainFormNode, SortNode: IXMLNode;

function Settings: TDeXSettings;
begin
  if not Assigned(fSettings) then
    fSettings := TDeXSettings.Create;
  Result := fSettings;
end;

{ TDexSettings }

procedure TDexSettings.SaveToFile(FileName: string);
var
  StringList: TStringList;
begin
  fFileName := FileName;
  if not FileExists(fFileName) then
  begin
    StringList := TStringList.Create;
    try
      StringList.Text := '<Settings></Settings>';
      StringList.SaveToFile(fFileName);
    finally
      StringList.Free;
    end;
  end;
  if not InitXMLDocument then
//  begin
//    if not InitXMLDocument then
      Exit;
//  end;
  SettingsNode := fXMLDocument.DocumentElement;
  if not Assigned(SettingsNode) then
    fXmlDocument.AddChild('Settings');
  SettingsNode.ChildNodes.Clear;
  SettingsNode.AddChild('Version').Text := Format('%.1f', [fVersion]);
  SettingsNode.AddChild('AutoStart').Text := BoolToStr(fAutoStart, true);
  SettingsNode.AddChild('AutoSave').Text := BoolToStr(fAutoSave, true);
  SettingsNode.AddChild('MinimizeToTray').Text := BoolToStr(fMinimizeToTray, true);
  SettingsNode.AddChild('CloseToTray').Text := BoolToStr(fCloseToTray, true);
  SettingsNode.AddChild('HideOnStart').Text := BoolToStr(fHideOnStart, true);
  SettingsNode.AddChild('FontName').Text := fFontName;
//  SettingsNode.AddChild('UseTDeXHint').Text := BoolToStr(fUseTDeXHint, true);
  SettingsNode.AddChild('SiteURL').Text := 'http://www.nldelphi.com';
  SettingsNode.AddChild('SearchText').Text := fSearchText;

  fUser.Save;
  fNotifySound.Save;
  fAboutForm.Save;
  fFetchDateTimeForm.Save;
  fSettingsForm.Save;
  fLoginForm.Save;
  fMainForm.Save;
  fPopup.Save;
  fTracker.Save;
  fXmlDocument.SaveToFile(FileName);
end;

procedure TDexSettings.LoadFromFile(FileName: string);

  procedure GetAutoSave;
  begin
    try
      fAutoSave := StrToBool(SettingsNode.ChildNodes['AutoSave'].Text);
    except
      fAutoSave := true;
    end;
  end;

  procedure GetAutoStart;
  begin
    try
      fAutoStart := StrToBool(SettingsNode.ChildNodes['AutoStart'].Text);
    except
      fAutoStart := true;
    end;
  end;

  procedure GetMinimizeToTray;
  begin
    try
      fMinimizeToTray := StrToBool(SettingsNode.ChildNodes['MinimizeToTray'].Text);
    except
      fMinimizeToTray := false;
    end;
  end;

  procedure GetCloseToTray;
  begin
    try
      fCloseToTray := StrToBool(SettingsNode.ChildNodes['CloseToTray'].Text);
    except
      fCloseToTray := false;
    end;
  end;

  procedure GetHideOnStart;
  begin
    try
      fHideOnStart := StrToBool(SettingsNode.ChildNodes['HideOnStart'].Text);
    except
      fHideOnStart := false;
    end;
  end;

  procedure GetFontName;
  begin
    fFontName := SettingsNode.ChildNodes['FontName'].Text;
    if fFontName = '' then
      fFontName := DefFontData.Name;
  end;

//  procedure GetUseTDeXHint;
//  begin
//    try
//      fUseTDeXHint := StrToBool(SettingsNode.ChildNodes['UseTDeXHint'].Text);
//    except
//      fUseTDeXHint  := true;
//    end;
//  end;

  procedure GetVersion;
  begin
    try
      fVersion := StrToFloat(SettingsNode.ChildNodes['Version'].Text);
    except
      fVersion := 3.0;
    end;
  end;

  procedure GetSiteURL;
  begin
    fSiteURL := SettingsNode.ChildNodes['SiteURL'].Text;
    if fSiteURL = '' then
      fSiteURL := 'http://www.NLDelphi.com';
  end;

  procedure GetSearchText;
  begin
    fSearchText := SettingsNode.ChildNodes['SearchText'].Text;
  end;

begin
  fFileName := FileName;
  if not InitXMLDocument then
  begin
    LoadDefaults;
    Exit;
  end;
  SettingsNode := fXMLDocument.DocumentElement;
  if not Assigned(SettingsNode) then
    Exit;
  GetAutoSave;
  GetAutoStart;
  GetMinimizeToTray;
  GetCloseToTray;
  GetHideOnStart;
  GetFontName;
//  GetUseTDeXHint;
  GetVersion;
  GetSiteURL;
  GetSearchText;
  fUser.Load;
  fNotifySound.Load;
  fAboutForm.Load;
  fFetchDateTimeForm.Load;
  fSettingsForm.Load;
  fLoginForm.Load;
  fMainForm.Load;
  fPopup.Load;
  fTracker.Load;
end;

function TDexSettings.InitXMLDocument: boolean;
var
  StringList: TStringList;
begin
  Result := FileExists(fFileName);
  if Result then
  try
    fXmlDocument := LoadXMLDocument(fFileName);
  except
    Result := false;
    StringList := TStringList.Create;
    try
      StringList.Text := '<Settings></Settings>';
      StringList.SaveToFile(fFileName);
    finally
      StringList.Free;
    end;
    if not InitXMLDocument then
      Exit;
  end;
end;

constructor TDexSettings.Create;
begin
  fUser := TUserSettings.Create;
  fNotifySound := TNotifySoundSettings.Create;
  fAboutForm := TAboutFormSettings.Create;
  fFetchDateTimeForm := TFetchDateTimeFormSettings.Create;
  fSettingsForm := TSettingsFormSettings.Create;
  fLoginForm := TLoginFormSettings.Create;
  fMainForm := TMainFormSettings.Create;
  fPopup := TPopupSettings.Create;
  fTracker := TTrackerSettings.Create;
end;

destructor TDexSettings.Destroy;
begin
  fUser.Free;
  fNotifySound.Free;
  fAboutForm.Free;
  fFetchDateTimeForm.Free;
  fSettingsForm.Free;
  fLoginForm.Free;
  fMainForm.Free;
  fPopup.Free;
  fTracker.Free;
  inherited;
end;

procedure TDexSettings.LoadDefaults;
begin
  fVersion := 3.0;
  fMinimizeToTray := false;
  fCloseTotray := false;
  fHideOnStart := false;
  fFontName := DefFontData.Name;
  fAutoSave := true;
  fAutoStart := true;
  fSearchText := '';
  fSiteURL := 'http://www.NLDelphi.com';
  User.LoadDefaults;
  NotifySound.LoadDefaults;
  AboutForm.LoadDefaults;
  FetchDateTimeForm.LoadDefaults;
  SettingsForm.LoadDefaults;
  LoginForm.LoadDefaults;
  MainForm.LoadDefaults;
  Popup.LoadDefaults;
  Tracker.LoadDefaults;
end;

{ TUserSettings }

procedure TUserSettings.Load;
begin
  UserNode := SettingsNode.ChildNodes.FindNode('User');
  if not Assigned(UserNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  fLocation := UserNode.ChildNodes['Location'].Text;
  fName := UserNode.ChildNodes['Name'].Text;
  fPassword := UserNode.ChildNodes['Password'].Text;
end;

procedure TUserSettings.LoadDefaults;
begin
  fLocation := '';
  fName := '';
  fPassword := '';
end;

procedure TUserSettings.Save;
begin
  UserNode := SettingsNode.ChildNodes.FindNode('User');
  if not Assigned(UserNode) then
    UserNode := SettingsNode.AddChild('User');
  UserNode.AddChild('Location').Text := fLocation;
  UserNode.AddChild('Name').Text := fName;
  UserNode.AddChild('Password').Text := fPassword;
end;

{ TNotifySoundSettings }

procedure TNotifySoundSettings.Load;

  procedure GetEnabled;
  begin
    try
      fEnabled := StrToBool(NotifySoundNode.ChildNodes['Enabled'].Text);
    except
      fEnabled := true;
    end;
  end;

begin
  NotifySoundNode := SettingsNode.ChildNodes.FindNode('NotifySound');
  if not Assigned(NotifySoundNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  fFileName := NotifySoundNode.ChildNodes['FileName'].Text;
  GetEnabled;
end;

procedure TNotifySoundSettings.LoadDefaults;
begin
  fFileName := '';
  fEnabled := true;
end;

procedure TNotifySoundSettings.Save;
begin
  NotifySoundNode := SettingsNode.ChildNodes.FindNode('NotifySound');
  if not Assigned(NotifySoundNode) then
    NotifySoundNode := SettingsNode.AddChild('NotifySound');
  NotifySoundNode.AddChild('Enabled').Text := BoolToStr(fEnabled, true);
  NotifySoundNode.AddChild('FileName').Text := fFileName;
end;

{ TAboutFormSettings }

procedure TAboutFormSettings.Load;

  procedure GetLeft;
  begin
    try
      fLeft := StrToInt(AboutFormNode.ChildNodes['Left'].Text);
    except
      fLeft := 0;
    end;
  end;

  procedure GetTop;
  begin
    try
      fTop := StrToInt(AboutFormNode.ChildNodes['Top'].Text);
    except
      fTop := 0;
    end;
  end;

begin
  AboutFormNode := SettingsNode.ChildNodes.FindNode('AboutForm');
  if not Assigned(AboutFormNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  GetLeft;
  GetTop;
end;

procedure TAboutFormSettings.LoadDefaults;
begin
  fLeft := 100;
  fTop := 100;
end;

procedure TAboutFormSettings.Save;
begin
  AboutFormNode := SettingsNode.ChildNodes.FindNode('AboutForm');
  if not Assigned(AboutFormNode) then
    AboutFormNode := SettingsNode.AddChild('AboutForm');
  AboutFormNode.AddChild('Left').Text := IntToStr(fLeft);
  AboutFormNode.AddChild('Top').Text := IntToStr(fTop);
end;

{ TFetchDateTimeFormSettings }

procedure TFetchDateTimeFormSettings.Load;

  procedure GetLeft;
  begin
    try
      fLeft := StrToInt(FetchDateTimeFormNode.ChildNodes['Left'].Text);
    except
      fLeft := 0;
    end;
  end;

  procedure GetTop;
  begin
    try
      fTop := StrToInt(FetchDateTimeFormNode.ChildNodes['Top'].Text);
    except
      fTop := 0;
    end;
  end;

begin
  FetchDateTimeFormNode := SettingsNode.ChildNodes.FindNode('FetchDateTimeForm');
  if not Assigned(FetchDateTimeFormNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  GetLeft;
  GetTop;
end;

procedure TFetchDateTimeFormSettings.LoadDefaults;
begin
  fLeft := 100;
  fTop := 100;
end;

procedure TFetchDateTimeFormSettings.Save;
begin
  FetchDateTimeFormNode := SettingsNode.ChildNodes.FindNode('FetchDateTimeForm');
  if not Assigned(FetchDateTimeFormNode) then
    FetchDateTimeFormNode := SettingsNode.AddChild('FetchDateTimeForm');
  FetchDateTimeFormNode.AddChild('Left').Text := IntToStr(fLeft);
  FetchDateTimeFormNode.AddChild('Top').Text := IntToStr(fTop);
end;

{ TSettingsFormSettings }

procedure TSettingsFormSettings.Load;

  procedure GetLeft;
  begin
    try
      fLeft := StrToInt(SettingsFormNode.ChildNodes['Left'].Text);
    except
      fLeft := 0;
    end;
  end;

  procedure GetTop;
  begin
    try
      fTop := StrToInt(SettingsFormNode.ChildNodes['Top'].Text);
    except
      fTop := 0;
    end;
  end;

//  procedure GetWidth;
//  begin
//    try
//      fWidth := StrToInt(SettingsFormNode.ChildNodes['Width'].Text);
//    except
//      fWidth := 0;
//    end;
//  end;

//  procedure GetHeight;
//  begin
//    try
//      fHeight := StrToInt(SettingsFormNode.ChildNodes['Height'].Text);
//    except
//      fHeight := 0;
//    end;
//  end;

  procedure GetActivePage;
  begin
    try
      fActivePage := StrToInt(SettingsFormNode.ChildNodes['ActivePage'].Text);
    except
      fActivePage := 0;
    end;
  end;

begin
  SettingsFormNode := SettingsNode.ChildNodes.FindNode('SettingsForm');
  if not Assigned(SettingsFormNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  GetLeft;
  GetTop;
//  GetWidth;
//  GetHeight;
  GetActivePage;
end;

procedure TSettingsFormSettings.LoadDefaults;
begin
  fleft := 100;
  fTop := 100;
//  fWidth := 0;
//  fHeight := 0;
end;

procedure TSettingsFormSettings.Save;
begin
  SettingsFormNode := SettingsNode.ChildNodes.FindNode('SettingsForm');
  if not Assigned(SettingsFormNode) then
    SettingsFormNode := SettingsNode.AddChild('SettingsForm');
  SettingsFormNode.AddChild('Left').Text := IntToStr(fLeft);
  SettingsFormNode.AddChild('Top').Text := IntToStr(fTop);
//  SettingsFormNode.AddChild('Width').NodeValue := IntToStr(fWidth);
//  SettingsFormNode.AddChild('Height').Text := IntToStr(fHeight);
  SettingsFormNode.AddChild('ActivePage').Text := IntToStr(fActivePage);
end;

{ TLoginFormSettings }

procedure TLoginFormSettings.Load;

  procedure GetLeft;
  begin
    try
      fLeft := StrToInt(LoginFormNode.ChildNodes['Left'].Text);
    except
      fLeft := 0;
    end;
  end;

  procedure GetTop;
  begin
    try
      fTop := StrToInt(LoginFormNode.ChildNodes['Top'].Text);
    except
      fTop := 0;
    end;
  end;

begin
  LoginFormNode := SettingsNode.ChildNodes.FindNode('LoginForm');
  if not Assigned(LoginFormNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  GetLeft;
  GetTop;
end;

procedure TLoginFormSettings.LoadDefaults;
begin
  fLeft := 100;
  fTop := 100;
end;

procedure TLoginFormSettings.Save;
begin
  LoginFormNode := SettingsNode.ChildNodes.FindNode('LoginForm');
  if not Assigned(LoginFormNode) then
    LoginFormNode := SettingsNode.AddChild('LoginForm');
  LoginFormNode.AddChild('Left').Text := IntToStr(fLeft);
  LoginFormNode.AddChild('Top').Text := IntToStr(fTop);
end;

{ TPopupSettings }

procedure TPopupSettings.Load;

  procedure GetTopColor;
  begin
    try
      fTopColor := StringToColor(PopupNode.ChildNodes['TopColor'].Text);
    except
      fTopColor := clMoneyGreen;
    end;
  end;

  procedure GetBottomColor;
  begin
    try
      fBottomColor := StringToColor(PopupNode.ChildNodes['BottomColor'].Text);
    except
      fBottomColor := clTeal;
    end;
  end;

  procedure GetLinkColor;
  begin
    try
      fLinkColor := StringToColor(PopupNode.ChildNodes['LinkColor'].Text);
    except
      fLinkColor := clNavy;
    end;
  end;

  procedure GetTextColor;
  begin
    try
      fTextColor := StringToColor(PopupNode.ChildNodes['TextColor'].Text);
    except
      fTextColor := clBlack;
    end;
  end;

  procedure GetDuration;
  begin
    try
      fDuration := StrToInt(PopupNode.ChildNodes['Duration'].Text);
    except
      fDuration := 6;
    end;
  end;

  procedure GetPopup;
  begin
    try
      fPopup := StrToBool(PopupNode.ChildNodes['Popup'].Text);
    except
      fPopup := true;
    end;
  end;

  procedure GetDeleteOnOpen;
  begin
    try
      fDeleteOnOpen := StrToBool(PopupNode.ChildNodes['DeleteOnOpen'].Text);
    except
      fDeleteOnOpen := false;
    end;
  end;

begin
  PopupNode := SettingsNode.ChildNodes.FindNode('Popup');
  if not Assigned(PopupNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  GetTopColor;
  GetBottomColor;
  GetLinkColor;
  GetTextColor;
  GetDuration;
  GetPopup;
  GetDeleteOnOpen;
end;

procedure TPopupSettings.LoadDefaults;
begin
  fTopColor := clMoneyGreen;
  fBottomColor := clTeal;
  fLinkColor := clNavy;
  fTextColor := clBlack;
  fDuration := 6;
  fPopup := true;
  fDeleteOnOpen := false;
end;

procedure TPopupSettings.Save;
begin
  PopupNode := SettingsNode.ChildNodes.FindNode('Popup');
  if not Assigned(PopupNode) then
    PopupNode := SettingsNode.AddChild('Popup');
  PopupNode.AddChild('TopColor').Text := ColorToString(fTopColor);
  PopupNode.AddChild('BottomColor').Text := ColorToString(fBottomColor);
  PopupNode.AddChild('LinkColor').Text := ColorToString(fLinkColor);
  PopupNode.AddChild('TextColor').Text := ColorToString(fTextColor);
  PopupNode.AddChild('Duration').Text := IntToStr(fDuration);
  PopupNode.AddChild('Popup').Text := BoolToStr(fPopup, true);
  PopupNode.AddChild('DeleteOnOpen').Text := BoolToStr(fDeleteOnOpen, true);
end;

{ TTrackerSettings }

procedure TTrackerSettings.Load;

  procedure GetInterval;
  begin
    try
      fInterval := StrToint(TrackerNode.ChildNodes['Interval'].Text);
    except
      fInterval := 1;
    end;
  end;

  procedure GetUsers;
  var
    IgnoreUserNode: IXMLNode;
  begin
    IgnoreUserNode := TrackerNode.ChildNodes.FindNode('IgnoreUser');
    while Assigned(IgnoreUserNode) do
    try
      fNames.Add(IgnoreUserNode.ChildNodes['Name'].Text);
    finally
      IgnoreUserNode := IgnoreUserNode.NextSibling;
    end;
  end;

begin
  TrackerNode := SettingsNode.ChildNodes.FindNode('Tracker');
  if not Assigned(TrackerNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  GetInterval;
  GetUsers;
end;

constructor TTrackerSettings.Create;
begin
  fNames := TStringList.Create;
  fNames.Duplicates := dupIgnore;
end;

procedure TTrackerSettings.LoadDefaults;
begin
  fNames.Clear;
  fInterval := 1;
end;

procedure TTrackerSettings.Save;
var
  Index: integer;

  procedure AddUser;
  begin
    TrackerNode.AddChild('IgnoreUser').AddChild('Name').Text := fNames[Index];;
  end;

begin
  TrackerNode := SettingsNode.ChildNodes.FindNode('Tracker');
  if not Assigned(TrackerNode) then
    TrackerNode := SettingsNode.AddChild('Tracker');
  TrackerNode.AddChild('Interval').Text := IntToStr(fInterval);
  for Index := 0 to Pred(fNames.Count) do
    AddUser
end;

destructor TTrackerSettings.Destroy;
begin
  fNames.Free;
  inherited;
end;

procedure TTrackerSettings.AssignIgnoreUsers(Source: TStrings);
begin
  Assert(Assigned(Source), 'Settings.Tracker.IgnoreUser.Assign: Source is not Assigned');
  fNames.Assign(Source);
end;

procedure TTrackerSettings.AssignIgnoreUsersTo(Destination: TStrings);
begin
  Assert(Assigned(Destination), 'Settings.Tracker.IgnoreUser.AssignTo: Destination is not Assigned');
  Destination.Assign(fNames);
end;

{ TMainFormSettings }

constructor TMainFormSettings.Create;
begin
  fTabbar := TTabbarSettings.Create;
  fForum := TForumListSettings.Create;
  fFavorites := TFavoritesListSettings.Create;
  fSite := TSiteTreeSettings.Create;
  fForumSorting := TSortSettings.Create('Forum');
  fPMSorting := TSortSettings.Create('PM');
  fLinkSorting := TSortSettings.Create('Link');
  fNewsSorting := TSortSettings.Create('News');
  fFavoritesSorting := TSortSettings.Create('Favorites');
end;

destructor TMainFormSettings.Destroy;
begin
  fTabbar.Free;
  fForum.Free;
  fFavorites.Free;
  fSite.Free;
  fForumSorting.Free;
  fPMSorting.Free;
  fLinkSorting.Free;
  fNewsSorting.Free;
  fFavoritesSorting.Free;
  inherited;
end;

procedure TMainFormSettings.Load;

  procedure GetLeft;
  begin
    try
      fLeft := StrToInt(MainFormNode.ChildNodes['Left'].Text);
    except
      fLeft := 0;
    end;
  end;

  procedure GetTop;
  begin
    try
      fTop := StrToInt(MainFormNode.ChildNodes['Top'].Text);
    except
      fTop := 0;
    end;
  end;

  procedure GetWidth;
  begin
    try
      fWidth := StrToInt(MainFormNode.ChildNodes['Width'].Text);
    except
      fWidth := 580;
    end;
  end;

  procedure GetHeight;
  begin
    try
      fHeight := StrToInt(MainFormNode.ChildNodes['Height'].Text);
    except
      fHeight := 500;
    end;
  end;

  procedure GetWindowState;
  begin
    try
      fWindowState := TWindowState(StrToInt(MainFormNode.ChildNodes['WindowState'].Text));
    except
      fWindowState := wsNormal;
    end;
  end;

  procedure GetConfirmMultipleFavoritesDeletion;
  begin
    try
      fConfirmMultipleItemsDeletion :=
        StrToBool(MainFormNode.ChildNodes['Confirm'].ChildNodes['DeletionOfMultipleItems'].Text);
    except
      fConfirmMultipleItemsDeletion := false;
    end;
  end;

  procedure GetDeleteItemsAfterBeingRead;
  begin
    try
      fDeleteItemsAfterBeingRead :=
        StrToBool(MainFormNode.ChildNodes['DeleteItemsAfterRead'].Text);
    except
      fDeleteItemsAfterBeingRead := false;
    end;
  end;

begin
  MainFormNode := SettingsNode.ChildNodes.FindNode('MainForm');
  if not Assigned(MainFormNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  GetLeft;
  GetTop;
  GetWidth;
  GetHeight;
  GetWindowState;
  GetConfirmMultipleFavoritesDeletion;
  GetDeleteItemsAfterBeingRead;
  fTabbar.Load;
  fForum.Load;
  fFavorites.Load;
  fSite.Load;
  fForumSorting.Load;
  fPMSorting.Load;
  fLinkSorting.Load;
  fNewsSorting.Load;
  fFavoritesSorting.Load;
end;

procedure TMainFormSettings.LoadDefaults;
begin
  fleft := 100;
  fTop := 100;
  fWidth := 600;
  fHeight := 500;
  fWindowState := wsNormal;
  fConfirmMultipleItemsDeletion := true;
  fDeleteItemsAfterBeingRead := false;
  fTabbar.LoadDefaults;;
  fForum.LoadDefaults;
  fFavorites.LoadDefaults;
  fSite.LoadDefaults;
end;

procedure TMainFormSettings.Save;

  function WindowStatetext: string;
  begin
    Result := IntToStr(Integer(fWindowState));
  end;

begin
  MainFormNode := SettingsNode.ChildNodes.FindNode('MainForm');
  if not Assigned(MainFormNode) then
    MainFormNode := SettingsNode.AddChild('MainForm');
  MainFormNode.AddChild('Left').Text := IntToStr(fLeft);
  MainFormNode.AddChild('Top').Text := IntToStr(fTop);
  MainFormNode.AddChild('Width').Text := IntToStr(fWidth);
  MainFormNode.AddChild('Height').Text := IntToStr(fHeight);
  MainFormNode.AddChild('WindowState').Text := WindowStateText;
  MainFormNode.AddChild('Confirm').AddChild('DeletionOfMultipleItems').Text :=
    BoolToStr(fConfirmMultipleItemsDeletion, true);
  MainFormNode.AddChild('DeleteItemsAfterRead').Text := BoolToStr(fDeleteItemsAfterBeingRead, true);
  fTabbar.Save;
  fForum.Save;
  fFavorites.Save;
  fSite.Save;
  fForumSorting.Save;
  fPMSorting.Save;
  fLinkSorting.Save;
  fNewsSorting.Save;
  fFavoritesSorting.Save;
end;

{ TTabbarSettings }

procedure TTabbarSettings.Load;

  procedure GetAlignToTop;
  begin
    try
      fAlignToTop := StrToBool(MainFormNode.ChildNodes['TabBar'].ChildNodes['AlignToTop'].Text);
    except
      fAlignToTop := true;
    end;
  end;

begin
  GetAlignToTop;
end;

procedure TTabbarSettings.LoadDefaults;
begin
  fAlignToTop := true;
end;

procedure TTabbarSettings.Save;
begin
  MainFormNode.AddChild('TabBar').AddChild('AlignToTop').Text := BoolToStr(fAlignToTop, true);
end;

{ TForumListSettings }

procedure TForumListSettings.Load;

  procedure GetDeleteOnMoveTofavorites;
  begin
    try
      fDeleteNodesAfterAddingToFavorites :=
        StrToBool(MainFormNode.ChildNodes['Forum'].ChildNodes['DeleteOnMoveToFavorites'].Text);
    except
      fDeleteNodesAfterAddingToFavorites := false;
    end;
  end;

begin
  GetDeleteOnMoveTofavorites;
end;

procedure TForumListSettings.LoadDefaults;
begin
  fDeleteNodesAfterAddingToFavorites := false;
end;

procedure TForumListSettings.Save;
begin
  MainFormNode.AddChild('Forum').AddChild('DeleteOnMoveToFavorites').Text :=
    BoolToStr(fDeleteNodesAfterAddingToFavorites, true);
end;

{ TFavoritesListSettings }

procedure TFavoritesListSettings.Load;

  procedure GetConfirmGroupDeletion;
  begin
    try
      fConfirmGroupDeletion :=
        StrToBool(MainFormNode.ChildNodes['Favorites'].ChildNodes['Confirm'].ChildNodes['DeletionOfGroup'].Text);
    except
      fConfirmGroupDeletion := false;
    end;
  end;

begin
  GetConfirmGroupDeletion;
end;

procedure TFavoritesListSettings.LoadDefaults;
begin
  fConfirmGroupDeletion := true;
end;

procedure TFavoritesListSettings.Save;
begin
  MainFormNode.AddChild('Favorites').AddChild('Confirm').AddChild('DeletionOfGroup').Text :=
    BoolToStr(fConfirmGroupDeletion, true);
end;

{ TSiteTreeSettings }

procedure TSiteTreeSettings.Load;

  procedure GetColorStyle;
  begin
    try
      fColorStyle := TColorStyle(StrToInt(MainFormNode.ChildNodes['Site'].ChildNodes['ColorStyle'].Text));
    except
      fColorStyle := csNLDelphiVB3Style;
    end;
    if not (fColorStyle in [Low(TColorStyle)..High(TColorStyle)]) then
      fColorStyle := csNLDelphiVB3Style;
  end;

begin
  GetColorStyle;
end;

procedure TSiteTreeSettings.LoadDefaults;
begin
  fColorStyle := csNLDelphiVB3Style;
end;

procedure TSiteTreeSettings.Save;

  function ColorStyleText: string;
  begin
    Result := IntToStr(Integer(fColorStyle));
  end;

begin
  MainFormNode.AddChild('Site').AddChild('ColorStyle').Text := ColorStyleText;
end;

{ TSortSettings }

constructor TSortSettings.Create(Section: string);
begin
  fSection := Section;
end;

procedure TSortSettings.Load;

  procedure GetSortColumn;
  begin
    try
      fColumn := StrToInt(SortNode.ChildNodes[fSection].ChildNodes['SortColumn'].Text);
    except
      fColumn := 0;
    end;
  end;

  procedure GetSortDirection;
  begin
    try
      fDirection := StrToInt(SortNode.ChildNodes[fSection].ChildNodes['SortDirection'].Text);
    except
      fDirection := 1;
    end;
  end;

begin
  SortNode := SettingsNode.ChildNodes.FindNode('Sorting');
  if not Assigned(SortNode) then
  begin
    LoadDefaults;
    Exit;
  end;
  GetSortColumn;
  GetSortDirection;
end;

procedure TSortSettings.LoadDefaults;
begin
  fColumn := 0;
  fDirection := 1;
end;

procedure TSortSettings.Save;

  function SortColumnText: string;
  begin
    Result := IntToStr(fColumn);
  end;

  function SortDirectionText: string;
  begin
    Result := IntToStr(fDirection);
  end;

var
  TheNode: IXMLNode;
begin
  SortNode := SettingsNode.ChildNodes.FindNode('Sorting');
  if not Assigned(SortNode) then
    SortNode := SettingsNode.AddChild('Sorting');
  TheNode := SortNode.AddChild(fSection);
  TheNode.AddChild('SortColumn').Text := SortColumnText;
  TheNode.AddChild('SortDirection').Text := SortDirectionText;
end;

end.
