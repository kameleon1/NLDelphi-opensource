{ NLDSoundDialog

  - Componenten:

  TNLDOpenSoundDialog  -  TOpenDialog met voorbeeld optie voor audio bestanden.
  TNLDSaveSoundDialog  -  TSaveDialog met voorbeeld optie voor audio bestanden.

  - Geschiedenis:

  17-12-2002 - Component gedoneerd aan NLDelphi en eerste uitgave.

  - Disclaimer

  Deze units zijn gedoneerd aan de NLDelphi community. Doe ermee wat je wilt,
  maar ik zou het op prijs stellen als je eventuele suggesties, veranderingen,
  verbeteringen en bugreports aan mij doorgeeft. Oh ja, ik noch NLDelphi is
  op geen enkele manier aansprakelijk als er iets misgaat. :-)

  - Andere informatie

  Ik heb op verschillende plekken wat commentaar neergezet. Ook is er veel
  commented code van TOpenPictureDialog die ik als basis heb gebruikt. Die is
  niet meer nodig maar ik laat het er nog maar even staan.
  Ik vind het zonde om iets weg te gooien...

  Jan Wester (Jan_Wester@hotmail.com)                                          }

unit NLDSoundDialog;

interface

uses Windows, Classes, Messages, SysUtils, Dialogs, StdCtrls, ExtCtrls, Buttons, Graphics, Controls,
     MPlayer;

type
  { TNLDOpenSoundDialog }

  TNLDOpenSoundDialog = class(TOpenDialog)
  private                                
    FBackgroundPanel: TPanel;
    FExampleLabel: TLabel;
    FInfoLabel: TLabel;
    FStatusButton: TSpeedButton;
    FInfoPanel: TPanel;
    FMediaPlayer: TMediaPlayer;
    FSavedFilename: string;

    //FPlaySoundString: string;
    //FStopSoundString: string;
    //FExampleString: string;

    FPlaying: Boolean;

    function  IsFilterStored: Boolean;
    procedure MediaPlayerNotify(Sender: TObject);
  protected
    procedure StatusClick(Sender: TObject); virtual;
    procedure DoClose; override;
    procedure DoSelectionChange; override;
    procedure DoShow; override;

    procedure DoPlay; virtual;
    procedure DoStop; virtual;

    //property ImageCtrl: TImage read FImageCtrl;
    //property PictureLabel: TLabel read FPictureLabel;
  published
    property Filter stored IsFilterStored;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  { TNLDSaveSoundDialog }

  TNLDSaveSoundDialog = class(TNLDOpenSoundDialog)
  public
    function Execute: Boolean; override;
  end;

var
  SupportedMCIExtensions: string;

procedure Register;

implementation

uses Consts, Math, Forms, CommDlg, Dlgs, IniFiles;

{ Is er toevallig een of andere plek waar windoos deze constanten
  hieronder opslaat? Ik kom ze erg vaak gelocaliseerd tegen in
  windoos zelf (niet die media player rotzooi). BvD.              }

resourcestring
  SPlaySound = 'Play';
  SStopSound = 'Stop';
  SExample   = 'Example';
  SInformation = 'Information';

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDOpenSoundDialog, TNLDSaveSoundDialog]);
end;

{ function GetMCIFilter: string;

  Genereert een filter voor de TNLDOpenSoundDialog en
  TNLDSaveSoundDialog. Op het moment zeer improvisorisch
  ingericht, dus suggesties zijn welkom om het beter aan
  te pakken :-)                                          }

function GetMCIFilter: string;
var
  Ini: TIniFile;
  SL: TStringList;
  TmpExtern, TmpIntern: string;
  i: integer;
const
  EXT_TRAIL_EXTERN = ', '; { seperator voor zichtbare lijst }
  EXT_TRAIL_INTERN = ';';  { seperator voor onzichtbare 'werk' lijst }
