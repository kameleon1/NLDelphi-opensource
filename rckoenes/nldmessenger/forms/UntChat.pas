{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntChat;

interface

uses
  { TSIM Units }
  UntBaseForm, JabberCOM_TLB,
  { Delphi Units } 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, TntButtons, ExtCtrls, TntExtCtrls, Menus, TntMenus,
  ComCtrls, TntComCtrls, StdCtrls, TntLXRichEdits, TntStdCtrls, ActnMan,
  TSFontBox, ImgList, StdActns, ActnList, XPStyleActnCtrls;

type
  TFrmChat = class(TFrmBaseForm)
    TntMainMenu: TTntMainMenu;
    PnlBottum: TTntPanel;
    Splitter: TTntSplitter;
    StatusBar: TTntStatusBar;
    PnlButtons: TTntPanel;
    EdtSend: TTntRichEditLX;
    BtnSend: TTntSpeedButton;
    Contact1: TTntMenuItem;
    View1: TTntMenuItem;
    MMStayonTop: TTntMenuItem;
    MMClearChat: TTntMenuItem;
    N1: TTntMenuItem;
    CbxFont: TTSFontBox;
    BtnBold: TTntSpeedButton;
    BtnUnderLine: TTntSpeedButton;
    BtnItalic: TTntSpeedButton;
    CbxFonstSize: TTntComboBox;
    Edit1: TTntMenuItem;
    Cut2: TTntMenuItem;
    Copy2: TTntMenuItem;
    Paste2: TTntMenuItem;
    Delete2: TTntMenuItem;
    SelectAll1: TTntMenuItem;
    RecivePopUp: TTntPopupMenu;
    Copy1: TTntMenuItem;
    SelectAll2: TTntMenuItem;
    Rename1: TTntMenuItem;
    Addtoroster1: TTntMenuItem;
    N2: TTntMenuItem;
    Closeconversation1: TTntMenuItem;
    EdtRecive: TTntRichEditLX;
    Clientversion1: TTntMenuItem;
    Clienttime1: TTntMenuItem;
    N3: TTntMenuItem;
    Lastseen1: TTntMenuItem;
    procedure View1Click(Sender: TObject);
    procedure MMStayonTopClick(Sender: TObject);
    procedure MMClearChatClick(Sender: TObject);
    procedure BtnSendClick(Sender: TObject);
    procedure TntFormLXClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtSendKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Lastseen1Click(Sender: TObject);
    procedure Clientversion1Click(Sender: TObject);
    procedure Closeconversation1Click(Sender: TObject);
    procedure Clienttime1Click(Sender: TObject);
    procedure Rename1Click(Sender: TObject);
    procedure Addtoroster1Click(Sender: TObject);
  private
    JID : WideString;
    NickName: WideString;
    procedure AddColoredLine(AText: WideString; AColor: TColor);
    { Private declarations }
  public
    { Public declarations }
    procedure AddReciveMessage(Body: WideString);
    procedure AddSendMessage(Body: WideString);
    procedure AddUserStatus(Status : WideString);
    procedure AddChatError(Error : WideString);
    constructor Create(HideInTaskBar : Boolean; JID : WideString); reintroduce;
  end;

var
  FrmChat: TFrmChat;

implementation

uses UntJabber, UntJRosterNodes, UntUtil, UntMain;

{$R *.dfm}

procedure TFrmChat.View1Click(Sender: TObject);
begin
  MMStayonTop.Checked := Self.StayOnTop;
end;

procedure TFrmChat.MMStayonTopClick(Sender: TObject);
begin
  Self.StayOnTop := not Self.StayOnTop;
end;

procedure TFrmChat.MMClearChatClick(Sender: TObject);
begin
  if windows.MessageBoxW(Self.Handle,'Are you sure you want'+#13#10+'clear the chat screen',
     'Clear Chat screen?', MB_YESNO + MB_ICONQUESTION) = IDYES then
    EdtRecive.Clear;
end;

procedure TFrmChat.AddColoredLine(AText: WideString; AColor: TColor);
begin
  with EdtRecive do
  begin
    SelStart := Length(Text);
    SelAttributes.Color := AColor;
    SelText := AText;
  end;
end;

procedure TFrmChat.BtnSendClick(Sender: TObject);
Var
 JabberMsg : IJabberMsg;
begin
 if not (trim(EdtSend.Lines.Text) = '') then
   begin
     JabberMsg := DMJabber.JabberSession.CreateMsg;
     JabberMsg.ToJID := Self.JID;
     JabberMsg.Body  := trim(EdtSend.Text);
     JabberMsg.MsgType := jmtChat;
     DMJabber.JabberSession.SendMessage(JabberMsg);
     AddSendMessage(trim(EdtSend.Text));
     EdtSend.lines.Clear;
    end;
end;

procedure TFrmChat.AddReciveMessage(Body: WideString);
begin
 EdtRecive.Lines.BeginUpdate;

 EdtRecive.Paragraph.FirstIndent := 0;
 AddColoredLine (FormatDateTime('[hh:nn] ', now), progSettings.TextFont.Time);
 AddColoredLine ('['+ NickName +']'+#13#10,progSettings.TextFont.Username);

 EdtRecive.SelStart := Length(EdtRecive.Text);
 EdtRecive.Paragraph.FirstIndent := 10;
 AddColoredLine (Body, progSettings.TextFont.Normal);
 EdtRecive.SelStart := Length(EdtRecive.Text);
 EdtRecive.SelText := #13#10#13#10;

 EdtRecive.Paragraph.FirstIndent := 0;
 EdtRecive.Lines.EndUpdate;
end;

procedure TFrmChat.AddSendMessage(Body: WideString);
begin
 EdtRecive.Lines.BeginUpdate;

 EdtRecive.Paragraph.FirstIndent := 0;
 AddColoredLine (FormatDateTime('[hh:nn] ', now), progSettings.TextFont.Time);
 AddColoredLine ('['+ DMjabber.JabberSession.Username +']'+#13#10, progSettings.TextFont.YourUsername);

 EdtRecive.Paragraph.FirstIndent := 10;
 AddColoredLine (Body, progSettings.TextFont.Normal);
 EdtRecive.SelText := #13#10 + #13#10;

 EdtRecive.Paragraph.FirstIndent := 0;
 EdtRecive.Lines.EndUpdate;
end;

{ Remove Screen from Screen list }
procedure TFrmChat.TntFormLXClose(Sender: TObject;
  var Action: TCloseAction);
begin
   ScreenHandler.RemoveChat(self.JID);
   inherited;
end;

constructor TFrmChat.Create(HideInTaskBar: Boolean; JID: WideString);
var
  I : Integer;
begin
  inherited Create(HideInTaskBar);

  // Set form jid
  self.JID := JID;
  StatusBar.Panels[1].Text := Self.JID;
  //get the user nickname
  I := JRoster.Contacts.IndexOf(GetJID(JID));
  if I >= 0 then
    NickName := JRoster.Contacts.Items[I].Name
  else
    NickName := GetUserNameFromJID(JID);

  // set the caption of the form
  Self.Caption := 'Chatting with ' + NickName;

  // add de default chat started line
  AddColoredLine('Conversation started on ' + DateToStr(Date) + #13#10,clSilver);
end;

procedure TFrmChat.EdtSendKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key = 13) and not (Shift = [ssShift]) then
  begin
   key := 0;
   BtnSend.Click;
  end;
end;

procedure TFrmChat.Lastseen1Click(Sender: TObject);
begin
  DmJabber.GetLastSeen(self.JID);
end;

procedure TFrmChat.Clientversion1Click(Sender: TObject);
begin
  DmJabber.GetVersion(Self.JID);
end;

procedure TFrmChat.Closeconversation1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmChat.AddUserStatus(Status: WideString);
begin
  AddColoredLine(FormatDateTime('[d-m-yyyy hh:nn] ', now) + NickName+ ': ' +
                  Status + #13#10, progSettings.TextFont.System);
end;

procedure TFrmChat.AddChatError(Error: WideString);
begin
  AddColoredLine (Error+#13#10,progSettings.TextFont.Error);
end;

procedure TFrmChat.Clienttime1Click(Sender: TObject);
begin
  DmJabber.GetTime(Self.JID);
end;

procedure TFrmChat.Rename1Click(Sender: TObject);
begin
  inherited;
  ScreenHandler.ShowRenameUser(self.JID);
end;

procedure TFrmChat.Addtoroster1Click(Sender: TObject);
begin
  inherited;
  ScreenHandler.ShowAddUser;
end;

end.
