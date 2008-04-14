//////////////////////////////////////////////////////////////////////////////
//                                                                          //
//  NLDTrayIcon  -  A component that provides minimization to system tray   //
//                                                                          //
//  V2.1                                                                    //
//                                                                          //
//  Features:                                                               //
//  - Animation of tray icon                                                //
//  - Balloon tips                                                          //
//  - Restore application with double-click                                 //
//  - Right-click popup menu                                                //
//  - Decide when to show tray icon and taskbar button                      //
//  - Hint                                                                  //
//  - Restores tray icon in case of Windows Explorer crash                  //
//  - Ready for creation of custom descendent                               //
//                                                                          //
//  By NLDelphi.com members ®2006                                           //
//                                                                          //
//  Initiator: Stijn van Grinsven                                           //
//  Last edit: Sept 24, 2006 by Albert de Weerd                             //
//  See also: http://www.nldelphi.com/Forum/forumdisplay.php?f=48           //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
//  Change history                                                          //
//  --------------                                                          //
//                                                                          //
//  #13 10-02-2007 by Albert de Weerd (NGLN)                                //
//  -----------------------------------------------------                   //
//  - Fixed: Handle to Icon was never destroyed and caused "System out of   //
//    resources"                                                            //
//                                                                          //
//  #12 14-09-2006 by Albert de Weerd (NGLN)                                //
//  -----------------------------------------------------                   //
//  - Changed: CompilerVersion.inc expanded with new versions up to D2006   //
//  - Changed: Unit layout drastically cleaned                              //
//  - Added: Custom component type for possible future descendent creation  //
//  - Fixed: Got rid of unnecessary DFM-pollution: now all properties are   //
//           stored properly.                                               //
//  - Fixed: Now the OnRMouseClick event is called even if PopupMenu isn't  //
//           assigned. In that case, the DoPopup parameter is False by      //
//           default.                                                       //
//  - Changed: Moved {$R *.dcr} to package file                             //
//  - Changed: Unit CommCtrl moved to implementation section                //
//  - Fixed: Setting property AnimateIndex always called the OnTimer event, //
//           even when AnimateEnabled was False.                            //
//  - Fixed: Most property setters didn't check for same value              //
//  - Changed: Private field Icon renamed to FIcon                          //
//  - Deleted: Type declaration of pIcon wasn't used (anymore?)             //
//  - Added: Type TApplicationLocation                                      //
//  - Changed: NLDelphi flag added to component icon                        //
//                                                                          //
//  #11 13-12-2005 by MvdH (Mark HendriX)                                   //
//  -------------------------------------                                   //
//  - Fixed: Windows log-off/shutdown fails due to NLTrayIcon               //
//  - Fixed: Access Violation if MainForm is nil                            //
//                                                                          //
//  #10 17-09-2003 by PsychoMark (www.x2software.net)                       //
//  -------------------------------------------------                       //
//  - Added: Property ImageIndex: Enables the use of the ImageList even if  //
//           AnimateEnabled is False.                                       //
//                                                                          //
//  #9 14-08-2003 by Remmelt Koenes (www.triplesoftware.com)                //
//  --------------------------------------------------------                //
//  - Added: ShowBalloon now is a function and will return a boolean on     //
//           sucsesful creating a balloonHint.                              //
//  - Added: HideBalloon is a function that will hide the balloonhint by    //
//           by code. It will fire the OnBalloonHide event and will return  //
//           a boolean on succesful hidding a balloonHint.                  //
//  - Fixed: OnBalloonHide.                                                 //
//  - Changed: The Balloon hint is now a unit global variable.              //
//                                                                          //
//  #8 14-08-2003 by PsychoMark (www.x2software.net)                        //
//  ------------------------------------------------                        //
//  - Fixed: WM_TASKBAR_CREATED was using a hardcoded value (baaaaaad bug), //
//           now uses RegisterWindowMessage to check for the correct value. //
//                                                                          //
//  #7 08-08-2003 by PsychoMark (www.x2software.net)                        //
//  ------------------------------------------------                        //
//  - Added: RestoreApp function which restores the tray-minimized          //
//           application, also called if ComeToFront is set to True.        //
//           Application.Restore was already available, but this function   //
//           enables future additions if necessary without breaking any     //
//           code.                                                          //
//                                                                          //
//  #6 07-08-2003 by PsychoMark (www.x2software.net)                        //
//  ------------------------------------------------                        //
//  - Added: Feference to NLDTrayIcon.DCR for component icon                //
//  - Fixed: (De)AllocateHwnd now uses the Classes version if using D6 or   //
//           higher (also requires CompilerVersion.inc to determine D6      //
//           now), eliminates the deprecated warnings.                      //
//  - Fixed: SetIcon and FOnBalloonHide were not used but not commented     //
//           out either, caused warnings/hints.                             //
//  - Fixed: Moved component to NLDelphi tab instead of SVG tab to conform  //
//           to the NLDelphi Open-Source component standards.               //
//  - Fixed: Changed the package description to just 'NLDTrayIcon', makes   //
//           it MUCH easier to search for it in the Install Packages list   //
//  - Fixed: Removed dependancy on Dialogs and Math, don't seem to be       //
//           necessary. Haven't tested this in D5 and below, so I'm sorry   //
//           if it breaks any code on those version.                        //
//                                                                          //
//  #5 10-04-2003 by Remmelt Koenes (www.triplesoftware.com)                //
//  --------------------------------------------------------                //
//  - Added feature: Ballon Functions                                       //
//    - Balloon Click                                                       //
//    - Balloon Show                                                        //
//    - Balloon Hide  (This one does not work some how)                     //
//    - Balloon TimeOut                                                     //
//                                                                          //
//  #4 27-12-2002 by ?                                                      //
//  ------------------                                                      //
//  Added feature: Animation in Tray                                        //
//  - Property AutoSwitch = Boolean:                                        //
//      When True, it will animate the icon in the tray                     //
//  - Property AutoDelat = DWord:                                           //
//      The interval between every icon-switch                              //
//  - Property ImageList = TImageList:                                      //
//      The list of images where the icons for animation is stored          //
//  - Property AnimateIndex = Word:                                         //
//      The icon currently showing                                          //
//                                                                          //
//  #3 19-09-2002 by MendriX ICT (www.mendrix.nl)                           //
//  ---------------------------------------------                           //
//  - Component is made compatible with the use of:                         //
//    Application.ShowMainForm := False; with SomeMainForm.Visible := False //
//    which is considered as being minimized                                //
//  - From now on a short-cuts Minimized/Normal/Maximized setting is also   //
//    respected                                                             //
//                                                                          //
//  #2 19-09-2002 by MendriX ICT (www.mendrix.nl)                           //
//  ---------------------------------------------                           //
//  - Property MainFormOverruled:                                           //
//      Overrules Application.MainForm at any time, for behaviour as        //
//      'Close means terminate' and 'minimize means app. minimizes'         //
//  - Property LocationMinimized = [loSysTray, loTaskBar]:                  //
//      Determines where minimized application is shown:                    //
//      taskbar and/or systray                                              //
//  - Property LocationNormal = [loSysTray, loTaskBar]:                     //
//      Fetermines where normal application is shown:                       //
//      taskbar and/or systray                                              //
//                                                                          //
//  #1 19-09-2002 by ?                                                      //
//  ------------------                                                      //
//  - Some efficiency improvements: some methods were called multiple times //                                                       //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

