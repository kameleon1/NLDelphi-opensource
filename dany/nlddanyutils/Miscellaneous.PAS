unit Miscellaneous;

// Dany Rosseel

{ History of this unit:
  08-01-2005: * Initial version.
}

interface

(* ComboBox routines *)
procedure UpdateComBoBox(Sender: TObject);
// Adds the text in the textbox to the drop down list

(* Statistical routines *)
function MovingAverage(const Data: array of real;
                        Index, Left, Right: Integer): real;

implementation

uses StdCtrls, SysUtils;

(* ComboBox routines *)
procedure UpdateComBoBox(Sender: TObject);
begin
  with Sender as TComboBox do
  begin
    if (trim(Text) > '') and (Items.Indexof(trim(Text)) < 0)
    then Items.Insert(0, trim(Text));
  end;
end;

(* Statistical routines *)
function MovingAverage(const Data: array of real;
                        Index, Left, Right: Integer): real;
var Sum: real;
    Count, I : Integer;
begin
  If Index < 0 then Index := 0;
  if Index > High(Data) then Index := High(Data);

  Left := Index - Left;
  Right := Index + Right;

  if Left < 0 then Left := 0;
  if Right > High(Data) then Right := High(Data);

  Sum := 0.0;
  Count := 0;

  for I := Left to Right do
  begin
    Sum := Sum + Data[I];
    Inc(Count);
  end;

  if Count > 0 then
  begin
    Result := Sum / Count;
  end else Result := Data[Index];
end;

end.
