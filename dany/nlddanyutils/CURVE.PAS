unit Curve;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  curvefunc = function(x:real):real;

  TCurveForm = class(TForm)
    procedure FormPaint(Sender: TObject);
   private
    { Private declarations }
     x0_,                 { starting x-value }
     xf_,                 { final x-value }
     y0_,	          { minimal y-value }
     yf_,	          { maximal y-value }
     xd_,                 { coarse x-division }
     xdf_,                { fine x-division}
     yd_,                 { coarse y-division }
     ydf_:real;           { fine y-division }
     nr_values_: word;    { nr of values, 0 is automatic }
     grid_: boolean;      { grid wanted (coarse) }
     cp_: curvefunc;      { function to call }
     procedure draw_(x0,  { starting x-value }
                    xf,                 { final x-value }
                    y0,	                { minimal y-value }
                    yf,	                { maximal y-value }
                    xd,                 { coarse x-division }
                    xdf,                { fine x-division}
                    yd,                 { coarse y-division }
                    ydf:real;           { fine y-division }
                    nr_values: word;    { nr of values, 0 is automatic }
                    grid: boolean;      { grid wanted (coarse) }
                    cp: curvefunc);     { function to call }
   public
    { Public declarations }
    procedure draw_curve(x0,                 { starting x-value }
                         xf,                 { final x-value }
                         y0,	             { minimal y-value }
                         yf,	             { maximal y-value }
                         xd,                 { coarse x-division }
                         xdf,                { fine x-division}
                         yd,                 { coarse y-division }
                         ydf:real;           { fine y-division }
                         nr_values: word;    { nr of values, 0 is automatic }
                         grid: boolean;      { grid wanted (coarse) }
                         cp: curvefunc);     { function to call }
  end;

var
  CurveForm: TCurveForm;


implementation

{$R *.DFM}

const axis_color  = clwhite;
      grid_color  = clDkGray;
      curve_color = clred;
      div_color   = clgreen;
      x_space     = 75;
      y_space     = 50;

procedure TCurveForm.draw_curve
                   (x0,                 { starting x-value }
                    xf,                 { final x-value }
                    y0,	                { minimal y-value }
                    yf,	                { maximal y-value }
                    xd,                 { coarse x-division }
                    xdf,                { fine x-division}
                    yd,                 { coarse y-division }
                    ydf:real;           { fine y-division }
                    nr_values: word;    { nr of values, 0 is automatic }
                    grid: boolean;      { grid wanted (coarse) }
                    cp: curvefunc);     { function to call }
begin
  With CurveForm do begin
    x0_ :=         x0;
    xf_ :=         xf;
    y0_ :=         y0;
    yf_ :=         yf;
    xd_ :=         xd;
    xdf_ :=        xdf;
    yd_ :=         yd;
    ydf_ :=        ydf;
    nr_values_ :=  nr_values;
    grid_ :=       grid;
    cp_  :=        cp;
  end;
end;

procedure TCurveForm.draw_
                    (x0,                 { x starting value }
		     xf,                 { x final value }
		     y0,	         { minimal y-value }
		     yf,                 { maximal y-value }
		     xd,                 { x coarse division }
		     xdf,                { x fine division }
		     yd,                 { y coarse division }
		     ydf:real;           { y fine division }
		     nr_values:word;     { number of values, 0 is automatic }
		     grid: boolean;      { grid on/off }
		     cp: curvefunc);     { curve function }

{ x0 = beginwaarde van x, xf = finale waarde van x }
{ cp = functie die y-waarde geeft ifv x-waarde }

var i, j              : integer;
    dy, dx            : real; { delta y and delta x }
    ymin, ymax        : real; { minimum and maximum Y-value }
    x, stp            : real;
    y		      : real;
    tmp               : real;
    columns, rows     : word;
    y_ratio           : real;
    s                 : string;
    values            : array[0..10000] of real;
    x_dec_places: byte; {x value decimal places }
    y_dec_places: byte; {y value decimal places }

  procedure my_moveto(x, y: integer);
  begin
    y := ClientHeight - y;
    Canvas.MoveTo(x + x_space, y - y_space);
  end;

  procedure my_lineto(x, y: integer);
  begin
    y := ClientHeight - y;
    Canvas.LineTo(x + x_space, y - y_space);
  end;

begin

  Canvas.Pen.Mode := pmCopy;
  Canvas.Pen.Style := psSolid;

