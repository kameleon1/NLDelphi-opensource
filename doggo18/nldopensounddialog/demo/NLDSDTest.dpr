program NLDSDTest;

uses
  Forms,
  M_Test in 'M_Test.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
