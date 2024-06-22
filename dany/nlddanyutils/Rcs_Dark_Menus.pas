unit Rcs_Dark_Menus;

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
  Menus,
  UITypes;


{$IFDEF DARKMENUS}
type TMyDarkMenus = class(TComponent)
  private
    DarkMode: boolean;
    Active: boolean;
    procedure MenuItemSetEvents(Item: TMenuItem);
  protected
    procedure _OnMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure _OnDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: boolean);
    procedure _OnAdvancedDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetDarkMenu(Menu: TMainMenu; Value: boolean); overload;
    procedure SetDarkMenu(Menu: TPopUpMenu; Value: boolean); overload;
    procedure SetActive(Value: boolean); // defines if mymenus will be used or not. Darkmode is not possible if not active...
  end;
{$ENDIF}

implementation

{$IFDEF DARKMENUS}
// --------------------------------------------------------------------------------//
//                   Dark Menus                                                    //
// --------------------------------------------------------------------------------//

// Kameleon v6.2.13

constructor TMyDarkMenus.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Active := true;
  // ....
end;

destructor TMyDarkMenus.Destroy;
begin
  // ...
  inherited Destroy;
end;

procedure TMyDarkMenus.SetActive(Value: boolean);
begin
  Active := Value;
end;

procedure TMyDarkMenus.MenuItemSetEvents(Item: TMenuItem);
var I: integer;
begin
  if Active then
  begin
    Item.OnDrawItem := _OnDrawItem;
    Item.OnAdvancedDrawItem := _OnAdvancedDrawItem;
    Item.OnMeasureItem := _OnMeasureItem;
  end else
  begin
    Item.OnDrawItem := nil;
    Item.OnAdvancedDrawItem := nil;
    Item.OnMeasureItem := nil;
  end;

  for I := 0 to Item.Count - 1 do MenuItemSetEvents(Item.Items[I]);
end;

procedure TMyDarkMenus.SetDarkMenu(Menu: TMainMenu; Value: boolean);
var I: Integer;
  Item: TMenuItem;
begin
  DarkMode := Value;

  Menu.OwnerDraw := Value;
  for I := 0 to Menu.Items.Count - 1 do MenuItemSetEvents(Menu.Items[I]);

  // make sure the menu looks adapted  // Kameleon v6.2.13
  Item := TmenuItem.Create(Menu);
  Menu.Items.Insert(0, Item);
  Menu.Items.Delete(0);
  Item.Free;

  for I := 0 to Menu.Items.Count - 1 do
  begin
    Item := TmenuItem.Create(Menu);
    Menu.Items[I].Insert(0, Item);
    Menu.Items[I].Delete(0);
    Item.Free;
  end;
end;

procedure TMyDarkMenus.SetDarkMenu(Menu: TPopUpMenu; Value: boolean);
var I: Integer;
  Item: TMenuItem;
begin
  DarkMode := Value;

  Menu.OwnerDraw := true;
  for I := 0 to Menu.Items.Count - 1 do MenuItemSetEvents(Menu.Items[I]);

  // make sure the menu looks adapted  // Kameleon v6.2.13
  Item := TmenuItem.Create(Menu);
  Menu.Items.Insert(0, Item);
  Menu.Items.Delete(0);
  Item.Free;
end;


procedure TMyDarkMenus._OnMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
var W: integer;
  ITem: TMenuItem;
  TopLevel: boolean;
begin
  if not (Sender is TMenuItem) then exit;

  Item := Sender as TMenuItem;
  TopLevel := Item.GetParentComponent is TMainMenu;

  W := ACanvas.TextWidth(StringReplace(Item.Caption, '&', '', [rfReplaceAll]));
  Width := max(Acanvas.TextWidth('W') + 7, 25) + W; // always an image (or check sign) taken into account, //Kameleon v6.2.13

  if (not TopLevel) then
  begin
    if (Item.Count = 0) then // shortcut must be shown
    begin
      W := ACanvas.TextWidth(ShortCutToText(Item.shortcut));
      Width := Width + W;
    end else
    begin
      Width := Width + max(Acanvas.TextWidth('W') + 7, 25); // place for the right arrow , Kameleon v6.2.13, function name changed
    end;
  end;

  Width := Width + 10; // space, Kameleon v6.2.13

  if item.Caption <> '-' // Kameleon v6.2.13
  then Height := max(Acanvas.TextHeight(Item.Caption), Acanvas.TextHeight(ShortCutToText(Item.ShortCut))) + 10; // Kameleon v6.2.13
end;

procedure TMyDarkMenus._OnAdvancedDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
begin
  // pop the HDC state that TForm saved...
  RestoreDC(ACanvas.Handle, -1);

  // Prevent the OS from drawing the arrow...
  ExcludeClipRect(ACanvas.Handle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom); // Kameleon v6.2.13 , also in non darkmode now

  // save the new state so TForm will restore it...
  SaveDC(ACanvas.Handle);
end;

