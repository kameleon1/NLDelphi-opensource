{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntConnect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, ExtCtrls, StdCtrls, TntStdCtrls, ImgList;

type
  TFrmConnect = class(TTntForm)
    LblConnect: TTntLabel;
    ImgConnect: TImage;
    TmrAnimate: TTimer;
    procedure TntFormResize(Sender: TObject);
    procedure LblConnectMouseEnter(Sender: TObject);
    procedure LblConnectMouseLeave(Sender: TObject);
    procedure LblConnectClick(Sender: TObject);
    procedure TmrAnimateTimer(Sender: TObject);
    procedure TntFormCreate(Sender: TObject);
  private
    { Private declarations }
    AnimateIndex : Integer;
    FLogOnEnable : Boolean;
    ShowLogon    : Boolean;
  public
    { Public declarations }
    Property  LogOnEnable : Boolean read FLogOnEnable write FLogOnEnable default True;
    Procedure StartAnimatedLogo;
    Procedure StopAnimatedLogo;
    Procedure SetLabeltext(Value:WideString);
    Procedure ResetConnect;
  end;

var
  FrmConnect: TFrmConnect;

implementation

uses
  UntMain, UntScreenHandler;

{$R *.dfm}

procedure TFrmConnect.TntFormResize(Sender: TObject);
begin
  LblConnect.Width := Self.Width -8;
  ImgConnect.Left := (self.Width div 2) -27;
end;

procedure TFrmConnect.LblConnectMouseEnter(Sender: TObject);
begin
  if (Self.ShowLogon) then
    begin
      LblConnect.Font.Color := clBlue;
      LblConnect.Width := Self.Width -8;
    end;
end;

procedure TFrmConnect.LblConnectMouseLeave(Sender: TObject);
begin
  LblConnect.Font.Color := clBlack;
  LblConnect.Width := Self.Width -8;
end;

procedure TFrmConnect.LblConnectClick(Sender: TObject);
begin
  if ShowLogon then
    if  ScreenHandler.Showlogon then
    begin
      Self.ShowLogon := False;
      Self.StartAnimatedLogo;
      Self.SetLabeltext('Connecting ...');
    end;
end;

procedure TFrmConnect.TmrAnimateTimer(Sender: TObject);
begin
 ImgConnect.Canvas.Brush.Color := clWhite;
 ImgConnect.Canvas.FillRect(ImgConnect.Canvas.ClipRect);
 FrmMain.ImgLsAnimate.Draw(ImgConnect.Canvas,0,0,AnimateIndex,true);

 Inc(AnimateIndex);

 if AnimateIndex > FrmMain.ImgLsAnimate.Count -1 then
   AnimateIndex := 0;
end;

procedure TFrmConnect.StartAnimatedLogo;
begin
  TmrAnimate.Enabled := True;
end;

procedure TFrmConnect.StopAnimatedLogo;
begin
  TmrAnimate.Enabled := false;
  // reset the Animate timer index
  AnimateIndex := 0;

  // clear the image (logo)
  ImgConnect.Canvas.Brush.Color := clWhite;
  ImgConnect.Canvas.FillRect(ImgConnect.Canvas.ClipRect);

  // Draw TSIM logo in image
  FrmMain.ImgLsAnimate.Draw(ImgConnect.Canvas,0,0,AnimateIndex,true);
end;

procedure TFrmConnect.SetLabeltext(Value: WideString);
begin
  LblConnect.Caption  := Value;
  LblConnect.Width  := Self.Width -8;
end;

procedure TFrmConnect.TntFormCreate(Sender: TObject);
begin
  ShowLogon := True;
  AnimateIndex := 0;
  FrmMain.ImgLsAnimate.Draw(ImgConnect.Canvas,0,0,AnimateIndex,true);
end;

procedure TFrmConnect.ResetConnect;
begin
  self.StopAnimatedLogo;
  ShowLogon := true;
  self.LblConnect.Caption := 'Click here to Logon';

  LblConnect.Width := Self.Width -8;
  ImgConnect.Left := (self.Width div 2) -27;
end;

end.
