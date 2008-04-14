unit TSFontBox;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, TntStdCtrls,Forms;

type
  TTSFontBox = class(TTntComboBox)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent);override;
    procedure CreateWnd; override;
  published
    { Published declarations }
    property Style default csDropDownList;
    property Items stored False;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TS', [TTSFontBox]);
end;

{ TTSFontBox }

constructor TTSFontBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csDropDownList;
end;

procedure TTSFontBox.CreateWnd;
begin
  inherited CreateWnd;
  Items.Assign(Screen.Fonts);
end;

end.
