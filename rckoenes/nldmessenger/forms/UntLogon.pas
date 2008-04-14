{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntLogon;

interface

uses
  Classes, Controls, Forms, TntLxForms, SysUtils, StdCtrls, ComCtrls, ExtCtrls,
  Spin, JabberCOM_TLB, Graphics, Buttons, TntStdCtrls, TntExtCtrls, TntComCtrls,
  TntForms, UntFrameTitle;

type
  TFrmLogon = class(TTntFormLX)
    PageControl       : TTntPageControl;
    TsUser            : TTntTabSheet;
    TsProxy           : TTntTabSheet;
    TabSheet3         : TTntTabSheet;
    PnlBottom         : TTntPanel;
    BtnLogon          : TTntButton;
    LblUsername       : TTntLabel;
    LblPassword       : TTntLabel;
    LblServer         : TTntLabel;
    LblPort           : TTntLabel;
    EdtUserName       : TTntEdit;
    EdtPort           : TSpinEdit;
    LblPriority       : TTntLabel;
    EdtPriority       : TSpinEdit;
    EdtResource       : TTntEdit;
    LblrResource      : TTntLabel;
    EdtServer         : TTntComboBox;
    Line              : TTntBevel;
    EdtPassword       : TTntEdit;
    BtnClose          : TTntButton;
    CbSsl             : TCheckBox;
    GbProxyServer     : TTntGroupBox;
    GbProxyUser       : TTntGroupBox;
    CbProxy           : TTntComboBox;
    LblProxy          : TTntLabel;
    LblProxyServer    : TTntLabel;
    LblProxyPort      : TTntLabel;
    LblProxyUser      : TTntLabel;
    LblProxyPassword  : TTntLabel;
    EdtProxyServer    : TTntEdit;
    EdtProxyUser      : TTntEdit;
    EdtProxyPassword  : TTntEdit;
    EdtProxyPort      : TSpinEdit;
    FrameTitle1       : TFrameTitle;

    procedure BtnLogonClick(Sender: TObject);
    procedure EnterKeyPress(Sender: TObject; var Key: Char);
    procedure SetProxyServer(Value: Boolean);
    procedure SetProxyUser(Value: Boolean);
    procedure CbProxyChange(Sender: TObject);
    procedure TntFormLXCreate(Sender: TObject);
    procedure CbSslClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogon: TFrmLogon;

implementation

uses
  UntMain, UntJabber, UntUtil;

{$R *.dfm}

procedure TFrmLogon.BtnLogonClick(Sender: TObject);
begin
 with DmJabber do
  begin
   JabberSession.Username := EdtUsername.Text;
   JabberSession.Password := EdtPassword.Text;
   JabberSession.Server   := Edtserver.Text;
   JabberSession.Port     := EdtPort.Value;
   JabberSession.Resource := Edtresource.Text;
   JabberSession.Priority := Edtpriority.Value;
   JabberSession.UseSSL   := cbSsl.Checked;

   if CbProxy.ItemIndex = 1 then
    begin
      JabberSession.ProxyMethod := jproxySOCKS4;
      JabberSession.ProxyServer := EdtProxyServer.Text;
      JabberSession.ProxyPort   := EdtProxyPort.Value;
    end;

   if CbProxy.ItemIndex = 2 then
    begin
      JabberSession.ProxyMethod   := jproxySOCKS5;
      JabberSession.ProxyServer   := EdtProxyServer.Text;
      JabberSession.ProxyPort     := EdtProxyPort.Value;
      JabberSession.ProxyUser     := EdtProxyUser.Text;
      jabberSession.ProxyPassword := EdtProxyPassword.Text;
    end;

   JabberSession.DoConnect(false, jatAuto);
  end;
end;

procedure TFrmLogon.EnterKeyPress(Sender: TObject; var Key: Char);
begin
 if (key = #13) then
    BtnLogon.Click;
end;

procedure TFrmLogon.SetProxyServer(Value: Boolean);
begin
  LblProxyServer.Enabled  := Value;
  EdtProxyServer.Enabled  := Value;
  LblProxyPort.Enabled    := Value;
  EdtProxyPort.Enabled    := Value;
end;

procedure TFrmLogon.SetProxyUser(Value: Boolean);
begin
  LblProxyUser.Enabled      := Value;
  EdtProxyUser.Enabled      := Value;
  LblProxyPassword.Enabled  := Value;
  EdtProxyPassword.Enabled  := Value;
end;

procedure TFrmLogon.CbProxyChange(Sender: TObject);
begin
  case CbProxy.ItemIndex of
    0:  begin
          SetProxyServer(False);
          SetProxyUser(False);
        end;
    1:  begin
          SetProxyServer(True);
          SetProxyUser(False);
        end;
    2:  begin
          SetProxyServer(True);
          SetProxyUser(True);
        end;
  end;
end;

procedure TFrmLogon.TntFormLXCreate(Sender: TObject);
begin
  cbSsl.Visible := SslAviable;
end;

procedure TFrmLogon.CbSslClick(Sender: TObject);
begin
  If cbSsl.Checked and (EdtPort.Value = 5222) then
    EdtPort.Value := 5223
  else If not cbSsl.Checked and (EdtPort.Value = 5223) then
    EdtPort.Value := 5222;
end;

end.
