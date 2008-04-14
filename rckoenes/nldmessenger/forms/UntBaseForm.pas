{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntBaseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLxForms, ExtCtrls, ImgList;

type
  TFrmBaseForm = class(TTntFormLx)
    TmrFlash: TTimer;
    procedure TntFormLXPaint(Sender: TObject);
    procedure TntFormLXClose(Sender: TObject; var Action: TCloseAction);
    procedure TmrFlashTimer(Sender: TObject);
    procedure TntFormLXActivate(Sender: TObject);
  private
    { Private declarations }
    FStayOnTop : boolean;
    HideInTaskBar : Boolean;
    Procedure SetStayOnTop(Value : boolean);
  published
    { Public declarations }
    property StayOnTop : boolean Read FStayOnTop write SetStayOnTop default false;
  Public
    constructor Create(HideInTaskBar : Boolean); reintroduce;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure FlashForm;
  end;

var
  FrmBaseForm: TFrmBaseForm;

implementation

{$R *.dfm}

{ TTntFormLX2 }

constructor TFrmBaseForm.Create(HideInTaskBar: Boolean);
begin
  Self.HideInTaskBar := HideInTaskBar;

  inherited Create(application);

  Self.Visible := true;

  if not Self.HideInTaskBar then
    Self.BringToFront;
end;

procedure TFrmBaseForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if Self.HideInTaskBar then
    Params.Style := Params.Style or WS_ICONIC;
  Params.WndParent := HWND_DESKTOP;
end;

procedure TFrmBaseForm.SetStayOnTop(Value: boolean);
begin
  if Value then
    With Self Do
      SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height,
                    SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE)
  else
    With Self Do
      SetWindowPos(Handle, HWND_NOTOPMOST, Left, Top, Width, Height,
                    SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE);

  FStayOnTop := Value;
end;

procedure TFrmBaseForm.TntFormLXPaint(Sender: TObject);
begin
//  SetZOrder(True);
end;

procedure TFrmBaseForm.TntFormLXClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TFrmBaseForm.TmrFlashTimer(Sender: TObject);
begin
  if self.Handle = GetForegroundWindow then
    begin
      self.TmrFlash.Enabled := false;
      FlashWindow(Self.Handle,False);
    end
  else
    FlashWindow(Self.Handle,True);
end;

procedure TFrmBaseForm.TntFormLXActivate(Sender: TObject);
begin
  if TmrFlash.Enabled then
    begin
      TmrFlash.Enabled := false;
      FlashWindow(Self.Handle,False);
    end;
end;

procedure TFrmBaseForm.FlashForm;
begin
  self.TmrFlash.Enabled := true;
end;

end.
