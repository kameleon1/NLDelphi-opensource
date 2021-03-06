{ *************************************************************************** }
{                                                                             }
{ NLDPicture  -  www.nldelphi.com Open Source designtime component            }
{                                                                             }
{ Initiator: Albert de Weerd (aka NGLN)                                       }
{ License: Free to use, free to modify                                        }
{ SVN path: http://svn.nldelphi.com/nldelphi/opensource/ngln/NLDPicture       }
{                                                                             }
{ *************************************************************************** }
{                                                                             }
{ Edit by: Albert de Weerd                                                    }
{ Date: December 13, 2008                                                     }
{ Version: 2.0.0.3                                                            }
{                                                                             }
{ *************************************************************************** }

unit NLDPicture;

interface

uses
  Classes, Graphics, Forms, SysUtils, Dialogs, Jpeg;

type
  TCustomNLDPicture = class(TComponent)
  private
    FAutoSize: Boolean;
    FBitmap: TBitmap;
    FBitmapResName: String;
    FFileName: TFileName;
    FHeight: Integer;
    FJpegResName: String;
    FInternalLoading: Boolean;
    FOnChanged: TNotifyEvent;
    FPicture: TPicture;
    FStretched: Boolean;
    FWidth: Integer;
    function IsPictureStored: Boolean;
    function IsSizeStored: Boolean;
    procedure PictureChanged(Sender: TObject);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetBitmapResName(const Value: String);
    procedure SetFileName(const Value: TFileName);
    procedure SetHeight(const Value: Integer);
    procedure SetJpegResName(const Value: String);
    procedure SetPicture(const Value: TPicture);
    procedure SetStretched(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
  protected
    procedure Changed;
    procedure RefreshBitmap; virtual;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property BitmapResName: String read FBitmapResName write SetBitmapResName;
    property FileName: TFileName read FFileName write SetFileName;
    property Height: Integer read FHeight write SetHeight
      stored IsSizeStored;
    property JpegResName: String read FJpegResName write SetJpegResName;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property Picture: TPicture read FPicture write SetPicture
      stored IsPictureStored;
    property Stretched: Boolean read FStretched write SetStretched
      default False;
    property Width: Integer read FWidth write SetWidth
      stored IsSizeStored;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    function Empty: Boolean;
    procedure SetSize(const AWidth, AHeight: Integer;
      const NotifyChange: Boolean);
    property Bitmap: TBitmap read FBitmap;
  end;

  TNLDPicture = class(TCustomNLDPicture)
  published
    property AutoSize;
    property BitmapResName;
    property OnChanged;
    property FileName;
    property Height;
    property JpegResName;
    property Picture;
    property Stretched;
    property Width;
  end;

implementation

{ TCustomNLDPicture }

resourcestring
  SFileNotFound = 'File not found: %s';
  SJpegResType = 'JPEG';

procedure TCustomNLDPicture.Assign(Source: TPersistent);
begin
  if Source is TCustomNLDPicture then
  begin
    FAutoSize := TCustomNLDPicture(Source).FAutoSize;
    FBitmapResName := TCustomNLDPicture(Source).FBitmapResName;
    FFileName := TCustomNLDPicture(Source).FFileName;
    FHeight := TCustomNLDPicture(Source).FHeight;
    FJpegResName := TCustomNLDPicture(Source).FJpegResName;
    FOnChanged := TCustomNLDPicture(Source).FOnChanged;
    FPicture.Assign(TCustomNLDPicture(Source).FPicture);
    FStretched := TCustomNLDPicture(Source).FStretched;
    FWidth := TCustomNLDPicture(Source).FWidth;
    RefreshBitmap;
    Changed;
  end
  else
    inherited Assign(Source);
end;

procedure TCustomNLDPicture.Changed;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

constructor TCustomNLDPicture.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBitmap := TBitmap.Create;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  if not ((AOwner is TCustomForm) or (AOwner is TDataModule)) then
    SetSubcomponent(True);
end;

destructor TCustomNLDPicture.Destroy;
begin
  FPicture.Free;
  FBitmap.Free;
  inherited Destroy;
end;

function TCustomNLDPicture.Empty: Boolean;
begin
  Result := not Assigned(FPicture.Graphic);
  if not Result then
    Result := FPicture.Graphic.Empty;
end;

function TCustomNLDPicture.IsPictureStored: Boolean;
begin
  Result := (FFileName = '') and (FBitmapResName = '') and
    (FJpegResName = '') and (not Empty);
end;

function TCustomNLDPicture.IsSizeStored: Boolean;
begin
  Result := not FAutoSize;
end;

procedure TCustomNLDPicture.PictureChanged(Sender: TObject);
begin
  if not FInternalLoading then
  begin
    FBitmapResName := '';
    FFileName := '';
    FJpegResName := '';
  end;
  if FAutoSize then
  begin
    FWidth := FPicture.Width;
    FHeight := FPicture.Height;
  end;
  RefreshBitmap;
  Changed;
end;

procedure TCustomNLDPicture.RefreshBitmap;
begin
  if Empty then
  begin
    FBitmap.Width := 0;
    FBitmap.Height := 0;
  end
  else
  begin
    FBitmap.Width := FWidth;
    FBitmap.Height := FHeight;
    if FStretched then
      FBitmap.Canvas.StretchDraw(Rect(0, 0, FWidth, FHeight), FPicture.Graphic)
    else
      FBitmap.Canvas.Draw(0, 0, FPicture.Graphic);
  end;
end;

procedure TCustomNLDPicture.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if FAutoSize then
    begin
      FStretched := False;
      FWidth := FPicture.Width;
      FHeight := FPicture.Height;
      RefreshBitmap;
    end;
    Changed;
  end;
end;

procedure TCustomNLDPicture.SetBitmapResName(const Value: String);
begin
  if FBitmapResName <> Value then
    try
      FInternalLoading := True;
      FBitmapResName := Value;
      FFileName := '';
      FJpegResName := '';
      if FBitmapResName = '' then
        FPicture.Graphic := nil
      else
        try
          FPicture.Bitmap.LoadFromResourceName(HInstance, FBitmapResName);
        except
          on E: EResNotFound do
          begin
            FPicture.Graphic := nil;
            if not (csDesigning in ComponentState) then
              raise;
          end
          else
            raise;
        end;
    finally
      FInternalLoading := False;
  end;
end;

procedure TCustomNLDPicture.SetFileName(const Value: TFileName);
begin
  if FFileName <> Value then
    try
      FInternalLoading := True;
      FFileName := Value;
      FBitmapResName := '';
      FJpegResName := '';
      if FFileName = '' then
        FPicture.Graphic := nil
      else
        try
          if FileExists(FFileName) then
            FPicture.LoadFromFile(FFileName)
          else
            raise EInvalidGraphic.CreateFmt(SFileNotFound, [FFileName]);
        except
          on E: EInvalidGraphic do
          begin
            FPicture.Graphic := nil;
            if csDesigning in ComponentState then
              ShowMessage(E.Message)
            else
              raise;
          end;
        else
          raise;
        end;
    finally
      FInternalLoading := False;
  end;
end;

procedure TCustomNLDPicture.SetHeight(const Value: Integer);
begin
  if FHeight <> Value then
    if (not FAutoSize) and (Value >= 0) then
    begin
      FHeight := Value;
      RefreshBitmap;
      Changed;
    end;
end;

procedure TCustomNLDPicture.SetJpegResName(const Value: String);
var
  Stream: TStream;
  Jpg: TJPEGImage;
begin
  if FJpegResName <> Value then
    try
      FInternalLoading := True;
      FJpegResName := Value;
      FBitmapResName := '';
      FFileName := '';
      if FJpegResName = '' then
        FPicture.Graphic := nil
      else
        try
          Stream := TResourceStream.Create(HInstance, FJpegResName,
            PChar(SJpegResType));
          Jpg := TJPEGImage.Create;
          try
            Jpg.LoadFromStream(Stream);
            FPicture.Graphic := Jpg;
          finally
            Jpg.Free;
            Stream.Free;
          end;
        except
          on E: EResNotFound do
          begin
            FPicture.Graphic := nil;
            if not (csDesigning in ComponentState) then
              raise;
          end
          else
            raise;
        end;
    finally
      FInternalLoading := False;
  end;
end;

procedure TCustomNLDPicture.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TCustomNLDPicture.SetSize(const AWidth, AHeight: Integer;
  const NotifyChange: Boolean);
begin
  if (FWidth <> AWidth) or (FHeight <> AHeight) then
    if not FAutoSize then
    begin
      if AWidth >= 0 then
        FWidth := AWidth;
      if AHeight >= 0 then
        FHeight := AHeight;
      RefreshBitmap;
      if NotifyChange then
        Changed;
    end;
end;

procedure TCustomNLDPicture.SetStretched(const Value: Boolean);
begin
  if FStretched <> Value then
    if not FAutoSize then
    begin
      FStretched := Value;
      RefreshBitmap;
      Changed;
    end;
end;

procedure TCustomNLDPicture.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
    if (not FAutoSize) and (Value >= 0) then
    begin
      FWidth := Value;
      RefreshBitmap;
      Changed;
    end;
end;

end.
