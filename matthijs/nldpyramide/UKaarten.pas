unit UKaarten;

// Unit gebaseerd op het werk van Tom Lee
// Email : tom@libra.aaa.hinet.net , Web : http://www.aaa.hinet.net/delphi
// Helaas zijn Email en Web niet te bereiken. :(
// Ik denk echter dat je meer met de Cards.dll kunt doen.
// Dus als iemand kan vertellen welke functies deze dll exporteert,
// houd ik mij aan bevolen :)
// Het enige wat ik in deze code heb gedaan is een en ander omgezet naar het
// Nederlands. Ook gebruik ik wat minder Units. Bovendien heb ik de joker er
// maar even uitgegooid, omdat ik die op dit moment niet (nodig) heb.

interface

uses
  Classes, Controls, Windows, Graphics, SysUtils, Forms;

const
  Err1 = 'Kan %s niet laden';
  Err2 = 'Resource #%d niet gevonden (%s)';
  Err3 = 'Bitmap #%d is niet goed opgeslagen';

type
  TKaartKleur = (kkKlaver, kkRuiten, kkHarten, kkSchoppen);
  TKaartStatus = (ksOpen, ksDicht, {ksJoker,} ksO, ksX);
  TKaart = class(TGraphicControl)
  private
    FBitMap: TBitMap;
    FKaartRugplaatje: Integer;
    FStatus: TKaartStatus;
    FKleur: TKaartKleur;
    FWaarde: Integer;
//    procedure LoadResBmp(Naam: string; Dest: TBitmap);
    procedure LoadDLLBmp(FileNaam: string; BmpId: Integer; Dest: TBitmap);
    procedure SetStatus(const Value: TKaartStatus);
    procedure SetKaartRugplaatje(const Value: Integer);
    procedure SetWaarde(const Value: Integer);
    procedure SetKleur(const Value: TKaartKleur);
    procedure GetCardFromDLL;
  protected
    procedure Paint; override;
  public
    property  Canvas;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property KaartRugplaatje: Integer read FKaartRugplaatje write SetKaartRugplaatje default 1;
    property Cursor;
    property DragMode;
    property Enabled;
    property Height;
    property Hint;
    property Left;
    property Name;
    property ShowHint;
    property Status: TKaartStatus read FStatus write SetStatus default ksOpen;
    property Kleur: TKaartKleur read FKleur write SetKleur default kkKlaver;
    property Tag;
    property Top;
    property Waarde: Integer read FWaarde write SetWaarde default 1;
    property Visible;
    property Width;
    property OnClick;
    property OnDragDrop;
    property OnDblClick;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

implementation

{ TKaart }

constructor TKaart.Create(AOwner: TComponent);
begin
  inherited;
  Width :=30;
  Height :=30;
  FStatus := ksOpen;
  FKaartRugplaatje := 1;
  FWaarde := 1;
  FKleur := kkKlaver;
  FBitmap := TBitmap.Create;
end;

destructor TKaart.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TKaart.GetCardFromDLL;
var
   Id:integer;
begin
{
  if FStatus =  ksJoker then
    LoadResBmp('JOKER',FBitmap)
  else begin
}
    case FStatus of
      ksOpen: ID := FWaarde + Ord(FKleur)*13;
      ksDicht: ID := 52 + FKaartRugplaatje;
      ksO: ID := 68;
      ksX: ID := 67;
    else
      ID := 1;
    end;
    LoadDLLBmp('Cards.DLL',ID,FBitmap);
{
  end;
}  
end;

procedure TKaart.LoadDLLBmp(FileNaam: string; BmpId: Integer; Dest: TBitmap);
var
  Lib, rInfo, hMemory: THandle;
  rSize: Longint;
  pData: PByte;
  BmpHdr: TBitmapFileHeader;
  stream: TMemoryStream;
