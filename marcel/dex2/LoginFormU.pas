unit LoginFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, md5, Buttons;

type
  TLoginForm = class(TForm)
    Label3: TLabel;
    Label1: TLabel;
    PasswordEdit: TEdit;
    UserNameEdit: TEdit;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    SavePasswordCheck: TCheckBox;
    Label2: TLabel;
    LocationEdit: TEdit;
    LocationHelp: TSpeedButton;
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

end.
