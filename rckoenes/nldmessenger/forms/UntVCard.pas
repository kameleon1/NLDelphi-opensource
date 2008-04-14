{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntVCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLXForms, ComCtrls, TntComCtrls, StdCtrls, TntStdCtrls, Grids,
  TntGrids, ExtCtrls, TntExtCtrls, TntLXRichEdits, Buttons;

type
  TFrmVCard = class(TTntFormLX)
    PageControle: TTntPageControl;
    TabPersonel: TTntTabSheet;
    TabEmail: TTntTabSheet;
    TabBuisness: TTntTabSheet;
    PnlEmail: TTntPanel;
    PnlBottom: TTntPanel;
    BtnCancel: TTntButton;
    BtnOke: TTntButton;
    EdtFullName: TTntEdit;
    EdyMiddleName: TTntEdit;
    EdtFirstName: TTntEdit;
    EdtLastName: TTntEdit;
    LblFullName: TTntLabel;
    LblFirstName: TTntLabel;
    LblMiddleName: TTntLabel;
    TntLabel1: TTntLabel;
    EdtNick: TTntEdit;
    LblNick: TTntLabel;
    LVEmail: TTntListView;
    TntTabSheet1: TTntTabSheet;
    EdtOccupation: TTntEdit;
    TntLabel2: TTntLabel;
    EdtMarital: TTntEdit;
    TntLabel4: TTntLabel;
    TntLabel5: TTntLabel;
    EdtBirthday: TTntEdit;
    TntLabel6: TTntLabel;
    EdtWebsite: TTntEdit;
    TntLabel7: TTntLabel;
    TntComboBox1: TTntComboBox;
    TntGroupBox1: TTntGroupBox;
    EdtHomeAdres1: TTntEdit;
    TntLabel3: TTntLabel;
    TntLabel8: TTntLabel;
    EdtHomeAdres2: TTntEdit;
    TntLabel9: TTntLabel;
    EdtHomeZip: TTntEdit;
    TntLabel10: TTntLabel;
    EdtHomeTown: TTntEdit;
    TntLabel11: TTntLabel;
    EdtHomeState: TTntEdit;
    TntLabel12: TTntLabel;
    EdtHomeCountry: TTntEdit;
    TntGroupBox2: TTntGroupBox;
    TntLabel13: TTntLabel;
    TntLabel14: TTntLabel;
    TntLabel15: TTntLabel;
    TntLabel16: TTntLabel;
    TntLabel17: TTntLabel;
    TntLabel18: TTntLabel;
    EdtWorkAdres1: TTntEdit;
    EdtWorkAdres2: TTntEdit;
    EdtWorkZip: TTntEdit;
    EdtWorkTown: TTntEdit;
    EdtWorkState: TTntEdit;
    EdtWorkCountry: TTntEdit;
    EdtCompany: TTntEdit;
    TntLabel19: TTntLabel;
    TntLabel20: TTntLabel;
    EdtDepartment: TTntEdit;
    TntLabel21: TTntLabel;
    EdtRole: TTntEdit;
    TntTabSheet2: TTntTabSheet;
    LVPhone: TTntListView;
    TntTabSheet3: TTntTabSheet;
    EdtComment: TTntRichEditLX;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    TntPanel1: TTntPanel;
    btnEmailEdit: TSpeedButton;
    btnEmailDel: TSpeedButton;
    btnEmailAdd: TSpeedButton;
    TntPanel2: TTntPanel;
    btnPhoneEdit: TSpeedButton;
    btnPhoneDel: TSpeedButton;
    btnPhoneAdd: TSpeedButton;
    procedure TntFormLXClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVCard: TFrmVCard;

implementation

{$R *.dfm}

procedure TFrmVCard.TntFormLXClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
