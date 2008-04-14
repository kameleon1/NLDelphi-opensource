unit NLDTranslateReg;

interface
  procedure Register;

implementation
uses
  Classes,
  NLDTranslate,
  NLDTManager;

procedure Register;
begin
  RegisterComponents('NLDTranslate', [TNLDTranslate,
                                      TNLDTManager]);  
end;

end.
