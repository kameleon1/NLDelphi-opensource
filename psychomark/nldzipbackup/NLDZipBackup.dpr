program NLDZipBackup;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

uses
  Windows,
  SysUtils,
  Classes,
  ZipForge,
  Contnrs;

type
  PFolderData = ^TFolderData;
  TFolderData = record
    Path:         String;
    Relative:     String;
  end;


procedure AddFolderToStack(const AStack: TStack; const APath, ARelative: String);
var
  pData:        PFolderData;

begin
  New(pData);
  pData^.Path     := APath;
  pData^.Relative := ARelative;
  AStack.Push(pData);
end;


procedure ArchiveFiles(const ADest: TZipForge; const ASource: String;
                       const ARelative: String = ''; const AUseArchive: Boolean = True;
                       const AChangeArchive: Boolean = True);
var
  stFolders:    TStack;
  pFile:        TSearchRec;
  pFolder:      PFolderData;
  fsSource:     TFileStream;

begin
  // The stack is used to store folder information. This enables us to use
  // a non-recursive loop to search trough the folder structure, thus preventing
  // any "Stack Overflow" messages in case of large folder structures.
  stFolders := TStack.Create();
  try
    AddFolderToStack(stFolders, ASource, ARelative);

    repeat
      pFolder := PFolderData(stFolders.Pop());

      WriteLn('=== .\', pFolder^.Path);
      if FindFirst(pFolder^.Path + '*.*', faAnyFile, pFile) = 0 then begin
        repeat
          if (pFile.Name <> '.') and (pFile.Name <> '..') then
            // Check for folder
            if (pFile.Attr and faDirectory) = faDirectory then
              AddFolderToStack(stFolders, pFolder^.Path + pFile.Name + '\',
                               pFolder^.Relative + pFile.Name + '\')
            else begin
              // Check for archive attribute (if necessary)
              if (AUseArchive) and ((pFile.Attr and faArchive) <> faArchive) then
                WriteLn('Skipping: ', pFile.Name)
              else begin
                WriteLn('Adding:   ', pFile.Name);

                if (AUseArchive) and (AChangeArchive) then
                  // Set attribute to archived
                  SetFileAttributes(PChar(pFolder^.Path + pFile.Name),
                                    pFile.Attr and not FILE_ATTRIBUTE_ARCHIVE);

                fsSource  := TFileStream.Create(pFolder^.Path + pFile.Name,
                                                fmOpenRead or fmShareDenyWrite);
                try
                  ADest.AddFromStream(pFolder^.Relative + pFile.Name, fsSource,
                                      fsSource.Position, fsSource.Size);
                finally
                  FreeAndNil(fsSource);
                end;
              end;
            end;
        until FindNext(pFile) <> 0;

        FindClose(pFile);
      end;

      Dispose(pFolder);
    until stFolders.Count = 0;
  finally
    FreeAndNil(stFolders);
  end;
end;


var
  sSource:      String;
  sDest:        String;
  dtNow:        TDateTime;
  zipDest:      TZipForge;
  bArchive:     Boolean;
  bChange:      Boolean;
  iCount:       Integer;

begin
  WriteLn('NLDZipBackup v0.2');
  WriteLn('   copyright (c) 2003 X'#253'Software');
  WriteLn;
  WriteLn('Powered by ZipForge. (C) AidAim Software, http://www.aidaim.com/');
  WriteLn;

  if ParamCount() < 2 then begin
    WriteLn('Usage:     NLDZipBbackup.exe [path] [dest] [options]');
    WriteLn('Example:   NLDZipBackup.exe C:\NeedsBackup\ C:\Backup-%D%M%Y.zip');
    WriteLn;
    WriteLn('Options:');
    WriteLn('     -noarchive        Ignore the Archive attribute and back up all files');
    WriteLn('     -nochange         Check the Archive attribute, but do not change it');
    exit;
  end;

  sSource   := ParamStr(1);
  sDest     := ParamStr(2);
  bArchive  := not FindCmdLineSwitch('noarchive');
  bChange   := not FindCmdLineSwitch('nochange');

  if not DirectoryExists(sSource) then begin
    WriteLn('Error:     the specified directory does not exist!');
    exit;
  end;

  sSource := IncludeTrailingPathDelimiter(sSource);
  dtNow   := Now();
  sDest   := StringReplace(sDest, '%d', FormatDateTime('d', dtNow), [rfReplaceAll]);
  sDest   := StringReplace(sDest, '%D', FormatDateTime('dd', dtNow), [rfReplaceAll]);
  sDest   := StringReplace(sDest, '%m', FormatDateTime('m', dtNow), [rfReplaceAll]);
  sDest   := StringReplace(sDest, '%M', FormatDateTime('mm', dtNow), [rfReplaceAll]);
  sDest   := StringReplace(sDest, '%y', FormatDateTime('yy', dtNow), [rfReplaceAll]);
  sDest   := StringReplace(sDest, '%Y', FormatDateTime('yyyy', dtNow), [rfReplaceAll]);

  if FileExists(sDest) then
    DeleteFile(sDest);

  WriteLn('Creating archive ''', sDest, '''');
  zipDest   := TZipForge.Create(nil);
  try
    zipDest.FileName              := sDest;
    zipDest.Options.StorePath     := spRelativePath;
    zipDest.Options.FlushBuffers  := False;

    if FileExists(sDest) then
      zipDest.OpenArchive(fmOpenReadWrite)
    else
      zipDest.OpenArchive(fmCreate);

    //zipDest.AddFiles(sSource + '*.*');
    // Normally, AddFiles would be easier... but since we need to do some
    // custom parsing, not much choice...
    ArchiveFiles(zipDest, sSource, '', bArchive, bChange);
    iCount  := zipDest.FileCount;

    if iCount = 0 then begin
      WriteLn('Archive is empty, removing...');
      DeleteFile(sDest);
    end;

    zipDest.CloseArchive();
  finally
    FreeAndNil(zipDest);
  end;
  WriteLn('Done!');
end.
