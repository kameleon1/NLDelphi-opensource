unit uCommon;

interface

uses Windows, SysUtils, Forms, Graphics, Classes, Dialogs, uMain, uMibIfRow, uDataArray,
  JvEdit, StdCtrls, Controls, ExtCtrls;

procedure Red;
procedure Green;
procedure RedGreen;
procedure Black;
procedure GetData;
procedure Initialize;
procedure CalculateData;
procedure SetData;
procedure LoadIconFromResource(const AResourceName: string; const ADest: TIcon);
function Convert2SpecString(ToonBits: Boolean; SubEenheid: Byte; Decimalen: Byte; Waarde: Longword): string;
procedure SecondsToTime(const AInput: Integer; var ASeconds, AMinutes, AHours, ADays, AYears: Integer);
function SecondsToString(const ASeconds: Integer): string;
procedure CountersReset;
procedure AllDisabled;
procedure AllEnabled;
procedure CheckAlarms(Sender: TObject);
function ConvertAlarmsInBytes(iLimit: Extended; iUnit: Byte): Extended;
function GetReferencedAlarmByteValue(var vAttachedToID: Integer): Longword;
function GetReferencedAlarmString(var vAttachedToID: Integer): string;

var
  vMIBIfArray: uMibIfRow.TMIBIfArray;
  vAttachedToID: Integer;
  vAttachedToString: string;

implementation

uses uReadIniFile, uAlarmDialog;

{Koppel / Link de IconResource file aan de 'Unit' (of hoe je dat ook mag noemen :))}

{$R Resource\IconResource.RES}

{=====================================================================================================}
{= Procedure om een icoon @ RunTime uit een Recource file te halen. ==================================}
{= Met speciale dank aan PsychoMark. (voor het maken van deze procedure) =============================}
{=====================================================================================================}
procedure LoadIconFromResource(const AResourceName: string; const ADest: TIcon);
var
  vIconTemp: TIcon;
  vResourceImage: TResourceStream;
begin
  {Creeër een tijdelijk icoon !}
  vIconTemp := TIcon.Create();
  vResourceImage := nil;
  try
    {Creeër DE resourcestream, gebaseerd op de Resource Naam.}
    vResourceImage := TResourceStream.Create(hInstance, AResourceName, RT_RCDATA);
    try
      {Laad de resourcestream in het tijdelijke Icoon.}
      vIconTemp.LoadFromStream(vResourceImage);

      {Draag het tijdelijk icoon over aan de Destination.}
      ADest.Assign(vIconTemp);
    finally
      {Geef de ResourceStream vrij en zet hem op NIL.}
      FreeAndNil(vResourceImage);
    end;
  finally
    {Geef het tijdelijke Icoon vrij en zet hem op NIL.}
    FreeAndNil(vIconTemp);
  end;
end;

{=====================================================================================================}
{= Procedure maakt het icoon van de applicatie Rood & Zwart (Alleen Receive actief) ==================}
{=====================================================================================================}
procedure Red;
begin
  LoadIconFromResource('RED', frmMain.Icon);
  LoadIconFromResource('RED', Application.Icon);

  {Als de applicatie in de tray draaid...}
  if frmMain.JvTray.Active then
    LoadIconFromResource('RED', frmMain.JvTray.Icon);
end;

{=====================================================================================================}
{= Procedure maakt het icoon van de applicatie Groen & Zwart (Alleen Sent actief) ====================}
{=====================================================================================================}
procedure Green;
begin
  LoadIconFromResource('GREEN', frmMain.Icon);
  LoadIconFromResource('GREEN', Application.Icon);

  {Als de applicatie in de tray draaid...}
  if frmMain.JvTray.Active then
    LoadIconFromResource('GREEN', frmMain.JvTray.Icon);
end;

{=====================================================================================================}
{= Procedure maakt het icoon van de applicatie Rood & Groen (Receive & Sent actief) ==================}
{=====================================================================================================}
procedure RedGreen;
begin
  LoadIconFromResource('REDGREEN', frmMain.Icon);
  LoadIconFromResource('REDGREEN', Application.Icon);

  {Als de applicatie in de tray draaid...}
  if frmMain.JvTray.Active then
    LoadIconFromResource('REDGREEN', frmMain.JvTray.Icon);
end;

{=====================================================================================================}
{= Procedure maakt het icoon van de applicatie Zwart & Zwart (Geen Communicatie) =====================}
{=====================================================================================================}
procedure Black;
begin
  LoadIconFromResource('BLACK', frmMain.Icon);
  LoadIconFromResource('BLACK', Application.Icon);

  {Als de applicatie in de tray draaid...}
  if frmMain.JvTray.Active then
    LoadIconFromResource('BLACK', frmMain.JvTray.Icon);
