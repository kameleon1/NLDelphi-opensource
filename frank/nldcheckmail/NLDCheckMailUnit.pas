unit NLDCheckMailUnit;

interface

uses
  Windows, SysUtils, Forms, IdBaseComponent, IdComponent, IdTCPConnection,
  IdPOP3, INIFiles, Classes, ExtCtrls, IdMessageClient, IdTCPClient;

type
  TForm1 = class(TForm)
    IdPOP31: TIdPOP3;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ScrollLock: boolean;
  State: Short;

implementation

{$R *.dfm}

procedure SetKeyState(Key: Word; TurnOn: boolean);
  procedure PressKey(Key: Word);
  begin
    // Druk toets in...
    keybd_event(Key, 0, 0, 0);

    // ...en laat weer los
    keybd_event(Key, 0, KEYEVENTF_KEYUP, 0);
  end;

begin
  if TurnOn then begin
    // Controleer of de toets op 'uit' staat
    if LoWord(GetKeyState(Key)) = 0 then
      PressKey(Key);
  end else begin
    // Controleer of de toets op 'aan' staat
    if LoWord(GetKeyState(Key)) = 1 then
      PressKey(Key);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  try
    //Maak verbinding met de POP3 server en kijk of er nieuwe berichten zijn
    IdPOP31.Connect;
    if IdPOP31.CheckMessages <> 0 then
      Timer2.Enabled := true
    else
    begin
      SetKeyState(VK_SCROLL, (LoWord(State) = 1));
      Timer2.Enabled := false;
    end;
  except
    //Als er fouten zijn (die zeer waarschijnlijk ontstaan als je je mail
    //ophaalt in bijv. Outlook, omdat er dan al een verbinding is) negeer
    //deze dan
    on Exception do
      ;
  end;
  IdPOP31.Disconnect;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if ScrollLock then
  begin
    SetKeyState(VK_SCROLL, false);
    ScrollLock := false;
  end else
  begin
    SetKeyState(VK_SCROLL, true);
    ScrollLock := true;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Lees alle instellingen uit het bestand <exenaam>.ini
  with TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini')) do
  try
    IdPOP31.Host := ReadString('POP', 'Host', 'localhost');
    IdPOP31.Username := ReadString('POP', 'Username', '');
    IdPOP31.Password := ReadString('POP', 'Password', '');
    Timer1.Interval := ReadInteger('Intervals', 'MailCheckInterval', 1000);
    Timer2.Interval := ReadInteger('Intervals', 'FlashInterval', 500);
  finally
    Free;
  end;

  State := GetKeyState(VK_SCROLL);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetKeyState(VK_SCROLL, (LoWord(State) = 1));
end;

end.
