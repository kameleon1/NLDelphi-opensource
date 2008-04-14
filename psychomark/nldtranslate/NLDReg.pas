unit NLDReg;

interface
  procedure Register;

implementation
uses
  Classes,
  NLDTManager,
  NLDTranslate;

procedure Register;
begin
  // Register components
  RegisterComponents('NLDTranslate v2', [TNLDTManager,
                                         TNLDTranslate]);
end;

end.
