unit DeXTree;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, VirtualTrees, Forms, Graphics;

type
  TDexHint = class(THintWindow)
  private
    fNLDelphiFlag: TBitmap;
    fInternalMaxWidth: integer;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
    procedure Paint; override;
  end;

  TDeXTree = class(TVirtualStringTree)
  private
    { Private declarations }
  protected
    procedure DoBeforeCellPaint(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect); override;
    function GetHintWindowClass: THintWindowClass; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property IncrementalSearch default isAll;
    property IncrementalSearchStart default ssLastHit;
    property IncrementalSearchTimeOut default 750;
  end;

  TDexHintType = (htForum, htPM, htLink, htNews, htFavorite);

  TDexHintData = record
    ForumName,
    MemberName,
    ThreadName,
    GroupName: string;
    DateTime: TDateTime;
    Bitmap: TBitmap;
    ContainsBitmap: boolean;
    HintType: TDeXHintType;
  end;

var
  DexHintData: TDexHintData;

procedure Register;

implementation

uses
  DateUtils;

const
  MinimumHintWidth = 250;
  HintHeight: array[TDexHintType] of integer = (146, 110, 110, 74, 182);

procedure Register;
begin
  RegisterComponents('NLDelphi', [TDeXTree]);
end;

{ TDeXTree }

constructor TDeXTree.Create(AOwner: TComponent);
begin
  inherited;
  Header.Options := Header.Options + [hoVisible];
  TreeOptions.PaintOptions := TreeOptions.PaintOptions - [toShowRoot];
  TreeOptions.SelectionOptions := TreeOptions.SelectionOptions  +
    [toFullRowSelect, toMultiSelect, toRightClickSelect];
  IncrementalSearch := isAll;
  IncrementalSearchStart := ssLastHit;
  IncrementalSearchTimeOut := 750;
end;

procedure TDeXTree.DoBeforeCellPaint(Canvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellRect: TRect);
begin
  inherited;

  if Node.Index mod 2 = 0 then
  begin
    Canvas.Brush.Color := StringToColor('$00F0F0F0');
    Canvas.FillRect(CellRect);
  end;
end;

function TDeXTree.GetHintwindowclass: THintWindowClass;
begin
  Result := TDexHint;
end;

{ TDexHint }

function TDexHint.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  Result := inherited CalcHintRect(MaxWidth, aHint, aData);
  Result.Bottom := HintHeight[DexHintData.Hinttype];
  fInternalMaxWidth := MaxWidth;
end;

procedure TDexHint.Paint;
var
  Datum: TDate;
  Tijd: TTime;
  Bitmap: TBitmap;
  Dummy, MaxWidth: integer;

  procedure BuildNLDelphiFlagBitmap;
  begin
    if DexHintData.ContainsBitmap then
    begin
      fNLDelphiFlag.Assign(DexHintData.Bitmap);
      fNLDelphiFlag.Transparent := true;
      Exit;
    end;
    fNLDelphiFlag.Width := 16;
    fNLDelphiFlag.Height := 16;
    //opvullen met wit
    fNLDelphiFlag.Canvas.Brush.Color := clWhite;
    fNLDelphiFlag.Canvas.FillRect(Rect(0, 0, 16, 16));
    //bovenste kleur rood
    fNLDelphiFlag.Canvas.Pen.Color := clRed;
    fNLDelphiFlag.Canvas.Brush.Color := fNLDelphiFlag.Canvas.Pen.Color;
    fNLDelphiFlag.Canvas.Rectangle(0, 0, 16, 6);
    //onderste kleur blauw
    fNLDelphiFlag.Canvas.Pen.Color := clBlue;
    fNLDelphiFlag.Canvas.Brush.Color := fNLDelphiFlag.Canvas.Pen.Color;
    fNLDelphiFlag.Canvas.Rectangle(0, 10, 16, 16);
    //zwarte rand
    fNLDelphiFlag.Canvas.Brush.Color := clBlack;
    fNLDelphiFlag.Canvas.FrameRect(Rect(0, 0, 16, 16));
    fNLDelphiFlag.Transparent := false;
  end;

  procedure DrawTheText(aleft, aTop: integer; aCaption: TCaption; aFontStyles: TFontStyles; aSize: integer = 8);
  begin
    Bitmap.Canvas.Font.Style := aFontStyles;
    Bitmap.Canvas.Font.Size := aSize;
    Bitmap.Canvas.TextOut(aLeft, aTop, aCaption);
    Dummy := Bitmap.Canvas.PenPos.X;
    if Dummy > MaxWidth then
      MaxWidth := Dummy;
  end;

  procedure DrawBorder;
  begin
    with Bitmap.Canvas do
    begin
      MoveTo(0, Bitmap.Height-1);
      Pen.Color := clBtnShadow;
      LineTo(Bitmap.Width-1, Bitmap.Height-1);
      LineTo(Bitmap.Width-1, 0);
