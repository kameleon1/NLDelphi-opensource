unit StrEncDec;

// Dany Rosseel

{$DEFINE NoDebug} // Disable debug possibilities and range checking (= faster)
// {.$Define NoDebug}: During debugging
// {$Define NoDebug} : During "normal" use


{$IFDEF NoDebug}

{$O+} // Optimisation ON
{$D-} // Debug information OFF
{$I-} // I/O checking OFF
{$L-} // Local Symbols OFF
{$Q-} // Overflow Checking OFF
{$R-} // Range Checking OFF

{$ELSE}
{$O-} // Optimisation OFF
{$D+} // Debug information ON
{$I+} // I/O checking ON
{$L+} // Local Symbols ON
{$Q+} // Overflow Checking ON
{$R+} // Range Checking ON

{$ENDIF}

{$W-} // Stack Frames OFF
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

function str_encode(s: string): string;
function str_decode(s: string): string;

implementation

type encdec = (encode, decode);
     direction_up = boolean;

function str_code(s: string; Mode: encdec):string;
var i : byte;
    r : string;
    dir_up : direction_up;
    offs : byte;
begin
  r := '';
  offs := 5;
  dir_up := true;

  for i := 1 to length(s) do
  begin
    if (Mode = encode)
    then r := r + chr(ord(s[i]) + offs)
    else r := r + chr(ord(s[i]) - offs);

    if dir_up then
    begin
      inc(offs);
      if (offs = 10) then dir_up := false;
    end else
    begin
      dec(offs);
      if (offs = 1) then dir_up := true;
    end;
    
  end;
  result := r;
end;

function str_encode(s: string): string;
begin
  result := str_code(s, encode);
end;

function str_decode(s: string): string;
begin
  result := str_code(s, decode);
end;

end.

