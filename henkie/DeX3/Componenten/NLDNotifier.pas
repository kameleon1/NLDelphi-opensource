unit NLDNotifier;

interface

uses
  Windows, Controls, Messages, SysUtils, Classes, Forms, StdCtrls, ExtCtrls,
  Contnrs, Graphics;

type
  TNLDNotifier = class;
  TNotifyForm = class;

  TNotifyLabel = class(TLabel)
  private
    FForm: TNotifyForm;
  protected
    procedure Click; override;
    property Form: TNotifyForm read FForm;
    constructor Create(AOwner: TNotifyForm); reintroduce;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X: Integer; Y: Integer); override;
  end;

  { Formulier voor [TNLDNotifier] }
  TNotifyForm = class(TCustomForm)
  private
    fLinkLabel: TNotifyLabel;
    FTimer: TTimer;
    FNotifier: TNLDNotifier;
    FURL: string;
    procedure TimerDone(Sender: TObject);
    function GetText: string;
    procedure SetText(const Value: string);
    procedure Remove;
    function GetTimeout: Integer;
    procedure SetTimeout(const Value: Integer);
    function GetNotifyText: string;
    procedure SetNotifyText(const Value: string);
  protected
    fBackgroundBitmap, fCurvesBitmap, fMixBitmap, fFlagBitmap: TBitmap;
    fBackImage, fFlagImage: TImage;
    fNameLabel, fTextLabel: TLabel;
    function MouseOverForm: boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure PrepareBackgroundBitmap;
    procedure PrepareCurvesBitmap;
    procedure PrepareFlagBitmap;
    procedure CombineBitmaps;
  public
    property Text: string read GetText Write SetText;
    property URL: string read FURL write FURL;
    property NotifyText: string read GetNotifyText write SetNotifyText;
    property Timeout: Integer read GetTimeout write SetTimeout;
    property Notifier: TNLDNotifier read FNotifier;

    destructor Destroy; override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
  end;

  { Component om de popup te tonen }
  TNLDNotifier = class(TComponent)
  private
    FFormList: TComponentList;
    FTimeout: Integer;
    FEnabled: Boolean;
    FOnClick: TNotifyEvent;
    FLinkColor: TColor;
    FTextColor: TColor;
    fTopColor: TColor;
    fBottomColor: TColor;
  public
    procedure Execute(const NotifyText, LinkText: string; URL: string = '';
      Tag: integer = -1);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteForm(Form: TNotifyForm);
  published
    property TextColor: TColor read FTextColor write FTextColor;
    property LinkColor: TColor read FLinkColor write FLinkColor;
    property TopColor: TColor read fTopColor write fTopColor;
    property BottomColor: TColor read fBottomColor write fBottomColor;
    property Timeout: Integer read FTimeout write FTimeout;
    property Enabled: Boolean read FEnabled write FEnabled;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

procedure Register;

implementation

uses
  ShellAPI, GraphUtil;

const
  FormHeight = 137;
  FormWidth = 213;

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDNotifier]);
end;

{ TNLDNotifier }

constructor TNLDNotifier.Create(AOwner: TComponent);
begin
  inherited;
  FFormList := TComponentList.Create;
  FFormList.OwnsObjects := False;
end;

procedure TNLDNotifier.DeleteForm(Form: TNotifyForm);
begin
  AnimateWindow(Form.Handle, 750, AW_HIDE or AW_SLIDE or AW_VER_POSITIVE);
  FFormList.Remove(Form);
  { Moet in dit geval een release zijn omdat free regelmatig AV's abstract
    errors geeft }
  Form.Release;
end;

destructor TNLDNotifier.Destroy;
begin
  FFormList.Free;
  inherited;
end;

procedure TNLDNotifier.Execute(const NotifyText, LinkText: string; URL: string = '';
  Tag: Integer = -1);
var
  Form: TNotifyForm;
  i: Integer;
begin
  if not FEnabled then
    Exit;

  { De overige forms omhoogschuiven }
  for i := 0 to FFormList.Count -1 do
    TNotifyForm(fFormList[i]).Top := TNotifyForm(fFormList[i]).Top - FormHeight;

  Form := TNotifyForm.CreateNew(Self);
  Form.URL := URL;
  Form.Tag := Tag;
  FFormList.Add(Form);

  Form.Text := LinkText;
  Form.NotifyText :=  NotifyText;
  Form.Timeout := FTimeout;

  AnimateWindow(Form.Handle, 750, AW_ACTIVATE or AW_SLIDE or AW_VER_NEGATIVE);
