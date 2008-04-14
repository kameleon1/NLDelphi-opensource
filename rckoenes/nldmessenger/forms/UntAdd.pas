{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  TntForms, StrUtils, Dialogs, StdCtrls, ExtCtrls, JabberCOM_TLB, TntStdCtrls,
  TntExtCtrls, UntFrameTitle;



type
  TFrmAdd = class(TTntForm)
    LblJID: TTntLabel;
    LblGroup: TTntLabel;
    EdtSupAsk: TTntEdit;
    EdtNick: TTntEdit;
    CboAgent: TTntComboBox;
    CboGroup: TTntComboBox;
    Bevel1: TTntBevel;
    BtnAdd: TTntButton;
    BtnClose: TTntButton;
    LblSupAsk: TTntLabel;
    LblNick: TTntLabel;
    EdtJID: TTntEdit;
    LblAgent: TTntLabel;
    FrameTitle1: TFrameTitle;
    procedure BtnCloseClick(Sender: TObject);
    procedure ChangeBTN(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnCloseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TntFormCreate(Sender: TObject);
    procedure TntFormClose(Sender: TObject; var Action: TCloseAction);
  private


  public
    { Public declarations }
  end;

var
  FrmAdd: TFrmAdd;

implementation

{$R *.dfm}

Uses
  UntMain, UntJRosterNodes, UntJabber;

procedure TFrmAdd.ChangeBTN(Sender: TObject);
begin
 if (cboAgent.Text = '') or (EdtJID.Text = '') or (EdtNick.Text = '') or
      (cboGroup.Text = '') or (EdtSupAsk.Text = '') then
  BtnAdd.Enabled := False
 else
  BtnAdd.Enabled := True;
end;

procedure TFrmAdd.BtnCloseClick(Sender: TObject);
begin
  close;
end;


procedure TFrmAdd.BtnAddClick(Sender: TObject);
var
  RosterItem : IJabberRosterItem;
  JID : WideString;
  I : Integer;
begin
  JID := EdtJID.Text;
  if not (cboAgent.Text = 'Jabber') then
    begin
      JID := AnsiReplaceText(JID, '@', '%');
      for I := 0 to JRoster.agents.Count -1 do
        if JRoster.agents.Items[I].name = CboAgent.Text then
          JID := JID + '@' + JRoster.agents.Items[I].JID;
    end;
  RosterItem := DmJabber.JabberSession.Roster.Add(JID,EdtNick.text);
  RosterItem.AddGroup(CboGroup.Text);
  RosterItem.Subscription := jstNone;
  RosterItem.Update;

  DmJabber.JabberSession.SendPresence(JID,jptSubscribe,EdtSupAsk.Text,nil);

  Close;
end;

procedure TFrmAdd.BtnCloseKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key > 32 then
   begin
    beep;
    Key := 0;
   end;
end;

procedure TFrmAdd.TntFormCreate(Sender: TObject);
var
  I : Integer;
begin
  if DmJabber.JabberSession.Active = False then
   begin
    close;
    exit;
   end;

  for I := 0 to JRoster.Agents.Count -1 do
   With JRoster.Agents.Items[I] do
    If Transport and registered then
     CboAgent.Items.Append(Name);

  CboAgent.ItemIndex := 0;

  for I := 0 to JRoster.Groups.Count -1 do
   With JRoster.Groups.Items[I] do
    If not (Name = 'Gateway') then
     CboGroup.Items.Append(Name);

  CboGroup.ItemIndex := 0;

end;

procedure TFrmAdd.TntFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

end.
