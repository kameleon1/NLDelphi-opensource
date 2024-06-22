unit RcsDirectories;

// Dany Rosseel


{ History of this unit:
  27-06-2004: * Initial version, with thanks to walterheck.
  27-02-2011: * Adapted for Delphi XE and Windows 7
}

(*
  MOST IMPORTANT:
  Most of the code in this unit comes from the NLD Forum "Tiphoek" by moderator walterheck:
  url= http://www.nldelphi.com/forum/showthread.php?postid=23162#post23162
*)

(*
On XE2 a new class was introduced to deal with this: TOSVersion.

    Read TOSVersion.Architecture to check for 32 or 64 bit OS.
    Read TOSVersion.Platform to check for Windows or Mac.
    Read TOSVersion.Major and TOSVersion.Minor for version numbers.
    Read TOSVersion.Name to obtain the basic product name, e.g. Windows 7.
    Read TOSVersion.ToString to obtain the full product name with version, e.g. Windows 7 Service Pack 1 (Version 6.1, Build 7601, 64-bit Edition).
	
For older versions of Delphi I recommend the following:

In order to check for 2000, XP, Vista, 7 I suggest you read Win32MajorVersion and Win32MinorVersion.

    major.minor = 5.0 => Windows 2000
    major.minor = 5.1 => Windows XP
    major.minor = 5.2 => Windows 2003 server or XP64
    major.minor = 6.0 => Windows Vista/2008 server
    major.minor = 6.1 => Windows 7/2008 server R2

The same information is available on MSDN, but the above came from my head!

If you are wanting very detailed product information then that takes a bit more work. Warren's answer gives one good route to obtaining that information. If you are wanting to test capability then version numbers are fine.

Use CheckWin32Version to check if the prevailing OS exceeds a certain version level. Although you should check that the function works correctly in your Delphi since the implementation of that function in Delphi 6 and earlier was incorrect.

To find out what the native OS architecture is (32 or 64 bit), use the GetNativeSystemInfo function. This function is not available on older operating systems so you should load it explicitly with GetProcAddress. Test for wProcessorArchitecture=PROCESSOR_ARCHITECTURE_AMD64 to check for 64 bit OS.	

*)

interface

uses
  Windows,
  ActiveX,
  ShlObj,
  SysUtils,
  ComObj;

function AppStartupDirectory(const IncludeBackSlash: boolean = true): string;
// Returns the directory in which the application started,
// with or without trailing backslash

function AppExeFileDirectory(const IncludeBackSlash: boolean = true): string;
// Returns the directory in which the application EXE file resides,
// with or without trailing backslash

function CurrentDirectory(const IncludeBackSlash: boolean = true): string;
// Returns the current directory, with or without trailing backslash

const
  RES_FAILED_NOT_SUPPORTED = $0001;
  RES_OK = $0002;
  RES_FAILED_UNKNOWN = $0003;
  RES_FAILED_PATH_RETRIEVE = $0004;

type
  TOSType = (osWin95, osWin98, osWinME, osWinNT4, osWin2K,
    osWinXP, osWin7, osUnknown, osUnknown9x, osUnknownNT);

  TLocationType = (

    // Desktop voor alle gebruikers (Alleen WinNT/2k/XP)
    locCommonDesktop,

    // Favorieten voor alle gebruikers (Alleen WinNT/2k/XP)
    locCommonFavorites,

    // "Start -> programma's" voor alle gebruikers (Alleen WinNT/2k/XP)
    locCommonPrograms,

    // Start" voor alle gebruikers (Alleen WinNT/2k/XP)
    locCommonStartmenu,

    // "Start -> programma's -> Opstarten" voor alle gebruikers (Alleen WinNT/2k/XP)
    locCommonStartup,

    // Desktop voor de huidige gebruiker
    locDesktop,

    // Favorieten voor de huidige gebruiker
    locFavorites,

    // "Mijn Documenten" voor de huidige gebruiker
    locPersonal,

    // "Start -> programma's" voor de huidige gebruiker
    locPrograms,

    // "kopieren naar" voor de huidige gebruiker
    locSendto,

    // "Start" voor de huidige gebruiker
    locStartmenu,

    // "Start -> programma's -> Opstarten" voor de huidige gebruiker
    locStartup,

    // Application data directory voor huidige gebruiker: Users\UserName\AppData\Roaming
    locAppData);

function GetOSVersion: TOSType;
function GetSpecialFolderPath(Location: TLocationType; StartMenuFolder: string = ''): string;

// *************************************************************************

implementation

var
  AppStartupDir: string;

function AppStartupDirectory(const IncludeBackSlash: boolean = true): string;
begin
  Result := AppStartupDir;
  if IncludeBackSlash
  then Result := IncludeTrailingBackslash(Result)
  else Result := ExcludeTrailingBackSlash(Result);
end;

function AppExeFileDirectory(const IncludeBackSlash: boolean = true): string;
begin
  Result := ExtractFilePath(ParamStr(0));
  if IncludeBackSlash
  then Result := IncludeTrailingBackslash(Result)
  else Result := ExcludeTrailingBackSlash(Result);
