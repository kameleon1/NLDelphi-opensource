unit NLDTranslate;

{
  :: NLDTranslate is a set components which make it easy to apply
  :: runtime translation to an application. It uses the flexible XML
  :: format to define language files.

  :$
  :$
  :$ NLDTranslate is released under the zlib/libpng OSI-approved license.
  :$ For more information: http://www.opensource.org/
  :$ /n/n
  :$ /n/n
  :$ Copyright (c) 2002 M. van Renswoude
  :$ /n/n
  :$ This software is provided 'as-is', without any express or implied warranty.
  :$ In no event will the authors be held liable for any damages arising from
  :$ the use of this software.
  :$ /n/n
  :$ Permission is granted to anyone to use this software for any purpose,
  :$ including commercial applications, and to alter it and redistribute it
  :$ freely, subject to the following restrictions:
  :$ /n/n
  :$ 1. The origin of this software must not be misrepresented; you must not
  :$ claim that you wrote the original software. If you use this software in a
  :$ product, an acknowledgment in the product documentation would be
  :$ appreciated but is not required.
  :$ /n/n
  :$ 2. Altered source versions must be plainly marked as such, and must not be
  :$ misrepresented as being the original software.
  :$ /n/n
  :$ 3. This notice may not be removed or altered from any source distribution.
}

{$I NLDTDefines.inc}

{TODO Support Collection properties}
{TODO Implement Undo functionality}
{TODO Set Section to Owner name by default}

interface
uses
  SysUtils,
  Classes,
  Contnrs,
  XDOM_2_3,
  NLDTInterfaces,
  NLDTGlobal;

type
  {
    :$ Performs the translation on it's owner

    :: TNLDTranslate hooks up to a manager and performs the actual translation.
  }
  TCustomNLDTranslate = class(TNLDTBaseComponent, INLDTranslate, INLDTEvent,
                              INLDTFileChangeEvent, INLDTTreeWalkEvent)
  private
    FManager:           INLDTManager;
    FSection:           String;

    FOnFileChange:      TNotifyEvent;

    FTreeStack:         TStack;

    FUndoDOM:           TDomImplementation;
    FUndoDocument:      TDomDocument;
    FUndoParent:        TDomElement;
    FUndoEmpty:         Boolean;
    FUndoAllow:         Boolean;

    procedure SetManagerInternal(const Value: INLDTManager);
    procedure SetSection(const Value: String);
  protected
    procedure DoFileChange(); virtual;

    function InternalQuerySection(const AItem: INLDTTreeItem;
                                  const AStoreUndo: Boolean): Boolean; virtual; stdcall;
    function InternalQueryTreeItem(const AItem: INLDTTreeItem;
                                   const AStoreUndo: Boolean): Boolean; virtual; stdcall;
    procedure InternalEndTreeItem(const AItem: INLDTTreeItem;
                                  const AStoreUndo: Boolean); virtual; stdcall;

    // INLDTranslate implementation
    procedure SetManager(const Value: INLDTManager); virtual; stdcall;

    // INLDTEvent implementation
    procedure Detach(const ASender: INLDTInterface); virtual; stdcall;

    // INLDTFileChangeEvent implementation
    procedure FileChanged(const ASender: INLDTManager); virtual; stdcall;

    // INLDTTreeWalkEvent implementation
    function QuerySection(const AItem: INLDTTreeItem): Boolean; virtual; stdcall;
    function QueryTreeItem(const AItem: INLDTTreeItem): Boolean; virtual; stdcall;
    procedure EndTreeItem(const AItem: INLDTTreeItem); virtual; stdcall;

    procedure ApplyProperties(const AObject: TObject;
                              const AItem: INLDTTreeItem;
                              const AStoreUndo: Boolean); virtual;

    //:$ Gets or sets the manager
    //:: Set the Manager property to an object supporting the INLDTManager
    //:: interface (generally TNLDTManager).
    property Manager:       INLDTManager  read FManager write SetManagerInternal;

    //:$ Gets or sets the section
    //:: The section specifies which second-level node is used to get
    //:: translation data. Refer to the language file format specifications
    //:: for more information about sections and nodes.
    property Section:       String        read FSection write SetSection;


    //:$ Raised when the manager's language file changes
    property OnFileChange:  TNotifyEvent  read FOnFileChange  write FOnFileChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // INLDTranslate implementation
    //:$ Reverts all language changes
    //:: Undo reverts any changes made to the owner.
    procedure Undo(); virtual; stdcall;
  end;

  TNLDTranslate       = class(TCustomNLDTranslate)
  published
    property Manager;
    property Section;

    property OnFileChange;
  end;


