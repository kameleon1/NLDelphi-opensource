unit Rcs_Resize;

// Kameleon

{ History of this unit:
  11-10-2017: * Initial version
  14-10-2017: * Corrected an error for associated TUpDown components
  30-03-2018: * allow also resize < factor 1
  09-06-2018: * Replaced the conditional compilations by parameters in the create function
  15-06-2018: * Resizing is more linear now (Client sizes used)
  23-06-2018: * "Create" and "Resize" can now have any TControl type to start from
  28-06-2018: * Ingored not found components now (were not existing during creation)
  11-07-2018: * Added the 'MaxFontSize' property
  16-08-2018: * Also adapted the font size of the toplevel
              * Added the 'MinFontSize' property
  30-08-2018: * Changed 'Trunc' to 'Round' in the font resize routine.
  18-09-2018: * TToolbar added
  05-04-2022: * Made TRadiogroup resize correctly (do not try any longer to resize its decendants)
  26-07-2022: * Added SpinButton
  01-08-2022: * Added UpDownAdjust (height with assiciate height)
  09-02-2024: * Skip controls with no name from being taken up in the table
}

{$P+} // Open Strings ON
{$H+} // Long Strings ON

{$IFDEF RELEASE}
{$O+} // Optimisation ON
{$D-} // Debug information OFF
{$I-} // I/O checking OFF
{$L-} // Local Symbols OFF
{$Q-} // Overflow Checking OFF
{$R-} // Range Checking OFF
{$ENDIF}

{$IFDEF DEBUG}
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
  Math;

type
  TDimension = record
    Name: string;
    S, W, H, T, L, D1, D2: integer; // S = font.size
  end;

  TDimensions = array of TDimension;

  TResizeCallbackFunction = function(Control: TControl; VFactor, HFactor: real; L, W, H, T, S, D1, D2: integer): boolean;

type
  TMyResize = class(TObject)
  private
    MyDims: TDimensions;
    HFactor: real;
    VFactor: real;
    FResizeFont: boolean;
    CallbackFunction: TResizeCallbackFunction;
    procedure MyGetDims(Control: TControl; TopLevel: boolean);
    procedure MyChangeDims(Control: TControl; TopLevel: boolean);
  public
    MaxFontSize: integer;
    MinFontSize: integer;
    constructor Create(F: TControl; Fnct: TResizeCallbackFunction = nil; ResizeFont: boolean = false);
    destructor Destroy; override;
    procedure Resize(F: TControl);
  end;

// Classless routines

// Make a list of all objects
procedure GetAllOrgDims_(Control: TControl; var Dims: TDimensions; TopLevel: boolean = true);

// Get the original dimensions of item 'Name'
function GetOrigDims_(Name_: string; Dims: TDimensions; var OldDims: TDimension): boolean;

procedure UpDownAdjust(Control: TControl);

implementation

var
  _Index: integer;

procedure GetAllOrgDims_(Control: TControl; var Dims: TDimensions; TopLevel: boolean = true);
var
  I: integer;
begin

  if trim(Control.Name) = '' then exit; // skip controls with no name

  if TopLevel then _Index := -1;

  inc(_Index);

  SetLength(Dims, _Index + 1);

  // get the dimensions/position of the object

  if (Control is TLabel) then TLabel(Control).AutoSize := true;
  if (Control is TEdit) then TEdit(Control).AutoSize := true;
  if (Control is TLabeledEdit) then TLabeledEdit(Control).AutoSize := true;
  if (Control is TSpinEdit) then TSpinEdit(Control).AutoSize := true;
  if (Control is TMaskEdit) then TMaskEdit(Control).AutoSize := true;
  if (Control is TToolbar) then TToolbar(Control).AutoSize := false;

  Dims[_Index].Name := Control.Name;
  Dims[_Index].S := TEdit(Control).Font.Size;
  Dims[_Index].W := Control.ClientWidth;
  Dims[_Index].H := Control.ClientHeight;
  Dims[_Index].L := Control.Left;
  Dims[_Index].T := Control.Top;
  Dims[_Index].D1 := 0;
  Dims[_Index].D2 := 0;

  if Control is TStringGrid then
  begin
    Dims[_Index].D1 := TStringGrid(Control).DefaultColWidth; // extra dimensions
    Dims[_Index].D2 := TStringGrid(Control).DefaultRowHeight;
  end;

  if Control is TDrawGrid then
  begin
    Dims[_Index].D1 := TDrawGrid(Control).DefaultColWidth; // extra dimensions
    Dims[_Index].D2 := TDrawGrid(Control).DefaultRowHeight;
  end;

  if Control is TToolbar then
  begin
    Dims[_Index].D1 := TToolBar(Control).ButtonWidth; // extra dimensions
    Dims[_Index].D2 := TToolBar(Control).ButtonHeight;
  end;

  if (Control is TWinControl) and
    (not (Control is TRadioGroup)) and
    (not (Control is TToolbar)) and
    (not (Control is TSpinEdit)) and
    (not (Control is TSpinButton)) then
  begin
    for I := 0 to (TWinControl(Control).ControlCount - 1) do
      GetAllOrgDims_(TWinControl(Control).Controls[I], Dims, false);
  end;

