{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntChangeStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, StdCtrls, TntStdCtrls, UntBaseForm, TntWindows, TntLxForms;

type
  TFrmChangeStatus = class(TTntFormLx)
    CboxStatus: TTntComboBox;
    LblStatusMessage: TTntLabel;
    LblStatus: TTntLabel;
    EdtStatusMessage: TTntEdit;
    BtnOk: TTntButton;
    BtnCancel: TTntButton;
    procedure CboxStatusDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure TntFormCreate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmChangeStatus: TFrmChangeStatus;

implementation

uses
  UntMain, UntJabber;
{$R *.dfm}

procedure TFrmChangeStatus.CboxStatusDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
 CboxStatus.Canvas.FillRect(Rect);

 FrmMain.ImgLsTray.Draw(CboxStatus.Canvas, Rect.Left, Rect.Top, Index, true);

 Rect.Left := Rect.Left + 20; {move over some}

 Tnt_DrawTextW(CboxStatus.Canvas.Handle,
          PWideChar(CboxStatus.Items[Index]),
          -1,
          Rect,
          DT_SINGLELINE or DT_VCENTER or DT_LEFT);
end;

procedure TFrmChangeStatus.TntFormCreate(Sender: TObject);
begin
 CboxStatus.ItemIndex := DmJabber.JabberSession.ShowType;
end;

procedure TFrmChangeStatus.BtnCancelClick(Sender: TObject);
begin
 close;
end;

procedure TFrmChangeStatus.BtnOkClick(Sender: TObject);
begin
  DmJabber.SetStatus(CboxStatus.ItemIndex, EdtStatusMessage.Text);
  close;
end;

procedure TFrmChangeStatus.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
  ScreenHandler.FreeChangeStatus;
end;

end.
