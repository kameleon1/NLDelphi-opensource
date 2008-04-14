unit NLDMsgBox;

{
  :: NLDMessageBox is an extension to the MessageBox API. It adds several
  :: enhancements, such as automatic closing after a set number of seconds
  :: or adding a "Don't show this again" checkbox, while maintaining Windows
  :: compatibility (most noticably: the language and shortcuts of the
  :: available buttons).

  :$
  :$
  :$ NLDMessageBox is released under the zlib/libpng OSI-approved license.
  :$ For more information: http://www.opensource.org/
  :$ /n/n
  :$ /n/n
  :$ Copyright (c) 2003 M. van Renswoude
  :$ /n/n
  :$ This software is provided 'as-is', without any express or implied warranty.
  :$ In no event will the authors be held liable for any damages arising from
  :$ the use of this software.
  :$ /n/n
  :$ Permission is granted to anyone to use this software for any purpose,
  :$ including commercial applications, and to alter it and redistribute it
  :$ freely, subject to the following restrictions:
  :$ /n/n
  :$ 1. The origin of this software must not be misrepresented; you must not
  :$ claim that you wrote the original software. If you use this software in a
  :$ product, an acknowledgment in the product documentation would be
  :$ appreciated but is not required.
  :$ /n/n
  :$ 2. Altered source versions must be plainly marked as such, and must not be
  :$ misrepresented as being the original software.
  :$ /n/n
  :$ 3. This notice may not be removed or altered from any source distribution.
}

interface
uses
  Windows,
  Messages,
  Classes,
  // Delphi 5 and lower define MakeObjectInstance in the Forms unit instead
  // of Classes.
  {$IFNDEF VER140}
  Forms,
  {$ENDIF}
  SysUtils,
  Graphics,
  NLDMBHookInstance;