end;

function GetOrigDims_(Name_: string; Dims: TDimensions; var OldDims: TDimension): boolean;
var
  I: integer;
begin
  Result := false;
  if trim(Name_) = '' then exit;

  for I := 0 to length(Dims) - 1 do
  begin
    if Lowercase(Name_) = Lowercase(Dims[I].Name) then
    begin
      OldDims.S := Dims[I].S;
      OldDims.W := Dims[I].W;
      OldDims.H := Dims[I].H;
      OldDims.T := Dims[I].T;
      OldDims.L := Dims[I].L;
      OldDims.D1 := Dims[I].D1;
      OldDims.D2 := Dims[I].D2;
      Result := true;
      break; // found
    end;
  end;
end;

procedure UpDownAdjust(Control: TControl);
var I: integer;
    Ud: TUpDown;
begin
  if Control is TUpDown then
  begin
    Ud := Control as TUpDown;
    if Ud.Associate <> nil then Ud.Height := ud.Associate.Height;
  end;

  if (Control is TWinControl) and
    (not (Control is TRadioGroup)) and
    (not (Control is TToolbar)) and
    (not (Control is TSpinEdit)) and
    (not (Control is TSpinButton)) then
  begin
    for I := 0 to (TWinControl(Control).ControlCount - 1) do
      UpDownAdjust(TWinControl(Control).Controls[I]);
  end;
end;

procedure TMyResize.MyGetDims(Control: TControl; TopLevel: boolean);
begin
  GetAllOrgDims_(Control, MyDims, TopLevel);
end;

procedure TMyResize.MyChangeDims(Control: TControl; TopLevel: boolean);
var
  I: integer;
  S, L, T, W, H, D1, D2: integer;
  NewWidth: DWord;
  NewHeight: DWord;
  Tsg: TStringGrid;
  Tdg: TDrawGrid;
  Ttb: TToolbar;
  Found: boolean;
  Factor: real;
  OrigDims: TDimension;

  procedure AdaptFontSize(OldSize: integer);
  begin
    if FResizeFont then // adapt the toplevel fontsize to the new dimensions
    begin
      Factor := Min(VFactor, HFactor);
      S := Round(Factor * OldSize);

      if (MaxFontSize > 0) and (S > MaxFontSize) then S := MaxFontSize;
      if (MinFontSize > 0) and (S < MinFontSize) then S := MinFontSize;

      TEdit(Control).Font.Size := S;
    end;
  end;