begin
  Lib := LoadLibrary(PChar(FileNaam));
  if Lib < HINSTANCE_ERROR then raise Exception.CreateFmt(Err1,['Cards.DLL']);
  rInfo := FindResource(Lib, MakeIntResource(BmpId), rt_Bitmap);
  if rInfo = 0 then raise Exception.CreateFmt(Err2,[BmpId,'FindResource']);
  hMemory := LoadResource(Lib,rInfo);
  try
    if hMemory = 0 then raise Exception.CreateFmt(Err2,[BmpId,'LoadResource']);
    pData := LockResource(hMemory);
    try
      rSize := SizeofResource(Lib,rInfo);
      if rSize = 0 then raise Exception.CreateFmt(Err3,[BmpId]);
      stream := TMemoryStream.Create;
      try
        BmpHdr.bfType := $4D42;
        stream.SetSize(sizeof(BmpHdr)+rSize);
        stream.Write(BmpHdr,sizeof(BmpHdr));
        stream.Write(pData^,rSize);
        stream.Seek(0,0);
        Dest.LoadFromStream(stream);
      finally
        stream.Free;
      end;
    finally
      UnlockResource(hMemory);
    end;
  finally
    FreeResource(hMemory);
  end;
end;

{
procedure TKaart.LoadResBmp(Naam: string; Dest: TBitmap);
var
  HResInfo: THandle;
  BMF: TBitmapFileHeader;
  MemHandle: THandle;
  Stream: TMemoryStream;
  ResPtr: PByte;
  ResSize: Longint;
begin
  BMF.bfType := $4D42;
  HResInfo := FindResource(HInstance,PChar(Name),RT_Bitmap);
  ResSize := SizeofResource(HInstance, HResInfo);
  MemHandle := LoadResource(HInstance, HResInfo);
  ResPtr := LockResource(MemHandle);
  Stream := TMemoryStream.Create;
  Stream.SetSize(ResSize + SizeOf(BMF));
  Stream.Write(BMF, SizeOf(BMF));
  Stream.Write(ResPtr^, ResSize);
  FreeResource(MemHandle);
  Stream.Seek(0, 0);
  Dest.LoadFromStream(Stream);
  Stream.Free;
end;
}

procedure TKaart.Paint;
begin
  inherited;
  GetCardFromDLL;
  with Canvas do begin
    Draw(0,0,FBitmap);
    MoveTo(1,0);
    Pen.Color:=clBlack;
    LineTo(Width-1,0);
    LineTo(Width-1,1);
    LineTo(Width-1,Height-1);
    LineTo(Width-1,Height-1);
    LineTo(1,Height-1);
    LineTo(0,Height-1);
    LineTo(0,1);
    LineTo(1,0);
    Pixels[1,1]:=clBlack;
    Pixels[1,Height-2]:=clBlack;
    Pixels[Width-2,1]:=clBlack;
    Pixels[Width-2,Height-2]:=clBlack;
    Pixels[0,0] := TForm(Parent).Color;
    Pixels[0,Height-1] := TForm(Parent).Color;
    Pixels[Width-1,0] := TForm(Parent).Color;
    Pixels[Width-1,Height-1] := TForm(Parent).Color;
  end;
  Width:=FBitmap.Width;
  Height:=FBitmap.Height;
end;

procedure TKaart.SetKaartRugplaatje(const Value: Integer);
begin
  if (Value > 13) or (Value < 1) then exit;
  if Value <> FKaartRugplaatje then begin
    FKaartRugplaatje := Value;
    Invalidate;
  end;
end;

procedure TKaart.SetKleur(const Value: TKaartKleur);
begin
  if Value <> FKleur then
  begin
    FKleur := Value;
    Invalidate;
  end;
end;

procedure TKaart.SetStatus(const Value: TKaartStatus);
begin
  if Value <> FStatus then begin
    FStatus := Value;
    Invalidate;
  end;
end;

procedure TKaart.SetWaarde(const Value: Integer);
begin
  if (Value > 13) or (Value < 1) then exit;
  if Value <> FWaarde then
  begin
    FWaarde := Value;
    Invalidate;
  end;
end;

end.
