unit RcsFileUtils;

// Dany Rosseel

{ History of this unit:
  03-11-2002: * Initial version
  12-10-2003: * Adaptions made to meet coding conventions
  09-11-2003: * Small (non functional) text adaptations
              * Left out the usage of 'RcsStrings'
  11-01-2004: * Extended several procedures
                (TFileList.MakeFileList, FileNameExists, GetFileNames)
                - with recursivity (actions in subdirs also)
                - to provide a full path (starting with 'C;\...') or a relative path
                  (with respect to the starting directory) in the filenames:
              * Removed the function 'ExtendedFileAttribute' from the interface section
  08-05-2004: * Made the 'GetfileNames' procedure also accept more paths
                (file names in a TStrings) to search for.
  16-05-2004: * Called "ProcessMessages" in "MakefileList" for every directory
  06-06-2004: * Used a "TList" as parent class now for the "TFileList" class
  19-06-2004: * Splitted up the file "attributes" in a "Kind" and a "Status"
                (Makes it more logical to define those attributes)
  14-07-2004: * Changed "FileNameExists": returns now the found filename.
                Uses also "MakeFileList" now in stead of copying that code.
              * The function "ExistingFileName" has been removed (see above).
              * "MakeFileList" accepts one more (defaulted to MaxInt) parameter: MaxNumber.
                The parameter indicates the maximum number of entries allowed in the list
              * Removed the "NumberOfEntries" function, use "Count" instead.
                Indexes still range from 1 to Count (as before)!!!!!
              * Added the "NoDebug" define (see above)
  18-07-2004: * An explicite "Chdir" before calling "MakeFileList", "GetFileNames"
                and "FileNameExists" is not needed any longer:
                the (root) directory can be added in the filename (parameter "Fn") now.
                So:
                  MakeFileList ('xxx\*.pas', ...   // new way
                is exactly the same as:
                  ChDir('xxx');                    // old way
                  MakeFileList('*.pas', ...
                The "old" way still works however.
  21-07-2004: * Added the function "DirectoryNameExists".
                It resolves wildcards in a directoryname.
                All other functions in this unit make use of it now,
                so the (root) directory can contain wildcards now.
  24-07-2004: * Added the function "ExpandToLongPathName", the opposite of
                "ExtractShortPathName".
  27-07-2004: * Made "MakeFileList" a little faster.
  29-07-2004: * The recursive search is made also in hidden en system directories again.
  06-02-2005: * Added "const" in a few function/procedure parameterlists
  10-02-2005: * Changed "TFileList.Create" to start with place for 1000 entries
  04-12-2005: * Added an overloaded procedure for "MakeFileList": the first
                parameter (the file to be found) is a "list" of files to be found
                (TStrings) here.
  14-12-2005: * Extended the overloaded version of "MakeFileList"and "GetFileNames"
                with parameter "Excluded" (TStrings). All filenames (and directorynames)
                in this list will be ignored.
  26-07-2006: * Added filekind "faAnyKind" and FileStatus "faAnyStatus"
  05-08-2007: * Added a "RootDir" parameter to most procedures and/or functions: is the "root" the
                action of the procedure/function starts in (e.g. "GetFileNames").
                If "RootDir" is not defined it is derived from eg the filename
                to find, and if that fails it is set to the current directory.
  11-02-2023: * Removed "acRelaxed" and "acStrict" and replaced it by "AttrNotAllowed".
                Changed "Attr" to "AttrMustHave".
}

(*
  The "Includepath" parameter defines what format the filenames found have:
  -  ipNone     = no path information included, only the file name is returned
  -  ipRelative = the filename(s) include the path relative to the starting directory
  -  ipFull     = the filename(s) include the full path (e.g. 'C:\aaa\bbb\ccc....')
*)

(* The "Mode" the class TFileList is working in the separate functions work in has the following values:
  -  mdMask     = the normal file path/name mask is used (like in "*.pas" for pascal files)
  -  mdRegExp   = the regular expression mode is used (like in "\.pas$" for pascal files)
   The default is "mdMask"
*)

(* File Atttribute constants

faReadonly = $1
faHidden   = $2
faSysFile  = $4
faVolumeId  = $8
faDirectory = $10
faArchive   = $20
faNormal    = $80
faTemporary = $100
faSymlink   = $400
faCompressed = $800
faEncrypted  = $4000
faVirtual    = $10000
faAnyFile    = $1FF
*)

interface

uses SysUtils,
  Classes;

const AttrNotAllowedSpecial = 0; //faInvalid or faTemporary or faSymLink or faVirtual; // all others are allowed

type
  TIncludePath = (ipNone, ipRelative, ipFull);
  //TFileListMode = (mdMask, MdRegExp);

  TFileList =
    class(TList)
  private
    //TMode: TFileListMode;
    procedure DisposeFileList;
  public

    constructor Create;
    destructor Destroy; override;

    procedure MakeFileList(
      Fn: string;                                 // filename to find (rootdir is derived from it)
      AttrMustHave: Integer;                      // file attributes to find
      AttrNotAllowed: integer;                    // file attributes not allowed
      SubDirs: Boolean = false;                   // search in subdirs too
      IncludePath: TIncludePath = ipNone;         // include full path in the filenames found
      MaxNumber: Integer = MaxInt); overload;     // maximum number of entries in the list fo names found

    procedure MakeFileList(
      RootDir: string;                            // start directory
      Fn: string;                                 // filename to find
      AttrMustHave: Integer;                      // file attributes to find
      AttrNotAllowed: integer;                    // file attributes not allowed
      SubDirs: Boolean = false;                   // search in subdirs too
      IncludePath: TIncludePath = ipNone;         // include full path in the filenames found
      MaxNumber: Integer = MaxInt); overload;     // maximum number of entries in the list fo names found

    procedure MakeFileList(
      RootDir: string;                            // start directory
      FNames,                                     // list of filenames to find
      Excluded: Tstrings;                         // list of filenames to exclude
      AttrMustHave: Integer;                      // file attributes to find
      AttrNotAllowed: integer;                    // file attributes not allowed
      SubDirs: Boolean = false;                   // search in subdirs too
      IncludePath: TIncludePath = ipNone;         // include full path in the filenames found
      MaxNumber: Integer = MaxInt); overload;     // maximum number of entries in the list fo names found

    procedure AddToFileList(const Rec: TSearchrec);
    procedure GetEntry(const Index: Integer; var Rec: TSearchrec);
    procedure SortFileList;

    //property Mode: TFileListMode read TMode write TMode;
  end;

  {
  TFileList.MakeFileList:
   This procedure builds a list of 'TSearchRec' members, with attributes defined in the
   parameters. The "Attr" part of the TSearchRec members is extended with the extra
   attributes "faFile" and "faNormal".

   TFileList.MakeFileList parameters:
   - 'RootDir'     : The (top/root)directory the action starts in
                     if it is empty, an attempt is made to extract it from 'Fn',
                     if that fails then the current directory is used as RootDir
                     In functions/procedures where the parameter "RootDir" is not
                     present an attempt is made to derived from "Fn".
   - 'Fn'      (1) : The filename to be found, can contain wildcards
   - 'FNames'  (2) : a list of filenames to be found, can contain wildcards
   - 'Excluded'(2) : a list of filesnames (or directorynames) to exclude from the list
   - 'AttrMustHave : file attributes to find
   - 'AttrNotAllowed': file attributes not allowed
   - 'Check'       : Relaxed or strict checking of the file attributes (see the function 'Match')
   - 'SubDirs'     : True = also go into subdirs
   - 'IncludePath' : The path included in the filenames (see type 'TIncludepath')
   - 'MaxNumber'   : The maximum number of entries allowed in the list (default MaxInt)

      (1) and (2) are mutual exclusive
  }

{ FileNameExists
This function checks if file 'Fn' with attributes 'Attr' exists and returns its name.
If it does not exist, it returns ''.
All parameters have the same meaning as in 'TFileList.MakeFileList' (see above)
}
function FileNameExists(
  Fn: string;                                     // filename to check
  AttrMustHave: Integer;                          // file attributes to find
  AttrNotAllowed: integer;                        // file attributes not allowed
  SubDirs: Boolean = false;                       // search in subdirs too
  IncludePath: TIncludePath = ipNone              // include full path in the filenames found
  ): string;


{ GetFileNames
This procedure gets filenames in a TStrings object (like a TMemo.Lines).
The directory to start in is extracted from "Fn". If that fails then the
current directory is used as RootDir.
If 'RemoveExtension' is set to 'True', the extensions are removed from the filenames
All other parameters have the same meaning as in 'TFileList.MakeFileList' (see above)
}
procedure GetFileNames(
  Fn: string;                                     // filename to find (the rootdir is derived from it)
  AttrMustHave: Integer;                          // file attributes to find
  AttrNotAllowed: Integer;                        // file attributes not allowed
  RemoveExtension: Boolean;                       // the extention of the filenames found is to be removed in the list
  List: TStrings;                                 // the search results (found filenames)
  Subdirs: Boolean = false;                       // search in subdirs too
  IncludePath: TIncludePath = ipNone;             // include full path in the filenames found
  MaxNumber: Integer = MaxInt                     // maximum number of entries in the list fo names found
  ); overload;


{ GetFileNames
This procedure gets filenames in a TStrings object (like a TMemo.Lines).
The filename search action starts in "RootDir". If Rootdir is empty then an attempt
is made to extract RootDir from "Fn". If that fails then the
current directory is used as RootDir.
If 'RemoveExtension' is set to 'True', the extensions are removed from the filenames
All other parameters have the same meaning as in 'TFileList.MakeFileList' (see above)
}
procedure GetFileNames(
  RootDir: string;                                // start directory
  Fn: string;                                     // filename to find
  AttrMustHave: Integer;                          // file attributes to find
  AttrNotAllowed: integer;                        // file attributes not allowed
  RemoveExtension: Boolean;                       // the extention of the filenames found is to be removed in the List
  List: TStrings;                                 // the search results (found filenames)
  Subdirs: Boolean = false;                       // search in subdirs too
  IncludePath: TIncludePath = ipNone;             // include full path in the filenames found
  MaxNumber: Integer = MaxInt                     // maximum number of entries in the list fo names found
  ); overload;


{ GetFileNames
This procedure is identical to the above one, but one can give more paths to search
for in de TStrings variable 'FNames'.
Here if Rootdir is empty then the current directory is used as RootDir.
Additionally the files in "Excluded" are not in the filename list.
}
procedure GetFileNames(
  RootDir: string;                                // start directory
  FNames,                                         // list of filenames to find
  Excluded: Tstrings;                             // list of filenames to exclude
  AttrMustHave: Integer;                          // file attributes to find
  AttrNotAllowed: integer;                        // file attributes not allowed
  RemoveExtension: Boolean;                       // the extention of the filenames found is to be removed in the List
  List: TStrings;                                 // the search results (found filenames)
  Subdirs: Boolean = false;                       // search in subdirs too
  IncludePath: TIncludePath = ipNone;             // include full path in the filenames found
  MaxNumber: Integer = MaxInt                     // maximum number of entries in the list fo names found
  ); overload;


{ DirectoryNameExists
This function checks if "DirName" exists ("DirName" can contain wildcards in any
part of it) and returns its (with resolved wildcards) name (with or without trailing backslash).
If the directory "DirName" does not exist, the function returns an empty string.
}
function DirectoryNameExists(DirName: string; const IncludeBackSlash: Boolean =
  true): string;


{ ExpandToLongPathName
This functions returns the "long" pathname of "ShortPath", with or without trailing backslash.
See "ExtractShortPathName" (in SysUtils) for the opposite function.
}
function ExpandToLongPathName(ShortPath: string; const IncludeBackSlash: Boolean
  = true): string;



implementation

uses Forms,
  RcsStrings,
  ShellAPI,
  Masks;

{
the function below tests if fileattributes 'Wanted' and 'Actual' match
taken into account strict or relaxed checking
}

function Match(AttrActual, AttrMustHave, AttrNotAllowed: Integer): Boolean;
begin
  Result := true; // default

  if (AttrActual and AttrMustHave) <> AttrMustHave then
  begin
    Result := false; // not all "must have" attributes are there
    exit;
  end;

  if (AttrActual and AttrNotAllowed) > 0 then
  begin
    Result := false; // some "not allowed" attributes are there
    exit;
  end;
end;

function FileNameExists(Fn: string; AttrMustHave, AttrNotAllowed: Integer;
  SubDirs: Boolean = false; IncludePath: TIncludePath = ipNone): string;
var
  List: TFileList;
  Rec: TSearchRec;
begin
  Result := '';
  List := TFileList.Create;
  try
    List.MakeFileList('', Fn, AttrMustHave, AttrNotAllowed, Subdirs, IncludePath, 1);
    // only one file name to search for
    if List.Count > 0 then
    begin                                         // one filename found that matches the criteria
      List.GetEntry(1, Rec);
      Result := Rec.Name;
    end;
  finally
    List.Free;
  end;
end;

{ ***** routines to make and access a table of file entries ***** }

// the procedure below creates an empty filelist

constructor TFileList.Create;
begin
  inherited Create;
  Self.Capacity := 1000;
  //TMode := mdMask;
end;

// the procedure below frees the memory of all items pointed to in the list
// the result is an empty filelist again

procedure TFileList.DisposeFileList;
var
  I: Integer;
  P: ^TSearchrec;
begin
  for I := 0 to Count - 1 do
  begin
    P := Self[I];                                 // get the pointer out of the list
    Dispose(P);                                   // free memory of object pointed to
  end;
  Self.Clear;
end;

// the procedure below destroys the filelist

destructor TFileList.Destroy;
begin
  DisposeFileList;                                // dispose of all the memory pointed to by the pointers
  // and clear the list itself
  inherited Destroy;
end;

// the procedure below gets the item with index 'Index' from the filelist
// Index ranges from 1 to Count !!!!!!!!

procedure TFileList.GetEntry(const Index: Integer; var Rec: TSearchrec);
var
  Tmp: ^TSearchrec;
begin
  if (Index >= 1) and
    (Index <= Count) then
  begin
    Tmp := Self[Index - 1];
    Rec := Tmp^;
  end
  else
  begin                                           // Entry not found: return an empty one
    Rec.Name := '';
    Rec.Attr := 0;
    Rec.Size := 0;
    Rec.Time := 0;
  end;
end;

// the procedure below adds one record to the filelist

procedure TFileList.AddToFileList(const Rec: TSearchrec);
var
  P: ^TSearchrec;
begin
  New(P);                                         // create a new TSearchRec space, P points to it
  P^ := Rec;                                      // fill it with the contents of "Rec"
  Add(P);                                         // Add the pointer to the list
  Expand;
end;

// the procedure below fills the filelist with all filenames matching the
// name, attribute and acStrict or acRelaxed

procedure TFileList.MakeFileList(
  RootDir: string;                                // Start directory
  FNames,                                         // list of filenames to find
  Excluded: Tstrings;                             // list of filenames to exclude
  AttrMustHave: Integer;                          // file atrributes to find
  AttrNotAllowed: integer;                        // file attributes not allowed
  SubDirs: Boolean = false;                       // search also into subdirs
  IncludePath: TIncludePath = ipNone;             // include full path in the filename found
  MaxNumber: Integer = MaxInt);                   // maximum entries in the filename list allowed
var

  I: integer;

  function ToBeIgnored(Fn: string): boolean;
  var I: integer;
  begin
    Result := false;
    if Excluded <> nil then
    begin
      Fn := ExcludeTrailingBackSlash(Fn);
      for I := 0 to Excluded.Count - 1 do
      begin
        Result := MatchesMask(Fn, '*' + Excluded[I]);
        if Result then break;
      end;
    end;
  end;

  procedure AddFilesToList(Directory: string);
  var
    SRec: TSearchrec;
    Res: Integer;
    Dir: string;
    R: Integer;
    Rec: TSearchrec;
    I: Integer;
  begin
    Application.ProcessMessages();

    Directory := IncludeTrailingBackslash(Directory);

    Dir := '';
    if IncludePath <> ipNone then
    begin
      Dir := Directory;
      if IncludePath <> ipFull then
        Dir := Stringreplace(Dir, RootDir, '', [rfIgnoreCase]);
    end;

    for I := 0 to FNames.Count - 1 do
    begin
      Res := FindFirst(Directory + FNames[I], faAnyFile, SRec);
      while (Res = 0) and (Self.Count < MaxNumber) do
      begin
        if Match(SRec.Attr, AttrMustHave, AttrNotAllowed) and
          (SRec.Name <> '.') and (SRec.Name <> '..') then
        begin
          SRec.Name := Dir + SRec.Name;
          if not ToBeIgnored(SRec.Name) then
            AddToFileList(SRec);
        end;
        Res := FindNext(SRec);
      end;
      FindClose(SRec);
    end;

    if SubDirs and (Self.Count < MaxNumber) and
      (not ToBeIgnored(Directory)) then
      // Check for files in subdirectories also
    begin
      R := FindFirst(Directory + '*.*', faAnyFile, Rec);
      // find subdirectories (also the hidden ones and the system ones)
      while (R = 0) and (Self.Count < MaxNumber) do
      begin
        if ((Rec.Attr and faDirectory) > 0) and
          (Rec.Name <> '.') and
          (Rec.Name <> '..') then
          AddFilesToList(Directory + Rec.Name);   // add file names to the list
        R := FindNext(Rec);                       // get next subdirectory
      end;
      FindClose(Rec);
    end;

  end;

begin
  DisposeFileList;                                { clear the List }

  if (FNames <> nil) and (FNames.Count > 0) then
  begin

    if RootDir = ''
      then RootDir := IncludeTrailingBackslash(GetCurrentDir);
    RootDir := DirectoryNameExists(RootDir);      // resolve any wildcards
    if RootDir > '' then
      RootDir := IncludeTrailingBackslash(RootDir);

    if RootDir > '' then
    begin                                         // the rootdirectory exists
      for I := 0 to FNames.Count - 1 do
        FNames[I] := ExtractFileName(FNames[I]);
      // get filenames in the current directory
      // and in subdirectories if requested
      AddFilesToList(RootDir);
    end;

  end;
end;

procedure TFileList.MakeFileList(
  RootDir: string;
  Fn: string;                                     // filename to find
  AttrMustHave: Integer;
  AttrNotAllowed: integer;
  SubDirs: Boolean = false;
  IncludePath: TIncludePath = ipNone;
  MaxNumber: Integer = MaxInt);
var Names: TStrings;
begin
  if RootDir = '' then RootDir := ExtractFilePath(Fn);
  Names := TStringList.Create;
  try
    Names.Add(Fn);
    MakeFileList(RootDir, Names, nil, AttrMustHave, AttrNotAllowed, SubDirs, IncludePath, MaxNumber);
  finally
    Names.Free;
  end;
end;

procedure TFileList.MakeFileList(
  Fn: string;
  AttrMustHave: Integer;
  AttrNotAllowed: integer;
  SubDirs: Boolean = false;
  IncludePath: TIncludePath = ipNone;
  MaxNumber: Integer = MaxInt);
begin
  MakeFileList(
    '',
    Fn,
    AttrMustHave,
    AttrNotAllowed,
    SubDirs,
    IncludePath,
    MaxNumber);
end;

// the procedure below sorts the items in the filelist according name

function Compare(Item1, Item2: Pointer): Integer;
var
  R1, R2: TSearchrec;
begin
  R1 := TSearchRec(Item1^);
  R2 := TSearchRec(Item2^);
  if R1.Name > R2.Name then
    Result := 1
  else if R1.Name < R2.Name then
    Result := -1
  else
    Result := 0;
end;

procedure TFileList.SortFileList;
begin
  Sort(Compare);
end;

// the procedure below puts all filenames into 'List' that match the filename
// the attributes and acStrict or acRelaxed

procedure GetFileNames(
  RootDir: string;
  FNames,
  Excluded: Tstrings;
  AttrMustHave, AttrNotAllowed: Integer;
  RemoveExtension: Boolean;
  List: TStrings;
  SubDirs: Boolean = false;
  IncludePath: TIncludePath = ipNone;
  MaxNumber: Integer = MaxInt);

  procedure MakeList;
  var
    FileList: TFileList;
    I: Word;
    SRec: TSearchRec;
    Name: string;
  begin
    FileList := TFileList.Create;
    try
      // Make a new filelist
      FileList.MakeFileList(RootDir, FNames, Excluded, AttrMustHave, AttrNotAllowed, SubDirs, IncludePath, MaxNumber);
      for I := 1 to FileList.Count do             // Do all entries in the list
      begin
        FileList.GetEntry(I, SRec);               // Get the entry data
        Name := SRec.Name;
        if RemoveExtension then Name := ChangeFileExt(Name, '');
        List.Add(Name);
      end;
    finally
      FileList.free;
    end;
  end;

begin
  List.Clear;
  MakeList;
end;

procedure GetFileNames(
  RootDir: string;
  Fn: string;
  AttrMustHave, AttrNotAllowed: Integer;
  RemoveExtension: Boolean;
  List: TStrings;
  SubDirs: Boolean = false;
  IncludePath: TIncludePath = ipNone;
  MaxNumber: Integer = MaxInt);
var Names: TStrings;
begin
  if RootDir = '' then RootDir := ExtractFilePath(Fn);
  Names := TStringList.Create;
  try
    Names.Add(Fn);
    GetFileNames(RootDir, Names, nil, AttrMustHave, AttrNotAllowed, RemoveExtension, List, SubDirs, IncludePath, MaxNumber);
  finally
    Names.Free;
  end;
end;

procedure GetFileNames(Fn: string; AttrMustHave: Integer; AttrNotAllowed: Integer;
  RemoveExtension: Boolean; List: TStrings; Subdirs: Boolean = false;
  IncludePath: TIncludePath = ipNone; MaxNumber: Integer = MaxInt); overload;
begin
  GetFileNames(
    '',
    Fn,
    AttrMustHave,
    AttrNotAllowed,
    RemoveExtension,
    List,
    SubDirs,
    IncludePath,
    MaxNumber);
end;

function DirectoryNameExists(DirName: string; const IncludeBackSlash: Boolean =
  true): string;
var
  Tmp: TStrings;
  I, Res: Integer;
  SRec: TSearchRec;
begin
  DirName := Trim(DirName);
  if DirName = '' then DirName := '.';
  DirName := ExpandFileName(DirName);

  if DirectoryExists(DirName) then
  begin                                           // no wildcard resolution needed
    if IncludeBackSlash then
      Result := IncludeTrailingBackslash(DirName)
    else
      Result := ExcludeTrailingBackslash(DirName);
    Exit;
  end;

  Tmp := TStringList.Create;
  try
    StringToTStrings(DirName, Tmp, '\');
    TrimTStrings(Tmp, [trsTrim, trsEmptyLines]);

    if DirName[1] = '\' then Tmp[0] := '\' + Tmp[0];

    Result := '';
    for I := 0 to Tmp.Count - 1 do
    begin                                         // go along the path and check if every subdir exists
      // try to resolve any wildcards

      if DirectoryExists(Result + IncludeTrailingBackSlash(Tmp[I])) then
        Result := Result + IncludeTrailingBackSlash(Tmp[I])
      else

      begin                                       // search for the directory (and resolve wildcards)
        Res := FindFirst(Result + Tmp[I], faAnyfile, SRec);

        while (Res = 0) and
          ((Srec.Name = '.') or
          (SRec.Name = '..') or
          ((SRec.Attr and faDirectory) <> faDirectory)
          ) do
          Res := FindNext(SRec);

        if (Res = 0) then                         // directory name found
        begin
          Result := Result + IncludeTrailingBackSlash(SRec.Name); // actual name
          FindClose(SRec);
        end
        else
        begin
          FindClose(SRec);
          Result := '';                           // (part of the) directoryname does not exist
          Exit;
        end;
      end;
    end;
  finally
    Tmp.Free;
  end;
  if IncludeBackSlash then
    Result := IncludeTrailingBackslash(Result)
  else
    Result := ExcludeTrailingBackslash(Result);
end;

function ExpandToLongPathName(ShortPath: string; const IncludeBackSlash: Boolean
  = true): string;
var
  J: Integer;
  Info: _SHFILEINFOA;
  DisplayName: string;
  Tmp: TStrings;
begin
  Result := '';
  if ShortPath = '' then exit;
  ShortPath := ExpandFileName(ShortPath);

  Tmp := TStringList.Create;
  try
    StringToTStrings(ShortPath, Tmp, '\');
    TrimTStrings(Tmp, [trsTrim, trsEmptyLines]);

    {  <-----------------------------
    for J := 0 to Tmp.Count - 1 do
    begin
      if SHGetFileInfo(PChar(Result + Tmp[J]), 0, Info, SizeOf(Info),
        SHGFI_DISPLAYNAME) > 0 then
      begin                                       // SHGetFileInfo succeeded
        DisplayName := string(Info.szDisplayName);
        Result := Result + IncludeTrailingBackslash(DisplayName);
      end                                         // SHGetFileInfo failed
      else
        Result := Result + IncludeTrailingBackslash(Tmp[J]);
    end;
    }
  finally
    Tmp.Free;
  end;

  if IncludeBackSlash then
    Result := IncludeTrailingBackslash(Result)
  else
    Result := ExcludeTrailingBackslash(Result);
end;

end.
