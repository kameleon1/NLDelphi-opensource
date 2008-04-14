program NldDust;

uses
  Forms,
  Windows,
  Dialogs,
  Sysutils,
  uMibIfRow in 'Units\uMibIfRow.pas',
  uCommon in 'Units\uCommon.pas',
  uDataArray in 'Units\uDataArray.pas',
  uReadIniFile in 'Units\uReadIniFile.pas',
  uWriteIniFile in 'Units\uWriteIniFile.pas',
  uMain in 'Forms\uMain.pas' {frmMain},
  uLayout in 'Forms\uLayout.pas' {frmLayout},
  uColors in 'Forms\uColors.pas' {frmColors},
  uProgram in 'Forms\uProgram.pas' {frmProgram},
  uAbout in 'Forms\uAbout.pas' {frmAbout},
  uHistory in 'Forms\uHistory.pas' {frmHistory},
  uAlarms in 'Forms\uAlarms.pas' {frmAlarms},
  uAlarmDialog in 'Forms\uAlarmDialog.pas' {frmAlarmDialog};

{$R *.res}
var
  vWindowHandle: HWND;
  vYear, vDay, vMonth: Word;
begin
  Application.Initialize;

  DecodeDate(Now, vYear, vMonth, vDay);

  {Doe een Trial date datum check.}
  if ((vYear <= cRUNYEAR) and (vMonth = cRUNMONTH) and (vDay <= cRUNDAY)) or
    ((vYear <= cRUNYEAR) and (vMonth < cRUNMONTH)) or (vYear < cRUNYEAR) then
    begin
      {Zoek naar een window met de titel gelijk aan cAPPLICATIETITELNLD + cAPPLICATIEVERSIE}
      vWindowHandle := FindWindow('TApplication', pchar(cAPPLICATIETITELNLD + cAPPLICATIEVERSIE));

      {Indien window gevonden dan is vWindowHandle > 0 en wordt er dus GEEN 2e instantie opgestart.}
      if vWindowHandle <> 0 then
        begin
          {Hier GEEN (if IsIconic(hw) then ShowWindow(hw, SW_Restore)) gebruiken !!! dit ivm het trayicon.}
          SetForeGroundWindow(vWindowHandle);
          MessageDlg('There is allready another version of NldDust running.', mtError, [mbOK], 0);
        end
      else
        begin
          {Haal het huide pad op, waar de applicatie zich momenteel in bevind}
          vCurrentPath := ExtractFileDir(Application.ExeName);

          {Controleer of de Ini File bestaat, zoniet dan deze aanmaken met Default settings !!!}
          if not FileExists(vCurrentPath + cINIFILENAME) then
            if not uWriteIniFile.WriteIniFileDefault('All') then
              begin
                {Als Inifile creeren niet succesvol is gelukt dan ...}
                MessageDlg('Application wil be terminated.' + #13 + #10 + 'please contact the author.', mtError, [mbOK], 0);
                Application.Terminate;
              end;

          begin
            Application.Title := 'Down & Up Stream Traffic.';
            Application.CreateForm(TfrmMain, frmMain);
            Application.Run;
          end;
        end;
    end
  else
    begin
      {Als Trial Date Expired is...}
      Beep;
      MessageDlg('Trial date has expired, please contact the author for a newer version of NldDust.' + #13 + #10 + 'Application wil be terminated.', mtError, [mbOK], 0);
      Application.Terminate;
    end;
end.

