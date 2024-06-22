unit Regform1;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Registry, FileCtrl, Math;

type  TRegdata = record
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
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    keyname  : shortstring;
    filepath : shortstring;
    filename_date : shortstring;
    filename_regd : shortstring;
    filename_regdata : shortstring;
    regkey   : shortstring;
    period   : byte;
    function readregister_date : integer;
    procedure writeregister_date(v: integer);
    function readfile_date : integer;
    procedure writefile_date(v: integer);
    function readregister_regd : integer;
    procedure writeregister_regd(v: integer);
    function readfile_regd : integer;
    procedure writefile_regd(v: integer);
    function read_regdata: TRegdata;
    procedure write_regdata(v: TRegdata);
  public
    { Public declarations }
    procedure init(kn, fp, fn, k: shortstring; per: byte);
    procedure check_registratie;
    function programme_registered:boolean;
    function days_left : integer;
  end;

var
  RegistratieForm: TRegistratieForm;

implementation

{$R *.DFM}

uses  CalcCode;

var reg_changed : boolean;

procedure TRegistratieForm.init(kn, fp, fn, k: shortstring; per: byte);
var buff : array[0..max_path] of char;
    s : ansistring;
    registerdate, filedate: integer;
    curtime : TTimeStamp;
begin
  GetWindowsDirectory(@buff, max_path);

  s  := buff;
  fp := IncludeTrailingbackslash(IncludeTrailingBackslash(s) + fp);

  keyname  := kn;
  filename_date := fn;
  filename_regd := fn + '_';
  filename_regdata := fn + '__';
  filepath := fp;
  regkey   := k;
  period   := per;

  registerdate := readregister_date;
  filedate     := readfile_date;

  if (registerdate = 0) and (filedate = 0) then
  begin
    { write current date to register and file }
    curtime := DateTimeToTimeStamp(Now);
    registerdate := curtime.Date;
    writeregister_date(registerdate);
    writefile_date(registerdate);
  end else
  if (registerdate > 0) and (filedate = 0) then
  begin
    { write registertime to file }
    writefile_date(registerdate);
  end else
  if (registerdate = 0) and (filedate > 0) then
  begin
    { write filetime to register}
    writeregister_date(filedate);
  end else
  begin
    if (registerdate <> filedate) then
    begin
      registerdate := min(registerdate, filedate);
      writeregister_date(registerdate);
      writefile_date(registerdate);
    end;
  end;
end;

function TRegistratieForm.readregister_date : integer;
var TheReg       : TRegistry;
begin
  result := 0;
  TheReg  := TRegistry.Create;
  TheReg.RootKey := HKEY_CURRENT_USER;
  if (TheReg.KeyExists(KeyName)) then
  begin { key exists }
    if TheReg.OpenKey(KeyName, False)
    then if TheReg.ValueExists('Reg') { value exists }
         then result := TheReg.ReadInteger('Reg');
  end;
  TheReg.Closekey;
  TheReg.Free;
end;

procedure TRegistratieForm.writeregister_date(v: integer);
var TheReg       : TRegistry;
begin
  TheReg  := TRegistry.Create;
  if TheReg.OpenKey(KeyName, True)
  then TheReg.WriteInteger('Reg', v);
  TheReg.Closekey;
  TheReg.Free;
end;

function TRegistratieForm.readfile_date : integer;
var v : integer;
    f : file of integer;
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
var f: file of integer;
begin
  forcedirectories(filepath);
  assignfile(f, filepath + filename_date);
  rewrite(f);
  write(f, v);
  closefile(f);
  FileSetAttr( filepath + filename_date,
               FileGetAttr(filepath + filename_date) or faHidden);
  FileSetAttr( filepath + filename_date,
               FileGetAttr(filepath + filename_date) and ( NOT faArchive));
end;

function TRegistratieForm.readregister_regd : integer;
var TheReg       : TRegistry;
begin
  result  := 0;
  TheReg  := TRegistry.Create;
  TheReg.RootKey := HKEY_CURRENT_USER;
  if (TheReg.KeyExists(KeyName)) then
  begin { key exists }
    if TheReg.OpenKey(KeyName, False)
    then if TheReg.ValueExists('Ok')
         then result := TheReg.ReadInteger('Ok');
  end;
  TheReg.Closekey;
  TheReg.Free;
