unit ProxySetup;

// Dany Rosseel

{ History of this unit
  04-08-2003: Initial version
  10-10-2003: Adaptions made to meet coding conventions
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SimpleIniFile, Rcs_Resize, General;

type
  TProxyInfo = record
    UseProxy: boolean;
    ProxyAddress: {short}string;
    ProxyPort: {short}string;
    UseProxyAuthorization: boolean;
    UserName: {short}string;
    password: {short}string;
  end;

type
  TProxySetupForm = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    Password: TEdit;
      Name: TEdit;
    AuthorisationCheckBox: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    ConfigCheckbox: TCheckBox;
    ProxyAddress: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ProxyPort: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure AuthorisationCheckBoxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConfigCheckboxClick(Sender: TObject);
    procedure ProxyAddressChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ProxyChanged: boolean;
    Info: TProxyInfo;
    MyResize_: TMyResize;
    Resize_Enabled: boolean;
    procedure ReadProxy;
    procedure WriteProxy;
    procedure Get;
    procedure Put;
    procedure UpdateForm;
    procedure Init;
  public
    { Public declarations }
  end;

var
  ProxySetupForm: TProxySetupForm;

procedure GetProxyValues(var UseProxy: boolean;
  var ProxyAddress,
  ProxyPort: string;
  var UseProxyAuthorisation: boolean;
  var UserName,
  Password: string);

implementation

{$R *.DFM}

uses SimpleRegistry;

procedure GetProxyValues(var UseProxy: boolean;
  var ProxyAddress,
  ProxyPort: string;
  var UseProxyAuthorisation: boolean;
  var UserName,
  Password: string);
begin
  UseProxy := ProxySetupForm.Info.UseProxy;
  if UseProxy then
  begin
    ProxyAddress := ProxySetupForm.Info.ProxyAddress;
    ProxyPort := ProxySetupForm.Info.ProxyPort;
  end;

  UseProxyAuthorisation := ProxySetupForm.Info.UseProxyAuthorization;
  if UseProxyAuthorisation then
  begin
    UserName := ProxySetupForm.Info.UserName;
    Password := ProxySetupForm.Info.password;
  end;
end;

procedure TProxySetupForm.UpdateForm;
begin
  ProxyAddress.Enabled := ConfigCheckbox.Checked;
  ProxyPort.Enabled := ConfigCheckbox.Checked;
  AuthorisationCheckBox.Enabled := ConfigCheckbox.Checked;
  Name.Enabled := ConfigCheckbox.Checked and AuthorisationCheckBox.Checked;
  Password.Enabled := ConfigCheckbox.Checked and AuthorisationCheckbox.Checked;
end;

procedure TProxySetupForm.Get;
begin
  ConfigCheckBox.Checked := Info.UseProxy;
  ProxyAddress.Text := Info.ProxyAddress;
  ProxyPort.Text := Info.ProxyPort;
  AuthorisationCheckBox.Checked := Info.UseProxyAuthorization;
  Name.Text := Info.UserName;
  Password.Text := Info.password;
  UpdateForm;
end;

procedure TProxySetupForm.Put;
begin
  Info.UseProxy := ConfigCheckBox.Checked;
  Info.ProxyAddress := ProxyAddress.Text;
  Info.ProxyPort := ProxyPort.Text;
  Info.UseProxyAuthorization := AuthorisationCheckBox.Checked;
  Info.UserName := Name.Text;
  Info.password := Password.Text;
end;

const
  RegistryProxy = 'Software\Rcs\Proxy\';

procedure TProxySetupForm.ReadProxy;
var
  F: TSimpleRegistry;
begin
  F := TSimpleRegistry.Create;
  Info.UseProxy := F.ReadBool(RegistryProxy + 'Configuration', 'UseProxy',
    False);
  Info.ProxyAddress := F.ReadString(RegistryProxy + 'Configuration', 'Server',
    '');
  Info.ProxyPort := F.ReadString(RegistryProxy + 'Configuration', 'Port', '80');
  Info.UseProxyAuthorization := F.ReadBool(RegistryProxy + 'Authorisation',
    'UseProxyAuthorisation', False);
  Info.UserName := F.ReadString(RegistryProxy + 'Authorisation', 'Username',
    '');
  Info.password := F.ReadString(RegistryProxy + 'Authorisation', 'Password',
    '');
  F.Free;
  Get; // Get all values from the the 'Info' record into the UI
end;

procedure TProxySetupForm.WriteProxy;
var
  f: TSimpleRegistry;
begin
  Put; // Put all values from the UI Info the 'Info' record
  f := TSimpleRegistry.Create;
  F.WriteBool(RegistryProxy + 'Configuration', 'UseProxy', Info.UseProxy);
  F.WriteString(RegistryProxy + 'Configuration', 'Server', Info.ProxyAddress);
  F.WriteString(RegistryProxy + 'Configuration', 'Port', Info.ProxyPort);
  F.WriteBool(RegistryProxy + 'Authorisation', 'UseProxyAuthorisation',
    Info.UseProxyAuthorization);
  F.WriteString(RegistryProxy + 'Authorisation', 'Username', Info.UserName);
  F.WriteString(RegistryProxy + 'Authorisation', 'Password', Info.password);
  F.Free;
end;

procedure TProxySetupForm.FormCreate(Sender: TObject);
begin
  Resize_Enabled := false;
  if not automatic then
  begin
    MyResize_ := TMyResize.Create(Self);
    Resize_Enabled := true;
  end;

  Init;
  ReadProxy;
end;

procedure TProxySetupForm.AuthorisationCheckBoxClick(Sender: TObject);
begin
  UpdateForm;
  ProxyChanged := True;
end;

procedure TProxySetupForm.Button1Click(Sender: TObject);
begin
  if ProxyChanged then
    WriteProxy;
end;

procedure TProxySetupForm.Init;
var
  R: TSimpleRegistry;
  Tmp: string;
  B, E: byte;
const
  InternetSettings =
    '\Software\Microsoft\Windows\CurrentVersion\Internet Settings';
begin
  R := TSimpleRegistry.Create;
  try
    if not R.KeyExists(RegistryProxy) then
    begin
      if R.ValueExists(InternetSettings, 'ProxyEnable') then
        Info.UseProxy := R.ReadBool(InternetSettings, 'ProxyEnable', False);

      if R.ValueExists(InternetSettings, 'ProxyServer') then
      begin
        Tmp := R.ReadString(InternetSettings, 'ProxyServer', '');
        B := pos('http=', Tmp);
        if (B > 0) then
          Tmp := Copy(Tmp, B + length('http='), 100);
        E := Pos(';', Tmp);
        if E > 0 then
          Tmp := Copy(Tmp, 1, E - 1);
        E := Pos(':', Tmp);
        if E > 0 then
        begin
          Info.ProxyAddress := Copy(Tmp, 1, E - 1);
          Info.ProxyPort := Copy(Tmp, E + 1, 100);
        end
        else
        begin
          Info.ProxyAddress := Tmp;
          Info.ProxyPort := '80';
        end;
      end;

      Info.UseProxyAuthorization := False;
      Info.UserName := '';
      Info.password := '';

      Get;
      WriteProxy;
    end;
  finally
    R.Free;
  end;
end;

procedure TProxySetupForm.FormShow(Sender: TObject);
var Inifile: TSimpleIniFile;
    L, T, W, H: integer;
begin
  Inifile := TSimpleIniFile.Create;

  W := IniFile.ReadInteger('Sizes', 'ProxyWidth', 489);
  H := IniFile.ReadInteger('Sizes', 'ProxyHeight', 319);
  L := IniFile.ReadInteger('Sizes', 'ProxyLeft', (Screen.Width - Width) div 2);
  T := IniFile.ReadInteger('Sizes', 'ProxyTop', (Screen.Height - Height) div 2);

  SetBounds(L, T, W, H);

  Font.Size := IniFile.ReadInteger('Font', 'Main', 8);

  IniFile.Free;

  ReadProxy;
  ProxyChanged := False;
  ActiveControl := Button1;
end;

procedure TProxySetupForm.ConfigCheckboxClick(Sender: TObject);
begin
  UpdateForm;
  ProxyChanged := True;
end;

procedure TProxySetupForm.ProxyAddressChange(Sender: TObject);
begin
  ProxyChanged := True;
end;

procedure TProxySetupForm.FormResize(Sender: TObject);
begin
  if Resize_Enabled then MyResize_.Resize(Self);
end;

procedure TProxySetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
var IniFile: TSimpleIniFile;
begin
  IniFile := TSimpleIniFile.Create;

    IniFile.WriteInteger('Sizes', 'ProxyWidth', Width);
    IniFile.WriteInteger('Sizes', 'ProxyHeight', Height);
    IniFile.WriteInteger('Sizes', 'ProxyLeft', Left);
    IniFile.WriteInteger('Sizes', 'ProxyTop', Top);

  IniFile.Free;
end;

procedure TProxySetupForm.FormDestroy(Sender: TObject);
begin
  Resize_Enabled := false;
  MyResize_.Free;
end;

end.
