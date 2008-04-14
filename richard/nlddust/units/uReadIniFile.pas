unit uReadIniFile;

interface

uses Forms, SysUtils, Dialogs, IniFiles, Graphics;

function ReadIniFileSectionSetVar(Section: string): Boolean;
function ReadIniFileSectionSetObject(Section: string): Boolean;

var
  vLayOutAdapterBoxShow: Boolean;
  vLayOutAdapterBoxCaptionShow: Boolean;
  vLayOutUnitsBoxShow: Boolean;
  vLayOutUnitsBoxCaptionShow: Boolean;
  vLayOutStandardBoxShow: Boolean;
  vLayOutStandardBoxCaptionShow: Boolean;
  vLayOutDecimalsBoxShow: Boolean;
  vLayOutDecimalsBoxCaptionShow: Boolean;

  vSessionCurrentReceivedColor: string;
  vSessionCurrentReceivedBold: Boolean;
  vSessionAverageReceivedColor: string;
  vSessionAverageReceivedBold: Boolean;
  vSessionMaxReceivedColor: string;
  vSessionMaxReceivedBold: Boolean;
  vSessionTotalReceivedColor: string;
  vSessionTotalReceivedBold: Boolean;
  vWindowsTotalReceivedColor: string;
  vWindowsTotalReceivedBold: Boolean;
  vSessionCurrentSentColor: string;
  vSessionCurrentSentBold: Boolean;
  vSessionAverageSentColor: string;
  vSessionAverageSentBold: Boolean;
  vSessionMaxSentColor: string;
  vSessionMaxSentBold: Boolean;
  vSessionTotalSentColor: string;
  vSessionTotalSentBold: Boolean;
  vWindowsTotalSentColor: string;
  vWindowsTotalSentBold: Boolean;

  vAdapterBoxIndex: Integer;
  vUnitsInBits: Boolean;
  vUnitsInBytes: Boolean;
  vStandardInBinary: Boolean;
  vStandardInDecimal: Boolean;
  vDecimals1Decimal: Boolean;
  vDecimals2Decimal: Boolean;
  vDecimals3Decimal: Boolean;
  vDecimals4Decimal: Boolean;

  vShowHints: Boolean;
  vSaveOnExit: Boolean;
  vMinimizeOnRun: Boolean;
  vConfirmExit: Boolean;
  vStayOnTop: Boolean;

  vAlarmLimit1: Single;
  vAlarmUnits1: Integer;
  vAlarmAttachedTo1: Integer;
  vAlarmActive1: Boolean;
  vAlarmTimerActive1: Boolean;
  vAlarmTimerValue1: Integer;
  vAlarmOnTop1: Boolean;
  vAlarmSound1: Boolean;

  vAlarmLimit2: Single;
  vAlarmUnits2: Integer;
  vAlarmAttachedTo2: Integer;
  vAlarmActive2: Boolean;
  vAlarmTimerActive2: Boolean;
  vAlarmTimerValue2: Integer;
  vAlarmOnTop2: Boolean;
  vAlarmSound2: Boolean;
implementation

uses uMain, uLayout, uColors, uProgram, uAlarms;

