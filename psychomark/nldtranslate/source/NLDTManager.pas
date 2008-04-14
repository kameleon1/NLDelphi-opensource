unit NLDTManager;

{
  :: The NLDTranslate Manager provides the management of language files
  :: and distribution among the translators.

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

{TODO Automatically list language files at startup if appropriate}
{TODO Provide events for adding/removing of items in the Files collection}

interface
uses
  SysUtils,
  Classes,
  XDOM_2_3,
  NLDTInterfaces,
  NLDTGlobal;

type
  {
    :$ Holds a single language file.

    :: TNLDTFile is used by TNLDTFiles. It holds the filename and parsed
    :: description of the language.
  }
  TNLDTFile           = class(TCollectionItem)
  private
    FDescription:     String;
    FFilename:        String;
  protected
    procedure SetFilename(const Value: String); virtual;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Description: String  read FDescription;
    property Filename:    String  read FFilename      write SetFilename;
  end;

  {
    :$ Holds a collection of language files.

    :: TNLDTFiles holds a collection of language files which are loaded
    :: by the manager. There is generally no need to use TNLDTFiles directly,
    :: it is used internally by the manager.
  }
  TNLDTFiles          = class(TCollection)
  private
    function GetItem(Index: Integer): TNLDTFile;
    procedure SetItem(Index: Integer; const Value: TNLDTFile);
  public
    constructor Create();

    //:$ Adds a new language file
    //:: Add returns a new TNLDTFile instance.
    function Add(const AFilename: String): TNLDTFile;

    //:$ Inserts a new language file
    //:: Inserts a new TNLDTFile instance at the specified position and
    //:: returns the newly created instance.
    function Insert(Index: Integer): TNLDTFile;

    //:$ Find a file
    //:: FindFile searches for a TNLDTFile item using the specified
    //:: filename. Returns nil if no item was found. The search is performed
    //:: case-insensitive.
    function Find(const AFilename: String): TNLDTFile;

    //:$ Find a file by it's description
    //:: FindByDesc searches for a TNLDTFile item using the specified
    //:: description. Returns nil if no item was found. The search is performed
    //:: case-insensitive.
    function FindByDesc(const ADescription: String): TNLDTFile;

    //:$ Provides indexed access to the files in the collection.
    //:: Use the Items property to get indexed access to all the files
    //:: in the collection. Index is a value between 0 and Count - 1.
    property Items[Index: Integer]: TNLDTFile read GetItem
                                              write SetItem; default;
  end;


  TNLDTManagerStates  = (msLoading);
  TNLDTManagerState   = set of TNLDTManagerStates;

  {
    :$ Manages the available languages.

    :: TNLDTManager is the core component for listing and loading language
    :: files. It is responsible for passing this information to all connected
    :: sources, such as TNLDTranslate.
  }
  TCustomNLDTManager  = class(TNLDTBaseComponent, INLDTInterface,
                              INLDTEventSink, INLDTManager)
  private
    FEvents:        TInterfaceList;
    FFiles:         TNLDTFiles;
    FActiveFile:    TNLDTFile;

    FState:         TNLDTManagerState;

    FAutoUndo:      Boolean;
    FFilter:        String;
    FPath:          String;
  protected
    procedure SetActiveFile(const Value: TNLDTFile); virtual;
    procedure SetFiles(const Value: TNLDTFiles); virtual;
    procedure SetFilter(const Value: String); virtual;
    procedure SetPath(const Value: String); virtual;

    procedure Changed(); virtual;
    procedure ProcessSection(const ANode: TDomElement;
                             const AInterested: TInterfaceList); virtual;

    function IsRuntime(): Boolean; virtual;

    procedure Loaded(); override;

    // INLDTManager implementation
    procedure AddFile(const AFilename: String); virtual; stdcall;
    procedure RemoveFile(const AFilename: String); virtual; stdcall;
    procedure ClearFiles(); virtual; stdcall;

    // Properties (only available to descendants)
    property Events:      TInterfaceList  read FEvents;

    // Properties (published in TNLDTManager)
    //:$ Determines whether changes should be automatically reverted
    //:: Set AutoUndo to True to revert any language changes when ActiveFile
    //:: is changed.
    property AutoUndo:  Boolean read FAutoUndo  write FAutoUndo;

    //:$ Determines the filter to use when searching for language files
    //:: Set Filter to a DOS-style file filter (for example: *.lng) to list
    //:: all files matching that filter.
    property Filter:    String  read FFilter    write SetFilter;

    //:$ Determines the path to use when searching for language files
    //:: Set Path to the path which contains the language files.
    property Path:      String  read FPath      write SetPath;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    //:$ Reverts all language changes
    //:: Undo reverts any changes made by the language file. Undo itself does
    //:: perform any modifications, instead it notifies each registered
    //:: INLDTranslate interface.
    procedure Undo();

    // INLDTManager implementation
    //:$ List language files in the specified path.
    //:: LoadFromPath lists all language files which match AFilter
    //:: and adds it to the Files property. AFilter follows standard
    //:: file mask rules, for example: '*.lng'.
    procedure LoadFromPath(const APath, AFilter: String;
                           const ASubDirs: Boolean = False); virtual; stdcall;

    // INLDTEventSink implementation
    //:$ Register an event interface
    //:: Registers an event object in the internal event table. TNLDTManager
    //:: will raise events for the following interfaces:
    //:: /n/n
    //:: - INLDTFileChangeEvent /n
    //:: - INLDTTreeWalkEvent /n
    procedure RegisterEvent(const AEvent: INLDTEvent); virtual; stdcall;

    //:$ Unregister an event interface
    //:: Unregisters a previously registered event object.
    //:: See also: RegisterEvent
    procedure UnregisterEvent(const AEvent: INLDTEvent); virtual; stdcall;

    // Public properties
    //:$ Determines the currently active language file
    //:: Set ActiveFile to an item from the Files collection to apply the
    //:: language file. If ActiveFile is set to nil and AutoUndo is set to
    //:: True, all changes will be reverted.
    property ActiveFile:  TNLDTFile   read FActiveFile  write SetActiveFile;

    //:$ Contains the available language files
    //:: Files contains a list of language files which were found either by
    //:: implicitly calling LoadFromPath, or explicitly setting the Filter
    //:: and Path properties.
    property Files:       TNLDTFiles  read FFiles       write SetFiles;
  end;

  TNLDTManager        = class(TCustomNLDTManager)
  published
    property AutoUndo;
    property Filter;
    property Path;
  end;


implementation
uses
  {$IFDEF NLDT_FASTSTRINGS}
  FastStrings,
  {$ENDIF}
  NLDTXDOMUtils;


{*************************************** TNLDTFile
  Assign
**************************************************}
procedure TNLDTFile.Assign(Source: TPersistent);
begin
  if Source is TNLDTFile then
    with TNLDTFile(Source) do begin
      Self.FDescription := Description;
      Self.FFilename    := Filename;
    end
  else
    inherited;
end;


{*************************************** TNLDTFile
  Load language file
**************************************************}
procedure TNLDTFile.SetFilename;
const
  CNodeBegin:   String  = '<language';
  CNodeEnd:     String  = '>';
  CDescBegin:   String  = 'description="';
  CDescEnd:     String  = '"';

var
  fTemp:      TextFile;
  sData:      String;
  sLine:      String;
  iStart:     Integer;
  iEnd:       Integer;
  bStart:     Boolean;

begin
  if FFilename <> Value then begin
    if not FileExists(Value) then
      raise ENLDTFileDoesNotExist.Create('''' + Value + ''' does not exist!');

    FFilename     := Value;
    FDescription  := '(unknown)';
    sData         := '';
    bStart        := False;

    // Get description from the file
    AssignFile(fTemp, FFilename);
    try
      Reset(fTemp);

      while not Eof(fTemp) do begin
        ReadLn(fTemp, sLine);
        sData := sData + ' ' + Trim(sLine);

        if Length(sLine) > 0 then begin
          if not bStart then begin
            // Check for starting tag
            {$IFDEF NLDT_FASTSTRINGS}
            iStart  := FastPos(sData, CNodeBegin, Length(sData),
                               Length(CNodeBegin), 1);
            {$ELSE}
            iStart  := AnsiPos(CNodeBegin, sData);
            {$ENDIF}

            if iStart > 0 then begin
              Delete(sData, 1, iStart + Length(CNodeBegin) - 1);
              bStart  := True;
            end;
          end;

          if bStart then begin
            // Check for ending tag
            {$IFDEF NLDT_FASTSTRINGS}
            iEnd    := FastPos(sData, CNodeEnd, Length(sData),
                               Length(CNodeEnd), 1);
            {$ELSE}
            iEnd    := AnsiPos(CNodeEnd, sData);
            {$ENDIF}

            if iEnd > 0 then begin
              SetLength(sData, iEnd - 1);

              // Find attribute start
              {$IFDEF NLDT_FASTSTRINGS}
              iStart  := FastPos(sData, CDescBegin, Length(sData),
                                 Length(CDescBegin), 1);
              {$ELSE}
              iStart  := AnsiPos(CDescBegin, sData);
              {$ENDIF}

              if iStart > 0 then begin
                Delete(sData, 1, iStart + Length(CDescBegin) - 1);

                // Find attribute end
                {$IFDEF NLDT_FASTSTRINGS}
                iEnd    := FastPos(sData, CDescEnd, Length(sData),
                                   Length(CDescEnd), 1);
                {$ELSE}
                iEnd    := AnsiPos(CDescEnd, sData);
                {$ENDIF}

                if iEnd > 0 then begin
                  SetLength(sData, iEnd - 1);
                  FDescription  := XDOMEntityToChar(sData);
                end;
              end;

              break;
            end;
          end;
        end;
      end;
    finally
      CloseFile(fTemp);
    end;
  end;
end;


{************************************** TNLDTFiles
  TCollectionItem implementation
**************************************************}
constructor TNLDTFiles.Create;
begin
  inherited Create(TNLDTFile);
end;


function TNLDTFiles.Find;
var
  iItem:      Integer;

begin
  Result  := nil;

  for iItem := Count - 1 downto 0 do
    if CompareText(Items[iItem].Filename, AFilename) = 0 then begin
      Result  := Items[iItem];
      exit;
    end;
end;

function TNLDTFiles.FindByDesc;
var
  iItem:      Integer;

begin
  Result  := nil;

  for iItem := Count - 1 downto 0 do
    if CompareText(Items[iItem].Description, ADescription) = 0 then begin
      Result  := Items[iItem];
      exit;
    end;
end;


function TNLDTFiles.Add;
begin
  Result          := TNLDTFile(inherited Add());
  Result.Filename := AFilename;
end;

function TNLDTFiles.Insert;
begin
  Result  := TNLDTFile(inherited Insert(Index));
end;


function TNLDTFiles.GetItem;
begin
  Result  := TNLDTFile(inherited GetItem(Index));
end;

procedure TNLDTFiles.SetItem;
begin
  inherited SetItem(Index, Value);
end;


{****************************** TCustomNLDTManager
  Con/destructor
**************************************************}
constructor TCustomNLDTManager.Create;
begin
  inherited;

  FEvents   := TInterfaceList.Create();
  FFiles    := TNLDTFiles.Create();

  FFilter   := '*.lng';
  FPath     := '{APPPATH}';
  FAutoUndo := True;
end;

destructor TCustomNLDTManager.Destroy;
var
  iEvent:       Integer;

begin
  // Notify each event interface
  for iEvent  := FEvents.Count - 1 downto 0 do
    (FEvents[iEvent] as INLDTEvent).Detach(Self);

  FreeAndNil(FEvents);
  FreeAndNil(FFiles);

  inherited;
end;

procedure TCustomNLDTManager.Loaded;
begin
  inherited;
  LoadFromPath(FPath, FFilter, False);
  Changed();
end;


function TCustomNLDTManager.IsRuntime;
begin
  Result  := (not (csLoading in ComponentState)) and
             (not (csDesigning in ComponentState));
end;


{****************************** TCustomNLDTManager
  INLDTManager implementation
**************************************************}
procedure TCustomNLDTManager.AddFile;
begin
  if FFiles.Find(AFilename) = nil then
    FFiles.Add(AFilename);
end;

procedure TCustomNLDTManager.RemoveFile;
var
  pFile:      TNLDTFile;

begin
  pFile := FFiles.Find(AFilename);

  if Assigned(pFile) then
    FFiles.Delete(pFile.Index);
end;

procedure TCustomNLDTManager.ClearFiles;
begin
  FFiles.Clear();
end;


procedure TCustomNLDTManager.LoadFromPath;
var
  sPath:      String;
  pFile:      TSearchRec;

begin
  if (Length(APath) = 0) or (Length(AFilter) = 0) then
    exit;

  // Prevent files from getting cleared when searching subdirectories
  if not (msLoading in FState) then
    FFiles.Clear();

  Include(FState, msLoading);
  sPath := NLDTReplacePathVars(APath);
  sPath := NLDTIncludeDelimiter(sPath);

  if DirectoryExists(sPath) then begin
    if FindFirst(sPath + AFilter, faAnyFile, pFile) = 0 then begin
      repeat
        // Filter out directories
        if (pFile.Attr and faDirectory) = 0 then
          FFiles.Add(sPath + pFile.Name);
      until FindNext(pFile) <> 0;

      FindClose(pFile);
    end;

    // List sub-directories if requested
    if ASubDirs then
      if FindFirst(sPath + '*.', faDirectory, pFile) = 0 then begin
        repeat
          // Filter out parent directories
          if (pFile.Name <> '.') and (pFile.Name <> '..') then
            LoadFromPath(sPath + pFile.Name, AFilter, ASubDirs);
        until FindNext(pFile) <> 0;

        FindClose(pFile);
      end;
  end;

  Exclude(FState, msLoading);
end;


procedure TCustomNLDTManager.RegisterEvent;
begin
  FEvents.Add(AEvent)
end;

procedure TCustomNLDTManager.UnregisterEvent;
var
  iIndex:     Integer;

begin
  iIndex  := FEvents.IndexOf(AEvent);

  if iIndex > -1 then
    FEvents.Delete(iIndex);
end;


{****************************** TCustomNLDTManager
  Undo
**************************************************}
procedure TCustomNLDTManager.Undo;
var
  iEvent:       Integer;
  ifTranslate:  INLDTranslate;

begin
  for iEvent  := 0 to FEvents.Count - 1 do
    if FEvents[iEvent].QueryInterface(IID_INLDTranslate, ifTranslate) = 0 then begin
      ifTranslate.Undo();
      ifTranslate := nil;
    end;
end;



{****************************** TCustomNLDTManager
  Load language file
**************************************************}
procedure TCustomNLDTManager.Changed;
var
  xmlDom:           TDomImplementation;
  xmlDoc:           TDomDocument;
  xmlParser:        TXmlToDomParser;
  xmlRoot:          TDomElement;
  xmlSection:       TDomElement;
  pInterested:      TInterfaceList;
  iEvent:           Integer;
  ifTreeWalk:       INLDTTreeWalkEvent;
  ifItem:           INLDTTreeItem;

begin
  // Make sure we're not in design time or loading (loading only happens
  // when the component is not dynamically created, in that case the Loaded
  // procedure will trigger this method again)
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then
    exit;

  // Make sure there is an active file and it exists
  if (not Assigned(FActiveFile)) or (not FileExists(FActiveFile.Filename)) then begin
    // Undo any changes
    if FAutoUndo then
      Undo();

    exit;
  end;

  xmlDom  := TDomImplementation.Create(nil);
  try
    xmlParser := TXmlToDomParser.Create(nil);
    try
      // Parse language file
      xmlParser.DOMImpl := xmlDom;
      xmlDoc            := xmlParser.fileToDom(FActiveFile.Filename);
      try
        // Undo any changes
        if FAutoUndo then
          Undo();
          
        xmlRoot := xmlDoc.documentElement;

        pInterested := TInterfaceList.Create();
        try
          // Search for 'sections'
          xmlSection  := xmlRoot.findFirstChildElement();
          while Assigned(xmlSection) do begin
            // Build list of interested translators
            pInterested.Clear();

            for iEvent  := 0 to FEvents.Count - 1 do
              if FEvents[iEvent].QueryInterface(IID_INLDTTreeWalkEvent, ifTreeWalk) = 0 then begin
                ifItem  := TNLDTTreeItem.Create(xmlSection);
                try
                  if ifTreeWalk.QuerySection(ifItem) then
                    pInterested.Add(ifTreeWalk);
                finally
                  ifItem  := nil;
                end;

                ifTreeWalk  := nil;
              end;

            // Start recursive looping trough sub-items
            ProcessSection(xmlSection, pInterested);

            xmlSection  := xmlSection.findNextSiblingElement();
          end;
        finally
          FreeAndNil(pInterested);
        end;
      finally
        xmlDom.freeDocument(xmlDoc);
      end;
    finally
      FreeAndNil(xmlParser);
    end;
  finally
    FreeAndNil(xmlDom);
  end;
end;

procedure TCustomNLDTManager.ProcessSection;
  procedure InternalProcessSection(const ANode: TDomElement;
                                   const AInterested: TInterfaceList;
                                   const AProcess: array of Boolean);
  var
    xmlNode:        TDomElement;
    iEvent:         Integer;
    ifItem:         INLDTTreeItem;
    bProcess:       array of Boolean;

  begin
    SetLength(bProcess, High(AProcess) + 1);
    for iEvent  := High(AProcess) downto 0 do
      bProcess[iEvent]  := AProcess[iEvent];

    xmlNode := ANode.findFirstChildElement();
    while Assigned(xmlNode) do begin
      ifItem  := TNLDTTreeItem.Create(xmlNode);
      try
        // Query interested interfaces
        for iEvent  := AInterested.Count - 1 downto 0 do
          if bProcess[iEvent] then
            bProcess[iEvent]  := INLDTTreeWalkEvent(AInterested[iEvent]).QueryTreeItem(ifItem);

        // Process sub-nodes
        InternalProcessSection(xmlNode, AInterested, bProcess);

        // Let interested interfaces know we're done with the node
        for iEvent  := AInterested.Count - 1 downto 0 do
          if bProcess[iEvent] then
            INLDTTreeWalkEvent(AInterested[iEvent]).EndTreeItem(ifItem);
      finally
        ifItem  := nil;
      end;

      xmlNode := xmlNode.findNextSiblingElement();
    end;
  end;

var
  bProcess:     array of Boolean;
  iProcess:     Integer;

begin
  SetLength(bProcess, AInterested.Count);
  for iProcess  := AInterested.Count - 1 downto 0 do
    bProcess[iProcess]  := True;
    
  InternalProcessSection(ANode, AInterested, bProcess);
end;


{****************************** TCustomNLDTManager
  Properties
**************************************************}
procedure TCustomNLDTManager.SetFiles;
begin
  if Value <> FFiles then
    FFiles.Assign(Value);
end;

procedure TCustomNLDTManager.SetFilter;
begin
  if Value <> FPath then begin
    FFilter := Value;

    if IsRuntime() then
      LoadFromPath(FPath, FFilter, False);
  end;
end;

procedure TCustomNLDTManager.SetPath;
begin
  if Value <> FPath then begin
    FPath := Value;

    if IsRuntime() then
      LoadFromPath(FPath, FFilter, False);
  end;
end;

procedure TCustomNLDTManager.SetActiveFile;
var
  iEvent:           Integer;
  ifFileChange:     INLDTFileChangeEvent;

begin
  if Value <> FActiveFile then begin
    FActiveFile := Value;

    // Notify events
    for iEvent  := 0 to FEvents.Count - 1 do
      if FEvents[iEvent].QueryInterface(IID_INLDTFileChangeEvent, ifFileChange) = 0 then begin
        ifFileChange.FileChanged(Self);
        ifFileChange  := nil;
      end;

    Changed();
  end;
end;

end.
