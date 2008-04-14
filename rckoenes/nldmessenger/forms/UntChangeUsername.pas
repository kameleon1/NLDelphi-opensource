{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntChangeUsername;

interface

uses
  { TSIM units }
  UntJRosterNodes, UntUtil,
  { Delphi units }
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls;

type
  TFrmChangeUserName = class(TTntForm)
    LblOldNick: TTntLabel;
    LblNick: TTntLabel;
    LblNewNick: TTntLabel;
    EdtNewNick: TTntEdit;
    BtnOk: TTntButton;
    BtnCancel: TTntButton;
    StatusBar: TTntStatusBar;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure TntFormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtNewNickChange(Sender: TObject);
  private
    FContact  : TJContact;
  public
    property Contact  : TJContact   Read  FContact    write FContact;
    procedure setJID(value : Widestring);
  end;

var
  FrmChangeUserName: TFrmChangeUserName;

implementation

{$R *.dfm}

Uses
  UntMain;

procedure TFrmChangeUserName.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmChangeUserName.BtnOkClick(Sender: TObject);
begin
  Self.Enabled  :=  False;
  Contact.ChangeNick(EdtNewNick.Text);
  Close;
end;

procedure TFrmChangeUserName.TntFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action := CaFree;
end;

procedure TFrmChangeUserName.setJID(value: Widestring);
Var
  I : Integer;
begin
  
  I := JRoster.Contacts.IndexOf(GetJID(value));
  Contact := JRoster.Contacts.Items[i];
  Statusbar.Panels.Items[0].Text  := Contact.JID;
  LblOldNick.Caption              := Contact.Name;
end;

procedure TFrmChangeUserName.EdtNewNickChange(Sender: TObject);
begin
  if EdtNewNick.Text <> '' then
    BtnOk.Enabled :=  true
  else
    BtnOk.Enabled :=  False;
end;

end.
