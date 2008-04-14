program NLDCheckMail;

uses
  Forms,
  NLDCheckMailUnit in 'NLDCheckMailUnit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := False;
  Application.Title := 'NLDCheckMail';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
