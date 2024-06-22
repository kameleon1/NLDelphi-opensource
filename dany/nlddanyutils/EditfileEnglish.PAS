unit EditfileEnglish;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls,

  ync_frm_e, RcsStrings;

type
  TEditFileForm = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    SluitenButton: TButton;
    BewaarButton: TButton;
    Title: TPanel;
    PrintButton: TButton;
    FindButton: TButton;
    FindNextButton: TButton;
    procedure SluitenButtonClick(Sender: TObject);
    procedure BewaarButtonClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PrintButtonClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FindNextButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ZoekString: string;
    procedure UpdateKeys;
    procedure PrepareEdit(cap, title, filename: string; create: boolean);
  public
    { Public declarations }
    CurrentFileName: string;
    function Edit(cap, title, filename: string; create: boolean): TModalResult;
    function AddEdit(cap, title, filename: string; create: boolean; toadd:
      string): TModalResult; overload;
    function AddEdit(cap, title, filename: string; create: boolean; toadd:
      TStrings): TModalresult; overload;
  end;

var
  EditFileForm: TEditFileForm;

implementation

{$R *.DFM}

uses Printers;

procedure TEditFileForm.SluitenButtonClick(Sender: TObject);
begin
  //close;
end;

procedure TEditFileForm.UpdateKeys;
begin
  BewaarButton.Visible := Memo1.Modified;
  PrintButton.Visible := memo1.Lines.Count > 0;
  FindNextButton.Visible := ZoekString > '';
end;

procedure TEditFileForm.BewaarButtonClick(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(CurrentFileName);
  Memo1.Modified := false;
  UpDateKeys;
  SluitenButton.ModalResult := mrOk;
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
    res := YncForm.Show_it('File changed. Save?');
    if (res = mrYes) then
      begin
        Memo1.Lines.SaveToFile(CurrentFileName);
        //SluitenButton.ModalResult := mrOk;
        EditFileForm.ModalResult := mrOk;
      end;
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
    assignfile(f, CurrentFileName);
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

function TEditFileForm.Edit(cap, title, filename: string;
  create: boolean): TModalResult;
begin
  PrepareEdit(cap, title, filename, create);
  Memo1.Modified := false;
  UpdateKeys;
  Result := EditFileForm.ShowModal;
  {EditFileForm.WindowState := wsNormal;}
end;

function TEditFileForm.AddEdit(cap, title, filename: string; create: boolean;
  toadd: string): TModalResult;
begin
  PrepareEdit(cap, title, filename, create);
  Memo1.Lines.Add(toadd);
  Memo1.Modified := true;
  UpdateKeys;
  Result := EditFileForm.ShowModal;
end;

function TEditFileForm.AddEdit(cap, title, filename: string; create: boolean; toadd:
  TStrings): TModalResult;
begin
  PrepareEdit(cap, title, filename, create);
  Memo1.Lines.AddStrings(toadd);
  Memo1.Modified := true;
  UpdateKeys;
  Result := EditFileForm.ShowModal;
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

procedure TEditFileForm.FindButtonClick(Sender: TObject);
var P: Integer;
begin
  Inputquery('Search', '', ZoekString);
  if ZoekString > '' then
  begin
    P := Pos(Uppercase(ZoekString), Uppercase(Memo1.Text));
    if P > 0 then
    begin
      Memo1.SelStart := P - 1;
      Memo1.SelLength := Length(ZoekString);
    end else Memo1.SelLength := 0;
    Memo1.SetFocus;
  end;
  FindNextButton.enabled := true;
  UpdateKeys;
end;

procedure TEditFileForm.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  case ord(Key) of
    3: SluitenButtonClick(Sender);                                 // control C  -- close --
    6: if FindButton.Visible then  FindButtonClick(Sender);        // control F  -- Find --
   14: if FindNextButton.Visible then FindNextButtonClick(Sender); // control N  -- FindNext --
   16: if PrintButton.Visible then PrintButtonClick(Sender);       // control P  -- Print --
   19: if BewaarButton.Visible then BewaarButtonClick(Sender);     // control S  -- Save --
  end;

end;

procedure TEditFileForm.FormCreate(Sender: TObject);
begin
  ZoekString := '';
end;

procedure TEditFileForm.FindNextButtonClick(Sender: TObject);
var PartOf: string;
  Start: integer;
  P: integer;
begin
  Start := Memo1.SelStart + Memo1.SelLength + 1;
  PartOf := copy(Memo1.Text, Start, MaxInt);
  begin
    P := Pos(Uppercase(ZoekString), Uppercase(PartOf));
    if P > 0 then
    begin
      P := P + Start - 1;
      Memo1.SelStart := P - 1;
      Memo1.SelLength := Length(ZoekString);
    end else
    begin
      Memo1.SelLength := 0;
      FindNextButton.enabled := false;
    end;
    Memo1.SetFocus;
  end;
end;

procedure TEditFileForm.FormShow(Sender: TObject);
begin
  SluitenButton.ModalResult := mrCancel;
end;

end.
