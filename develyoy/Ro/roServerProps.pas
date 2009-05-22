unit roServerProps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TServerPropWin = class(TForm)
    Label1: TLabel;
    aName: TEdit;
    Label2: TLabel;
    aHost: TEdit;
    Label3: TLabel;
    aPort: TEdit;
    Label4: TLabel;
    aDescription: TMemo;
    Label5: TLabel;
    aPorts: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DoConnect:boolean;
  end;

var
  ServerPropWin: TServerPropWin;

implementation

{$R *.dfm}

procedure TServerPropWin.Button3Click(Sender: TObject);
begin
 DoConnect:=true;
 ModalResult:=mrOk;
end;

procedure TServerPropWin.FormShow(Sender: TObject);
begin
 DoConnect:=false;
end;

end.
