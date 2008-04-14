unit MLanguage;

interface

uses
  Forms,        // For pre-D6 compatibility
  SysUtils,
  Classes,
  NLDTGlobal,
  NLDTManager;

type
  TdmLanguage = class(TDataModule)
    nldtManager:      TNLDTManager;
  end;

var
  dmLanguage:   TdmLanguage;

implementation

{$R *.dfm}

end.
 