end;

{=====================================================================================================}
{= Procedure om data op te halen. (Gegevens omtrent de Up & Down Stream Speed) =======================}
{=====================================================================================================}
procedure GetData;
var
  vResultaat: Integer;
  vGrooteIfTabel: Integer;
  vAantalAdapters: Longint;
  vBuffer: PChar;
  vICounter: Integer;
begin
  {Initialisatie van de fGrooteIfTabel, fBuffer, fAantalAdapters, om een Hint / Warning te voorkomen !}
  vGrooteIfTabel := 0;
  vBuffer := nil;
  vAantalAdapters := 0;

  {Vul de fResultaat variable met het resultaat van het ophalen v/d IfTabel, en vul de buffer.}
  vResultaat := GetIfTable(PTMibIfTable(vBuffer), @vGrooteIfTabel, false);

  {Als fResultaat = 122 is dan exit de procedure (ERROR_INSUFFICIENT_BUFFER = 122)}
  if vResultaat <> ERROR_INSUFFICIENT_BUFFER then EXIT;

  {Creeër een dynamische variabele met pointer.}
  GetMem(vBuffer, vGrooteIfTabel);

  {Vul de fResultaat variable met het resultaat van het ophalen v/d IfTabel, en vul de buffer.}
  vResultaat := GetIfTable(PTMibIfTable(vBuffer), @vGrooteIfTabel, false);

  {Als fResultaat = 0 is dan verder met de procedure (NO_ERROR = 0)}
  if vResultaat = NO_ERROR then
    begin
      {Haal het aantal Adapters op.}
      vAantalAdapters := PTMibIfTable(vBuffer)^.dwNumEntries;

      if vAantalAdapters > 0 then
        begin
          {Set de groote van de Array.}
          SetLength(vMIBIfArray, vAantalAdapters);

          {Vergroot de buffer naar gelang het aantal gevonden adapters.}
          Inc(vBuffer, SizeOf(vAantalAdapters));

          for vICounter := 0 to pred(vAantalAdapters) do
            begin
              {Vul de array met data uit de buffer}
              vMIBIfArray[vICounter] := PTMibIfRow(vBuffer)^;

              {Vergroot de buffer met de groote van TMIBIfRow}
              Inc(vBuffer, SizeOf(TMIBIfRow));
            end;
        end;
    end;
  {Verklein de buffer.}
  Dec(vBuffer, SizeOf(DWORD) + vAantalAdapters * SizeOf(TMIBIfRow));

  {Leeg de dynamische variabele met pointer.}
  FreeMem(vBuffer);
end;

