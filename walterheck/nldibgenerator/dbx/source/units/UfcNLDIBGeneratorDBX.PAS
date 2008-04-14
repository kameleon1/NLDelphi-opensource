unit UfcNLDIBGeneratorDBX;

interface

uses
  SysUtils, Classes, SQLExpr;

type
  TNLDIBGeneratorDBX = class (TComponent)
  private
    FGenerator: string;
    FQuery: TSQLQuery;
    FSQLConnection: TSQLConnection;
    function GetCurrentValue: LongInt;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetValue(StepSize: integer): LongInt;
    property CurrentValue: LongInt read GetCurrentValue;
  published
    property Generator: string read FGenerator write FGenerator;
    property SQLConnection: TSQLConnection read FSQLConnection write 
            FSQLConnection;
  end;
  

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDIBGeneratorDBX]);
end;

{
****************************** TNLDIBGeneratorDBX ******************************
}
constructor TNLDIBGeneratorDBX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FQuery:=TSQLQuery.Create(nil);
end;

destructor TNLDIBGeneratorDBX.Destroy;
begin
  FreeAndNil(FQuery);
  inherited Destroy;
end;

function TNLDIBGeneratorDBX.GetCurrentValue: LongInt;
begin
  result:=GetValue(0);
end;

function TNLDIBGeneratorDBX.GetValue(StepSize: integer): LongInt;
begin
  with FQuery do
  begin
    try
      Close;
      SQLConnection:=Self.SQLConnection;
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