begin

  if TopLevel then // toplevel, get the new dimensions
  begin
    NewWidth := Control.ClientWidth;
    NewHeight := Control.ClientHeight;

    HFactor := NewWidth / MyDims[0].W;
    VFactor := NewHeight / MyDims[0].H;

    AdaptFontSize(MyDims[0].S); // adapt also the toplevel font size
  end
  else
  begin

    // find the start dimensions of the control to resize
    Found := GetOrigDims_(Control.Name, MyDims, OrigDims); // get the original dimensions

    if not Found then exit; // start dimensions are not available

    if (not assigned(CallbackFunction)) or
      (CallBackFunction(Control, VFactor, HFactor,
      OrigDims.L, OrigDims.W, OrigDims.H, OrigDims.T
      , OrigDims.S, OrigDims.D1, OrigDims.D2) = false) then
    begin // do the resizing here, else do the resizing in the Callback function

      // calculate new dimensions
      W := Trunc(HFactor * OrigDims.W);
      H := Trunc(VFactor * OrigDims.H);
      L := Trunc(HFactor * OrigDims.L);
      T := Trunc(VFactor * OrigDims.T);
      D1 := Trunc(HFactor * OrigDims.D1);
      D2 := Trunc(VFactor * OrigDims.D2);

      AdaptFontSize(OrigDims.S);

      if (Control is TComboBox) then // special case
      begin
        Control.ClientWidth := W;
        Control.Left := L;
        Control.Top := T;
        TComboBox(Control).ItemHeight := H - 6;
      end

      else
        if ((Control is TLabel) or
        (Control is TEdit) or
        (Control is TLabeledEdit) or
        (Control is TSpinEdit) or
        (Control is TMaskEdit)
        ) then
      begin
          // do not set the sizes here, set 'autosize' to true in the object inspector
        Control.Left := L;
        Control.Top := T;
        if not (Control is TLabel) then Control.ClientWidth := W;
      end

      else
        if Control is TUpDown then
      begin
        if TUpDown(Control).Associate = nil then
        begin
          Control.Left := L;
          Control.Top := T;
          Control.Width := W;
          Control.Height := H;
        end else
        begin
          Control.Left :=
            TUpDown(Control).Associate.Left + TUpDown(Control).Associate.Width;
          Control.Top := TUpDown(Control).Associate.Top;
          Control.Height := TUpDown(Control).Associate.Height;
          Control.Width := W;
        end;
      end

      else
        if Control is TStringGrid then
      begin
        Tsg := Control as TStringGrid;

        Tsg.Left := L;
        Tsg.Top := T;
        Tsg.DefaultColWidth := D1;
        Tsg.DefaultRowHeight := D2;
        Tsg.ClientWidth := W;
        Tsg.ClientHeight := H;
      end

      else
        if Control is TDrawGrid then
      begin
        Tdg := Control as TDrawGrid;

        Tdg.Left := L;
        Tdg.Top := T;
        Tdg.DefaultColWidth := D1;
        Tdg.DefaultRowHeight := D2;
        Tdg.ClientWidth := W;
        Tdg.ClientHeight := H;
      end

      else
        if Control is TToolBar then
      begin
        Ttb := Control as TToolbar;

        Ttb.Left := L;
        Ttb.Top := T;
        Ttb.ClientWidth := W;
        Ttb.ClientHeight := H;
        Ttb.ButtonWidth := D1;
        Ttb.ButtonHeight := D2;
      end

      else
      begin
        Control.Left := L;         // Kameleon v6.2.8
        Control.Top := T;          // Kameleon v6.2.8
        Control.ClientWidth := W;  // Kameleon v6.2.8
        Control.ClientHeight := H; // Kameleon v6.2.8
        //Control.SetBounds(L, T, W, H); // default   // Kameleon v6.2.8
      end;
    end;

  end;

  if (Control is TWinControl) and
    (not (Control is TRadioGroup)) and
    (not (Control is TToolbar)) and
    (not (Control is TSpinEdit)) and
    (not (Control is TSpinButton)) then // resize its descendants
  begin
    for I := 0 to (TWinControl(Control).ControlCount - 1) do
      // process all descendants
    begin
      MyChangeDims(TWinControl(Control).Controls[I], false);
    end;
  end;

end;

constructor TMyResize.Create(F: TControl; Fnct: TResizeCallbackFunction = nil; ResizeFont: boolean = false);
begin
  inherited Create;
  CallbackFunction := Fnct;
  FResizeFont := ResizeFont;
  MyGetDims(F, true); // get the original dimensions
  MaxFontSize := 0;
  MinFontSize := 0;
end;

procedure TMyResize.Resize(F: TControl);
begin
  MyChangeDims(F, true); // do resize of all components
end;

destructor TMyResize.Destroy;
begin
  SetLength(MyDims, 0);
  inherited Destroy;
end;

end.