end;

function CurrentDirectory(const IncludeBackSlash: boolean = true): string;
begin
  Result := GetCurrentDir;
  if IncludeBackSlash
  then Result := IncludeTrailingBackslash(Result)
  else Result := ExcludeTrailingBackSlash(Result);
end;

const

  SHGFP_TYPE_CURRENT = 0; // current value for user, verify it exists
  SHGFP_TYPE_DEFAULT = 1; // default value, may not exist

//function SHGetFolderPath; external SHFolder name 'SHGetFolderPathA';
//function SHGetFolderLocation; external SHFolder Name 'SHGetFolderLocation';

function GetOSVersion: TOSType;
var
  RawInfo: TOSVersionInfo;
begin
  // haal de OS Versie Info op
  RawInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(RawInfo);

  // Indien er geen OS kan worden herkend
  Result := osUnknown;

  with RawInfo do
  begin
    // bekijke versie
    case RawInfo.dwMajorVersion of
      4: // Windows 95/98/ME/NT 4
        case RawInfo.dwMinorVersion of
          0: // Windows 95/NT 4
            case RawInfo.dwPlatformId of
              VER_PLATFORM_WIN32_NT: // Windows NT 4
                Result := osWinNT4;
              VER_PLATFORM_WIN32_WINDOWS: // Windows 95
                Result := osWin95;
            end;
          10: // Windows 98
            Result := osWin98;
          90: // Windows ME
            Result := osWinME;
        else // Onbekend
          Result := osUnknown9x;
        end;
      5: // Windows 2000/XP
        case RawInfo.dwMinorVersion of
          0: // Windows 2000
            Result := osWin2K;
          1: // Windows XP
            Result := osWinXP;
        else // Onbekend
          Result := osUnknownNT;
        end;
      6: // windows7
        case RawInfo.dwMinorVersion of
          1: Result := osWin7;
        else Result := osUnknown;
        end;

        // to be extended
    else
      Result := osUnknown;
    end;
  end;
end;

function GetSpecialFolderPath(Location: TLocationType; StartMenuFolder: string = ''): string;
var
  PrefixPath: String;  // is a widechar string
  PrefixPathA: Ansistring;
