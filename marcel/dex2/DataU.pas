unit DataU;

interface

uses
  SysUtils, Classes, xmldom, XMLIntf, msxmldom, XMLDoc, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, ForumMessagesU,
  JvTrayIcon;

type
  TData = class(TDataModule)
  private
  public
  end;

var
  Data: TData;

implementation

uses GetDataU;

{$R *.dfm}

{ TData }

end.
