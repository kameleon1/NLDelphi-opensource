unit Euro_bef;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses StdCtrls, SysUtils;

const
  koers_euro = 40.3399; { 1 euro is 40,3399 bef }
function euro_to_bef(eur: real48): real48;
function bef_to_euro(bef: real48): real48;

function bef_to_string(bef: real48; t, a: byte): shortstring;
function bef_to_string_trimmed(bef: real48): shortstring;
function euro_to_string(eur: real48; t, a: byte): shortstring;
function euro_to_string_trimmed(eur: real48): shortstring;
function bef_to_eur_to_string(bef: real48; t, a: byte): shortstring;
function eur_to_bef_to_string(eur: real48; t, a: byte): shortstring;
function string_to_bedrag(s: shortstring): real48;

type
  BefEuroEdit = object
    bedrag_bef: real48;
    procedure init(var bf, eu: TEdit);
    procedure show;
    procedure update(var changed: boolean);
      { to be used on 'exit' of the datafield }
    procedure check_key_and_update(var key: char; var changed: boolean);
      { checks for 'enter' and 'escape' }
  private
    bef_edit, eur_edit: ^TEdit;
    bef_string, eur_string: string;
    function bef_is_changed: boolean;
    function eur_is_changed: boolean;
  end;

implementation

uses RcsStrings;

function euro_to_bef(eur: real48): real48;
var
  res: real48;
begin
  res := eur * koers_euro;
  Result := res;
end;

function bef_to_euro(bef: real48): real48;
var
  res: real48;
begin
  res := bef / koers_euro;
  Result := res;
end;

function bef_to_string(bef: real48; t, a: byte): shortstring;
var
  s: shortstring;
  i: byte;
begin
  str(bef: t: a, s);
  for i := 1 to length(s) do
    if s[i] = '.' then
      s[i] := ',';
  Result := s;
end;

function bef_to_string_trimmed(bef: real48): shortstring;
var
  s: shortstring;
begin
  s := bef_to_string(bef, 20, 0); { no fraction }
  Result := trim(s);
end;

function euro_to_string(eur: real48; t, a: byte): shortstring;
var
  s: shortstring;
  i: byte;
begin
  str(eur: t: a, s);
  for i := 1 to length(s) do
    if s[i] = '.' then
      s[i] := ',';
  Result := s;
end;

function euro_to_string_trimmed(eur: real48): shortstring;
var
  s: shortstring;
begin
  s := euro_to_string(eur, 20, 2); { 2 digits fraction }
  Result := trim(s);
end;

function bef_to_eur_to_string(bef: real48; t, a: byte): shortstring;
var
  eur: real48;
  s: shortstring;
begin
  eur := bef_to_euro(bef);
  s := euro_to_string(eur, t, a);
  Result := s;
end;

function eur_to_bef_to_string(eur: real48; t, a: byte): shortstring;
var
  bef: real48;
  s: shortstring;
begin
  bef := euro_to_bef(eur);
  s := bef_to_string(bef, t, a);
  Result := s;
end;
{------------------------------------------------------------}

procedure BefEuroEdit.init(var bf, eu: TEdit);
begin
  bedrag_bef := 0.0;
  bef_edit := @bf;
  eur_edit := @eu;
  bef_string := trim(bef_edit^.text);
  eur_string := trim(eur_edit^.text);
end;

procedure replace_comma_by_point(var s: shortstring);
var
  i: byte;
begin
  for i := 1 to length(s) do
    if s[i] = ',' then
      s[i] := '.';
end;

function string_to_bedrag(s: shortstring): real48;
var
  tmp: real48;
  code: integer;
begin
  replace_comma_by_point(s);
  val(s, tmp, code);
  if (code = 0)
    then
    Result := tmp
  else
    Result := 0;
end;

procedure BefEuroEdit.show;
begin
  bef_string := bef_to_string_trimmed(bedrag_bef);
  eur_string := euro_to_string_trimmed(bef_to_euro(bedrag_bef));

  bef_edit^.text := bef_string;
  eur_edit^.text := eur_string;
end;

function BefEuroEdit.bef_is_changed: boolean;
begin
  Result := trim(bef_edit^.text) <> trim(bef_string);
end;

function BefEuroEdit.eur_is_changed: boolean;
begin
  Result := trim(eur_edit^.text) <> trim(eur_string);
end;

procedure BefEuroEdit.update(var changed: boolean);
var
  eur, tmp: real48;
  code: integer;
  s: shortstring;
begin
  Changed := false;
  if eur_is_changed then
  begin
    s := eur_edit^.text;
    replace_comma_by_point(s);
    val(s, eur, code);
    if (code = 0) then
    begin
      bedrag_bef := euro_to_bef(eur);
      changed := true;
    end else
    if trim(S) = '' then
    begin
      bedrag_bef := 0.0;
      changed := true;
    end;
  end
  else
  if bef_is_changed then
  begin
    s := bef_edit^.text;
    replace_comma_by_point(s);
    val(s, tmp, code);
    if (code = 0) then
    begin
      bedrag_bef := tmp;
      changed := true;
    end else
    if trim(S) = '' then
    begin
      bedrag_bef := 0.0;
      changed := true;
    end;
  end;
  if Changed then
  begin
    bef_string := bef_to_string_trimmed(bedrag_bef);
    eur_string := euro_to_string_trimmed(bef_to_euro(bedrag_bef));
  end;
  
  show;
end;

procedure BefEuroEdit.check_key_and_update(var key: char; var changed: boolean);
begin
  if not (key in ['0'..'9', '-', '.', ',', #13, #27, #8]) then
  begin
    Key := #0;
    Exit;
  end;
  if (key = #13) then
  begin {enter}
    update(changed);
    key := #0;
  end;
  if (key = #27) then
  begin {escape}
    show;
    key := #0;
  end;
end;

end.
