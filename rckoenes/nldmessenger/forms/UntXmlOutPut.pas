{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntXmlOutPut;

interface

uses
  Classes, Controls, Forms, TntForms, StdCtrls, ExtCtrls, ComCtrls, TntStdCtrls,
  TntExtCtrls, TntComCtrls;

type
  TFrmXml = class(TTntForm)
    EdtOutput: TTntRichEdit;
    PnlBottum: TTntPanel;
    BtnClose: TTntButton;

    procedure BtnCloseClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmXml: TFrmXml;

implementation

uses UntMain;
{$R *.dfm}

procedure TFrmXml.BtnCloseClick(Sender: TObject);
begin
 close;
end;

procedure TFrmXml.FormResize(Sender: TObject);
begin
  EdtOutput.Repaint;
end;

end.
