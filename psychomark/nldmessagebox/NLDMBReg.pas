unit NLDMBReg;

interface
uses
  Classes,
  NLDMsgBox;

  procedure Register();

implementation

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDMessageBox]);
end;

end.
