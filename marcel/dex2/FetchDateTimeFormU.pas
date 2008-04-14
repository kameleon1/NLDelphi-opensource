unit FetchDateTimeFormU;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls;

type
  TFetchDateTimeForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    DatePicker: TDateTimePicker;
    TimePicker: TDateTimePicker;
  private
    function GetDateTime: Integer;
  public
    property DateTime: Integer read GetDateTime;
    constructor Create(AOwner: TComponent); override;
  end;


implementation

{$R *.DFM}

uses
  DateUtils;

{ TFetchDateTimeForm }

constructor TFetchDateTimeForm.Create(AOwner: TComponent);
begin
  inherited;

  DatePicker.Date := Date;
end;

function TFetchDateTimeForm.GetDateTime: Integer;
var
  DateTime: TDateTime;
begin
  DateTime := DatePicker.DateTime;
  ReplaceTime(DateTime, TimePicker.Time);
  DateTime := DateTime;
  Result := DateTimeToUnix(DateTime);
end;

end.
