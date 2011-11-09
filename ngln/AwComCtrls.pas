unit AwComCtrls;

{$I AwFramework.inc}

interface

uses
  Windows, Classes, Controls, ComCtrls, Messages;

type
  TAwTabSheet = class(TTabSheet)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Resize; override;
    procedure WndProc(var Message: TMessage); override;
  end;

  TAwPageControl = class(TPageControl)
  private
    function GetPage(Index: Integer): TAwTabSheet;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Pages[Index: Integer]: TAwTabSheet read GetPage; default;
  end;

implementation

{ TAwTabSheet }

procedure TAwTabSheet.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    WindowClass.Style := WindowClass.Style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TAwTabSheet.Resize;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, 50, nil);
  inherited Resize;
end;

procedure TAwTabSheet.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_TIMER then
  begin
    KillTimer(Handle, 1);
    Invalidate;
  end
  else
    inherited WndProc(Message);
end;

{ TAwPageControl }

constructor TAwPageControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DoubleBuffered := True;
end;

procedure TAwPageControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    WindowClass.Style := WindowClass.Style and not (CS_HREDRAW or CS_VREDRAW);
end;

function TAwPageControl.GetPage(Index: Integer): TAwTabSheet;
begin
  Result := TAwTabSheet(inherited Pages[Index]);
end;

end.
