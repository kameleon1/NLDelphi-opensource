unit UHoofd;

interface

uses
  Windows, Classes, Controls, Forms, Dialogs, UKaarten, Menus;

type
  TMijnKaart = class
    Kleur: TKaartKleur;
    Waarde: Integer;
  end;
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Spel1: TMenuItem;
    Deel1: TMenuItem;
    N1: TMenuItem;
    Afsluiten1: TMenuItem;
    Help1: TMenuItem;
    Doelvanhetspel1: TMenuItem;
    Info1: TMenuItem;
    procedure Afsluiten1Click(Sender: TObject);
    procedure Deel1Click(Sender: TObject);
    procedure Doelvanhetspel1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure KaartGeslotenClick(Sender: TObject);
    procedure KaartOpenClick(Sender: TObject);
    procedure KaartPyramideClick(Sender: TObject);
  private
    { Private declarations }
    Afstand: Integer;
    Boven: Array[1..28] of Integer;
    Gesloten: TList;
    Kaarten: Array[1..52] of Integer;
    KaartBreedte: Integer;
    KaartGesloten: TKaart;
    KaartHoogte: Integer;
    KaartOpen: TKaart;
    Links: Array[1..28] of Integer;
    Open: TList;
    Pyramides: Array[1..28] of TKaart;
    PyrKrt: Array[1..28,1..2] of Integer;
    Top: Array[1..3] of Boolean;
    procedure ControleerKaarten;
    procedure DefinePyramide;
    procedure Initieer;
    procedure SchudKaarten;
    procedure WisLijsten;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure swap(var a, b: integer);
begin
  a := a xor b;
  b := b xor a;
  a := a xor b;
end;

procedure TForm1.Afsluiten1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ControleerKaarten;
var
  i: Integer;
