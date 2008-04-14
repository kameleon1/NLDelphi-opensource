unit uProgram;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmProgram = class(TForm)
    Panel1: TPanel;
    BtCancel: TBitBtn;
    BtOk: TBitBtn;
    BtDefault: TBitBtn;
    GbAdapter: TGroupBox;
    CmbAdapterLijst: TComboBox;
    GbUnits: TGroupBox;
    RbBits: TRadioButton;
    RbBytes: TRadioButton;
    GbStandard: TGroupBox;
    RbStandardBinary: TRadioButton;
    RbStandartDecimal: TRadioButton;
    GbDecimal: TGroupBox;
    Rb1Decimaal: TRadioButton;
    Rb2Decimaal: TRadioButton;
    Rb3Decimaal: TRadioButton;
    Rb4Decimaal: TRadioButton;
    Bevel1: TBevel;
    GbCommon: TGroupBox;
    CbShowhints: TCheckBox;
    CbSaveonexit: TCheckBox;
    CbMinimizeonrun: TCheckBox;
    CbConfirmExit: TCheckBox;
    CbStayOnTop: TCheckBox;
    procedure BtOkClick(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure BtDefaultClick(Sender: TObject);
    procedure ObjectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProgram: TfrmProgram;

  {Var om bij te houden of FormShow Event getriggert en klaar is.
  ivm checkbox die een ongewenst click event genereerd indien deze codematig gezet wordt.}
  vFormShowDone: Boolean;

  {Var om bij te houden of DefaultClick Event getriggert en klaar is.
  ivm Colorbox / Checkbox die een ongewenst click event genereerd indien deze codematig gezet wordt.}
  vSetDefaultDone: Boolean;

implementation

uses uMain, uReadIniFile, uWriteIniFile, uCommon;

{$R *.dfm}

{=====================================================================================================}
{= FormShow Event, Lees Ini File in en adv. de ingezen waardes de checkboxen setten. =================}
{=====================================================================================================}
procedure TfrmProgram.FormShow(Sender: TObject);
var
  vICounter: Integer;
begin
  {Set Form Caption}
  frmProgram.Caption := cAPPLICATIETITELNLD + ' - [ Program ]';

  {Loop de Adapter Naam Array door en vul de adapter combo lijst.}
  for vICounter := low(vAdapterArray) to high(vAdapterArray) do
    CmbAdapterLijst.Items.Add(vAdapterArray[vICounter]);

  {Lees Ini file in, alleen de sectie's voor het setten van de layout}
  uReadIniFile.ReadIniFileSectionSetObject('Program');

  {Set var op true, formshow event is klaar.}
  vFormShowDone := True;

  {Set var op true, DefaultClick event is klaar.}
  vSetDefaultDone := False;
end;

{=====================================================================================================}
{= Procedure om het Program Form te sluiten na een klik op het close border Icoon. =====================}
{=====================================================================================================}
procedure TfrmProgram.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  {Forceer een Button Click op de Cancel button.}
  BtCancelClick(nil);
end;

{=====================================================================================================}
{= Form Close Procedure, wordt door de Cancel en Ok button aangeroepen.===============================}
{=====================================================================================================}
procedure TfrmProgram.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {Set var terug op false, om er voor te zorgen dat deze nog een keer gebruikt kan worden.}
  vFormShowDone := False;

  {Set var terug op false, om er voor te zorgen dat deze nog een keer gebruikt kan worden.}
  vSetDefaultDone := False;

  {Toon Main Form.}
  frmMain.Show;
end;

{=====================================================================================================}
{= Cancel Button Click Procedure, Lees Ini File opnieuw in en maak wijzigingen daar mee ongedaan. ====}
{=====================================================================================================}
procedure TfrmProgram.BtCancelClick(Sender: TObject);
begin
  {Sluit Program Form.}
  frmProgram.Close;
end;

{=====================================================================================================}
{= Ok Button Click Procedure, Schrijf Ini File weg en sluit scherm. ==================================}
{=====================================================================================================}
procedure TfrmProgram.BtOkClick(Sender: TObject);
begin
  {Schrijf Ini file weg, alleen de sectie's voor het setten van de layout}
  uWriteIniFile.WriteIniFileSection('Program');

  {Sluit Program Form.}
  frmProgram.Close;
end;

{=====================================================================================================}
{= Default Button Click Procedure, Set alle Colorboxen en Checkboxen op RICHARD's Default instelling.=}
{=====================================================================================================}
procedure TfrmProgram.BtDefaultClick(Sender: TObject);
begin
  {Set Default button disabled, omdat er toch al op geklickt is.}
  BtDefault.Enabled := False;

  {Set var op false, DefaultClick event is bezig...}
  vSetDefaultDone := False;

  {Set alle Colorboxen en Checkboxen op RICHARD's Default instelling.}
  {Bij wijzigingen, denk dan ook aan de Default Property van de INI File. !!!}
  with frmProgram do
    begin
      {Adapter Groupbox}
      frmProgram.CmbAdapterLijst.ItemIndex := 0;

      {Units Groupbox}
      frmProgram.RbBits.Checked := False;
      frmProgram.RbBytes.Checked := True;

      {Standard Groupbox}
      frmProgram.RbStandardBinary.Checked := True;
      frmProgram.RbStandartDecimal.Checked := False;

      {Decimals Groupbox}
      frmProgram.Rb1Decimaal.Checked := False;
      frmProgram.Rb2Decimaal.Checked := True;
      frmProgram.Rb3Decimaal.Checked := False;
      frmProgram.Rb4Decimaal.Checked := False;

      {Common Groupbox}
      frmProgram.CbShowhints.Checked := True;
      frmProgram.CbSaveonexit.Checked := False;
      frmProgram.CbMinimizeonrun.Checked := False;
      frmProgram.CbConfirmExit.Checked := False;
      frmProgram.CbStayOnTop.Checked := False;
    end;

  {Set var op True, DefaultClick event is Klaar !}
  vSetDefaultDone := True;

  {Set BtOk op enabled, omdat er iets gewijzigt KAN zijn.}
  BtOk.Enabled := True;
end;

{=====================================================================================================}
{= Event wat bij ELKE Combobox & Checkbox click getriggerd wordt, doel: setten v/d Ok en Default Btn =}
{=====================================================================================================}
procedure TfrmProgram.ObjectClick(Sender: TObject);
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

