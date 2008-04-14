
{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}


program NLDMessenger;

uses
  Forms,
  UntMain in 'forms\UntMain.pas' {FrmMain: TTntForm},
  UntBaseForm in 'forms\UntBaseForm.pas' {FrmBaseForm: TTntFormLX},
  UntConnect in 'forms\UntConnect.pas' {FrmConnect: TTntForm},
  UntRoster in 'forms\UntRoster.pas' {FrmRoster: TTntForm},
  UntConfig in 'units\UntConfig.pas',
  UntJabber in 'units\UntJabber.pas' {DmJabber: TDataModule},
  UntServer in 'forms\UntServer.pas' {FrmServer: TTntForm},
  UntAbout in 'forms\UntAbout.pas' {FrmAbout: TTntForm},
  UntLogon in 'forms\UntLogon.pas' {FrmLogon: TTntForm},
  UntScreenHandler in 'units\UntScreenHandler.pas',
  UntChat in 'forms\UntChat.pas' {FrmChat: TTntFormLX},
  UntMessage in 'forms\UntMessage.pas' {FrmMessage: TTntFormLX},
  UntPassword in 'forms\UntPassword.pas' {FrmPassword: TTntFormLX},
  WizardNewUser in 'forms\WizardNewUser.pas' {FrmNewUser: TTntForm},
  UntSubscription in 'forms\UntSubscription.pas' {FrmSubscription: TTntForm},
  UntAdd in 'forms\UntAdd.pas' {FrmAdd: TTntForm},
  UntChangeStatus in 'forms\UntChangeStatus.pas' {FrmChangeStatus: TTntForm},
  UntChangeUsername in 'forms\UntChangeUsername.pas' {FrmChangeUserName: TTntForm},
  UntDialog in 'forms\UntDialog.pas' {FrmDialog: TTntFormLX},
  UntXmlOutPut in 'forms\UntXmlOutPut.pas' {FrmXml: TTntForm},
  UntSettings in 'forms\UntSettings.pas' {FrmSettings: TTntFormLX},
  UntGroupChat in 'forms\UntGroupChat.pas' {FrmGroupChat: TTntFormLX},
  UntJRosterNodes in 'units\UntJRosterNodes.pas',
  UntVCard in 'forms\UntVCard.pas' {FrmVCard: TTntFormLX},
  UntBrowser in 'forms\UntBrowser.pas' {FrmBrowser: TTntFormLX},
  UntProfileMan in 'forms\UntProfileMan.pas' {FrmProfileMan: TTntFormLX},
  UntUtil in 'units\UntUtil.pas',
  UntProfile in 'units\UntProfile.pas',
  UntIQ in 'units\UntIQ.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'NLDMessenger';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDmJabber, DmJabber);
  Application.CreateForm(TFrmXml, FrmXml);
  Application.Run;
end.
