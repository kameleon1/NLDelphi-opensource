{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntServer;

interface

uses
  Classes, Controls, Forms, TntForms, TntStdCtrls, StdCtrls, JabberCOM_TLB,
  ExtCtrls, TntExtCtrls;


type
  TFrmServer = class(TTntForm)
    GbServer: TTntGroupBox;
    LblName: TTntLabel;
    LblVersionS: TTntLabel;
    LblTimeS: TTntLabel;
    LblServer: TTntLabel;
    LblTime: TTntLabel;
    LblVersion: TTntLabel;
    BtnClose: TTntButton;
    LblOsS: TTntLabel;
    LblOs: TTntLabel;
    LsbGateways: TTntListBox;

    procedure BtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TntFormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmServer: TFrmServer;

implementation

uses
  UntJabber, UntMain, UntJRosterNodes , UntScreenHandler;

{$R *.dfm}

procedure TFrmServer.BtnCloseClick(Sender: TObject);
begin
 close;
end;

procedure TFrmServer.FormShow(Sender: TObject);
var
 I : integer;
 Iq : IJabberIQ;
begin
 for I := 0 to JRoster.agents.Count -1 do
  LsbGateways.Items.Add(JRoster.agents.Items[I].name);

 Iq := DmJabber.JabberSession.CreateIQ;
 With Iq do
  Begin
    NameSpace := 'jabber:iq:time';
    ID := 'ServInfo';
    iqType := 'get';
    ToJID  := DmJabber.JabberSession.Server;
    FromJID := DmJabber.JabberSession.MyJID;
  end;
 DmJabber.JabberSession.SendIQ(Iq);

 With Iq do
  Begin
    NameSpace := 'jabber:iq:version';
    ID := 'ServInfo';
    iqType := 'get';
    ToJID  := DmJabber.JabberSession.Server;
    FromJID := DmJabber.JabberSession.MyJID;
  end;
 DmJabber.JabberSession.SendIQ(Iq);

 LblServer.Caption := DmJabber.JabberSession.Server;
end;

procedure TFrmServer.TntFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
  ScreenHandler.FreeServer;
end;

end.
