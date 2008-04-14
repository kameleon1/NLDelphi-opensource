{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntAbout;

interface

uses
  { TSIM Units }
  UntUtil,
  { Delphi Units }
  Windows, Classes, Controls, Forms, TntForms, ExtCtrls, StdCtrls, ShellAPI,
  jpeg, Graphics, TntStdCtrls, TntExtCtrls, ComCtrls, TntComCtrls,
  TntLXRichEdits;

type
  TFrmAbout = class(TTntForm)
    BtnClose      : TTntButton;
    TSIMlogo: TImage;
    lblTSIM2: TTntLabel;
    Bevel1: TBevel;
    TntStaticText1: TTntStaticText;
    TntLabel1: TTntLabel;
    TntStaticText2: TTntStaticText;
    TntLabel2: TTntLabel;
    TntLabel3: TTntLabel;
    TntStaticText3: TTntStaticText;
    TntLabel4: TTntLabel;
    TntLabel5: TTntLabel;
    devList: TTntMemo;

    procedure BtnCloseClick(Sender: TObject);
    procedure TntFormClose(Sender: TObject; var Action: TCloseAction);
    procedure TntLabel1Click(Sender: TObject);
    procedure TntLabel2Click(Sender: TObject);
    procedure TntLabel3Click(Sender: TObject);
    procedure TntLabel4Click(Sender: TObject);
    procedure TntLabel5Click(Sender: TObject);
    procedure TntFormShow(Sender: TObject);

  private
    procedure OpenSite(URL : String);
  public
    { Public declarations }
  end;


implementation

uses UntMain;

{$R *.dfm}

procedure TFrmAbout.BtnCloseClick(Sender: TObject);
begin
 close;
end;

procedure TFrmAbout.OpenSite(URL: String);
begin
   ShellExecute(0, Nil, pAnsiChar(URL), Nil, Nil, SW_NORMAL);
end;

procedure TFrmAbout.TntFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
  ScreenHandler.FreeAbout;
end;

procedure TFrmAbout.TntLabel1Click(Sender: TObject);
begin
  OpenSite('http://www.triplesoftware.com/');
end;

procedure TFrmAbout.TntLabel2Click(Sender: TObject);
begin
  OpenSite('http://www.northern.nl/');
end;

procedure TFrmAbout.TntLabel3Click(Sender: TObject);
begin
  OpenSite('http://jabbercom.sf.net/');
end;

procedure TFrmAbout.TntLabel4Click(Sender: TObject);
begin
  OpenSite('http://tnt.ccci.org/');
end;

procedure TFrmAbout.TntLabel5Click(Sender: TObject);
begin
  OpenSite('http://www.nldelphi.com/');
end;

procedure TFrmAbout.TntFormShow(Sender: TObject);
begin
  self.Caption := self.Caption + application.Title + ' ' + FileVersion;
end;

end.