begin
  for i := 1 to 28 do begin
    if ((PyrKrt[i, 1] = 0) or (not Pyramides[PyrKrt[i, 1]].Visible))
    and ((PyrKrt[i, 2] = 0) or (not Pyramides[PyrKrt[i, 2]].Visible)) then
      Pyramides[i].Status := ksOpen;
  end;
  if not Pyramides[1].Visible
           and not Pyramides[2].Visible and not Pyramides[3].Visible then begin
    if MessageDlg('U heeft gewonnen!'+#13+#10+'Nog een spel?', mtInformation, [mbYes,mbNo], 0) = mrYes then begin
      Deel1Click(nil);
    end else begin
      WisLijsten;
      KaartGesloten.Status := ksDicht;
      KaartOpen.Status := ksO;
    end;
  end
end;

procedure TForm1.Deel1Click(Sender: TObject);
var
  i : Integer;
  Kaart : TMijnKaart;
begin
  Screen.Cursor := crHourGlass;
  Initieer;
  for i := 1 to 3 do
    Top[i] := False;
  WisLijsten;
  SchudKaarten;
  // De eerste 28 kaarten worden op de pyramides geplaats.
  // De laatste 10 kaarten zijn open.
  for i := 1 to 28 do begin
    with Pyramides[i] do begin
      Waarde := (Kaarten[i] mod 13) + 1;
      case (Kaarten[i] div 13) of
        0: Kleur := kkKlaver;
        1: Kleur := kkRuiten;
        2: Kleur := kkHarten;
        3: Kleur := kkSchoppen;
      end;
      Visible := True;
      if i > 18 then
        Status := ksOpen
      else
        Status := ksDicht;
      KaartRugplaatje := KaartGesloten.KaartRugplaatje;
    end;
  end;
  // De overige kaarten komen op de gesloten stack.
  for i := 29 to 52 do begin
    Kaart := TMijnKaart.Create;
    Kaart.Waarde := (Kaarten[i] mod 13) + 1;
    case (Kaarten[i] div 13) of
      0: Kaart.Kleur := kkKlaver;
      1: Kaart.Kleur := kkRuiten;
      2: Kaart.Kleur := kkHarten;
      3: Kaart.Kleur := kkSchoppen;
    end;
    Gesloten.Add(Kaart);
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.DefinePyramide;
// Iedere kaart kan door 1 of 2 kaarten overlapt worden in de pyramides.
// Deze array geeft aam welke kaarten de huidige overlappen.
// De kaarten in de pyramide liggen dus als volgt:
//       01          02          03
//     04  05      06  07      08  09
//   10  11  12  13  14  15  16  17  18
// 19  20  21  22  23  24  25  26  27  28
// Kaart 1 (de top van de linker pyramide) wordt dus overlapt door kaart 4 en 5
// Een kaart ligt dicht tot beide kaarten die hem overlappen zijn weggespeeld.
begin
  PyrKrt[1,1] := 4;  PyrKrt[1,2] := 5;
  PyrKrt[2,1] := 6;  PyrKrt[2,2] := 7;
  PyrKrt[3,1] := 8;  PyrKrt[3,2] := 9;
  PyrKrt[4,1] := 10;  PyrKrt[4,2] := 11;
  PyrKrt[5,1] := 11;  PyrKrt[5,2] := 12;
  PyrKrt[6,1] := 13;  PyrKrt[6,2] := 14;
  PyrKrt[7,1] := 14;  PyrKrt[7,2] := 15;
  PyrKrt[8,1] := 16;  PyrKrt[8,2] := 17;
  PyrKrt[9,1] := 17;  PyrKrt[9,2] := 18;
  PyrKrt[10,1] := 19;  PyrKrt[10,2] := 20;
  PyrKrt[11,1] := 20;  PyrKrt[11,2] := 21;
  PyrKrt[12,1] := 21;  PyrKrt[12,2] := 22;
  PyrKrt[13,1] := 22;  PyrKrt[13,2] := 23;
  PyrKrt[14,1] := 23;  PyrKrt[14,2] := 24;
  PyrKrt[15,1] := 24;  PyrKrt[15,2] := 25;
  PyrKrt[16,1] := 25;  PyrKrt[16,2] := 26;
  PyrKrt[17,1] := 26;  PyrKrt[17,2] := 27;
  PyrKrt[18,1] := 27;  PyrKrt[18,2] := 28;
  PyrKrt[19,1] := 0;  PyrKrt[19,2] := 0;
  PyrKrt[20,1] := 0;  PyrKrt[20,2] := 0;
  PyrKrt[21,1] := 0;  PyrKrt[21,2] := 0;
  PyrKrt[22,1] := 0;  PyrKrt[22,2] := 0;
  PyrKrt[23,1] := 0;  PyrKrt[23,2] := 0;
  PyrKrt[24,1] := 0;  PyrKrt[24,2] := 0;
  PyrKrt[25,1] := 0;  PyrKrt[25,2] := 0;
  PyrKrt[26,1] := 0;  PyrKrt[26,2] := 0;
  PyrKrt[27,1] := 0;  PyrKrt[27,2] := 0;
  PyrKrt[28,1] := 0;  PyrKrt[28,2] := 0;
end;

procedure TForm1.Doelvanhetspel1Click(Sender: TObject);
begin
//
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Variabelen voor het tekenen van de kaarten.
  KaartBreedte := 71;  KaartHoogte := 96;  Afstand := 20;
  Randomize;
  Open := TList.Create;     // Lijstje van gespeelde kaarten (open stack)
  Gesloten := TList.Create; // Lijstje van te spelen kaarten (gesloten stack)
  Initieer;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
// Eerst zelf alles weer vrij geven.
  KaartOpen.Free;
  KaartGesloten.Free;
  for i := 1 to 28 do
    Pyramides[i].Free;
  WisLijsten;
  Open.Free;
  Gesloten.Free;
end;

procedure TForm1.Info1Click(Sender: TObject);
begin
//
end;

procedure TForm1.Initieer;
var
  i: Integer;
begin
// Links en Boven zijn array's waar de "top" en "left" van de kaarten in
// opgeslagen kunnen worden. Deze top en left zijn natuurlijk nodig voor het
// plaatsen van de kaarten op de tafel.
  for i := 19 to 28 do begin
    Links[i] := 10 + ((i - 19) * (KaartBreedte + 5));
    Boven[i] := 10 + 3 * Afstand;
  end;
  for i := 10 to 18 do begin
    Links[i] := 10 + (KaartBreedte div 2) + ((i - 10) * (KaartBreedte + 5));
    Boven[i] := 10 + 2 * Afstand;
  end;
  Links[4] := Links[20]; Links[5] := Links[21];
  Links[6] := Links[23]; Links[7] := Links[24];
  Links[8] := Links[26]; Links[9] := Links[27];
  for i := 4 to 9 do
    Boven[i] := 10 + Afstand;
  Links[1] := Links[11]; Links[2] := Links[14]; Links[3] := Links[17];
  for i := 1 to 3 do
    Boven[i] := 10;
  SchudKaarten;
  DefinePyramide;
  for i := 1 to 28 do begin
    Pyramides[i] := TKaart.Create(Self);
    Pyramides[i].Parent := Self;
    Pyramides[i].Top := Boven[i];
    Pyramides[i].Left := Links[i];
    Pyramides[i].Status := ksO;
    Pyramides[i].OnClick := KaartPyramideClick;
  end;
  KaartGesloten := TKaart.Create(Self);
  with KaartGesloten do begin
    Parent := Self;
    Height := KaartHoogte;
    Width := KaartBreedte;
    KaartRugplaatje := 5;
    Left := Links[23];
    Top := 2 * KaartHoogte;
    Status := ksDicht;
    OnClick := KaartGeslotenClick;
  end;
  KaartOpen := TKaart.Create(Self);
  with KaartOpen do begin
    Parent := Self;
    Height := KaartHoogte;
    Width := KaartBreedte;
    KaartRugplaatje := 5;
    Left := Links[24];
    Top := 2 * KaartHoogte;
    Status := ksO;
    OnClick := KaartOpenClick;
  end;
end;

procedure TForm1.KaartGeslotenClick(Sender: TObject);
begin
  if (KaartGesloten.Status <> ksX) and (Gesloten.Count <> 0) then begin
    KaartOpen.Status := ksDicht;
    Open.Add(Gesloten.Items[0]);
    KaartOpen.Kleur := TMijnKaart(Gesloten.Items[0]).Kleur;
    KaartOpen.Waarde := TMijnKaart(Gesloten.Items[0]).Waarde;
    KaartOpen.Status := ksOpen;
    Gesloten.Delete(0);
    if Gesloten.Count = 0 then
      KaartGesloten.Status := ksX;
  end;
end;

procedure TForm1.KaartOpenClick(Sender: TObject);
begin
  if Gesloten.Count = 0 then begin
    Gesloten.Assign(Open);
    Open.Clear;
    KaartOpen.Status := ksO;
    KaartGesloten.Status := ksDicht;
  end;
end;

procedure TForm1.KaartPyramideClick(Sender: TObject);
var
  KlikKaart, OpenKaart: TMijnKaart;
begin
// Als er op een kaart in de Pyramide geklikt wordt, wordt gecontroleerd of het
// verschil met de "open kaart" 1 is. Zo ja dan wordt de kaart op de open stack
// gelegd en kan men met de volgende kaart verder gaan.
  if Sender is TKaart then begin
    if TKaart(Sender).Status = ksOpen then begin
      KlikKaart := TMijnKaart.Create;
      KlikKaart.Waarde := TKaart(Sender).Waarde;
      KlikKaart.Kleur := TKaart(Sender).Kleur;
      OpenKaart := TMijnKaart(Open.Last);
      if (abs(KlikKaart.Waarde - OpenKaart.Waarde) = 1)
        or (abs(KlikKaart.Waarde - OpenKaart.Waarde) = 12) then begin
        Open.Add(KlikKaart);
        KaartOpen.Waarde := KlikKaart.Waarde;
        KaartOpen.Kleur := KlikKaart.Kleur;
        TKaart(Sender).Visible := False;
        ControleerKaarten;
      end else begin
        KlikKaart.Free;
      end;
    end;
  end;
end;

procedure TForm1.SchudKaarten;
var
  i, j: Integer;
  nu: Cardinal;
begin
// Het schudden der kaarten. Hier geïmplementeerd door gedurende een bepaalde
// tijd twee willekeurige kaarten van positie te laten wisselen.
// De bepaalde tijd is nu 1000 tick-en, dus zeg maar 1 seconde.
  for i := 1 to 52 do
    Kaarten[i] := i;
  nu := GetTickCount;
  repeat
    i := Random(52) + 1;
    j := Random(52) + 1;
    if i <> j then swap(Kaarten[i], Kaarten[j]);
  until GetTickCount > nu + 1000;
end;

procedure TForm1.WisLijsten;
var
  i: Integer;
begin
// Er voor zorgen dat alle kaarten weer opgeruimd worden.
  if Open.Count <> 0 then begin
    for i := (Open.Count - 1) downto 0 do begin
      TMijnKaart(Open.Items[i]).Free;
      Open.Delete(i);
    end;
  end;
  if Gesloten.Count <> 0 then begin
    for i := (Gesloten.Count - 1) downto 0 do begin
      TMijnKaart(Gesloten.Items[i]).Free;
      Gesloten.Delete(i);
    end;
  end;
end;

end.
