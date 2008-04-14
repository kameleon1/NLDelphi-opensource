unit NLDNotifier;

interface

uses
  Windows, Controls, Messages, SysUtils, Classes, Forms, StdCtrls, ExtCtrls,
  Contnrs, Graphics;

type
  TNLDNotifier = class;
  TNotifyForm = class;

  TNotifyLabel = class(TLabel)
  private
    FForm: TNotifyForm;
  protected
    procedure Click; override;
    property Form: TNotifyForm read FForm;
    constructor Create(AOwner: TNotifyForm); reintroduce;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X: Integer; Y: Integer); override;
  end;

  { Formulier voor [TNLDNotifier] }
  TNotifyForm = class(TCustomForm)
  private
    FLabel: TNotifyLabel;
    FTimer: TTimer;
    FNotifier: TNLDNotifier;
    FURL: string;
    procedure TimerDone(Sender: TObject);
    function GetText: string;
    procedure SetText(const Value: string);
    procedure Remove;
    function GetTimeout: Integer;
    procedure SetTimeout(const Value: Integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    property Text: string read GetText Write SetText;
    property URL: string read FURL write FURL;
    property Timeout: Integer read GetTimeout write SetTimeout;
    property Notifier: TNLDNotifier read FNotifier;

    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
  end;

  { Component om een een textbox by de traybar tekst(en) te tonen }
  TNLDNotifier = class(TComponent)
  private
    FFormList: TComponentList;
    FColor: TColor;
    FTimeout: Integer;
    FEnabled: Boolean;
    FOnClick: TNotifyEvent;
    FLinkColor: TColor;
    FTextColor: TColor;
  public
    procedure Execute(const NotifyText: string; URL: string = '';
      Tag: integer = -1);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteForm(Form: TNotifyForm);
  published
    property Color: TColor read FColor write FColor;
    property TextColor: TColor read FTextColor write FTextColor;
    property LinkColor: TColor read FLinkColor write FLinkColor;
    property Timeout: Integer read FTimeout write FTimeout;
    property Enabled: Boolean read FEnabled write FEnabled;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

procedure Register;

implementation

uses
  ShellAPI;

const
  FormHeight = 20;
  FormWidth = 400;

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDNotifier]);
end;

{ TNLDNotifier }

constructor TNLDNotifier.Create(AOwner: TComponent);
begin
  inherited;
  FFormList := TComponentList.Create;
  FFormList.OwnsObjects := False;
end;

{ Formulier wordt uit de lijst gehaald en vrijgegeven }
procedure TNLDNotifier.DeleteForm(Form: TNotifyForm);
begin
  FFormList.Remove(Form);
  { Moet in dit geval een release zijn omdat free regelmatig AV's abstract
    errors geeft }
  Form.Release;
end;

destructor TNLDNotifier.Destroy;
begin
  FFormList.Free;
  inherited;
end;

{ Nieuw formulier wordt aangemaakt en onder eventueel eerdere formulieren
  geplaatst }
procedure TNLDNotifier.Execute(const NotifyText: string; URL: string = '';
  Tag: Integer = -1);
var
  Form: TNotifyForm;
  i: Integer;
begin
  if not FEnabled then
    Exit;

  { De overige forms omhoogschuiven }
  for i := 0 to FFormList.Count -1 do
   TNotifyForm(FFormList[i]).Top := TNotifyForm(FFormList[i]).Top - FormHeight;

  Form := TNotifyForm.CreateNew(Self);
  Form.URL := URL;
  Form.Tag := Tag;
  FFormList.Add(Form);

  Form.Color := FColor;
  Form.Text := NotifyText;
  Form.Timeout := FTimeout;
  ShowWindow(Form.Handle, SW_SHOWNOACTIVATE);
  Form.Visible := True;
  Form.Update;
end;

{ TNotifyForm }

{ Wordt aangeroepen door de timer. Roept FNotifier.[DeleteForm] aan. }
procedure TNotifyForm.TimerDone(Sender: TObject);
begin
  Remove;
end;

procedure TNotifyForm.Remove;
begin
  FNotifier.DeleteForm(Self);
end;

constructor TNotifyForm.CreateNew(AOwner: TComponent; Dummy: Integer);
var
  r: TRect;
begin
  inherited;
  FNotifier := TNLDNotifier(AOwner);
  FormStyle := fsStayOnTop;

  Color := clInfoBk;
  Height := FormHeight;
  Width := FormWidth;
  BorderIcons := [];
  BorderStyle := bsNone;

  { Desktopomvang ophalen }
  SystemParametersInfo(SPI_GETWORKAREA, 0, @r, 0);
  Left := r.Right - Width;
  Top := r.Bottom - Height;

  FTimer := TTimer.Create(self);
  FTimer.Interval := 0;
  FTimer.Enabled := False;
  FTimer.OnTimer := TimerDone;

  FLabel := TNotifyLabel.Create(self);
  FLabel.Parent := self;
  FLabel.Left := 3;
  FLabel.Top := 3;
  FLabel.Font.Color := Notifier.FTextColor;
end;

procedure TNotifyForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;
  Params.Style := Params.Style and not WS_CAPTION or WS_POPUP;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW;

  { TODO : Testen of alles nu goed gaat 
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE;
    maar dat gaf DrWatson meldingen op NT
  }
end;

function TNotifyForm.GetText: string;
begin
  Result := FLabel.Caption;
end;

procedure TNotifyForm.SetText(const Value: string);
begin
  FLabel.Caption := Value;
  FLabel.ShowHint := True;
  FLabel.Hint := Value;
end;

function TNotifyForm.GetTimeout: Integer;
begin
  Result := FTimer.Interval div 1000;
end;

procedure TNotifyForm.SetTimeout(const Value: Integer);
begin
  FTimer.Interval := Value * 1000;
  FTimer.Enabled := FTimer.Interval > 0;
end;

{ TNotifyLabel }

procedure TNotifyLabel.Click;
begin
  inherited;
  Form.FTimer.Enabled := False;

  if Form.URL <> '' then
    ShellExecute(0, 'open', PChar(Form.URL), nil, nil, SW_SHOW);

  if Assigned(Form.Notifier.OnClick) then
    Form.Notifier.OnClick(Form);

  Form.Remove;
end;

procedure TNotifyLabel.CMMouseEnter(var Message: TMessage);
begin
  Font.Color := Form.Notifier.LinkColor;
  Font.Style := Font.Style + [fsUnderline];
end;

procedure TNotifyLabel.CMMouseLeave(var Message: TMessage);
begin
  Font.Color := Form.Notifier.TextColor;
  Font.Style := Font.Style - [fsUnderline];
end;

constructor TNotifyLabel.Create(AOwner: TNotifyForm);
begin
  inherited Create(AOwner);
  FForm := AOwner;
  Cursor := crHandPoint;
end;

procedure TNotifyLabel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Button = mbRight then
    Form.Remove;
end;

end.
