unit RcsSimpleHID;

// Dany Rosseel

{ History of this unit
  16-01-2009: * Initial version.
}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  SysUtils,
  Classes,
  JvHidControllerClass;

type
  THIDReportBuff = array[0..64] of byte; // max size
  THID_Device = TJvHidDevice;

  TEnumerateProc    = function  (HidDev: TJvHidDevice; const Idx: Integer): Boolean of object;
  TDeviceChangeProc = procedure (Sender: TObject) of object;
  TOnDataProc       = procedure (HidDev: THID_Device; ReportID: Byte; const Data: Pointer; Size: Word) of object;

var
  HidCtl: TJvHidDeviceController; // only one devicecontroller needed
  HIDDev: THID_Device;

procedure HID_Create(EnumerateProc: TEnumerateProc; DeviceChangeProc: TDeviceChangeProc; OnDataProc: TOnDataProc);
procedure HID_Free;
procedure HID_Enumerate;

function HID_DeviceOpen(const VID, PID: integer): boolean;
function HID_DeviceIsOpen: boolean;
procedure HID_DeviceClose;
function HID_DeviceName: Widestring;
function HID_SerialNumber: Widestring;
function HID_VendorName: Widestring;
function HID_Write(var Buf: THIDReportBuff): byte; // Buf[0] := ReportId;
procedure HID_GetReport(var Buf: THIDReportBuff); // Buf[0] := ReportId;
procedure HID_SetReport(var Buf: THIDReportBuff); // Buf[0] := ReportId;
procedure HID_GetFeature(var Buf: THIDReportBuff); // Buf[0] := ReportId;
procedure HID_SetFeature(var Buf: THIDReportBuff); // Buf[0] := ReportId;
function HID_InputReportSize: byte;
function HID_OutputReportSize: byte;
Function HID_FeatureReportSize: byte;
function HID_ReadWriteAccess: boolean;
function HID_CheckedOut: boolean;
function HID_PluggedIn: boolean;
function HID_DeviceString(Idx: byte): WideString;
function HID_DeviceVersion: word;

implementation

var OnDataProcedure : TOnDataProc;


procedure HID_Create(EnumerateProc: TEnumerateProc; DeviceChangeProc: TDeviceChangeProc; OnDataProc: TOnDataProc);
begin
  HIDDev := nil;
  if not assigned(HidCtl) then HidCtl := TJvHidDeviceController.Create(nil);
  HIDCtl.OnEnumerate := EnumerateProc;
  HIDCtl.OnDeviceChange := DeviceChangeProc;
  OnDataProcedure := OnDataProc;
end;

procedure HID_Free;
begin
  HIDDev.Free;
  HidCtl.Free;
end;

procedure HID_Enumerate;
begin
  if assigned(HidCtl) then HidCtl.Enumerate;
end;

function HID_DeviceOpen(const VID, PID: integer): boolean;
begin
  Result := false;
  if not assigned(HidDev) then
  begin
    Result := HidCtl.CheckOutByID(HidDev, VID, PID);
    if Result then HIDDev.OnData := OnDataProcedure; // "Device.OnData" will be called when the device received data
  end;
end;

function HID_DeviceIsOpen: boolean;
begin
  Result := assigned(HidDev);
end;

procedure HID_DeviceClose;
begin
  if assigned(HidDev) then
  begin
    HIDDev.OnData := nil;
    HidCtl.CheckIn(HidDev);
  end;
end;

function HID_DeviceName: Widestring;
begin
  Result := HidDev.ProductName;
end;

function HID_SerialNumber: Widestring;
begin
  Result := HidDev.SerialNumber;
end;

function HID_VendorName: Widestring;
begin
  Result := HidDev.VendorName;
end;

function HID_Write(var Buf: THIDReportBuff): byte; // Buf[0] := ReportId;
var
  Written: Cardinal;
begin
  Written := 0;
  if assigned(HidDev) then
  begin
    HidDev.WriteFile(Buf, HidDev.Caps.OutputReportByteLength, Written);
  end;
  Result := Written;
end;

procedure HID_GetReport(var Buf: THIDReportBuff); // Buf[0] := ReportId;
begin
  if assigned(HidDev) then
  begin
    FillChar(Buf[0], SizeOf(Buf), 0); // clear buffer
    HidDev.GetInputReport(Buf[0], SizeOf(Buf));
  end;
end;

procedure HID_SetReport(var Buf: THIDReportBuff); // Buf[0] := ReportId;
begin
  if assigned(HidDev) then
  begin
    HidDev.SetOutputReport(Buf[0], HidDev.Caps.OutputReportByteLength);
  end;
end;

procedure HID_GetFeature(var Buf: THIDReportBuff); // Buf[0] := ReportId;
begin
  if assigned(HidDev) then
  begin
    HidDev.GetFeature(Buf[0], HidDev.Caps.FeatureReportByteLength);
  end;
end;

procedure HID_SetFeature(var Buf: THIDReportBuff); // Buf[0] := ReportId;
begin
  if assigned(HidDev) then
  begin
    HidDev.SetFeature(Buf[0], HidDev.Caps.FeatureReportByteLength);
  end;
end;

function HID_InputReportSize: byte;
begin
  Result := 0;
  if assigned(HidDev) then Result := HidDev.Caps.InputReportByteLength;
end;

function HID_OutputReportSize: byte;
begin
  Result := 0;
  if assigned(HidDev) then Result := HidDev.Caps.OutputReportByteLength;
end;

function HID_FeatureReportSize: byte;
begin
  Result := 0;
  if assigned(HidDev) then Result := HidDev.Caps.FeatureReportByteLength;
end;

function HID_ReadWriteAccess: boolean;
begin
  Result := false;
  if assigned(HidDev) then Result := HidDev.HasReadWriteAccess;
end;

function HID_CheckedOut: boolean;
begin
  Result := false;
  if assigned(HidDev) then Result := HidDev.IsCheckedOut;
end;

function HID_PluggedIn: boolean;
begin
  Result := false;
  if assigned(HidDev) then Result := HidDev.IsPluggedIn;
end;

function HID_DeviceString(Idx: byte): WideString;
begin
  Result := '';
  if assigned(HidDev) then Result := HidDev.DeviceStrings[Idx];
end;

function HID_DeviceVersion: word;
begin
  Result := 0;
  if assigned(HidDev) then Result := HidDev.Attributes.VersionNumber;
end;

begin
  HidCtl := nil;
  OnDataProcedure := nil;
end.