end;

{ TNotifyForm }

procedure TNotifyForm.TimerDone(Sender: TObject);
begin
  if not MouseOverForm then
    Remove;
end;

procedure TNotifyForm.Remove;
begin
  FNotifier.DeleteForm(Self);
end;

constructor TNotifyForm.CreateNew(AOwner: TComponent; Dummy: Integer);
var
  r: TRect;
begin
  inherited;
  FNotifier := TNLDNotifier(AOwner);
  FormStyle := fsStayOnTop;
  //volgende regel zeker toevoegen of de popup komt linksboven ipv rechtsonder
  Position := poDesigned;
  Height := FormHeight;
  Width := FormWidth;
//gradientbitmap
  fBackgroundBitmap := TBitmap.Create;
  fBackgroundBitmap.PixelFormat := pf24bit;
  fBackgroundBitmap.Width := Width;
  fBackgroundBitmap.Height := Height;
//curvesbitmap
  fCurvesBitmap := TBitmap.Create;
  fCurvesBitmap.PixelFormat := pf24bit;
  fCurvesBitmap.Width := Width;
  fCurvesBitmap.Height := Height;
  fCurvesBitmap.Transparent := true;
//backgroundbitmap
  fMixBitmap := TBitmap.Create;
  fMixBitmap.PixelFormat := pf24bit;
  fMixBitmap.Width := Width;
  fMixBitmap.Height := Height;
//achtergrond
  fBackImage := TImage.Create(Self);
  fBackImage.Parent := Self;
  fBackImage.SetBounds(0, 0, Width, Height);
//flagbitmap
  fFlagBitmap := TBitmap.Create;
  fFlagBitmap.Width := 24;
  fFlagBitmap.Height := 24;
//vlag
  fFlagImage := TImage.Create(Self);
  fFlagImage.Parent := Self;
  fFlagImage.Left := 8;
  fFlagImage.Top := 8;
  fFlagImage.AutoSize := true;
//titel
  fNameLabel := TLabel.Create(Self);
  fNameLabel.SetBounds(40, 8, 164, 25);
  fNameLabel.Anchors := [akLeft, akTop, akRight];
  fNameLabel.AutoSize := false;
  fNameLabel.Caption := 'DeX 3';
  fNameLabel.Font.Style := [fsBold];
  fNameLabel.Font.Color := Notifier.TextColor;
  fNameLabel.Layout := tlCenter;
  fNameLabel.Transparent := true;
  fNameLabel.Parent := Self;
  fNameLabel.ShowAccelChar := false;
//tekst
  fTextLabel := TLabel.Create(Self);
  fTextLabel.Parent := Self;
  fTextLabel.AutoSize := false;
  fTextLabel.Transparent := true;
  fTextLabel.WordWrap := true;
  fTextLabel.SetBounds(8, 48, 197, 41);
  fTextLabel.Font.Color := Notifier.TextColor;
//link
  fLinkLabel := TNotifyLabel.Create(self);
  fLinkLabel.AutoSize := false;
  fLinkLabel.SetBounds(8, 80, 197, 49);
  fLinkLabel.Transparent := true;
  fLinkLabel.Font.Style := [fsBold];
  fLinkLabel.WordWrap := true;
  fLinkLabel.Parent := self;

  PrepareBackgroundBitmap;
  PrepareCurvesBitmap;
  PrepareFlagBitmap;
  CombineBitmaps;

  BorderIcons := [];
  BorderStyle := bsDialog;

  SystemParametersInfo(SPI_GETWORKAREA, 0, @r, 0);
  Left := r.Right - Width;
  Top := r.Bottom - Height;

  FTimer := TTimer.Create(self);
  FTimer.Interval := 0;
  FTimer.Enabled := False;
  FTimer.OnTimer := TimerDone;
end;

procedure TNotifyForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;
  Params.Style := Params.Style and not WS_CAPTION or WS_POPUP;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE;
end;