begin
  Result := '';

  Ini := TIniFile.Create('WIN.INI');
  SL := TStringList.Create;
  try
    TmpExtern := ''; TmpIntern := '';

    Ini.ReadSection('mci extensions', SL);
    for i := 0 to SL.Count - 1 do
    begin
      TmpExtern := TmpIntern + '*.' + Lowercase(SL[i]) + EXT_TRAIL_EXTERN;
      TmpIntern := TmpIntern + '*.' + Lowercase(SL[i]) + EXT_TRAIL_INTERN;
    end;

    { verwijder het laatste staartje }
    Delete(TmpExtern, Length(TmpExtern) - Length(EXT_TRAIL_EXTERN), Length(EXT_TRAIL_EXTERN));
    Delete(TmpIntern, Length(TmpIntern) - Length(EXT_TRAIL_INTERN), Length(EXT_TRAIL_INTERN));

    SL.Clear;
    SL.Add('All sounds (' + TmpExtern + ')|' + TmpIntern);
    SL.Add('All files (*.*)|*.*');

    //SL.Delimiter := '|';
    //SL.QuoteChar := #0;

    for i := 0 to SL.Count - 1 do
      Result := Result + SL[i] + '|';

    Delete(Result, Length(Result), 1);

  finally
    Ini.Free;
    SL.Free;
  end;
end;

{ function MCISupportedExtensions: string;

  Genereert een lijst met MCI extensies in de vorm van:
  .abc.def.ghi (*.abc *.def *.ghi).                     }

function MCISupportedExtensions: string;
var
  Ini: TIniFile;
  SL: TStringList;
  i: integer;
begin
  Ini := TIniFile.Create('WIN.INI');
  SL := TStringList.Create;
  try
    Result := '';

    Ini.ReadSection('mci extensions', SL);
    for i := 0 to SL.Count - 1 do
      Result := Result + '.' + Lowercase(SL[i]);

  finally
    Ini.Free;
    SL.Free;
  end;
end;

{ TNLDOpenSoundDialog }

{$R NLDEXTDLG.RES}

constructor TNLDOpenSoundDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Filter := GetMCIFilter; //GraphicFilter(TGraphic);

  FBackgroundPanel := TPanel.Create(Self);
  with FBackgroundPanel do
  begin
    Name := 'BackgroundPanel';
    Caption := '';
    SetBounds(204, 5, 169, 200);
    BevelOuter := bvNone;
    BorderWidth := 6;
    TabOrder := 1;
    FInfoPanel := TPanel.Create(Self);
    with FInfoPanel do
    begin
      Name := 'InfoPanel';
      Caption := '';
      SetBounds(6, 29, 157, 145);
      Align := alClient;
      BevelInner := bvRaised;
      BevelOuter := bvLowered;
      TabOrder := 0;
      //FImageCtrl := TImage.Create(Self);
      Parent := FBackgroundPanel;
      {with FImageCtrl do
      begin
        Name := 'PaintBox';
        Align := alClient;
        //OnDblClick := PreviewClick;
        Parent := FPaintPanel;
        Proportional := True;
        Stretch := True;
        Center := True;
        IncrementalDisplay := True;
      end;}
    end;
    FStatusButton := TSpeedButton.Create(Self);
    with FStatusButton do
    begin
      Name := 'StatusButton';
      SetBounds(10, 30, 23, 22);
      Enabled := False;
      Glyph.LoadFromResourceName(HInstance, 'PLAYGLYPH');
      Hint := SPlaySound;
      ParentShowHint := False;
      ShowHint := True;
      OnClick := StatusClick;
      Parent := FInfoPanel;
    end;
    FInfoLabel := TLabel.Create(Self);
    with FInfoLabel do
    begin
      Name := 'InfoLabel';
      Caption := SInformation;
      SetBounds(10, 7, 100, 23);
      AutoSize := False;
      Parent := FInfoPanel;
    end;
    FExampleLabel := TLabel.Create(Self);
    with FExampleLabel do
    begin
      Name := 'ExampleLabel';
      Caption := SExample;
      SetBounds(45, 34, 50, 23);
      AutoSize := False;
      Parent := FInfoPanel;
    end;
    FMediaPlayer := TMediaPlayer.Create(Self);
    with FMediaPlayer do
    begin
      Name := 'MediaPlayer';
      Visible := False;
      Tabstop := False;
      Notify := True;
      OnNotify := MediaPlayerNotify;
      Parent := FInfoPanel;
    end;
  end;
end;

procedure TNLDOpenSoundDialog.DoSelectionChange;
var
  FullName: string;
  ValidSound: Boolean;

  function ValidFile(const FileName: string): Boolean;
  begin
    Result := GetFileAttributes(PChar(FileName)) <> $FFFFFFFF;
  end;

