{
//aangepast door Henkie (BEGIN)
  dit betekend dat ik een deel van de code aangepast heb
  tot aan de regel:
//aangepast door Henkie (END)

//toegevoegd door Henkie (BEGIN)
  dit betekend dat ik een procedure ofzo bijgevoegd heb
  tot aan de regel:
//toegevoegd door Henkie (END)
}

unit NLDCalendar;

interface

uses Classes, Controls, Messages, Windows, Forms, Graphics, StdCtrls,
  Grids, SysUtils;

type
//toegevoegd door Henkie (BEGIN)
  //array die de hints bijhoudt
  THintGrid = array[0..6,1..6] of string;
  //array of de achtergrondkleur van de cellen bij te houden

  //record om de kleuren van achtergrond en tekst van een bepaalde cell bij te houden
  //BG = BackGround
  //FG = Foreground
  TBGFGColor = record
    BackColor:TColor;
    TextColor:TColor;
  end;
//toegevoegd door Henkie (END)

  TDayOfWeek = 0..6;
//aangepast door Henkie (BEGIN)
  //was TColor, nu TBGFGColor
  TColorGrid = array[0..6, 1..6] of TBGFGColor;
  {Array that holds the assigned color for each square on the calendar}
//aangepast door Henkie (END)



  TNLDCalendar = class(TCustomGrid)
  private
    ColorGrid: TColorGrid;
//toegevoegd door Henkie (BEGIN)
    HintGrid:THintGrid;
//toegevoegd door Henkie (END)
    FDate: TDateTime;
    FMonthOffset: Integer;
    FOnChange: TNotifyEvent;
    FReadOnly: Boolean;
    FStartOfWeek: TDayOfWeek;
    FUpdating: Boolean;
    FUseCurrentDate: Boolean;
    function GetCellText(ACol, ARow: Integer): string;
    function GetDateElement(Index: Integer): Integer;
    procedure SetCalendarDate(Value: TDateTime);
    procedure SetDateElement(Index: Integer; Value: Integer);
    procedure SetStartOfWeek(Value: TDayOfWeek);
    procedure SetUseCurrentDate(Value: Boolean);
    function StoreCalendarDate: Boolean;
  protected
    procedure Change; dynamic;
    procedure ChangeMonth(Delta: Integer);
    procedure Click; override;
    function DaysPerMonth(AYear, AMonth: Integer): Integer; virtual;
    function DaysThisMonth: Integer; virtual;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    function IsLeapYear(AYear: Integer): Boolean; virtual;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
//toegevoegd door Henkie (BEGIN)
    procedure CMHintShow(var Msg:TCMHintShow);message CM_HINTSHOW;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
//toegevoegd door Henkie (END)
  public
    constructor Create(AOwner: TComponent); override;
    function BGFGColor(cback, cText: TColor): TBGFGColor;
    property CalendarDate: TDateTime  read FDate write SetCalendarDate stored StoreCalendarDate;
    property CellText[ACol, ARow: Integer]: string read GetCellText;
    procedure NextMonth;
    procedure NextYear;
    procedure PrevMonth;
    procedure PrevYear;
    procedure UpdateCalendar; virtual;
//aangepast door Henkie (BEGIN)
    //paramter aHint toegevoegd om tegemoet te komen aan de optie om hints in te stellen
    procedure SetDateColor(Adate: TDateTime; aColor: TBGFGColor;aHint:string ='');
    //naamsverandering (was ResetColors) om tegemoet te komen aan de optie om hints in te stellen
    procedure ResetColorsAndHints;
//aangepast door Henkie (END)
  published
    property Align;
    property Anchors;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property Day: Integer index 3  read GetDateElement write SetDateElement stored True;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property GridLineWidth;
    property Month: Integer index 2  read GetDateElement write SetDateElement stored True;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property ShowHint;
    property StartOfWeek: TDayOfWeek read FStartOfWeek write SetStartOfWeek;
    property TabOrder;
    property TabStop;
    property UseCurrentDate: Boolean read FUseCurrentDate write SetUseCurrentDate default True;
    property Visible;
    property Year: Integer index 1  read GetDateElement write SetDateElement stored True;
    property OnClick;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
//toegevoegd door Henkie (BEGIN)
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
//toegevoegd door Henkie (END)
    property OnStartDock;
    property OnStartDrag;
  end;

//toegevoegd door Henkie (BEGIN)
const
 sInvalidDate = 'The supplied date is not covered by this calendar';
//toegevoegd door Henkie (END)

procedure Register;

implementation

//toegevoegd door Henkie (BEGIN)
function TNLDCalendar.BGFGColor(cback, cText:TColor):TBGFGColor;
begin
  result.BackColor:=cback;
  result.TextColor:=ctext;
end;
//toegevoegd door Henkie (END)

{$R *.DCR}

