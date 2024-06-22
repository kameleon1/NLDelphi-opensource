unit GetWindows;

// Dany Rosseel

{ History of this unit
  21-09-2002: Initial version
  11-10-2003: Adaptions made to meet coding conventions
}

interface

uses Classes, Windows, SysUtils;

procedure BuildListOfWindows(List: TStrings);
function  GetWindowHandle(Win: string): THandle;

implementation

var Handles : array of THandle;
    N : Word;

function ENumWindowsFunc(Handle: THandle; List: TStrings): Boolean; stdcall;
var Caption: array[0..256] of Char;
begin
  if GetWindowtext(Handle, Caption, sizeof(Caption) -1) <> 0
  then begin
         List.Add(Lowercase(Caption)); // store the name
         SetLength(Handles, N + 1);    // increment the size of the array
         Handles[N] := Handle;         // store the Handle
         Inc(N);                       // one more stored
       end;
  Result := True;
end;

{ This function gets the List of active windoes into a stringlist}
procedure BuildListOfWindows(List: TStrings);
begin
  List.Clear;
  SetLength(Handles, 0);
  N := 0;
  EnumWindows(@ENumWindowsFunc, LParam(List));
end;


{ This function returns the Handle for a given windowname}
function GetWindowHandle(Win: string): THandle;
var List  : TStrings;
    N     : Word;
    Found : Boolean;
begin
  Result := 0;
  List   := TStringList.Create;
  BuildListOfWindows(List);
  if List.Count > 0 then
  begin
    Found := False;
    N := 0;
    while (N < List.Count) and (not Found) do
    begin
      if (Lowercase(Win) = Lowercase(List.strings[N])) then  // Found!
      begin
        Result := Handles[N];
        Found  := True;
      end;
      Inc(N);
    end;
  end;
  List.Free;
end;

end.
