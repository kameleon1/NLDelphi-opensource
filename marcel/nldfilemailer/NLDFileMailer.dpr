{-----------------------------------------------------------------------------
 Unit:         NLDFileMailer
 Auteur:       Marcel van Beuzekom
 Beschrijving: Commandline tool om via mail een bestand te versturen.
               Kan bijvoorbeeld worden gebruikt om logfiles dagelijks naar
               een adres te versturen.
 Historie:     1.0 14 februari 2003
-----------------------------------------------------------------------------}
program NLDFileMailer;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  FileMailerU in 'FileMailerU.pas' {FileMailer: TDataModule};

function CommandlineSwitch(const Switch: string): string;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to ParamCount do
  begin
    if SameText(Copy(ParamStr(i), 1, Length(Switch)), Switch) then
    begin
      Result := Copy(ParamStr(i), Length(Switch) + 1, MaxInt);
      Break;
    end;
  end;

  if Copy(Result, 1, 1) = '"' then
  begin
    Result := Copy(Result, 2, MaxInt);
    Result := Copy(Result, 1, Pos('"', Result) - 1);
  end;
end;


var
  Address: string;
  FileName: string;
  Subject: string;

begin
  try
    Address := CommandlineSwitch('-a');
    FileName := CommandlineSwitch('-f');
    Subject := CommandlineSwitch('-s');

    Writeln('NLDelphi filemailer versie 1.1. Copyright: Marcel van Beuzekom');
    if (Address = '') or (FileName = '') then
    begin
      Writeln('');
      Writeln('Voor meer informatie: www.NLDelphi.com/opensource');
      Writeln('');
      Writeln('Syntax: NLDFileMailer -aAdres -fBestandsnaam -sOnderwerp');
      Writeln('');
      Writeln('Verzenden naar meedere adressen is mogelijk door de ');
      Writeln('adressen te scheiden door een ;');
      Writeln('');
      Writeln('Bestandsnaam kan de volgende tags bevatten:');
      Writeln('[dd] Dag van de maand in de vorm 01');
      Writeln('[mm] Maand in in de vorm 01');
      Writeln('[yy] Jaar in de form 03');
      Writeln('[yyyy] Jaar in de form 2003');
      Writeln('');
      Writeln('Voorbeeld:');
      Writeln(' -ftest[dd][mm][yyyy].txt wordt ' + ParseFileName('test[dd][mm][yyyy].txt'));
      Writeln('');
      Writeln('Overige instellingen worden uit NLDFileMailer.ini gelezen:');
      Writeln('');
      Writeln('[SMTP]');
      Writeln('Host=SMTP server, default localhost');
      Writeln('UserName=Username voor SMTP server, default leeg');
      Writeln('Password=Password voor SMTP server, default leeg');
      Writeln('Sender=Afzender. Alleen email adres, of volledig in de vorm: Marcel <Marcel@NLDelphi.com>');
    end
    else
    begin
      with TFileMailer.Create(nil) do
      try
        IniFilename := ChangeFileExt(ParamStr(0), '.ini');
        SendFile(Address, FileName, Subject);
      finally
        Free;
      end;
    end;
  except
    on e: Exception do
      Writeln(e.Message);
  end;
end.
