{-------------------------------------------------------------------------------
  Registratie unit
-------------------------------------------------------------------------------}

unit NLDTXCollectionWizard;

interface

uses
  ToolsApi, Dialogs;

type
  TCollectionWizard = class(TNotifierObject, IOTAMenuWizard, IOTAWizard)
  public
    // IOTAWizard interface methods
    function GetIDString: string; virtual;
    function GetName: string; virtual;
    function GetState: TWizardState; virtual;
    procedure Execute; virtual;
    // IOTAMenuWizard voor een menu item in het help menu
    function GetMenuText: string; virtual;
  end;

procedure Register;

implementation

uses
  NLDTXCreateCollection,
  NLDTXFormEditCollection;

procedure Register;
begin
  RegisterPackageWizard(TCollectionWizard.Create);
end;

{ TTredoxBuilder }

procedure TCollectionWizard.Execute;
var
  ItemName: string;
  Mode: TCollectionCreateMode;
begin
  ItemName := '';
  if InputCollectionItem(ItemName, Mode) then
    InsertCode(ItemName, Mode);
end;

function TCollectionWizard.GetIDString: string;
begin
  Result := 'NLD.CollectionWizard';
end;

function TCollectionWizard.GetMenuText: string;
begin
  Result := 'NLD &Collection Wizard...';
end;

function TCollectionWizard.GetName: string;
begin
  Result := 'NLD Collection Wizard';
end;

function TCollectionWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

end.

