unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, JvLabel, JvHotLink,
  JvScrollText;

type
  TfrmAbout = class(TForm)
    BtOk: TBitBtn;
    Bevel1: TBevel;
    lblDate: TLabel;
    pnlTop: TPanel;
    imgAbout: TImage;
    lblTitle: TLabel;
    lblSubTitle: TLabel;
    JvHotLink1: TJvHotLink;
    Panel1: TPanel;
    JvScrollText1: TJvScrollText;
    Label2: TLabel;
    Label3: TLabel;
    JvHotLink2: TJvHotLink;
    Label4: TLabel;
    Label5: TLabel;
    procedure BtOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses uMain;

{$R *.dfm}

{=====================================================================================================}
{= Form Close Procedure, wordt door de Ok button aangeroepen.=========================================}
{=====================================================================================================}
procedure TfrmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {Toon Main Form.}
  frmMain.Show;
end;

{=====================================================================================================}
{= Ok Button Click Procedure, sluit scherm. ==========================================================}
{=====================================================================================================}
procedure TfrmAbout.BtOkClick(Sender: TObject);
begin
  {Set de Scrolling text op niet actief.}
  JvScrollText1.Active := False;

  {Sluit About Form.}
  frmAbout.Close;
end;

{=====================================================================================================}
{= FormShow Event, Set 'alle' title's en captions. en start de scrolling text. =======================}
{=====================================================================================================}
procedure TfrmAbout.FormShow(Sender: TObject);
begin
  {Set Form Caption}
  frmAbout.Caption := cAPPLICATIETITELNLD + ' - [ About ]';

  {Set Title Caption, dit ivm het huidige versie nummer.}
  lblTitle.Caption := 'NLD-Software [ Down && Up Stream Traffic ' + cAPPLICATIEVERSIE + ' ]';

  {Set de Datum Caption, dit ivm de last changed datum.}
  lblDate.Caption := 'Date : ' + cDATELASTCHANGED;

  {Set de Scrolling text op actief.}
  JvScrollText1.Active := True;
end;

end.