type
  EDateRangeError = class(Exception);
  {Exception that is raised if the date passed to SetDateColor is }
  {Not within the dates displayed by this calendar}

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDCalendar]);
end;

constructor TNLDCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//toegevoegd door Henkie (BEGIN)
  DefaultDrawing:=false;
  //nodig bij DrawCell()
  DoubleBuffered:=true;
  //Width en Height stonden er nog niet in
  Height:=115;
  Width:=318;
//toegevoegd door Henkie (END)
  { defaults }
  FUseCurrentDate := True;
  FixedCols := 0;
//aangepast door Henkie (BEGIN)
  //was 1, nu 0. We tekenen de header zelf
  FixedRows := 0;
//aangepast door Henkie (END)
  ColCount := 7;
  RowCount := 7;
  ScrollBars := ssNone;
//aangepast door Henkie (BEGIN)
  //goVertLine en goHorzLine weggelaten
  //teken alle lijnen zelf in DrawCell
  Options := Options - [goRangeSelect, goVertLine, goHorzLine] + [goDrawFocusSelected];
//aangepast door Henkie (END)
  If UseCurrentDate = True then
  begin
    FDate := Now;
    SetCalendarDate(Date)
  end else
    SetCalendarDate(EncodeDate(Year, Month, Day));
  UpdateCalendar;
//aangepast door Henkie (BEGIN)
  ResetColorsAndHints;
//aangepast door Henkie (END)
end;

procedure TNLDCalendar.ResetColorsAndHints;
  {This procedure put's 0's in the entire Color Grid Array}

