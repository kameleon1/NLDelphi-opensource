unit NLDRichEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, ComCtrls, Messages, RichEdit,
  Windows;

type
  TURLClickEvent = procedure(Sender: TObject; URL: String) of object;

type
  TNLDRichEdit = class(TCustomRichEdit)
  private
    FOnURLClick: TURLClickEvent;
    procedure CNNotifyMsg(var Message: TWMNotify); message CN_NOTIFY;
  protected
    procedure CreateWnd; override;
    function GetWideText: WideString;
    procedure SetWideText(Value: WideString);
  public
    property WideText: WideString read GetWideText write SetWideText;
  published
    property Align;
    property Alignment;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HideScrollBars;
    property ImeMode;
    property ImeName;
    property Constraints;
    property Lines;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property WantTabs;
    property WantReturns;
    property WordWrap;
    property OnChange;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnProtectChange;
    property OnResizeRequest;
    property OnSaveClipboard;
    property OnSelectionChange;
    property OnStartDock;
    property OnStartDrag;

    property OnURLClick: TURLClickEvent read FOnURLClick write FOnURLClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Custom', [TNLDRichEdit]);
end;

{ TExRichEdit }

procedure TNLDRichEdit.CNNotifyMsg(var Message: TWMNotify);
type
  PENLink = ^TENLink;
var
  URL: String;
begin
  case Message.NMHdr^.code of

  EN_LINK:
    with PENLink(Pointer(Message.NMHdr))^ do
    begin
      if Msg = WM_LBUTTONDOWN then
      begin
        URL := WideText;
        URL := Copy(URL, chrg.cpMin + 1, chrg.cpMax - chrg.cpMin);
        if Assigned(FOnURLClick) then FOnURLClick(Self, URL);
      end;
    end;

  else
    inherited;
  end;
end;

procedure TNLDRichEdit.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, EM_SETEVENTMASK, 0, ENM_CHANGE or ENM_SELCHANGE or ENM_REQUESTRESIZE or ENM_PROTECTED or ENM_LINK);
  SendMessage(Handle, EM_AUTOURLDETECT, 1, 0);
end;

function TNLDRichEdit.GetWideText: WideString;
var
  GTL: TGetTextLengthEx;
  GT: TGetTextEx;
  L: Integer;
begin
  GTL.flags := GTL_DEFAULT;
  GTL.codepage := 1200;
  L := Perform(EM_GETTEXTLENGTHEX, Integer(@GTL), 0);
  SetLength(Result, L);
  GT.cb := L * 2 + 2;
  GT.flags := GT_DEFAULT;
  GT.codepage := 1200;
  GT.lpDefaultChar := nil;
  GT.lpUsedDefChar := nil;
  SendMessage(Handle, EM_GETTEXTEX, Integer(@GT), Integer(@Result[1]));
end;

procedure TNLDRichEdit.SetWideText(Value: WideString);
begin
  SendMessage(Handle, WM_SETTEXT, 0, Integer(@Value[1]));
end;

end.
