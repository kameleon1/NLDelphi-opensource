{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLXForms, StdCtrls, TntStdCtrls, Buttons, TntButtons,
  ExtCtrls, TntExtCtrls, ComCtrls, TntComCtrls;

type
  TFrmBrowser = class(TTntFormLX)
    PnlTop: TTntPanel;
    TntStatusBar1: TTntStatusBar;
    TntListView1: TTntListView;
    BtnBack: TTntSpeedButton;
    BtnFoward: TTntSpeedButton;
    BtnStop: TTntSpeedButton;
    BtnRefresh: TTntSpeedButton;
    TntComboBox1: TTntComboBox;
    BtnHome: TTntSpeedButton;
    TntSpeedButton1: TTntSpeedButton;
    TmrLogo: TTimer;
    PnlLogo: TTntPanel;
    ImgLogo: TTntImage;
    procedure TntFormLXCreate(Sender: TObject);
    procedure TmrLogoTimer(Sender: TObject);
    procedure BtnBackClick(Sender: TObject);
    procedure BtnFowardClick(Sender: TObject);
  private
    { Private declarations }
    AnimateIndex : Integer;
    Procedure StartLogoLoop;
    Procedure StopLogoLoop;
    Procedure DrawLogo(Index: integer);
  public
    { Public declarations }
  end;

var
  FrmBrowser: TFrmBrowser;

implementation

uses UntMain;

{$R *.dfm}

{ TFrmBrowser }

procedure TFrmBrowser.StartLogoLoop;
begin
  TmrLogo.Enabled := True;
end;

procedure TFrmBrowser.StopLogoLoop;
begin
  TmrLogo.Enabled := False;
  DrawLogo(0);
end;

procedure TFrmBrowser.TntFormLXCreate(Sender: TObject);
begin
  DrawLogo(0);
end;

procedure TFrmBrowser.TmrLogoTimer(Sender: TObject);
begin
  DrawLogo(AnimateIndex);

  Inc(AnimateIndex);

  if AnimateIndex > FrmMain.ImgLsAnimate.Count -1 then
    AnimateIndex := 0;
end;

procedure TFrmBrowser.DrawLogo(Index: integer);
begin
   ImgLogo.Canvas.Brush.Color := clWhite;
   ImgLogo.Canvas.FillRect(ImgLogo.Canvas.ClipRect);
   FrmMain.ImgLsAnimate.Draw(ImgLogo.Canvas,0,0,Index,true);
end;

procedure TFrmBrowser.BtnBackClick(Sender: TObject);
begin
  StartLogoLoop;
end;

procedure TFrmBrowser.BtnFowardClick(Sender: TObject);
begin
  StopLogoLoop;
end;

end.
