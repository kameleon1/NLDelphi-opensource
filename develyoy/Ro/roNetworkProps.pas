unit roNetworkProps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TNetworkPropWin = class(TForm)
    Label1: TLabel;
    aName: TEdit;
    Label2: TLabel;
    aDescription: TMemo;
    aNick: TEdit;
    aAltNick: TEdit;
    aFullName: TEdit;
    aEmail: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DoConnect:boolean;
  end;

var
  NetworkPropWin: TNetworkPropWin;

implementation

{$R *.dfm}

procedure TNetworkPropWin.FormShow(Sender: TObject);
begin
 aName.SelectAll;
 DoConnect:=false;
end;

procedure TNetworkPropWin.Button3Click(Sender: TObject);
begin
 DoConnect:=true;
 ModalResult:=mrOk;
end;

end.
