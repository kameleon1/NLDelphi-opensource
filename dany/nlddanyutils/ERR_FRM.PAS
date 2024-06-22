unit Err_frm;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TErrorForm = class(TForm)
    Error: TLabel;
    BitBtn1: TBitBtn;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure show(s: shortstring);
  end;

var
  ErrorForm: TErrorForm;

implementation

{$R *.DFM}

procedure TErrorForm.Show(s: shortstring);
begin
  ErrorForm.Error.Caption := s;
  ErrorForm.Showmodal;
end;

end.
