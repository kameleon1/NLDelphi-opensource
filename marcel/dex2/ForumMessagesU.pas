{****************************************************************}
{                                                                }
{                    Delphi XML Data Binding                     }
{                                                                }
{         Generated on: 1-4-2002 23:17:20                        }
{       Generated from: D:\Delphi6\NLDelphiTracker\tracker.xml   }
{   Settings stored in: D:\Delphi6\NLDelphiTracker\tracker.xdb   }
{                                                                }
{****************************************************************}
unit ForumMessagesU;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLNLDelphiDataType = interface;
  IXMLMemberType = interface;
  IXMLForumType = interface;
  IXMLForumTypeList = interface;
  IXMLThreadType = interface;
  IXMLThreadTypeList = interface;
  IXMLPostType = interface;
  IXMLPostTypeList = interface;

{ IXMLNLDelphiDataType }

  IXMLNLDelphiDataType = interface(IXMLNode)
    ['{726BE3B1-9D48-446E-966C-EABC17373BEA}']
    { Property Accessors }
    function Get_Member: IXMLMemberType;
    function Get_Forum: IXMLForumTypeList;
    function Get_RowCount: Integer;
    function Get_LastDateTime: Integer;
    procedure Set_RowCount(Value: Integer);
    procedure Set_LastDateTime(Value: Integer);
    { Methods & Properties }
    property Member: IXMLMemberType read Get_Member;
    property Forum: IXMLForumTypeList read Get_Forum;
    property RowCount: Integer read Get_RowCount write Set_RowCount;
    property LastDateTime: Integer read Get_LastDateTime write Set_LastDateTime;
  end;

{ IXMLMemberType }

  IXMLMemberType = interface(IXMLNode)
    ['{24157FAB-7263-471D-B8D0-254EDEDF774F}']
    { Property Accessors }
    function Get_ID: Integer;
    function Get_Name: WideString;
    procedure Set_ID(Value: Integer);
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property ID: Integer read Get_ID write Set_ID;
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLForumType }

  IXMLForumType = interface(IXMLNode)
    ['{F017439A-922D-4C52-BE1A-740F40B783A1}']
    { Property Accessors }
    function Get_Title: WideString;
    function Get_ID: Integer;
    function Get_Thread: IXMLThreadTypeList;
    procedure Set_Title(Value: WideString);
    procedure Set_ID(Value: Integer);
    { Methods & Properties }
    property Title: WideString read Get_Title write Set_Title;
    property ID: Integer read Get_ID write Set_ID;
    property Thread: IXMLThreadTypeList read Get_Thread;
  end;

{ IXMLForumTypeList }

  IXMLForumTypeList = interface(IXMLNodeCollection)
    ['{E3120AB7-BED9-491F-AFA9-9D3FC43B9487}']
    { Methods & Properties }
    function Add: IXMLForumType;
    function Insert(const Index: Integer): IXMLForumType;
    function Get_Item(Index: Integer): IXMLForumType;
    property Items[Index: Integer]: IXMLForumType read Get_Item; default;
  end;

{ IXMLThreadType }

  IXMLThreadType = interface(IXMLNode)
    ['{AD9B9AFB-46A0-4D54-A795-5A8452325E0A}']
    { Property Accessors }
    function Get_Title: WideString;
    function Get_ID: Integer;
    function Get_Member: IXMLMemberType;
    function Get_Post: IXMLPostTypeList;
    procedure Set_Title(Value: WideString);
    procedure Set_ID(Value: Integer);
    { Methods & Properties }
    property Title: WideString read Get_Title write Set_Title;
    property ID: Integer read Get_ID write Set_ID;
    property Member: IXMLMemberType read Get_Member;
    property Post: IXMLPostTypeList read Get_Post;
  end;

{ IXMLThreadTypeList }

  IXMLThreadTypeList = interface(IXMLNodeCollection)
    ['{24524110-DA4C-4985-8847-313E0B28AB2E}']
    { Methods & Properties }
    function Add: IXMLThreadType;
    function Insert(const Index: Integer): IXMLThreadType;
    function Get_Item(Index: Integer): IXMLThreadType;
    property Items[Index: Integer]: IXMLThreadType read Get_Item; default;
  end;

{ IXMLPostType }

  IXMLPostType = interface(IXMLNode)
    ['{6A8DD887-8462-4A39-931B-AA25547ADD82}']
    { Property Accessors }
    function Get_DateTime: Integer;
    function Get_ID: Integer;
    function Get_Member: IXMLMemberType;
    procedure Set_DateTime(Value: Integer);
    procedure Set_ID(Value: Integer);
    { Methods & Properties }
    property DateTime: Integer read Get_DateTime write Set_DateTime;
    property ID: Integer read Get_ID write Set_ID;
    property Member: IXMLMemberType read Get_Member;
  end;

