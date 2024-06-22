unit Regform;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TRegistratieForm = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    Mess: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function programme_registered(key: shortstring):boolean;
  end;

var
  RegistratieForm: TRegistratieForm;
const
  Extension = '.DRO';  

implementation

{$R *.DFM}

uses  CalcCode;

var regfile : textfile;
    fn      : shortstring;
    reg_changed : boolean;


function TRegistratieForm.programme_registered(key: shortstring):boolean;
var res: boolean;
    s1, s2: shortstring;
begin
  res := true;
  fn := ChangeFileExt(ExtractFilename(paramstr(0)), Extension);
  if not fileexists(fn) then fn := 'Registratie';
  if not fileexists(fn)
  then res := false
  else begin
         assignfile(regfile, fn);
         reset(regfile);
         readln(regfile, s1); readln(regfile, s2);
         closefile(regfile);
         Edit1.Text := s1;
         Edit2.Text := s2;
         reg_changed := false;
         if (s2 <> regcode(key, s1)) then res := false;
       end;
  programme_registered := res;
end;

procedure TRegistratieForm.BitBtn1Click(Sender: TObject);
begin
  if reg_changed then
  begin
    fn := ChangeFileExt(ExtractFilename(paramstr(0)), Extension);
    assignfile(regfile, fn);
    rewrite(regfile);
    writeln(regfile, Edit1.Text);
    writeln(regfile, Edit2.Text);
    closefile(regfile);
  end;
end;

procedure TRegistratieForm.Edit1Change(Sender: TObject);
begin
  reg_changed := true;
end;

end.
