{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLXForms, StdCtrls, TntStdCtrls, ExtCtrls, ComCtrls,
  TntComCtrls, TntExtCtrls, Buttons, TntButtons, TntDialogs, ImgList, Spin,
  TSFontBox;

type
  TFrmSettings = class(TTntFormLX)
    PnlBottom: TTntPanel;
    Bevel1: TBevel;
    TntButton1: TTntButton;
    TntButton2: TTntButton;
    PnlClient: TTntPanel;
    PnlTop: TTntPanel;
    PageControl: TTntPageControl;
    TabSound: TTntTabSheet;
    TabGeneral: TTntTabSheet;
    TabDialogs: TTntTabSheet;
    LblLabel: TTntLabel;
    Shape1: TShape;
    Shape2: TShape;
    ImgLogo: TImage;
    LnlOnline: TTntLabel;
    lblMessage: TTntLabel;
    LblOffline: TTntLabel;
    LblSubscription: TTntLabel;
    EdtOnline: TTntEdit;
    EdtOffline: TTntEdit;
    EdtMessage: TTntEdit;
    EdtSubscription: TTntEdit;
    OpenDialog: TTntOpenDialog;
    lvSettings: TTntListView;
    ImgLstSettings: TImageList;
    TntBitBtn1: TTntBitBtn;
    TntBitBtn2: TTntBitBtn;
    TntBitBtn3: TTntBitBtn;
    TntBitBtn4: TTntBitBtn;
    TntGroupBox1: TTntGroupBox;
    TntCheckBox1: TTntCheckBox;
    TntCheckBox2: TTntCheckBox;
    TntCheckBox3: TTntCheckBox;
    TntGroupBox2: TTntGroupBox;
    TntCheckBox4: TTntCheckBox;
    TntGroupBox3: TTntGroupBox;
    TntCheckBox5: TTntCheckBox;
    TntGroupBox4: TTntGroupBox;
    TntCheckBox6: TTntCheckBox;
    TntGroupBox5: TTntGroupBox;
    TntLabel2: TTntLabel;
    ColorBox1: TColorBox;
    pnlPreview: TTntPanel;
    lblSystem: TTntLabel;
    lblTime: TTntLabel;
    lblUserName: TTntLabel;
    lblNormal: TTntLabel;
    lblYourUserName: TTntLabel;
    lblNormal2: TTntLabel;
    lblTime2: TTntLabel;
    TntLabel10: TTntLabel;
    ColorBoxBG: TColorBox;
    TntGroupBox6: TTntGroupBox;
    Fontbox: TTSFontBox;
    TntLabel1: TTntLabel;
    TntLabel3: TTntLabel;
    FontSize: TSpinEdit;
    pnlFontPreview: TTntPanel;
    TntCheckBox7: TTntCheckBox;
    lblError: TTntLabel;
    cboSelect: TTntComboBox;
    procedure TntFormLXClose(Sender: TObject; var Action: TCloseAction);
    procedure lvSettingsClick(Sender: TObject);
    procedure TntFormLXShow(Sender: TObject);
    procedure TabGeneralShow(Sender: TObject);
    procedure TabSoundShow(Sender: TObject);
    procedure TabDialogsShow(Sender: TObject);
    procedure ColorBoxBGChange(Sender: TObject);
    procedure FontboxChange(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure lblSystemClick(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure cboSelectChange(Sender: TObject);
    procedure TntButton2Click(Sender: TObject);
    procedure TntButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure savesettings();
  public
    { Public declarations }
  end;

var
  FrmSettings: TFrmSettings;

implementation

uses
  UntMain, UntConfig;

{$R *.dfm}

procedure TFrmSettings.TntFormLXClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action := caFree;

 ScreenHandler.FreeSettings;
end;

procedure TFrmSettings.lvSettingsClick(Sender: TObject);
begin
  if not (lvSettings.Selected = NIL ) then
    begin
      PageControl.ActivePageIndex := lvSettings.Selected.Index;
    end;
end;

procedure TFrmSettings.TntFormLXShow(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;

  pnlFontPreview.Font.Name    := ProgSettings.TextFont.FontName;
  pnlFontPreview.Font.Size    := ProgSettings.TextFont.FontSize;

  Fontbox.Text := ProgSettings.TextFont.FontName;
  FontSize.Value := ProgSettings.TextFont.FontSize;


  pnlPreview.Color            := ProgSettings.TextFont.BackGround ;
  lblSystem.Font.Color        := ProgSettings.TextFont.System;
  lblTime.Font.Color          := ProgSettings.TextFont.Time;
  lblUserName.Font.Color      := ProgSettings.TextFont.Username;
  lblYourUserName.Font.Color  := ProgSettings.TextFont.YourUsername;
  lblNormal.Font.Color        := ProgSettings.TextFont.Normal;
  lblError.Font.Color         := ProgSettings.TextFont.Error;
end;

procedure TFrmSettings.TabGeneralShow(Sender: TObject);
begin
  LblLabel.Caption := 'General Settings';
end;

procedure TFrmSettings.TabSoundShow(Sender: TObject);
begin
  LblLabel.Caption := 'Sound Settings';
end;

procedure TFrmSettings.TabDialogsShow(Sender: TObject);
begin
  LblLabel.Caption := 'Dialog Settings';
end;

procedure TFrmSettings.ColorBoxBGChange(Sender: TObject);
begin
  pnlPreview.Color := ColorBoxBG.Selected;
end;

procedure TFrmSettings.savesettings;
begin
  ProgSettings.TextFont.FontName := pnlFontPreview.Font.Name;

  ProgSettings.TextFont.BackGround    := pnlPreview.Color;
  ProgSettings.TextFont.Username      := lblUserName.Font.Color;
  ProgSettings.TextFont.YourUsername  := lblYourUserName.Font.Color;
  ProgSettings.TextFont.System        := lblSystem.Font.Color;
  ProgSettings.TextFont.Time          := lblTime.Font.Color;
  ProgSettings.TextFont.Error         := lblError.Font.Color;
  ProgSettings.TextFont.Normal        := lblNormal.Font.Color
end;

procedure TFrmSettings.FontboxChange(Sender: TObject);
begin
  pnlFontPreview.Font.Name := FontBox.Text;
end;

procedure TFrmSettings.FontSizeChange(Sender: TObject);
begin
  pnlFontPreview.Font.Size := FontSize.Value;
end;

procedure TFrmSettings.lblSystemClick(Sender: TObject);
begin
  if (Sender = lblSystem) then
    cboSelect.ItemIndex := 0;
  if (Sender = lblTime) or (Sender = lblTime2) then
    cboSelect.ItemIndex := 1;
  if (Sender = lblUserName) then
    cboSelect.ItemIndex := 2;
  if (Sender = lblYourUserName) then
    cboSelect.ItemIndex := 3;
  if (Sender = lblNormal) or (Sender = lblNormal2) then
    cboSelect.ItemIndex := 4;
  if (Sender = lblError) then
    cboSelect.ItemIndex := 5;

  cboSelect.OnChange(Self);
end;

procedure TFrmSettings.ColorBox1Change(Sender: TObject);
begin
  case cboSelect.ItemIndex of
    0:  lblSystem.Font.Color := Colorbox1.Selected;
    1:  begin
          lblTime.Font.Color  := Colorbox1.Selected;
          lblTime2.Font.Color := Colorbox1.Selected;
        end;
    2:  lblUserName.Font.Color     := Colorbox1.Selected;
    3:  lblYourUserName.Font.Color := Colorbox1.Selected;
    4:  begin
          lblNormal.Font.Color  := Colorbox1.Selected;
          lblNormal2.Font.Color := Colorbox1.Selected;
        end;
    5:  lblError.Font.Color := Colorbox1.Selected;
  end;
end;

procedure TFrmSettings.cboSelectChange(Sender: TObject);
begin
  case cboSelect.ItemIndex of
    0:  Colorbox1.Selected := lblSystem.Font.Color;
    1:  begin
          Colorbox1.Selected := lblTime.Font.Color;
          Colorbox1.Selected := lblTime2.Font.Color;
        end;
    2:  Colorbox1.Selected := lblUserName.Font.Color;
    3:  Colorbox1.Selected := lblYourUserName.Font.Color;
    4:  begin
          Colorbox1.Selected := lblNormal.Font.Color;
          Colorbox1.Selected := lblNormal2.Font.Color;
        end;
    5:  Colorbox1.Selected := lblError.Font.Color;
  end;
end;

procedure TFrmSettings.TntButton2Click(Sender: TObject);
begin
  Self.savesettings;
  close;
end;

procedure TFrmSettings.TntButton1Click(Sender: TObject);
begin
  close;
end;

end.
