unit sharemem;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface uses sysutils,windows;

{

  This unit demonstrates how simple it is to share a block of memory
  between several Windows applications.

  The parameter "objectname" identifies the memory block. Please use
  a meaningful and not-too-short name for the thing!

  (please note! Backslashes aren't allowed in this name!
   It is NOT a "dos" name!)


  "size" identifies the size of the block.
  "memory" is the address of the block.




  If another application has already created the object, it should be
  possible to set this parameter to zero (I haven't tried this though, and
  I don't know what happens if the "size" parameter isn't identical in all
  applications  trying to access the block simultaneously....



  Written August 30,1996 by Arthur Hoornweg
  (hoornweg@hannover.sgh-net.de)

  Freeware!


 }

  TYPE ESharedMemoryError = class( exception );


  TYPE
  TSharedMemory = class
  private
    FMappingHandle :THandle;
    FMemory        :Pointer;
    Fsize          :Longint;
  public
    constructor Create(ObjectName  : PCHAR;       {no \ allowed....}
                       DesiredSize : Longint     {zero if existing}
                       );      {create if not existing}
    destructor  Destroy; override;
    property    Memory :Pointer read FMemory;
    Property    Size:Longint read fsize;
  end;


implementation


constructor TSharedMemory.Create(ObjectName  : PCHAR;       {no \ allowed....}
                                 DesiredSize : Longint);     {zero if existing}

begin
  FSize:=DesiredSize;

  FMappingHandle :=
     CreateFileMapping(
       $FFFFFFFF,        {no file-use Windows swap file}
       nil,
       page_readwrite,   {read and write access for all!}
       0,
       desiredsize,
       ObjectName);

  if ( FMappingHandle = 0 )
    then raise ESharedMemoryError.Create( 'TSharedmemory createfilemapping error' );

  FMemory := MapViewOfFile( FMappingHandle, FILE_MAP_write, 0, 0, 0 );
  if ( FMemory = Nil ) then raise ESharedMemoryError.Create('Tfilemapping map view error' );
end;


destructor TSharedMemory.Destroy;
begin
  if ( FMemory <> Nil ) then
    begin
      if not UnmapViewOfFile( FMemory )
        then raise ESharedMemoryError.Create( 'TFilemapping unmapviewoffile error');
      FMemory := Nil;
    end;

  if ( FMappingHandle <> 0 ) then
    if not CloseHandle( FMappingHandle )
      then raise ESharedMemoryError.Create('TFileMapping close handle error' );
  inherited Destroy;
end;




end.
