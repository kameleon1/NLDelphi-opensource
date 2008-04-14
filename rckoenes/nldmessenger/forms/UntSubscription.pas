{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntSubscription;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UntMain, UntJRosterNodes, JabberCOM_TLB, UntAdd,
  TntStdCtrls, TntForms, TntLxForms;

type
  TFrmSubscription = class(TTntFormLx)
    BtnOk: TTntButton;
    LblTheUser: TTntLabel;
    LblUser: TTntLabel;
    Lblinfo: TTntLabel;
    EdtSubAsp: TTntMemo;
    GbSubType: TTntGroupBox;
    RbAccept: TTntRadioButton;
    RbAcceptAdd: TTntRadioButton;
    RbDecline: TTntRadioButton;
    procedure BtnOkClick(Sender: TObject);
    procedure CheckEnabled(Sender: TObject);
  private
    { Private declarations }
    FJID : WideString;
  public
    { Public declarations }
    property JID        : WideString  read  FJID       Write FJID;
    procedure setInfo(FromJID, subscription : WideString);
  end;

var
  FrmSubscription: TFrmSubscription;

implementation

uses UntJabber, UntUtil;

{$R *.dfm}

procedure TFrmSubscription.BtnOkClick(Sender: TObject);
Var
  FrmAdd : TFrmAdd;
begin
  if RbAccept.Checked then
    DmJabber.JabberSession.SendPresence(JID,jptSubscribed,'Subscription Approved',nil);

  if RbAcceptAdd.Checked then
  begin
    DmJabber.JabberSession.SendPresence(JID,jptSubscribed,'Subscription Approved',nil);
    FrmAdd := TFrmAdd.Create(Application);
    FrmAdd.EdtJID.Text := JID;
    FrmAdd.EdtJID.Enabled := False;
    FrmAdd.Show;
  end;

  if RbDecline.Checked then
    DmJabber.JabberSession.SendPresence(JID,jptUnSubscribed,'User Declined your request',nil);
  
 Close;
end;

procedure TFrmSubscription.CheckEnabled(Sender: TObject);
begin
 if RbAccept.Checked or RbAcceptAdd.Checked or RbDecline.Checked then
  BtnOk.Enabled := true;
end;

procedure TFrmSubscription.setInfo(FromJID, subscription: WideString);
begin
  self.JID := FromJID;
  LblUser.Caption := FromJID;
  self.EdtSubAsp.Lines.Add(subscription);
end;

end.
