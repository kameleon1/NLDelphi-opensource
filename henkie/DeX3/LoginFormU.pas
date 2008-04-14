unit LoginFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, md5, Buttons, JvExStdCtrls, JvEdit;

type
  TLoginForm = class(TForm)
    Panel2: TPanel;
    Bevel2: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    Image2: TImage;
    UserNameLabel: TLabel;
    PasswordLabel: TLabel;
    PasswordEdit: TJvEdit;
    SavePasswordCheck: TCheckBox;
    LocationLabel: TLabel;
    LocationHelp: TSpeedButton;
    Bevel3: TBevel;
    OKButton: TButton;
    CancelButton: TButton;
    UserNameEdit: TJvEdit;
    LocationEdit: TJvEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LocationHelpClick(Sender: TObject);
  private
    function GetPassword: string;
    function GetUserName: string;
    procedure SetUserName(const Value: string);
    function GetSavePassword: Boolean;
    function GetLocation: string;
    procedure SetLocation(const Value: string);
    { Private declarations }
  public
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword;
    property Location: string read GetLocation write SetLocation;
    property SavePassword: Boolean read GetSavePassword;
  end;

implementation

uses
  SettingsUnit;

{$R *.dfm}

{ TLoginForm }

function TLoginForm.GetLocation: string;
begin
  Result := LocationEdit.Text;
end;

function TLoginForm.GetPassword: string;
begin
  Result := MD5Print(MD5String(PasswordEdit.Text));
end;

function TLoginForm.GetSavePassword: Boolean;
begin
  Result := SavePasswordCheck.Checked;
end;

function TLoginForm.GetUserName: string;
begin
  Result := UserNameEdit.Text;
end;

procedure TLoginForm.SetLocation(const Value: string);
begin
  LocationEdit.Text := Value;
end;

procedure TLoginForm.SetUserName(const Value: string);
begin
  UserNameEdit.Text := Value;
end;

procedure TLoginForm.LocationHelpClick(Sender: TObject);
begin
  MessageDlg('Door een lokatie op te geven is het mogelijk op verschillende '
    +#13+#10+'lokaties verschillende instellingen te hebben. Zo kun je '
    +#13+#10+'bijvoorbeeld ''Thuis'' en ''Werk'' gebruiken om op je werk al '
    +#13+#10+'berichten te verwijderen en deze thuis weer opnieuw op te '
    +#13+#10+'halen.'
    +#13+#10+''+#13+#10+
    'Als je dat juist niet wilt laat je de lokatie leeg (of vul je dezelfde '
    +#13+#10+'lokatie in).', mtInformation, [mbOK], 0);
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  Left := Settings.LoginForm.Left;
  Top := Settings.LoginForm.Top;
end;

procedure TLoginForm.FormDestroy(Sender: TObject);
begin
  Settings.LoginForm.Left := left;
  Settings.LoginForm.Top := Top;
end;

end.