type
  //:$ Wraps the MessageBox flags.
  //:: These values correspond to the various MB_* constants, look up
  //:: MessageBox in de Win32 SDK Help for more information.
  TNLDMessageBoxStyle   = (mbOk, mbOkCancel, mbAbortRetryIgnore, mbYesNoCancel,
                           mbYesNo, mbRetryCancel,

                           mbIconHand, mbIconQuestion,
                           mbIconExclamation, mbIconAsterisk, mbIconWarning,
                           mbIconError, mbIconInformation, mbIconStop,

                           mbDefButton1, mbDefButton2, mbDefButton3, mbDefButton4,
                           mbApplModal, mbSystemModal, mbTaskModal, mbHelp,
                           mbNoFocus, mbSetForeground, mbDefaultDesktopOnly,
                           mbTopMost, mbRight, mbRtlReading,
                           mbServiceNotification, mbServiceNotificationNT3X);

  TNLDMessageBoxStyles  = set of TNLDMessageBoxStyle;

  //:$ Wraps the MessageBox result constants.
  //:: These values correspond to the various ID_* constants, look up
  //:: MessageBox in de Win32 SDK Help for more information.
  TNLDMessageBoxResult = (idOK, idCancel, idAbort, idRetry, idIgnore, idYes,
                          idNo, idClose, idHelp);


  //:$ Contains a list of possible options.
  //:: If you want to enable the extended functionality, you need to explicitly
  //:: include that option.
  //:: /n/n
  //:: <b>boCheckBox</b>/n
  //:: Adds a checkbox at the bottom of the dialog. Use the Checked property
  //:: to set the initial check state. After Execute() returns, the Checked
  //:: property can be used to read the checked state after the dialog
  //:: closes.
  //:: /n/n
  //:: <b>boCustomIcon</b>/n
  //:: Replaces the standard icon with either the icon specified in the
  //:: IconHandle property, or the Icon property. If IconHandle is set, it
  //:: is always used instead of Icon.
  //:: /n/n
  //:: <b>boAutoClose</b>/n
  //:: The dialog will close automatically after the number of seconds specified
  //:: in the CloseDelay property, unless of course the user presses one of the
  //:: buttons. If the delay expires, the dialog is closed as if the user
  //:: clicked the 'X', and returns the value it would in that situation.
  //:: /n/n
  //:: <b>boCentered</b>/n
  //:: Centers the dialog according to the specified parent. Note that the
  //:: Parent property must be set in this case.
  //:: /n/n
  //:: <b>boPositioned</b>/n
  //:: The dialog will be positioned at the X and Y position specified in the
  //:: MessageLeft and MessageTop properties. No further checks are performed
  //:: to assure the location lies within the screen space, although this might
  //:: be implemented in a later release (since the dialog would otherwise
  //:: block the whole program without a visible clue).
  //:: /n/n
  //:: <b>boTextCentered</b>/n
  //:: Centers the test displayed in the dialog.
  TNLDMessageBoxOption  = (boCheckBox, boCustomIcon, boAutoClose,
                           boCentered, boPositioned, boTextCentered);
  TNLDMessageBoxOptions = set of TNLDMessageBoxOption;


  {
    :$ Wraps all the extended MessageBox functionality.

    :: Create an instance of TNLDMessageBox to display a MessageBox with
    :: the extended functionality. All options are available trough the
    :: various properties, just make sure you update the Options property
    :: to reflect the desired functionality.
  }
  TNLDMessageBox  = class(TComponent)
  private
    FCaption:         String;
    FCheckBoxCaption: String;
    FChecked:         Boolean;
    FCloseDelay:      Integer;
    FIcon:            TIcon;
    FIconHandle:      Cardinal;
    FMessageLeft:     Integer;
    FMessageTop:      Integer;
    FOptions:         TNLDMessageBoxOptions;
    FParent:          Cardinal;
    FStyle:           TNLDMessageBoxStyles;
    FText:            TStrings;

    FHook:            Cardinal;
    FHookProc:        Pointer;
    FHookRun:         Boolean;

    FChildText:       Cardinal;
    FChildImage:      Cardinal;
    FChildButtons:    TList;

    FWindow:          Cardinal;
    FCheckBox:        Cardinal;
    FCloseTimer:      Cardinal;
    FCloseCounter:    Integer;
    FOldWndProc:      Pointer;
  protected
    procedure SetCheckBoxCaption(const Value: String); virtual;
    procedure SetIcon(const Value: TIcon); virtual;
    procedure SetText(const Value: TStrings); virtual;

    procedure SetHook(); virtual;
    procedure FreeHook(); virtual;
    procedure HookProc(var Msg: THookMessage); virtual;
    procedure SubclassProc(var Msg: TMessage); virtual;

    property ChildText:       Cardinal  read FChildText     write FChildText;
    property ChildImage:      Cardinal  read FChildImage    write FChildImage;
    property ChildButtons:    TList     read FChildButtons;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    //:$ Copies the content of one object to another.
    //:: Use Assign to copy the properties of one NLDMessageBox to
    //:: another instance.
    procedure Assign(Source: TPersistent); override;

    //:$ Shows the MessageBox and returns the result.
    function Execute(): TNLDMessageBoxResult; virtual;

    //:$ Contains a handle to the custom icon.
    //:! Setting the IconHandle property overrides the Icon property. The
    //:! Icon property will not be modified, but the specified IconHandle will
    //:! still be used instead. Also note that the Icon handle is not freed
    //:! when the Message Box is destroyed.
    property IconHandle:  Cardinal  read FIconHandle  write FIconHandle;

    //:$ Specifies the parent window for the MessageBox
    property Parent:      Cardinal  read FParent      write FParent;
  published
    //:$ Determines the caption visible in the dialog's title bar.
    property Caption:     String    read FCaption     write FCaption;

    //:$ Determines the caption displayed next to the check box.
    property CheckBoxCaption:   String  read FCheckBoxCaption write SetCheckBoxCaption;

    //:$ Determines the checked state of the check box.
    property Checked:     Boolean   read FChecked     write FChecked;

    //:$ Specifies the delay, in seconds, before the MessageBox is closed
    property CloseDelay:  Integer   read FCloseDelay  write FCloseDelay;

    //:$ Contains the custom icon to display.
    //:! When assigning the Icon, a copy is made instead of a reference. You
    //:! can safely Destroy the source TIcon.
    property Icon:        TIcon     read FIcon        write SetIcon;

    //:$ Determines the absolute X position of the MessageBox
    property MessageLeft: Integer   read FMessageLeft write FMessageLeft;

    //:$ Determines the absolute Y position of the MessageBox
    property MessageTop:  Integer   read FMessageTop  write FMessageTop;

    //:$ Determines which extended functionality should be enabled
    property Options:     TNLDMessageBoxOptions read FOptions write FOptions;

    //:$ Determines the MessageBox style.
    //:: These flags correspond to the various MessageBox API styles.
    //:: Read the Win32 SDK Help for more information.
    property Style:       TNLDMessageBoxStyles  read FStyle   write FStyle;

    //:$ Determines the text displayed to the user.
    property Text:        TStrings  read FText        write SetText;
  end;



  //:$ Converts a set of MessageBox types to an API-compatible value
  function NLDMBStylesToAPI(const ASource: TNLDMessageBoxStyles): Cardinal;

  //:$ Converts an API-compatible value to a set of MessageBox types
  function NLDAPIToMBStyles(const ASource: Cardinal): TNLDMessageBoxStyles;

  //:$ Converts a set of MessageBox types to an API-compatible value
  function NLDMBResultToAPI(const ASource: TNLDMessageBoxResult): Cardinal;

  //:$ Converts an API-compatible value to a set of MessageBox types
  function NLDAPIToMBResult(const ASource: Cardinal): TNLDMessageBoxResult;


