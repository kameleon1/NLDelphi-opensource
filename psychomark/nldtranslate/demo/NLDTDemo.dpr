program NLDTDemo;

uses
  Forms,
  FMain in 'Forms\FMain.pas' {frmMain},
  MLanguage in 'Modules\MLanguage.pas' {dmLanguage: TDataModule};

{$R *.res}

var
  frmMain: TfrmMain;

begin
  Application.Initialize;
  Application.CreateForm(TdmLanguage, dmLanguage);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
