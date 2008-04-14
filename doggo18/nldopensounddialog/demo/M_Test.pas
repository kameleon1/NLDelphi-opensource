unit M_Test;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtDlgs;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses NLDSoundDialog;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  OSD: TNLDOpenSoundDialog;
begin
  OSD := TNLDOpenSoundDialog.Create(self);
  try
    OSD.Execute;
  finally
    OSD.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  OPD: TOpenPictureDialog;
begin
  OPD := TOpenPictureDialog.Create(self);
  try
    OPD.Execute;
  finally
    OPD.Free;
  end;
end;

end.
