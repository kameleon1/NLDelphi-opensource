unit FmxUtils;

interface

uses SysUtils, WinTypes, WinProcs, Classes, Consts;

function Copy_File(const FileName, DestName: TFileName): boolean;
  { true = success }
function Move_File(const FileName, DestName: TFileName): boolean;
function Get_File_Size(const FileName: string): LongInt;
function File_Date_Time(const FileName: string): TDateTime;
function File_Has_Attr(const FileName: string; Attr: Word): Boolean;
function File_Execute(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;

implementation

uses Forms, ShellAPI;

function Copy_File(const FileName, DestName: TFileName): boolean;
var res: longbool;
    NewFile, OldFile: TFileStream;
begin

  res := CopyFileW(PChar(FileName), PChar(DestName), longBool(false));
  Copy_File := res; { true is successfull }

  (*
  Result := true;
  OldFile := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    NewFile := TFileStream.Create(DestName, fmCreate or fmShareDenyRead);
    try
      try
        NewFile.CopyFrom(OldFile, OldFile.Size);
      except
        Result := false;
      end;
    finally
      FreeAndNil(NewFile);
    end;
  finally
    FreeAndNil(OldFile);
  end;
  *)
end;

function Move_File(const FileName, DestName: TFileName): boolean;
var
  success: boolean;
begin
  success := RenameFile(Filename, DestName);
  if success then
  begin
    Move_File := true;
    exit;
  end
  else
    success := Copy_File(FileName, DestName);
  if success then
    SysUtils.DeleteFile(FileName);
  Move_File := success;
end;

function Get_File_Size(const FileName: string): LongInt;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
    Result := SearchRec.Size
  else
    Result := -1;
end;

function File_Date_Time(const FileName: string): System.TDateTime;
begin
  Result := FileDateToDateTime(FileAge(FileName));
end;

function File_Has_Attr(const FileName: string; Attr: Word): Boolean;
begin
  Result := (FileGetAttr(FileName) and Attr) = Attr;
end;

function File_Execute(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
var
  zFileName, zParams, zDir: array[0..79] of Char;
begin
  Result := ShellExecute(Application.MainForm.Handle, nil,
    StrPCopy(zFileName, FileName), StrPCopy(zParams, Params),
    StrPCopy(zDir, DefaultDir), ShowCmd);
end;

end.
