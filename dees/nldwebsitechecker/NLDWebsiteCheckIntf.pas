unit NLDWebsiteCheckIntf;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLSiteboekType = interface;
  IXMLSiteType = interface;
  IXMLSiteTypeList = interface;

{ IXMLSiteboekType }

  IXMLSiteboekType = interface(IXMLNode)
    ['{4D09FAD5-4E5E-42EB-A650-B2AFD6DD67B8}']
    { Property Accessors }
    function Get_DefaultMail: WideString;
    function Get_Site: IXMLSiteTypeList;
    procedure Set_DefaultMail(Value: WideString);
    { Methods & Properties }
    property DefaultMail: WideString read Get_DefaultMail write Set_DefaultMail;
    property Site: IXMLSiteTypeList read Get_Site;
  end;

{ IXMLSiteType }

  IXMLSiteType = interface(IXMLNode)
    ['{4EDF6A2F-3B2A-4FD7-BA87-3FEE3C734676}']
    { Property Accessors }
    function Get_URL: WideString;
    function Get_Mail: WideString;
    procedure Set_URL(Value: WideString);
    procedure Set_Mail(Value: WideString);
    { Methods & Properties }
    property URL: WideString read Get_URL write Set_URL;
    property Mail: WideString read Get_Mail write Set_Mail;
  end;

{ IXMLSiteTypeList }

  IXMLSiteTypeList = interface(IXMLNodeCollection)
    ['{2DA37E8B-4032-4062-8DF3-4FA503B52558}']
    { Methods & Properties }
    function Add: IXMLSiteType;
    function Insert(const Index: Integer): IXMLSiteType;
    function Get_Item(Index: Integer): IXMLSiteType;
    property Items[Index: Integer]: IXMLSiteType read Get_Item; default;
  end;

{ Forward Decls }

  TXMLCheckSitesType = class;
  TXMLSiteType = class;
  TXMLSiteTypeList = class;

{ TXMLCheckSitesType }

  TXMLCheckSitesType = class(TXMLNode, IXMLSiteboekType)
  private
    FSite: IXMLSiteTypeList;
  protected
    { IXMLSiteboekType }
    function Get_DefaultMail: WideString;
    function Get_Site: IXMLSiteTypeList;
    procedure Set_DefaultMail(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSiteType }

  TXMLSiteType = class(TXMLNode, IXMLSiteType)
  protected
    { IXMLSiteType }
    function Get_URL: WideString;
    function Get_Mail: WideString;
    procedure Set_URL(Value: WideString);
    procedure Set_Mail(Value: WideString);
  end;

{ TXMLSiteTypeList }

  TXMLSiteTypeList = class(TXMLNodeCollection, IXMLSiteTypeList)
  protected
    { IXMLSiteTypeList }
    function Add: IXMLSiteType;
    function Insert(const Index: Integer): IXMLSiteType;
    function Get_Item(Index: Integer): IXMLSiteType;
  end;

{ Global Functions }

function GetCheckSites(Doc: IXMLDocument): IXMLSiteboekType;
function LoadCheckSites(const FileName: WideString): IXMLSiteboekType;
function NewCheckSites: IXMLSiteboekType;

implementation

{ Global Functions }

function GetCheckSites(Doc: IXMLDocument): IXMLSiteboekType;
begin
  Result := Doc.GetDocBinding('CheckSites', TXMLCheckSitesType) as IXMLSiteboekType;
end;
function LoadCheckSites(const FileName: WideString): IXMLSiteboekType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('CheckSites', TXMLCheckSitesType) as IXMLSiteboekType;
end;

function NewCheckSites: IXMLSiteboekType;
begin
  Result := NewXMLDocument.GetDocBinding('CheckSites', TXMLCheckSitesType) as IXMLSiteboekType;
end;

{ TXMLCheckSitesType }

procedure TXMLCheckSitesType.AfterConstruction;
begin
  RegisterChildNode('Site', TXMLSiteType);
  FSite := CreateCollection(TXMLSiteTypeList, IXMLSiteType, 'Site') as IXMLSiteTypeList;
  inherited;
end;

function TXMLCheckSitesType.Get_DefaultMail: WideString;
begin
  Result := ChildNodes['DefaultMail'].Text;
end;

procedure TXMLCheckSitesType.Set_DefaultMail(Value: WideString);
begin
  ChildNodes['DefaultMail'].NodeValue := Value;
end;

function TXMLCheckSitesType.Get_Site: IXMLSiteTypeList;
begin
  Result := FSite;
end;

{ TXMLSiteType }

function TXMLSiteType.Get_URL: WideString;
begin
  Result := ChildNodes['URL'].Text;
end;

procedure TXMLSiteType.Set_URL(Value: WideString);
begin
  ChildNodes['URL'].NodeValue := Value;
end;

function TXMLSiteType.Get_Mail: WideString;
begin
  Result := ChildNodes['Mail'].Text;
end;

procedure TXMLSiteType.Set_Mail(Value: WideString);
begin
  ChildNodes['Mail'].NodeValue := Value;
end;

{ TXMLSiteTypeList }

function TXMLSiteTypeList.Add: IXMLSiteType;
begin
  Result := AddItem(-1) as IXMLSiteType;
end;

function TXMLSiteTypeList.Insert(const Index: Integer): IXMLSiteType;
begin
  Result := AddItem(Index) as IXMLSiteType;
end;

function TXMLSiteTypeList.Get_Item(Index: Integer): IXMLSiteType;
begin
  Result := List[Index] as IXMLSiteType;
end;

end.
