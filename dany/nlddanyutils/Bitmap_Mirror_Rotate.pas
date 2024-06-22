Unit Bitmap_Mirror_Rotate;

    interface
     
    uses
      Windows, Graphics;
     
    procedure FlipBitmap(Source, Dest: TBitmap);
    procedure MirrorBitmap(Source, Dest: TBitmap);
    procedure MirrorBitmapHorz(Source, Dest: TBitmap);
    procedure MirrorBitmapVert(Source, Dest: TBitmap);
    procedure RotateBitmap90(Source, Dest: TBitmap);
    procedure RotateBitmap180(Source, Dest: TBitmap);
    procedure RotateBitmap270(Source, Dest: TBitmap);
    procedure TumbleBitmapLeft(Source, Dest: TBitmap);
    procedure TumbleBitmapRight(Source, Dest: TBitmap);
    procedure TurnBitmap(Source, Dest: TBitmap);
     
    implementation
     
    procedure FlipBitmap(Source, Dest: TBitmap);
    begin
      MirrorBitmapVert(Source, Dest);
    end;
     
    procedure MirrorBitmap(Source, Dest: TBitmap);
    begin
      MirrorBitmapHorz(Source, Dest);
    end;
     
    procedure MirrorBitmapHorz(Source, Dest: TBitmap);
    var
      Points: array[0..2] of TPoint;
    begin
      if (Source <> nil) and (Dest <> nil) then
        with Source, Canvas do
        begin
          Dest.Width := Width;
          Dest.Height := Height;
          Points[0].X := Width - 1;
          Points[0].Y := 0;
          Points[1].X := -1;
          Points[1].Y := 0;
          Points[2].X := Width - 1;
          Points[2].Y := Height;
          PlgBlt(Dest.Canvas.Handle, Points, Handle, 0, 0, Width, Height, 0, 0, 0);
          Dest.Modified := True;
        end;
    end;
     
    procedure MirrorBitmapVert(Source, Dest: TBitmap);
    var
      Points: array[0..2] of TPoint;
    begin
      if (Source <> nil) and (Dest <> nil) then
        with Source, Canvas do
        begin
          Dest.Width := Width;
          Dest.Height := Height;
          Points[0].X := 0;
          Points[0].Y := Height - 1;
          Points[1].X := Width;
          Points[1].Y := Height - 1;
          Points[2].X := 0;
          Points[2].Y := -1;
          PlgBlt(Dest.Canvas.Handle, Points, Handle, 0, 0, Width, Height, 0, 0, 0);
          Dest.Modified := True;
        end;
    end;
     
    procedure RotateBitmap90(Source, Dest: TBitmap);
    var
      Points: array[0..2] of TPoint;
    begin
      if (Source <> nil) and (Dest <> nil) then
        with Source, Canvas do
        begin
          Dest.Width := Height;
          Dest.Height := Width;
          Points[0].X := 0;
          Points[0].Y := Width;
          Points[1].X := 0;
          Points[1].Y := 0;
          Points[2].X := Height;
          Points[2].Y := Width;
          PlgBlt(Dest.Canvas.Handle, Points, Handle, 0, 0, Width, Height, 0, 0, 0);
          Dest.Modified := True;
        end;
    end;
     
    procedure RotateBitmap180(Source, Dest: TBitmap);
    var
      Points: array[0..2] of TPoint;
    begin
      if (Source <> nil) and (Dest <> nil) then
        with Source, Canvas do
        begin
          Dest.Width := Width;
          Dest.Height := Height;
          Points[0].X := Width - 1;
          Points[0].Y := Height - 1;
          Points[1].X := -1;
          Points[1].Y := Height - 1;
          Points[2].X := Width - 1;
          Points[2].Y := -1;
          PlgBlt(Dest.Canvas.Handle, Points, Handle, 0, 0, Width, Height, 0, 0, 0);
          Dest.Modified := True;
        end;
    end;
     
    procedure RotateBitmap270(Source, Dest: TBitmap);
    var
      Points: array[0..2] of TPoint;
    begin
      if (Source <> nil) and (Dest <> nil) then
        with Source, Canvas do
        begin
          Dest.Width := Height;
          Dest.Height := Width;
          Points[0].X := Height;
          Points[0].Y := 0;
          Points[1].X := Height;
          Points[1].Y := Width;
          Points[2].X := 0;
          Points[2].Y := 0;
          PlgBlt(Dest.Canvas.Handle, Points, Handle, 0, 0, Width, Height, 0, 0, 0);
          Dest.Modified := True;
        end;
    end;
     
    procedure TumbleBitmapLeft(Source, Dest: TBitmap);
    begin
      RotateBitmap90(Source, Dest);
    end;
     
    procedure TumbleBitmapRight(Source, Dest: TBitmap);
    begin
      RotateBitmap270(Source, Dest);
    end;
     
    procedure TurnBitmap(Source, Dest: TBitmap);
    begin
      RotateBitmap180(Source, Dest);
    end;
end.