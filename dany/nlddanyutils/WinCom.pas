unit WinCom;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

// Latest update: 24-03-2014
{ Thanks to Virgil Chindris for pointing out type errors in the routines "getChar" and "OpenCom". }

interface

uses WinTypes;

const
  LastCom = 20;

type
  TComNr = 0..LastCom;

const

  { Baudrates (word)}
  BaudRate_110       = CBR_110;
  BaudRate_300       = CBR_300;
  BaudRate_600       = CBR_600;
  BaudRate_1200      = CBR_1200;
  BaudRate_2400      = CBR_2400;
  BaudRate_4800      = CBR_4800;
  BaudRate_9600      = CBR_9600;
  BaudRate_14K4      = CBR_14400;
  BaudRate_19K2      = CBR_19200;
  BaudRate_38K4      = CBR_38400;
  BaudRate_56K       = CBR_56000;
  BaudRate_57K       = CBR_57600;
  BaudRate_115K      = CBR_115200;
  BaudRate_128K      = CBR_128000;
  BaudRate_256K      = CBR_256000;

  { Parity (Byte) }
  Parity_none        = NOPARITY;
  Parity_odd         = ODDPARITY;
  Parity_even        = EVENPARITY;
  Parity_mark        = MARKPARITY;
  Parity_space       = SPACEPARITY;

  { Number of stop bits (Byte) }
  Stopbits_1         = ONESTOPBIT;
  Stopbits_1_5       = ONE5STOPBITS;
  Stopbits_2         = TWOSTOPBITS;

  { Errorbits }
  ComError_Break     = CE_BREAK;    {The hardware detected a break condition.}
  ComError_Framing   = CE_FRAME;    {The hardware detected a framing error.}
  ComError_IO        = CE_IOE;      {An I/O error occurred during communications with the device.}
  ComError_Overrun   = CE_OVERRUN;  {A character-buffer overrun has occurred. The next character is lost.}
  ComError_Overflow  = CE_RXOVER;   {An input buffer overflow has occurred. There is either no room in the input buffer, or a character was received after the end-of-file (EOF) character.}
  ComError_Parity    = CE_RXPARITY; {The hardware detected a parity error.}
  ComError_TxFull    = CE_TXFULL;   {The application tried to transmit a character, but the output buffer was full.}

