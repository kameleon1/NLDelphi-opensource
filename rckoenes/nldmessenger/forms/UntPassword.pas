{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

{
Changing a password sould be done by the following IQ:
<iq type="set" to="somjabber.server" id="TSIM01">
  <query xmlns="jabber:iq:register">
    <username>Some User</username>
    <password>You would like to know</password>
  </query>
</iq>
}

unit UntPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLXForms, StdCtrls,JabberCOM_TLB, TntStdCtrls, ExtCtrls,
  TntExtCtrls, TntForms, UntFrameTitle;

type
  TFrmPassword = class(TTntFormLX)
    BtnChange: TTntButton;
    BtnCancel: TTntButton;
    TntLabel1: TTntLabel;
    TntLabel2: TTntLabel;
    TntLabel3: TTntLabel;
    EdtOld: TTntEdit;
    EdtNew: TTntEdit;
    EdtNewConfirm: TTntEdit;
    FrameTitle1: TFrameTitle;
    procedure BtnCancelClick(Sender: TObject);
    procedure TntFormLXClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnChangeClick(Sender: TObject);
    procedure EdtOldChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPassword: TFrmPassword;

implementation

Uses UntJabber, UntMain;

{$R *.dfm}

procedure TFrmPassword.BtnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmPassword.TntFormLXClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ScreenHandler.FreePassword;
  Action := CaFree;
end;

procedure TFrmPassword.BtnChangeClick(Sender: TObject);
var
  Iq : IJabberIQ;
begin
  if (DmJabber.JabberSession.Password = EdtOld.Text) and
      (EdtNewConfirm.Text = EdtNew.Text) and (EdtNew.Text <> '') then
    begin
     Iq := DmJabber.JabberSession.CreateIQ;
     With Iq do
      Begin
        NameSpace := 'jabber:iq:register';
        iqType := 'set';
        ID := DmJabber.JabberSession.GetNextID;
        ToJID  := DmJabber.JabberSession.Server;
        FromJID := DmJabber.JabberSession.MyJID;
        SetField('username',FromJID);
        SetField('password',EdtNew.Text);
      end;
     DmJabber.JabberSession.SendIQ(Iq);
     DmJabber.JabberSession.Password := EdtNew.Text;
    end;
    close;
end;

procedure TFrmPassword.EdtOldChange(Sender: TObject);
begin
  if (DmJabber.JabberSession.Password = EdtOld.Text) and
      (EdtNewConfirm.Text = EdtNew.Text) then
    BtnChange.Enabled := true
  else
    BtnChange.Enabled := false;
end;

end.
