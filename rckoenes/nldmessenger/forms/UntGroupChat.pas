{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntGroupChat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UntBaseForm, StdCtrls, TntStdCtrls, VirtualTrees, Buttons,
  TntButtons, TntComCtrls, ComCtrls, TntLXRichEdits, Menus, ExtCtrls,
  TntExtCtrls, TntWindows, TntMenus, TSFontBox;

type
  TFrmGroupChat = class(TFrmBaseForm)
    PnlBottom: TTntPanel;
    SplitterBottom: TTntSplitter;
    PnlButton: TTntPanel;
    EdtSend: TTntRichEdit;
    TntSpeedButton1: TTntSpeedButton;
    TntMainMenu1: TTntMainMenu;
    Contact1: TTntMenuItem;
    MMView: TTntMenuItem;
    PnlRoster: TTntPanel;
    TntSplitter1: TTntSplitter;
    PnlChat: TTntPanel;
    PnlStatus: TTntPanel;
    PnlSubject: TTntPanel;
    EdtRecive: TTntRichEditLX;
    TntTreeView1: TTntTreeView;
    TntSpeedButton2: TTntSpeedButton;
    mmStayontop: TTntMenuItem;
    mmClear: TTntMenuItem;
    CboxStatus: TTntComboBox;
    pnlUsers: TTntPanel;
    CbxFonstSize: TTntComboBox;
    CbxFont: TTSFontBox;
    BtnItalic: TTntSpeedButton;
    BtnUnderLine: TTntSpeedButton;
    BtnBold: TTntSpeedButton;
    Edit: TTntMenuItem;
    Cut1: TTntMenuItem;
    Cut2: TTntMenuItem;
    Paste1: TTntMenuItem;
    Delete1: TTntMenuItem;
    SelectAll1: TTntMenuItem;
    PupUser: TTntPopupMenu;
    Chat: TTntMenuItem;
    Message: TTntMenuItem;
    N7: TTntMenuItem;
    ClientInfo: TTntMenuItem;
    GetVersion: TTntMenuItem;
    GetTime: TTntMenuItem;
    LastSeen: TTntMenuItem;
    GetVcard: TTntMenuItem;
    Closeconversation1: TTntMenuItem;
    procedure CboxStatusDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure TntFormLXCreate(Sender: TObject);
    procedure mmClearClick(Sender: TObject);
    procedure mmStayontopClick(Sender: TObject);
    procedure MMViewClick(Sender: TObject);
    procedure TntSpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    JID : WideString;
    procedure AddReciveMessage(JID, Msg : WideString);
  end;

var
  FrmGroupChat: TFrmGroupChat;

implementation

uses UntMain;

{$R *.dfm}

procedure TFrmGroupChat.CboxStatusDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
 CboxStatus.Canvas.FillRect(Rect);

 FrmMain.ImgLsTray.Draw(CboxStatus.Canvas, Rect.Left, Rect.Top, Index, true);

 Rect.Left := Rect.Left + 20; {move over some}

 Tnt_DrawTextW(CboxStatus.Canvas.Handle, PWideChar(CboxStatus.Items[Index]),
                -1, Rect, DT_SINGLELINE or DT_VCENTER or DT_LEFT);

end;

procedure TFrmGroupChat.TntFormLXCreate(Sender: TObject);
begin
  inherited;
  CboxStatus.ItemIndex := 0;
end;

procedure TFrmGroupChat.mmClearClick(Sender: TObject);
begin
  if windows.MessageBoxW(Self.Handle,'Are you sure you want'+#13#10+'clear the chat screen',
                          'Clear Chat screen?',MB_YESNO + MB_ICONQUESTION) = IDYES then
    EdtRecive.Clear;
end;

procedure TFrmGroupChat.mmStayontopClick(Sender: TObject);
begin
  Self.StayOnTop := not Self.StayOnTop;
end;

procedure TFrmGroupChat.MMViewClick(Sender: TObject);
begin
  MMStayonTop.Checked := Self.StayOnTop;
end;

procedure TFrmGroupChat.AddReciveMessage(JID, Msg: WideString);
begin
//
end;

procedure TFrmGroupChat.TntSpeedButton2Click(Sender: TObject);
begin
// Change chat subject
end;

end.