implementation
const
  // Provides a way to convert MessageBox types to API constants.
  NLDMBStyles:  array[Low(TNLDMessageBoxStyle)..High(TNLDMessageBoxStyle)] of
                Cardinal = (MB_OK, MB_OKCANCEL, MB_ABORTRETRYIGNORE,
                            MB_YESNOCANCEL, MB_YESNO, MB_RETRYCANCEL,

                            MB_ICONHAND, MB_ICONQUESTION, MB_ICONEXCLAMATION,
                            MB_ICONASTERISK, MB_ICONWARNING, MB_ICONERROR,
                            MB_ICONINFORMATION, MB_ICONSTOP,

                            MB_DEFBUTTON1, MB_DEFBUTTON2, MB_DEFBUTTON3,
                            MB_DEFBUTTON4, MB_APPLMODAL, MB_SYSTEMMODAL,
                            MB_TASKMODAL, MB_HELP, MB_NOFOCUS, MB_SETFOREGROUND,
                            MB_DEFAULT_DESKTOP_ONLY, MB_TOPMOST, MB_RIGHT,
                            MB_RTLREADING, MB_SERVICE_NOTIFICATION,
                            MB_SERVICE_NOTIFICATION_NT3X);

  NLDMBResults: array[Low(TNLDMessageBoxResult)..High(TNLDMessageBoxResult)] of
                Cardinal = (ID_OK, ID_CANCEL, ID_ABORT, ID_RETRY, ID_IGNORE,
                ID_YES, ID_NO, ID_CLOSE, ID_HELP);

  NLDMBDefaultCBCaption  = 'Don''t show this message again...';
  NLDMBCloseCaption      = 'Closing in %d second(s)...';


  // Windows.pas defines MessageBoxIndirect incorrectly (at least in Delphi 6)
  function MessageBoxIndirect(const MsgBoxParams: TMsgBoxParams): Integer; stdcall;
                              external user32 name 'MessageBoxIndirectA';


{****************************************
  Various convert functions
****************************************}
function NLDMBStylesToAPI;
var
  pType:      TNLDMessageBoxStyle;

begin
  Result  := 0;

  for pType := Low(TNLDMessageBoxStyle) to High(TNLDMessageBoxStyle) do
    if pType in ASource then
      Result  := Result or NLDMBStyles[pType];
end;

function NLDAPIToMBStyles;
var
  pType:      TNLDMessageBoxStyle;

begin
  Result  := [];

  for pType := Low(TNLDMessageBoxStyle) to High(TNLDMessageBoxStyle) do
    if (ASource and NLDMBStyles[pType]) <> 0 then
      Include(Result, pType);
end;

function NLDMBResultToAPI;
begin
  Result  := NLDMBResults[ASource];
end;

function NLDAPIToMBResult;
var
  pResult:    TNLDMessageBoxResult;

begin
  Result  := idOK;

  for pResult := Low(TNLDMessageBoxResult) to High(TNLDMessageBoxResult) do
    if NLDMBResults[pResult] = ASource then begin
      Result  := pResult;
      break;
    end;
end;


{************************* TNLDMessageBox
  Constructor / destructor
****************************************}
constructor TNLDMessageBox.Create;
begin
  inherited;

  FCaption          := 'NLDMessageBox';
  FCheckBoxCaption  := NLDMBDefaultCBCaption;
  FIcon             := TIcon.Create();
  FIconHandle       := 0;
  FOptions          := [];
  FStyle            := [mbOk, mbIconInformation];
  FText             := TStringList.Create();

  FChildText        := 0;
  FChildImage       := 0;
  FChildButtons     := TList.Create();
