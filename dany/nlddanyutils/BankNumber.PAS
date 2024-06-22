unit BankNumber;

// Dany Rosseel 13-10-2003

{ History of this unit
  24-07-2002 Initial Version
  13-10-2003 Renamed the unit to 'BankNumber' (was 'bank_nr')
             Renamed functions and variables.. to meet naming conventions
}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

// This function checks the validity of a bank number (including non numerical characters)
// and returns 'True' if Ok
function BankNumberOk(S: string): boolean;


// This function returns the numerical part of a banknumber (including non numerical characters)
// and returns it as a string (excluding non numerical characters)
function NumericalBankNumber(S: string): string;


implementation
uses RcsStrings, SysUtils, StrUtils;

function NumericalBankNumber(S: string): string;
var
  I, L: byte;
begin
  S := Trim(S);
  L := Length(S);
  for I := L downto 1 do
  begin
    if (S[I] < '0') or (S[I] > '9') then
      Delete(S, I, 1);
  end;
  Result := S;
end;

function BankNumberOk(S: string): boolean;
var
  S1, S2: string;
  Number: real;
  Check: byte;
  Error: integer;
begin

  S := NumericalBankNumber(S);

  if (Length(S) <> 12) then
  begin
    Result := False;
    Exit;
  end;

  S1 := LeftStr(S, Length(S) - 2) + '.0';
  S2 := RightStr(S, 2);

  Val(S1, Number, Error);
  if (Error <> 0) then
  begin
    Result := False;
    Exit;
  end;

  Val(S2, Check, Error);
  if (Error <> 0) then
  begin
    Result := False;
    Exit;
  end;

  if (Check = 0) then
    Check := 97
  else if (check = 97) then
    Check := 0;

  if ((Number - ((Int(Number / 97)) * 97)) = Check) then
    Result := True
  else
    Result := False;

end;

end.
