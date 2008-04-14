unit NLDTGlobal;

{
  :: NLDTGlobals contains all of the global variables and functions. This unit
  :: may contain only generic functions which might be used by other units,
  :: specific functionality must be contained within the appropriate unit.

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

interface
uses
  SysUtils,
  Classes,
  XDOM_2_3,
  NLDTInterfaces;

type
  {
    :$ The specified file does not exist.

    :: ENLDTFileDoesNotExist is raised when the specified language file could
    :: not be found.
  }
  ENLDTFileDoesNotExist = class(Exception);

  {
    :$ The specified file is invalid.

    :: ENLDTInvalidLangFile is raised when the specified language file does
    :: not conform to the standard.
  }
  ENLDTInvalidLangFile  = class(Exception);


  {
    :$ Provides a base for NLDTranslate components

    :: NLDTBaseComponent descends from TComponent and implements the IUnknown
    :: interface. In this way it does the same thing for TComponent which
    :: TInterfacedObject does for TObject, except it implicitly adds a
    :: reference if an Owner is supplied. This prevents the component from
    :: being destroyed if it is placed on a form. If you do not want this
    :: behaviour, set AutoDestroy to False, this will prevent the component
    :: from being destroyed automatically.
  }
  TNLDTBaseComponent  = class(TComponent, IUnknown)
  private
    FAutoDestroy:       Boolean;
    FRefCount:          Integer;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(AOwner: TComponent); override;

    //:$ Determines if the component should be reference-counted
    //:: Set AutoDestroy to False to prevent the component from being destroyed
    //:: once the last reference is cleared.
    //:! Make sure to set AutoDestroy to False directly after creating the
    //:! component to make sure it will not be destroyed!
    property AutoDestroy:   Boolean read FAutoDestroy write FAutoDestroy;

    //:$ Returns the current reference count
    //:: RefCount provides access to the internal reference count. The
    //:: reference count is inherited from the IUnknown interface.
    property RefCount:      Integer read FRefCount;
  end;


  {
    :$ Implements the INLDTTreeItem interface

    :: TNLDTTreeItem provides a wrapper around an XML element found in
    :: the language file. It is primarily used to be passed to the
    :: translator interfaces.
  }
  TNLDTTreeItem       = class(TInterfacedObject, INLDTInterface,
                              INLDTTreeItem)
  private
    FNode:        TDomElement;
  public
    //:$ Initializes a new TNLDTTreeItem instance
    constructor Create(ANode: TDomElement);

    // INLDTTreeItem implementation
    //:$ Returns the name of the tree item
    function GetName(): String; stdcall;

    //:$ Returns the value of the tree item
    function GetValue(): String; stdcall;

    //:$ Returns the number of attributes for the tree item
    //:: Call GetAttributeCount to get the number of attributes available for
    //:: the tree item. You can use the GetAttribute method to get the
    //:: value for a specific attribute.
    function GetAttributeCount(): Integer; virtual; stdcall;

    //:$ Returns the name of the specified attribute
    //:: Use GetAttributeName to get the name of an attribute. The AIndex
    //:: must be between 0 and GetAttributeCount - 1 or an exception is raised.
    function GetAttributeName(const AIndex: Integer): String; virtual; stdcall;

    //:$ Returns the value of the specified attribute
    //:: Use GetAttributeValue to get the value of an attribute. The AIndex
    //:: must be between 0 and GetAttributeCount - 1 or an exception is raised.
    function GetAttributeValue(const AIndex: Integer): String; virtual; stdcall;

    //:$ Returns the value of the specified attribute
    //:: Use GetAttributeValueByName to get the value of an attribute. The AName
    //:: parameter represent the attribute's name. Returns an empty string if
    //:: the attribute is not found.
    function GetAttributeValueByName(const AName: String): String; virtual; stdcall;

    //:$ Gets or sets the Node associated with the tree item
    //:: Set Node to a valid TDomElement to allow the INLDTTreeItem interface
    //:: to be implemented.
    property Node:      TDomElement read FNode    write FNode;
  end;


  {
    :$ Includes a trailing path delimiter (slash or backslash)

    :: This function encapsulates the functions IncludeTrailingPathDelimiter
    :: and IncludeTrailingBackslash, depending on the compiler version. This
    :: eliminates the 'function is deprecated' warning.
  }
  function NLDTIncludeDelimiter(const ASource: String): String;

  {
    :$ Exclude a trailing path delimiter (slash or backslash)

    :: This function encapsulates the functions ExcludeTrailingPathDelimiter
    :: and ExcludeTrailingBackslash, depending on the compiler version. This
    :: eliminates the 'function is deprecated' warning.
  }
  function NLDTExcludeDelimiter(const ASource: String): String;

  {
    :$ Replace predefined variables

    :: Replaces predefined variables in path parameters. This function
    :: must be called by any NLDTranslate implementation using paths.
  }
  function NLDTReplacePathVars(const ASource: String): String;

implementation
uses
  {$IFDEF NLDT_FASTSTRINGS}
  FastStrings,
  {$ENDIF}
  NLDTXDOMUtils,
  Windows;

var
  GVar_AppPath:             String;


{******************** TNLDTBaseComponent
  Initialization
****************************************}
constructor TNLDTBaseComponent.Create;
begin
  inherited;

  FAutoDestroy  := True;
  if Assigned(AOwner) then
    _AddRef();
end;


{******************** TNLDTBaseComponent
  IUnknown implementation
****************************************}
function TNLDTBaseComponent._AddRef;
begin
  Result  := InterlockedIncrement(FRefCount);
end;

function TNLDTBaseComponent._Release;
begin
  Result  := InterlockedDecrement(FRefCount);

  if (Result = 0) and (not FAutoDestroy) then
    Destroy;
end;

function TNLDTBaseComponent.QueryInterface;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;



{*********************************** TNLDTTreeItem
  Constructor
**************************************************}
constructor TNLDTTreeItem.Create;
begin
  inherited Create();
  FNode := ANode;
end;


{*********************************** TNLDTTreeItem
  INLDTTreeItem implementation
**************************************************}
function TNLDTTreeItem.GetName;
begin
  Result  := '';
  if not Assigned(FNode) then exit;
  Result  := FNode.nodeName;
end;

function TNLDTTreeItem.GetValue;
begin
  Result  := '';
  if not Assigned(FNode) then exit;
  Result  := FNode.textContent;
end;


function TNLDTTreeItem.GetAttributeCount;
begin
  Result  := 0;
  if not Assigned(FNode) then exit;
  Result  := FNode.attributes.length;
end;

function TNLDTTreeItem.GetAttributeName;
var
  xmlAttr:      TDomNode;

begin
  Result  := '';
  if not Assigned(FNode) then exit;
  xmlAttr := FNode.attributes.item(AIndex);

  if Assigned(xmlAttr) then
    Result  := xmlAttr.nodeName;
end;

function TNLDTTreeItem.GetAttributeValue;
begin
  Result  := '';
  if not Assigned(FNode) then exit;
  Result  := XDOMGetAttributeByIndex(FNode, AIndex);
end;

function TNLDTTreeItem.GetAttributeValueByName;
begin
  Result  := '';
  if not Assigned(FNode) then exit;
  Result  := XDOMGetAttribute(FNode, AName);
end;


{****************************************
  Include trailing path delimiter
****************************************}
function NLDTIncludeDelimiter;
begin
  {$IFDEF NLDT_D6}
  Result  := IncludeTrailingPathDelimiter(ASource);
  {$ELSE}
  Result  := IncludeTrailingBackslash(ASource);
  {$ENDIF}
end;


{****************************************
  Exclude trailing path delimiter
****************************************}
function NLDTExcludeDelimiter;
begin
  {$IFDEF NLDT_D6}
  Result  := ExcludeTrailingPathDelimiter(ASource);
  {$ELSE}
  Result  := ExcludeTrailingBackslash(ASource);
  {$ENDIF}
end;


{****************************************
  Replace variables
****************************************}
function NLDTReplacePathVars;
  procedure InternalReplace(var ASource: String;
                            const AVarName, AVarValue: String);
  begin
    {$IFDEF NLDT_FASTSTRINGS}
    ASource := FastReplace(ASource, '{' + AVarName + '}', AVarValue, False);
    {$ELSE}
    ASource := StringReplace(ASource, '{' + AVarName + '}', AVarValue,
                             [rfReplaceAll, rfIgnoreCase]);
    {$ENDIF}
  end;

begin
  Result  := ASource;
  InternalReplace(Result, 'APPPATH', GVar_AppPath);
end;



initialization
  // Prepare variables
  GVar_AppPath  := NLDTExcludeDelimiter(ExtractFilePath(ParamStr(0)));

end.