end;

destructor TNLDMessageBox.Destroy;
begin
  FreeAndNil(FChildButtons);
  
  FreeAndNil(FIcon);
  FreeAndNil(FText);

  inherited;
end;

procedure TNLDMessageBox.Assign;
begin
  if Source is TNLDMessageBox then
    with TNLDMessageBox(Source) do begin
      // Copy properties (the Set procedures will take care of the necessary
      // assign calls if required)
      Self.Caption    := Caption;
      Self.Icon       := Icon;
      Self.IconHandle := IconHandle;
      Self.Options    := Options;
      Self.Parent     := Parent;
      Self.Style      := Style;
      Self.Text       := Text;
    end
  else
    inherited;
end;


{************************* TNLDMessageBox
  Execute
****************************************}
function TNLDMessageBox.Execute;
const
  CIconFlags    = [mbIconHand, mbIconQuestion, mbIconExclamation,
                   mbIconAsterisk, mbIconWarning, mbIconError,
                   mbIconInformation, mbIconStop];

var
  iStyle:       Cardinal;
  iResult:      Cardinal;
  msgParams:    TMsgBoxParams;
  pStyle:       TNLDMessageBoxStyles;

begin
  // If we want a custom icon, make sure the dialog box reserves space for
  // the icon so we can replace it
  pStyle  := FStyle;

  if boCustomIcon in FOptions then
    if pStyle - CIconFlags = pStyle then
      Include(pStyle, mbIconInformation);

  iStyle  := NLDMBStylesToAPI(pStyle);

  if FOptions <> [] then
    SetHook();

  with msgParams do begin
    // We won't define the icon here, instead, we'll modify that in the
    // hook procedure. This way we're not dependant on icons loaded from
    // resources, but can just use any icon with a handle :)
    cbSize              := SizeOf(TMsgBoxParams);
    hwndOwner           := FParent;
    hInstance           := 0;
    lpszText            := PChar(FText.Text);
    lpszCaption         := PChar(FCaption);
    dwStyle             := iStyle;
    lpszIcon            := nil;
    dwContextHelpId     := 0;
    lpfnMsgBoxCallback  := nil;
    dwLanguageId        := 0;
  end;

  iResult     := MessageBoxIndirect(msgParams);
  Result      := NLDAPIToMBResult(iResult);

  // Remove the hook (just in case it is still active)
  FreeHook();
end;


{************************* TNLDMessageBox
  Hook Procedures
****************************************}
procedure TNLDMessageBox.SetHook;
begin
  FHookProc := MakeHookInstance(HookProc);
  FHookRun  := False;
  FHook     := SetWindowsHookEx(WH_CALLWNDPROCRET, FHookProc, 0,
                                GetCurrentThreadId());
end;

procedure TNLDMessageBox.FreeHook;
begin
  if FHook <> 0 then begin
    UnhookWindowsHookEx(FHook);
    FreeHookInstance(FHookProc);

    FHook     := 0;
    FHookProc := nil;
  end;
end;


function NLDMBFindChildrenProc(hwnd: HWND; lParam: LPARAM): BOOL; stdcall;
var
  cClass:       array[0..255] of Char;
  iImage:       Integer;
  pMsgBox:      TNLDMessageBox;

