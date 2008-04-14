unit uHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmHistory = class(TForm)
    Bevel1: TBevel;
    BtOk: TBitBtn;
    MmoHistory: TMemo;
    procedure BtOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHistory: TfrmHistory;

implementation

uses uMain;

{$R *.dfm}

{=====================================================================================================}
{= Form Close Procedure, wordt door de Ok button aangeroepen.=========================================}
{=====================================================================================================}
procedure TfrmHistory.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {Toon Main Form.}
  frmMain.Show;
end;

{=====================================================================================================}
{= Ok Button Click Procedure, sluit scherm. ==========================================================}
{=====================================================================================================}
procedure TfrmHistory.BtOkClick(Sender: TObject);
begin
  {Sluit History Form.}
  frmHistory.Close;
end;

{=====================================================================================================}
{= FormShow Event, Set Form title. ===================================================================}
{=====================================================================================================}
procedure TfrmHistory.FormShow(Sender: TObject);
begin
  {Set Form Caption}
  frmHistory.Caption := cAPPLICATIETITELNLD + ' - [ History ]';
end;

end.