{ get the dimensions of the graphics display }

  columns := ClientWidth - (2 * x_space);
  rows    := ClientHeight - (2 * y_space);

 { define the y-value for every usefull x value}
  if (nr_values = 0) then
  begin { number of steps is resolution dependant }
    stp := (xf - x0) / (columns - 1); { x value step }
    x := x0;                          { starting x value }
    i := 0;                           { array index }
    repeat
      values[i] := cp(x);
      inc(i);
      x := x + stp;
    until (i > columns);
    end
  else begin { number of steps is predefined }
    stp := (xf - x0) / (nr_values - 1);
    for i := 0 to (nr_values - 1) do begin
      values[i] := cp(x0 + (i * stp));
    end;
  end;

 { define minimum and maximum Y-values }

 if (y0 = 0) and (yf = 0) { automatic y-scaling }
 then begin
   ymin := values[0]; ymax := values[0];
   if (nr_values = 0) then begin { nr of steps is resolution dependant }
     for i := 1 to (columns) do begin
       if ymax < values[i] then ymax := values[i];
       if ymin > values[i] then ymin := values[i];
     end;
   end
   else begin { nr of steps is predefined }
     for i := 1 to (nr_values - 1) do begin
       if ymax < values[i] then ymax := values[i];
       if ymin > values[i] then ymin := values[i];
     end;
   end;
 end
 else begin { ymin and ymax were predefined }
   ymin := y0;
   ymax := yf;
 end;

{ define vertical ratio between display and values }

  y_ratio := rows / (ymax - ymin);

{ Define delta X (dx, value change per column) and
  delta Y (dy, value change per row).
  Values of zero are not allowed }

  dy := (ymax - ymin) / (rows-1);
    if (dy = 0) then exit;

  dx := (xf - x0) / (columns-1);
    if (dx = 0) then exit;


{ print the Y-axis }

  {get the number of decimals for the y axis }

  str(yd:1:10,s);
  while (length(s) > 1) and (s[length(s)] = '0') do delete(s,length(s),1);
  if pos('.',s) > 0
    then y_dec_places := length(s) - pos('.',s)
    else y_dec_places := 0;

  { print the Y-axis }

  Canvas.Pen.Color := axis_color;
  my_MoveTo (0, 0);
  my_LineTo (0, rows);

  y := ymin;  { display coarse y-scale }
  while (y <= ymax) do begin
    tmp := (y - ymin) / dy;
    my_moveto(-3, round(tmp));
    Canvas.Pen.Color := div_color;
    my_lineto(3, round(tmp));
    if grid and (y <> ymin) then begin
      Canvas.Pen.Color := grid_color;
      my_lineto(columns, round(tmp));
    end;
    Canvas.Pen.Color := axis_color;
    str(y:1:y_dec_places,s);
    my_moveto(-(length(s) * 10), round(tmp) + 3);
    Canvas.TextOut(Canvas.PenPos.X, Canvas.PenPos.Y, s);
    y := y + yd; { y - display step }
  end;

  y := ymin;  { display fine y-scale }
  Canvas.Pen.Color := div_color;
  while (y <= ymax) do begin
    tmp := (y - ymin) /dy;
    my_moveto(-1, round(tmp));
    my_lineto( 1, round(tmp));
    y := y + ydf; { fine y - display step }
  end;

{ print the x-axis }

  {get the number of decimals for the y axis }

  str(xd:1:10,s);
  while (length(s) > 1) and (s[length(s)] = '0') do delete(s,length(s),1);
  if pos('.',s) > 0
    then x_dec_places := length(s) - pos('.',s)
    else x_dec_places := 0;

  { print the X-axis }

  Canvas.Pen.Color := axis_color;
  my_MoveTo (0,0);
  my_LineTo (columns,0);

  x := x0;    { display coarse x - scale}
  while (x <= xf) do begin
    tmp := (x - x0) / dx;
    my_moveto(round(tmp), -3);
    Canvas.Pen.Color := div_color;
    my_lineto(round(tmp), 3);
    Canvas.Pen.Color := axis_color;
    if grid and (x <> x0) then begin
      Canvas.Pen.Color := grid_color;
      my_lineto(round(tmp), rows);
    end;
    Canvas.Pen.Color := axis_color;
    str(x:1:x_dec_places,s);
    my_moveto(round(tmp) - (length(s) * 3), - 7);
    Canvas.TextOut(Canvas.PenPos.X, Canvas.PenPos.Y, s);
    x := x + xd; { coarse x-display step}
  end;

  x := x0;    { display fine x - scale }
  Canvas.Pen.Color := div_color;
  while (x <= xf) do begin
    tmp := (x - x0) / dx;
    my_moveto(round(tmp), -1);
    my_lineto(round(tmp), 1);
    x := x + xdf; { fine x-display step}
  end;


{ print the curve }

  Canvas.Pen.Color := curve_color;

  if (nr_values = 0) then begin { nr of values is resolution dependant }
    my_moveto(0, round((values[0] - ymin) * y_ratio));
    for j := 1 to (columns) do begin
      my_lineTo((j), round((values[j] - ymin) * y_ratio));
    end;
  end
  else begin { nr of values was predefined }
    stp := columns / (nr_values - 1);
    my_moveto(0, round((values[0] - ymin) * y_ratio));
    for j := 1 to (nr_values - 1) do begin
      my_LineTo(round(j * stp), round((values[j] - ymin) * y_ratio));
    end;
  end;

end;

procedure TCurveForm.FormPaint(Sender: TObject);
begin
  draw_(x0_,
        xf_,
        y0_,
        yf_,
        xd_,
        xdf_,
        yd_,
        ydf_,
        nr_values_,
        grid_,
        cp_);
end;

end.


