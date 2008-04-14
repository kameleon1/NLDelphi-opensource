{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntProfileMan;

interface

uses
  { TSIM Units }
  UntProfile,
  { Delphi Units }
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLXForms, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls,
  ComCtrls, TntComCtrls, Spin, TntForms, UntFrameTitle;

type
  TFrmProfileMan = class(TTntFormLX)
    pnlBottom: TTntPanel;
    TntPageControl1: TTntPageControl;
    tabWelkom: TTntTabSheet;
    tabOverview: TTntTabSheet;
    tabAccount: TTntTabSheet;
    tabNewprofile: TTntTabSheet;
    Bevel2: TBevel;
    TntListView1: TTntListView;
    btnNew: TTntButton;
    btnEdit: TTntButton;
    btnDel: TTntButton;
    TntRadioButton1: TTntRadioButton;
    TntRadioButton2: TTntRadioButton;
    btnNext: TTntButton;
    btnBack: TTntButton;
    btnCancel: TTntButton;
    TntGroupBox1: TTntGroupBox;
    lblInfo: TTntStaticText;
    TntLabel5: TTntLabel;
    TntEdit4: TTntEdit;
    TntGroupBox2: TTntGroupBox;
    lblNewResource: TTntLabel;
    lblNewPassword: TTntLabel;
    lblNewUserName: TTntLabel;
    edtNewUsername: TTntEdit;
    edtNewPassword: TTntEdit;
    edtNewResource: TTntEdit;
    lblNewPoort: TTntLabel;
    lblNewServer: TTntLabel;
    TntComboBox1: TTntComboBox;
    EdtPoort: TSpinEdit;
    cbNewSSL: TTntCheckBox;
    FrameTitle1: TFrameTitle;
    TntButton1: TTntButton;
    TntGroupBox3: TTntGroupBox;
    TntLabel1: TTntLabel;
    TntLabel2: TTntLabel;
    TntLabel3: TTntLabel;
    TntLabel4: TTntLabel;
    TntLabel6: TTntLabel;
    TntEdit1: TTntEdit;
    TntEdit2: TTntEdit;
    TntEdit3: TTntEdit;
    TntComboBox2: TTntComboBox;
    SpinEdit1: TSpinEdit;
    TntCheckBox1: TTntCheckBox;
    TntButton2: TTntButton;
    procedure TntFormLXClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProfileMan: TFrmProfileMan;

implementation

uses
  UntMain;

{$R *.dfm}



procedure TFrmProfileMan.TntFormLXClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
  ScreenHandler.FreeProfileManager
end;

procedure TFrmProfileMan.btnCancelClick(Sender: TObject);
begin
 self.Close;
end;

end.
