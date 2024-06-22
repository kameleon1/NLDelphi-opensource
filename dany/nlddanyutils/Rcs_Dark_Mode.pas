unit Rcs_Dark_Mode;

// Kameleon

{-$DEFINE NoDebug}// Disable debug possibilities and range checking (= faster)
// {.$Define NoDebug}: During debugging
// {$Define NoDebug} : During "normal" use

{ History of this unit:
  31-07-2023: * Initial version
}

{$P+} // Open Strings ON
{$H+} // Long Strings ON

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

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  Dialogs,
  Controls,
  StdCtrls,
  Buttons,
  ExtCtrls,
  ComCtrls,
  Mask,
  Grids,
  Spin,
  Math,
  VirtualTrees,
  MyColors;

type
  TColor_ = record
    Name: string;
    Color, FontColor, FixedColor: TColor;
  end;

  TColors = array of TColor_;

  TDarkModeCallbackFunction = function(Control: TControl; Color_, FontColor: TColor; DarkMode: boolean): boolean;

type
  TMyDarkMode = class(TObject)
  private
    _Index: integer;
    MyCols: TColors;
    DarkMode: boolean;
    CallbackFunction: TDarkModeCallbackFunction;
    procedure MyChangeColors(Control: TControl);
    function GetOrigColors_(Name_: string; var OrigCols: TColor_): boolean;
  public
    //MyCols: TColors;
    constructor Create(F: TControl; Fnct: TDarkModeCallbackFunction = nil);
    destructor Destroy; override;
    //procedure MyClearColors;    // Kameleon v6.2.9
    procedure MyGetColors(Control: TControl; TopLevel: boolean); // Kameleon v6.2.9
    procedure SetDarkMode(F: TControl; Mode: boolean);
  end;

implementation

function NoColor(Control: TControl): boolean;
begin
  Result := false;

  if (Control is TSpeedbutton) then
  begin // no 'Color'
    Result := true;
    (Control as TSpeedButton).ParentFont := false;
    exit;
  end;

  if (Control is TButton) then
  begin // no 'Color'
    Result := true;
    (Control as TButton).ParentFont := false;
    exit;
  end;

  if (Control is TBitBtn) then
  begin // no 'Color'
    Result := true;
    (Control as TBitBtn).ParentFont := false;
    exit;
  end;

  if (control is TToolButton) then
  begin
    Result := true;
    exit;
  end;

   if (Control is TStatusBar) then  // Kameleon v6.2.11, statusbar behaves bad when inverted (text not visible any more)
  begin
    Result := true;
    exit;
  end;
end;

// Get the original colors of item 'Name'

function TMyDarkMode.GetOrigColors_(Name_: string; var OrigCols: TColor_): boolean;
var
  I: integer;
begin
  Result := false;
  for I := 0 to length(MyCols) - 1 do
  begin
    if Lowercase(Name_) = Lowercase(MyCols[I].Name) then
    begin
      OrigCols.Color := MyCols[I].Color;
      OrigCols.FontColor := MyCols[I].FontColor;
      OrigCols.FixedColor := MyCols[I].FixedColor;
      Result := true;
      break; // found
    end;
  end;
end;

{$DEFINE REPLACE_SYSTEM_COLOURS}
procedure TMyDarkMode.MyGetColors(Control: TControl; TopLevel: boolean);
var
  I: integer;
begin
  if TopLevel then _Index := -1;

  if NoColor(Control)
    then exit;

  inc(_Index);

  SetLength(MyCols, _Index + 1);

  MyCols[_Index].Name := Control.Name;
  MyCols[_Index].Color := TEdit(Control).Color;
  MyCols[_Index].FontColor := TEdit(Control).Font.Color;
  if Control is TStringgrid then MyCols[_Index].FixedColor := TStringgrid(Control).FixedColor;

  {$IFDEF REPLACE_SYSTEM_COLOURS}
   TEdit(Control).Color := ReplaceSystemColor(TEdit(Control).Color);
   TEdit(Control).Font.Color := ReplaceSystemColor(TEdit(Control).Font.Color);
   if Control is TStringgrid then TStringgrid(Control).FixedColor := ReplaceSystemColor(TStringgrid(Control).FixedColor);
  {$ENDIF}

  if (Control is TWinControl) and
    (not (Control is TRadioGroup)) and
    (not (Control is TToolbar)) and
    (not (Control is TSpinEdit)) and
    (not (Control is TSpinButton)) then
  begin
    for I := 0 to (TWinControl(Control).ControlCount - 1) do
      MyGetColors(TWinControl(Control).Controls[I], false);
  end;
end;

{
procedure TMyDarkMode.MyClearColors;
begin
  SetLength(MyCols, 0);
end;
}

procedure TMyDarkMode.MyChangeColors(Control: TControl);
var
  I: integer;
  Found: boolean;
  OrigCols: Tcolor_;
  Strg: TStringgrid;
begin

  if NoColor(Control)
    then exit;

  // find the start colors of the control to handle
  Found := GetOrigColors_(Control.Name, OrigCols); // get the original colors

  if not Found then exit; // start colors are not available

  if (not assigned(CallbackFunction)) or
    (CallBackFunction(Control, OrigCols.Color, OrigCols.FontColor, DarkMode) = false) then
  begin // do the processing here, else do the processing in the Callback function

    if Control is TStringGrid then
    begin
      Strg := TStringGrid(Control);
      if not DarkMode // normal
      then
      begin
        Strg.Color := OrigCols.Color;
        Strg.Font.Color := OrigCols.FontColor;
        Strg.FixedColor := OrigCols.FixedColor;
      end
      else
      begin
        Strg.Font.Color := OrigCols.Color;
        Strg.Color := OrigCols.FontColor;
        Strg.FixedColor := OrigCols.FontColor;
      end;
    end
    else

    begin // default
      if not DarkMode // normal
      then
      begin
        TEdit(Control).Color := OrigCols.Color;
        TEdit(Control).Font.Color := OrigCols.FontColor;
      end
      else
      begin
        TEdit(Control).Font.Color := OrigCols.Color;
        TEdit(Control).Color := OrigCols.FontColor;
      end;
    end;

  end;

  if (Control is TWinControl) and
    (not (Control is TRadioGroup)) and
    (not (Control is TToolbar)) and
    (not (Control is TSpinEdit)) and
    (not (Control is TSpinButton))
    then
  begin
    for I := 0 to (TWinControl(Control).ControlCount - 1) do
      // process all descendants
    begin
      MyChangeColors(TWinControl(Control).Controls[I]);
    end;
  end;

end;

constructor TMyDarkMode.Create(F: TControl; Fnct: TDarkModeCallbackFunction = nil);
begin
  inherited Create;
  CallbackFunction := Fnct;
  MyGetColors(F, true); // get the original colors
end;

procedure TMyDarkMode.SetDarkMode(F: TControl; Mode: boolean);
begin
  DarkMode := Mode;
  MyChangeColors(F);
end;

destructor TMyDarkMode.Destroy;
begin
  SetLength(MyCols, 0);
  inherited Destroy;
end;

end.
