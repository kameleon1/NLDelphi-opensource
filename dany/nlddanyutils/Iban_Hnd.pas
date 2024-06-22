unit Iban_Hnd;

{$DEFINE NoDebug}// Disable debug possibilities and range checking (= faster)
// {.$Define NoDebug}: During debugging
// {$Define NoDebug} : During "normal" use

{ History of this unit:
6-7-2008: * Initial version
1-5-2009: * Adapted to make conversion between banknumbers and IBAN nrs possible
}

{$P+}                                             // Open Strings ON
{$H+}                                             // Long Strings ON

{$IFDEF NoDebug}

{$O+}                                             // Optimisation ON
{$D-}                                             // Debug information OFF
{$I-}                                             // I/O checking OFF
{$L-}                                             // Local Symbols OFF
{$Q-}                                             // Overflow Checking OFF
{$R-}                                             // Range Checking OFF

{$ELSE}
{$O-}                                             // Optimisation OFF
{$D+}                                             // Debug information ON
{$I+}                                             // I/O checking ON
{$L+}                                             // Local Symbols ON
{$Q+}                                             // Overflow Checking ON
{$R+}                                             // Range Checking ON

{$ENDIF}

{$W-}                                             // Stack Frames OFF
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

function IBANControleCode(IbanNr: string): string;
function IBANWithControleCode(IbanNr: string): string;
function BbanToIban(CountryCode, Bban: string): string;
function IbanToBban(Iban: string): string;
function PaperIban(Iban: string): string;
function CodesToBban(BankId, SortCode, AccountNr: string): string;

function Mod97ControleCode(RekNo: Int64): byte; overload;
function Mod97ControleCode(RekNo: string): byte; overload;
function Mod97ControleCodetoString(RekNo: Int64): string; overload;
function Mod97ControleCodetoString(RekNo: string): string; overload;

function LargeNumberModulo(Number: string; Divisor: word): word;
function NLBankElfProefCheck(Number: Cardinal): boolean;
function WeightedSum(Number: string): Cardinal; overload;
function WeightedSum(Number: Cardinal): Cardinal; overload;

implementation

uses SysUtils;

// ----------------------------- General routines ------------------------------


// The "simple" code below does not work because the numbers are much too large
// to handle as e.g. Cardinals:
  (*
  Nr := StrToInt(Number);
  Nr := Nr mod Divisor;
  *)
// So, the number is splitted up in parts of which the reminder is calculated
// "Number" is assumed positive

function LargeNumberModulo(Number: string; Divisor: word): word;
var TmpS: string;
  P, L: byte;
  Reminder: word;
begin
  // P = position in "Number"
  // L = lenght of part of the number to be calculated
  // TmpS := temporary value for which the reminder should be calculated
  // Reminder = the reminder of each calculation

  P := 1;
  L := 6;       // number of 6 digits (makes 8 in total together with the inherited reminder)
                // can easily be handled by integer calculation
  TmpS := '';                                     // start with an empty "Reminder" part
  Reminder := 0;

  while P <= Length(Number) do
  begin
    // get part of the number, concatenate it to the reminder of the previous calculation
    TmpS := TmpS + Copy(Number, P, L);

    // Calculate reminder
    Reminder := StrToInt(TmpS) mod Divisor;

    // Add reminder to the number of which the reminder should be calculated next
    TmpS := IntToStr(Reminder);

    // point to next part of the large number
    P := P + L;

  end;

  Result := Reminder;
end;

function WeightedSum(Number: string): Cardinal; overload; // needed for the so-called "NL 11 proef"
var I: byte;
  // Result is (N1 * 9) + (N2 * 8) + (N3 * 7) ...
begin
  Result := 0;
  for I := 1 to Length(Number) do Result := Result + ((Length(Number) - I + 1) * (Ord(Number[I]) - Ord('0')));
end;

function WeightedSum(Number: Cardinal): Cardinal; overload; // needed for the so-called "NL 11 proef"
begin
  Result := WeightedSum(IntToStr(Number));
end;

function NLBankElfProefCheck(Number: Cardinal): boolean; // NL 11 proef check
begin
  Result := WeightedSum(Number) mod 11 = 0;
end;

// ----------------------------- IBAN related routines -------------------------

(*
Het IBAN controlegetal wordt verkregen door

   1. de rekeningidentificatie te nemen
   2. er de landcode achter te plaatsen
   3. alle letters te vervangen door hun positie in het romeinse alfabet, vermeerderd met 9 (A=10, B=11...Z=35)
   4. twee nullen toe te voegen aan het einde
   5. dan de rest te nemen van de deling van het zo bekomen getal door 97.
   6. deze rest van 98 af te trekken om het controlegetal te krijgen

Voorbeeld: Voor een imaginair Nederlands postbanknummer 1234567 is de IBAN-code NLxx PSTB 0001 2345 67 (zie hieronder).
           Het controlegetal wordt als volgt berekend:

   1. PSTB0001234567
   2. PSTB0001234567NL
   3. 2528291100012345672321
   4. 252829110001234567232100
   5. 252829110001234567232100 / 97 = ... , rest 29
   6. 98 - 29 = 69

Het IBAN zal dus NL69PSTB0001234567 zijn.
*)

