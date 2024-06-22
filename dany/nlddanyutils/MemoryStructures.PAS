unit MemoryStructures;

interface

uses windows;

type
TDosHeader   = record
                      magic    : array[0..1] of char;
                      cblp     : Word;
                      cp       : Word;
                      crlc     : word;
                      cparhdr  : Word;
                      minalloc : Word;
                      maxalloc : Word;
                      ss       : word;
                      sp       : Word;
                      csum     : Word;
                      ip       : Word;
                      cs       : Word;
                      lfarlc   : Word;
                      ovno     : Word;
                      res      : array[0..3] of Word;
                      oemid    : Word;
                      oeminfo  : Word;
                      res2     : array [0..9] of Word;
                      lfanew   : LongWord;
                    end;

         TImageData    = record
                            VirtualAddress : DWord;
                            Size: DWord;
                          end;

          TImageSectionHeader =
                          record
                            Name : array[0..7] of char;
                            VirtualSize : DWord;
                            VirtualAddress : DWord;
                            SizeOfRawData : DWord;
                            PointerToRawData : DWord;
                            PointerToLineNumbers : DWord;
                            NumberOfRelocations : DWord;
                            NumberOfLineNumbers : DWord;
                            Characteristics : DWord;
                          end;

          TPeHeader     = record
                            Signature : DWord;

                            { Header }
                            Machine   : Word;
                            NumberOfSections : Word;
                            TimeDateStamp: DWord;
                            PonterToSymbolTable : DWord;
                            NumberOfSymbols     : Dword;
                            SizeOptionalHeadr   : Word;
                            Characteristics     : word;

                            { Optional Header }
                            Magic : Word;
                            MajorLinkerVersion : Byte;
                            MinorLinkerVersion : Byte;
                            SizeOfCode         : DWord;
                            SizeOfInitializedData : DWord;
                            SizeOfUnInitializedData : DWord;
                            AddressOfEntrypoint : DWord;
                            BaseOfCode : DWord;
                            BaseOfData : DWord;
                            Imagebase : DWord;
                            SectionAlignment : DWord;
                            FileAlignment : DWord;
                            MajorOsVersion : Word;
                            MinorOsVersion : Word;
                            MajorImageVersion: Word;
                            MinorImageVersion : Word;
                            MajorSubsystemVersion : Word;
                            MinorSubsystemVersion : Word;
                            Reserved1: DWord;
                            SizeOfImage: DWord;
                            SizeOfHeaders : DWord;
                            CheckSum : DWord;
                            SubSystem: Word;
                            DllCharacteristics: Word;
                            SizeOfStackReserve: DWord;
                            SizeOfStackCommit: DWord;
                            SizeOfHeapReserve: DWord;
                            SizeOfHeapCommit: DWord;
                            LoaderFlags: DWord;
                            NumberOfRvaAndSizes: DWord;
                            ImageDataDirectory  : array [1..16] of TImageData;
                            ImageSectionHeaders : array [1..16] of TImageSectionHeader;
                          end;

          {TMemoryBasicInformation =
                          record
                            BaseAddress       : DWord;
                            AllocationBase    : DWord;
                            AllocationProtect : DWord;
                            RegionSize        : DWord;
                            State             : DWord;
                            Protect           : DWord;
                            _Type             : DWord;
                          end;
           }

implementation

end.