function TNotifyForm.GetText: string;
begin
  Result := fLinkLabel.Caption;
end;

procedure TNotifyForm.SetText(const Value: string);
begin
  fLinklabel.Visible := Value <> '';
  if not fLinkLabel.Visible then
    Exit;
  fLinkLabel.Caption := Value;
  fLinkLabel.ShowHint := True;
  fLinkLabel.Hint := Value;
end;

function TNotifyForm.GetTimeout: Integer;
begin
  Result := FTimer.Interval div 1000;
end;

procedure TNotifyForm.SetTimeout(const Value: Integer);
begin
  FTimer.Interval := Value * 1000;
  FTimer.Enabled := FTimer.Interval > 0;
end;

{ TNotifyLabel }

procedure TNotifyLabel.Click;
begin
  inherited;
  Form.FTimer.Enabled := False;

  if Form.URL <> '' then
    ShellExecute(0, 'open', PChar(Form.URL), nil, nil, SW_SHOW);

  if Assigned(Form.Notifier.OnClick) then
    Form.Notifier.OnClick(Form);

  Form.Remove;
end;

procedure TNotifyLabel.CMMouseEnter(var Message: TMessage);
begin
  Font.Style := Font.Style + [fsUnderline];
end;

procedure TNotifyLabel.CMMouseLeave(var Message: TMessage);
begin
  Font.Style := Font.Style - [fsUnderline];
end;

constructor TNotifyLabel.Create(AOwner: TNotifyForm);
begin
  inherited Create(AOwner);
  FForm := AOwner;
  Cursor := crHandPoint;
  Font.Color := Form.Notifier.LinkColor;
  //geen onderstreepte letters
  ShowAccelChar := false;
end;

procedure TNotifyLabel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Button = mbRight then
    Form.Remove;
end;

destructor TNotifyForm.Destroy;
begin
  fCurvesBitmap.Free;
  fBackgroundBitmap.Free;
  inherited;
end;

procedure TNotifyForm.PrepareBackgroundBitmap;
begin
{
  Niet Clientrect gebruiken want dan is de BackgroundBitmap te klein en ziet er dus niet uit.
  Gebeurt enkel als niet de klassieke Windows stijl gebruikt wordt (Luna onder XP of Aero onder vista)
}
  GradientFillCanvas(fBackgroundBitmap.Canvas, fNotifier.TopColor, fNotifier.BottomColor,
    Rect(0, 0, Width, Height), gdVertical);
end;

procedure TNotifyForm.PrepareCurvesBitmap;
var
  Curves: array[0..3] of TPoint;
begin
  with fCurvesBitmap do
  begin
    Canvas.Brush.Color := clFuchsia;
    Canvas.FillRect(Rect(0, 0, Width, Height));
    Canvas.Pen.Color := clWhite;
    Canvas.Pen.Width := 1;
      Curves[0] := Point(-5, 41);
      Curves[1] := Point(120, 44);
      Curves[2] := Point(120, 13);
      Curves[3] := Point(Succ(Width), 13);
    Canvas.PolyBezier(Curves);
    Canvas.Pen.Width := 1;
      Curves[0] := Point(-5, 39);
      Curves[1] := Point(120, 42);
      Curves[2] := Point(120, 15);
      Curves[3] := Point(Succ(Width), 15);
    Canvas.PolyBezier(Curves);
  end;
end;

procedure TNotifyForm.CombineBitmaps;

