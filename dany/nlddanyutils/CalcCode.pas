unit CalcCode;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface
function regcode(key, s: {short}string): {short}string;

implementation

uses SysUtils;

function regcode(key, s: {short}string): {short}string;
type
  Tbewerking = (maal, plus);
var
  bewerking: Tbewerking;
  resultaat: real;
  i: byte;
  res: {short}string;
  err: integer;
  offs: word;
begin
  val(key, offs, err);
  s := trim(s);
  bewerking := maal;
  resultaat := length(s); { start with the length of the string }
  for i := 1 to length(s) do
  begin
    case bewerking of
      maal:
        begin
          resultaat := resultaat * (offs - ord(s[i]));
          bewerking := plus;
        end;
      plus:
        begin
          resultaat := resultaat + (offs - ord(s[i]));
          bewerking := maal;
        end;
    end; {case}
  end;
  //str(resultaat: 1: 0, res);
  Res := FloatToStrF(resultaat, ffFixed, 1, 0);
  Result := res;
end;

end.
