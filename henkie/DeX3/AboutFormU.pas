unit AboutFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, jpeg;

type
  TAboutForm = class(TForm)
    Versionlabel: TLabel;
    ThanksLabel: TImage;
    Bevel1: TBevel;
    CloseButton: TButton;
    WebsiteLabel: TLabel;
    EmailLabel: TLabel;
    Label1: TLabel;
    ContactLabel: TLabel;
    MadeWithLabel: TLabel;
    BDSLabel: TLabel;
    IndyLabel: TLabel;
    VSTLabel: TLabel;
    JVCLLabel: TLabel;
    ThanksText: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure JVCLLabelClick(Sender: TObject);
    procedure VSTLabelClick(Sender: TObject);
    procedure IndyLabelClick(Sender: TObject);
    procedure BDSLabelClick(Sender: TObject);
    procedure URLEmailLabelClick(Sender: TObject);
    procedure LabelsMouseLeave(Sender: TObject);
    procedure LabelsMouseEnter(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    procedure OpenURL(URL: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class procedure ShowIt;
  end;


implementation

{$R *.dfm}

uses
  JclFileUtils, ShellAPI, SettingsUnit;

constructor TAboutForm.Create(AOwner: TComponent);
begin
  inherited;
  with TJclFileVersionInfo.Create(Application.ExeName) do
  try
    Versionlabel.Caption := Format('NLDelphi XML Client v%s', [FileVersion]);
  finally
    Free;
  end;
end;

procedure TAboutForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

class procedure TAboutForm.ShowIt;
begin
  with TAboutForm.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TAboutForm.LabelsMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clHotLight;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline];
  TLabel(Sender).Cursor := crHandPoint;
end;

procedure TAboutForm.LabelsMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBtnText;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline];
  TLabel(Sender).Cursor := crDefault;
end;

procedure TAboutForm.URLEmailLabelClick(Sender: TObject);
var
  URL: string;
begin
  URL := TLabel(Sender).Caption;
  if Sender = WebsiteLabel then
    URL := 'http://www.nldelphi.com/Forum/forumdisplay.php?f=133';
  OpenURL(URL);
end;

procedure TAboutForm.BDSLabelClick(Sender: TObject);
begin
  OpenURL('http://www.codegear.com/products/delphi/win32');
end;

procedure TAboutForm.IndyLabelClick(Sender: TObject);
begin
  OpenURL('http://www.indyproject.org/index.en.aspx');
end;

procedure TAboutForm.VSTLabelClick(Sender: TObject);
begin
  OpenURL('http://www.soft-gems.net/index.php?option=com_content&task=view&id=12&Itemid=33');
end;

procedure TAboutForm.JVCLLabelClick(Sender: TObject);
begin
  OpenURL('http://sourceforge.net/projects/jvcl');
end;

procedure TAboutForm.OpenURL(URL: string);
begin
  ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    CloseButton.Click;
end;

destructor TAboutForm.Destroy;
begin
  Settings.AboutForm.Left := Left;
  Settings.AboutForm.Top := Top;
  inherited;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  Left := Settings.AboutForm.Left;
  Top := Settings.AboutForm.Top;
end;

end.
