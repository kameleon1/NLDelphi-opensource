unit FileInMem;

// Dany Rosseel, 14-10-2003

{ History of this unit
  23-03-2002: Initial version
  14-10-2003: Adaptions made to meet coding conventions
}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

{ This unit provides a class that is capable of getting a file in memory
  (in member "Buffer") and writing memory contents ("Buffer") to that file.
}

interface

uses Windows, Classes;

type
  TFileBuff = array[0..100000000] of byte;
  PTFileBuff = ^TFileBuff;

  TFileInMemory =
    class
  public
    Buffer: PTFileBuff;
    constructor Create;
    procedure GetFileInMemory(Fn: string);
    procedure FlushFileInMemory;
    procedure RemoveFileFromMemory;
    function FileSize: longword;
  private
    hFile, hFilemapping: THandle;
  end;

implementation

constructor TFileInMemory.Create;
begin
  Buffer := nil;
  inherited Create;
end;

procedure TFileInMemory.GetFileInMemory(Fn: string);
var
  Res: PTFileBuff;
begin
  Res := nil;
  hFile := CreateFile(pchar(fn),
    GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_WRITE,
    nil,
    OPEN_EXISTING,
    0,
    0);
  if (hFile > 0) then
  begin
    hFilemapping := CreateFileMapping(hFile,
      nil,
      PAGE_READWRITE or SEC_COMMIT,
      0,
      0,
      nil);
    if (hFileMapping > 0) then
    begin
      Res := MapViewOfFile(hFileMapping,
        FILE_MAP_ALL_ACCESS,
        0,
        0,
        0);
      if (Res = nil) then
      begin
        CloseHandle(hFileMapping);
        CloseHandle(hFile);
      end;
    end
    else
    begin                               {hFileMapping = 0 }
      CloseHandle(hFile);
    end;
  end;

  Buffer := Res; // "Buffer" gets the address of the data in memory
end;

procedure TFileInMemory.FlushFileInMemory;
begin
  FlushViewOfFile(Buffer, 0);
end;

procedure TFileInMemory.RemoveFileFromMemory;
begin
  UnmapViewOfFile(Buffer);
  CloseHandle(hFileMapping);
  CloseHandle(hFile);
end;

function TFileInMemory.FileSize: longword;
begin
  Result := GetFileSize(hFile, nil);
end;

end.
