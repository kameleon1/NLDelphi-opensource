unit Regform;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, SimpleRegistry, FileCtrl, Math, ExtCtrls;

type
  TRegdata = record
    name: shortstring;
    code: shortstring;
  end;

type
  TRegistratieForm = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    DaysLeft: TLabel;
    Timer1: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    keyname: {short}string;
    filepath: {short}string;
    filename_date: {short}string;
    filename_regdata: {short}string;
    regkey: {short}string;
    period: byte;
    function readregister_date: integer;
    procedure writeregister_date(v: integer);
    function readfile_date: integer;
    procedure writefile_date(v: integer);
    function read_regdata: TRegdata;
    procedure write_regdata(v: TRegdata);
  public
    { Public declarations }
    procedure init(kn, fp, fn, k: {short}string; per: byte);
    procedure check_registratie;
    function programme_registered: boolean;
    function days_left: integer;
  end;

var
  RegistratieForm: TRegistratieForm;

implementation

{$R *.DFM}

uses CalcCode, StrEncDec;

var
  reg_changed: boolean;

procedure TRegistratieForm.init(kn, fp, fn, k: {short}string; per: byte);
var
  buff: array[0..max_path] of char;
  s: ansistring;
  registerdate: integer;
  filedate: integer;
  curtime: TTimeStamp;
  filename_regd : string; // to be deleted
begin
  GetWindowsDirectory(@buff, max_path);

  s := buff;
  fp := IncludeTrailingbackslash(IncludeTrailingBackslash(s) + fp);

  keyname := kn; // keyname in the registry
  filename_date := fn; // first use date filename
  filename_regd := fn + '_'; // "Registered" filename, to be deleted
  filename_regdata := fn + '__'; // Register Name and Number filename
  filepath := fp; // filepath for the registerfile(s)
  regkey := k;
  period := per;

  if FileExists(fp + filename_regd) then DeleteFile(fp + Filename_regd); // to be deleted

  registerdate := readregister_date;
  filedate := readfile_date;

  if (registerdate = 0) and (filedate = 0) then
  begin
    { write current date to register and file }
    curtime := DateTimeToTimeStamp(Now);
    registerdate := curtime.Date;
    writeregister_date(registerdate);
    writefile_date(registerdate);
  end
  else if (registerdate > 0) and (filedate = 0) then
  begin
    { write registertime to file }
    writefile_date(registerdate);
  end
  else if (registerdate = 0) and (filedate > 0) then
  begin
    { write filetime to register}
    writeregister_date(filedate);
  end
  else
  begin
    if (registerdate <> filedate) then
    begin
      registerdate := min(registerdate, filedate);
      writeregister_date(registerdate);
      writefile_date(registerdate);
    end;
  end;
  Timer1.Enabled := true;
end;

function TRegistratieForm.readregister_date: integer;
var
  TheReg: TSimpleRegistry;
begin
  TheReg := TSimpleRegistry.Create;
  try
    TheReg.RootKey := HKEY_CURRENT_USER;
    result := TheReg.ReadInteger(Keyname, 'Reg', 0);
    TheReg.DeleteValue(Keyname, 'Ok'); // not used value, to be deleted
  finally
    TheReg.Free;
  end;
end;

procedure TRegistratieForm.writeregister_date(v: integer);
var
  TheReg: TSimpleRegistry;
begin
  TheReg := TSimpleRegistry.Create;
  try
    TheReg.WriteInteger(KeyName, 'Reg', v);
  finally
    TheReg.Free;
  end;
end;

function TRegistratieForm.readfile_date: integer;
var
  v: integer;
  f: file of integer;
begin
  result := 0;
  if fileexists(filepath + filename_date) then
  begin
    assignfile(f, filepath + filename_date);
    reset(f);
    read(f, v);
    closefile(f);
    result := v;
  end;
end;

procedure TRegistratieForm.writefile_date(v: integer);
var
  f: file of integer;
begin
  SysUtils.forcedirectories(filepath);
  assignfile(f, filepath + filename_date);
  rewrite(f);
  write(f, v);
  closefile(f);
  FileSetAttr(filepath + filename_date,
    FileGetAttr(filepath + filename_date) or faHidden);
  FileSetAttr(filepath + filename_date,
    FileGetAttr(filepath + filename_date) and (not faArchive));
end;

procedure TRegistratieForm.write_regdata(v: TRegdata);
var
  f: file of TRegdata;
begin
  SysUtils.forcedirectories(filepath);
  assignfile(f, filepath + filename_regdata);
  rewrite(f);
  write(f, v);
  closefile(f);
end;

function TRegistratieForm.read_regdata: TRegdata;
var
  f: file of TRegdata;
  d: TRegdata;
begin
  if fileexists(filepath + filename_regdata) then
  begin
    assignfile(f, filepath + filename_regdata);
    reset(f);
    read(f, d);
    closefile(f);
    Result := d;
  end
  else
  begin
    Result.name := '';
    Result.code := '';
    write_regdata(result);
  end;
end;

function TRegistratieForm.programme_registered: boolean;
var r: TRegdata;
begin
  r := read_regdata;
  Result := (r.code = regcode(regkey, r.name));
  Result := true;
end;

function TRegistratieForm.days_left: integer;
var
  registerdate: integer;
  curtime: TTimeStamp;
begin
  registerdate := readregister_date;
  curtime := DateTimeToTimeStamp(Now);
  result := (registerdate + period) - curtime.Date;
  if (result > period) then
    result := 0;
end;

procedure TRegistratieForm.check_registratie;
begin
  if not programme_registered then
    ShowModal;
end;

procedure TRegistratieForm.BitBtn1Click(Sender: TObject);
var
  r: TRegdata;
begin
  if reg_changed then
  begin
    if (Edit2.Text = regcode(regkey, Edit1.Text))
    then showmessage(str_decode('Wknq|~{i{oj$dcoxdewj'))
    else showmessage(str_decode('Wknq|~{i{oj$rpkwlwy''()*'));
    r.name := Edit1.Text;
    r.code := Edit2.Text;
    write_regdata(r);
  end;
end;

procedure TRegistratieForm.Edit1Change(Sender: TObject);
begin
  reg_changed := true;
end;

procedure TRegistratieForm.FormShow(Sender: TObject);
var
  r: TRegdata;
begin
  r := read_regdata;
  Edit1.Text := r.name;
  Edit2.Text := r.code;
  if not programme_registered then
  begin
    label1.Caption := str_decode('Io{(y|xoygrqd"ju#rtm''vro}(nkwijktvuijxk)');
    GroupBox1.Caption := str_decode(
      'Wknq|~{mlx%ss<!jwxu@67~}nzz4xo|pfv1fj5is;C?=>>4Huq0kqhj~5p}wH+ykl');
    if (days_left <= 0) then
      DaysLeft.caption := str_decode('Ukyqxnn(}gs$ytjl#kjhy}ru)~vuwfll/')
    else
      DaysLeft.caption := str_decode('Sun(') + inttostr(days_left) +
        str_decode('%jhonx)~yoo$jgctxmp&v~n|7');
  end
  else
  begin
    Label1.Caption := str_decode('Io{(y|xoygrqd"ju#kjxlor}}zlkwh');
    GroupBox1.Caption := '';
    DaysLeft.caption := '';
  end;
  reg_changed := false;
  ActiveControl := BitBtn1;
end;

procedure TRegistratieForm.Timer1Timer(Sender: TObject);
begin
  if (not visible) and
     (not programme_registered) and
     (days_left <= 0) then Application.Terminate;
end;

end.
