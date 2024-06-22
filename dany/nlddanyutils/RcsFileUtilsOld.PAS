unit RcsFileUtils;

// Dany Rosseel

{ History of this unit
  03-11-2002: * Initial version
  12-10-2003: * Adaptions made to meet coding conventions
  09-11-2003: * Small (non functional) text adaptations
              * Left out the usage of 'RcsStrings'
  11-01-2004: * Extended several procedures
                - with recursivity (actions in subdirs also)
                - to provide a full path (starting with 'C;\...'
                  or a relative path (with respect to the starting directory) in the filenames:
                Procedures adapted are: TFileList.MakeFileList
                                        FileNameExists
                                        GetFileNames
              * Removed the function 'ExtendedFileAttribute' from the interface section
  08-05-2004: * Made the 'GetfileNames' procedure also accept more paths (file names in a TStrings)
                to search for.
  16-05-2004: * Called "ProcessMessages" in "MakefileList" for every directory             
}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses SysUtils, Classes;

type  
  TAttributeCheck = (acStrict, acRelaxed);
  { FileAttribute checking method:
    acStrict  : all Wanted attributes must be ON, and NO others must be OFF
    acRelaxed : at least one of the Wanted attrs must be ON and all others
                are allowed ON or OFF (don't care) }
  { Attribute 'faAnyFile' is always assumed to be 'acRelaxed' }

  TIncludePath = (ipNone, ipRelative, ipFull);
  { Path included in the FileNames found:
      ipNone = no path information included, only the file name is returned
      ipRelative = the filename(s) include the path relative to the starting directory
      ipFull = the filename(s) include the full path (e.g. 'C:\aaa\bbb\ccc....')
  }

  FileListPointer = ^FileListItem;
  FileListItem =
    record
    Data: TSearchrec;
    Next: FileListPointer;
  end;

  TFileList =
    class(TObject)
    constructor Create;
    destructor Destroy; override;
    procedure MakeFileList(Fn: string; Attr: Byte; Check: TAttributeCheck; SubDirs: boolean = false; IncludePath: TIncludePath = ipNone);
    procedure AddToFileList(Rec: TSearchrec);
    function NumberOfEntries: Word;
    procedure GetEntry(Index: Word; var Rec: TSearchrec);
    procedure SortFileList;
  private
    Root: FileListPointer;
    Nr: LongWord; { number of entries }
  end;

{
TFileList.MakeFileList:
 This procedure builds a list of 'TSearchRec' members, with attributes defined in the
 parameters.

 TFileList.MakeFileList parameters:
 - 'Fn'          : the filename to be found, can contain wild cards
 - 'Attr'        : the file-attributes to be found
 - 'Check'       : relaxed or strict checking of the file attributes (see 'TAttributeCheck')
 - 'SubDirs'     : true = also go into subdirs
 - 'IncludePath' : the path included in the filenames (see type 'TIncludepath')
}

const
  faNormal = $40; { NOT ReadOnly, NOT Hidden, NOT SysFile,
  NOT VolumeID, NOT Directory,
  but : Archive = don't care }

function FileNameExists(Fn: string; Attr: Byte; Check: TAttributeCheck; SubDirs: boolean = false; IncludePath: TIncludePath = ipNone): Boolean;
// This function checks if file 'Fn' with attributes 'Attr' exists. If so (result = true),
// the name of the file found can be obtained with the function 'ExistingFileName'.
// All parameters have the same meaning as in 'TFileList.MakeFileList' (see above)

function ExistingFileName: string;
// see the comments on the function above

procedure GetFileNames(Fn: string; Attr: Byte; Check: TAttributeCheck;
  RemoveExtension: Boolean; List: TStrings; Subdirs: boolean = false; IncludePath: TIncludePath = ipNone); overload
// This procedure gets filenames in a TStrings object (like a Tmemo.Lines).
// If 'RemoveExtension' is set to 'True', the extensions are removed from the filenames
// All other parameters have the same meaning as in 'TFileList.MakeFileList' (see above)

procedure GetFileNames(FNames: Tstrings; Attr: Byte; Check: TAttributeCheck;
  RemoveExtension: Boolean; List: TStrings; Subdirs: boolean = false; IncludePath: TIncludePath = ipNone); overload
// This procedure is identical to the above one, but one can give more paths to search
// for in de TStrings variable 'FNames'

implementation

uses Forms;

var
  NameFound: string;

  
// the function below extends an existing file attribute with the value 'faNormal'

function ExtendedFileAttribute(Attr: Byte): Byte;
begin
  Attr := Attr and $7F;
  if (Attr and Lo(not faArchive) = 0) then
    Attr := Attr or faNormal; { this file is 'Normal'}
  Result := Attr;
end;


// the function below tests if fileattributes 'Wanted' and 'Actual' match
// taken into account strict or relaxed checking

function Match(Wanted, Actual: Byte; Check: TAttributeCheck): Boolean;
var
  Res: Boolean;
begin
  Res := False; {default}
  case Wanted of
    faAnyFile: Res := True; { Always (very) acRelaxed }
  else
    begin
      case Check of
        acStrict: Res := (Wanted = ExtendedFileAttribute(Actual));
        { acStrict checking }
        acRelaxed: Res := ((Wanted and ExtendedFileAttribute(Actual)) > 0);
        { acRelaxed checking }
      end; {case}
    end;
  end; {case}
  Result := Res and (Actual and faVolumeId = 0); { volume id is no file }
end;


// the function below returns True if the file with filename Fn exists and
// has the correct attibutes taking into account acStrict or acRelaxed
// Additionally, the function places the filename found into the "NameFound" variable

function FileNameExists(Fn: string; Attr: Byte; Check: TAttributeCheck; SubDirs: boolean = false; IncludePath: TIncludePath = ipNone): Boolean;
var
  RootDir : string;
  Found: Boolean;

  procedure DoIt;
  var dir : string;
      SRec, Rec: TSearchrec;
      Res, R: integer;
  begin
    Dir := '';
    if IncludePath <> ipNone then
    begin
      Dir := IncludeTrailingbackSlash(GetCurrentDir);
      if IncludePath <> ipFull
      then Dir := Stringreplace(Dir, RootDir, '', [rfIgnoreCase]);
    end;

    Res := FindFirst(Fn, faAnyFile, SRec);
    while (Res = 0) and (not Found) do
    begin
      if Match(Attr, SRec.Attr, Check) then
      begin
        Found := True;
        NameFound := Dir + Lowercase(SRec.Name);
      end;
      Res := FindNext(SRec);
    end;
    FindClose(SRec);

    if (not found) and SubDirs then   // continue in subdirectories
    begin
      R := FindFirst('*.*', faAnyFile, Rec);
      while (R = 0) and (not found) do
      begin
        if ((Rec.Attr and faDirectory) > 0) and
           (Rec.Name <> '.') and
           (Rec.Name <> '..') then
        begin
          chdir(Rec.Name);  // change to subdirectory
          DoIt;             // check if file exists in subdir
          chdir('..');      // change back to the current directory
        end;
        R := FindNext(Rec); // get next directory
      end;
      FindClose(Rec);
    end;
  end;

begin
  Found := False;
  NameFound := '';
  RootDir := IncludeTrailingbackSlash(GetCurrentDir);
  DoIt;
  Result := Found;
end;


// the function below returns the filename Found with the previous function

function ExistingFileName: string;
begin
  Result := NameFound;
end;



{ ***** routines to make and access a table of file entries ***** }

// the procedure below creates an empty filelist

constructor TFileList.Create;
begin
  inherited Create;
  Root := nil;
  Nr := 0;
end;


// the procedure below empties the filelist

procedure DisposeFileList(var P: FileListPointer);
begin
  if (P <> nil) then
  begin
    if P^.Next <> nil then
      DisposeFileList(P^.Next);
    Dispose(P);
    P := nil;
  end;
end;


// the procedure below destroys the filelist

destructor TFileList.Destroy;
begin
  DisposeFileList(Root);
  Nr := 0;
  inherited Destroy;
end;


// the procedure below recursively adds one record to the filelisttree at the end

procedure Add(var P: FileListPointer; Rec: TSearchrec);
begin
  if (P = nil) then // the end of the list is reached, add the record here
  begin
    New(P); // Create a new data field in the list
    P^.Data := Rec; // and put the record in it
    P^.Next := nil; // there is no 'next' record
  end
  else
    Add(P^.Next, Rec); // check further along the list for the end of it
end;


// the procedure below adds one record to the filelist

procedure TFileList.AddToFileList(Rec: TSearchrec);
begin
  Add(Root, Rec); // Add the record to the list
  Inc(Nr); // The number of records increments
end;


// the procedure below fill the filelist with all filenames matching the
// name, attribute and acStrict or acRelaxed

procedure TFileList.MakeFileList(Fn: string; Attr: Byte; Check: TAttributeCheck;
  SubDirs: boolean = false;
  IncludePath: TIncludePath = ipNone);
var RootDir : string;                        

  procedure AddFilesToList;
  var SRec: TSearchrec;
      Res: integer;
      Dir : string;
      R : Integer;
      Rec: TSearchrec;
  begin
    Application.ProcessMessages();

    Dir := '';
    if IncludePath <> ipNone then
    begin
      Dir := IncludeTrailingbackSlash(GetCurrentDir);
      if IncludePath <> ipFull
      then Dir := Stringreplace(Dir, RootDir, '', [rfIgnoreCase]);
    end;

    Res := FindFirst(Fn, faAnyFile, SRec);
    while (Res = 0) do
    begin
      if Match(Attr, SRec.Attr, Check) and
         (SRec.Name <> '.') and (SRec.Name <> '..')
         then
         begin
           SRec.Name := Dir + SRec.Name;
           AddToFileList(SRec);
         end;
      Res := FindNext(SRec);
    end;
    FindClose(SRec);

    if SubDirs then
    begin
      R := FindFirst('*.*', faAnyFile, Rec);
      
      while (R = 0) do
      begin
        if ((Rec.Attr and faDirectory) > 0) and
           (Rec.Name <> '.') and
           (Rec.Name <> '..') then
        begin
          chdir(Rec.Name);  // change to subdirectory
          AddFilesToList;   // add file names to the list
          chdir('..');      // change back to the current directory
        end;

        R := FindNext(Rec); // get next directory
      end;
      FindClose(Rec);
    end;

  end;

begin
  RootDir := IncludeTrailingBackslash(GetCurrentDir);

  DisposeFileList(Root); { clear the List }
  Nr := 0;               { Nr of entries = 0 }
  AddFilesToList;  // get filenames in the current directory

end;


// the function below returns the number of entries in the filelist

function TFileList.NumberOfEntries: Word;
begin
  Result := Nr;
end;


// the procedure below gets the item with index 'Index' from the filelist

procedure TFileList.GetEntry(Index: Word; var Rec: TSearchrec);
var
  W: Word;
  Tmp: FileListPointer;
begin
  if (Index >= 1) and
    (Index <= NumberOfEntries) then
  begin
    Tmp := Root; // Start with the beginning of the list
    for W := 2 to Index do
      Tmp := Tmp^.Next; // goto the 'Index'th entry
    Rec := Tmp^.Data;
  end
  else
  begin // Entry not found: return an empty one
    Rec.Name := '';
    Rec.Attr := 0;
    Rec.Size := 0;
    Rec.Time := 0;
  end;
end;


// the procedure below sorts the items in the filelist according name

procedure TFileList.SortFileList;
var
  P1, P2: FileListPointer;
  Name1, Name2: string;

  procedure ExchangeData; // exchange the records
  var
    Tmp: TSearchrec;
  begin
    Tmp := P1^.Data;
    P1^.Data := P2^.Data;
    P2^.Data := Tmp;
  end;

begin
  P1 := Root;
  while (P1 <> nil) do
  begin
    P2 := P1^.Next;
    while (P2 <> nil) do
    begin
      Name1 := ExtractFilename(P1^.Data.Name);
      Name2 := ExtractFilename(P2^.Data.Name);
      if (Name1 > Name2) then
        ExchangeData;
      P2 := P2^.Next;
    end;
    P1 := P1^.Next;
  end;
end;


// the procedure below puts all filenames into 'List' that match the filename
// the attributes and acStrict or acRelaxed

procedure GetFileNames(Fn: string; Attr: Byte; Check: TAttributeCheck;
  RemoveExtension: Boolean;
  List: TStrings;
  SubDirs: boolean = false;
  IncludePath: TIncludePath = ipNone);

  procedure MakeList;
  var FileList: TFileList;
      I: Word;
      SRec: TSearchRec;
      Name : string;
  begin
    FileList := TFileList.Create;
    FileList.MakeFileList(Fn, Attr, Check, SubDirs, IncludePath);   // Make a new filelist
    for I := 1 to FileList.NumberOfEntries do          // Do all entries in the list
    begin
      FileList.GetEntry(I, SRec); // Get the entry data
      Name := SRec.Name;
      if RemoveExtension then Name := ChangeFileExt(Name, '');
      List.Add(Name);
    end;
    FileList.free;
  end;

begin
  List.Clear;
  MakeList;
end;

procedure GetFileNames(FNames: Tstrings;
  Attr: Byte;
  Check: TAttributeCheck;
  RemoveExtension: Boolean;
  List: TStrings;
  Subdirs: boolean = false;
  IncludePath: TIncludePath = ipNone);
var Tmp: TStrings;
    I: Integer;
begin
  List.Clear;
  Tmp := TStringList.Create;
  try
    For I := 0 to FNames.Count - 1 do
    begin
      GetFileNames(FNames[I], Attr, Check, RemoveExtension, Tmp, Subdirs, IncludePath);
      List.AddStrings(Tmp);
    end;
  finally
    Tmp.Free;
  end;
end;

begin
  NameFound := '';
end.
