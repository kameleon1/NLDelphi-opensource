unit UProperties;

interface
uses
  SysUtils,
  Classes;

type
  // Stores the selected properties of a component
  TNLDComponentItem = class(TCollectionItem)
  private
    FComponent:           TComponent;
    FSelProperties:       TStringList;

    function GetName(): String;
    function GetSelected(Name: String): Boolean;
    procedure SetSelected(Name: String; const Value: Boolean);
    function GetProperties: String;
    procedure SetName(const Value: String);
    procedure SetProperties(const Value: String);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy(); override;

    property Component:       TComponent      read FComponent   write FComponent;
    property Selected[Name: String]: Boolean  read GetSelected  write SetSelected;
  published
    // Used for writing to file
    property Name:            String          read GetName        write SetName;
    property Properties:      String          read GetProperties  write SetProperties;
  end;

  // Stores the components on a form
  TNLDGetComponentEvent = procedure(Sender: TObject; const Name: String;
                                    out Component: TComponent) of object;

  TNLDComponents    = class(TCollection)
  private
    FOnGetComponent:    TNLDGetComponentEvent;

    function GetItem(Index: Integer): TNLDComponentItem;
    procedure SetItem(Index: Integer; const Value: TNLDComponentItem);
  protected
    procedure DoGetComponent(const Name: String; out Component: TComponent);
  public
    constructor Create();

    procedure LoadFromFile(const AFilename: String);
    procedure SaveToFile(const AFilename: String);

    function Add(): TNLDComponentItem;
    function GetFromComponent(const AComponent: TComponent): TNLDComponentItem;

    property Items[Index: Integer]: TNLDComponentItem read GetItem
                                                      write SetItem; default;

    property OnGetComponent:    TNLDGetComponentEvent read FOnGetComponent
                                                      write FOnGetComponent;
  end;

  // Wrapper to allow easy storage of the collection
  TNLDComponentsWrapper = class(TComponent)
  private
    FCollection:        TCollection;
  published
    property Collection:    TCollection read FCollection  write FCollection;
  end;


implementation
uses
  Dialogs;

{
  :: TNLDComponentItem
}
constructor TNLDComponentItem.Create;
begin
  inherited;

  FSelProperties  := TStringList.Create();
end;

destructor TNLDComponentItem.Destroy;
begin
  FreeAndNil(FSelProperties);

  inherited;
end;

function TNLDComponentItem.GetName;
begin
  if Assigned(FComponent) then
    Result  := FComponent.Name
  else
    Result  := '';
end;

function TNLDComponentItem.GetProperties;
begin
  Result  := FSelProperties.Text;
end;


function TNLDComponentItem.GetSelected;
begin
  Result  := (FSelProperties.IndexOf(Name) > -1);
end;

procedure TNLDComponentItem.SetName;
begin
  if (Assigned(Collection)) and (Collection is TNLDComponents) then
    TNLDComponents(Collection).DoGetComponent(Value, FComponent);
end;

procedure TNLDComponentItem.SetProperties;
begin
  FSelProperties.Text := Value;
end;


procedure TNLDComponentItem.SetSelected;
var
  iIndex:     Integer;

begin
  iIndex  := FSelProperties.IndexOf(Name);

  if Value then begin
    if iIndex = -1 then
      FSelProperties.Add(Name);
  end else
    if iIndex > -1 then
      FSelProperties.Delete(iIndex);
end;


{
  :: TNLDComponents
}
constructor TNLDComponents.Create;
begin
  inherited Create(TNLDComponentItem);
end;

function TNLDComponents.Add;
begin
  Result  := TNLDComponentItem(inherited Add());
end;


procedure TNLDComponents.LoadFromFile;
var
  pSource:      TFileStream;
  pWrapper:     TNLDComponentsWrapper;

begin
  Clear();

  // Load from file
  pSource := TFileStream.Create(AFilename, fmOpenRead or fmShareDenyWrite);
  try
    pWrapper  := TNLDComponentsWrapper.Create(nil);
    try
      pWrapper.Collection := Self;
      pSource.ReadComponent(pWrapper);
    finally
      FreeAndNil(pWrapper);
    end;
  finally
    FreeAndNil(pSource);
  end;
end;

procedure TNLDComponents.SaveToFile;
var
  pDest:        TFileStream;
  pWrapper:     TNLDComponentsWrapper;
  iItem:        Integer;

begin
  // Filter unused components
  for iItem := Count - 1 downto 0 do
    if Items[iItem].FSelProperties.Count = 0 then
      Delete(iItem);

  if Count = 0 then
    if FileExists(AFilename) then begin
      DeleteFile(AFilename);
      exit;
    end;

  // Save to file
  pDest := TFileStream.Create(AFilename, fmCreate or fmShareExclusive);
  try
    pWrapper  := TNLDComponentsWrapper.Create(nil);
    try
      pWrapper.Collection := Self;
      pDest.WriteComponent(pWrapper);
    finally
      FreeAndNil(pWrapper);
    end;
  finally
    FreeAndNil(pDest);
  end;
end;


function TNLDComponents.GetItem;
begin
  Result  := TNLDComponentItem(inherited GetItem(Index));
end;

procedure TNLDComponents.SetItem;
begin
  inherited SetItem(Index, Value);
end;


function TNLDComponents.GetFromComponent;
var
  iItem:        Integer;

begin
  for iItem := Count - 1 downto 0 do
    if Items[iItem].Component = AComponent then begin
      Result  := Items[iItem];
      exit;
    end;

  Result            := Add();
  Result.Component  := AComponent;
end;

procedure TNLDComponents.DoGetComponent;
begin
  if Assigned(FOnGetComponent) then
    FOnGetComponent(Self, Name, Component);
end;

end.
