unit SMTPSetup;

// Dany Rosseel

{ History of this unit
  27-09-2003: Initial version
  09-10-2003: Adaptions made to meet coding conventions
}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdSmtp;

type
  TSMTPSetupForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    SmtpServerEdit: TEdit;
    SmtpPortEdit: TEdit;
    GroupBox2: TGroupBox;
    Button1: TButton;
    UsedCheckBox: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    SmtpAccountNameEdit: TEdit;
    SmtpPasswordEdit: TEdit;
    EmailAddressEdit: TEdit;
    ReplyAddressEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure UsedCheckBoxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SmtpServerEditChange(Sender: TObject);
    procedure SmtpPortEditChange(Sender: TObject);
    procedure SmtpAccountNameEditChange(Sender: TObject);
    procedure SmtpPasswordEditChange(Sender: TObject);
    procedure EmailAddressEditChange(Sender: TObject);
    procedure ReplyAddressEditChange(Sender: TObject);
  private
    { Private declarations }
    SmtpChanged: boolean;
    procedure ReadSmtp;
    procedure WriteSmtp;
    procedure Get;
    procedure Put;
    procedure UpdateForm;
    procedure Init;
  public
    { Public declarations }
    English : boolean;
  end;

var
  SMTPSetupForm: TSMTPSetupForm;

procedure GetSmtpValues(var
  SmtpServer,
  SmtpPort: string;
  var
  SmtpLogin: TIdSMTPAuthenticationType;
  var
  SmtpAccount,
  SmtpPassword: string);

procedure GetEmailAddresses(var EmailAddress,
  ReplyAddress: string);

implementation

{$R *.dfm}

uses SimpleRegistry;

var
  Info: record
    SmtpServer: {short}string;
    SmtpPort: {short}string;
    SmtpUseLogin: TIdSMTPAuthenticationType;
    SmtpAccountName: {short}string;
    SmtpPassword: {short}string;
    EmailAddress: {short}string;
    ReplyAddress: {short}string;
  end;

procedure GetSmtpValues(var
  SmtpServer,
  SmtpPort: string;
  var
  SmtpLogin: TIdSMTPAuthenticationType;
  var
  SmtpAccount,
  SmtpPassword: string);
begin
  SmtpServer := Info.SmtpServer;
  SmtpPort := Info.SmtpPort;
  SmtpLogin := Info.SmtpUseLogin;
  if SmtpLogin = satDefault then
  begin
    SmtpAccount := Info.SmtpAccountName;
    SmtpPassword := Info.SmtpPassword;
  end;
end;

procedure GetEmailAddresses(var EmailAddress,
  ReplyAddress: string);
begin
  EmailAddress := Info.EmailAddress;
  ReplyAddress := Info.ReplyAddress;
end;

procedure TSMTPSetupForm.UpdateForm;
begin
  SmtpAccountNameEdit.Enabled := UsedCheckbox.Checked;
  SmtpPasswordEdit.Enabled := UsedCheckbox.Checked;
end;

procedure TSMTPSetupForm.Get;
begin

  SmtpServerEdit.Text := Info.SmtpServer;
  SmtpPortEdit.Text := Info.SmtpPort;
  UsedCheckBox.Checked := (Info.SmtpUseLogin = satDefault);
  SmtpAccountNameEdit.Text := Info.SmtpAccountName;
  SmtpPasswordEdit.Text := Info.SmtpPassword;
  EmailAddressEdit.Text := Info.EmailAddress;
  ReplyAddressEdit.Text := Info.ReplyAddress;
  UpdateForm;

end;

procedure TSMTPSetupForm.Put;
begin

  Info.SmtpServer := SmtpServerEdit.Text;
  Info.SmtpPort := SmtpPortEdit.Text;
  if UsedCheckBox.Checked then
    Info.SmtpUseLogin := satDefault
  else
    Info.SmtpUseLogin := satNone;
  Info.SmtpAccountName := SmtpAccountNameEdit.Text;
  Info.SmtpPassword := SmtpPasswordEdit.Text;
  Info.EmailAddress := EmailAddressEdit.Text;
  Info.ReplyAddress := ReplyAddressEdit.Text;

end;

const
  SmtpRegister = 'Software\Rcs\Smtp\';

procedure TSMTPSetupForm.WriteSmtp;
var
  F: TSimpleRegistry;
begin

  Put; // Put all values from the UI Info the 'Info' record
  F := TSimpleRegistry.Create;
  F.WriteString(SmtpRegister + 'Configuration', 'Server', Info.SmtpServer);
  F.WriteString(SmtpRegister + 'Configuration', 'Port', Info.SmtpPort);
  F.WriteInteger(SmtpRegister + 'Login', 'UseLogin',
    Integer(Info.SmtpUseLogin));
  F.WriteString(SmtpRegister + 'Login', 'AccountName', Info.SmtpAccountName);
  F.WriteString(SmtpRegister + 'Login', 'Password', Info.SmtpPassword);
  F.WriteString(SmtpRegister + 'Addresses', 'Email', Info.EmailAddress);
  F.WriteString(SmtpRegister + 'Addresses', 'Answer', Info.ReplyAddress);
  F.Free;

