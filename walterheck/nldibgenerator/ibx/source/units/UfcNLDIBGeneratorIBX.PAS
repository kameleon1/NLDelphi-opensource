unit UfcNLDIBGeneratorIBX;

interface

uses
  SysUtils, Classes, IBDatabase, IBQuery;

type
  TNLDIBGeneratorIBX = class (TComponent)
  private
    FGenerator: string;
    FIBDatabase: TIBDatabase;
    FQuery: TIBQuery;
    FTransaction: TIBTransaction;
    function GetCurrentValue: LongInt;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetValue(StepSize: integer): LongInt;
    property CurrentValue: LongInt read GetCurrentValue;
  published
    property Generator: string read FGenerator write FGenerator;
    property IBDatabase: TIBDatabase read FIBDatabase write FIBDatabase;
  end;
  

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDIBGeneratorIBX]);
end;

{
****************************** TNLDIBGeneratorIBX ******************************
}
constructor TNLDIBGeneratorIBX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FQuery:=TIBQuery.Create(nil);
  FTransaction:=TIBTransaction.Create(nil);
end;

destructor TNLDIBGeneratorIBX.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FTransaction);
  inherited Destroy;
end;

function TNLDIBGeneratorIBX.GetCurrentValue: LongInt;
begin
  result:=GetValue(0);
end;

function TNLDIBGeneratorIBX.GetValue(StepSize: integer): LongInt;
begin
  with FQuery do
  begin
    try
      Close;
      IBDatabase:=FIBDatabase;
      Transaction:=FTransaction;
      FTransaction.DefaultDatabase:=FIBDatabase;
      SQL.Text:=Format('select GEN_ID(%s,%d) as ID from RDB$DATABASE',[FGenerator,StepSize]);
      Open;
      First;
      Result:=FieldByName('ID').AsInteger;
      Close;
    except
      raise Exception.create('Failed to retrieve generator value');
    end;
  end;
end;


end.
