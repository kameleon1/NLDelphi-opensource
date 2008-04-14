unit FMain;

interface
uses
  Forms,
  Classes,
  Controls,
  Graphics,
  StdCtrls,
  NLDMsgBox;

type
  TfrmMain = class(TForm)
    mbTest:           TNLDMessageBox;
    cmdNormal:        TButton;
    cmdCustomIcon:    TButton;
    cmdCheckbox:      TButton;
    cmdPositioned:    TButton;
    cmdCentered:      TButton;
    cmdCenterText:    TButton;
    cmdAutoClose:     TButton;
    cmdFull:          TButton;

    procedure FormCreate(Sender: TObject);
    procedure cmdNormalClick(Sender: TObject);
    procedure cmdCustomIconClick(Sender: TObject);
    procedure cmdCheckboxClick(Sender: TObject);
    procedure cmdPositionedClick(Sender: TObject);
    procedure cmdCenteredClick(Sender: TObject);
    procedure cmdCenterTextClick(Sender: TObject);
    procedure cmdAutoCloseClick(Sender: TObject);
    procedure cmdFullClick(Sender: TObject);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate;
begin
  mbTest.Parent := Self.Handle;
end;


procedure TfrmMain.cmdNormalClick;
begin
  with mbTest do begin
    Options := [];
    Execute();
  end;
end;

procedure TfrmMain.cmdCustomIconClick;
begin
  with mbTest do begin
    Options := [boCustomIcon];
    Execute();
  end;
end;

procedure TfrmMain.cmdCheckboxClick;
begin
  with mbTest do begin
    Options := [boCheckBox];
    Execute();

    // You can use the Checked property here...
  end;
end;

procedure TfrmMain.cmdPositionedClick;
begin
  with mbTest do begin
    Options     := [boPositioned];
    Execute();
  end;
end;

procedure TfrmMain.cmdCenteredClick;
begin
  with mbTest do begin
    Options     := [boCentered];
    Execute();
  end;
end;

procedure TfrmMain.cmdCenterTextClick;
begin
  with mbTest do begin
    Options     := [boTextCentered];
    Execute();
  end;
end;

procedure TfrmMain.cmdAutoCloseClick;
begin
  with mbTest do begin
    Options     := [boAutoClose];
    Execute();
  end;
end;

procedure TfrmMain.cmdFullClick;
begin
  with mbTest do begin
    Options     := [boCustomIcon, boCheckBox, boPositioned, boTextCentered,
                    boAutoClose];
    Execute();
  end;
end;

end.
