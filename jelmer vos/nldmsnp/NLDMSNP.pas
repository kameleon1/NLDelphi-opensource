unit NLDMSNP;

interface

uses
  Classes, MSNProtocol;

type
  TNLDMSNP = class(TMSNP);

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDMSNP]);
end;

end.
