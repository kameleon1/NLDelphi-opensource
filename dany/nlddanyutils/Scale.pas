unit Scale;

interface

uses
  Vcl.Forms, Math,
  System.Types;    // Kameleon v6.2.6

var // used variables for test purposes
  DevPixelsPerInch: integer; // values of the development system
  DevScreenWidth: integer;
  DevScreenHeight: integer;

  AllowNegativeFormCoordinates: boolean;

type
  Scale_perc = record
    V, H: integer;
  end;

function ScreenScalePercentages: Scale_Perc;
procedure ScaleFormTo(F: TForm; Mult_, Div_: integer);
procedure ResizeFormTo(F: TForm; Mult_, Div_: integer);
procedure ScaleFormToScreenSize(F: TForm);
procedure SetLimitedBounds(F: TForm; L, T, W, H: integer); // Limit the boundaries of a form to the WorkArea boundaries
procedure LimitSizes(F: TForm);

implementation

// Development system Values
const
  // actual values of the development screen
  DevPixelsPerInch_ = 96;
  DevScreenWidth_ = 1920;
  DevScreenHeight_ = 1080;

procedure ResizeFormTo(F: TForm; Mult_, Div_: integer); // dit werkt beter, samen met Rcs_resize.
begin
  F.SetBounds(F.Left, F.Top, Mult_ * F.Width div Div_, F.Height * Mult_ div div_); // <--- en dit
end;

procedure ScaleFormTo(F: TForm; Mult_, Div_: integer); // werkt niet zo goed (Scaleby werkt niet zo goed)
begin
  // scale the form
  ResizeFormTo(F, Mult_, Div_);

  // scale the controls within it
  F.Scaleby(Mult_, Div_);
end;

function ScreenScalePercentages: Scale_Perc;
begin
  Result.H := round(100 * Screen.Width / DevScreenWidth);
  Result.V := round(100 * Screen.Height / DevScreenHeight);
end;

procedure ScaleFormToScreenSize(F: TForm);
begin
   ScaleFormTo(F, min(ScreenScalePercentages.H, ScreenScalePercentages.V),100);
end;



{
procedure ScaleFormToScreenSize(F: TForm); // werkt niet zo goed (Scaleby werkt niet zo goed)
var
  Ratio: Scale_Perc;
  MyRatio: integer;
begin
  Ratio := ScreenScalePercentages;

  if Ratio.H < Ratio.V
  then MyRatio := Ratio.H
  else myRatio := Ratio.V;

  ScaleFormTo(F, MyRatio, 100);
end;
}

procedure SetLimitedBounds(F: TForm; L, T, W, H: integer);
var Rect: TRect;
begin

  // Kameleon v6.2.6
  F.SetBounds(L, T, W, H);

  if not AllowNegativeFormCoordinates then
  begin
    Rect := F.Monitor.WorkAreaRect;

    if T < Rect.Top
    then T := Rect.Top;

    if L < Rect.Left
    then L := Rect.Left;

    F.SetBounds(L, T, W, H);
  end;
  // end Kameleon v6.2.6

end;

procedure LimitSizes(F: TForm);
begin
  SetLimitedBounds(F, F.Left, F.Top, F.Width, F.Height);
end;

begin
  DevPixelsPerInch := DevPixelsPerInch_;
  DevScreenWidth := DevScreenWidth_;
  DevScreenHeight := DevScreenHeight_;

  AllowNegativeFormCoordinates := false;
end.