procedure TMyDarkMenus._OnDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: boolean);
var
  _Caption, _Shortcut, _Symbol: string;
  Item: TMenuItem;
  Parent: TMenu;
  Bmp: TBitMap;
  Myrect: TRect;
  L2, MyRect_Right: integer; // Kameleon v6.2.13, iTopPos deleted
  TopLevel: boolean;
  Vertoffset: integer;

  // added Kameleon v6.2.13

  procedure MakeBitMapGray;
  var x, y: integer;

    function ColorGray(Clr: TColor): TColor;
    var
      r, g, b, avg: integer;
    begin
      Clr := ColorToRGB(clr);
      r := (Clr and $000000FF);
      g := (Clr and $0000FF00) shr 8;
      b := (Clr and $00FF0000) shr 16;

      Avg := (r + g + b) div 3;

      if Avg > 240 then Avg := 240;
      Result := RGB(Avg, Avg, Avg);
    end;

  begin
    for y := 0 to Bmp.Height - 1 do
      for x := 0 to Bmp.Width - 1 do
        Bmp.Canvas.Pixels[x, y] := ColorGray(Bmp.Canvas.Pixels[x, y]);
  end;
  // end added Kameleon v6.2.13

begin
  Item := Sender as TMenuItem;
  TopLevel := Item.GetParentComponent is TMainMenu;
  Parent := Item.GetParentMenu;

  _Caption := StringReplace(Item.Caption, '&', '', [rfReplaceAll]);
  _ShortCut := ShortCutToText(Item.shortcut);

  with ACanvas do
  begin

    if (not DarkMode) then
    begin
      Brush.Color := clbtnFace;
      Font.Color := clWindowText;
      Pen.Color := clWindowtext;
    end else
    begin
      Brush.Color := clWindowText;
      Font.Color := clBtnFace;
      Pen.Color := clBtnFace;
    end;

    if Selected then
    begin
      if not DarkMode
        then Brush.Color := clMenuHighLight
      else Brush.Color := clblue;
    end;

    if not (Item.Enabled) then
      Font.Color := clGray; // "

    FillRect(ARect); // background

    MyRect := ARect;

    if (not TopLevel) and (Item.Count > 0) then
      Myrect.Width := MyRect.Width - max(ACanvas.TextWidth(char($27A4)), 25); // make place for the arrow, Kameleon v6.2.13

    MyRect_Right := MyRect.Left + Myrect.Width;

    if (not TopLevel) and (_Caption = '-') then
    begin
      MoveTo(MyRect.left + 20, MyRect.Top + 3);
      LineTo(MyRect_Right - 5, MyRect.Top + 3);
    end
    else

    begin

      if (not TopLevel) and Item.Checked then // checked, has precedence here
      begin
        _Symbol := char($2714); // Kameleon v6.2.13, simplified
        VertOffset := (Arect.Bottom - ARect.Top - ACanvas.TextHeight(_Symbol)) div 2;
        TextOut(MyRect.Left + 5, Arect.Top + VertOffset, _Symbol);
      end

      else // check for image
      begin
        if (Assigned(Parent.Images)) and (Item.ImageIndex > -1) then // image
        begin
          Bmp := TBitmap.Create;
          if Parent.Images.GetBitmap(Item.ImageIndex, Bmp) then
          begin
            CopyMode := cmSrcCopy;
            if not Item.Enabled // Kameleon v6.2.13
            then MakeBitMapGray; // Kameleon v6.2.13
            Bmp.Transparent := True; // Kameleon v6.2.13
            VertOffset := (Arect.Bottom - ARect.Top - Bmp.Height) div 2;
            Draw(ARect.left + 3, ARect.Top + VertOffset, Bmp);
          end;
          Bmp.Free;
        end;
      end;

      if Item.Default then ACanvas.Font.Style := ACanvas.Font.Style + [fsBold]; // Kameleon v6.2.13

      VertOffset := (Arect.Bottom - ARect.Top - Acanvas.TextHeight(_Caption + _ShortCut)) div 2;

      TextOut(Arect.Left + Acanvas.TextWidth('W') + 15, ARect.Top + VertOffset, _Caption); // caption, Kameleon v6.2.13
      ACanvas.Font.Style := ACanvas.Font.Style - [fsBold]; // Kameleon v6.2.13

      if not TopLevel then
      begin
        if (Item.Count = 0) and (_ShortCut > '') then // show the shortcut
        begin
          L2 := ACanvas.TextExtent(_Shortcut).cx;
          TextOut(MyRect_Right - L2 - 5, ARect.Top + VertOffset, _Shortcut); // shortcut
        end;

        if (Item.Count > 0) then // draw arrow
        begin
          _Symbol := char($27A4); // Kameleon v6.2.13, simplified
          VertOffset := (Arect.Bottom - ARect.Top - ACanvas.TextHeight(_Symbol)) div 2;
          TextOut(MyRect_Right + 5, Myrect.Top + VertOffset, _Symbol);
        end;
      end;

    end;
  end;
end;


// -----------------------------------------------------------------------------//
{$ENDIF}

end.
