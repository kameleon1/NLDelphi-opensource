unit FetchDateTimeFormU;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, Mask, JvExMask, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit, JvDatePickerEdit,
  JvExComCtrls, JvDateTimePicker;

type
  TFetchDateTimeForm = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    DateLabel: TLabel;
    DatePicker: TDateTimePicker;
    TimePicker: TDateTimePicker;
    Panel1: TPanel;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    TimeLabel: TLabel;
    Bevel2: TBevel;
    procedure FormShow(Sender: TObject);
  private
    function GetDateTime: Integer;
  public
    property DateTime: Integer read GetDateTime;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function FetchDateTime(var aDateTime: integer): boolean;
  end;


implementation

{$R *.DFM}

uses
  DateUtils, SettingsUnit;

{ TFetchDateTimeForm }

constructor TFetchDateTimeForm.Create(AOwner: TComponent);
begin
  inherited;
  DatePicker.Date := Date;
end;

destructor TFetchDateTimeForm.Destroy;
begin
  Settings.FetchDateTimeForm.Left := Left;
  Settings.FetchDateTimeForm.Top := Top;
  inherited;
end;

class function TFetchDateTimeForm.FetchDateTime(var aDateTime: integer): boolean;
begin
  aDateTime := 0;
  with TFetchDateTimeForm.Create(nil) do
  try
    Result := ShowModal = mrOK;
    if Result then
      aDateTime := DateTime;
  finally
    Free;
  end;
end;

function TFetchDateTimeForm.GetDateTime: Integer;
var
  DateTime: TDateTime;
begin
  DateTime := DatePicker.DateTime;
  ReplaceTime(DateTime, TimePicker.Time);
  DateTime := DateTime; //geheel getal maken
  Result := DateTimeToUnix(DateTime);
end;

procedure TFetchDateTimeForm.FormShow(Sender: TObject);
begin
  Left := Settings.FetchDateTimeForm.Left;
  Top := Settings.FetchDateTimeForm.Top;
end;

end.