{ IXMLPostTypeList }

  IXMLPostTypeList = interface(IXMLNodeCollection)
    ['{88C4133E-C4C3-441A-9659-1379EC77A6F8}']
    { Methods & Properties }
    function Add: IXMLPostType;
    function Insert(const Index: Integer): IXMLPostType;
    function Get_Item(Index: Integer): IXMLPostType;
    property Items[Index: Integer]: IXMLPostType read Get_Item; default;
  end;

{ Forward Decls }

  TXMLNLDelphiDataType = class;
  TXMLMemberType = class;
  TXMLForumType = class;
  TXMLForumTypeList = class;
  TXMLThreadType = class;
  TXMLThreadTypeList = class;
  TXMLPostType = class;
  TXMLPostTypeList = class;

{ TXMLNLDelphiDataType }

  TXMLNLDelphiDataType = class(TXMLNode, IXMLNLDelphiDataType)
  private
    FForum: IXMLForumTypeList;
  protected
    { IXMLNLDelphiDataType }
    function Get_Member: IXMLMemberType;
    function Get_Forum: IXMLForumTypeList;
    function Get_RowCount: Integer;
    function Get_LastDateTime: Integer;
    procedure Set_RowCount(Value: Integer);
    procedure Set_LastDateTime(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMemberType }

  TXMLMemberType = class(TXMLNode, IXMLMemberType)
  protected
    { IXMLMemberType }
    function Get_ID: Integer;
    function Get_Name: WideString;
    procedure Set_ID(Value: Integer);
    procedure Set_Name(Value: WideString);
  end;

{ TXMLForumType }

  TXMLForumType = class(TXMLNode, IXMLForumType)
  private
    FThread: IXMLThreadTypeList;
  protected
    { IXMLForumType }
    function Get_Title: WideString;
    function Get_ID: Integer;
    function Get_Thread: IXMLThreadTypeList;
    procedure Set_Title(Value: WideString);
    procedure Set_ID(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLForumTypeList }

  TXMLForumTypeList = class(TXMLNodeCollection, IXMLForumTypeList)
  protected
    { IXMLForumTypeList }
    function Add: IXMLForumType;
    function Insert(const Index: Integer): IXMLForumType;
    function Get_Item(Index: Integer): IXMLForumType;
  end;

{ TXMLThreadType }

  TXMLThreadType = class(TXMLNode, IXMLThreadType)
  private
    FPost: IXMLPostTypeList;
  protected
    { IXMLThreadType }
    function Get_Title: WideString;
    function Get_ID: Integer;
    function Get_Member: IXMLMemberType;
    function Get_Post: IXMLPostTypeList;
    procedure Set_Title(Value: WideString);
    procedure Set_ID(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLThreadTypeList }

  TXMLThreadTypeList = class(TXMLNodeCollection, IXMLThreadTypeList)
  protected
    { IXMLThreadTypeList }
    function Add: IXMLThreadType;
    function Insert(const Index: Integer): IXMLThreadType;
    function Get_Item(Index: Integer): IXMLThreadType;
  end;

{ TXMLPostType }

  TXMLPostType = class(TXMLNode, IXMLPostType)
  protected
    { IXMLPostType }
    function Get_DateTime: Integer;
    function Get_ID: Integer;
    function Get_Member: IXMLMemberType;
    procedure Set_DateTime(Value: Integer);
    procedure Set_ID(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPostTypeList }

  TXMLPostTypeList = class(TXMLNodeCollection, IXMLPostTypeList)
  protected
    { IXMLPostTypeList }
    function Add: IXMLPostType;
    function Insert(const Index: Integer): IXMLPostType;
    function Get_Item(Index: Integer): IXMLPostType;
  end;

{ Global Functions }

function GetNLDelphiData(Doc: IXMLDocument): IXMLNLDelphiDataType;
function LoadNLDelphiData(const FileName: WideString): IXMLNLDelphiDataType;
function NewNLDelphiData: IXMLNLDelphiDataType;

implementation

{ Global Functions }

function GetNLDelphiData(Doc: IXMLDocument): IXMLNLDelphiDataType;
begin
  Result := Doc.GetDocBinding('NLDelphiData', TXMLNLDelphiDataType) as IXMLNLDelphiDataType;
end;
function LoadNLDelphiData(const FileName: WideString): IXMLNLDelphiDataType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('NLDelphiData', TXMLNLDelphiDataType) as IXMLNLDelphiDataType;
end;

function NewNLDelphiData: IXMLNLDelphiDataType;
begin
  Result := NewXMLDocument.GetDocBinding('NLDelphiData', TXMLNLDelphiDataType) as IXMLNLDelphiDataType;
end;

{ TXMLNLDelphiDataType }

