{-------------------------------------------------------------------------------
  routines om collection-sourcecode te schrijven
-------------------------------------------------------------------------------}
unit NLDTXCreateCollection;

interface

uses
  Windows, Classes, Controls, Graphics, Dialogs, SysUtils, ToolsApi;

type
  TCollectionCreateMode = (
    ccmNone,
    ccmInterface,
    ccmImplementation
  );

const
  CrLf = Chr(13) + Chr(10);

  // sjabloon-strings voor collectionitem en collection
  SCollectionInterface =
    CrLf +
    'type ' + CrLf +
    '  T_MyItem_ = class(TCollectionItem) ' + CrLf +
    '  private ' + CrLf +
    '  protected ' + CrLf +
    '  public ' + CrLf +
    '  published ' + CrLf +
    '  end; ' + CrLf +
    '  ' + CrLf +
    '  T_MyItem_Collection = class(TOwnedCollection) ' + CrLf +
    '  private ' + CrLf +
    '    function GetItem(Index: Integer): T_MyItem_; ' + CrLf +
    '    procedure SetItem(Index: Integer; const Value: T_MyItem_); ' + CrLf +
    '  protected ' + CrLf +
    '  public ' + CrLf +
    '    constructor Create(aOwner: TPersistent); ' + CrLf +
    '    function Add: T_MyItem_; ' + CrLf +
    '    function Insert(Index: Integer): T_MyItem_; ' + CrLf +
    '    property Items[Index: Integer]: T_MyItem_ read GetItem write SetItem; default; ' + CrLf +
    '  published ' + CrLf +
    '  end; ' + CrLf;

  SCollectionImplementation =
    CrLf +
    '{ T_MyItem_Collection } ' + CrLf +
    '' + CrLf +
    'function T_MyItem_Collection.Add: T_MyItem_; ' + CrLf +
    'begin ' + CrLf +
    '  Result := T_MyItem_(inherited Add); ' + CrLf +
    'end; ' + CrLf +
    '' + CrLf +
    'constructor T_MyItem_Collection.Create(aOwner: TPersistent); ' + CrLf +
    'begin ' + CrLf +
    '  inherited Create(aOwner, T_MyItem_); ' + CrLf +
    'end; ' + CrLf +
    '' + CrLf +
    'function T_MyItem_Collection.GetItem(Index: Integer): T_MyItem_; ' + CrLf +
    'begin ' + CrLf +
    '  Result := T_MyItem_(inherited GetItem(Index)) ' + CrLf +
    'end; ' + CrLf +
    '' + CrLf +
    'function T_MyItem_Collection.Insert(Index: Integer): T_MyItem_; ' + CrLf +
    'begin ' + CrLf +
    '  Result := T_MyItem_(inherited Insert(Index)) ' + CrLf +
    'end; ' + CrLf +
    '' + CrLf +
    'procedure T_MyItem_Collection.SetItem(Index: Integer; const Value: T_MyItem_); ' + CrLf +
    'begin ' + CrLf +
    '  inherited SetItem(Index, Value); ' + CrLf +
    'end; ' + CrLf;

procedure InsertCode(const aCollectionItemName: string; aMode: TCollectionCreateMode);

implementation

// retourneer borland editor
function BorEditorServices: IOTAEditorServices;
begin
  Result := BorlandIDEServices as IOTAEditorServices;
end;

// string naar tempfile
procedure StringToFile(const aString, aFileName: string);
var
  L: TStringList;
begin
  L := TStringList.Create;
  try
    L.Add(aString);
    L.SaveToFile(aFileName);
  finally
    L.Free;
  end;
end;

procedure InsertStringIntoEditor(const S: string);
var
  EditorServices: IOTAEditorServices;
  CurrentView: IOTAEditView;
  SourceEditor: IOTASourceEditor;
  OldCol, OldRow, EOL: Integer;
  aFileName: string;
begin

  // is er een editor service?
  EditorServices := BorEditorServices;
  if EditorServices = nil then
  begin
    ShowMessage('Kan Borland Editor Service niet vinden');
    Exit;
  end;

  // is er een actieve editor?
  CurrentView := EditorServices.TopView;
  if CurrentView = nil then
  begin
    ShowMessage('Geen actieve editor aanwezig');
    Exit;
  end;

  // save string naar tempfile
  aFileName := GetCurrentDir + '$$$CWZD.TMP';
  StringToFile(S, aFileName);

  // insert tempfile in editor
  with CurrentView.Position do
  begin
    MoveBOL;
    InsertFile(aFileName);
  end;

  // repaint editor
  CurrentView.Paint;

  // delete temp file
  DeleteFile(aFileName);
end;

procedure InsertCode(const aCollectionItemName: string; aMode: TCollectionCreateMode);
var
  S: string;
  aName: string;
begin
  if aCollectionItemName = '' then
    Exit;

  // "T" ervoor als niet aanwezig
  aName := aCollectionItemName;
  if aName[1] <> 'T' then
    aName := 'T' + aName;
  // netjes
  if Length(aName) > 1 then
    aName[2] := UpCase(aName[2]);

  // maak string
  case aMode of
    ccmInterface:
      S := StringReplace(SCollectionInterface, 'T_MyItem_', aName, [rfReplaceAll, rfIgnoreCase]);
    ccmImplementation:
      S := StringReplace(SCollectionImplementation, 'T_MyItem_', aName, [rfReplaceAll, rfIgnoreCase]);
  end;

  // en schrijf naar editor
  InsertStringIntoEditor(S);
end;


end.






