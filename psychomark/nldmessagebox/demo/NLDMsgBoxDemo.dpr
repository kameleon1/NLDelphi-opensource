program NLDMsgBoxDemo;

uses
  Forms,
  FMain in 'Forms\FMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
