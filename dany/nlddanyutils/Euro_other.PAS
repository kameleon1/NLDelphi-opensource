unit Euro_other;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses StdCtrls, SysUtils;


type   EuroEdit = object
         koers_other: real;
         decimals   : byte;
         bedrag_euro : real48;
         procedure init(var eu, other: TEdit);
         procedure show;
         procedure update(var changed: boolean); { to be used on 'exit' of the datafield }
         procedure check_key_and_update(var key: char; var changed: boolean); { checks for 'enter' and 'escape' }

         private
         other_edit, eur_edit: ^TEdit;
         other_string, eur_string : shortstring;
         function other_is_changed: boolean;
         function eur_is_changed: boolean;
         function euro_to_other(eur: real48): real48;
         function other_to_euro(other: real48): real48;
         function other_to_string(other:real48;t,a:byte)          : shortstring;
         function other_to_string_trimmed(other:real48)           : shortstring;
         function euro_to_string(eur: real48;t,a:byte)            : shortstring;
         function euro_to_string_trimmed(eur: real48)             : shortstring;
         function other_to_eur_to_string(other:real48; t,a : byte): shortstring;
         function eur_to_other_to_string(eur:real48; t,a : byte)  : shortstring;
         function string_to_bedrag(s:shortstring)                 : real48;
       end;

implementation

function EuroEdit.euro_to_other(eur: real48) : real48;
var res: real48;
begin
  res := eur * koers_other;
  euro_to_other := res;
end;

function EuroEdit.other_to_euro(other: real48): real48;
var res: real48;
begin
  res := other / koers_other;
  other_to_euro := res;
end;

function EuroEdit.other_to_string(other:real48;t,a:byte): shortstring;
var s : shortstring;
    i : byte;
begin
  str(other:t:a,s);
  for i := 1 to length(s) do if s[i] = '.' then s[i] := ',';
  other_to_string := s;
end;

function EuroEdit.other_to_string_trimmed(other:real48):shortstring;
var s: shortstring;
begin
   s := other_to_string(other, 20, decimals);
   other_to_string_trimmed := trim(s);
end;

function EuroEdit.euro_to_string(eur: real48;t,a:byte): shortstring;
var s : shortstring;
    i : byte;
begin
  str(eur:t:a,s);
  for i := 1 to length(s) do if s[i] = '.' then s[i] := ',';
  euro_to_string := s;
end;

function EuroEdit.euro_to_string_trimmed(eur: real48): shortstring;
var s: shortstring;
begin
   s := euro_to_string(eur, 20, 2); { 2 digits fraction }
   euro_to_string_trimmed := trim(s);
end;

function EuroEdit.other_to_eur_to_string(other:real48; t,a : byte): shortstring;
var eur: real48;
    s : shortstring;
begin
  eur := other_to_euro(other);
  s := euro_to_string(eur, t, a);
  other_to_eur_to_string := s;
end;

function EuroEdit.eur_to_other_to_string(eur:real48; t,a : byte): shortstring;
var other: real48;
    s : shortstring;
begin
  other := euro_to_other(eur);
  s := other_to_string(other, t, a);
  eur_to_other_to_string := s;
end;
{------------------------------------------------------------}

procedure EuroEdit.init(var eu, other: TEdit);
begin
  koers_other  := 40.3399; { for Bef }
  decimals     := 0;      { for Bef }
  bedrag_euro  := 0.0;
  other_edit   := @other;
  eur_edit     := @eu;
  other_string := trim(other_edit^.text);
  eur_string   := trim(eur_edit^.text);
end;

procedure replace_comma_by_point(var s: shortstring);
var i: byte;
begin
  for i := 1 to length(s) do if s[i] = ',' then s[i] := '.';
end;

function EuroEdit.string_to_bedrag(s:shortstring): real48;
var tmp  : real48;
    code : integer;
begin
  replace_comma_by_point(s);
  val(s, tmp, code);
  if (code = 0)
  then string_to_bedrag := tmp
  else string_to_bedrag := 0;
end;

procedure EuroEdit.show;
begin
  other_string := other_to_string_trimmed(euro_to_other(bedrag_euro));
  eur_string := euro_to_string_trimmed(bedrag_euro);

  other_edit^.text := other_string;
  eur_edit^.text   := eur_string;
end;

function EuroEdit.other_is_changed: boolean;
begin
  other_is_changed := trim(other_edit^.text) <> trim(other_string);
end;

function EuroEdit.eur_is_changed: boolean;
begin
  eur_is_changed := trim(eur_edit^.text) <> trim(eur_string);
end;

procedure EuroEdit.update(var changed: boolean);
var eur, tmp  : real48;
    code      : integer;
    s         : shortstring;
begin

  if other_is_changed then
  begin
    s := other_edit^.text;
    replace_comma_by_point(s);
    val(s, tmp, code);
    if (code = 0) then
    begin
      bedrag_euro := other_to_euro(tmp);
      changed     := true;
    end;
  end;

  if eur_is_changed then
  begin
    s := eur_edit^.text;
    replace_comma_by_point(s);
    val(s, eur, code);
    if (code = 0) then
    begin
      bedrag_euro := eur;
      changed     := true;
    end;
  end;

  show;
end;

procedure EuroEdit.check_key_and_update(var key: char; var changed: boolean);
begin
  if (key = #13) then begin {enter}
    update(changed);
    key := #0;
  end;
  if (key = #27) then begin {escape}
    show;
    key := #0;
  end;
end;

end.