{=====================================================================================================}
{= functie om 'bepaalde' sectie's in variabelen te laden. ============================================}
{=====================================================================================================}
function ReadIniFileSectionSetVar(Section: string): Boolean;
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
          if (Section = 'Layout') or (Section = 'All') then
            begin
              {Adapter Groupbox}
              vLayOutAdapterBoxShow := ReadBool(cLAYOUTSECTION, 'AdapterBoxShow', True);
              vLayOutAdapterBoxCaptionShow := ReadBool(cLAYOUTSECTION, 'AdapterBoxCaptionShow', True);
              {Units Groupbox}
              vLayOutUnitsBoxShow := ReadBool(cLAYOUTSECTION, 'UnitsBoxShow', True);
              vLayOutUnitsBoxCaptionShow := ReadBool(cLAYOUTSECTION, 'UnitsBoxCaptionShow', True);
              {Standard Groupbox}
              vLayOutStandardBoxShow := ReadBool(cLAYOUTSECTION, 'StandardBoxShow', True);
              vLayOutStandardBoxCaptionShow := ReadBool(cLAYOUTSECTION, 'StandardCaptionShow', True);
              {Decimals Groupbox}
              vLayOutDecimalsBoxShow := ReadBool(cLAYOUTSECTION, 'DecimalsBoxListShow', True);
              vLayOutDecimalsBoxCaptionShow := ReadBool(cLAYOUTSECTION, 'DecimalsBoxCaptionShow', True);
            end;

          if (Section = 'Colors') or (Section = 'All') then
            begin
              {Session Current Received Color}
              vSessionCurrentReceivedColor := ReadString(cCOLORSSECTION, 'SessionCurrentReceivedColor', 'clRed');
              vSessionCurrentReceivedBold := ReadBool(cCOLORSSECTION, 'SessionCurrentReceivedBold', False);
              {Session Average Received Color}
              vSessionAverageReceivedColor := ReadString(cCOLORSSECTION, 'SessionAverageReceivedColor', 'clTeal');
              vSessionAverageReceivedBold := ReadBool(cCOLORSSECTION, 'SessionAverageReceivedBold', False);
              {Session Max Received Color}
              vSessionMaxReceivedColor := ReadString(cCOLORSSECTION, 'SessionMaxReceivedColor', 'clRed');
              vSessionMaxReceivedBold := ReadBool(cCOLORSSECTION, 'SessionMaxReceivedBold', False);
              {Session Total Received Color}
              vSessionTotalReceivedColor := ReadString(cCOLORSSECTION, 'SessionTotalReceivedColor', 'clGreen');
              vSessionTotalReceivedBold := ReadBool(cCOLORSSECTION, 'SessionTotalReceivedBold', False);
              {Windows Total Received Color}
              vWindowsTotalReceivedColor := ReadString(cCOLORSSECTION, 'WindowsTotalReceivedColor', 'clNavy');
              vWindowsTotalReceivedBold := ReadBool(cCOLORSSECTION, 'WindowsTotalReceivedBold', True);
              {Session Current Sent Color}
              vSessionCurrentSentColor := ReadString(cCOLORSSECTION, 'SessionCurrentSentColor', 'clBlue');
              vSessionCurrentSentBold := ReadBool(cCOLORSSECTION, 'SessionCurrentSentBold', False);
              {Session Average Sent Color}
              vSessionAverageSentColor := ReadString(cCOLORSSECTION, 'SessionAverageSentColor', 'clTeal');
              vSessionAverageSentBold := ReadBool(cCOLORSSECTION, 'SessionAverageSentBold', False);
              {Session Max Sent Color}
              vSessionMaxSentColor := ReadString(cCOLORSSECTION, 'SessionMaxSentColor', 'clBlue');
              vSessionMaxSentBold := ReadBool(cCOLORSSECTION, 'SessionMaxSentBold', False);
              {Session Total Sent Color}
              vSessionTotalSentColor := ReadString(cCOLORSSECTION, 'SessionTotalSentColor', 'clGreen');
              vSessionTotalSentBold := ReadBool(cCOLORSSECTION, 'SessionTotalSentBold', False);
              {Windows Total Sent Color}
              vWindowsTotalSentColor := ReadString(cCOLORSSECTION, 'WindowsTotalSentColor', 'clNavy');
              vWindowsTotalSentBold := ReadBool(cCOLORSSECTION, 'WindowsTotalSentBold', True);
            end;

          if (Section = 'Program') or (Section = 'All') then
            begin
              {Adapter Groupbox}
              vAdapterBoxIndex := ReadInteger(cPROGRAMSECTION, 'AdapterBoxIndex', 0);
              {Units Groupbox}
              vUnitsInBits := ReadBool(cPROGRAMSECTION, 'UnitsInBits', False);
              vUnitsInBytes := ReadBool(cPROGRAMSECTION, 'UnitsInBytes', True);
              {Standard Groupbox}
              vStandardInBinary := ReadBool(cPROGRAMSECTION, 'StandardInBinary', True);
              vStandardInDecimal := ReadBool(cPROGRAMSECTION, 'StandardInDecimal', False);
              {Decimals Groupbox}
              vDecimals1Decimal := ReadBool(cPROGRAMSECTION, 'Decimals1Decimal', False);
              vDecimals2Decimal := ReadBool(cPROGRAMSECTION, 'Decimals2Decimal', True);
              vDecimals3Decimal := ReadBool(cPROGRAMSECTION, 'Decimals3Decimal', False);
              vDecimals4Decimal := ReadBool(cPROGRAMSECTION, 'Decimals4Decimal', False);
              {Common Groupbox}
              vShowHints := ReadBool(cPROGRAMSECTION, 'ShowHints', True);
              vSaveOnExit := ReadBool(cPROGRAMSECTION, 'SaveOnExit', False);
              vMinimizeOnRun := ReadBool(cPROGRAMSECTION, 'MinimizeOnRun', False);
              vConfirmExit := ReadBool(cPROGRAMSECTION, 'ConfirmExit', False);
              vStayOnTop := ReadBool(cPROGRAMSECTION, 'StayOnTop', False);
            end;

          if (Section = 'Alarms') or (Section = 'All') then
            begin
              {Alarm 1 settings.}
              vAlarmLimit1 := ReadFloat(cALARMSSECTION, 'AlarmLimit1', 55);
              vAlarmUnits1 := ReadInteger(cALARMSSECTION, 'AlarmUnits1', 5);
              vAlarmAttachedTo1 := ReadInteger(cALARMSSECTION, 'AlarmAttachedTo1', 0);
              vAlarmActive1 := ReadBool(cALARMSSECTION, 'AlarmActive1', False);
              vAlarmTimerActive1:= ReadBool(cALARMSSECTION, 'AlarmTimerActive1', True);
              vAlarmTimerValue1 := ReadInteger(cALARMSSECTION, 'AlarmTimerValue1', 60);
              vAlarmOnTop1:=ReadBool(cALARMSSECTION, 'AlarmOnTop1', False);
              vAlarmSound1:=ReadBool(cALARMSSECTION, 'AlarmSound1', True);
              {Alarm 2 settings.}
              vAlarmLimit2 := ReadFloat(cALARMSSECTION, 'AlarmLimit2', 12);
              vAlarmUnits2 := ReadInteger(cALARMSSECTION, 'AlarmUnits2', 5);
              vAlarmAttachedTo2 := ReadInteger(cALARMSSECTION, 'AlarmAttachedTo2', 4);
              vAlarmActive2 := ReadBool(cALARMSSECTION, 'AlarmActive2', False);
              vAlarmTimerActive2:= ReadBool(cALARMSSECTION, 'AlarmTimerActive2', True);
              vAlarmTimerValue2 := ReadInteger(cALARMSSECTION, 'AlarmTimerValue2', 60);
              vAlarmOnTop2:=ReadBool(cALARMSSECTION, 'AlarmOnTop2', False);
              vAlarmSound2:=ReadBool(cALARMSSECTION, 'AlarmSound2', True);
            end;
        end;
    except
      Beep;
      MessageDlg('Error raised while creating default ini file.' + #13 + #10 + 'function : uReadIniFile.ReadIniFileSectionSetVar.', mtError, [mbOK], 0);
    end;
  finally
    vDefaultIniFile.Free;
  end;
end;

{=====================================================================================================}
{= functie om 'bepaalde' sectie's op de form's te setten. ============================================}
{=====================================================================================================}
function ReadIniFileSectionSetObject(Section: string): Boolean;
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
          if Section = 'Layout' then
            begin
              {Adapter Groupbox}
              frmLayout.CbAdapterShowBox.Checked := ReadBool(cLAYOUTSECTION, 'AdapterBoxShow', True);
              frmLayout.CbAdapterShowCaption.Checked := ReadBool(cLAYOUTSECTION, 'AdapterBoxCaptionShow', True);
              {Units Groupbox}
              frmLayout.CbUnitsShowBox.Checked := ReadBool(cLAYOUTSECTION, 'UnitsBoxShow', True);
              frmLayout.CbUnitsShowCaption.Checked := ReadBool(cLAYOUTSECTION, 'UnitsBoxCaptionShow', True);
              {Standard Groupbox}
              frmLayout.CbStandardShowBox.Checked := ReadBool(cLAYOUTSECTION, 'StandardBoxShow', False);
              frmLayout.CbStandardShowCaption.Checked := ReadBool(cLAYOUTSECTION, 'StandardCaptionShow', False);
              {Decimals Groupbox}
              frmLayout.CbDecimalsShowBox.Checked := ReadBool(cLAYOUTSECTION, 'DecimalsBoxListShow', False);
              frmLayout.CbDecimalsShowCaption.Checked := ReadBool(cLAYOUTSECTION, 'DecimalsBoxCaptionShow', False);
            end;

          if Section = 'Colors' then
            begin
              {Session Current Received Color}
              frmColors.ClrbColorSessionCurrentReceived.Selected := StringToColor(ReadString(cCOLORSSECTION, 'SessionCurrentReceivedColor', 'clRed'));
              frmColors.CbColorSessionCurrentReceived.Checked := ReadBool(cCOLORSSECTION, 'SessionCurrentReceivedBold', False);
              {Session Average Received Color}
              frmColors.ClrbColorSessionAverageReceived.Selected := StringToColor(ReadString(cCOLORSSECTION, 'SessionAverageReceivedColor', 'clTeal'));
              frmColors.CbColorSessionAverageReceived.Checked := ReadBool(cCOLORSSECTION, 'SessionAverageReceivedBold', False);
              {Session Max Received Color}
              frmColors.ClrbColorSessionMaxReceived.Selected := StringToColor(ReadString(cCOLORSSECTION, 'SessionMaxReceivedColor', 'clRed'));
              frmColors.CbColorSessionMaxReceived.Checked := ReadBool(cCOLORSSECTION, 'SessionMaxReceivedBold', False);
              {Session Total Received Color}
              frmColors.ClrbColorSessionTotalReceived.Selected := StringToColor(ReadString(cCOLORSSECTION, 'SessionTotalReceivedColor', 'clGreen'));
              frmColors.CbColorSessionTotalReceived.Checked := ReadBool(cCOLORSSECTION, 'SessionTotalReceivedBold', False);
              {Windows Total Received Color}
              frmColors.ClrbColorWindowsTotalReceived.Selected := StringToColor(ReadString(cCOLORSSECTION, 'WindowsTotalReceivedColor', 'clNavy'));
              frmColors.CbColorWindowsTotalReceived.Checked := ReadBool(cCOLORSSECTION, 'WindowsTotalReceivedBold', True);
              {Session Current Sent Color}
              frmColors.ClrbColorSessionCurrentSent.Selected := StringToColor(ReadString(cCOLORSSECTION, 'SessionCurrentSentColor', 'clBlue'));
              frmColors.CbColorSessionCurrentSent.Checked := ReadBool(cCOLORSSECTION, 'SessionCurrentSentBold', False);
              {Session Average Sent Color}
              frmColors.ClrbColorSessionAverageSent.Selected := StringToColor(ReadString(cCOLORSSECTION, 'SessionAverageSentColor', 'clTeal'));
              frmColors.CbColorSessionAverageSent.Checked := ReadBool(cCOLORSSECTION, 'SessionAverageSentBold', False);
              {Session Max Sent Color}
              frmColors.ClrbColorSessionMaxSent.Selected := StringToColor(ReadString(cCOLORSSECTION, 'SessionMaxSentColor', 'clBlue'));
              frmColors.CbColorSessionMaxSent.Checked := ReadBool(cCOLORSSECTION, 'SessionMaxSentBold', False);
              {Session Total Sent Color}
              frmColors.ClrbColorSessionTotalSent.Selected := StringToColor(ReadString(cCOLORSSECTION, 'SessionTotalSentColor', 'clGreen'));
              frmColors.CbColorSessionTotalSent.Checked := ReadBool(cCOLORSSECTION, 'SessionTotalSentBold', False);
              {Windows Total Sent Color}
              frmColors.ClrbColorWindowsTotalSent.Selected := StringToColor(ReadString(cCOLORSSECTION, 'WindowsTotalSentColor', 'clNavy'));
              frmColors.CbColorWindowsTotalSent.Checked := ReadBool(cCOLORSSECTION, 'WindowsTotalSentBold', True);
            end;

          if Section = 'Program' then
            begin
              {Adapter Groupbox}
              frmProgram.CmbAdapterLijst.ItemIndex := ReadInteger(cPROGRAMSECTION, 'AdapterBoxIndex', 0);
              {Units Groupbox}
              frmProgram.RbBits.Checked := ReadBool(cPROGRAMSECTION, 'UnitsInBits', False);
              frmProgram.RbBytes.Checked := ReadBool(cPROGRAMSECTION, 'UnitsInBytes', True);
              {Standard Groupbox}
              frmProgram.RbStandardBinary.Checked := ReadBool(cPROGRAMSECTION, 'StandardInBinary', True);
              frmProgram.RbStandartDecimal.Checked := ReadBool(cPROGRAMSECTION, 'StandardInDecimal', False);
              {Decimals Groupbox}
              frmProgram.Rb1Decimaal.Checked := ReadBool(cPROGRAMSECTION, 'Decimals1Decimal', False);
              frmProgram.Rb2Decimaal.Checked := ReadBool(cPROGRAMSECTION, 'Decimals2Decimal', True);
              frmProgram.Rb3Decimaal.Checked := ReadBool(cPROGRAMSECTION, 'Decimals3Decimal', False);
              frmProgram.Rb4Decimaal.Checked := ReadBool(cPROGRAMSECTION, 'Decimals4Decimal', False);
              {Common Groupbox}
              frmProgram.CbShowhints.Checked := ReadBool(cPROGRAMSECTION, 'ShowHints', True);
              frmProgram.CbSaveonexit.Checked := ReadBool(cPROGRAMSECTION, 'SaveOnExit', False);
              frmProgram.CbMinimizeonrun.Checked := ReadBool(cPROGRAMSECTION, 'MinimizeOnRun', False);
              frmProgram.CbConfirmExit.Checked := ReadBool(cPROGRAMSECTION, 'ConfirmExit', False);
              frmProgram.cbStayOnTop.Checked := ReadBool(cPROGRAMSECTION, 'StayOnTop', False)
            end;

          if Section = 'Alarms' then
            begin
              {Alarm 1 settings.}
              frmAlarms.SpeAlarmLimit1.Value :=  ReadFloat(cALARMSSECTION, 'AlarmLimit1', 55);
              frmAlarms.CmbAlarmUnits1.ItemIndex := ReadInteger(cALARMSSECTION, 'AlarmUnits1', 5);
              frmAlarms.CmbAlarmAttachedTo1.ItemIndex := ReadInteger(cALARMSSECTION, 'AlarmAttachedTo1', 0);
              frmAlarms.CbAlarmActive1.Checked := ReadBool(cALARMSSECTION, 'AlarmActive1', False);
              frmAlarms.CbAlarmTimerActive1.Checked := ReadBool(cALARMSSECTION, 'AlarmTimerActive1', True);
              frmAlarms.SpeAlarmTimer1.Value := ReadInteger(cALARMSSECTION, 'AlarmTimerValue1', 60);
              frmAlarms.CbAlarmOnTop1.Checked :=ReadBool(cALARMSSECTION, 'AlarmOnTop1', False);
              frmAlarms.CbAlarmSound1.Checked:=ReadBool(cALARMSSECTION, 'AlarmSound1', True);
              {Alarm 2 settings.}
              frmAlarms.SpeAlarmLimit2.Value := ReadFloat(cALARMSSECTION, 'AlarmLimit2', 12);
              frmAlarms.CmbAlarmUnits2.ItemIndex := ReadInteger(cALARMSSECTION, 'AlarmUnits2', 5);
              frmAlarms.CmbAlarmAttachedTo2.ItemIndex := ReadInteger(cALARMSSECTION, 'AlarmAttachedTo2', 4);
              frmAlarms.CbAlarmActive2.Checked := ReadBool(cALARMSSECTION, 'AlarmActive2', False);
              frmAlarms.CbAlarmTimerActive2.Checked := ReadBool(cALARMSSECTION, 'AlarmTimerActive2', True);
              frmAlarms.SpeAlarmTimer2.Value := ReadInteger(cALARMSSECTION, 'AlarmTimerValue2', 60);
              frmAlarms.CbAlarmOnTop2.Checked :=ReadBool(cALARMSSECTION, 'AlarmOnTop2', False);
              frmAlarms.CbAlarmSound2.Checked:=ReadBool(cALARMSSECTION, 'AlarmSound2', True);
            end;
        end;
    except
      Beep;
      MessageDlg('Error raised while creating default ini file.' + #13 + #10 + 'function : uReadIniFile.ReadIniFileSectionSetObject.', mtError, [mbOK], 0);
    end;
  finally
    vDefaultIniFile.Free;
  end;
end;
end.

