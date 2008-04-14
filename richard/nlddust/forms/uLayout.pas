unit uLayout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmLayout = class(TForm)
    Panel1: TPanel;
    GbLayoutAdapter: TGroupBox;
    CbAdapterShowCaption: TCheckBox;
    CbAdapterShowBox: TCheckBox;
    GbLayoutUnits: TGroupBox;
    CbUnitsShowBox: TCheckBox;
    CbUnitsShowCaption: TCheckBox;
    GbLayoutStandard: TGroupBox;
    CbStandardShowBox: TCheckBox;
    CbStandardShowCaption: TCheckBox;
    GbLayoutDecimals: TGroupBox;
    CbDecimalsShowBox: TCheckBox;
    CbDecimalsShowCaption: TCheckBox;
    BtCancel: TBitBtn;
    BtOk: TBitBtn;
    BtDefault: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
    procedure SetCheckBox(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtOkClick(Sender: TObject);
    procedure BtDefaultClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLayout: TfrmLayout;

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
{= FormShow Event, Lees Ini File in en adv. de ingezen waardes de checkboxen setten. =================}
{=====================================================================================================}
procedure TfrmLayout.FormShow(Sender: TObject);
begin
  {Set Form Caption}
  frmLayout.Caption := cAPPLICATIETITELNLD + ' - [ Layout ]';

  {Lees Ini file in, alleen de sectie's voor het setten van de layout}
  uReadIniFile.ReadIniFileSectionSetObject('Layout');

  {Maak Show Caption Checkboxen disabled indien Show Box Checkbox false is.}
  SetCheckBox(nil);

  {Set var op true, formshow event is klaar.}
  vFormShowDone := True;

  {Set var op true, DefaultClick event is klaar.}
  vSetDefaultDone := False;
end;

{=====================================================================================================}
{= Procedure om het LayOut Form te sluiten na een klik op het close border Icoon. =====================}
{=====================================================================================================}
procedure TfrmLayout.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  {Forceer een Button Click op de Cancel button.}
  BtCancelClick(nil);
end;

{=====================================================================================================}
{= Form Close Procedure, wordt door de Cancel en Ok button aangeroepen.===============================}
{=====================================================================================================}
procedure TfrmLayout.FormClose(Sender: TObject; var Action: TCloseAction);
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
procedure TfrmLayout.BtCancelClick(Sender: TObject);
begin
  {Sluit Layout Form.}
  frmLayout.Close;
end;

{=====================================================================================================}
{= Ok Button Click Procedure, Schrijf Ini File weg en sluit scherm. ==================================}
{=====================================================================================================}
procedure TfrmLayout.BtOkClick(Sender: TObject);
begin
  {Schrijf Ini file weg, alleen de sectie's voor het setten van de layout}
  uWriteIniFile.WriteIniFileSection('Layout');

  {Sluit Layout Form.}
  frmLayout.Close;
end;

{=====================================================================================================}
{= Event om de Show Caption Checkboxen te disabelen indien de Show Box Checkbox false is. ============}
{=====================================================================================================}
procedure TfrmLayout.SetCheckBox(Sender: TObject);
begin
  {Maak Show Caption Checkboxen disabled indien Show Box Checkbox false is.}
  CbAdapterShowCaption.Enabled := CbAdapterShowBox.Checked;
  CbUnitsShowCaption.Enabled := CbUnitsShowBox.Checked;
  CbStandardShowCaption.Enabled := CbStandardShowBox.Checked;
  CbDecimalsShowCaption.Enabled := CbDecimalsShowBox.Checked;
end;

{=====================================================================================================}
{= Event wat bij ELKE checkbox click getriggerd wordt, doel: setten van de Show caption box etc. =====}
{=====================================================================================================}
procedure TfrmLayout.CheckBoxClick(Sender: TObject);
begin
  {Dankzij deze var, wordt routine alleen uitgevoerd indien het formshow of setdefault event klaar is.}
  if vFormShowDone or vSetDefaultDone then
    begin
      {Maak Show Caption Checkboxen disabled indien Show Box Checkbox false is.}
      SetCheckBox(nil);

      {Wijziging heeft plaatsgevonden dus, de Ok en Default button moeten GeEnabled worden.}
      BtOk.Enabled := True;
      if vSetDefaultDone then BtDefault.Enabled := True;
    end;
end;

{=====================================================================================================}
{= Default Button Click Procedure, Set alle Colorboxen en Checkboxen op RICHARD's Default instelling.=}
{=====================================================================================================}
procedure TfrmLayout.BtDefaultClick(Sender: TObject);
begin
  {Set Default button disabled, omdat er toch al op geklickt is.}
  BtDefault.Enabled := False;

  {Set var op false, DefaultClick event is bezig...}
  vSetDefaultDone := False;

  {Set alle Checkboxen op RICHARD's Default instelling.}
  {Bij wijzigingen, denk dan ook aan de Default Property van de INI File. !!!}
  with frmLayout do
    begin
      {Adapter Groupbox}
      CbAdapterShowBox.Checked := True;
      CbAdapterShowCaption.Checked := True;
      {Units Groupbox}
      CbUnitsShowBox.Checked := True;
      CbUnitsShowCaption.Checked := True;
      {Standard Groupbox}
      CbStandardShowBox.Checked := False;
      CbStandardShowCaption.Checked := False;
      {Decimals Groupbox}
      CbDecimalsShowBox.Checked := False;
      CbDecimalsShowCaption.Checked := False;
    end;

  {Set var op True, DefaultClick event is Klaar !}
  vSetDefaultDone := True;

  {Set BtOk op enabled, omdat er iets gewijzigt KAN zijn.}
  BtOk.Enabled := True;
end;

end.