const

  { "TDCB.Flags" bits (one bit each }
  DCB_Flag_Binary        = $0001; { Binary mode (skip eof check) }
  DCB_Flag_RtsDisable    = $0002; { RTS handshake on input }
  DCB_Flag_Parity        = $0004; { Enable parity checking }
  DCB_Flag_OutxCtsFlow   = $0008; { CTS handschaking on output }
  DCB_Flag_OutxDsrFlow   = $0010; { DSR handshaking on output }

  DCB_Flag_DtrDisable    = $0080; { Don't assert DTR at init time }
  DCB_Flag_OutX          = $0100; { Enable output X-ON/X-OFF }
  DCB_Flag_InX           = $0200; { Enable input X-ON/X-OFF }
  DCB_Flag_PEErrorChar   = $0400; { Enable parity error replacement }
  DCB_Flag_Null          = $0800; { Enable Null stripping }
  DCB_Flag_RxEvt         = $1000; { enable RX character event }
  DCB_Flag_InDtrFlow     = $2000; { DTR handshake on input }
  DCB_Flag_InRtsFlow     = $4000; { RTS handshake on input }

const

  { "TComStat.Flags" bits (one bit each }
  Comstat_Flag_CtsHold   = $0001; { Transmit is on CTS hold }
  Comstat_Flag_DsrHold   = $0002; { Transmit is on DSR hold }
  Comstat_Flag_RlsdHold  = $0004; { Transmit is on RLSD hold }
  Comstat_Flag_XoffHold  = $0008; { Received handshake }
  Comstat_Flag_XoffSent  = $0010; { Issued handshake }
  Comstat_Flag_Eof       = $0020; { End of file character found }
  Comstat_Flag_Txim      = $0040; { Character being transmitted }


type
  ComDataRec = record
    Handle: longword;
    DCB: TDCB;
    Stat: TCOMSTAT;
    Errors: longword;
  end;

var
  ComData: array[1..LastCom] of ^ComDataRec;  
    
{----------------------commonly used routines --------------------------}

function OpenCom(ComNr: TComNr; {1..LastCom}
  baud:           LongWord;
  parity:         Byte;
  databits:       Byte; {4..8}
  stopbits:       Byte;
  sendbuffer_size,
  recbuffer_size: longword): Boolean; { true = success, false = failure}

procedure CloseCom(ComNr: TComNr);

function ComIsOpen(ComNr: TComNr): Boolean; { true = open, false = not open }

function NrCharsReceived(ComNr: TComNr): longword;
{ result is the number of characters in the receivebuffer}

function SendChars(ComNr: TComNr; var Buf: array of ansichar; number_to_send: longword): longword;
{ the result is (the absolute value of) the number of characters sent, a negative result means an error }

function SendString(ComNr: TComNr; const s: ansistring): longword;
{ the result is (the absolute value of) the number of characters sent, a negative result means an error }

function GetChar(ComNr: TComNr; var Ch: ansichar): boolean;

function ReceiveChars(ComNr: TComNr; var Buf: array of ansichar; number_to_receive: longword): longword;
{ the result is (the absolute value of) the number of characters received, a negative result means an error }

function FlushReceiveBuffer(ComNr: TComNr): Boolean;
function FlushSendBuffer(ComNr: TComNr): Boolean;

function SetDtr_(ComNr: TComNr): Boolean;
function ClearDtr(ComNr: TComNr): Boolean;

function SetRts_(ComNr: TComNr): Boolean;
function ClearRts(ComNr: TComNr): Boolean;

function SetBreak(ComNr: TComNr): Boolean; { disables communication }
function ClearBreak(ComNr: TComNr): Boolean; {default, enables communication }

function  GetComErrors(ComNr: TComNr): longword;
procedure GetComStatus(ComNr: TComNr; var Stat: TComStat);

procedure Cancel_Io(ComNr: TComNr);
procedure GetErrorAndStatus(ComNr: TComNr);


implementation

uses SysUtils;



  (*
     DTE (Terminal)                                DCE (modem)
    +-------------+                               +-------------+
    |          DTR|------------------------------>|             |
    |          RTS|------------------------------>|             |
    |             |                               |             |
    |             |<------------------------------|CD           |
    |             |<------------------------------|DSR          |
    |             |<------------------------------|CTS          |
    +-------------+                               +-------------+

  *)

procedure GetErrorAndStatus(ComNr: TComNr);
begin
  if ComIsOpen(ComNr) then
  begin
    with ComData[ComNr]^ do
    begin
      ClearCommError(Handle, Errors, @Stat);
    end;
  end;
end;

procedure GetDcb(ComNr: TComNr; var DCB: TDCB);
begin
  if ComIsOpen(ComNr) then
  GetCommState(ComData[ComNr]^.Handle, DCB);
end;

function SetDcb(ComNr: TComNr; NewDCB: TDCB): Boolean;
var
  success: LongBool;
begin
  success := false;
  if ComIsOpen(ComNr) then
  begin
    success := SetCommState(ComData[ComNr]^.Handle, NewDCB);
    if success then
      GetErrorAndStatus(ComNr);
  end;
  SetDcb := success;
end;

procedure MakeDefaultDcb(var DCB: TDCB);
begin
  with DCB do
  begin
    DCBlength := sizeof(TDCB);
    Baudrate := Baudrate_1200;
    Flags := DCB_Flag_Binary;
    XonLim := 65535;
    XoffLim := 0;
    ByteSize := 8;
    Parity := Parity_none;
    StopBits := Stopbits_2;
    XonChar := #0;
    XoffChar := #255;
    ErrorChar := '.';
    EofChar := #0;
    EvtChar := #0;
  end;
end;

function OpenCom(ComNr: TComNr;
  baud: LongWord;
  parity: Byte;
  databits: Byte;
  stopbits: Byte;
  sendbuffer_size,
  recbuffer_size: longword): Boolean;
var
  success: LongBool;
  ComName: PChar;
  res: Integer;
  Timeouts: TCommTimeouts;
begin
  success := true;

  if (ComNr < 1) or (ComNr > LastCom) then ComNr := 1; // default
  
  if not ComIsOpen(ComNr) then
  begin
    new(ComData[ComNr]);

   if ComNr < 10 then
        ComName := PChar('COM' + IntToStr(ComNr))
      else
        ComName := PChar('\\.\COM' + IntToStr(ComNr));

    res := Createfile(ComName,
      GENERIC_READ or GENERIC_WRITE,
      0,
      nil,
      OPEN_EXISTING,
      0, 0);

    success := (res >= 0);

    if success then
    begin {comport was sucessfully opened }

      ComData[ComNr]^.Handle := res;

      GetCommState(ComData[ComNr].handle, ComData[ComNr]^.DCB);
      ComData[ComNr]^.DCB.Baudrate  := baud;
      ComData[ComNr]^.DCB.ByteSize  := databits;
      ComData[ComNr]^.DCB.Parity    := parity;
      ComData[ComNr]^.DCB.StopBits  := stopbits;
      success := SetDcb(ComNr, ComData[ComNr]^.DCB);

      if success then
      begin

        success := SetupComm(ComData[ComNr]^.Handle,
                             recbuffer_size,
                             sendbuffer_size);

        if success then { set up communication timeouts }
        begin
          with Timeouts do
          begin
            ReadIntervalTimeout          := MaxDword;
            ReadTotalTimeoutMultiplier   := 0;
            ReadTotalTimeoutConstant     := 0;
            WriteTotalTimeoutMultiplier  := 10;
            WriteTotalTimeoutConstant    := 10;
          end;

{  ----  Timeout parameters ----

ReadIntervalTimeout:
--------------------

Specifies the maximum time, in milliseconds, allowed to elapse between the arrival of two characters on the communications line.
During a ReadFile operation, the time period begins when the first character is received. If the interval between the arrival of
any two characters exceeds this amount, the ReadFile operation is completed and any buffered data is returned.
A value of zero indicates that interval time-outs are not used.
A value of MAXDWORD, combined with zero values for both the ReadTotalTimeoutConstant and ReadTotalTimeoutMultiplier members,
specifies that the read operation is to return immediately with the characters that have already been received,
even if no characters have been received.

ReadTotalTimeoutMultiplier:
---------------------------

Specifies the multiplier, in milliseconds, used to calculate the total time-out period for read operations.
For each read operation, this value is multiplied by the requested number of bytes to be read.

ReadTotalTimeoutConstant:
-------------------------

Specifies the constant, in milliseconds, used to calculate the total time-out period for read operations.
For each read operation, this value is added to the product of the ReadTotalTimeoutMultiplier member and the requested number of bytes.
A value of zero for both the ReadTotalTimeoutMultiplier and ReadTotalTimeoutConstant members indicates that total time-outs are
not used for read operations.

WriteTotalTimeoutMultiplier:
----------------------------

Specifies the multiplier, in milliseconds, used to calculate the total time-out period for write operations.
For each write operation, this value is multiplied by the number of bytes to be written.

WriteTotalTimeoutConstant:
--------------------------

Specifies the constant, in milliseconds, used to calculate the total time-out period for write operations.
For each write operation, this value is added to the product of the WriteTotalTimeoutMultiplier member and the number of bytes
to be written.
A value of zero for both the WriteTotalTimeoutMultiplier and WriteTotalTimeoutConstant members indicates that total time-outs
are not used for write operations.

}
          success := SetCommTimeouts(ComData[ComNr]^.Handle,
            TimeOuts);
        end
        else
        begin
          ComData[ComNr]^.Errors := GetLastError;
          OpenCom := false;
          exit;
        end;
      end
      else
      begin
        ComData[ComNr]^.Errors := GetLastError;
        CloseCom(ComNr); {close comport again and get rid of variables }
        OpenCom := false;
        exit;
      end;
    end
    else
    begin
      ComData[ComNr]^.Errors := GetLastError;
      dispose(ComData[ComNr]); { get rid of allocated variables now }
      ComData[ComNr] := nil;
      OpenCom := false;
      exit;
    end;
  end;
  OpenCom := success;
end;

procedure CloseCom(ComNr: TComNr);
begin
  if ComIsOpen(ComNr) then
  begin
    FlushSendbuffer(ComNr);
    FlushReceivebuffer(ComNr);
    CloseHandle(ComData[ComNr]^.Handle);
    dispose(ComData[ComNr]);
    ComData[ComNr] := nil;
  end;
end;

function ComIsOpen(ComNr: TComNr): Boolean;
begin
  ComIsOpen := (ComNr > 0) and (ComData[ComNr] <> nil);
end;

function NrCharsReceived(ComNr: TComNr): longword;
begin
  Result := 0;
  if ComIsOpen(ComNr) then
  begin
    GetErrorAndStatus(ComNr);
    Result := ComData[ComNr]^.Stat.cbInQue;
  end;
end;

function SendChars(ComNr: TComNr; var Buf: array of ansichar; number_to_send: longword): longword;
var
  nr: DWord;
  success: LongBool;
begin
  nr := 0;
  success := false;
  if ComIsOpen(ComNr) then
    success := WriteFile(ComData[ComNr]^.Handle,
      Buf,
      number_to_send,
      Nr,
      nil);
  if not success then
    ComData[ComNr]^.Errors := GetLastError;
  Result := nr;
end;

function SendString(ComNr: TComNr; const S: ansistring): longword;
var
  Buff: array[0..10000] of ansichar;
begin
  StrPcopy(@Buff, S);
  Result := SendChars(ComNr, Buff, length(s));
end;

function ReceiveChars(ComNr: TComNr; var Buf: array of ansichar; number_to_receive: longword):
  longword;
var
  success: boolean;
begin
  if ComIsOpen(ComNr) then
  begin
    Success := ReadFile(ComData[ComNr]^.Handle,
             Buf,
             number_to_receive,
             Result,
             nil);
    if not success then
    begin
      GetErrorAndStatus(ComNr);
    end;
  end;
end;

procedure Cancel_Io(ComNr: TComNr);
begin
  CancelIo(ComData[ComNr]^.Handle);
end;

function GetChar(ComNr: TComNr; var Ch: ansichar): boolean;
var Buf: ^ansichar;
    Nr: longword;
begin
  Buf := @Ch;
  ReadFile(ComData[ComNr]^.Handle,
  Buf^,
  1,
  Nr,
  nil);
  Result := Nr > 0;
end;

function FlushReceiveBuffer(ComNr: TComNr): Boolean;
var
  success: LongBool;
begin
  success := false;
  if ComIsOpen(ComNr) then
    success := PurgeComm(ComData[ComNr]^.Handle,
      PURGE_RXABORT or PURGE_RXCLEAR);
  if not success then
    ComData[ComNr]^.Errors := GetLastError;
  FlushReceiveBuffer := success;
end;

function FlushSendBuffer(ComNr: TComNr): Boolean;
var
  success: LongBool;
begin
  success := false;
  if ComIsOpen(ComNr) then
    success := PurgeComm(ComData[ComNr]^.Handle,
      PURGE_TXABORT or PURGE_TXCLEAR);
  if not success then
    ComData[ComNr]^.Errors := GetLastError;
  FlushSendBuffer := success;
end;

function SetDtr_(ComNr: TComNr): Boolean;
begin
  Result := false;
  if ComIsOpen(ComNr) then
  begin
    Result := EscapeCommFunction(ComData[ComNr]^.Handle, SETDTR);
  end;
end;

function ClearDtr(ComNr: TComNr): Boolean;
begin
  Result := false;
  if ComIsOpen(ComNr) then
  begin
    Result := EscapeCommFunction(ComData[ComNr]^.Handle, CLRDTR);
  end;
end;

function SetRts_(ComNr: TComNr): Boolean;
begin
  Result := false;
  if ComIsOpen(ComNr) then
  begin
    Result := EscapeCommFunction(ComData[ComNr]^.Handle, SETRTS);
  end;
end;

function ClearRts(ComNr: TComNr): Boolean;
begin
  Result := false;
  if ComIsOpen(ComNr) then
  begin
    Result := EscapeCommFunction(ComData[ComNr]^.Handle, CLRRTS);
  end;
end;

function SetBreak(ComNr: TComNr): Boolean;
var
  success: LongBool;
begin
  success := false;
  if ComIsOpen(ComNr) then
    success := SetCommBreak(ComData[ComNr]^.Handle);
  if not success then
    ComData[ComNr]^.Errors := GetLastError;
  SetBreak := success;
end;

function ClearBreak(ComNr: TComNr): Boolean;
var
  success: LongBool;
begin
  success := false;
  if ComIsOpen(ComNr) then
    success := ClearCommBreak(ComData[ComNr]^.Handle);
  if not success then
    ComData[ComNr]^.Errors := GetLastError;
  ClearBreak := success;
end;

function GetComErrors(ComNr: TComNr): longword;
var
  res: longword;
begin
  if ComIsOpen(ComNr) then
    res := ComData[ComNr]^.Errors
  else
    res := 0;
  ComData[ComNr]^.Errors := 0; { clear errors }
  GetComErrors := res;
end;

procedure GetComStatus(ComNr: TComNr; var Stat: TComStat);
begin
  if ComIsOpen(ComNr) then
  begin
    GetErrorAndStatus(ComNr);
    Stat.Flags := ComData[ComNr]^.Stat.Flags;
    Stat.cbInQue := ComData[ComNr]^.Stat.cbInQue;
    Stat.cbOutQue := ComData[ComNr]^.Stat.cbOutQue;
  end;
end;

procedure Initialize;
var
  I: Byte;
begin
  for I := 1 to LastCom do
    ComData[I] := nil;
end;

procedure Finalize;
var
  I: Byte;
begin
  for I := 1 to LastCom do
    if ComIsOpen(I) then
      CloseCom(I);
end;


initialization
  Initialize;

finalization
  Finalize;

end.