begin
  Result := '';

  SetLength(PrefixPath, MAX_PATH);
  FillChar(PrefixPath[1], MAX_PATH, 0);

  SetLength(PrefixPathA, MAX_PATH);
  FillChar(PrefixPathA[1], MAX_PATH, 0);

  case GetOSVersion of
    osWin95, osWin98, osWinNT4:
      begin
        case Location of
          locCommonDesktop: exit;
          locCommonFavorites: exit;
          locCommonPrograms: exit;
          locCommonStartmenu: exit;
          locCommonStartup: exit;

          locDesktop:
            begin
              if SHGetSpecialFolderPath(0, PChar(PrefixPath),
                CSIDL_DESKTOPDIRECTORY, False)
              then SetLength(PrefixPath, StrLen(PChar(PrefixPath)))
              else exit;
            end;

          locFavorites:
            begin
              if SHGetSpecialFolderPath(0, PChar(PrefixPath), CSIDL_FAVORITES,
                False)
              then SetLength(PrefixPath, StrLen(PChar(PrefixPath)))
              else exit;
            end;

          locPersonal:
            begin
              if SHGetSpecialFolderPath(0, PChar(PrefixPath), CSIDL_PERSONAL,
                False)
              then SetLength(PrefixPath, StrLen(PChar(PrefixPath)))
              else exit;
            end;

          locAppData:
            begin
              if SHGetSpecialFolderPath(0, PChar(PrefixPath), CSIDL_APPDATA,
                False)
              then SetLength(PrefixPath, StrLen(PChar(PrefixPath)))
              else exit;
            end;

          locPrograms:
            begin
              if SHGetSpecialFolderPath(0, PChar(PrefixPath), CSIDL_PROGRAMS,
                False) then
              begin
                SetLength(PrefixPath, StrLen(PChar(PrefixPath)));
                PrefixPath := PrefixPath + StartMenuFolder;
                if not DirectoryExists(PrefixPath) then
                    CreateDir(PrefixPath);
              end
              else exit;
            end;

          locSendto:
            begin
              if SHGetSpecialFolderPath(0, PChar(PrefixPath), CSIDL_SENDTO,
                False)
              then SetLength(PrefixPath, StrLen(PChar(PrefixPath)))
              else exit;
            end;

          locStartmenu:
            begin
              if SHGetSpecialFolderPath(0, PChar(PrefixPath), CSIDL_STARTMENU,
                False) then
              begin
                SetLength(PrefixPath, StrLen(PChar(PrefixPath)));
                PrefixPath := PrefixPath + StartMenuFolder;
                if not DirectoryExists(PrefixPath) then
                    CreateDir(PrefixPath);
              end
              else exit;
            end;

          locStartup:
            begin
              if SHGetSpecialFolderPath(0, PChar(PrefixPath), CSIDL_STARTUP,
                False)
              then SetLength(PrefixPath, StrLen(PChar(PrefixPath)))
              else exit;
            end;
        end;
      end;

    //osWinME, osWin2K, osWinXP, osWin7:
    else
      begin
        case Location of

          locCommonDesktop:
            begin
              if SHGetFolderPathA(0, CSIDL_COMMON_DESKTOPDIRECTORY, 0,
                SHGFP_TYPE_CURRENT, PAnsiChar(PrefixPathA)) = S_OK
              then SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)))
              else exit;
            end;

          locCommonFavorites:
            begin
              if SHGetFolderPathA(0, CSIDL_COMMON_FAVORITES, 0,
                SHGFP_TYPE_CURRENT, PAnsiChar(PrefixPathA)) = S_OK
              then SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)))
              else exit;
            end;

          locCommonPrograms:
            begin
              if SHGetFolderPathA(0, CSIDL_COMMON_PROGRAMS, 0,
                SHGFP_TYPE_CURRENT, PAnsiChar(PrefixPathA)) = S_OK then
              begin
                SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)));
                PrefixPathA := ansistring(string(PrefixPathA) + StartMenuFolder);
                if not DirectoryExists(string(PrefixPathA)) then
                    CreateDir(string(PrefixPathA));
              end
              else exit;
            end;

          locCommonStartmenu:
            begin
              if SHGetFolderPathA(0, CSIDL_COMMON_STARTMENU, 0,
                SHGFP_TYPE_CURRENT, PAnsiChar(PrefixPathA)) = S_OK then
              begin
                SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)));
                PrefixPathA := ansistring(string(PrefixPathA) + StartMenuFolder);
                if not DirectoryExists(string(PrefixPathA)) then
                    CreateDir(string(PrefixPathA));
              end
              else exit;
            end;

          locCommonStartup:
            begin
              if SHGetFolderPathA(0, CSIDL_COMMON_STARTUP, 0, SHGFP_TYPE_CURRENT,
                PAnsiChar(PrefixPathA)) = S_OK
              then SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)))
              else exit;
            end;

          locDesktop:
            begin
              if SHGetFolderPathA(0, CSIDL_DESKTOPDIRECTORY, 0,
                SHGFP_TYPE_CURRENT, PAnsiChar(PrefixPathA)) = S_OK
              then SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)))
              else exit;
            end;

          locFavorites:
            begin
              if SHGetFolderPathA(0, CSIDL_FAVORITES, 0, SHGFP_TYPE_CURRENT,
                PAnsiChar(PrefixPathA)) = S_OK
              then SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)))
              else exit;
            end;

          locPersonal:
            begin
              if SHGetFolderPathA(0, CSIDL_PERSONAL, 0, SHGFP_TYPE_CURRENT,
                PAnsiChar(PrefixPathA)) = S_OK
              then SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)))
              else exit;
            end;

          locAppData:
            begin
              if SHGetFolderPathA(0, CSIDL_APPDATA, 0, SHGFP_TYPE_CURRENT,
                PAnsiChar(PrefixPathA)) = S_OK
              then SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)))
              else exit;
            end;

          locPrograms:
            begin
              if SHGetFolderPathA(0, CSIDL_PROGRAMS, 0, SHGFP_TYPE_CURRENT,
                PAnsiChar(PrefixPathA)) = S_OK then
              begin
                SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)));
                PrefixPathA := ansistring(string(PrefixPathA) + StartMenuFolder);
                if not DirectoryExists(string(PrefixPathA)) then
                    CreateDir(string(PrefixPathA));
              end
              else exit;
            end;

          locSendto:
            begin
              if SHGetFolderPathA(0, CSIDL_SENDTO, 0, SHGFP_TYPE_CURRENT,
                PAnsiChar(PrefixPathA)) = S_OK
              then SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)))
              else exit;
            end;

          locStartmenu:
            begin
              if SHGetFolderPathA(0, CSIDL_STARTMENU, 0, SHGFP_TYPE_CURRENT,
                PAnsiChar(PrefixPathA)) = S_OK then
              begin
                SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)));
                PrefixPathA := ansistring(string(PrefixPathA) + StartMenuFolder);
                if not DirectoryExists(string(PrefixPathA)) then
                    CreateDir(string(PrefixPathA));
              end
              else exit;
            end;

          locStartup:
            begin
              if SHGetFolderPathA(0, CSIDL_STARTUP, 0, SHGFP_TYPE_CURRENT,
                PAnsiChar(PrefixPathA)) = S_OK
              then SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)))
              else exit;
            end;
        end;
      end;
  end;
  SetLength(PrefixPath, StrLen(PChar(PrefixPath)));
  SetLength(PrefixPathA, StrLen(PAnsiChar(PrefixPathA)));

  case GetOSVersion of
    osWin95, osWin98, osWinNT4: Result := PrefixPath;
    else Result := string(PrefixPathA);
  end;
end;

begin
  AppStartupDir := GetCurrentDir;
end.