unit NLDTrayIcon;

interface

uses
  Messages, Menus, Windows, Classes, ShellApi, Graphics, SysUtils, Controls,
  AppEvnts, ExtCtrls, ImgList, Forms;

const
  WM_TRAYICON        = WM_USER + 1;
  WM_TRAYICON_UPDATE = WM_USER + 2;
  {#5 Rckoenes >>>}
  WM_BALLOONSHOW     = WM_USER + 2;
  WM_BALLOONHIDE     = WM_USER + 3; // zou moeten werken maar doet het niet :(
  WM_BALLOONTIMEOUT  = WM_USER + 4;
  WM_BALLOONCLICK    = WM_USER + 5;
  {<<< Rckoenes}
  WM_BALLOONMSG      = WM_USER + 3;
  NIIF_NONE          = $00000000;
  NIIF_INFO          = $00000001;
  NIIF_WARNING       = $00000002;
  NIIF_ERROR         = $00000003;
  NIF_INFO           = $00000010;

var
  WM_TASKBAR_CREATED: Cardinal; {#8 PsychoMark}

type
  TPopupNotify = procedure(Sender: TPopupMenu; var DoPopup: Boolean) of object;

//  pIcon = ^TIcon; {#12 NGLN}

  {#5 Rckoenes >>>}
  TNotifyIconData_TipInfo = record // defined in shellapi.h
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array[0..MAXCHAR] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array[0..MAXBYTE] of AnsiChar;
    uTimeout: UINT;
    szInfoTitle: array[0..63] of AnsiChar;
    dwInfoFlags: DWORD;
  end;
  {<<< Rckoenes}

  TTimeout  = 10..30; // seconds

  TIconType = (bitNone,    // no icon
               bitInfo,    // icon: information
               bitWarning, // icon: warning
               bitError);  // icon: error

  TApplicationLocation = (loTaskBar, loSysTray); {#12 NGLN}
  TApplicationLocations = set of TApplicationLocation;

  TNLDCustomTrayIcon = class(TComponent) {#12 NGLN}
  private
    FActive: Boolean;
    FAnimateEnabled: Boolean;
    FAnimateIndex: Word;
    FAnimateInterval: DWord;
    FApplicationEvents: TApplicationEvents;
    FBalloonTip: TNotifyIconData_TipInfo; {#5 Rckoenes}
    FComeToFront: Boolean;
    FFilename: TFileName;
    FFirstRestoreOrMinimize: Boolean;
    FHiddenOnTaskBar: Boolean;
    FHint: String;
    FIcon: TIcon; {#12 NGLN}
    FImageIndex: TImageIndex; {#10 PsychoMark}
    FImageList: TImageList;
    FInternTimer: TTimer;
    FLocationMinimized: TApplicationLocations;
    FLocationNormal: TApplicationLocations;
    {#5 Rckoenes >>>}
    FOnBalloonClick: TNotifyEvent;
    FOnBalloonShow: TNotifyEvent;
    FOnBalloonHide: TNotifyEvent; {PsychoMark}
    FOnBalloonTimeout: TNotifyEvent;
    {<<< Rckoenes}
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnPopup: TNotifyEvent;
    FOnRMouseClick: TPopupNotify;
    FPopup: Boolean;
    FPopupMenu: TPopupMenu;
    FShowHint: Boolean;
    MNic: TNotifyIconData;
    Wnd: THandle;
    procedure ApplicationMinimizeHandler(Sender: TObject);
    procedure ApplicationRestoreHandler(Sender: TObject);
    procedure CaptureMsg(var Msg: TMessage); message WM_TRAYICON;
    procedure DoOnTimer(Sender: TObject);
    function GetMainFormOverruled: TCustomForm;
    procedure MakeInTray(Flag: Byte);
    procedure MakeOnTaskBar;
    procedure Minimize;
    procedure Restore;
    procedure SetActive(const Value: Boolean);
    procedure SetAnimateIndex(const Value: Word);
    procedure SetAnimateInterval(const Value: DWORD);
    procedure SetAnimateEnabled(const Value: Boolean);
    procedure SetHint(const Value: String);
    {#10 PsychoMark >>>}
    //procedure SetIcon(IconHandle: THandle);
    procedure SetImageIndex(const Value: TImageIndex);
    {<<< PsychoMark}
    procedure SetLocationMinimized(const Value: TApplicationLocations);
    procedure SetLocationNormal(const Value: TApplicationLocations);
    procedure SetMainFormOverruled(const Value: TCustomForm);
    function ShouldShowInTray: Boolean;
    function ShouldShowOnTaskBar: Boolean;
  protected
    {#12 NGLN >>>}
    procedure DoBalloonClick; virtual;
    procedure DoBalloonHide; virtual;
    procedure DoBalloonShow; virtual;
    procedure DoBalloonTimeOut; virtual;
    procedure DoClick; virtual;
    procedure DoDblClick; virtual;
    procedure DoPopup; virtual;
    procedure DoRMouseClick; virtual;
    property Active: Boolean read FActive write SetActive;
    property AnimateEnabled: Boolean read FAnimateEnabled
      write SetAnimateEnabled;
    property AnimateIndex: Word read FAnimateIndex write SetAnimateIndex;
    property AnimateInterval: DWORD read FAnimateInterval
      write SetAnimateInterval;
    property ComeToFront: Boolean read FComeToFront write FComeToFront;
    property Filename: TFileName read FFilename write FFilename;
    property Hint: String read FHint write SetHint;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex; {#10 PsychoMark}
    property ImageList: TImageList read FImageList write FImageList;
    property LocationMinimized: TApplicationLocations read FLocationMinimized
      write SetLocationMinimized;
    property LocationNormal: TApplicationLocations read FLocationNormal
      write SetLocationNormal;
    property Popup: Boolean read FPopup write FPopup;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property ShowHint: Boolean read FShowHint write FShowHint;
    {#5 Rckoenes >>>}
    property OnBalloonClick: TNotifyEvent read FOnBalloonClick
      write FOnBalloonClick;
    property OnBalloonHide: TNotifyEvent read FOnBalloonHide
      write FOnBalloonHide;
    property OnBalloonShow: TNotifyEvent read FOnBalloonShow
      write FOnBalloonShow;
    property OnBalloonTimeOut: TNotifyEvent read FOnBalloonTimeOut
      write FOnBalloonTimeOut;
    {<<< Rckoenes}
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnPopup: TNotifyEvent read FOnPopUp write FOnPopUp;
    property OnRMouseClick: TpopUpNotify read FOnRmouseClick
      write FOnRmouseClick;
    {<<< NGLN}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HideBalloon: Boolean;
    property MainFormOverruled: TCustomForm read GetMainFormOverruled
      write SetMainFormOverruled;
    function PopBalloon(const BalloonText, BalloonTitle: String;
      const IconID: TIconType; const TimeOut: TTimeout = 10): Boolean;
    procedure RestoreApp; {#7 PsychoMark}
    procedure Update;
  end;

  {#12 NGLN >>>}
  TNLDTrayIcon = class(TNLDCustomTrayIcon)
  published
    property Active default False;
    property AnimateEnabled default False;
    property AnimateIndex default 1;
    property AnimateInterval default 1000;
    property ComeToFront default False;
    property Filename;
    property Hint;
    property ImageIndex default -1;
    property ImageList;
    property LocationMinimized default [loSysTray];
    property LocationNormal default [loTaskBar, loSysTray];
    property Popup default False;
    property PopupMenu;
    property ShowHint default False;
    property OnBalloonClick;
    property OnBalloonHide;
    property OnBalloonShow;
    property OnBalloonTimeOut;
    property OnClick;
    property OnDblClick;
    property OnPopup;
    property OnRMouseClick;
  end;
  {<<< NGLN}

procedure Register;

implementation

{$I CompilerVersion.inc} {#6 PsychoMark}

uses
  CommCtrl;

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDTrayIcon]); {#6 PsychoMark}
end;

{ TNLDCustomTrayIcon }

procedure TNLDCustomTrayIcon.ApplicationMinimizeHandler(Sender: TObject);
begin
  MakeInTray(0);
  MakeOnTaskBar;
end;

procedure TNLDCustomTrayIcon.ApplicationRestoreHandler(Sender: TObject);
begin
  MakeInTray(0);
  MakeOnTaskBar;
end;

procedure TNLDCustomTrayIcon.CaptureMsg(var Msg: Tmessage);
begin
  case Msg.Msg of
    WM_TRAYICON_UPDATE:
      begin
        MakeInTray(0);
        MakeOnTaskBar;
      end;
    WM_TRAYICON:
      case Msg.LParam of
        WM_LBUTTONDBLCLK: DoDblClick;
        WM_LBUTTONDOWN: DoClick;
        WM_RBUTTONDOWN: DoRMouseClick;
        {#5 Rckoenes >>>}
        WM_BALLOONCLICK: DoBalloonClick;
        WM_BALLOONHIDE: DoBalloonHide;
        WM_BALLOONSHOW: DoBalloonShow;
        WM_BALLOONTIMEOUT: DoBalloonTimeOut;
        {<<< Rckoenes}
      end;
    WM_ACTIVATEAPP:
      if Msg.LParam = 1576 then
        RestoreApp(); {#7 PsychoMark}
    else
      if Msg.Msg = WM_TASKBAR_CREATED then
        MakeInTray(0)
      else
        {#11 Mendix >>>}
        Msg.Result := DefWindowProc(Wnd, Msg.Msg, Msg.WParam, Msg.LParam);
        {<<< Mendrix}
  end;
end;

constructor TNLDCustomTrayIcon.Create(AOwner: TComponent);
begin
  inherited;
  Wnd := {$IFDEF D6}Classes.{$ENDIF}AllocateHwnd(CaptureMsg); {#6 PsychoMark}
  FImageIndex := -1; {#10 PsychoMark}
  PostMessage(Wnd, WM_TRAYICON_UPDATE, 0, 0);
  FFirstRestoreOrMinimize := False;
  FLocationMinimized := [loSysTray];
  FLocationNormal := [loTaskBar, loSysTray];
  FHiddenOnTaskBar := False;
  FApplicationEvents := TApplicationEvents.Create(Self);
  FApplicationEvents.OnMinimize := ApplicationMinimizeHandler;
  FApplicationEvents.OnRestore := ApplicationRestoreHandler;
  FAnimateIndex := 1;
  FAnimateInterval := 1000;
  FInternTimer := TTimer.Create(Self);
  FInternTimer.OnTimer := DoOnTimer;
  FIcon := TIcon.Create;
end;

destructor TNLDCustomTrayIcon.Destroy;
begin
  try
    if Wnd <> 0 then
      {$IFDEF D6}Classes.{$ENDIF}DeallocateHwnd(Wnd); {#6 PsychoMark}
    if Assigned(FIcon) then
      FreeAndNil(FIcon);
    if Assigned(FInternTimer) then
      FreeAndNil(FInternTimer);
    inherited;
  finally
    Shell_NotifyIcon(NIM_DELETE, @MNic);
  end;
end;

procedure TNLDCustomTrayIcon.DoBalloonClick;
begin
  if Assigned(FOnBalloonClick) then
    FOnBalloonClick(Self);
end;

procedure TNLDCustomTrayIcon.DoBalloonHide;
begin
  if Assigned(FOnBalloonHide) then
    FOnBalloonHide(Self);
end;

procedure TNLDCustomTrayIcon.DoBalloonShow;
begin
  if Assigned(FOnBalloonShow) then
    FOnBalloonShow(Self);
end;

procedure TNLDCustomTrayIcon.DoBalloonTimeOut;
begin
  if Assigned(FOnBalloonTimeOut) then
    FOnBalloonTimeOut(Self);
end;

procedure TNLDCustomTrayIcon.DoClick;
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TNLDCustomTrayIcon.DoDblClick;
begin
  if FComeToFront then
    RestoreApp(); {#7 PsychoMark}
  if Assigned(FOnDblClick) then
    FOnDblClick(Self);
end;

procedure TNLDCustomTrayIcon.DoOnTimer(Sender: TObject);
var
  Icon: TIcon;
begin
  if not Assigned(ImageList) then
    Exit;
  if FAnimateIndex > ImageList.Count - 1 then
    FAnimateIndex := 0;
  Icon := TIcon.Create;
  try
    ImageList.GetIcon(FAnimateIndex, Icon);
    MNic.hIcon := Icon.Handle;
    Shell_NotifyIcon(NIM_MODIFY, @MNic);
  finally
    Icon.Free;
  end;
  Inc(FAnimateIndex, 1);
end;

procedure TNLDCustomTrayIcon.DoPopup;
begin
  if Assigned(FOnPopup) then
    FOnPopup(FPopupMenu);
end;

procedure TNLDCustomTrayIcon.DoRMouseClick;
var
  DoPop: Boolean;
  Pt: TPoint;
begin
  {#12 NGLN >>>}
  DoPop := Assigned(FPopupMenu);
  if Assigned(FOnRMouseClick) then
    FOnRMouseClick(FPopupMenu, DoPop);
  if Assigned(FPopupMenu) and DoPop and FPopup then
  {<<< NGLN}
  begin
    GetCursorPos(Pt);
    DoPopup;
    FPopupMenu.Popup(Pt.X, Pt.Y);
  end;
end;

function TNLDCustomTrayIcon.GetMainFormOverruled: TCustomForm;
begin
  Result := Application.MainForm;
end;

function TNLDCustomTrayIcon.HideBalloon: Boolean;
begin
  with FBalloonTip do
  begin
    uFlags := uFlags or NIF_INFO;
    StrPCopy(szInfo, '');
  end;
  Result := Shell_NotifyIcon(NIM_modify, @FBalloonTip)
end;

procedure TNLDCustomTrayIcon.MakeInTray(Flag: Byte);
begin
  if ([csDesigning,csLoading] * ComponentState) <> [] then
    Exit;
  if FActive and ShouldShowInTray then
  begin
    with MNic do
    begin
      cbSize := SizeOf(TNotifyIconData);
      Wnd := Self.Wnd;
      uID := 1;
      uCallbackMessage := WM_TRAYICON;
      if FileExists(FFilename) then
      begin
        FIcon.LoadFromFile(FFilename);
        hIcon := FIcon.Handle;
      end
      else
        {#10 PsychoMark >>>}
        if (Assigned(FImageList)) and (FImageIndex > -1) then
        begin
          {13 NGLN >>>>}
          if hIcon <> 0 then
            DestroyIcon(hIcon);
          {<<<< NGLN}
          hIcon := ImageList_GetIcon(FImageList.Handle, FImageIndex, 0)
          {<<< PsychoMark}
        end
        else
          hIcon := Application.Icon.Handle;
      uFlags := NIF_MESSAGE or NIF_ICON;
      if FShowHint then
      begin
        uFlags := uFlags or NIF_TIP;
        FillChar(szTip, Length(szTip), 0);
        StrPCopy(szTip, FHint);
      end;
    end;
    if Flag = 0 then
      Shell_NotifyIcon(NIM_ADD, @MNic)
    else
      Shell_NotifyIcon(NIM_MODIFY, @MNic);
  end
  else
    Shell_NotifyIcon(NIM_DELETE, @MNic);
end;

procedure TNLDCustomTrayIcon.MakeOnTaskBar;
begin
  if ([csDesigning, csLoading] * ComponentState) <> [] then
    Exit;
  if IsIconic(Application.Handle) then
    Minimize
  else
    Restore;
  FFirstRestoreOrMinimize := True;
end;

procedure TNLDCustomTrayIcon.Minimize;
begin
  if Active then
    if ShouldShowOnTaskBar then
      ShowWindow(Application.Handle, SW_SHOW)
    else
      ShowWindow(Application.Handle, SW_HIDE);
end;

function TNLDCustomTrayIcon.PopBalloon(const BalloonText, BalloonTitle: String;
  const IconID: TIconType; const TimeOut: TTimeout = 10): Boolean;
const
  BalloonIconTypes: array[TIconType] of Byte =
    (NIIF_NONE, NIIF_INFO, NIIF_WARNING, NIIF_ERROR);
{#5 Rckoenes >>>
var
  NID: TNotifyIconData_TipInfo;
<<< Rckoenes}
begin
  FillChar({NID}FBalloonTip, SizeOf(TNotifyIconData_TipInfo), 0);
  with FBalloonTip do
  begin
    cbSize := SizeOf(TNotifyIconData_TipInfo);
    Wnd := Self.Wnd;
    uID := 1;
    uFlags := NIF_INFO;
    StrPCopy(szInfo, BalloonText);
    uTimeout := Timeout * 1000;
    StrPCopy(szInfoTitle, BalloonTitle);
    uCallbackMessage := WM_TRAYICON;
    dwInfoFlags := BalloonIconTypes[IconId];
  end;
  Result := Shell_NotifyIcon(NIM_MODIFY, @FBalloonTip);
end;

procedure TNLDCustomTrayIcon.Restore;
begin
  if not Active then
    Exit;
  SetForegroundWindow(Application.Handle); // otherwise sometimes all in backgr
  ShowWindow(Application.Handle, SW_RESTORE); // redundant?
  repeat
    if Assigned(Application.MainForm) then // show mainform
      if not FFirstRestoreOrMinimize then
      begin
        if not Application.ShowMainForm
          or (Application.MainForm.WindowState = wsMinimized)
          or not Application.MainForm.Visible then
        begin
          Application.Minimize;
          Break;
        end;
        {#11 Mendrix >>>}
        // next was outside following end;, which could cause AV's
        Application.MainForm.Show;
        {<<< Mendrix}
      end;
  until True;
  if not ShouldShowOnTaskBar then // hide on taskbar if needed
    ShowWindow(Application.Handle, SW_HIDE);
end;

{#7 PsychoMark >>>}
procedure TNLDCustomTrayIcon.RestoreApp;
begin
  Application.Restore;
end;
{<<< PsychoMark}

procedure TNLDCustomTrayIcon.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    MakeInTray(0);
    MakeOnTaskBar;
    FInternTimer.Enabled := FActive And FAnimateEnabled;
  end;
end;

procedure TNLDCustomTrayIcon.SetAnimateEnabled(const Value: Boolean);
begin
  if FAnimateEnabled <> Value then
  begin
    FAnimateEnabled := Value;
    FInternTimer.Enabled := FActive and FAnimateEnabled;
    if not FAnimateEnabled then
      with MNic do
      begin
        if FileExists(FFilename) then
        begin
          FIcon.LoadFromFile(FFilename);
          hIcon := FIcon.Handle;
        end
        else
          {#10 PsychoMark >>>}
          if (Assigned(FImageList)) and (FImageIndex > -1) then
            hIcon := ImageList_GetIcon(FImageList.Handle, FImageIndex, 0)
            {<<< PsychoMark}
          else
            hIcon := Application.Icon.Handle;
      end;
    Shell_NotifyIcon(NIM_MODIFY, @MNic);
  end;
end;

procedure TNLDCustomTrayIcon.SetAnimateIndex(const Value: Word);
begin
  if FAnimateIndex <> Value then
  begin
    FAnimateIndex := Value;
    if ([csDesigning, csLoading] * ComponentState) <> [] then
      Exit;
    if FAnimateEnabled then {#12 NGLN}
      DoOnTimer(nil);
  end;
end;

procedure TNLDCustomTrayIcon.SetAnimateInterval(const Value: DWORD);
begin
  if FAnimateInterval <> Value then
  begin
    FAnimateInterval := Value;
    FInternTimer.Interval := Value;
  end;
end;

procedure TNLDCustomTrayIcon.SetHint(const Value: String);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    with MNic do
    begin
      FillChar(szTip, Length(szTip), 0);
      StrPCopy(szTip, Value);
    end;
    Shell_NotifyIcon(NIM_MODIFY, @MNic);
  end;
end;

{#6 PsychoMark >>>
procedure TNLDTrayIcon.SetIcon(IconHandle: THandle);
begin
  with MNic do
    hIcon := IconHandle;
  Shell_NotifyIcon(NIM_MODIFY, @MNic);
end;
<<< PsychoMark}

{#10 PsychoMark >>>}
procedure TNLDCustomTrayIcon.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    MakeInTray(1);
  end;
end;
{<<< PsychoMark}

procedure TNLDCustomTrayIcon.SetLocationMinimized(
  const Value: TApplicationLocations);
begin
  if ((Value * [loTaskBar]) = (LocationMinimized * [loTaskBar]))
    and ((Value * [loSysTray]) = (LocationMinimized * [loSysTray])) then
    Exit;
  FLocationMinimized := Value;
  MakeInTray(0);
  MakeOnTaskBar;
end;

procedure TNLDCustomTrayIcon.SetLocationNormal(
  const Value: TApplicationLocations);
begin
  if ((Value * [loTaskBar]) = (LocationNormal * [loTaskBar]))
    and ((Value * [loSysTray]) = (LocationNormal * [loSysTray])) then
    Exit;
  FLocationNormal := Value;
  MakeInTray(0);
  MakeOnTaskBar;
end;

procedure TNLDCustomTrayIcon.SetMainFormOverruled(const Value: TCustomForm);
begin
  Pointer(Pointer(@Application.Mainform)^) := Value;
end;

function TNLDCustomTrayIcon.ShouldShowInTray: Boolean;
begin
  if not Active then
    Result := False
  else
    if IsIconic(Application.Handle) then
      Result := (loSysTray in LocationMinimized)
    else
      Result := (loSysTray in LocationNormal)
end;

function TNLDCustomTrayIcon.ShouldShowOnTaskBar: Boolean;
begin
  if not Active then
    Result := True
  else
    if IsIconic(Application.Handle) then
      Result := (loTaskBar in LocationMinimized)
    else
      Result := (loTaskBar in LocationNormal)
end;

procedure TNLDCustomTrayIcon.Update;
begin
  MakeInTray(1);
  MakeOnTaskBar;
end;

initialization
  {#8 PsychoMark}
  WM_TASKBAR_CREATED := RegisterWindowMessage('TaskbarCreated');

end.
