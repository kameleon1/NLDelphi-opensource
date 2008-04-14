unit DeXTree;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, VirtualTrees, Forms, Graphics;

type
  TDeXTree = class(TVirtualStringTree)
  private
    { Private declarations }
  protected
    procedure DoBeforeCellPaint(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

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
end;

procedure TDeXTree.DoBeforeCellPaint(Canvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellRect: TRect);
begin
  inherited;

  if Node.Index mod 2 = 0 then
  begin
    Canvas.Brush.Color :=  StringToColor('$00F0F0F0');
    Canvas.FillRect(CellRect);
  end;
end;

end.