{=====================================================================================================}
{= Initializeer procedure, hierin worden de waarde's eenmalig voor het eerst geinitaliseert. =========}
{=====================================================================================================}
procedure Initialize;
var
  vICounter: Integer;
  vAdapterName: string;
begin
  {Set Flag dat initialisatie gedaan is.}
  vInitializeDone := True;

  {Leeg de Combo, dit omdat na het stop en starten er dubbele items in staan. !!!}
  frmMain.CmbAdapterLijst.Clear;

  if Length(vMIBIfArray) > 0 then
    begin
      {Set de lengte van de DataArray gelijk aan de lengte van de MIBIfArray.}
      SetLength(vDataArray, Length(vMIBIfArray));

      for vICounter := low(vMIBIfArray) to High(vMIBIfArray) do
        with vMIBIfArray[vICounter] do
          begin
            with vDataArray[vICounter] do
              begin
                fSessionCurrentReceived := 0;
                fSessionCurrentSent := 0;
                fSessionAverageReceived := 0;
                fSessionAverageSent := 0;
                fSessionMaxReceived := 0;
                fSessionMaxSent := 0;
                fSessionTotalReceived := 0;
                fSessionTotalSent := 0;
                fWindowsTotalReceived := dwInOctets;
                fWindowsTotalSent := dwOutOctets;
                fPreviousReceived := dwInOctets;
                fPreviousSent := dwOutOctets;
                fSessionActiveCountReceived := 0;
                fSessionActiveCountSent := 0;
              end;

            {Set de lengte van de te vullen string.}
            SetLength(vAdapterName, pred(dwDescrLen));

            {Haal de Adapter omschrijving op.}
            Move(bDescr, vAdapterName[1], pred(dwDescrLen));

            {Vul de Adapter Combolist met de aanwezige adapters.}
            frmMain.CmbAdapterLijst.AddItem(Trim(vAdapterName), nil);

            {Vul de Dynamische Array met de Adapternamen. (gebruikt voor menu: Settings => Program) }
            SetLength(vAdapterArray, vICounter + 1);
            vAdapterArray[vICounter] := vAdapterName;

            {Indien geen adapters aanwezig dan dit melden in combobox.}
            if frmMain.CmbAdapterLijst.Items.Count > 0 then frmMain.CmbAdapterLijst.ItemIndex := 0
            else frmMain.CmbAdapterLijst.AddItem('Geen Adapter', nil);

            {MICHIEN NOG EEN ERROR RAISEN EN/OF TIMER STOPPEN, MOET UITGEZOCHT WORDEN.}
          end;
    end;
  {Set TmrSequence op Actief, hierna volgt er per seconde een data ophaal actie.}
  frmMain.TmrSequence.Enabled := True;
end;

{=====================================================================================================}
{= Bereken / Muteer de data uit de Data Array ========================================================}
{=====================================================================================================}
procedure CalculateData;
var
  vICounter: Integer;
begin
  for vICounter := Low(vMIBIfArray) to High(vMIBIfArray) do
    with vMIBIfArray[vICounter] do
      begin
        with vDataArray[vICounter] do
          begin
            {Bereken Huidige Sessie Snelheid.}
            fSessionCurrentReceived := dwInOctets - fPreviousReceived;
            fSessionCurrentSent := dwOutOctets - fPreviousSent;

            {Bereken Gemiddelde Sessie Snelheid.}
            fSessionAverageReceived := (fSessionTotalReceived div vSessionActive);
            fSessionAverageSent := (fSessionTotalSent div vSessionActive);

            {Bereken Max. Sessie Snelheid indien de de Huidige Sessie Snelheid > 0}
            if fSessionCurrentReceived > fSessionMaxReceived then
              fSessionMaxReceived := fSessionCurrentReceived;
            if fSessionCurrentSent > fSessionMaxSent then
              fSessionMaxSent := fSessionCurrentSent;

            {Verhoog de totale Sessie Up & DownLoad.}
            Inc(fSessionTotalReceived, fSessionCurrentReceived);
            Inc(fSessionTotalSent, fSessionCurrentSent);

            {Verhoog de totale Windows Up & DownLoad.}
            Inc(fWindowsTotalReceived, fSessionCurrentReceived);
            Inc(fWindowsTotalSent, fSessionCurrentSent);

            {Helper: om de Huidige Sessie Snelheid te berekenen.}
            fPreviousReceived := dwInOctets;
            fPreviousSent := dwOutOctets;

            {Helper: mischien nodig om de Gemiddelde Sessie Snelheid te berekenen.}
            if fSessionCurrentReceived > 0 then Inc(fSessionActiveCountReceived);
            if fSessionCurrentSent > 0 then Inc(fSessionActiveCountSent);
          end;
      end;
end;

{=====================================================================================================}
{= Procedure om de data uit de DataArray op het scherm te tonen. =====================================}
{=====================================================================================================}
procedure SetData;
var
  vICounter: Integer;
  vDecimaal: Byte;
begin
  {Initialisatie van de fDecimaal, om een Hint / Warning te voorkomen !}
  vDecimaal := 1;

  vStandardInBinary := frmMain.RbStandardBinary.Checked;
  vStandardInDecimal := frmMain.RbStandartDecimal.Checked;

  if frmMain.Rb1Decimaal.Checked then vDecimaal := 1;
  if frmMain.Rb2Decimaal.Checked then vDecimaal := 2;
  if frmMain.Rb3Decimaal.Checked then vDecimaal := 3;
  if frmMain.Rb4Decimaal.Checked then vDecimaal := 4;

  {Loop de gehele tijdelijke Data Array af.}
  for vICounter := Low(vDataArray) to High(vDataArray) do
    with vDataArray[vICounter] do
      begin
        {Controleer welke Adapter in de Combo gekozen is, en toon DIE gegevens.}
        if vICounter = frmMain.CmbAdapterLijst.ItemIndex then
          begin
            {Set Application en Form Icoon in de juiste 'kleur'.}
            if (fSessionCurrentReceived = 0) and (fSessionCurrentSent = 0) then Black; {Geen Communicatie.}
            if (fSessionCurrentReceived > 0) and (fSessionCurrentSent = 0) then Red; {Alleen Receive.}
            if (fSessionCurrentReceived = 0) and (fSessionCurrentSent > 0) then Green; {Alleen Sent.}
            if (fSessionCurrentReceived > 0) and (fSessionCurrentSent > 0) then RedGreen; {Beide, Receive & Sent.}

            {Toon Huidige Sessie Snelheid in de Edit Box.}
            frmMain.EdtSessionCurrentReceived.Text := Convert2SpecString(frmMain.RbBits.Checked, 1, vDecimaal, fSessionCurrentReceived);
            frmMain.EdtSessionCurrentSent.Text := Convert2SpecString(frmMain.RbBits.Checked, 1, vDecimaal, fSessionCurrentSent);

            {Toon Gemiddelde Sessie Snelheid in de Edit Box.}
            if fSessionTotalReceived > 0 then
              frmMain.EdtSessionAverageReceived.Text := Convert2SpecString(frmMain.RbBits.Checked, 1, vDecimaal, fSessionAverageReceived)
            else frmMain.EdtSessionAverageReceived.Text := ' --- ';
            if fSessionTotalSent > 0 then
              frmMain.EdtSessionAverageSent.Text := Convert2SpecString(frmMain.RbBits.Checked, 1, vDecimaal, fSessionAverageSent)
            else frmMain.EdtSessionAverageSent.Text := ' --- ';

            {Toon Maximale Sessie Snelheid in de Edit Box.}
            frmMain.EdtSessionMaxReceived.Text := Convert2SpecString(frmMain.RbBits.Checked, 1, vDecimaal, fSessionMaxReceived);
            frmMain.EdtSessionMaxSent.Text := Convert2SpecString(frmMain.RbBits.Checked, 1, vDecimaal, fSessionMaxSent);

            {Toon Totale Sessie Up & Download in de Edit Box.}
            if fSessionActiveCountReceived > 0 then
              frmMain.EdtSessionTotalReceived.Text := Convert2SpecString(frmMain.RbBits.Checked, 0, vDecimaal, fSessionTotalReceived)
            else frmMain.EdtSessionTotalReceived.Text := ' --- ';
            if fSessionActiveCountSent > 0 then
              frmMain.EdtSessionTotalSent.Text := Convert2SpecString(frmMain.RbBits.Checked, 0, vDecimaal, fSessionTotalSent)
            else frmMain.EdtSessionTotalSent.Text := ' --- ';

            {Toon Totale Windows Up & Download in de Edit Box.}
            if fSessionActiveCountReceived > 0 then
              frmMain.EdtWindowsTotalReceived.Text := Convert2SpecString(frmMain.RbBits.Checked, 0, vDecimaal, fWindowsTotalReceived)
            else frmMain.EdtWindowsTotalReceived.Text := ' --- ';
            if fSessionActiveCountSent > 0 then
              frmMain.EdtWindowsTotalSent.Text := Convert2SpecString(frmMain.RbBits.Checked, 0, vDecimaal, fWindowsTotalSent)
            else frmMain.EdtWindowsTotalSent.Text := ' --- ';
          end;
      end;
end;

{=====================================================================================================}
{= Functie om octets naar een string te converteren. =================================================}
{=====================================================================================================}
{= Toonbits : (True/False) Geeft aan of het resultaat in Bits of in Byte's getoond moet worden. ======}
{= Eenheid  : ( 0/1/2/3  ) 0 = Geen eenheid, 1 = in Seconden, 2 = in Minuten, 3 = in Uren. ===========}
{= Decimalen: (0/1/2/3/4 ) 0 = Geen Decimaal, 1 = 1 Dec., 2 = 2 Dec., 3 = 3 Dec., 4 = 4 Dec. =========}
{= Waarde   :  Octet input waarde ====================================================================}
{=====================================================================================================}
function Convert2SpecString(ToonBits: Boolean; SubEenheid: Byte; Decimalen: Byte; Waarde: Longword): string;
const
  cGIGABYTESTRING = 'GBytes';
  cMEGABYTESTRING = 'MBytes';
  cKILOBYTESTRING = 'KBytes';
  cBYTESTRING = 'Bytes';

  cGIGABITSTRING = 'GBits';
  cMEGABITSTRING = 'MBits';
  cKILOBITSTRING = 'KBits';
  cBITSTRING = 'Bits';

  cBITMULTIPLIER = 8;
  cEENHEIDGEEN = '';
  cEENHEIDSECONDEN = '/s.';
  cEENHEIDMINUTEN = '/m.';
  cEENHEIDUREN = '/h.';

var
  vEenheid: string;
  vSubEenheid: string;
  vDecimalen: Byte;
  vWaarde: Int64;
  vValue: Extended;

  cKILOBYTE: Integer;
  cMEGABYTE: Longword;
  cGIGABYTE: Longword;

  cKILOBIT: Integer;
  cMEGABIT: Longword;
  cGIGABIT: Longword;

begin
  {Initialisatie van de cVariablen, Result, om een Hint / Warning te voorkomen !}
  cKILOBYTE := 0;
  cMEGABYTE := 0;
  cGIGABYTE := 0;
  cKILOBIT := 0;
  cMEGABIT := 0;
  cGIGABIT := 0;

 {Gebruik het Decimal Bits and Bytes Stelsel.}
 {source: http://www.romulus2.com/articles/guides/misc/bitsbytes.shtml}
  if vStandardInDecimal then
    begin
      cKILOBYTE := 1000;
      cMEGABYTE := 1000000;
      cGIGABYTE := 1000000000;

      cKILOBIT := 1000;
      cMEGABIT := 1000000;
      cGIGABIT := 1000000000;
    end;

  {Gebruik het Binary Bits and Bytes Stelsel.}
  {source: http://www.romulus2.com/articles/guides/misc/bitsbytes.shtml}
  if vStandardInBinary then
    begin
      cKILOBYTE := 1024;
      cMEGABYTE := 1048576;
      cGIGABYTE := 1073741824;

      cKILOBIT := 1024;
      cMEGABIT := 1048576;
      cGIGABIT := 1073741824;
    end;

  {Initialisatie van de vValue, om een Hint / Warning te voorkomen !}
  vValue := 0;

  {Aan de hand van de EENHEIDS keuze wordt de Eenheids String bepaald.}
  case SubEenheid of
    0: vSubEenheid := cEENHEIDGEEN;
    1: vSubEenheid := cEENHEIDSECONDEN;
    2: vSubEenheid := cEENHEIDMINUTEN;
    3: vSubEenheid := cEENHEIDUREN;
    else
      vSubEenheid := cEENHEIDGEEN;
  end;

  {Bepaald het aantal getallen achter de Comma, oftewijl het aantal Decimalen.}
  vDecimalen := Decimalen;

  case ToonBits of
    {Indien er kozen wordt om de weergave in Byte's te tonen.}
    False:
      begin
        vWaarde := Int64(Waarde);

        {Eenheid in Byte's.}
        if (vWaarde >= 0) and (vWaarde < cKILOBYTE) then
          begin
            vValue := vWaarde;
            vEenheid := cBYTESTRING;
          end;
        {Eenheid in KiloByte's.}
        if (vWaarde >= cKILOBYTE) and (vWaarde < cMEGABYTE) then
          begin
            vValue := vWaarde / cKILOBYTE;
            vEenheid := cKILOBYTESTRING;
          end;
        {Eenheid in MegaByte's.}
        if (vWaarde >= cMEGABYTE) and (vWaarde < cGIGABYTE) then
          begin
            vValue := vWaarde / cMEGABYTE;
            vEenheid := cMEGABYTESTRING;
          end;
        {Eenheid in GigaByte's.}
        if (vWaarde >= cGIGABYTE) and (vWaarde < High(Int64)) then
          begin
            vValue := vWaarde / cGIGABYTE;
            vEenheid := cGIGABYTESTRING;
          end;
      end;

    {Indien er kozen wordt om de weergave in Bits te tonen.}
    True:
      begin
        {Waarde vermenigvuldigen met de BitMulitplier, in dit geval is dat 8.}
        vWaarde := Int64(Waarde) * cBITMULTIPLIER;

        {Eenheid in Bits.}
        if (vWaarde >= 0) and (vWaarde < cKILOBIT) then
          begin
            vValue := vWaarde;
            vEenheid := cBITSTRING;
          end;
        {Eenheid in KiloBits.}
        if (vWaarde >= cKILOBIT) and (vWaarde < cMEGABIT) then
          begin
            vValue := vWaarde / cKILOBIT;
            vEenheid := cKILOBITSTRING;
          end;
        {Eenheid in MegaBits.}
        if (vWaarde >= cMEGABIT) and (vWaarde < cGIGABIT) then
          begin
            vValue := vWaarde / cMEGABIT;
            vEenheid := cMEGABITSTRING;
          end;
        {Eenheid in GigaBits.}
        if (vWaarde >= cGIGABIT) and (vWaarde < High(Int64)) then
          begin
            vValue := vWaarde / cGIGABIT;
            vEenheid := cGIGABITSTRING;
          end;
      end;
  end;
  Result := FloatToStrF(vValue, ffFixed, 9, vDecimalen) + ' ' + vEenheid + vSubEenheid;
end;

{=====================================================================================================}
{= Procedure om een integer om te zetten in jaren,dagen,uren,minuten,seconden. =======================}
{= Met speciale dank aan PsychoMark & de NLD Tiphoek (voor het maken van deze procedure) =============}
{=====================================================================================================}
procedure SecondsToTime(const AInput: Integer; var ASeconds, AMinutes, AHours, ADays, AYears: Integer);
  {Nested function, kijkt hoeveel seconden er in een bepaalde grootheid zitten.}
  function SubtractSeconds(var ASeconds: Integer; ASize: Integer): Integer;
  begin
    Result := ASeconds div ASize;
    Dec(ASeconds, Result * ASize);
  end;

var
  iSeconds: Integer;
begin
  iSeconds := AInput;
  AYears := SubtractSeconds(iSeconds, cSECSPERDAY * 365);
  ADays := SubtractSeconds(iSeconds, cSECSPERDAY);
  AHours := SubtractSeconds(iSeconds, cSECSPERHOUR);
  AMinutes := SubtractSeconds(iSeconds, cSECSPERMIN);
  ASeconds := iSeconds;
end;

{=====================================================================================================}
{= Procedure om een integer om te zetten in een speciale DateTime String. ============================}
{= Met speciale dank aan PsychoMark & de NLD Tiphoek (voor het maken van deze procedure) =============}
{=====================================================================================================}
function SecondsToString(const ASeconds: Integer): string;
var
  iYears: Integer;
  iDays: Integer;
  iHours: Integer;
  iMinutes: Integer;
  iSeconds: Integer;
begin
  Result := '';
  SecondsToTime(ASeconds, iSeconds, iMinutes, iHours, iDays, iYears);

  if iYears > 0 then
    Result := Format('%d %s, %d %s, %.2d:%.2d:%.2d ', [iYears, cYEARS, iDays, CDAYS, iHours, iMinutes, iSeconds])
  else
    if iDays > 0 then
      Result := Format('%d %s, %.2d:%.2d:%.2d ', [iDays, CDAYS, iHours, iMinutes, iSeconds])
    else
      Result := Format('%.2d:%.2d:%.2d ', [iHours, iMinutes, iSeconds]);
end;

{=====================================================================================================}
{= Reset alle tellers op de Windows TOTAL na. ========================================================}
{=====================================================================================================}
procedure CountersReset;
begin
  uMain.vSessionActive := 0;
  uCommon.Initialize;
end;

{=====================================================================================================}
{= Disabled alle Stats velden, dit omdat dust stopgezet wordt door gebruiker. ========================}
{=====================================================================================================}
procedure AllDisabled;
var
 {Globale Counter}
  vICounter: Byte;
begin
  {Loop door alle componenten op het form heen.}
  for vICounter := 0 to (frmMain.ComponentCount - 1) do
    begin

      {indien het gevonden component een TColorbox is...}
      if frmMain.Components[vICounter] is TJvEdit then
        begin
         {Wijzig de Color, FontColor, Text property van de betreffende TJvEdit.}
          TJvEdit(frmMain.Components[vICounter]).Color := clBtnFace;
          TJvEdit(frmMain.Components[vICounter]).Font.Color := clInactiveCaption;
          TJvEdit(frmMain.Components[vICounter]).Text := '--';
        end;

      {indien het gevonden component een TLabel is...}
      if frmMain.Components[vICounter] is TLabel then
        begin
          {Wijzig de Enabled property van de betreffende TLabel.}
          TLabel(frmMain.Components[vICounter]).Enabled := False;
        end;
    end;
  frmMain.GbReceived.Font.Color := clInactiveCaption;
  frmMain.GbSent.Font.Color := clInactiveCaption;
end;

{=====================================================================================================}
{= Enabled alle Stats velden, dit omdat dust gestart wordt door gebruiker. ===========================}
{=====================================================================================================}
procedure AllEnabled;
var
 {Globale Counter}
  vICounter: Byte;
begin
  {Loop door alle componenten op het form heen.}
  for vICounter := 0 to (frmMain.ComponentCount - 1) do
    begin
      {indien het gevonden component een TJvEdit is...}
      if frmMain.Components[vICounter] is TJvEdit then
        begin
          {Wijzig de Color, FontColor, Text property van de betreffende TJvEdit.}
          TJvEdit(frmMain.Components[vICounter]).Color := clWindow;
          TJvEdit(frmMain.Components[vICounter]).Font.Color := clWindowText;
          TJvEdit(frmMain.Components[vICounter]).Text := '';
        end;

      {indien het gevonden component een TLabel is...}
      if frmMain.Components[vICounter] is TLabel then
        begin
          {Wijzig de Enabled property van de betreffende TLabel.}
          TLabel(frmMain.Components[vICounter]).Enabled := True;
        end;
    end;
  frmMain.GbReceived.Font.Color := clWindowText;
  frmMain.GbSent.Font.Color := clWindowText;
  frmMain.SetColorsApplication;
end;

{=====================================================================================================}
{= Functie om de huidige waarde van een gerefereerd veld op te halen. ================================}
{=====================================================================================================}
function GetReferencedAlarmByteValue(var vAttachedToID: Integer): Longword;
var
  vICounter: Integer;
begin
  Result := 0;
 {Loop de gehele tijdelijke Data Array af.}
  for vICounter := Low(vDataArray) to High(vDataArray) do
    begin
      with vDataArray[vICounter] do
        begin
         {Controleer welke Adapter in de Combo gekozen is, en gebruik DIE gegevens.}
          if vICounter = frmMain.CmbAdapterLijst.ItemIndex then
            begin
              case vAttachedToID of
                0: Result := fSessionCurrentReceived;
                1: Result := fSessionAverageReceived;
                2: Result := fSessionTotalReceived;
                3: Result := fWindowsTotalReceived;
                4: Result := fSessionCurrentSent;
                5: Result := fSessionAverageSent;
                6: Result := fSessionTotalSent;
                7: Result := fWindowsTotalSent;
                else
                  begin
                    MessageDlg('Error on reading GetReferencedAlarmByteValue : AttachedID ', mtError, [mbOK], 0);
                    Result := fSessionCurrentReceived;
                  end;
              end;
            end;
        end;
    end;
end;

{=====================================================================================================}
{= Functie om een Alarm String op te halen van een gerefereerd veld op te halen. =====================}
{=====================================================================================================}
function GetReferencedAlarmString(var vAttachedToID: Integer): string;
var
  vICounter: Integer;
begin
 {Loop de gehele tijdelijke Data Array af.}
  for vICounter := Low(vDataArray) to High(vDataArray) do
    begin
      with vDataArray[vICounter] do
        begin
         {Controleer welke Adapter in de Combo gekozen is, en gebruik DIE gegevens.}
          if vICounter = frmMain.CmbAdapterLijst.ItemIndex then
            begin
              case vAttachedToID of
                0: Result := 'Session Current - Received';
                1: Result := 'Session Average - Received';
                2: Result := 'Session Total - Received';
                3: Result := 'Windows Total - Received';
                4: Result := 'Session Current - Sent';
                5: Result := 'Session Average - Sent';
                6: Result := 'Session Total - Sent';
                7: Result := 'Windows Total - Sent';
                else
                  begin
                    MessageDlg('Error on reading GetReferencedAlarmString : AttachedID ', mtError, [mbOK], 0);
                    Result := 'Session Current - Received';
                  end;
              end;
            end;
        end;
    end;
end;

{=====================================================================================================}
{= Procedure om te controleren of er een Alarm geraised moet / mag worden. ===========================}
{=====================================================================================================}
procedure CheckAlarms(sender: TObject);
var
  vICounter: Integer;
  vTmpAlarmLimit: Longword;
  vTmpMeasurment: Longword;
  AlarmActiveArray: array[0..1] of Boolean;
  AlarmTimerArray: array[0..1] of TTimer;
  AlarmTimerDoneArray: array[0..1] of Boolean;
  AlarmTimerActiveArray: array[0..1] of Boolean;
  AlarmTimerValueArray: array[0..1] of Integer;
  AlarmLimitArray: array[0..1] of Single;
  AlarmUnitsArray: array[0..1] of Integer;
  DontShowAlarmAgainArray: array[0..1] of Boolean;
  AlarmAttachedToArray: array[0..1] of Integer;
  AlarmShowOnTopArray: array[0..1] of Boolean;
  AlarmSoundArray: array[0..1] of Boolean;
begin
  AlarmLimitArray[0] := vAlarmLimit1;
  AlarmLimitArray[1] := vAlarmLimit2;
  AlarmUnitsArray[0] := vAlarmUnits1;
  AlarmUnitsArray[1] := vAlarmUnits2;
  AlarmAttachedToArray[0] := vAlarmAttachedTo1;
  AlarmAttachedToArray[1] := vAlarmAttachedTo2;

  AlarmActiveArray[0] := vAlarmActive1;
  AlarmActiveArray[1] := vAlarmActive2;
  AlarmTimerActiveArray[0] := vAlarmTimerActive1;
  AlarmTimerActiveArray[1] := vAlarmTimerActive2;
  AlarmTimerValueArray[0] := vAlarmTimerValue1;
  AlarmTimerValueArray[1] := vAlarmTimerValue2;

  AlarmShowOnTopArray[0] := vAlarmOnTop1;
  AlarmShowOnTopArray[1] := vAlarmOnTop2;
  AlarmSoundArray[0] := vAlarmSound1;
  AlarmSoundArray[1] := vAlarmSound2;

  AlarmTimerArray[0] := frmMain.TmrAlarm1;
  AlarmTimerArray[1] := frmMain.TmrAlarm2;
  AlarmTimerDoneArray[0] := vAlarmTimerDone1;
  AlarmTimerDoneArray[1] := vAlarmTimerDone2;
  DontShowAlarmAgainArray[0] := vDontShowAlarm1Again;
  DontShowAlarmAgainArray[1] := vDontShowAlarm2Again;

  for vICounter := 0 to 1 do
    begin
      if AlarmActiveArray[vICounter] then
        begin
          if not DontShowAlarmAgainArray[vICounter] then
            begin
              if AlarmTimerDoneArray[vICounter] then
                begin
                  {Converteer de ingestelde alarm grens in byte's}
                  vTmpAlarmLimit := Trunc(ConvertAlarmsInBytes(AlarmLimitArray[vICounter], AlarmUnitsArray[vICounter]));

                  {Haal de referenced waarde op, bv Session-Current Received in Bytes.}
                  vTmpMeasurment := GetReferencedAlarmByteValue(AlarmAttachedToArray[vICounter]);

                  {als ingestelde alarm grens groter is als de gemeten waarde dan...}
                  if (vTmpAlarmLimit > 0) and (vTmpMeasurment > vTmpAlarmLimit) then
                    begin
                      {als er nog geen alarm geraised is en er GEEN enkel ander Form openstaat dan...}
                      if (not vAlarmRaised) and (not vFormOpen) then
                        begin
                        {--}
                          try
                            try
                              vAlarmRaised := True;

                              {Creeër dynamisch het Alarms Form.}
                              frmAlarmDialog := TfrmAlarmDialog.Create(nil);

                              {Set Alarm Dialog op Foreground.}
                              if AlarmShowOnTopArray[vICounter] then SetForegroundWindow(frmAlarmDialog.Handle);

                              {Produceer geluid.}
                              if AlarmSoundArray[vICounter] then Beep;

                              {Haal Alarm String op.}
                              vAlarmString := GetReferencedAlarmString(AlarmAttachedToArray[vICounter]);

                              {Set AlarmID}
                              vAlarmID := vICounter + 1;

                              {Show AlarmDialog.}
                              frmAlarmDialog.ShowModal;
                            except
                              Beep;
                              MessageDlg('Error raised while creating Alarms Dialog.' + #13 + #10 + 'Procedure : uCommon.CheckAlarms.', mtError, [mbOK], 0);
                            end;
                          finally

                            {Set Alarm X Timers interval, indien deze optie is gekozen.}
                            if AlarmTimerActiveArray[vICounter] then
                              begin
                                {Set Timer interval.}
                                AlarmTimerArray[vICounter].Interval := AlarmTimerValueArray[vICounter] * 1000;
                                AlarmTimerDoneArray[vICounter] := False;
                                if vICounter = 0 then vAlarmTimerDone1 := False;
                                if vICounter = 1 then vAlarmTimerDone2 := False;
                                AlarmTimerArray[vICounter].Enabled := True;
                              end;
                            {Geef Alarms Form weer vrij.}
                            frmAlarmDialog.Free;
                            vAlarmRaised := False;
                          end;
                         {--}
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

{=====================================================================================================}
{= Functie converteerd de ingestelde alarm grens in absolute byte waarde. ============================}
{=====================================================================================================}
function ConvertAlarmsInBytes(iLimit: Extended; iUnit: Byte): Extended;
var
  vStandard: Integer;
  vResultString: string;
begin
  Result := 0;
  vStandard := 1024;

  if vStandardInBinary then vStandard := 1024;
  if vStandardInDecimal then vStandard := 1000;

  case iUnit of
    0: {bits}
      begin
        Result := iLimit / 8;
        vResultString := 'bits';
      end;
    1: {kilobits}
      begin
        Result := ((iLimit * vStandard) / 8);
        vResultString := 'Kilobits';
      end;
    2: {megabits}
      begin
        Result := ((iLimit * (vStandard * vStandard)) / 8);
        vResultString := 'Megabits';
      end;
    3: {gigabits}
      begin
        Result := ((iLimit * (vStandard * vStandard * vStandard)) / 8);
        vResultString := 'Gigabits';
      end;
    4: {bytes}
      begin
        Result := (iLimit);
        vResultString := 'bytes';
      end;
    5: {kilobytes}
      begin
        Result := (iLimit * vStandard);
        vResultString := 'Kilobytes';
      end;
    6: {megabytes}
      begin
        Result := (iLimit * (vStandard * vStandard));
        vResultString := 'Megabytes';
      end;
    7: {gigabytes}
      begin
        Result := (iLimit * (vStandard * vStandard * vStandard));
        vResultString := 'Gigabytes';
      end;
  end;
  //frmMain.StatusbarMain.Panels[0].Text := FloatToStr(iLimit) + ' ' + vResultString + ' = ' + (FloatToStrF(Result, ffFixed, 10, 1)) + ' bytes';
end;

end.

