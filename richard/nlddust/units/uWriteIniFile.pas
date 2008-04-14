unit uWriteIniFile;

interface

uses Forms, SysUtils, Dialogs, IniFiles, Graphics;

function WriteIniFileSection(Section: string): Boolean;
function WriteIniFileDefault(Section: string): Boolean;

implementation

uses uMain, uLayout, uColors, uProgram, uReadIniFile, uAlarms;

{=====================================================================================================}
{= functie om 'bepaalde' sectie's op te slaan in de INI FILE. ========================================}
{=====================================================================================================}
function WriteIniFileSection(Section: string): Boolean;
var
  vDefaultIniFile: TMemIniFile;
begin
 {Initialisatie van de vDefaultIniFile, Result, om een Hint / Warning te voorkomen !}
  vDefaultIniFile := nil;
  Result := False;
  try
    try
      vDefaultIniFile := TMemIniFile.Create(vCurrentPath + cINIFILENAME);
      with vDefaultIniFile do
        begin
          {==========================================================================================================}
          if Section = 'Common' then
            begin
              {Common Settings}
              WriteString(cCOMMONSECTION, 'ApplicationTitle', cAPPLICATIETITELNLD);
              WriteString(cCOMMONSECTION, 'ApplicationVersion', cAPPLICATIEVERSIE);
              WriteString(cCOMMONSECTION, 'CurrentApplicationPath', vCurrentPath);
            end;
          {==========================================================================================================}
          if Section = 'Layout' then
            begin
              {Adapter Groupbox}
              WriteBool(cLAYOUTSECTION, 'AdapterBoxShow', frmLayout.CbAdapterShowBox.Checked);
              WriteBool(cLAYOUTSECTION, 'AdapterBoxCaptionShow', frmLayout.CbAdapterShowCaption.Checked);
              {Units Groupbox}
              WriteBool(cLAYOUTSECTION, 'UnitsBoxShow', frmLayout.CbUnitsShowBox.Checked);
              WriteBool(cLAYOUTSECTION, 'UnitsBoxCaptionShow', frmLayout.CbUnitsShowCaption.Checked);
              {Standard Groupbox}
              WriteBool(cLAYOUTSECTION, 'StandardBoxShow', frmLayout.CbStandardShowBox.Checked);
              WriteBool(cLAYOUTSECTION, 'StandardCaptionShow', frmLayout.CbStandardShowCaption.Checked);
              {Decimals Groupbox}
              WriteBool(cLAYOUTSECTION, 'DecimalsBoxListShow', frmLayout.CbDecimalsShowBox.Checked);
              WriteBool(cLAYOUTSECTION, 'DecimalsBoxCaptionShow', frmLayout.CbDecimalsShowCaption.Checked);
            end;
          {==========================================================================================================}
          if Section = 'Colors' then
            begin
              {Session Current Received.}
              WriteString(cCOLORSSECTION, 'SessionCurrentReceivedColor', ColorToString(frmColors.ClrbColorSessionCurrentReceived.Selected));
              WriteBool(cCOLORSSECTION, 'SessionCurrentReceivedBold', frmColors.CbColorSessionCurrentReceived.Checked);
              {Session Average Received.}
              WriteString(cCOLORSSECTION, 'SessionAverageReceivedColor', ColorToString(frmColors.ClrbColorSessionAverageReceived.Selected));
              WriteBool(cCOLORSSECTION, 'SessionAverageReceivedBold', frmColors.CbColorSessionAverageReceived.Checked);
              {Session Max Received.}
              WriteString(cCOLORSSECTION, 'SessionMaxReceivedColor', ColorToString(frmColors.ClrbColorSessionMaxReceived.Selected));
              WriteBool(cCOLORSSECTION, 'SessionMaxReceivedBold', frmColors.CbColorSessionMaxReceived.Checked);
              {Session Total Received.}
              WriteString(cCOLORSSECTION, 'SessionTotalReceivedColor', ColorToString(frmColors.ClrbColorSessionTotalReceived.Selected));
              WriteBool(cCOLORSSECTION, 'SessionTotalReceivedBold', frmColors.CbColorSessionTotalReceived.Checked);
              {Windows Total Received.}
              WriteString(cCOLORSSECTION, 'WindowsTotalReceivedColor', ColorToString(frmColors.ClrbColorWindowsTotalReceived.Selected));
              WriteBool(cCOLORSSECTION, 'WindowsTotalReceivedBold', frmColors.CbColorWindowsTotalReceived.Checked);
              {Session Current Sent.}
              WriteString(cCOLORSSECTION, 'SessionCurrentSentColor', ColorToString(frmColors.ClrbColorSessionCurrentSent.Selected));
              WriteBool(cCOLORSSECTION, 'SessionCurrentSentBold', frmColors.CbColorSessionCurrentSent.Checked);
              {Session Average Sent.}
              WriteString(cCOLORSSECTION, 'SessionAverageSentColor', ColorToString(frmColors.ClrbColorSessionAverageSent.Selected));
              WriteBool(cCOLORSSECTION, 'SessionAverageSentBold', frmColors.CbColorSessionAverageSent.Checked);
              {Session Max Sent.}
              WriteString(cCOLORSSECTION, 'SessionMaxSentColor', ColorToString(frmColors.ClrbColorSessionMaxSent.Selected));
              WriteBool(cCOLORSSECTION, 'SessionMaxSentBold', frmColors.CbColorSessionMaxSent.Checked);
              {Session Total Sent.}
              WriteString(cCOLORSSECTION, 'SessionTotalSentColor', ColorToString(frmColors.ClrbColorSessionTotalSent.Selected));
              WriteBool(cCOLORSSECTION, 'SessionTotalSentBold', frmColors.CbColorSessionTotalSent.Checked);
              {Windows Total Sent.}
              WriteString(cCOLORSSECTION, 'WindowsTotalSentColor', ColorToString(frmColors.ClrbColorWindowsTotalSent.Selected));
              WriteBool(cCOLORSSECTION, 'WindowsTotalSentBold', frmColors.CbColorWindowsTotalSent.Checked);
            end;
          {==========================================================================================================}
          if Section = 'Program' then
            begin
              {Adapter Groupbox}
              WriteInteger(cPROGRAMSECTION, 'AdapterBoxIndex', frmProgram.CmbAdapterLijst.ItemIndex);
              {Units Groupbox}
              WriteBool(cPROGRAMSECTION, 'UnitsInBits', frmProgram.RbBits.Checked);
              WriteBool(cPROGRAMSECTION, 'UnitsInBytes', frmProgram.RbBytes.Checked);
              {Standard Groupbox}
              WriteBool(cPROGRAMSECTION, 'StandardInBinary', frmProgram.RbStandardBinary.Checked);
              WriteBool(cPROGRAMSECTION, 'StandardInDecimal', frmProgram.RbStandartDecimal.Checked);
              {Decimals Groupbox}
              WriteBool(cPROGRAMSECTION, 'Decimals1Decimal', frmProgram.Rb1Decimaal.Checked);
              WriteBool(cPROGRAMSECTION, 'Decimals2Decimal', frmProgram.Rb2Decimaal.Checked);
              WriteBool(cPROGRAMSECTION, 'Decimals3Decimal', frmProgram.Rb3Decimaal.Checked);
              WriteBool(cPROGRAMSECTION, 'Decimals4Decimal', frmProgram.Rb4Decimaal.Checked);
              {Common Groupbox}
              WriteBool(cPROGRAMSECTION, 'ShowHints', frmProgram.CbShowhints.Checked);
              WriteBool(cPROGRAMSECTION, 'SaveOnExit', frmProgram.CbSaveonexit.Checked);
              WriteBool(cPROGRAMSECTION, 'MinimizeOnRun', frmProgram.CbMinimizeonrun.Checked);
              WriteBool(cPROGRAMSECTION, 'ConfirmExit', frmProgram.CbConfirmExit.Checked);
              WriteBool(cPROGRAMSECTION, 'StayOnTop', frmProgram.CbStayOnTop.Checked);
            end;
          {==========================================================================================================}
          if Section = 'SaveOnExit' then
            begin
              {Adapter Groupbox}
              if vLayOutAdapterBoxShow then
                begin
                  WriteInteger(cPROGRAMSECTION, 'AdapterBoxIndex', frmMain.CmbAdapterLijst.ItemIndex);
                end;
              {Units Groupbox}
              if vLayOutUnitsBoxShow then
                begin
                  WriteBool(cPROGRAMSECTION, 'UnitsInBits', frmMain.RbBits.Checked);
                  WriteBool(cPROGRAMSECTION, 'UnitsInBytes', frmMain.RbBytes.Checked);
                end;
              {Standard Groupbox}
              if vLayOutStandardBoxShow then
                begin
                  WriteBool(cPROGRAMSECTION, 'StandardInBinary', frmMain.RbStandardBinary.Checked);
                  WriteBool(cPROGRAMSECTION, 'StandardInDecimal', frmMain.RbStandartDecimal.Checked);
                end;
              {Decimals Groupbox}
              if vLayOutDecimalsBoxShow then
                begin
                  WriteBool(cPROGRAMSECTION, 'Decimals1Decimal', frmMain.Rb1Decimaal.Checked);
                  WriteBool(cPROGRAMSECTION, 'Decimals2Decimal', frmMain.Rb2Decimaal.Checked);
                  WriteBool(cPROGRAMSECTION, 'Decimals3Decimal', frmMain.Rb3Decimaal.Checked);
                  WriteBool(cPROGRAMSECTION, 'Decimals4Decimal', frmMain.Rb4Decimaal.Checked);
                end;
            end;
          {==========================================================================================================}
          if Section = 'Alarms' then
            begin
              {Alarm 1 Settings.}
              WriteFloat(cALARMSSECTION, 'AlarmLimit1', frmAlarms.SpeAlarmLimit1.Value);
              WriteInteger(cALARMSSECTION, 'AlarmUnits1', frmAlarms.CmbAlarmUnits1.ItemIndex);
              WriteInteger(cALARMSSECTION, 'AlarmAttachedTo1', frmAlarms.CmbAlarmAttachedTo1.ItemIndex);
              WriteBool(cALARMSSECTION, 'AlarmActive1', frmAlarms.CbAlarmActive1.Checked);
              WriteBool(cALARMSSECTION, 'AlarmTimerActive1', frmAlarms.CbAlarmTimerActive1.Checked);
              WriteInteger(cALARMSSECTION, 'AlarmTimerValue1', frmAlarms.SpeAlarmTimer1.AsInteger);
              WriteBool(cALARMSSECTION, 'AlarmOnTop1', frmAlarms.CbAlarmOnTop1.Checked);
              WriteBool(cALARMSSECTION, 'AlarmSound1', frmAlarms.CbAlarmSound1.Checked);
              {Alarm 2 Settings.}
              WriteFloat(cALARMSSECTION, 'AlarmLimit2', frmAlarms.SpeAlarmLimit2.Value);
              WriteInteger(cALARMSSECTION, 'AlarmUnits2', frmAlarms.CmbAlarmUnits2.ItemIndex);
              WriteInteger(cALARMSSECTION, 'AlarmAttachedTo2', frmAlarms.CmbAlarmAttachedTo2.ItemIndex);
              WriteBool(cALARMSSECTION, 'AlarmActive2', frmAlarms.CbAlarmActive2.Checked);
              WriteBool(cALARMSSECTION, 'AlarmTimerActive2', frmAlarms.CbAlarmTimerActive2.Checked);
              WriteInteger(cALARMSSECTION, 'AlarmTimerValue2', frmAlarms.SpeAlarmTimer2.AsInteger);
              WriteBool(cALARMSSECTION, 'AlarmOnTop2', frmAlarms.CbAlarmOnTop2.Checked);
              WriteBool(cALARMSSECTION, 'AlarmSound2', frmAlarms.CbAlarmSound2.Checked);
            end;
          {==========================================================================================================}

          UpdateFile;
          Result := True;
        end;
    except
      Beep;
      MessageDlg('Error raised while creating ini file.' + #13 + #10 + 'function : uWriteIniFile.WriteIniFileSection.', mtError, [mbOK], 0);
    end;
  finally
    vDefaultIniFile.Free;
  end;
end;

{=====================================================================================================}
{= functie om een DEFAULT INI FILE weg te schrijven. =================================================}
{=====================================================================================================}
function WriteIniFileDefault(Section: string): Boolean;
var
  vDefaultIniFile: TMemIniFile;
begin
 {Initialisatie van de vDefaultIniFile, Result, om een Hint / Warning te voorkomen !}
  vDefaultIniFile := nil;
  Result := False;
  try
    try
      vDefaultIniFile := TMemIniFile.Create(vCurrentPath + cINIFILENAME);
      with vDefaultIniFile do
        begin
          if Section = 'All' then
            begin
              {Common Settings}
              WriteString(cCOMMONSECTION, 'ApplicationTitle', cAPPLICATIETITELNLD);
              WriteString(cCOMMONSECTION, 'ApplicationVersion', cAPPLICATIEVERSIE);
              WriteString(cCOMMONSECTION, 'CurrentApplicationPath', vCurrentPath);

              {Adapter Groupbox}
              WriteBool(cLAYOUTSECTION, 'AdapterBoxShow', True);
              WriteBool(cLAYOUTSECTION, 'AdapterBoxCaptionShow', True);
              {Units Groupbox}
              WriteBool(cLAYOUTSECTION, 'UnitsBoxShow', True);
              WriteBool(cLAYOUTSECTION, 'UnitsBoxCaptionShow', True);
              {Standard Groupbox}
              WriteBool(cLAYOUTSECTION, 'StandardBoxShow', False);
              WriteBool(cLAYOUTSECTION, 'StandardCaptionShow', False);
              {Decimals Groupbox}
              WriteBool(cLAYOUTSECTION, 'DecimalsBoxListShow', False);
              WriteBool(cLAYOUTSECTION, 'DecimalsBoxCaptionShow', False);

              {Session Current Received.}
              WriteString(cCOLORSSECTION, 'SessionCurrentReceivedColor', 'clRed');
              WriteBool(cCOLORSSECTION, 'SessionCurrentReceivedBold', False);
              {Session Average Received.}
              WriteString(cCOLORSSECTION, 'SessionAverageReceivedColor', 'clTeal');
              WriteBool(cCOLORSSECTION, 'SessionAverageReceivedBold', False);
              {Session Max Received.}
              WriteString(cCOLORSSECTION, 'SessionMaxReceivedColor', 'clRed');
              WriteBool(cCOLORSSECTION, 'SessionMaxReceivedBold', False);
              {Session Total Received.}
              WriteString(cCOLORSSECTION, 'SessionTotalReceivedColor', 'clGreen');
              WriteBool(cCOLORSSECTION, 'SessionTotalReceivedBold', False);
              {Windows Total Received.}
              WriteString(cCOLORSSECTION, 'WindowsTotalReceivedColor', 'clNavy');
              WriteBool(cCOLORSSECTION, 'WindowsTotalReceivedBold', True);
              {Session Current Sent.}
              WriteString(cCOLORSSECTION, 'SessionCurrentSentColor', 'clBlue');
              WriteBool(cCOLORSSECTION, 'SessionCurrentSentBold', False);
              {Session Average Sent.}
              WriteString(cCOLORSSECTION, 'SessionAverageSentColor', 'clTeal');
              WriteBool(cCOLORSSECTION, 'SessionAverageSentBold', False);
              {Session Max Sent.}
              WriteString(cCOLORSSECTION, 'SessionMaxSentColor', 'clBlue');
              WriteBool(cCOLORSSECTION, 'SessionMaxSentBold', False);
              {Session Total Sent.}
              WriteString(cCOLORSSECTION, 'SessionTotalSentColor', 'clGreen');
              WriteBool(cCOLORSSECTION, 'SessionTotalSentBold', False);
              {Windows Total Sent.}
              WriteString(cCOLORSSECTION, 'WindowsTotalSentColor', 'clNavy');
              WriteBool(cCOLORSSECTION, 'WindowsTotalSentBold', True);

              {Adapter Groupbox}
              WriteInteger(cPROGRAMSECTION, 'AdapterBoxIndex', 0);
              {Units Groupbox}
              WriteBool(cPROGRAMSECTION, 'UnitsInBits', False);
              WriteBool(cPROGRAMSECTION, 'UnitsInBytes', True);
              {Standard Groupbox}
              WriteBool(cPROGRAMSECTION, 'StandardInBinary', True);
              WriteBool(cPROGRAMSECTION, 'StandardInDecimal', False);
              {Decimals Groupbox}
              WriteBool(cPROGRAMSECTION, 'Decimals1Decimal', False);
              WriteBool(cPROGRAMSECTION, 'Decimals2Decimal', True);
              WriteBool(cPROGRAMSECTION, 'Decimals3Decimal', False);
              WriteBool(cPROGRAMSECTION, 'Decimals4Decimal', False);
              {Common Groupbox}
              WriteBool(cPROGRAMSECTION, 'ShowHints', True);
              WriteBool(cPROGRAMSECTION, 'SaveOnExit', False);
              WriteBool(cPROGRAMSECTION, 'MinimizeOnRun', False);
              WriteBool(cPROGRAMSECTION, 'ConfirmExit', False);
              WriteBool(cPROGRAMSECTION, 'StayOnTop', False);

              {Alarm 1 Settings}
              WriteFloat(cALARMSSECTION, 'AlarmLimit1', 55);
              WriteInteger(cALARMSSECTION, 'AlarmUnits1', 5);
              WriteInteger(cALARMSSECTION, 'AlarmAttachedTo1', 0);
              WriteBool(cALARMSSECTION, 'AlarmActive1', False);
              WriteBool(cALARMSSECTION, 'AlarmTimerActive1', True);
              WriteInteger(cALARMSSECTION, 'AlarmTimerValue1', 60);
              WriteBool(cALARMSSECTION, 'AlarmOnTop1', False);
              WriteBool(cALARMSSECTION, 'AlarmSound1', True);
              {Alarm 2 Settings}
              WriteFloat(cALARMSSECTION, 'AlarmLimit2', 12);
              WriteInteger(cALARMSSECTION, 'AlarmUnits2', 5);
              WriteInteger(cALARMSSECTION, 'AlarmAttachedTo2', 4);
              WriteBool(cALARMSSECTION, 'AlarmActive2', False);
              WriteBool(cALARMSSECTION, 'AlarmTimerActive2', True);
              WriteInteger(cALARMSSECTION, 'AlarmTimerValue2', 60);
              WriteBool(cALARMSSECTION, 'AlarmOnTop2', False);
              WriteBool(cALARMSSECTION, 'AlarmSound2', True);
            end;
          UpdateFile;
          Result := True;
        end;
    except
      Beep;
      MessageDlg('Error raised while creating ini file.' + #13 + #10 + 'function : uWriteIniFile.WriteDefaultIniFile.', mtError, [mbOK], 0);
    end;
  finally
    vDefaultIniFile.Free;
  end;
end;

end.

