{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit WizardNewUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, ExtCtrls, StdCtrls, TntStdCtrls, ComCtrls,
  TntComCtrls, TntExtCtrls, CommCtrl, OleServer, JabberCOM_TLB, Spin,
  UntFrameTitle;

type
  TFrmNewUser = class(TTntForm)
    PnlBottum: TTntPanel;
    PageControle: TTntPageControl;
    BtnCancel: TTntButton;
    BtnNext: TTntButton;
    BtnBack: TTntButton;
    TabWelkom: TTntTabSheet;
    TabUsername: TTntTabSheet;
    TabRegistering: TTntTabSheet;
    EdtUserName: TTntEdit;
    EdtPassword1: TTntEdit;
    EdtServer: TTntComboBox;
    TntLabel1: TTntLabel;
    TntLabel2: TTntLabel;
    TntLabel3: TTntLabel;
    EdtPassword2: TTntEdit;
    TntLabel4: TTntLabel;
    TabMoreInfo: TTntTabSheet;
    TabFinished: TTntTabSheet;
    LblWait: TTntStaticText;
    PrBarWait: TTntProgressBar;
    WaitTimer: TTimer;
    JabNew: TJabberSession;
    EdtExtra: TTntEdit;
    LblExtra: TTntLabel;
    LblCongrats: TTntLabel;
    LblMoreInfo: TTntLabel;
    LblFinal: TTntStaticText;
    TntLabel5: TTntLabel;
    SpinEdit1: TSpinEdit;
    FrameTitle1: TFrameTitle;
    procedure TabRegisteringShow(Sender: TObject);
    procedure WaitTimerTimer(Sender: TObject);
    procedure TabRegisteringHide(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure TabWelkomShow(Sender: TObject);
    procedure TabUsernameShow(Sender: TObject);
    procedure TabFinishedShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNewUser: TFrmNewUser;

implementation

{$R *.dfm}


procedure TFrmNewUser.TabRegisteringShow(Sender: TObject);
begin
  WaitTimer.Enabled := true;
end;

procedure TFrmNewUser.WaitTimerTimer(Sender: TObject);
begin
  if PrBarWait.Position < 100 then
    PrBarWait.Position := PrBarWait.Position +1
  else
    PrBarWait.Position := 0;
end;

procedure TFrmNewUser.TabRegisteringHide(Sender: TObject);
begin
  PrBarWait.Position := 0;
  WaitTimer.Enabled := false;
end;

procedure TFrmNewUser.BtnCancelClick(Sender: TObject);
begin
  Close;

end;

procedure TFrmNewUser.TabWelkomShow(Sender: TObject);
begin
  BtnBack.Enabled := False;
end;

procedure TFrmNewUser.TabUsernameShow(Sender: TObject);
begin
  BtnBack.Enabled := true;
end;

procedure TFrmNewUser.TabFinishedShow(Sender: TObject);
var
  MsgFinal : WideString;
begin
  MsgFinal := 'Congratulations, You have just created your jabber account.'+
              #13#10+#13#10+
              'You are now able to loging with your account on %s server.';

  LblFinal.Caption := WideFormat(MsgFinal,[EdtServer.Text]);
end;

end.