implementation
uses
  Dialogs,
  TypInfo,
  Formatted_XDOM,
  NLDTRTTIUtils,
  NLDTXDOMUtils;


{******************* TCustomNLDTranslate
  Con/destructor
****************************************}
constructor TCustomNLDTranslate.Create;
begin
  inherited;

  FTreeStack    := TStack.Create();
  FUndoDOM      := TDomImplementation.Create(nil);
  FUndoDocument := FUndoDOM.createDocument('language', nil);
  FUndoEmpty    := True;
  FUndoAllow    := True;
end;

destructor TCustomNLDTranslate.Destroy;
begin
  FUndoDOM.freeDocument(FUndoDocument);
  FreeAndNil(FUndoDOM);
  FreeAndNil(FTreeStack);

  inherited;
end;


{******************* TCustomNLDTranslate
  INLDTEvent implementation
****************************************}
procedure TCustomNLDTranslate.Detach;
begin
  if ASender = FManager then
    FManager  := nil;
end;


{******************* TCustomNLDTranslate
  Undo
****************************************}
procedure TCustomNLDTranslate.Undo;
  procedure InternalProcessSection(const ANode: TDomElement);
  var
    xmlNode:        TDomElement;
    ifItem:         INLDTTreeItem;

  begin
    xmlNode := ANode.findFirstChildElement();
    while Assigned(xmlNode) do begin
      ifItem  := TNLDTTreeItem.Create(xmlNode);
      try
        // Query
        if InternalQueryTreeItem(ifItem, False) then begin
          InternalProcessSection(xmlNode);
          InternalEndTreeItem(ifItem, False);
        end;
      finally
        ifItem  := nil;
      end;

      xmlNode := xmlNode.findNextSiblingElement();
    end;
  end;

var
  xmlRoot:          TDomElement;
  ifItem:           INLDTTreeItem;

begin
  xmlRoot := FUndoDocument.documentElement;

  // Imitate NLDTManager.ProcessSection
  ifItem  := TNLDTTreeItem.Create(xmlRoot);
  try
    InternalQuerySection(ifItem, False);
    InternalProcessSection(xmlRoot);

    xmlRoot.clear();
    FUndoEmpty  := True;
  finally
    ifItem  := nil;
  end;
end;


procedure TCustomNLDTranslate.FileChanged;
begin
  DoFileChange();
end;

function TCustomNLDTranslate.InternalQuerySection;
begin
  Result  := ((Length(FSection) > 0) and (FSection = AItem.GetName()));

  if Result then begin
    // New section comin' up, reset
    while FTreeStack.Count > 0 do
      FTreeStack.Pop();

    FUndoParent := FUndoDocument.documentElement;
    if AStoreUndo then
      FUndoParent.clear();

    // Check for owner to apply properties to
    if Assigned(Self.Owner) then
      ApplyProperties(Self.Owner, AItem, True);
  end;
end;

function TCustomNLDTranslate.InternalQueryTreeItem;
var
  sName:        String;
  pParent:      TObject;
  pDest:        TObject;
  pInfo:        TNLDTRTTIInfo;
  iComponent:   Integer;
  xmlTemp:      TDomElement;

