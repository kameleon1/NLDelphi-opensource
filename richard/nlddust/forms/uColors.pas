unit uColors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmColors = class(TForm)
    Panel1: TPanel;
    BtCancel: TBitBtn;
    BtOk: TBitBtn;
    GbColorSent: TGroupBox;
    GbColorSessionCurrentSent: TGroupBox;
    ClrbColorSessionCurrentSent: TColorBox;
    CbColorSessionCurrentSent: TCheckBox;
    GbColorSessionAverageSent: TGroupBox;
    ClrbColorSessionAverageSent: TColorBox;
    CbColorSessionAverageSent: TCheckBox;
    GbColorSessionMaxSent: TGroupBox;
    ClrbColorSessionMaxSent: TColorBox;
    CbColorSessionMaxSent: TCheckBox;
    GbColorSessionTotalSent: TGroupBox;
    ClrbColorSessionTotalSent: TColorBox;
    CbColorSessionTotalSent: TCheckBox;
    GbColorWindowsTotalSent: TGroupBox;
    ClrbColorWindowsTotalSent: TColorBox;
    CbColorWindowsTotalSent: TCheckBox;
    BtDefault: TBitBtn;
    GbColorReceived: TGroupBox;
    GbColorSessionCurrentReceived: TGroupBox;
    ClrbColorSessionCurrentReceived: TColorBox;
    CbColorSessionCurrentReceived: TCheckBox;
    GbColorSessionAverageReceived: TGroupBox;
    ClrbColorSessionAverageReceived: TColorBox;
    CbColorSessionAverageReceived: TCheckBox;
    GbColorSessionMaxReceived: TGroupBox;
    ClrbColorSessionMaxReceived: TColorBox;
    CbColorSessionMaxReceived: TCheckBox;
    GbColorSessionTotalReceived: TGroupBox;
    ClrbColorSessionTotalReceived: TColorBox;
    CbColorSessionTotalReceived: TCheckBox;
    GbColorWindowsTotalReceived: TGroupBox;
    ClrbColorWindowsTotalReceived: TColorBox;
    CbColorWindowsTotalReceived: TCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure BtDefaultClick(Sender: TObject);
    procedure ObjectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmColors: TfrmColors;

  {Var om bij te houden of FormShow Event getriggert en klaar is.
  (ivm checkbox die een ongewenst click event genereerd indien deze codematig gezet wordt.}
  vFormShowDone: Boolean;

  {Var om bij te houden of DefaultClick Event getriggert en klaar is.
  (ivm Colorbox / Checkbox die een ongewenst click event genereerd indien deze codematig gezet wordt.}
  vSetDefaultDone: Boolean;

implementation

uses uMain, uReadIniFile, uWriteIniFile;

{$R *.dfm}

{=====================================================================================================}
{= FormCreate Event, Routine zorgt dat ALLE TColorboxen op dit form, Prettynames krijgen. dus -cl. ===}
{=====================================================================================================}
procedure TfrmColors.FormCreate(Sender: TObject);
var
 {Globale Counter}
  vICounter: Byte;
begin
  {Loop door alle componenten op het form heen.}
  for vICounter := 0 to (ComponentCount - 1) do begin
      {indien het gevonden component een TColorbox is...}
      if Components[vICounter] is TColorBox then
        begin
          {Wijzig de STYLE property van de betreffende TColorbox.}
          TColorBox(Components[vICounter]).Style := [cbStandardColors, cbExtendedColors, cbPrettyNames];
        end;
    end;
end;

{=====================================================================================================}
{= FormShow Event, Lees Ini File in en adv. de ingezen waardes de Objecten setten. ===================}
{=====================================================================================================}
procedure TfrmColors.FormShow(Sender: TObject);
begin
  {Set Form Caption}
  frmColors.Caption := cAPPLICATIETITELNLD + ' - [ Colors ]';

  {Lees Ini file in, alleen de sectie's voor het setten van de Colors}
  uReadIniFile.ReadIniFileSectionSetObject('Colors');

  {Set var op true, formshow event is klaar.}
  vFormShowDone := True;

  {Set var op true, DefaultClick event is klaar.}
  vSetDefaultDone := False;
end;

{=====================================================================================================}
{= Procedure om het Colors Form te sluiten na een klik op het close border Icoon. =====================}
{=====================================================================================================}
procedure TfrmColors.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  {Forceer een Button Click op de Cancel button.}
  BtCancelClick(nil);
end;

{=====================================================================================================}
{= Form Close Procedure, wordt door de Cancel en Ok button aangeroepen.===============================}
{=====================================================================================================}
procedure TfrmColors.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {Set var terug op false, om er voor te zorgen dat deze nog een keer gebruikt kan worden.}
  vFormShowDone := False;

  {Set var terug op false, om er voor te zorgen dat deze nog een keer gebruikt kan worden.}
  vSetDefaultDone := False;

  {Toon Main Form.}
  frmMain.Show;
end;

{=====================================================================================================}
{= Cancel Button Click Procedure, sluit scherm. ======================================================}
{=====================================================================================================}
procedure TfrmColors.BtCancelClick(Sender: TObject);
begin
  {Sluit Colors Form.}
  frmColors.Close;
end;

{=====================================================================================================}
{= Ok Button Click Procedure, Schrijf Ini File weg en sluit scherm. ==================================}
{=====================================================================================================}
procedure TfrmColors.BtOkClick(Sender: TObject);
begin
  {Schrijf Ini file weg, alleen de sectie's voor het setten van de layout}
  uWriteIniFile.WriteIniFileSection('Colors');

  {Sluit Colors Form.}
  frmColors.Close;
end;

{=====================================================================================================}
{= Default Button Click Procedure, Set alle Colorboxen en Checkboxen op RICHARD's Default instelling.=}
{=====================================================================================================}
procedure TfrmColors.BtDefaultClick(Sender: TObject);
begin
  {Set Default button disabled, omdat er toch al op geklickt is.}
  BtDefault.Enabled := False;

  {Set var op false, DefaultClick event is bezig...}
  vSetDefaultDone := False;

  {Set alle Colorboxen en Checkboxen op RICHARD's Default instelling.}
  {Bij wijzigingen, denk dan ook aan de Default Property van de INI File. !!!}
  with frmColors do
    begin
      {Session Current Received Color}
      ClrbColorSessionCurrentReceived.Selected := StringToColor('clRed');
      CbColorSessionCurrentReceived.Checked := False;
      {Session Average Received Color}
      ClrbColorSessionAverageReceived.Selected := StringToColor('clTeal');
      CbColorSessionAverageReceived.Checked := False;
      {Session Max Received Color}
      ClrbColorSessionMaxReceived.Selected := StringToColor('clRed');
      CbColorSessionMaxReceived.Checked := False;
      {Session Total Received Color}
      ClrbColorSessionTotalReceived.Selected := StringToColor('clGreen');
      CbColorSessionTotalReceived.Checked := False;
      {Windows Total Received Color}
      ClrbColorWindowsTotalReceived.Selected := StringToColor('clNavy');
      CbColorWindowsTotalReceived.Checked := True;
      {Session Current Sent Color}
      ClrbColorSessionCurrentSent.Selected := StringToColor('clBlue');
      CbColorSessionCurrentSent.Checked := False;
      {Session Average Sent Color}
      ClrbColorSessionAverageSent.Selected := StringToColor('clTeal');
      CbColorSessionAverageSent.Checked := False;
      {Session Max Sent Color}
      ClrbColorSessionMaxSent.Selected := StringToColor('clBlue');
      CbColorSessionMaxSent.Checked := False;
      {Session Total Sent Color}
      ClrbColorSessionTotalSent.Selected := StringToColor('clGreen');
      CbColorSessionTotalSent.Checked := False;
      {Windows Total Sent Color}
      ClrbColorWindowsTotalSent.Selected := StringToColor('clNavy');
      CbColorWindowsTotalSent.Checked := True;
    end;

  {Set var op True, DefaultClick event is Klaar !}
  vSetDefaultDone := True;

  {Set BtOk op enabled, omdat er iets gewijzigt KAN zijn.}
  BtOk.Enabled := True;
end;

{=====================================================================================================}
{= Event wat bij ELKE Colorbox & Checkbox click getriggerd wordt, doel: setten v/d Ok en Default Btn =}
{=====================================================================================================}
procedure TfrmColors.ObjectClick(Sender: TObject);
begin
 {Dankzij deze var, wordt routine alleen uitgevoerd indien het formshow of setdefault event klaar is.}
  if vFormShowDone or vSetDefaultDone then
    begin
      {Wijziging heeft plaatsgevonden dus, de Ok en Default button moeten GeEnabled worden.}
      BtOk.Enabled := True;
      if vSetDefaultDone then BtDefault.Enabled := True;
    end;
end;

end.

