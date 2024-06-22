unit Ync_frm;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TYNCForm = class(TForm)
    Image1: TImage;
    Mededeling: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function show_it(s: {short}string): word;
  end;

var
  YNCForm: TYNCForm;

implementation

{$R *.DFM}

function TYNCForm.show_it(s: {short}string): word;
begin
  YncForm.Mededeling.caption := s;
  Result := YncForm.ShowModal;
end;

procedure TYNCForm.FormShow(Sender: TObject);
begin
  ActiveControl := BitBtn1;
end;

end.
