program NLDWebsiteChecker;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  NLDWebsiteCheck in 'NLDWebsiteCheck.pas' {NLDSiteCheck: TDataModule},
  NLDWebsiteCheckIntf in 'NLDWebsiteCheckIntf.pas';

begin
  with TNLDSiteCheck.Create(nil) do
  begin
    try
      // Zet Ini en XML Filename;
      IniFilename := ChangeFileExt(ParamStr(0), '.ini');
      XMLFileName := ChangeFileExt(ParamStr(0), '.xml');

      GetSites;
    finally
      Free;
    end;
  end;
end.

