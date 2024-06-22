(**************************************************************************)
(*                                                                        *)
(*          General Purpose Hash Function Algorithms Library              *)
(*                                                                        *)
(* Author: Arash Partow - 2002                                            *)
(* URL: http://www.partow.net                                             *)
(* URL: http://www.partow.net/programming/hashfunctions/index.html        *)
(*                                                                        *)
(* Copyright notice:                                                      *)
(* Free use of the General Purpose Hash Function Algorithms Library is    *)
(* permitted under the guidelines and in accordance with the most current *)
(* version of the Common Public License.                                  *)
(* http://www.opensource.org/licenses/cpl.php                             *)
(*                                                                        *)
(**************************************************************************)


unit GeneralHashfunctions;

interface


type THashfunction = function(key : String) : LongInt;


function RSHash   (const Str : String) : LongInt;
function JSHash   (const Str : String) : LongInt;
function PJWHash  (const Str : String) : LongInt;
function ELFHash  (const Str : String) : LongInt;
function BKDRHash (const Str : String) : LongInt;
function SDBMHash (const Str : String) : LongInt;
function DJBHash  (const Str : String) : LongInt;
function APHash   (const Str : String) : LongInt;
function MyHash   (const Str : String) : LongInt;

implementation

function RSHash(const Str : String) : LongInt;
const b = 378551;
var
  a : LongInt;
  i : Integer;
begin
 a      := 63689;
 Result := 0;
 for i := 1 to Length(Str) do
 begin
  Result := Result * a + Ord(Str[i]);
  a      := a * b;
 end;
 Result := (Result and $7FFFFFFF);
end;

(* End Of RS Hash function *)


function JSHash(const Str : String) : LongInt;
var
  i : Integer;
begin
 Result := 1315423911;
 for i := 1 to Length(Str) do
 begin
  Result := Result xor ((Result shl 5) + Ord(Str[i]) + (Result shr 2));
 end;
 Result := (Result and $7FFFFFFF);
end;
(* End Of JS Hash function *)


function PJWHash(const Str : String) : LongInt;
const
 BitsInLongInt = Sizeof(LongInt) * 8;
 ThreeQuarters = (BitsInLongInt  * 3) Div 4;
 OneEighth     = BitsInLongInt Div 8;
 HighBits      : LongInt = (not LongInt(0)) shl (BitsInLongInt - OneEighth);
var
  i    : integer;
  Test : LongInt;
begin
 Result := 0;
 for i := 1 to Length(Str) do
 begin
  Result := (Result shl OneEighth) + Ord(Str[i]);
  Test   := Result and HighBits;
  If (Test <> 0) then
  begin
   Result := (Result xor (Test shr ThreeQuarters)) and (not HighBits);
  end;
 end;
 Result := (Result and $7FFFFFFF);
end;
(* End Of P. J. Weinberger Hash function *)


function ELFHash(const Str : String) : LongInt;
var
  i : integer;
  x : LongInt;
begin
 Result := 0;
 for i := 1 to Length(Str) do
 begin
  Result := (Result shl 4) + Ord(Str[i]);
  x      := Result and $F0000000;
  if (x <> 0) then
  begin
   Result := Result xor (x shr 24);
   Result := Result and (not x);
  end;
 end;
 Result := (Result and $7FFFFFFF);
end;
(* End Of ELF Hash function *)


function BKDRHash(const Str : String) : LongInt;
const Seed = 131; (* 31 131 1313 13131 131313 etc... *)
var
  i : integer;
begin
 Result := 0;
 for i := 1 to Length(Str) do
 begin
  Result := (Result * Seed) + Ord(Str[i]);
 end;
 Result := (Result and $7FFFFFFF);
end;
(* End Of BKDR Hash function *)


function SDBMHash(const Str : String) : LongInt;
var
  i : integer;
begin
 Result := 0;
 for i := 1 to Length(Str) do
 begin
  Result := Ord(str[i]) + (Result shl 6) + (Result shl 16) - Result;
 end;
 Result := (Result and $7FFFFFFF);
end;
(* End Of SDBM Hash function *)


function DJBHash(const Str : String) : LongInt;
var
  i : integer;
begin
 Result := 5381;
 for I:= 1 to Length(Str) do
 begin
  Result := ((Result shl 5) + Result) + Ord(Str[i]);
 end;
 Result := (Result and $7FFFFFFF);
end;
(* End Of DJB Hash function *)


function APHash(const Str : String) : LongInt;
var
  i : integer;
begin
 Result := 0;
 for i := 1 to Length(Str) do
 begin
  if ((i - 1) and 1) = 0 then
   Result := Result xor ((Result shl 7) xor Ord(Str[i]) xor (Result shr 3))
  else
   Result := Result xor (not((Result shl 11) xor Ord(Str[i]) xor (Result shr 5)));
 end;
 Result := (Result and $7FFFFFFF);
end;
(* End Of AP Hash function *)

function MyHash(const Str : String) : LongInt;
var I: integer;
begin
  Result := 64;
  for I := 1 to Length(Str) do
  begin
    Result := Result + (5 * I * Ord(Str[I]));
  end;
end;

end.