// The function below assumes there is place for the controlecode, but content is undefined
// so, the format of IBanNr is e.g. "NLxx PSTB 0001 2345 67", where xx is to be calculated

function IBANControleCode(IbanNr: string): string;
var TmpS: string;
  I, J: byte;
  Reminder: Integer;
begin
  IbanNr := Uppercase(IbanNr);

  // remove spaces and other abnormal characters
  for I := Length(IbanNr) downto 1 do if not (IBanNr[I] in ['0'..'9', 'A'..'Z'])
    then Delete(IbanNr, I, 1);

  // make the controlcode '00'
  IbanNr[3] := '0';
  IbanNr[4] := '0';

  // move the 4 first characters to the end of the string
  TmpS := Copy(IbanNr, 1, 4);
  Delete(IbanNr, 1, 4);
  IbanNr := IbanNr + TmpS;

  // replace all non digit chars in the string by 2 digits : 'A' = '10', 'B'= '11', etc...
  for I := Length(IbanNr) downto 1 do
  begin
    if not (IBanNr[I] in ['0'..'9']) then
    begin
      J := Ord(IbanNr[I]) - Ord('A') + 10;
      TmpS := IntToStr(J);
      Delete(IbanNr, I, 1);
      Insert(TmpS, IbanNr, I);
    end;
  end;

  Reminder := LargeNumberModulo(IbanNr, 97);

  // End calculations
  Result := IntToStr(98 - Reminder);
  if Length(Result) < 2 then Result := '0' + Result;
end;


// the function below assumes there is place for the controlecode, but content is undefined
// so, the format of IBanNr is e.g. "NLxx PSTB 0001 2345 67",
// where xx is to be replaced by the calculated value

function IBANWithControleCode(IbanNr: string): string;
var TmpS: string;
begin
  TmpS := IbanControleCode(IbanNr);
  IbanNr[3] := TmpS[1];
  IbanNr[4] := TmpS[2];
  Result := IbanNr;
end;

function BbanToIban(CountryCode, Bban: string): string;
var TmpS: string;
begin
  TmpS := CountryCode + '00' + Bban;
  Result := IBANWithControleCode(TmpS);
  Result := PaperIban(Result);
end;

function IbanToBban(Iban: string): string;
var P: byte;
begin
  for P := Length(Iban) downto 1 do
  begin
    if not (IBan[P] in ['0'..'9', 'A'..'Z']) then Delete(Iban, P, 1);
  end;
  Result := Iban;
  Delete(Result, 1, 4); // delete first 4 characters
  Insert('-', Result, 4);
  Insert('-', Result, 12);
end;

function PaperIban(Iban: string): string;
var P: byte;
begin
  // remove spaces if there are already there
  for P := Length(Iban) downto 1 do
  begin
    if not (IBan[P] in ['0'..'9', 'A'..'Z']) then Delete(Iban, P, 1);
  end;

  // Insert spaces after every 4 characters
  P := 5;
  while P < Length(Iban) do
  begin
    Insert(' ', Iban, P);
    Inc(P, 5);
  end;
  Result := Iban;
end;

function CodesToBban(BankId, SortCode, AccountNr: string): string;
begin
  Result := BankId + SortCode + AccountNr;
end;


// ------------------------------- Modulo 97 routines related ------------------

function Mod97ControleCode(RekNo: Int64): byte; overload;
begin
  Result := RekNo mod 97;
  if Result = 0 then Result := 97;
end;

function Mod97ControleCode(RekNo: string): byte; overload;
var I: byte;
  RN: Int64;
begin
  for I := Length(RekNo) downto 1 do
    if not (RekNo[I] in ['0'..'9']) then delete(RekNo, I, 1);
  RN := StrToInt64(Copy(RekNo, 1, 10));
  Result := Mod97ControleCode(RN);
end;

function Mod97ControleCodetoString(RekNo: Int64): string; overload;
begin
  Result := IntToStr(Mod97ControleCode(RekNo));
  if Length(Result) < 2 then Result := '0' + Result;
end;

function Mod97ControleCodetoString(RekNo: string): string; overload;
begin
  Result := IntToStr(Mod97ControleCode(RekNo));
  if Length(Result) < 2 then Result := '0' + Result;
end;


end.
