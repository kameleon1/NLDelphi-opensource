unit NLDWebsiteCheck;

interface

uses
  SysUtils, Classes, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, DB, ADODB, IdMessageClient, IdSMTP, IdMessage,
  IniFiles, ActiveX, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TNLDSiteCheck = class(TDataModule)
    HTTP          : TIdHTTP;
    SMTP          : TIdSMTP;
    MailMessage   : TIdMessage;
    XMLDocument: TXMLDocument;
  private
    { Private declarations }
    FIniFilename: string;
    FXMLFileName: string;

    procedure GetIniSettings;
    procedure SetIniFilename(const Value: string);
    procedure SetXMLFileName(const Value: string);
  public
    { Public declarations }
    procedure  CheckWebSite(URL, Mail: string);
    procedure  GetSites;
    property   IniFilename: string read FIniFilename write SetIniFilename;
    property   XMLFileName: string read FXMLFileName write SetXMLFileName;
  end;

var
  NLDSiteCheck: TNLDSiteCheck;

implementation

{$R *.dfm}

{ TNLDWebsiteCheck }

type
  TSplitArray = array of String;

{ Bedankt PsychoMark!
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



procedure TNLDSiteCheck.CheckWebSite(URL, Mail: string);
var
  i           : Integer;
  content     : string;
  Recipients  : TSplitArray;
begin
  try

    try
      HTTP.Connect(-1);

      try

        if HTTP.Connected then
          content := HTTP.Get(URL);

      except

        // Wis eerdere Mailadressen
        with MailMessage. Recipients do
          Clear;

        { Meerdere ontvangers zijn gescheiden door een ; }
        if Pos(';', Mail) > 0 then
        begin
          Recipients := Split(Mail, ';');

          for i := 0 to Length(Recipients) - 1 do
            with MailMessage.Recipients.Add do
              Text := Recipients[i];
        end
        else
          with MailMessage.Recipients.Add do
            Text := Mail;

        with MailMessage do
        begin
          Subject := '#Error# ' + URL;
          Body.Text := 'Fout bij openen website: '+ #13#10 + URL;
        end;

        // verstuur mail
        with SMTP do
        begin

          try
            Connect(-1);
            Send(MailMessage);
          finally
            Disconnect();
          end;

        end;

      end;
    except
    end;
  finally
    HTTP.Disconnect();
  end;
end;

procedure TNLDSiteCheck.GetIniSettings;
begin
  // Haal gegevens uit Inifile
  with TIniFile.Create(FIniFileName) do

  try

    SMTP.Host             := ReadString('SMTP', 'host', 'localhost');
    SMTP.Username         := ReadString('SMTP', 'user', '');
    SMTP.Password         := ReadString('SMTP', 'pass', '');

    MailMessage.From.Text := ReadString('SMTP', 'sender', '');

  finally
    Free;
  end;

  if (Trim(SMTP.Username) <> '') and (Trim(SMTP.Password) <> '') then
    SMTP.AuthenticationType := atLogin
  else
    SMTP.AuthenticationType := atNone;
end;

procedure TNLDSiteCheck.SetIniFilename(const Value: string);
begin
  FIniFilename := Value;
  GetIniSettings;
end;

procedure TNLDSiteCheck.SetXMLFileName(const Value: string);
begin
  FXMLFileName := Value;
end;

procedure TNLDSiteCheck.GetSites;
var
  xmlRoot         : IXMLNode;
  xmlSite         : IXMLNode;
  xmlSiteItem     : IXMLNode;
  xmlDefaultMail  : IXMLNode;
  URL, Mail       : string;
  DefaultMail     : string;
begin

  // Zet de FileName van XML - document
  XMLDocument.FileName := FXMLFileName;

  try
    XMLDocument.Active := True; // Active

    xmlRoot   := XMLDocument.DocumentElement;

    // Haal default mail uit XML - file
    xmlDefaultMail := xmlRoot.ChildNodes.FindNode('DefaultMail');
      DefaultMail := xmlDefaultMail.NodeValue;

    // FindNode <Site>
    xmlSite  := xmlRoot.ChildNodes.FindNode('Site');
    while Assigned(xmlSite) do // Zolang er een site is.
    begin
      // Eerste Kind
      xmlSiteItem  := xmlSite.ChildNodes[0];

      while Assigned(xmlSiteItem) do // Zolang er een Site-Item is
      begin

        // Kijk of Site Item 'URL' of 'Mail' is.
        if xmlSiteItem.NodeName = 'URL' then
          URL := xmlSiteItem.NodeValue;

        if xmlSiteItem.NodeName = 'Mail' then
          Mail := xmlSiteItem.NodeValue;

        // Volgende SiteItem
        xmlSiteItem  := xmlSiteItem.NextSibling;
      end;

      // Controleer of Mail Leeg is
      if Trim(Mail) = '' then
        Mail := DefaultMail;

      // Kinderen zijn op, Kijk of site bestaat.
      if trim(URL) <> '' then
        CheckWebSite(URL,Mail);

      // Volgende <Site>
      xmlSite  := xmlSite.NextSibling;
    end;

  finally
    XMLDocument.Active := False;
  end;

end;

initialization
  CoInitialize(nil);
finalization
  CoUninitialize;

end.