//      Pen.Color := clbtnHighlight;
      LineTo(0, 0);
      LineTo(0, Bitmap.Height-1);
    end;
  end;

  procedure DrawForumText;
  begin
    DrawTheText(32, 8, DexHintData.ForumName, [fsBold, fsUnderline], 10);

    DrawTheText(8, 40, 'Gepost door:', [fsBold]);
    DrawTheText(24, 54, DexHintData.MemberName, []);

    DrawTheText(8, 76, 'In thread:', [fsBold]);
    DrawTheText(24, 90, DexHintData.ThreadName, []);

    DrawTheText(8, 112, 'Gepost op:', [fsBold]);
    DrawTheText(24, 126, Format('%s om %s', [DateToStr(Datum), TimeToStr(Tijd)]), []);
  end;

  procedure DrawPMText;
  begin
    DrawTheText(32, 8, DexHintData.MemberName, [fsBold, fsUnderline], 10);

    DrawTheText(8, 40, 'Onderwerp:', [fsBold]);
    DrawTheText(24, 54, DexHintData.ThreadName, []);

    DrawTheText(8, 76, 'Gepost op:', [fsBold]);
    DrawTheText(24, 90, Format('%s om %s', [DateToStr(Datum), TimeToStr(Tijd)]), []);
  end;

  procedure DrawLinksText;
  begin
    DrawTheText(32, 8, DexHintData.ForumName, [fsBold, fsUnderline], 10);

    DrawTheText(8, 40, 'Titel:', [fsBold]);
    DrawTheText(24, 54, DexHintData.ThreadName, []);

    DrawTheText(8, 76, 'Gepost op:', [fsBold]);
    DrawTheText(24, 90, Format('%s om %s', [DateToStr(Datum), TimeToStr(Tijd)]), []);
  end;

  procedure DrawNewsText;
  begin
    DrawTheText(32, 8, DexHintData.ThreadName, [fsBold, fsUnderline], 10);

    DrawTheText(8, 40, 'Gepost op:', [fsBold]);
    DrawTheText(24, 54, Format('%s om %s', [DateToStr(Datum), TimeToStr(Tijd)]), []);
  end;

  procedure DrawFavoritesText;
  begin
    DrawTheText(32, 8, DexHintData.ForumName, [fsBold, fsUnderline], 10);

    DrawTheText(8, 40, 'Gepost door:', [fsBold]);
    DrawTheText(24, 54, DexHintData.MemberName, []);

    DrawTheText(8, 76, 'In thread:', [fsBold]);
    DrawTheText(24, 90, DexHintData.ThreadName, []);

    DrawTheText(8, 112, 'Gepost op:', [fsBold]);
    DrawTheText(24, 126, Format('%s om %s', [DateToStr(Datum), TimeToStr(Tijd)]), []);

    DrawTheText(8, 148, 'In groep:', [fsBold]);
    DrawTheText(24, 162, DexHintData.GroupName, []);
  end;

begin
//  Inherited;
  MaxWidth := 0;
  Datum := DateOf(DexHintData.DateTime);
  Tijd := TimeOf(DexHintData.DateTime);
  Bitmap := TBitmap.Create;
  try
    Bitmap.Canvas.Lock;
    with Bitmap do
    begin
      Bitmap.Width := fInternalMaxWidth;
      Height := Self.Height;
      with Bitmap.Canvas do
      begin
        Font.Assign(Screen.HintFont);
        SetBkMode(Handle, Windows.TRANSPARENT);
        Brush.Color := clInfoBk;
        FillRect(Rect(0, 0, Width, Height));
        Font.Color := clInfoText;
        BuildNLDelphiFlagBitmap;
        Draw(8, 8, fNLDelphiFlag);
        case DexHintData.HintType of
          htForum: DrawForumText;
          htPM: DrawPMText;
          htLink: DrawLinksText;
          htNews: DrawNewsText;
          htFavorite: DrawFavoritesText;
        end;
        MaxWidth := MaxWidth + 8;
        Bitmap.Width := MaxWidth;
        Self.Width := MaxWidth;
      end;
    end;
//    inherited;
    DrawBorder;
    Self.Canvas.Draw(0, 0, Bitmap);
  finally
    Bitmap.Canvas.Unlock;
    Bitmap.Free;
  end;
end;


constructor TDexHint.Create(aOwner: TComponent);
begin
  inherited;
//  Color := clInfoBk;
  fNLDelphiFlag := TBitmap.Create;
end;

destructor TDexHint.Destroy;
begin
  fNLDelphiFlag.Free;
  inherited;
end;

procedure TDexHint.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style and not WS_BORDER;
end;

initialization
  DexHintData.Bitmap := TBitmap.Create;

finalization
  DexHintData.Bitmap.Free;

end.
