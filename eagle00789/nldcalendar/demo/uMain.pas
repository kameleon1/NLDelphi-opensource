unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, NLDCalendar, StdCtrls, MPlayer, ExtCtrls, DateUtils;

type
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    NLDCalendar1: TNLDCalendar;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure NLDCalendar1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    procedure ZetKleurenEnHints;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if (key = VK_UP) or (key = VK_DOWN) then
  if key in [VK_UP,VK_DOWN] then
    key:=0;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  nldcalendar1.ShowHint:=checkbox1.checked;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  checkbox1.checked:=nldcalendar1.ShowHint;
  NLDCalendar1.UseCurrentDate := True;
  ZetKleurenEnHints;
  label1.caption:='';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ZetKleurenEnHints;
end;

procedure TForm1.ZetKleurenEnHints;
var
  dt:tdate;
begin
  with NLDCalendar1 do
  begin
    dt:=EncodeDate(YearOf(now()),MonthOf(now()),1);
    SetDateColor(dt,BGFGColor(clRed,clWindowText),'1 juli 2004');
    dt:=EncodeDate(YearOf(now()),MonthOf(now()),10);
    SetDateColor(dt,bgfgcolor(clblue,clYellow),'10 juli 2004');
    dt:=EncodeDate(YearOf(now()),MonthOf(now()),21);
    SetDateColor(dt,bgfgcolor(clteal,clWhite),'Nationale feestdag België');
    SetDateColor(dt,bgfgcolor(clteal,clWhite),'Eerste man landde 35 jaar geleden op de maan');
    dt:=EncodeDate(YearOf(now()),MonthOf(now()),25);
    SetDateColor(dt,bgfgcolor(clyellow,clMaroon),'Je staat nu linksonder in de kalender');
    dt:=EncodeDate(YearOf(now()),MonthOf(now()),23);
    SetDateColor(dt,bgfgcolor(clFuchsia,clLime),'23 juli 2004');
    dt:=EncodeDate(YearOf(now()),MonthOf(now()),5);
    SetDateColor(dt,bgfgcolor(clLime, clRed),'de vijfde dag van de zevende maand in het jaar tweeduizend vier');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  nldcalendar1.ResetColorsAndHints;
end;

procedure TForm1.NLDCalendar1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  gc:tgridcoord;
  dag:integer ;
begin
  gc:=nldcalendar1.MouseCoord(x,y);
  try
    dag:=strtoint(nldcalendar1.CellText[gc.x,gc.y]);
  except
    label1.caption:='';
    exit;
  end;
  label1.caption:=format('Dag = %d, Maand = %d, Jaar = %d',[dag,nldcalendar1.Month,nldcalendar1.Year]);
end;

end.
