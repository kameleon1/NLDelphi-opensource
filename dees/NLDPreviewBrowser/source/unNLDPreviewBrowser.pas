unit unNLDPreviewBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, ComCtrls, DB, DBTables,
  ImgList, ToolWin, Buttons, Menus, ActiveX, StdActns, ActnList;

type
  TfrmNLDPreviewBrowser = class(TForm)
    stsBrowser: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    WebBrowser: TWebBrowser;
    ImageList1: TImageList;
    Panel3: TPanel;
    Panel4: TPanel;
    btnOpenen: TBitBtn;
    cmbAdres: TComboBox;
    Label1: TLabel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    ToolBar1: TToolBar;
    tlbTerug: TToolButton;
    tlbVerder: TToolButton;
    ToolButton3: TToolButton;
    tlbStop: TToolButton;
    tlbVernieuwen: TToolButton;
    tlbHome: TToolButton;
    ToolButton8: TToolButton;
    tlbInfo: TToolButton;
    MainMenu1: TMainMenu;
    Bestand1: TMenuItem;
    Bewerken1: TMenuItem;
    Info1: TMenuItem;
    Afsluiten1: TMenuItem;
    Info2: TMenuItem;
    ImageList2: TImageList;
    mnuKopieren: TMenuItem;
    mnuPlakken: TMenuItem;
    N1: TMenuItem;
    mnuAllesSelecteren: TMenuItem;
    N2: TMenuItem;
    Afdrukken1: TMenuItem;
    procedure btnOpenenClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WebBrowserTitleChange(Sender: TObject;
      const Text: WideString);
    procedure cmbAdresKeyPress(Sender: TObject; var Key: Char);
    procedure WebBrowserStatusTextChange(Sender: TObject;
      const Text: WideString);
    procedure FormCreate(Sender: TObject);
    procedure tlbTerugClick(Sender: TObject);
    procedure tlbVerderClick(Sender: TObject);
    procedure tlbInfoClick(Sender: TObject);
    procedure tlbStopClick(Sender: TObject);
    procedure tlbVernieuwenClick(Sender: TObject);
    procedure tlbHomeClick(Sender: TObject);
    procedure Info2Click(Sender: TObject);
    procedure Afsluiten1Click(Sender: TObject);
    procedure cmbAdresEnter(Sender: TObject);
    procedure cmbAdresExit(Sender: TObject);
    procedure mnuAllesSelecterenClick(Sender: TObject);
    procedure mnuKopierenClick(Sender: TObject);
    procedure mnuPlakkenClick(Sender: TObject);
    procedure Afdrukken1Click(Sender: TObject);
    procedure WebBrowserCommandStateChange(Sender: TObject;
      Command: Integer; Enable: WordBool);
    procedure WebBrowserNewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
  private
    { Private declarations }
    filename        :   String;
    blnOpenSite     :   Boolean;
    procedure OpenSite(adres:string);
  public
    { Public declarations }
  end;

var
  frmNLDPreviewBrowser: TfrmNLDPreviewBrowser;

implementation

uses
  unNLDPreviewBrowserHelp;

{$R *.dfm}

procedure TfrmNLDPreviewBrowser.btnOpenenClick(Sender: TObject);
begin
  {Open de pagina}
  OpenSite(cmbAdres.text);
  filename := cmbAdres.text;
end;

procedure TfrmNLDPreviewBrowser.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {Refresh de pagina}
  if key = vk_F5 then
    WebBrowser.Refresh;
end;

procedure TfrmNLDPreviewBrowser.WebBrowserTitleChange(Sender: TObject;
  const Text: WideString);
begin
  {Zet de Title van de pagina in de Titel van de Browser}
  Self.Caption := text;
end;