end;

procedure TSMTPSetupForm.ReadSmtp;
var
  F: TSimpleRegistry;
begin

  F := TSimpleRegistry.Create;
  Info.SmtpServer := F.ReadString(SmtpRegister + 'Configuration', 'Server', '');
  Info.SmtpPort := F.ReadString(SmtpRegister + 'Configuration', 'Port', '25');
  Info.SmtpUseLogin := TIdSmtpAuthenticationType(F.ReadInteger(SmtpRegister + 'Login',
    'UseLogin', Integer(satNone)));
  Info.SmtpAccountName := F.ReadString(SmtpRegister + 'Login', 'AccountName',
    '');
  Info.SmtpPassword := F.ReadString(SmtpRegister + 'Login', 'Password', '');
  Info.EmailAddress := F.ReadString(SmtpRegister + 'Addresses', 'Email', '');
  Info.ReplyAddress := F.ReadString(SmtpRegister + 'Addresses', 'Answer', '');
  F.Free;
  Get; // Get all values from the the 'Info' record into the UI

end;

procedure TSMTPSetupForm.FormCreate(Sender: TObject);
begin
  English := false;
  Init;
  ReadSmtp;
end;

procedure TSMTPSetupForm.UsedCheckBoxClick(Sender: TObject);
begin
  UpdateForm;
  SmtpChanged := true;
end;

procedure TSMTPSetupForm.Button1Click(Sender: TObject);
begin
  if SmtpChanged then
    WriteSmtp;
end;

procedure TSMTPSetupForm.Init;
var
  R: TSimpleRegistry;
  Account: string;
const
  AccountMgr = '\Software\Microsoft\Internet Account Manager';
  MailAccounts = '\Software\Microsoft\Internet Account Manager\Accounts\';
begin

  R := TSimpleRegistry.Create;
  try
    if not R.KeyExists(SmtpRegister) then
    begin
      Account := R.ReadString(AccountMgr, 'Default Mail Account', '');

      if (Account > '') then
      begin                             // default mail Account found

        Info.SmtpServer := R.Readstring(MailAccounts + Account, 'SMTP Server',
          '');
        Info.SmtpPort := IntToStr(R.ReadInteger(MailAccounts + Account,
          'SMTP Port', 25));

        case R.ReadInteger(MailAccounts + Account, 'SMTP Use Sicily', 0) of
          0:
            begin
              Info.SmtpUseLogin := satNone;
            end;
          1:
            begin
              Info.SmtpUseLogin := satNone;
            end;
          2:
            begin
              Info.SmtpUseLogin := satDefault;
              Info.SmtpAccountName := R.ReadString(MailAccounts + Account,
                'POP3 User Name', '');
              Info.SmtpPassword := '';
            end;
          3:
            begin
              Info.SmtpUseLogin := satDefault;
              Info.SmtpAccountName := R.ReadString(MailAccounts + Account,
                'SMTP User Name', '');
              Info.SmtpPassword := '';
            end;
        end;

        Info.EmailAddress := R.ReadString(MailAccounts + Account,
          'SMTP Email Address', '');
        Info.ReplyAddress := R.ReadString(MailAccounts + Account,
          'SMTP Reply To Email Address', '');

        Get;
        WriteSmtp;
      end;
    end;
  finally
    R.Free;
  end;

end;

procedure TSMTPSetupForm.FormShow(Sender: TObject);
begin
  if English then
  begin
    GroupBox1.Caption := 'Outgoing E-mail Server';
    Label2.Caption := 'Port';
    UsedCheckBox.Caption := 'Server Login needed';
    Label3.Caption := 'Account Name';
    Label4.Caption := 'Password';
    GroupBox2.Caption := 'Addresses';
    Label5.Caption := 'E-mail Address';
    Label6.Caption := 'Reply Address';
  end;
  ReadSmtp;
  SmtpChanged := false;
  ActiveControl := Button1;
end;

procedure TSMTPSetupForm.SmtpServerEditChange(Sender: TObject);
begin
  SmtpChanged := true;
end;

procedure TSMTPSetupForm.SmtpPortEditChange(Sender: TObject);
begin
  SmtpChanged := true;
end;

procedure TSMTPSetupForm.SmtpAccountNameEditChange(Sender: TObject);
begin
  SmtpChanged := true;
end;

procedure TSMTPSetupForm.SmtpPasswordEditChange(Sender: TObject);
begin
  SmtpChanged := true;
end;

procedure TSMTPSetupForm.EmailAddressEditChange(Sender: TObject);
begin
  SmtpChanged := true;
end;

procedure TSMTPSetupForm.ReplyAddressEditChange(Sender: TObject);
begin
  SmtpChanged := true;
end;

end.
