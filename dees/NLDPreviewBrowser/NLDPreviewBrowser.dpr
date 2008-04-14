program NLDPreviewBrowser;

uses
  Forms,
  unNLDPreviewBrowser in 'Source\unNLDPreviewBrowser.pas' {frmNLDPreviewBrowser},
  unNLDPreviewBrowserHelp in 'Source\unNLDPreviewBrowserHelp.pas' {frmInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmNLDPreviewBrowser, frmNLDPreviewBrowser);
  Application.Run;
end.
