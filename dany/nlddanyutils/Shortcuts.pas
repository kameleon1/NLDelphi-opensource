unit Shortcuts;

// Dany Rosseel


{ History of this unit:
  30-05-2004: * Initial version, with thanks to walterheck.
  27-06-2004: * Moved the "GetSpecialFolderPath"and "GetOsVersion" to a new
                unit: "RcsDirectories"
  13-10-2018: * Added function 'GetShortcutPath'.
}


(*
  MOST IMPORTANT:
  - Most of the code in this unit comes from the NLD Forum "Tiphoek" by 
    moderator walterheck:
    url= http://www.nldelphi.com/forum/showthread.php?postid=23162#post23162
  - Ikzelf heb alleen de routine "RemoveShortCut" toegevoegd. 
*)

(*
    AANROEP
 procedure TForm1.Button1Click(Sender: TObject);
var
  SourceFileName: TFileName;
  Location: TLocationType;
  IconPath: string;
  IconIndex: Integer;
  ShortcutName: string;
  Arguments: string;
  Tooltip: string;
begin
  SourceFileName:='c:\windows\explorer.exe';
  Arguments:= 'c:';
  Location:=locDesktop;
  IconPath:=Application.ExeName;
  IconIndex:=0;
  Tooltip:='Dubbelklik het icoon om de applicatie te starten';
  ShortcutName:='Tiphoek - Create een shortcut';
  case CreateShortCut(SourceFileName, Location, IconPath, IconIndex, Tooltip, ShortcutName, Arguments) of
    RES_FAILED_NOT_SUPPORTED:
      ShowMessage('Geen support voor deze lokatie');
    RES_OK:
      ShowMessage('Geen problemen');
    RES_FAILED_UNKNOWN:
      ShowMessage('Onbekende fout tijdens het maken van de shortcut');
    RES_FAILED_PATH_RETRIEVE:
      ShowMessage('Fout bij het opzoeken van het pad voor de locatie');
  end;
end;
 *)

interface

uses Windows, SysUtils, RcsDirectories;

function CreateShortCut(SourceFileName: TFileName;
                        Location: TLocationType;
                        IconPath: string;
                        IconIndex: Integer;
                        Tooltip: string;
                        ShortcutName: string;
                        Arguments: string;
                        WorkingDirectory: string = '';
                        StartMenuFolder: string = ''): Integer;

function RemoveShortCut(Location: TLocationType;
                        ShortCutName: string;
                        StartMenuFolder: string = ''): Integer;

function GetShortcutPath(Location: TLocationType;
                         ShortcutName: String;
                         StartMenuFolder: string = ''): String;

//*************************************************************************

implementation

uses
  ActiveX,
  ShlObj,
  ComObj;
  
(*
procedure CreateLink(const PathObj, PathLink, Desc, Param: string);
var
  IObject: IUnknown;
  SLink: IShellLink;
  PFile: IPersistFile;
begin
  IObject:=CreateComObject(CLSID_ShellLink);
  SLink:=IObject as IShellLink;
  PFile:=IObject as IPersistFile;
  with SLink do
  begin
    SetArguments(PChar(Param));
    SetDescription(PChar(Desc));
    SetPath(PChar(PathObj));
  end;
  PFile.Save(PWChar(WideString(PathLink)), FALSE);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CreateLink('c:\windows\notepad.exe','c:\MyNotePad.lnk','','');
end;
*)  

function CreateShortCut(SourceFileName: TFileName;
                        Location: TLocationType;
                        IconPath: string;
                        IconIndex: Integer;
                        Tooltip: string;
                        ShortcutName: string;
                        Arguments: string;
                        WorkingDirectory: string = '';
                        StartMenuFolder: string = ''): Integer;
var
  PrefixPath: string;
  MyObject: IUnknown;
  MySLink: IShellLink;
  MyPFile: IPersistFile;
  WFileName: WideString;
begin

  PrefixPath := GetSpecialFolderPath(Location, StartMenuFolder);
  if PrefixPath = '' then
  begin
    Result := RES_FAILED_PATH_RETRIEVE;
    exit;
  end;

  // maak een shellink object aan...
  MyObject := CreateComObject(CLSID_ShellLink);
  MySLink  := MyObject as IShellLink;
  MyPFile  := MyObject as IPersistFile;

  // doe de juiste instellingen...
  MySLink.SetPath(PChar(SourceFileName));
  if trim(WorkingDirectory) = ''
  then MySLink.SetWorkingDirectory(PChar(ExtractFileDir(SourceFileName)))
  else MySLink.SetWorkingDirectory(PChar(WorkingDirectory));
  MySLink.SetIconLocation(PChar(IconPath),IconIndex);
  MySLink.SetDescription(PChar(Tooltip));
  MySLink.SetArguments(PChar(Arguments));

  //create de shortcut...
  WFileName := IncludeTrailingBackSlash(PrefixPath) + ShortcutName + '.lnk';
  MyPFile.Save(PWChar(WFileName), False);

  // alles ging goed!! ...
  Result := RES_OK;
end;

function RemoveShortCut(Location: TLocationType;
                        ShortCutName: string;
                        StartMenuFolder: string = ''): Integer;
var
  PrefixPath: string;
  WFileName: WideString;
begin

  PrefixPath := GetSpecialFolderPath(Location, StartMenuFolder);
  if PrefixPath = '' then
  begin
    Result := RES_FAILED_PATH_RETRIEVE;
    exit;
  end;

  //remove de shortcut...
  if PrefixPath <> '' then
  begin
    WFileName := PrefixPath + '\' + ShortcutName + '.lnk';
    if fileexists(WFileName) then deletefile(WFileName);
  end;

  // alles ging goed!! ...
  Result := RES_OK;
end;

function GetShortcutPath(Location: TLocationType;
                         ShortcutName: String;
                         StartMenuFolder: string = ''): String;
// dereferences the given link name to the file/folder name associated with the link
var
  PrefixPath: string;
  AObject: IUnknown;
  ASLink: IShellLink;
  APFile: IPersistFile;
  WFileName: WideString;
  PFD: TWin32FindData;

  Pth, Args: string;
begin

  Result := '';

  PrefixPath := GetSpecialFolderPath(Location, StartMenuFolder);
  if PrefixPath = '' then exit;

  // create a helper interface to dereference the link (because this is local it will
  // be freed automatically on exit)
  AObject := CreateComObject(CLSID_ShellLink);
  ASLink := AObject as IShellLink;
  APFile := AObject as IPersistFile;
  // convert to wide string

  WFileName := PrefixPath + '\' + ShortCutName + '.lnk';
  if not FileExists(WFileName) then exit;

  APFile.Load(PWideChar(WFileName), 0);

  SetLength(Pth, MAX_PATH);
  ASLink.GetPath(PChar(Pth), MAX_PATH, PFD, 0);
  SetLength(Pth, StrLen(PChar(Pth)));

  SetLength(Args, MAX_PATH);
  ASLink.GetArguments(PChar(Args), MAX_PATH);
  SetLength(Args, StrLen(PChar(Args)));

  Result := Pth + ' ' + Args;
end;

end.