procedure TfrmNLDPreviewBrowser.cmbAdresKeyPress(Sender: TObject; var Key: Char);
begin
  {Controleer op welke knop er gedrukt wordt}
  if key = #13 then begin
    {Open site en maak Key-Code #0}
    OpenSite(cmbAdres.text);
    key := #0;
  end;
end;

procedure TfrmNLDPreviewBrowser.OpenSite(adres:string);
begin
  if trim(adres) <> '' then begin
    {Procedure voor het openen van de opgevraagde websites}
    Webbrowser.Navigate(adres);

    {Kijk of adres al voorkomt in de combobox}
    if cmbAdres.Items.IndexOf(adres) = -1  then begin
      cmbAdres.Items.Add(adres);

      {Sla adres op in combobox alleen nodig als het er nog niet instond}
      cmbAdres.Items.SaveToFile('adressen.txt');
    end;

    {SiteOpen waar - webbrowser focus geven}
    blnOpenSite := true;
    Webbrowser.SetFocus;
  end;
end;

procedure TfrmNLDPreviewBrowser.WebBrowserStatusTextChange(Sender: TObject;
  const Text: WideString);
begin
  {Zet de window.status text van het HTML bestand in de statusbar}
  stsBrowser.SimpleText := text;
end;

procedure TfrmNLDPreviewBrowser.FormCreate(Sender: TObject);
begin
  try
    {Controleer of adressen.txt bestaat, zoja laadt de adressen in de combo}
    if FileExists('adressen.txt') then
      cmbAdres.Items.LoadFromFile('adressen.txt');

    {Ga naar startpagina}
    Webbrowser.GoHome;
  except
  end;
end;

procedure TfrmNLDPreviewBrowser.tlbTerugClick(Sender: TObject);
begin
  try
    {Teruknop van de browser}
    if (blnOpenSite) then begin
      Webbrowser.GoBack;
    end;
  except
    on e:exception do
      showmessage('Er is een fout opgetreden: ' + e.Message);
  end;
end;

procedure TfrmNLDPreviewBrowser.tlbVerderClick(Sender: TObject);
begin
  try
    {Verder knop van de browser}
    if blnOpenSite then begin
      Webbrowser.GoForward;
    end;
  except
    on e:exception do
      showmessage('Er is een fout opgetreden: ' + e.Message);
  end;
end;

procedure TfrmNLDPreviewBrowser.tlbInfoClick(Sender: TObject);
begin
  {Maak frmInfo}
  if frmInfo = nil then
    Application.CreateForm(TfrmInfo, frmInfo);

  frmInfo.Show;
end;

procedure TfrmNLDPreviewBrowser.tlbStopClick(Sender: TObject);
begin
  try
    {Stoppen met openen van pagina in de browser}
    if blnOpenSite then
      Webbrowser.Stop;
  except
    on e:exception do
      showmessage('Er is een fout opgetreden: ' + e.Message);
  end;
end;

procedure TfrmNLDPreviewBrowser.tlbVernieuwenClick(Sender: TObject);
begin
  try
    {Refresh geven op de pagina}
    if blnOpenSite then
      Webbrowser.Refresh;
  except
    on e:exception do
      showmessage('Er is een fout opgetreden: ' + e.Message);
  end;
end;

procedure TfrmNLDPreviewBrowser.tlbHomeClick(Sender: TObject);
begin
  try
    {Open de startpagina in de browser}
    Webbrowser.GoHome;
  except
    on e:exception do
      showmessage('Er is een fout opgetreden: ' + e.Message);
  end;
end;

procedure TfrmNLDPreviewBrowser.Info2Click(Sender: TObject);
begin
  {Maak infoscherm}
  if frmInfo = nil then
    Application.CreateForm(TfrmInfo, frmInfo);

  frmInfo.Show;
end;

procedure TfrmNLDPreviewBrowser.Afsluiten1Click(Sender: TObject);
begin
  {Afsluiten applicatie}
  Application.Terminate;
end;

procedure TfrmNLDPreviewBrowser.cmbAdresEnter(Sender: TObject);
begin
  {Plakken van text in combobox enablen}
  mnuPlakken.Enabled := True;
end;

procedure TfrmNLDPreviewBrowser.cmbAdresExit(Sender: TObject);
begin
  {Plakken van text in combobox disablen}
  mnuPlakken.Enabled := False;
end;

procedure TfrmNLDPreviewBrowser.mnuAllesSelecterenClick(Sender: TObject);
begin
  {Controleer of er een pagina open is}
  if blnOpenSite then begin
    try
      {Selecteer alles in de browser}
      WebBrowser.ExecWB(OLECMDID_SELECTALL, OLECMDEXECOPT_PROMPTUSER);
    except
      on e:exception do
        showmessage('Er is een fout opgetreden: ' + e.Message);
    end;
  end;
end;

procedure TfrmNLDPreviewBrowser.mnuKopierenClick(Sender: TObject);
begin
  {Controleer of er een pagina open is}
  if blnOpenSite then begin
    try
      {Kopieren van gegevens}
      WebBrowser.ExecWB(OLECMDID_COPY, OLECMDEXECOPT_PROMPTUSER);
    except
      on e:exception do
        showmessage('Er is een fout opgetreden: ' + e.Message);
    end;
  end;
end;

procedure TfrmNLDPreviewBrowser.mnuPlakkenClick(Sender: TObject);
begin
  {Tekst plakken in de combobox}
  SendMessage (cmbadres.Handle, WM_Paste, 0, 0);
end;

procedure TfrmNLDPreviewBrowser.Afdrukken1Click(Sender: TObject);
begin
  {Controleer of er een pagina open is}
  if blnOpenSite then begin
    try
      {Afdrukken van de pagina}
      WebBrowser.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER);
    except
      on e:exception do
        showmessage('Er is een fout opgetreden: ' + e.Message);
    end;
  end;
end;

procedure TfrmNLDPreviewBrowser.WebBrowserCommandStateChange(
  Sender: TObject; Command: Integer; Enable: WordBool);
begin
  {Controleer of er genavigeerd kan worden~! met dank aan: www.codefoot.com}
  case Command of
    CSC_NAVIGATEBACK: tlbTerug.Enabled := Enable;
    CSC_NAVIGATEFORWARD: tlbVerder.Enabled := Enable;
  end;
end;

procedure TfrmNLDPreviewBrowser.WebBrowserNewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
var
  NewBrowser: TfrmNLDPreviewBrowser;
begin
   NewBrowser := TfrmNLDPreviewBrowser.Create(Owner);
   NewBrowser.Visible := true;
   ppdisp := NewBrowser.WebBrowser.Application;
end;

initialization
  OleInitialize(nil);
finalization
  OleUninitialize;

end.
