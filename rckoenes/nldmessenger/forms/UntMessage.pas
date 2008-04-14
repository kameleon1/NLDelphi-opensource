{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntMessage;

interface

uses
  { TSIM Units }
  UntBaseForm, JabberCOM_TLB,
  { Delphi Units }
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, TntButtons,
  TntLXRichEdits, TntExtCtrls, Menus, TntMenus, Buttons,
  TSFontBox;

type
  TFrmMessage = class(TFrmBaseForm)
    PnlTop: TTntPanel;
    ImgLogo: TImage;
    PageView: TTntPageControl;
    TabMessage: TTntTabSheet;
    TabURL: TTntTabSheet;
    TabContact: TTntTabSheet;
    TabRecive: TTntTabSheet;
    LblMsg: TTntLabel;
    LblSubjectS: TTntLabel;
    LblJID: TTntLabel;
    EdtSubject: TTntEdit;
    PnlButtons: TTntPanel;
    BtnSend: TTntSpeedButton;
    EdtMessage: TTntRichEditLX;
    CbxFonstSize: TTntComboBox;
    CbxFont: TTSFontBox;
    BtnItalic: TTntSpeedButton;
    BtnUnderLine: TTntSpeedButton;
    BtnBold: TTntSpeedButton;
    lvRecipients: TTntListView;
    PnlUrl: TTntPanel;
    TntEdit1: TTntEdit;
    TntEdit2: TTntEdit;
    lblUrl: TTntLabel;
    lblDecription: TTntLabel;
    BtnAddUrl: TTntSpeedButton;
    TntPopupMenu1: TTntPopupMenu;
    Remove1: TTntMenuItem;
    lvContacts: TTntListView;
    lvUrl: TTntListView;
    procedure clickReply(Sender: TObject);
    procedure clickSend(Sender: TObject);
  private
    { Private declarations }
    JID : WideString;
    NickName : WideString;



  public
    { Public declarations }
    constructor Create(HideInTaskBar : Boolean; JID : WideString); reintroduce;
    procedure SetRecive(Msg, Subject : WideString);
    procedure SetReply(Msg, Subject: WideString);
    procedure SetXML(Tag: IXMLTag);
  end;

var
  FrmMessage: TFrmMessage;

implementation

uses UntMain, UntUtil, UntJabber, UntJRosterNodes;

{$R *.dfm}

{ TFrmMessage }

procedure TFrmMessage.clickReply(Sender: TObject);
begin
  ScreenHandler.ReplyMessage(JId,EdtSubject.Text,EdtMessage.Text);
  close;
end;

procedure TFrmMessage.clickSend(Sender: TObject);
var
  msg : IJabberMsg;
begin
  msg := DMjabber.JabberSession.CreateMsg;
  with msg do
    begin
      Subject := EdtSubject.Text;
      ToJID := JID;
      MsgType := jmtNormal;
      Body := TRIM(EdtMessage.Text);
    end;
  DMjabber.JabberSession.SendMessage(msg);
  Close;
end;

constructor TFrmMessage.Create(HideInTaskBar: Boolean; JID : WideString);
var
  I : Integer;
begin
  inherited Create(HideInTaskBar);

  // set the form JID
  Self.JID := JID;

  // Get the a Nickname voor user
  I := JRoster.Contacts.IndexOf(GetJID(JID));
  if I >= 0 then
    NickName := JRoster.Contacts.Items[I].Name
  else
    NickName := GetUserNameFromJID(JID);

  LblJid.Caption := NickName + '('+Self.JID+')';
end;

procedure TFrmMessage.SetRecive(Msg, Subject : WideString);
begin
  Caption := 'Message From: '+NickName;
  EdtMessage.Lines.Add(Msg);
  EdtMessage.ReadOnly := true;

  EdtSubject.Text := Subject;
  EdtSubject.ReadOnly := true;

  BtnSend.Caption := '&Reply';
  BtnSend.OnClick := clickReply;
end;

procedure TFrmMessage.SetReply(Msg, Subject : WideString);
begin
  Caption := 'Message To: '+NickName;

  EdtMessage.Lines.Add(Msg);

  EdtSubject.Text := 'Re: '+Subject;
end;



procedure TFrmMessage.SetXML(Tag: IXMLTag);
begin

end;

end.
