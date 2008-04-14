{-----------------------------------------------------------------------------
 Unit:         FileMailerU
 Auteur:       Marcel van Beuzekom
 Beschrijving: Datamodule met de eigenlijke code voor NLDFileMailer
-----------------------------------------------------------------------------}
unit FileMailerU;

interface

uses
  SysUtils, Classes, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient, IdSMTP, IdMessage;

type
  TFileMailer = class(TDataModule)
    SMTP: TIdSMTP;
    MailMessage: TIdMessage;
  private
    FIniFilename: string;
    procedure ReadSettings;
    procedure SetIniFilename(const Value: string);
  public
    procedure SendFile(const SendTo, FileName, Subject: string);

    property IniFilename: string read FIniFilename write SetIniFilename;
  end;

  function ParseFileName(const FileName: string): string;

implementation

{$R *.dfm}

uses
  IniFiles;

{ TFileMailer }

type
  TSplitArray = array of String;

{ Dankjewel PsychoMark!
  http://www.x2software.net/viewarticle.php?id=5&page=2
}
function Split(const Source, Delimiter: String): TSplitArray;
var
  iCount:    Integer;
  iPos:      Integer;
  iLength:    Integer;
  sTemp:      String;
  aSplit:    TSplitArray;

begin
  sTemp  := Source;
  iCount  := 0;
  iLength := Length(Delimiter) - 1;

  repeat
    iPos := Pos(Delimiter, sTemp);

    if iPos = 0 then
      break
    else begin
      Inc(iCount);
      SetLength(aSplit, iCount);
      aSplit[iCount - 1] := Copy(sTemp, 1, iPos - 1);
      Delete(sTemp, 1, iPos + iLength);
    end;
  until False;

  if Length(sTemp) > 0 then begin
    Inc(iCount);
    SetLength(aSplit, iCount);
    aSplit[iCount - 1] := sTemp;
  end;

  Result := aSplit;
end;


{ FileName kan de volgende tags bevatten:

  [dd] Dag van de maand in de vorm 01
  [mm] Maand in in de vorm 01
  [yy] Jaar in de form 03
  [yyyy] Jaar in de form 2003
}
function ParseFileName(const FileName: string): string;

  function CheckString(const S, Search, Replace: string): string;
  begin
    Result := StringReplace(S, Search, Replace,
      [rfReplaceAll, rfIgnoreCase]);
  end;

begin
  Result := FileName;
  Result := CheckString(Result, '[dd]', FormatDateTime('dd', Date));
  Result := CheckString(Result, '[mm]', FormatDateTime('mm', Date));
  Result := CheckString(Result, '[yy]', FormatDateTime('yy', Date));
  Result := CheckString(Result, '[yyyy]', FormatDateTime('yyyy', Date));
end;

procedure TFileMailer.ReadSettings;
begin
  with TIniFile.Create(FIniFileName) do
  try
    SMTP.Host := ReadString('SMTP', 'Host', 'localhost');
    SMTP.Username := ReadString('SMTP', 'UserName', '');
    SMTP.Password := ReadString('SMTP', 'Password', '');
    MailMessage.From.Text := ReadString('SMTP', 'Sender', 'NLDFileMailer');
  finally
    Free;
  end;

  if (SMTP.Username <> '') and (SMTP.Password <> '') then
    SMTP.AuthenticationType := atLogin
  else
    SMTP.AuthenticationType := atNone;
end;

procedure TFileMailer.SendFile(const SendTo, FileName, Subject: string);
var
  Recipients: TSplitArray;
  i: Integer;
begin
  { Meerdere ontvangers zijn gescheiden door een ; }
  if Pos(';', SendTo) > 0 then
  begin
    Recipients := Split(SendTo, ';');

    for i := 0 to Length(Recipients) - 1 do
      with MailMessage.Recipients.Add do
        Text := Recipients[i];
  end
  else
    with MailMessage.Recipients.Add do
      Text := SendTo;

  MailMessage.Subject := Subject;

  TIdAttachment.Create(MailMessage.MessageParts, ParseFileName(FileName));

  SMTP.Connect(10000);
  try
    SMTP.Send(MailMessage);
  finally
    SMTP.Disconnect;
  end;
end;

procedure TFileMailer.SetIniFilename(const Value: string);
begin
  FIniFilename := Value;
  ReadSettings;
end;

end.
