{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntLXForms, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls,
  TntLXRichEdits, ExtCtrls, TntExtCtrls, UntBaseForm;

type
  TFrmDialog = class(TTntFormLX)
    PnlTop: TTntPanel;
    ImgLogo: TImage;
    PnlBottum: TTntPanel;
    BtnClose: TTntButton;
    EdtMessage: TTntRichEditLX;
    LblStFrom: TTntLabel;
    LblStSubject: TTntLabel;
    LblFrom: TTntLabel;
    LblSubject: TTntLabel;
    procedure BtnCloseClick(Sender: TObject);
    procedure TntFormLXClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { New Function 23-01-2004}
    procedure setCaption(aCaption : WideString);
    procedure setFrom(aFrom : WideString);
    procedure setSubject(aSubject : WideString);
    procedure setSimpleMessage(aMessage : WideString);
    procedure setNumberMessage(aMessage : WideString);
  end;

var
  FrmDialog: TFrmDialog;

implementation

{$R *.dfm}

{ TFrmDlg }


procedure TFrmDialog.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmDialog.TntFormLXClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmDialog.setCaption(aCaption: WideString);
begin
  self.Caption := aCaption;
end;

procedure TFrmDialog.setFrom(aFrom: WideString);
begin
  self.LblFrom.Caption := aFrom;
end;

procedure TFrmDialog.setSimpleMessage(aMessage: WideString);
begin
  self.EdtMessage.Text := aMessage;
end;

procedure TFrmDialog.setSubject(aSubject: WideString);
begin
  self.LblSubject.Caption := aSubject;
end;

procedure TFrmDialog.setNumberMessage(aMessage: WideString);
begin
  With EdtMessage Do
  Begin
    Lines.BeginUpdate;
    Paragraph.Numbering := nsBullet;
    Lines.Add(aMessage);
    Paragraph.Numbering := nsNone;
    Lines.EndUpdate;
  end;
end;

end.
