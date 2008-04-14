{-----------------------------------------------------------------------------
 Unit:         NLDHeaderCheck
 Auteur:       Marcel van Beuzekom
 Beschrijving: Commandline tool van een URL de header op te vragen. Kan handig
               zijn om wat meer informatie over de URL te zien
 Historie:     1.0 14 februari 2003
-----------------------------------------------------------------------------}
program NLDHeaderCheck;

{$APPTYPE CONSOLE}


uses
  SysUtils,
  IdHTTP,
  IdAuthentication;

type
  TAuthHandler  = class(TObject)
    class procedure OnAuthorization(Sender: TObject;
                                    Authentication: TIdAuthentication;
                                    var Handled: Boolean);
  end;


{ TAuthHandler }
class procedure TAuthHandler.OnAuthorization;
var
  sInput:     String;

begin
  if not (Sender is TIdHTTP) then
    exit;

  WriteLn('Toegang geweigerd!');
  Write('Gebruikersnaam: ');
  ReadLn(sInput);
  Authentication.Username := sInput;

  Write('Paswoord: ');
  ReadLn(sInput);
  Authentication.Password := sInput;
  WriteLn;

  Authentication.Reset();
  Handled := True;
end;


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
  i: Integer;
  GetURL: string;
  Agent: string;
  Username: string;
  Password: string;
  HeadName: string;
  HTTP: TIdHTTP;

begin
  Writeln('NLDelphi headercheck versie 1.1. Copyright: Marcel van Beuzekom');
  Writeln;

  GetURL := CommandlineSwitch('-u');
  Agent := CommandlineSwitch('-a');
  Username  := CommandLineSwitch('-g');
  Password  := CommandLineSwitch('-p');

  if GetURL = '' then
  begin
    Writeln('');
    Writeln('Voor meer informatie: www.NLDelphi.com/opensource');
    Writeln('');
    Writeln('Syntax: NLDHeaderCheck -uURL [-aAgent] [-gGebruiker] [-pPaswoord]');
  end
  else
  begin
    HTTP := TIdHTTP.Create(nil);
    try
        if Agent = '' then
          Agent := 'NLDelphi Headercheck. www.NLDelphi.com/opensource';

        HTTP.Request.UserAgent  := Agent;
        HTTP.Request.Username   := Username;
        HTTP.Request.Password   := Password;
        HTTP.Response.KeepAlive := False;
        HTTP.OnAuthorization    := TAuthHandler.OnAuthorization;

        HTTP.Request.BasicAuthentication  := ((Length(Username) > 0) or
                                              (Length(Password) > 0));

        repeat
          HTTP.Head(GetURL);

          // If we don't clear the authentication it will retry internally,
          // not raise OnAuthorization and eventually get to a Stream
          // Read Error...
          HTTP.Request.Username             := '';
          HTTP.Request.Password             := '';
          HTTP.Request.BasicAuthentication  := False;

          // Perhaps we should limit it to 3 retries, but who cares. Just press
          // Ctrl-C if you want out of the authorization loop...
        until HTTP.ResponseCode <> 401;

        WriteLn(HTTP.Response.ResponseText);
        
        for i := 0 to HTTP.Response.RawHeaders.Count - 1 do
        begin
          HeadName := HTTP.Response.RawHeaders.Names[i];
          WriteLn(HeadName + ': ' + HTTP.Response.RawHeaders.Values[HeadName]);
        end;
    finally
      HTTP.Free;
    end;
  end;
end.