begin
  Result  := True;
  pMsgBox := TNLDMessageBox(lParam);

  if not Assigned(pMsgBox) then begin
    Result  := False;
    exit;
  end;

  FillChar(cClass, SizeOf(cClass), #0);
  GetClassName(hwnd, @cClass, SizeOf(cClass));

  if CompareText(String(cClass), 'STATIC') = 0 then begin
    iImage  := SendMessage(hwnd, STM_GETIMAGE, IMAGE_ICON, 0);

    if iImage <> 0 then
      // Icon
      pMsgBox.ChildImage  := hwnd
    else
      // Text
      pMsgBox.ChildText   := hwnd
  end else if CompareText(String(cClass), 'BUTTON') = 0 then
    // Button
    pMsgBox.ChildButtons.Add(Pointer(hwnd));
end;

procedure TNLDMessageBox.HookProc;
const
  CSpacing        = 8;

var
  pData:            PCWPRetStruct;
  cTitle:           array[0..255] of Char;
  rText:            TRect;
  rClient:          TRect;
  rWindow:          TRect;
  hContext:         HDC;
  hIcon:            Cardinal;
  iWWidth:          Integer;
  iWidth:           Integer;
  iHeight:          Integer;
  iWDiff:           Integer;
  iHDiff:           Integer;
  iValue:           Integer;
  pSubclassProc:    Pointer;
  hStyle:           Cardinal;
  iCBHeight:        Integer;
  hDlgFont:         HFONT;

begin
  if Msg.nCode > -1 then begin
    pData := PCWPRetStruct(Msg.lParam);

    case pData^.message of
      WM_INITDIALOG:
        begin
        // Get window title
        FillChar(cTitle, SizeOf(cTitle), #0);
        GetWindowText(pData^.hwnd, @cTitle, SizeOf(cTitle));

        if String(cTitle) = FCaption then
          FWindow := pData^.hwnd;

          // Make sure we don't run the same code twice...
          if not FHookRun then begin
            FHookRun  := True;

            // Subclass the messagebox
            pSubclassProc := MakeObjectInstance(SubclassProc);
            FOldWndProc   := Pointer(SetWindowLong(FWindow, GWL_WNDPROC,
                                     Integer(pSubclassProc)));

            // Get child windows
            FChildText    := 0;
            FChildImage   := 0;
            FChildButtons.Clear();
            EnumChildWindows(FWindow, @NLDMBFindChildrenProc, Integer(Self));

            // === Custom Icon ===
            if (boCustomIcon in FOptions) and (FChildImage <> 0) then begin
              if FIconHandle <> 0 then
                hIcon := FIconHandle
              else
                hIcon := FIcon.Handle;

              SendMessage(FChildImage, STM_SETIMAGE, IMAGE_ICON, hIcon);
            end;

            // === Checkbox ===
            if boCheckBox in FOptions then begin
              GetWindowRect(FWindow, rWindow);
              GetClientRect(FWindow, rClient);

              iWDiff  := (rWindow.Right - rWindow.Left) -
                         (rClient.Right - rClient.Left);
              iHDiff  := (rWindow.Bottom - rWindow.Top) -
                         (rClient.Bottom - rClient.Top);

              // Calculate text size
              SendMessage(FWindow, WM_SETFONT, GetStockObject(DEFAULT_GUI_FONT), 0);

              hContext  := GetDC(FWindow);
              FillChar(rText, SizeOf(rText), #0);
              DrawText(hContext, PChar(FCheckBoxCaption),
                       Length(FCheckBoxCaption), rText, DT_CALCRECT or
                       DT_SINGLELINE);
              ReleaseDC(FWindow, hContext);

              // Retrieve checkbox size
              iCBHeight := GetSystemMetrics(SM_CYMENUCHECK);
              if iCBHeight > (rText.Bottom - rText.Top) then
                rText.Bottom  := rText.Top + iCBHeight
              else
                iCBHeight     := rText.Bottom - rText.Top;

              iWWidth   := rClient.Right - rClient.Left;
              iWidth    := rText.Right - rText.Left;
              iHeight   := rText.Bottom - rText.Top;

              Inc(iWidth, CSpacing * 2);
              Inc(iWidth, GetSystemMetrics(SM_CXMENUCHECK));
              Inc(iHeight, CSpacing);

              // Make sure the dialog is wide enough
              if iWWidth < iWidth then begin
                Dec(iWidth, iWWidth);
                Inc(rClient.Right, iWidth);
              end;

              // Increase the size
              Inc(rClient.Bottom, iHeight);

              // Resize dialog
              SetWindowPos(FWindow, 0, 0, 0, (rClient.Right - rClient.Left) +
                           iWDiff, (rClient.Bottom - rClient.Top) + iHDiff,
                           SWP_NOACTIVATE	or SWP_NOMOVE	or SWP_NOOWNERZORDER or SWP_NOZORDER);

              // Add the actual checkbox
              FCheckBox := CreateWindow('BUTTON', '', WS_CHILD or BS_AUTOCHECKBOX or
                                        BS_CHECKBOX or BS_TEXT or BS_VCENTER,
                                        CSpacing, rClient.Bottom - iHeight,
                                        rClient.Right - rClient.Left, iCBHeight, FWindow,
                                        777, hInstance, nil);
              SetWindowText(FCheckBox, PChar(FCheckBoxCaption));

              // Set initial state
              if FChecked then
                iValue  := BST_CHECKED
              else
                iValue  := BST_UNCHECKED;

              SendMessage(FCheckBox, BM_SETCHECK, iValue, 0);

              // Assign default font
              hDlgFont  := SendMessage(FWindow, WM_GETFONT, 0, 0);
              SendMessage(FCheckBox, WM_SETFONT, hDlgFont, 0);
              ShowWindow(FCheckBox, SW_SHOW);
            end;

            // === Positioned ===
            if boPositioned in FOptions then begin
              SetWindowPos(FWindow, 0, FMessageLeft, FMessageTop, 0, 0, SWP_NOACTIVATE or
                           SWP_NOSIZE or SWP_NOOWNERZORDER or SWP_NOZORDER);
            end else if boCentered in FOptions then begin
              GetWindowRect(FWindow, rClient);
              GetWindowRect(FParent, rWindow);

              iWidth  := (((rWindow.Right - rWindow.Left) -
                         (rClient.Right - rClient.Left)) div 2) + rWindow.Left;
              iHeight := (((rWindow.Bottom - rWindow.Top) -
                         (rClient.Bottom - rClient.Top)) div 2) + rWindow.Top;

              SetWindowPos(FWindow, 0, iWidth, iHeight, 0, 0, SWP_NOACTIVATE or
                           SWP_NOSIZE or SWP_NOOWNERZORDER or SWP_NOZORDER);
            end;

            // === Centered Text ===
            if (boTextCentered in FOptions) and (FChildText <> 0) then begin
              hStyle  := GetWindowLong(FChildText, GWL_STYLE);
              hStyle  := hStyle or SS_CENTER;
              SetWindowLong(FChildText, GWL_STYLE, hStyle);
            end;

            // === Auto-Close ===
            if boAutoClose in FOptions then begin
              FCloseCounter := FCloseDelay;
              FCloseTimer   := SetTimer(FWindow, 778, 1000, nil);
              SetWindowText(FWindow, PChar(FCaption + ' - ' +
                            Format(NLDMBCloseCaption, [FCloseCounter])));
            end else
              FCloseTimer   := 0;

            FreeHook();
          end;
        end;
    end;
  end;

  Msg.Result  := CallNextHookEx(FHook, Msg.nCode, Msg.wParam, Msg.lParam);
end;

procedure TNLDMessageBox.SubclassProc;
begin
  Msg.Result  := CallWindowProc(FOldWndProc, FWindow, Msg.Msg, Msg.WParam, Msg.LParam);

  case Msg.Msg of
    WM_COMMAND:
      if Msg.WParamLo = 777 then
        // Get checkbox state
        FChecked      := (SendMessage(FCheckBox, BM_GETCHECK, 0, 0) = BST_CHECKED);
    WM_TIMER:
      if Msg.WParam = 778 then begin
        Dec(FCloseCounter);

        if FCloseCounter = 0 then begin
          KillTimer(FWindow, Msg.WParam);
          FCloseTimer := 0;
          SendMessage(FWindow, WM_CLOSE, 0, 0);
        end else
          SetWindowText(FWindow, PChar(FCaption + ' - ' +
                        Format(NLDMBCloseCaption, [FCloseCounter])));
      end;
    WM_NCDESTROY:
      begin
        // Restore window procedure if necessary
        if FOldWndProc <> nil then begin
          SetWindowLong(FWindow, GWL_WNDPROC, Integer(FOldWndProc));
          FOldWndProc := nil;
        end;

        if FCloseTimer <> 0 then
          KillTimer(FWindow, 778);

        DestroyWindow(FCheckBox);

        FCheckBox     := 0;
        FWindow       := 0;
      end;
  end;
end;


{************************* TNLDMessageBox
  Properties
****************************************}
procedure TNLDMessageBox.SetCheckBoxCaption;
begin
  FCheckBoxCaption  := Value;

  if Length(FCheckboxCaption) = 0 then
    FCheckboxCaption  := NLDMBDefaultCBCaption;
end;

procedure TNLDMessageBox.SetIcon;
begin
  FIcon.Assign(Value);
end;

procedure TNLDMessageBox.SetText;
begin
  FText.Assign(Value);
end;

end.
