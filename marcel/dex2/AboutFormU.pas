unit AboutFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvScrollText, StdCtrls, ExtCtrls, Buttons;

type
  TAboutForm = class(TForm)
    ScrollText: TJvScrollText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Versionlabel: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Image2: TImage;
    procedure Image2Click(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent); override;
  end;


implementation

{$R *.dfm}

uses
  JclFileUtils;

constructor TAboutForm.Create(AOwner: TComponent);
begin
  inherited;
  ScrollText.Active := True;

  with TJclFileVersionInfo.Create(Application.ExeName) do
    Versionlabel.Caption := FileVersion;

end;

procedure TAboutForm.Image2Click(Sender: TObject);
begin
  Close;
end;

end.
