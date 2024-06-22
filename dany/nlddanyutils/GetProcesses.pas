unit GetProcesses;

// Dany Rosseel

{ History of this unit
  21-09-2002: Initial version
  11-10-2003: Adaptions made to meet coding conventions
  05-01-2004: Adapted to use "TlHelp32" in stead of "ToolHelp32
}

interface
uses Windows, SysUtils, StdCtrls, Classes;

procedure BuildListOfProcesses(List: TStrings);
// This procedure builds a of List names of running processes 
// in the (properly created) stringlist

function  GetProcessId(Prc: string): LongWord;
// This function returns the ProcessId of the process with name 'Prc'.


implementation

uses TlHelp32;

var
Flags  : DWord = 2; { 2 = TH32CS_SNAPPROCESS }
ProcId : DWord = 0;

ProcessIds : array of LongWord;
N          : Word;

// This procedure builds a of List names of running processes in the (properly created) stringlist
procedure BuildListOfProcesses(List: TStrings);
var Snapshot : THandle;
    Res      : Bool;
    Entry    : TProcessEntry32;
    I        : Word;
    S        : shortstring;
begin
  List.Clear;
  SetLength(ProcessIds, 0);    // clear the process ID array
  N := 0;                      // set the count to zero

  Snapshot := CreateToolhelp32Snapshot(Flags, ProcId);
  if (Snapshot > 0) then
  begin
    Entry.DwSize := SizeOf(TProcessEntry32);
    Res := Process32First(Snapshot, Entry);
    while Res do
    begin
      S := '';
      I := 0;
      while (I <= 255) and (Entry.szExefile[I] > #0) do
      begin
        S := S + Entry.szExefile[I];
        inc(I);
      end;
      S := LowerCase(ExtractFileName(S));
      S[1] := upcase(S[1]);
      List.Add(S);                          // add the name to the List

      SetLength(ProcessIds, N+1);           // increment the size of the array
      ProcessIds[N] := Entry.th32ProcessId; // store the process id
      inc(N);                               // one more stored

      res := Process32Next(Snapshot, Entry);
    end;
    CloseHandle(Snapshot);
  end;
end;


// This function returns the ProcessId of the process with name 'Prc'
function GetProcessId(Prc: string): LongWord;
var List  : TStrings;
    N     : Word;
    Found : Boolean;
begin
  Result := 0;
  List := TStringList.Create;
  BuildListOfProcesses(List);
  if List.Count > 0 then
  begin
    Found := False;
    N := 0;
    while (N < List.Count) and (not Found) do
    begin
      if (LowerCase(Prc) = LowerCase(List.strings[N])) then  // Found!
      begin
        Result := ProcessIds[N];
        Found  := True;
      end;
      inc(N);
    end;
  end;
  List.free;
end;

end.