procedure TXMLNLDelphiDataType.AfterConstruction;
begin
  RegisterChildNode('Member', TXMLMemberType);
  RegisterChildNode('Forum', TXMLForumType);
  FForum := CreateCollection(TXMLForumTypeList, IXMLForumType, 'Forum') as IXMLForumTypeList;
  inherited;
end;

function TXMLNLDelphiDataType.Get_Member: IXMLMemberType;
begin
  Result := ChildNodes['Member'] as IXMLMemberType;
end;

function TXMLNLDelphiDataType.Get_Forum: IXMLForumTypeList;
begin
  Result := FForum;
end;

function TXMLNLDelphiDataType.Get_RowCount: Integer;
begin
  Result := ChildNodes['RowCount'].NodeValue;
end;

procedure TXMLNLDelphiDataType.Set_RowCount(Value: Integer);
begin
  ChildNodes['RowCount'].NodeValue := Value;
end;

function TXMLNLDelphiDataType.Get_LastDateTime: Integer;
begin
  Result := ChildNodes['LastDateTime'].NodeValue;
end;

procedure TXMLNLDelphiDataType.Set_LastDateTime(Value: Integer);
begin
  ChildNodes['LastDateTime'].NodeValue := Value;
end;

{ TXMLMemberType }

function TXMLMemberType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLMemberType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLMemberType.Get_Name: WideString;
begin
  Result := ChildNodes['Name'].Text;
end;

procedure TXMLMemberType.Set_Name(Value: WideString);
begin
  ChildNodes['Name'].NodeValue := Value;
end;

{ TXMLForumType }

procedure TXMLForumType.AfterConstruction;
begin
  RegisterChildNode('Thread', TXMLThreadType);
  FThread := CreateCollection(TXMLThreadTypeList, IXMLThreadType, 'Thread') as IXMLThreadTypeList;
  inherited;
end;

function TXMLForumType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLForumType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
end;

function TXMLForumType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLForumType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLForumType.Get_Thread: IXMLThreadTypeList;
begin
  Result := FThread;
end;

{ TXMLForumTypeList }

function TXMLForumTypeList.Add: IXMLForumType;
begin
  Result := AddItem(-1) as IXMLForumType;
end;

function TXMLForumTypeList.Insert(const Index: Integer): IXMLForumType;
begin
  Result := AddItem(Index) as IXMLForumType;
end;

function TXMLForumTypeList.Get_Item(Index: Integer): IXMLForumType;
begin
  Result := List[Index] as IXMLForumType;
end;

{ TXMLThreadType }

procedure TXMLThreadType.AfterConstruction;
begin
  RegisterChildNode('Member', TXMLMemberType);
  RegisterChildNode('Post', TXMLPostType);
  FPost := CreateCollection(TXMLPostTypeList, IXMLPostType, 'Post') as IXMLPostTypeList;
  inherited;
end;

function TXMLThreadType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLThreadType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
end;

function TXMLThreadType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLThreadType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLThreadType.Get_Member: IXMLMemberType;
begin
  Result := ChildNodes['Member'] as IXMLMemberType;
end;

function TXMLThreadType.Get_Post: IXMLPostTypeList;
begin
  Result := FPost;
end;

{ TXMLThreadTypeList }

function TXMLThreadTypeList.Add: IXMLThreadType;
begin
  Result := AddItem(-1) as IXMLThreadType;
end;

function TXMLThreadTypeList.Insert(const Index: Integer): IXMLThreadType;
begin
  Result := AddItem(Index) as IXMLThreadType;
end;

function TXMLThreadTypeList.Get_Item(Index: Integer): IXMLThreadType;
begin
  Result := List[Index] as IXMLThreadType;
end;

{ TXMLPostType }

procedure TXMLPostType.AfterConstruction;
begin
  RegisterChildNode('Member', TXMLMemberType);
  inherited;
end;

function TXMLPostType.Get_DateTime: Integer;
begin
  Result := ChildNodes['DateTime'].NodeValue;
end;

procedure TXMLPostType.Set_DateTime(Value: Integer);
begin
  ChildNodes['DateTime'].NodeValue := Value;
end;

function TXMLPostType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLPostType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLPostType.Get_Member: IXMLMemberType;
begin
  Result := ChildNodes['Member'] as IXMLMemberType;
end;

{ TXMLPostTypeList }

function TXMLPostTypeList.Add: IXMLPostType;
begin
  Result := AddItem(-1) as IXMLPostType;
end;

function TXMLPostTypeList.Insert(const Index: Integer): IXMLPostType;
begin
  Result := AddItem(Index) as IXMLPostType;
end;

function TXMLPostTypeList.Get_Item(Index: Integer): IXMLPostType;
begin
  Result := List[Index] as IXMLPostType;
end;

end.

