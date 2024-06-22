unit Editfile;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls,

  ync_frm, RcsStrings;

type
  TEditFileForm = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    SluitenButton: TButton;
    BewaarButton: TButton;
    Title: TPanel;
    PrintButton: TButton;
    ZoekButton: TButton;
    procedure SluitenButtonClick(Sender: TObject);
    procedure BewaarButtonClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PrintButtonClick(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure ZoekButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ZoekString: string;
    procedure UpdateKeys;
    procedure PrepareEdit(cap, title, filename: string; create: boolean);
  public
    { Public declarations }
    CurrentFileName: string;
    procedure Edit(cap, title, filename: string; create: boolean);
    procedure AddEdit(cap, title, filename: string; create: boolean; toadd:
      string); overload;
    procedure AddEdit(cap, title, filename: string; create: boolean; toadd:
      TStrings); overload;
    procedure EditReplace(cap, title, filename: string; create: boolean; ToReplace:
      string; Index: Integer);
  end;

var
  EditFileForm: TEditFileForm;

implementation

{$R *.DFM}

uses Printers;

procedure TEditFileForm.SluitenButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TEditFileForm.UpdateKeys;
begin
  BewaarButton.Visible := Memo1.Modified;
  PrintButton.Visible := memo1.Lines.Count > 0;
end;

procedure TEditFileForm.BewaarButtonClick(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(CurrentFileName);
  Memo1.Modified := false;
  UpDateKeys;
end;

procedure TEditFileForm.Memo1Change(Sender: TObject);
begin
  UpdateKeys;
end;

procedure TEditFileForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  res: word;
begin
  if Memo1.Modified then
  begin
    WindowState := wsNormal;
    BringToFront;
    res := YncForm.Show_it('Gewijzigd. Opslaan?');
    if (res = mrYes) then
      Memo1.Lines.SaveToFile(CurrentFileName);
    if (res = mrCancel) then
      CanClose := false;
  end;
end;

procedure TEditFileForm.PrepareEdit(cap, title, filename: string;
  create: boolean);
var
  f: TextFile;
begin
  Memo1.Clear;
  CurrentFileName := trim(filename);

  if (not fileexists(CurrentFileName)) and create then
  begin { create file }
    AssignFile(f, CurrentFileName);
    rewrite(f);
    closefile(f);
  end;

  cap := trim(cap);
  EditFileForm.Caption := cap;
  title := trim(title);
  if (title = '') then
    EditFileForm.Title.Visible := false
  else
  begin
    EditFileForm.Title.Visible := true;
    EditFileForm.Title.Caption := title;
  end;

  if FileExists(CurrentFileName) then
    Memo1.Lines.LoadFromFile(CurrentFileName);
end;

procedure TEditFileForm.Edit(cap, title, filename: string;
  create: boolean);
begin
  PrepareEdit(cap, title, filename, create);
  Memo1.Modified := false;
  UpdateKeys;
  EditFileForm.ShowModal;
end;

procedure TEditFileForm.AddEdit(cap, title, filename: string; create: boolean;
  toadd: string);
begin
  PrepareEdit(cap, title, filename, create);
  Memo1.Lines.Add(toadd);
  Memo1.Modified := true;
  UpdateKeys;
  EditFileForm.ShowModal;
end;

procedure TEditFileForm.AddEdit(cap, title, filename: string; create: boolean; toadd:
      TStrings);
begin
  PrepareEdit(cap, title, filename, create);
  Memo1.Lines.AddStrings(toadd);
  Memo1.Modified := true;
  UpdateKeys;
  EditFileForm.ShowModal;
end;

procedure TEditFileForm.EditReplace(cap, title, filename: string; create: boolean; ToReplace:
      string; Index: Integer);
begin
  PrepareEdit(cap, title, filename, create);
  if (Index >= 0) and (Index < Memo1.Lines.Count)
  then Memo1.Lines[Index] := ToReplace;
  Memo1.Modified := true;
  UpdateKeys;
  EditFileForm.ShowModal;
end;

procedure TEditFileForm.PrintButtonClick(Sender: TObject);
var
  f: textfile;
  i: word;
begin
  AssignPrn(f);
  Rewrite(f);

  Printer.Canvas.Font.Name := 'Courier New';
  Printer.Canvas.Font.Size := 10;
  Printer.Canvas.Font.Style := [];

  for i := 0 to Memo1.Lines.Count - 1 do
    writeln(f, Memo1.Lines[i]);

  closefile(f);
end;

procedure TEditFileForm.Memo1KeyPress(Sender: TObject; var Key: Char);

begin
  if ord(Key) = 6 then ZoekButtonClick(Sender); // control F  -- Find --
  if ord(Key) = 19 then BewaarButtonClick(Sender); // control S   -- Save --
end;

procedure TEditFileForm.ZoekButtonClick(Sender: TObject);
var P : Integer;
begin
  Inputquery('Zoeken', 'Geef zoekterm', ZoekString);
    if ZoekString > '' then
    begin
      P := Pos(Uppercase(ZoekString), Uppercase(Memo1.Text));
      if P > 0 then
      begin
        Memo1.SelStart  := P - 1;
        Memo1.SelLength := Length(ZoekString);
      end else Memo1.SelLength := 0;
      Memo1.SetFocus;
    end;
end;

procedure TEditFileForm.FormShow(Sender: TObject);
begin
  Memo1.SetFocus;
end;

procedure TEditFileForm.FormCreate(Sender: TObject);
begin
  ZoekString := '';
end;

end.
