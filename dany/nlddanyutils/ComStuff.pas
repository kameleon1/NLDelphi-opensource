UNIT ComStuff;

INTERFACE
USES
  Windows, WinTypes, Sysutils;

CONST
  tpNotPresent  = 0;
  tpAvailable   = 1;
  tpNusy        = 2;

TYPE
  TcomArray     = Array[0..255] of Byte;

Procedure GetCOMPorts( Var Ports : TcomArray);
// function returns all available and occupied serial COM prts

Function OpenCOMPort( PortNr : Byte): Boolean;

Function COMportIsOpen : Boolean;

Function SendCOMdata(Data: String) : Boolean;

Function ReadCOMData: String;

Procedure CloseCOMPort;

IMPLEMENTATION

function FormatDeviceName(PortNumber: Integer): string;
begin
  if (Win32Platform = VER_PLATFORM_WIN32_NT) and (PortNumber > 9) then
    Result := Format('\\.\COM%d', [PortNumber])
  else
    Result := Format('COM%d', [PortNumber]);
end;

const
  PS_OPEN     = 0;
  PS_CLOSE    = 1;
  PS_NOTEXIST = 2;

type
  TPortState = packed record
    ComNumber: Word;
    State: Word;
  end;

function GetPortState( PortNumber: Integer): TPortState;
var
  DeviceHandle: THandle;
  DeviceName: String;
begin
  If (PortNumber < 0) then PortNumber := 0;
  Result.ComNumber := PortNumber;
  DeviceName := FormatDeviceName(PortNumber);
  DeviceHandle := CreateFile(PChar(DeviceName), GENERIC_READ or GENERIC_WRITE,
    0, nil, OPEN_EXISTING, 0, 0);
  If DeviceHandle = INVALID_HANDLE_VALUE then
  begin
    If GetLastError = ERROR_FILE_NOT_FOUND then
      Result.State := PS_NOTEXIST  // port not present
    else
      Result.State := PS_OPEN; // port is already open
  end else
  begin
    CloseHandle(DeviceHandle);
    Result.State := PS_CLOSE;  // port is available
  end;
end;

Procedure GetCOMports( Var Ports : TcomArray);
// returns the numbers of all com ports.
// when port is available "1" is returned else
// if a port is already open "2" is returned
// else "0" is returned.
Var
  Port : Integer;
Begin
  For Port := 0 to $FF do
    If (GetPortState(Port).State = PS_CLOSE) then Ports[Port] := 1
    else
    If (GetPortState(Port).State = PS_OPEN) then Ports[Port] := 2
    else
    Ports[Port] := 0;
End;

VAR
  ComFile: THandle = INVALID_HANDLE_VALUE;

function SetupCOMPort : Boolean;
const
   RxBufferSize = 256;
   TxBufferSize = 256;
var
   DCB: TDCB;
   Timeouts: TCommTimeouts;

begin
  Result := FALSE;
  If ComFile = INVALID_HANDLE_VALUE then Exit;
    { We assume that the setup to configure the setup works fine.
      Otherwise the function returns false.

      wir gehen davon aus das das Einstellen des COM Ports funktioniert.
      sollte dies fehlschlagen wird der Rückgabewert auf "FALSE" gesetzt.
    }
   Result := True;

   if not SetupComm(ComFile, RxBufferSize, TxBufferSize) then
     Result := False;

    with Timeouts do
      begin
        ReadIntervalTimeout          := MaxDword;
        ReadTotalTimeoutMultiplier   := 0;
        ReadTotalTimeoutConstant     := 0;
        WriteTotalTimeoutMultiplier  := 10;
        WriteTotalTimeoutConstant    := 10;
      end;
    Result := SetCommTimeouts(ComFile, TimeOuts);

   if not GetCommState(ComFile, DCB) then
     Result := False
   else
   // define the default baudrate, parity,...
     begin
       DCB.BaudRate := CBR_115200;
       DCB.ByteSize := 8;
       DCB.Parity   := NOPARITY;
       DCB.StopBits := ONESTOPBIT;
     end;

   if not SetCommState(ComFile, DCB) then
     Result := False;
end;

function OpenCOMPort( PortNr : Byte): Boolean;
var
   DeviceName: array[0..500] of Char;
begin
    { First step is to open the communications device for read/write.
      This is achieved using the Win32 'CreateFile' function.
      If it fails, the function returns false.
    }
   StrPCopy(DeviceName, FormatDeviceName(PortNr));

   ComFile := CreateFile(DeviceName,
     GENERIC_READ or GENERIC_WRITE,
     0,
     nil,
     OPEN_EXISTING,
     FILE_ATTRIBUTE_NORMAL,
     0);

   Result := (ComFile <> INVALID_HANDLE_VALUE);
   If Result then Result := SetupCOMport;
end;



{
   The following is an example of using the 'WriteFile' function
   to write data to the serial port.
 }
Function SendCOMdata(Data: string) : Boolean;
var
   BytesWritten: DWORD;
begin
  Result := FALSE;
  If ComFile = INVALID_HANDLE_VALUE then Exit;
   Result := WriteFile(ComFile, Data[1], Length(Data), BytesWritten, nil);
end;


{
   The following is an example of using the 'ReadFile' function to read
   data from the serial port.
 }
Function ReadCOMData: string;
var
   Data      : array[1..500] of Char;
   BytesRead : Cardinal;
   I         : Integer;
begin
  Result := '';
  If ComFile = INVALID_HANDLE_VALUE then Exit;
   if not ReadFile(ComFile, Data, SizeOf(Data), BytesRead, nil) then
   begin
     { Raise an exception }
   end;
   Result := '';
   for i := 1 to BytesRead do Result := Result + Data[I];
end;

Function COMportIsOpen : Boolean;
Begin
  Result := ComFile <> INVALID_HANDLE_VALUE;
End;


procedure CloseCOMPort;
begin
   // finally close the COM Port!
  If ComFile = INVALID_HANDLE_VALUE then Exit;
   CloseHandle(ComFile);
   ComFile := INVALID_HANDLE_VALUE;
end;

END.
