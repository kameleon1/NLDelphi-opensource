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

var
  HidCtl: TJvHidDeviceController; // only one devicecontroller needed

procedure HID_Create;
procedure HID_Free;
procedure HID_Enumerate;

function HID_DeviceOpen(var HidDev: TJvHidDevice; const VID, PID: integer): boolean;
procedure HID_DeviceClose(var HidDev: TJvHidDevice);
function HID_DeviceName(HidDev: TJvHidDevice): Widestring;
function HID_SerialNumber(HidDev: TJvHidDevice): Widestring;
function HID_VendorName(HidDev: TJvHidDevice): Widestring;
function HID_Write(var HidDev: TJvHidDevice; var Buf: THIDReportBuff): byte; // Buf[0] := ReportId;
procedure HID_GetReport(var HidDev: TJvHidDevice; var Buf: THIDReportBuff); // Buf[0] := ReportId;
procedure HID_SetReport(var HidDev: TJvHidDevice; var Buf: THIDReportBuff); // Buf[0] := ReportId;
procedure HID_GetFeature(var HidDev: TJvHidDevice; var Buf: THIDReportBuff); // Buf[0] := ReportId;
procedure HID_SetFeature(var HidDev: TJvHidDevice; var Buf: THIDReportBuff); // Buf[0] := ReportId;
function HID_InputReportSize(var HidDev: TJvHidDevice): byte;
function HID_OutputReportSize(var HidDev: TJvHidDevice): byte;
Function HID_FeatureReportSize(var HidDev: TJvHidDevice): byte;
function HID_ReadWriteAccess(var HidDev: TJvHidDevice): boolean;
function HID_CheckedOut(var HidDev: TJvHidDevice): boolean;
function HID_PluggedIn(var HidDev: TJvHidDevice): boolean;
function HID_DeviceString(var HidDev: TJvHidDevice; Idx: byte): WideString;
function HID_DeviceVersion(var HidDev: TJvHidDevice): word;

implementation



procedure HID_Create;
begin
  if not assigned(HidCtl) then HidCtl := TJvHidDeviceController.Create(nil);
end;

procedure HID_Free;
begin
  HidCtl.Free;
end;

procedure HID_Enumerate;
begin
  if assigned(HidCtl) then HidCtl.Enumerate;
end;

function HID_DeviceOpen(var HidDev: TJvHidDevice; const VID, PID: integer): boolean;
begin
  Result := false;
  if not assigned(HidDev) then Result := HidCtl.CheckOutByID(HidDev, VID, PID);
end;

procedure HID_DeviceClose(var HidDev: TJvHidDevice);
begin
  if assigned(HidDev) then HidCtl.CheckIn(HidDev);
end;

function HID_DeviceName(HidDev: TJvHidDevice): Widestring;
begin
  Result := HidDev.ProductName;
end;

function HID_SerialNumber(HidDev: TJvHidDevice): Widestring;
begin
  Result := HidDev.SerialNumber;
end;

function HID_VendorName(HidDev: TJvHidDevice): Widestring;
begin
  Result := HidDev.VendorName;
end;

function HID_Write(var HidDev: TJvHidDevice; var Buf: THIDReportBuff): byte; // Buf[0] := ReportId;
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

procedure HID_GetReport(var HidDev: TJvHidDevice; var Buf: THIDReportBuff); // Buf[0] := ReportId;
begin
  if assigned(HidDev) then
  begin
    FillChar(Buf[0], SizeOf(Buf), 0); // clear buffer
    HidDev.GetInputReport(Buf[0], SizeOf(Buf));
  end;
end;

procedure HID_SetReport(var HidDev: TJvHidDevice; var Buf: THIDReportBuff); // Buf[0] := ReportId;
begin
  if assigned(HidDev) then
  begin
    HidDev.SetOutputReport(Buf[0], HidDev.Caps.OutputReportByteLength);
  end;
end;

procedure HID_GetFeature(var HidDev: TJvHidDevice; var Buf: THIDReportBuff); // Buf[0] := ReportId;
begin
  if assigned(HidDev) then
  begin
    HidDev.GetFeature(Buf[0], HidDev.Caps.FeatureReportByteLength);
  end;
end;

procedure HID_SetFeature(var HidDev: TJvHidDevice; var Buf: THIDReportBuff); // Buf[0] := ReportId;
begin
  if assigned(HidDev) then
  begin
    HidDev.SetFeature(Buf[0], HidDev.Caps.FeatureReportByteLength);
  end;
end;

function HID_InputReportSize(var HidDev: TJvHidDevice): byte;
begin
  Result := 0;
  if assigned(HidDev) then Result := HidDev.Caps.InputReportByteLength;
end;

function HID_OutputReportSize(var HidDev: TJvHidDevice): byte;
begin
  Result := 0;
  if assigned(HidDev) then Result := HidDev.Caps.OutputReportByteLength;
end;

function HID_FeatureReportSize(var HidDev: TJvHidDevice): byte;
begin
  Result := 0;
  if assigned(HidDev) then Result := HidDev.Caps.FeatureReportByteLength;
end;

function HID_ReadWriteAccess(var HidDev: TJvHidDevice): boolean;
begin
  Result := false;
  if assigned(HidDev) then Result := HidDev.HasReadWriteAccess;
end;

function HID_CheckedOut(var HidDev: TJvHidDevice): boolean;
begin
  Result := false;
  if assigned(HidDev) then Result := HidDev.IsCheckedOut;
end;

function HID_PluggedIn(var HidDev: TJvHidDevice): boolean;
begin
  Result := false;
  if assigned(HidDev) then Result := HidDev.IsPluggedIn;
end;

function HID_DeviceString(var HidDev: TJvHidDevice; Idx: byte): WideString;
begin
  Result := '';
  if assigned(HidDev) then Result := HidDev.DeviceStrings[Idx];
end;

function HID_DeviceVersion(var HidDev: TJvHidDevice): word;
begin
  Result := 0;
  if assigned(HidDev) then Result := HidDev.Attributes.VersionNumber;
end;

begin
  HidCtl := nil;

end.
