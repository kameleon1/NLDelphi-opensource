unit FMain;

interface

uses
  MLanguage,
  Forms,
  Classes,
  Controls,
  ExtCtrls,
  StdCtrls,
  ComCtrls,
  NLDTGlobal,
  NLDTManager,
  NLDTranslate;

type
  TfrmMain = class(TForm)
    nldTranslate:             TNLDTranslate;
    lstLanguages:             TListBox;
    pnlEnum:                  TPanel;
    sbStatus:                 TStatusBar;

    procedure FormCreate(Sender: TObject);
    procedure lstLanguagesClick(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate;
var
  iFile:        Integer;

begin
  // List available languages
  lstLanguages.Items.Add('[None (undo changes)]');
  
  with dmLanguage.nldtManager do
    for iFile := 0 to Files.Count - 1 do
      lstLanguages.Items.AddObject(Files[iFile].Description, Files[iFile]);

  lstLanguages.ItemIndex  := 0;
  if Assigned(lstLanguages.OnClick) then
    lstLanguages.OnClick(lstLanguages);
end;

procedure TfrmMain.lstLanguagesClick;
var
  pFile:        TNLDTFile;

begin
  pFile := TNLDTFile(lstLanguages.Items.Objects[lstLanguages.ItemIndex]);
  dmLanguage.nldtManager.ActiveFile := pFile;
end;

end.
