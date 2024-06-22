unit Ync_frm_e;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

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
    function show_it(S: string): word;
  end;

var
  YNCForm: TYNCForm;

implementation

{$R *.DFM}

function TYNCForm.show_it(S: string): word;
begin
  YncForm.Mededeling.caption := S;
  show_it := YncForm.ShowModal;
end;

procedure TYNCForm.FormShow(Sender: TObject);
begin
  ActiveControl := BitBtn1;
end;

end.