begin
  // Get parent object
  if FTreeStack.Count > 0 then
    pParent := TObject(FTreeStack.Peek())
  else
    pParent := Self.Owner;

  if not Assigned(pParent) then begin
    Result  := False;
    exit;
  end;

  pDest := nil;
  sName := AItem.GetName();

  if (pParent is TCollection) and (sName = 'Item') then begin
    // Destination is a TCollection's item
    iComponent  := StrToIntDef(AItem.GetAttributeValueByName('Index'), -1);

    if (iComponent > -1) and (iComponent < TCollection(pParent).Count) then
      pDest := TCollection(pParent).Items[iComponent];
  end else begin
    pInfo := TNLDTRTTIInfo.Create(pParent);
    try
      // Check if the object has a property with this name
      if (pInfo.HasProperty(sName)) and
         (pInfo.GetPropertyType(sName) = tkClass) then
        // Class property exist
        pDest := pInfo.GetPropertyAsObject(sName)
      else begin
        // Try to find owned object
        if pParent is TComponent then
          with TComponent(pParent) do
            for iComponent  := 0 to ComponentCount - 1 do
              if CompareText(Components[iComponent].Name, sName) = 0 then begin
                pDest := Components[iComponent];
                break;
              end;
      end;
    finally
      FreeAndNil(pInfo);
    end;
  end;

  // Add object to stack
  Result  := Assigned(pDest);
  if not Result then
    exit;

  FTreeStack.Push(Pointer(pDest));

  if AStoreUndo then begin
    // Create new element
    xmlTemp     := FUndoDocument.createElement(sName);
    FUndoParent.appendChild(xmlTemp);
    FUndoParent := xmlTemp;
  end;

  // Apply properties
  ApplyProperties(pDest, AItem, True);
end;

procedure TCustomNLDTranslate.InternalEndTreeItem;
begin
  // We're done with the component, remove it from the stack
  FTreeStack.Pop();

  if AStoreUndo then
    // ...and up one undo level we go!
    FUndoParent := FUndoParent.findParentElement();
end;


function TCustomNLDTranslate.QuerySection;
begin
  FUndoAllow  := FUndoEmpty;
  FUndoEmpty  := False;
  Result      := InternalQuerySection(AItem, FUndoAllow);
end;

function TCustomNLDTranslate.QueryTreeItem;
begin
  Result  := InternalQueryTreeItem(AItem, FUndoAllow);
end;

procedure TCustomNLDTranslate.EndTreeItem;
begin
  InternalEndTreeItem(AItem, FUndoAllow);
end;


procedure TCustomNLDTranslate.ApplyProperties;
var
  pInfo:      TNLDTRTTIInfo;
  iAttr:      Integer;
  sName:      String;
  sValue:     String;
  bHasProp:   Boolean;
  bIsIndex:   Boolean;

begin
  pInfo := TNLDTRTTIInfo.Create(AObject);
  try
    for iAttr := 0 to AItem.GetAttributeCount() - 1 do begin
      sName     := AItem.GetAttributeName(iAttr);
      bHasProp  := pInfo.HasProperty(sName);
      bIsIndex  := ((AObject is TCollectionItem) and (sName = 'Index'));

      if (AStoreUndo) and ((bHasProp) or (bIsIndex)) then begin
        // Store property
        if bIsIndex then
          sValue  := AItem.GetAttributeValue(iAttr)
        else
          sValue  := pInfo.GetPropertyAsString(sName);

        XDOMSetAttribute(FUndoParent, sName, sValue);
      end;

      if (bHasProp) and (not bIsIndex) then begin
        // Apply property
        sValue  := AItem.GetAttributeValue(iAttr);
        pInfo.SetPropertyAsString(sName, sValue);
      end;
    end;
  finally
    FreeAndNil(pInfo);
  end;
end;


{******************* TCustomNLDTranslate
  Properties
****************************************}
procedure TCustomNLDTranslate.SetManager;
begin
  if FManager <> Value then begin
    if Assigned(FManager) then
      FManager.UnregisterEvent(Self);

    FManager := Value;

    if Assigned(FManager) then
      FManager.RegisterEvent(Self);
  end;
end;

procedure TCustomNLDTranslate.SetManagerInternal;
begin
  SetManager(Value);
end;

procedure TCustomNLDTranslate.SetSection;
begin
  if FSection <> Value then begin
    FSection := Value;
  end;
end;


{******************* TCustomNLDTranslate
  Events
****************************************}
procedure TCustomNLDTranslate.DoFileChange;
begin
  if Assigned(FOnFileChange) then
    FOnFileChange(Self);
end;

end.
