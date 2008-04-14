unit NLDMBHookInstance;

{
  :: This unit contains the code necessary to map a hook procedure to an
  :: object method. It is an almost exact copy of the code found in Forms.pas
  :: (for Delphi 5 and lower) or Classes.pas (for Delphi 6 and higher).
  ::/n/n
  :: This code was found at: http://www.undu.com/Articles/980326c.htm

  :$
  :$
  :$ NLDMessageBox is released under the zlib/libpng OSI-approved license.
  :$ For more information: http://www.opensource.org/
  :$ /n/n
  :$ /n/n
  :$ Copyright (c) 2003 M. van Renswoude
  :$ /n/n
  :$ This software is provided 'as-is', without any express or implied warranty.
  :$ In no event will the authors be held liable for any damages arising from
  :$ the use of this software.
  :$ /n/n
  :$ Permission is granted to anyone to use this software for any purpose,
  :$ including commercial applications, and to alter it and redistribute it
  :$ freely, subject to the following restrictions:
  :$ /n/n
  :$ 1. The origin of this software must not be misrepresented; you must not
  :$ claim that you wrote the original software. If you use this software in a
  :$ product, an acknowledgment in the product documentation would be
  :$ appreciated but is not required.
  :$ /n/n
  :$ 2. Altered source versions must be plainly marked as such, and must not be
  :$ misrepresented as being the original software.
  :$ /n/n
  :$ 3. This notice may not be removed or altered from any source distribution.
}

interface
uses
  Windows;

type
  THookMessage  = packed record
    nCode:      Integer;
    wParam:     WPARAM;
    lParam:     LPARAM;
    Result:     LRESULT;
  end;

  THookMethod = procedure(var Msg: THookMessage) of object;

  function MakeHookInstance(Method: THookMethod): Pointer;
  procedure FreeHookInstance(ObjectInstance: Pointer);

implementation
const
  InstanceCount = 313;  // set so that sizeof (TInstanceBlock) < PageSize

type
  PObjectInstance = ^TObjectInstance;
  TObjectInstance = packed record
    Code:         Byte;
    Offset:       Integer;
    case Integer of
      0: (Next:   PObjectInstance);
      1: (Method: THookMethod);
  end;

type
  PInstanceBlock = ^TInstanceBlock;
  TInstanceBlock = packed record
    Next:         PInstanceBlock;
    Code:         array[1..2] of Byte;
    WndProcPtr:   Pointer;
    Instances:    array[0..InstanceCount] of TObjectInstance;
  end;

var
  InstBlockList:  PInstanceBlock  = nil;
  InstFreeList:   PObjectInstance = nil;

function StdHookProc(Code, WParam: WPARAM; LParam: LPARAM): LResult; stdcall; assembler;
asm
  XOR     EAX,EAX
  PUSH    EAX
  PUSH    LParam
  PUSH    WParam
  PUSH    Code
  MOV     EDX,ESP
  MOV     EAX,[ECX].Longint[4]
  CALL    [ECX].Pointer
  ADD     ESP,12
  POP     EAX
end;

{ Allocate a hook method instance }
function CalcJmpOffset(Src, Dest: Pointer): Longint;
begin
  Result := Longint(Dest) - (Longint(Src) + 5);
end;

function MakeHookInstance(Method: THookMethod): Pointer;
const
  BlockCode: array [1..2] of Byte = ($59, $E9);
  PageSize = 4096;
var
  Block: PInstanceBlock;
  Instance: PObjectInstance;
begin
  if InstFreeList = nil then
  begin
    Block := VirtualAlloc (nil, PageSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    Block^.Next := InstBlockList;
    Move(BlockCode, Block^.Code, SizeOf(BlockCode));
    Block^.WndProcPtr := Pointer(CalcJmpOffset(@Block^.Code[2], @StdHookProc));
    Instance := @Block^.Instances;
    repeat
      Instance^.Code := $E8;
      Instance^.Offset := CalcJmpOffset(Instance, @Block^.Code);
      Instance^.Next := InstFreeList;
      InstFreeList := Instance;
      Inc(Longint(Instance), SizeOf(TObjectInstance));
    until Longint(Instance) - Longint(Block) >= SizeOf(TInstanceBlock);
    InstBlockList := Block
  end;
  Result := InstFreeList;
  Instance := InstFreeList;
  InstFreeList := Instance^.Next;
  Instance^.Method := Method
end;

{ Free a hook method instance }
procedure FreeHookInstance (ObjectInstance: Pointer);
begin
  if ObjectInstance <> nil then
  begin
    PObjectInstance(ObjectInstance)^.Next := InstFreeList;
    InstFreeList := ObjectInstance 
  end 
end; 

end.