begin
  FullName := FileName;
  if FullName <> FSavedFilename then
  begin
    FSavedFilename := FullName;

    DoStop;
    FMediaPlayer.Close;

    ValidSound := FileExists(FullName) and ValidFile(FullName);
    if ValidSound then
    try
      //FImageCtrl.Picture.LoadFromFile(FullName);
      //FPictureLabel.Caption := Format(SPictureDesc,
      //  [FImageCtrl.Picture.Width, FImageCtrl.Picture.Height]);
      //FPreviewButton.Enabled := True;
      //FInfoPanel.Caption := '';

      { Beetje vreemde combinatie van informatie. Aangezien de MCI exceptions
        erg lastig zijn tijdens het debuggen haal ik de benodigde extensies uit
        WIN.INI om dubbel te controleren. Zou iemand kunnen verifieren dat ALLE
        supported mci extensions daar daadwerkelijk staan? BvD.                 }

      if Pos(LowerCase(ExtractFileExt(FileName)), SupportedMCIExtensions) <> 0 then
      begin
        FMediaPlayer.FileName := FileName;
        FMediaPlayer.Open;
        FStatusButton.Enabled := True;
      end
      else
        ValidSound := False;
    except
      ValidSound := False;
    end;
    if not ValidSound then
    begin
      FStatusButton.Enabled := False;
      //FPictureLabel.Caption := SPictureLabel;
      //FPreviewButton.Enabled := False;
      //FImageCtrl.Picture := nil;
      //FPaintPanel.Caption := srNone;
    end;
  end;
  inherited DoSelectionChange;
end;

procedure TNLDOpenSoundDialog.DoClose;
begin
  inherited DoClose;
  { Hide any hint windows left behind }
  Application.HideHint;
end;

procedure TNLDOpenSoundDialog.DoShow;
var
  PreviewRect, StaticRect: TRect;
begin
  { Set preview area to entire dialog }
  GetClientRect(Handle, PreviewRect);
  StaticRect := GetStaticRect;
  { Move preview area to right of static area }
  PreviewRect.Left := StaticRect.Left + (StaticRect.Right - StaticRect.Left);
  Inc(PreviewRect.Top, 4);
  FBackgroundPanel.BoundsRect := PreviewRect;
  //FPreviewButton.Left := FPaintPanel.BoundsRect.Right - FPreviewButton.Width - 2;
  //FImageCtrl.Picture := nil;
  FSavedFilename := '';
  //FInfoPanel.Caption := srNone;
  FBackgroundPanel.ParentWindow := Handle;

  FPlaying := False;

  inherited DoShow;
end;

function TNLDOpenSoundDialog.Execute;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'SOUNDTEMPLATE' else
    Template := nil;
  Result := inherited Execute;
end;

function TNLDOpenSoundDialog.IsFilterStored: Boolean;
begin
  //Result := not (Filter = GraphicFilter(TGraphic));
  Result := not (Filter = GetMCIFilter);
end;

procedure TNLDOpenSoundDialog.StatusClick(Sender: TObject);
begin
  if FPlaying then
    DoStop
  else
    DoPlay;
end;

procedure TNLDOpenSoundDialog.DoPlay;
begin
  if FPlaying then
    DoStop;

  try
    FMediaPlayer.Rewind;
    FMediaPlayer.Play;
    FPlaying := True;

    FStatusButton.Glyph.LoadFromResourceName(HInstance, 'STOPGLYPH');
    FStatusButton.Hint := SStopSound;
  except
    DoStop;
  end;
end;

procedure TNLDOpenSoundDialog.DoStop;
begin
  if FPlaying then
  begin
    FPlaying := False;
    FMediaPlayer.Stop;

    FStatusButton.Glyph.LoadFromResourceName(HInstance, 'PLAYGLYPH');
    FStatusButton.Hint := SPlaySound;
  end;
end;

procedure TNLDOpenSoundDialog.MediaPlayerNotify(Sender: TObject);
begin
  if (FMediaPlayer.Mode = mpStopped) then
  begin
    DoStop;
  end;

  //if (MediaPlayer.Mode = mpOpen) then
  //begin
  //  DoStop;
  //end;

  FMediaPlayer.Notify := True;
end;

{ TNLDSaveSoundDialog }

function TNLDSaveSoundDialog.Execute: Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'SOUNDTEMPLATE' else
    Template := nil;
  Result := DoExecute(@GetSaveFileName);
end;

{ -= Initialization =- }

initialization
  SupportedMCIExtensions := MCISupportedExtensions;
end.