end;

procedure TRegistratieForm.writeregister_regd(v: integer);
var TheReg       : TRegistry;
begin
  TheReg  := TRegistry.Create;
  TheReg.RootKey := HKEY_CURRENT_USER;
  if TheReg.OpenKey(KeyName, True)
  then TheReg.WriteInteger('Ok', v);
  TheReg.Closekey;
  TheReg.Free;
end;

function TRegistratieForm.readfile_regd: integer;
var v: integer;
    f: file of integer;
begin
  result := 0;
  if fileexists(filepath + filename_regd) then
  begin
    assignfile(f, filepath + filename_regd);
    reset(f);
    read(f, v);
    closefile(f);
    result := v;
  end;
end;

procedure TRegistratieForm.writefile_regd(v: integer);
var f: file of integer;
begin
  forcedirectories(filepath);
  assignfile(f, filepath + filename_regd);
  FileSetAttr( filepath + filename_regd,
               FileGetAttr(filepath + filename_regd) and (not faHidden));
  rewrite(f);
  write(f, v);
  closefile(f);
  FileSetAttr( filepath + filename_regd,
               FileGetAttr(filepath + filename_regd) or faHidden);
  FileSetAttr( filepath + filename_regd,
               FileGetAttr(filepath + filename_regd) and ( NOT faArchive))
end;

procedure TRegistratieForm.write_regdata(v: TRegdata);
var f: file of TRegdata;
begin
 forcedirectories(filepath);
 assignfile(f, filepath + filename_regdata);
 rewrite(f);
 write(f, v);
 closefile(f);
end;

function TRegistratieForm.read_regdata: TRegdata;
var f: file of TRegdata;
    d : TRegdata;
begin
  if fileexists(filepath + filename_regdata) then
  begin
    assignfile(f, filepath + filename_regdata);
    reset(f);
    read(f, d);
    closefile(f);
    Result := d;
  end else
  begin
    Result.name := '';
    Result.code := '';
    write_regdata(result);
  end;
end;

function TRegistratieForm.programme_registered:boolean;
var d: integer;
begin
  d := MAXINT - readregister_date;
  result := (readregister_regd = d) and (readfile_regd = d);
end;

function TRegistratieForm.days_left : integer;
var curtime      : TTimeStamp;
    registerdate : integer;
begin
  registerdate := readregister_date;
  curtime := DateTimeToTimeStamp(Now);
  result := (registerdate + period) - curtime.Date;
  if (result > period) then result := 0;
end;

procedure TRegistratieForm.check_registratie;
begin
  if not programme_registered then ShowModal;
end;

procedure TRegistratieForm.BitBtn1Click(Sender: TObject);
var regd : boolean;
    d : integer;
    r : TRegdata;
begin
  if reg_changed then
  begin
    regd := (Edit2.Text = regcode(regkey, Edit1.Text));
    if regd then
    begin
      d := MAXINT - readregister_date;
      writeregister_regd(d);
      writefile_regd(d);
      showmessage('Registration accepted');
    end else
    begin
      d := 0;
      writeregister_regd(d);
      writefile_regd(d);
      showmessage('Registration not correct!!!!');
    end;
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
var r: TRegdata;
begin
  r := read_regdata;
  Edit1.Text := r.name;
  Edit2.Text := r.code;
  if not programme_registered
  then
  begin
    label1.Caption := 'This program is not yet registered!';
    GroupBox1.Caption := 'Register now: (ask the registration code at rcs@skynet.be)';
    if (days_left <= 0)
    then DaysLeft.caption := 'Free usage period expired.'
    else DaysLeft.caption := 'Still ' + inttostr(days_left) + ' days of free usage left.';
  end
  else
  begin
    Label1.Caption := 'This program is registered';
    GroupBox1.Caption := '';
    DaysLeft.caption := '';
  end;
  reg_changed := false;
end;

end.