//toegevoegd door Henkie
{And put's '' (empty strings) in the entire HintGrid array}
//toegevoegd door Henkie

  {then it calls the parents Update Calendar Procedure}
  {The UpdateCalendar Procedure does some other work then}
  {It calls DrawCell for each cell in the calendar}
var
  row, col: integer;
begin
  for col := 0 to 6 do
    for row := 1 to 6 do
    begin
//aangapast door Henkie (BEGIN)
      //maakt nu gebruik van TBGFGColor
      ColorGrid[col, row] := bgfgcolor(clWindow,clWindowText);
//aangepast door Henkie (END)
//toegevoegd door Henkie (BEGIN)
      //de hints "resetten"
      HintGrid[col,row]:='';
//toegevoegd door Henkie (END)
    end;
  UpdateCalendar;
end;

procedure TNLDCalendar.SetDateColor(Adate: TDateTime; aColor: TBGFGColor;aHint:string ='');
var
  col, row: Integer;
  found: Boolean;
  theText, dayText: string;
  aYear, aMonth, aDay: Word;
begin
  DecodeDate(Adate, AYear, AMonth, ADay);
  {Turn the date into month,day, and year integers}

  if (aYear <> Year) or (aMonth <> Month) then
//aangepast door Henkie (BEGIN)
//de string is nu een constante
    raise EDateRangeError.Create(sInvalidDate);
//aangepast door Henkie (END)

   {If the Month or year passed is different from the current month or year of the}
   {calendar, the EDateRangeError is raised.  You must check for this}
   {Exception in the calling code}

  dayText := IntToStr(aDay);
  {search for the cell that contains the same day as the day passed}
  { to this procedure}

  found := False;
  row := 1;
  {again, we don't have to search the first row because the names}
  {of the days are there}

  while not (found) and (row < 7) do
  {Found is a boolean variable that is set to true when the correct day}
  {has been found. This improves loop performance by allowing for }
  {early exit from the loop}

  begin
    col := 0;
    while not (found) and (col < 7) do
    begin
      theText := CellText[col, row];
      if theText = dayText then
      begin
        found := True;
        {write the color of this cell to the color grid array}
        ColorGrid[col, row] := aColor;
//toegevoegd door Henkie (BEGIN)
        if length(hintgrid[col,row]) > 0 then
          hintgrid[col,row]:=hintgrid[col,row]+#13#10+ahint
        else
          hintgrid[col,row]:=aHint;
//toegevoegd door Henkie (END)
        UpdateCalendar; (*** remove the // to test and use RL. ***)
      end;
      Inc(col);
    end;
    Inc(row);
  end;
end;

procedure TNLDCalendar.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TNLDCalendar.Click;
var
  TheCellText: string;
begin
  inherited Click;
  TheCellText := CellText[Col, Row];
  if TheCellText <> '' then
    Day := StrToInt(TheCellText);
end;

function TNLDCalendar.IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function TNLDCalendar.DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then
    Inc(Result); { leap-year Feb is special }
end;

function TNLDCalendar.DaysThisMonth: Integer;
begin
  Result := DaysPerMonth(Year, Month);
end;

procedure TNLDCalendar.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
//toegevoegd door Henkie (BEGIN)
const
  //alle kleuren worden op 1 plaats gehouden, makkelijker onderhoud en minder kans op fouten
  SelectieKleur:TColor = clHighLight;
  SelectieTekstKleur :TColor = clHighlightText;
  RandKleur:TColor = clBtnShadow;
  HeaderKleur:TColor = clbtnface;
//  Vulkleur:TColor = clWindow;
  AndereMaandKleur:TColor = clbtnFace;
//toegevoegd door Henkie (END)
var
  theText: string;
  {Used by the CellText procedure to get the text from the grid}
  {that is pointed to by ACol and ARow}
begin
  theText := CellText[ACol, ARow];
  {Get the date text from the current cell}
//aangepast door Henkie (BEGIN)
  //pen.Width op 2 gezet, is nodig om de border rond de cellen te tekenen
  canvas.Pen.Width:=2;
  //teken zelf de headers
  if aRow = 0 then
  begin
    canvas.brush.color:=HeaderKleur;
    DrawFrameControl(canvas.Handle,arect,DFC_BUTTON,DFCS_ADJUSTRECT or DFCS_BUTTONPUSH);
    canvas.TextRect(arect,arect.left+((arect.right-arect.Left-canvas.TextWidth(TheText)) div 2),
      arect.top+((arect.bottom-arect.top-canvas.TextHeight(TheText)) div 2),TheText);
    exit;
  end;

//aangepast door Henkie (END)
  if theText <> '' then
  {Can only set the color on grid cells that contain a date}
  begin
    {the current box is selected, overwrite the selected box hilight}
//aangepast door Henkie (BEGIN)
//anders zie je niet welke cell geselecteerd is ;)
    if gdSelected in AState then
      Canvas.Brush.Color := SelectieKleur
    else
    begin
      canvas.Brush.color:=colorgrid[acol,arow].BackColor;
      canvas.pen.color:=Randkleur;
      canvas.Rectangle(arect);
    end;
//aangepast door Henkie (END)
  end {If Thetext <> ''}else
//toegevoegd door Henkie (BEGIN)
  begin
//de cellen zonder tekst (die dus tot de volgende of vorige maand behoren
//worden ingekleurd met AndereMaandKleur --> clBtnFace
    canvas.brush.color:=AndereMaandKleur;
    canvas.pen.color:=AndereMaandKleur;
    canvas.Rectangle(arect);
  end;
//toegevoegd door Henkie (END)

//aangepast door Henkie (BEGIN)
  //nam de systeeminstellingen voor de geslecteerde tekstkleur niet over
  if (gdSelected in aState) then
    canvas.Font.Color:=SelectieTekstKleur
  else
//aangepast door Henkie (END)
    Canvas.Font.Color := colorgrid[aCol,aRow].TextColor;
  with ARect, Canvas do
    TextRect(ARect, Left + (Right - Left - TextWidth(theText)) div 2,
      Top + (Bottom - Top - TextHeight(theText)) div 2, theText);
             {This procedure was copied from the parent class}
end;

function TNLDCalendar.GetCellText(ACol, ARow: Integer): string;
var
  DayNum: Integer;
begin
  if ARow = 0 then  { day names at tops of columns }
    Result := ShortDayNames[(StartOfWeek + ACol) mod 7 + 1]
  else
  begin
    DayNum := FMonthOffset + ACol + (ARow - 1) * 7;
    if (DayNum < 1) or (DayNum > DaysThisMonth) then
      Result := ''
    else
      Result := IntToStr(DayNum);
  end;
end;

function TNLDCalendar.SelectCell(ACol, ARow: Longint): Boolean;
begin
//aangepast door Henkie (BEGIN)
  //or (aRow =0) toegevoegd, dit omdat je anders een header kon selecteren
  if ((not FUpdating) and FReadOnly) or (CellText[ACol, ARow] = '') or (aRow = 0) then
//aangepast door Henkie (END)
    Result := False
  else
    Result := inherited SelectCell(ACol, ARow);
//toegevoegd door Henkie (BEGIN)
  //Invalidate is hier nodig om de cellen te hertekenen wanneer je een range probeert te selecteren
  invalidate;
//toegevoegd door Henkie (END)
end;

procedure TNLDCalendar.SetCalendarDate(Value: TDateTime);
begin
  FDate := Value;
  UpdateCalendar;
  Change;
end;

function TNLDCalendar.StoreCalendarDate: Boolean;
begin
  Result := not FUseCurrentDate;
end;

function TNLDCalendar.GetDateElement(Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  case Index of
    1: Result := AYear;
    2: Result := AMonth;
    3: Result := ADay;
    else Result := -1;
  end;
end;

procedure TNLDCalendar.SetDateElement(Index: Integer; Value: Integer);
var
  AYear, AMonth, ADay: Word;
begin
  if Value > 0 then
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);
    case Index of
      1: if AYear <> Value then AYear := Value else Exit;
      2: if (Value <= 12) and (Value <> AMonth) then AMonth := Value else Exit;
      3: if (Value <= DaysThisMonth) and (Value <> ADay) then ADay := Value else Exit;
      else Exit;
    end;
    FDate := EncodeDate(AYear, AMonth, ADay);
    FUseCurrentDate := False;
    UpdateCalendar;
    Change;
  end;
end;

procedure TNLDCalendar.SetStartOfWeek(Value: TDayOfWeek);
begin
  if Value <> FStartOfWeek then
  begin
    FStartOfWeek := Value;
    UpdateCalendar;
  end;
end;

procedure TNLDCalendar.SetUseCurrentDate(Value: Boolean);
begin
  if Value <> FUseCurrentDate then
  begin
    FUseCurrentDate := Value;
    if Value then
    begin
      FDate := Date; { use the current date, then }
      UpdateCalendar;
    end;
  end;
end;

{ Given a value of 1 or -1, moves to Next or Prev month accordingly }
procedure TNLDCalendar.ChangeMonth(Delta: Integer);
var
  AYear, AMonth, ADay: Word;
  NewDate: TDateTime;
  CurDay: Integer;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  CurDay := ADay;
  if Delta > 0 then
    ADay := DaysPerMonth(AYear, AMonth)
  else
    ADay := 1;
  NewDate := EncodeDate(AYear, AMonth, ADay);
  NewDate := NewDate + Delta;
  DecodeDate(NewDate, AYear, AMonth, ADay);
  if DaysPerMonth(AYear, AMonth) > CurDay then
    ADay := CurDay
  else
    ADay := DaysPerMonth(AYear, AMonth);
  CalendarDate := EncodeDate(AYear, AMonth, ADay);
end;

procedure TNLDCalendar.PrevMonth;
begin
  ChangeMonth(-1);
end;

procedure TNLDCalendar.NextMonth;
begin
  ChangeMonth(1);
end;

procedure TNLDCalendar.NextYear;
begin
  if IsLeapYear(Year) and (Month = 2) and (Day = 29) then
    Day := 28;
  Year := Year + 1;
end;

procedure TNLDCalendar.PrevYear;
begin
  if IsLeapYear(Year) and (Month = 2) and (Day = 29) then
    Day := 28;
  Year := Year - 1;
end;

procedure TNLDCalendar.UpdateCalendar;
var
  AYear, AMonth, ADay: Word;
  FirstDate: TDateTime;
begin
  FUpdating := True;
  try
    DecodeDate(FDate, AYear, AMonth, ADay);
    FirstDate := EncodeDate(AYear, AMonth, 1);
    FMonthOffset := 2 - ((DayOfWeek(FirstDate) - StartOfWeek + 7) mod 7); { day of week for 1st of month }
    if FMonthOffset = 2 then
      FMonthOffset := -5;
    MoveColRow((ADay - FMonthOffset) mod 7, (ADay - FMonthOffset) div 7 + 1,False, False);
    Invalidate;
  finally
    FUpdating := False;
  end;
end;

procedure TNLDCalendar.WMSize(var Message: TWMSize);
var
  GridLines: Integer;
begin
  GridLines := 6 * GridLineWidth;
  DefaultColWidth := (Message.Width - GridLines) div 7;
  DefaultRowHeight := (Message.Height - GridLines) div 7;
end;

//toegevoegd door Henkie (BEGIN)
procedure TNLDCalendar.CMHintShow(var Msg: TCMHintShow);
  //nodig om de hints per cell te tonen
var
  gc:TGridCoord;
  pt:tpoint;
  aCellRect:trect;
  aHint:string;
begin
  with msg do
  begin
    result:=1;
    //cursorpos omzeten naar row en col
    pt:=point(hintinfo.CursorPos.X,hintinfo.CursorPos.Y);
    gc:=mousecoord(pt.x,pt.y);
    if ((gc.x < 0) or (gc.x > 6)) or ((gc.y < 1) or (gc.y > 6)) then
      exit;
    acellrect:=self.CellRect(gc.x,gc.y);
    //hint ophalen
    aHint:=self.HintGrid[gc.x,gc.y];
  end;
  with msg.HintInfo^ do
  begin
    //hint tonen
    CursorRect := aCellrect;
    HintStr := aHint;
    Msg.Result := 0;
  end;
end;

procedure TNLDCalendar.CMDesignHitTest(var Msg: TCMDesignHitTest);
//maakt het selecteren van een cell @designtime mogelijk
var
  gc:TgridCoord;
  pt:tpoint;
begin
  pt:=point(msg.XPos,msg.YPos);
  gc:=mousecoord(pt.X,pt.y);
  msg.result:=ord(SelectCell(gc.x,gc.y));
end;
//toegevoegd door Henkie (END)

end.