{$REGION 'Niet gebruikte procedure'}
  procedure MixBitmaps(const BitmapA: TBitmap; const WeightA: cardinal;
    const BitmapB: TBitmap; const WeightB: cardinal);
  const
    MaxPixelCount = 65536;
  type
    TRGBArray = array[0..MaxPixelCount-1] of TRGBTriple;
    pRGBArray = ^TRGBArray;
  var
    BreedteIndex:  integer;
    HoogteIndex:  integer;
    RowA:  pRGBArray;
    RowB:  pRGBArray;
    MixRow:  pRGBArray;
    SumWeights:  cardinal;

    function WeightPixels (const PixelA, PixelB:  cardinal):  byte;
    begin
      Result := byte((WeightA*PixelA + WeightB*PixelB) DIV SumWeights)
    end;

  begin
    Assert((BitmapA.PixelFormat = pf24bit) and (BitmapB.PixelFormat = pf24bit), 'Need 24bit bitmaps to combine');
    SumWeights := WeightA + WeightB;
    // if SumWeights is 0, just return a "empty" white image
    if SumWeights > 0 then
    begin
      for HoogteIndex := 0 to Pred(fMixBitmap.Height) do
      begin
        RowA := BitmapA.Scanline[HoogteIndex];
        RowB := BitmapB.Scanline[HoogteIndex];
        MixRow := fMixBitmap.Scanline[HoogteIndex];

        for BreedteIndex := 0 to Pred(fMixBitmap.Width) do
          with MixRow[BreedteIndex] do
          begin
            rgbtRed := WeightPixels(RowA[BreedteIndex].rgbtRed, rowB[BreedteIndex].rgbtRed);
            rgbtGreen := WeightPixels(RowA[BreedteIndex].rgbtGreen, rowB[BreedteIndex].rgbtGreen);
            rgbtBlue := WeightPixels(RowA[BreedteIndex].rgbtBlue, rowB[BreedteIndex].rgbtBlue)
          end
      end
    end
  end;
{$ENDREGION}

var
  p0, p1, p2 : PByteArray;
  XIndex, YIndex: integer;
begin
  fMixBitmap.Canvas.StretchDraw(Rect(0, 0, Width, Height), fBackgroundBitmap);
  fMixBitmap.Canvas.StretchDraw(Rect(0, 0, Width, Height), fCurvesBitmap);
  //antialiasing van de bitmap
  for YIndex := 1 to fMixBitmap.Height - 2 do
  begin
    p0 := fMixBitmap.ScanLine[YIndex - 1];
    p1 := fMixBitmap.scanline[YIndex];
    p2 := fMixBitmap.ScanLine[YIndex + 1];
    for XIndex := 1 to Width - 2 do begin
      p1[XIndex * 3] := (p0[XIndex * 3] + p2[XIndex * 3] + p1[(XIndex - 1) * 3] + p1[(XIndex + 1) * 3])div 4;
      p1[XIndex * 3 + 1] := (p0[XIndex * 3 + 1] + p2[XIndex * 3 + 1] + p1[(XIndex - 1) * 3 + 1] +
        p1[(XIndex + 1) * 3 + 1])div 4;
      p1[XIndex * 3 + 2] := (p0[XIndex * 3 + 2] + p2[XIndex * 3 + 2] + p1[(XIndex -1 ) * 3 + 2] +
        p1[(XIndex +1 ) * 3 + 2])div 4;
    end;
  end;
  fBackImage.Picture.Bitmap.Assign(fMixBitmap);
end;

procedure TNotifyForm.PrepareFlagBitmap;
begin
//opvullen met wit
  fFlagBitmap.Canvas.Brush.Color := clWhite;
  fFlagBitmap.Canvas.FillRect(Rect(0, 0, 24, 24));
//bovenste kleur rood
  fFlagBitmap.Canvas.Pen.Color := clRed;
  fFlagBitmap.Canvas.Brush.Color := fFlagBitmap.Canvas.Pen.Color;
  fFlagBitmap.Canvas.Rectangle(0, 0, 24, 8);
//onderste kleur blauw
  fFlagBitmap.Canvas.Pen.Color := clBlue;
  fFlagBitmap.Canvas.Brush.Color := fFlagBitmap.Canvas.Pen.Color;
  fFlagBitmap.Canvas.Rectangle(0, 16, 24, 24);
//zwarte rand
  fFlagBitmap.Canvas.Brush.Color := clBlack;
  fFlagBitmap.Canvas.FrameRect(Rect(0, 0, 24, 24));
  fFlagBitmap.Transparent := false;

  fFlagImage.Picture.Bitmap.Assign(fFlagBitmap);
end;

function TNotifyForm.GetNotifyText: string;
begin
  Result := fTextLabel.Caption;
end;

procedure TNotifyForm.SetNotifyText(const Value: string);
begin
  fTextLabel.Caption := Value;
end;

function TNotifyForm.MouseOverForm: boolean;
begin
  Result := PtInRect(Rect(Left, Top, Left + Width, Top + Height), Mouse.CursorPos);
end;

end.
