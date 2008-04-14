program PNlDPyramide;

uses
  Forms,
  UHoofd in 'UHoofd.pas' {Form1},
  UKaarten in 'UKaarten.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
