
{*******************************************************************}
{                                                                   }
{                      Delphi XML Data Binding                      }
{                                                                   }
{         Generated on: 5-10-2003 17:46:58                          }
{       Generated from: D:\NLDelphi\Projects\DeX2\TemplateDeX.xml   }
{   Settings stored in: D:\NLDelphi\Projects\DeX2\TemplateDeX.xdb   }
{                                                                   }
{*******************************************************************}
unit NLDXMLIntf;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLNLDelphiDataType = interface;
  IXMLErrorType = interface;
  IXMLPMType = interface;
  IXMLPMTypeList = interface;
  IXMLMemberType = interface;
  IXMLPMReadType = interface;
  IXMLPMReadTypeList = interface;
  IXMLForumType = interface;
  IXMLForumTypeList = interface;
  IXMLThreadType = interface;
  IXMLThreadTypeList = interface;
  IXMLPostType = interface;
  IXMLPostTypeList = interface;
  IXMLEventType = interface;
  IXMLEventTypeList = interface;
  IXMLLinkType = interface;
  IXMLLinkTypeList = interface;
  IXMLNewsType = interface;
  IXMLNewsTypeList = interface;
  IXMLForumInfoType = interface;
  IXMLForumInfoTypeList = interface;
  IXMLString_List = interface;

{ IXMLNLDelphiDataType }

  IXMLNLDelphiDataType = interface(IXMLNode)
    ['{8F530BEF-B012-44B2-8FF0-6D6084CB96CB}']
    { Property Accessors }
    function Get_SessionID: WideString;
    function Get_RowCount: Integer;
    function Get_Error: IXMLErrorType;
    function Get_PM: IXMLPMTypeList;
    function Get_PMRead: IXMLPMReadTypeList;
    function Get_Forum: IXMLForumTypeList;
    function Get_Event: IXMLEventTypeList;
    function Get_Link: IXMLLinkTypeList;
    function Get_News: IXMLNewsTypeList;
    function Get_ForumInfo: IXMLForumInfoTypeList;
    procedure Set_SessionID(Value: WideString);
    procedure Set_RowCount(Value: Integer);
    { Methods & Properties }
    property SessionID: WideString read Get_SessionID write Set_SessionID;
    property RowCount: Integer read Get_RowCount write Set_RowCount;
    property Error: IXMLErrorType read Get_Error;
    property PM: IXMLPMTypeList read Get_PM;
    property PMRead: IXMLPMReadTypeList read Get_PMRead;
    property Forum: IXMLForumTypeList read Get_Forum;
    property Event: IXMLEventTypeList read Get_Event;
    property Link: IXMLLinkTypeList read Get_Link;
    property News: IXMLNewsTypeList read Get_News;
    property ForumInfo: IXMLForumInfoTypeList read Get_ForumInfo;
  end;

{ IXMLErrorType }

  IXMLErrorType = interface(IXMLNode)
    ['{9E7B19B9-7E10-4AEE-A2A2-D5E909AE2DFD}']
    { Property Accessors }
    function Get_Text: WideString;
    procedure Set_Text(Value: WideString);
    { Methods & Properties }
    property Text: WideString read Get_Text write Set_Text;
  end;

{ IXMLPMType }

  IXMLPMType = interface(IXMLNode)
    ['{8754A362-4509-49F3-8B08-F76E7BA37196}']
    { Property Accessors }
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_Member: IXMLMemberType;
    function Get_DateTime: Integer;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
    procedure Set_DateTime(Value: Integer);
    { Methods & Properties }
    property ID: Integer read Get_ID write Set_ID;
    property Title: WideString read Get_Title write Set_Title;
    property Member: IXMLMemberType read Get_Member;
    property DateTime: Integer read Get_DateTime write Set_DateTime;
  end;

{ IXMLPMTypeList }

  IXMLPMTypeList = interface(IXMLNodeCollection)
    ['{7E5B8A1C-B845-44BF-90FD-8AD0BA512B16}']
    { Methods & Properties }
    function Add: IXMLPMType;
    function Insert(const Index: Integer): IXMLPMType;
    function Get_Item(Index: Integer): IXMLPMType;
    property Items[Index: Integer]: IXMLPMType read Get_Item; default;
  end;

{ IXMLMemberType }

  IXMLMemberType = interface(IXMLNode)
    ['{14F50029-70C9-42E3-B553-54BCE339D848}']
    { Property Accessors }
    function Get_ID: Integer;
    function Get_Name: WideString;
    procedure Set_ID(Value: Integer);
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property ID: Integer read Get_ID write Set_ID;
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLPMReadType }

  IXMLPMReadType = interface(IXMLNode)
    ['{1D823C08-6E5C-40C4-ACF8-A52544B73756}']
    { Property Accessors }
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_Member: IXMLMemberType;
    function Get_DateTime: Integer;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
    procedure Set_DateTime(Value: Integer);
    { Methods & Properties }
    property ID: Integer read Get_ID write Set_ID;
    property Title: WideString read Get_Title write Set_Title;
    property Member: IXMLMemberType read Get_Member;
    property DateTime: Integer read Get_DateTime write Set_DateTime;
  end;

{ IXMLPMReadTypeList }

  IXMLPMReadTypeList = interface(IXMLNodeCollection)
    ['{46BA1C7A-050A-4073-A81C-3BD48837C690}']
    { Methods & Properties }
    function Add: IXMLPMReadType;
    function Insert(const Index: Integer): IXMLPMReadType;
    function Get_Item(Index: Integer): IXMLPMReadType;
    property Items[Index: Integer]: IXMLPMReadType read Get_Item; default;
  end;

{ IXMLForumType }

  IXMLForumType = interface(IXMLNode)
    ['{A08548DF-EDF3-4978-9DB9-944AF5B8CF19}']
    { Property Accessors }
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_Thread: IXMLThreadTypeList;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
    { Methods & Properties }
    property ID: Integer read Get_ID write Set_ID;
    property Title: WideString read Get_Title write Set_Title;
    property Thread: IXMLThreadTypeList read Get_Thread;
  end;

{ IXMLForumTypeList }

  IXMLForumTypeList = interface(IXMLNodeCollection)
    ['{A6500BF3-9F56-4EFF-B979-057D3E47EA05}']
    { Methods & Properties }
    function Add: IXMLForumType;
    function Insert(const Index: Integer): IXMLForumType;
    function Get_Item(Index: Integer): IXMLForumType;
    property Items[Index: Integer]: IXMLForumType read Get_Item; default;
  end;

{ IXMLThreadType }

  IXMLThreadType = interface(IXMLNode)
    ['{ACCB85A5-A7D6-4FBC-9810-8A3A3F40257B}']
    { Property Accessors }
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_Part: Integer;
    function Get_IconID: Integer;
    function Get_Member: IXMLMemberType;
    function Get_Post: IXMLPostTypeList;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
    procedure Set_Part(Value: Integer);
    procedure Set_IconID(Value: Integer);
    { Methods & Properties }
    property ID: Integer read Get_ID write Set_ID;
    property Title: WideString read Get_Title write Set_Title;
    property Part: Integer read Get_Part write Set_Part;
    property IconID: Integer read Get_IconID write Set_IconID;
    property Member: IXMLMemberType read Get_Member;
    property Post: IXMLPostTypeList read Get_Post;
  end;

{ IXMLThreadTypeList }

  IXMLThreadTypeList = interface(IXMLNodeCollection)
    ['{76C27AEC-59C2-4F3C-8D62-EB7B843DE93D}']
    { Methods & Properties }
    function Add: IXMLThreadType;
    function Insert(const Index: Integer): IXMLThreadType;
    function Get_Item(Index: Integer): IXMLThreadType;
    property Items[Index: Integer]: IXMLThreadType read Get_Item; default;
  end;

{ IXMLPostType }

  IXMLPostType = interface(IXMLNode)
    ['{71E9901D-FE48-4248-87CF-29842BA43BE2}']
    { Property Accessors }
    function Get_ID: Integer;
    function Get_DateTime: Integer;
    function Get_IconID: Integer;
    function Get_Member: IXMLMemberType;
    procedure Set_ID(Value: Integer);
    procedure Set_DateTime(Value: Integer);
    procedure Set_IconID(Value: Integer);
    { Methods & Properties }
    property ID: Integer read Get_ID write Set_ID;
    property DateTime: Integer read Get_DateTime write Set_DateTime;
    property IconID: Integer read Get_IconID write Set_IconID;
    property Member: IXMLMemberType read Get_Member;
  end;

{ IXMLPostTypeList }

  IXMLPostTypeList = interface(IXMLNodeCollection)
    ['{D946D12E-317B-4C4F-BCE8-D15B2689F357}']
    { Methods & Properties }
    function Add: IXMLPostType;
    function Insert(const Index: Integer): IXMLPostType;
    function Get_Item(Index: Integer): IXMLPostType;
    property Items[Index: Integer]: IXMLPostType read Get_Item; default;
  end;

{ IXMLEventType }

  IXMLEventType = interface(IXMLNode)
    ['{D08E764E-EA95-4B72-8304-B8F047E1D51E}']
    { Property Accessors }
    function Get_Title: IXMLString_List;
    function Get_Date: Integer;
    procedure Set_Date(Value: Integer);
    { Methods & Properties }
    property Title: IXMLString_List read Get_Title;
    property Date: Integer read Get_Date write Set_Date;
  end;

{ IXMLEventTypeList }

  IXMLEventTypeList = interface(IXMLNodeCollection)
    ['{622014BF-8C9C-486B-8C20-C7C309BE3F94}']
    { Methods & Properties }
    function Add: IXMLEventType;
    function Insert(const Index: Integer): IXMLEventType;
    function Get_Item(Index: Integer): IXMLEventType;
    property Items[Index: Integer]: IXMLEventType read Get_Item; default;
  end;

{ IXMLLinkType }

  IXMLLinkType = interface(IXMLNode)
    ['{3A123D99-4B8F-4308-BFC8-557D13005DF3}']
    { Property Accessors }
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_DateTime: Integer;
    function Get_Forum: IXMLForumType;
    function Get_Member: IXMLMemberType;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
    procedure Set_DateTime(Value: Integer);
    { Methods & Properties }
    property ID: Integer read Get_ID write Set_ID;
    property Title: WideString read Get_Title write Set_Title;
    property DateTime: Integer read Get_DateTime write Set_DateTime;
    property Forum: IXMLForumType read Get_Forum;
    property Member: IXMLMemberType read Get_Member;
  end;

{ IXMLLinkTypeList }

  IXMLLinkTypeList = interface(IXMLNodeCollection)
    ['{182B7753-34CB-4F22-8FC6-F1B0E1E686DD}']
    { Methods & Properties }
    function Add: IXMLLinkType;
    function Insert(const Index: Integer): IXMLLinkType;
    function Get_Item(Index: Integer): IXMLLinkType;
    property Items[Index: Integer]: IXMLLinkType read Get_Item; default;
  end;

{ IXMLNewsType }

  IXMLNewsType = interface(IXMLNode)
    ['{28F5CCE0-132E-43DE-9069-2768B5123487}']
    { Property Accessors }
    function Get_ID: Integer;
    function Get_DateTime: Integer;
    function Get_Title: WideString;
    procedure Set_ID(Value: Integer);
    procedure Set_DateTime(Value: Integer);
    procedure Set_Title(Value: WideString);
    { Methods & Properties }
    property ID: Integer read Get_ID write Set_ID;
    property DateTime: Integer read Get_DateTime write Set_DateTime;
    property Title: WideString read Get_Title write Set_Title;
  end;

{ IXMLNewsTypeList }

  IXMLNewsTypeList = interface(IXMLNodeCollection)
    ['{A17969B0-938B-4168-9882-E23841012FFA}']
    { Methods & Properties }
    function Add: IXMLNewsType;
    function Insert(const Index: Integer): IXMLNewsType;
    function Get_Item(Index: Integer): IXMLNewsType;
    property Items[Index: Integer]: IXMLNewsType read Get_Item; default;
  end;

{ IXMLForumInfoType }

  IXMLForumInfoType = interface(IXMLNode)
    ['{E4CB7946-BD04-4CBF-AD62-52ADD042C51F}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_ID: Integer;
    function Get_ParentID: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_ID(Value: Integer);
    procedure Set_ParentID(Value: Integer);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property ID: Integer read Get_ID write Set_ID;
    property ParentID: Integer read Get_ParentID write Set_ParentID;
  end;

{ IXMLForumInfoTypeList }

  IXMLForumInfoTypeList = interface(IXMLNodeCollection)
    ['{E27422D4-9E6B-43C7-8F1E-F26E935F09CA}']
    { Methods & Properties }
    function Add: IXMLForumInfoType;
    function Insert(const Index: Integer): IXMLForumInfoType;
    function Get_Item(Index: Integer): IXMLForumInfoType;
    property Items[Index: Integer]: IXMLForumInfoType read Get_Item; default;
  end;

{ IXMLString_List }

  IXMLString_List = interface(IXMLNodeCollection)
    ['{07FBE96B-9FE8-4475-AA22-FF44B8797CE6}']
    { Methods & Properties }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
    property Items[Index: Integer]: WideString read Get_Item; default;
  end;

{ Forward Decls }

  TXMLNLDelphiDataType = class;
  TXMLErrorType = class;
  TXMLPMType = class;
  TXMLPMTypeList = class;
  TXMLMemberType = class;
  TXMLPMReadType = class;
  TXMLPMReadTypeList = class;
  TXMLForumType = class;
  TXMLForumTypeList = class;
  TXMLThreadType = class;
  TXMLThreadTypeList = class;
  TXMLPostType = class;
  TXMLPostTypeList = class;
  TXMLEventType = class;
  TXMLEventTypeList = class;
  TXMLLinkType = class;
  TXMLLinkTypeList = class;
  TXMLNewsType = class;
  TXMLNewsTypeList = class;
  TXMLForumInfoType = class;
  TXMLForumInfoTypeList = class;
  TXMLString_List = class;

{ TXMLNLDelphiDataType }

  TXMLNLDelphiDataType = class(TXMLNode, IXMLNLDelphiDataType)
  private
    FPM: IXMLPMTypeList;
    FPMRead: IXMLPMReadTypeList;
    FForum: IXMLForumTypeList;
    FEvent: IXMLEventTypeList;
    FLink: IXMLLinkTypeList;
    FNews: IXMLNewsTypeList;
    FForumInfo: IXMLForumInfoTypeList;
  protected
    { IXMLNLDelphiDataType }
    function Get_SessionID: WideString;
    function Get_RowCount: Integer;
    function Get_Error: IXMLErrorType;
    function Get_PM: IXMLPMTypeList;
    function Get_PMRead: IXMLPMReadTypeList;
    function Get_Forum: IXMLForumTypeList;
    function Get_Event: IXMLEventTypeList;
    function Get_Link: IXMLLinkTypeList;
    function Get_News: IXMLNewsTypeList;
    function Get_ForumInfo: IXMLForumInfoTypeList;
    procedure Set_SessionID(Value: WideString);
    procedure Set_RowCount(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLErrorType }

  TXMLErrorType = class(TXMLNode, IXMLErrorType)
  protected
    { IXMLErrorType }
    function Get_Text: WideString;
    procedure Set_Text(Value: WideString);
  end;

{ TXMLPMType }

  TXMLPMType = class(TXMLNode, IXMLPMType)
  protected
    { IXMLPMType }
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_Member: IXMLMemberType;
    function Get_DateTime: Integer;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
    procedure Set_DateTime(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPMTypeList }

  TXMLPMTypeList = class(TXMLNodeCollection, IXMLPMTypeList)
  protected
    { IXMLPMTypeList }
    function Add: IXMLPMType;
    function Insert(const Index: Integer): IXMLPMType;
    function Get_Item(Index: Integer): IXMLPMType;
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

{ TXMLPMReadType }

  TXMLPMReadType = class(TXMLNode, IXMLPMReadType)
  protected
    { IXMLPMReadType }
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_Member: IXMLMemberType;
    function Get_DateTime: Integer;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
    procedure Set_DateTime(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPMReadTypeList }

  TXMLPMReadTypeList = class(TXMLNodeCollection, IXMLPMReadTypeList)
  protected
    { IXMLPMReadTypeList }
    function Add: IXMLPMReadType;
    function Insert(const Index: Integer): IXMLPMReadType;
    function Get_Item(Index: Integer): IXMLPMReadType;
  end;

{ TXMLForumType }

  TXMLForumType = class(TXMLNode, IXMLForumType)
  private
    FThread: IXMLThreadTypeList;
  protected
    { IXMLForumType }
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_Thread: IXMLThreadTypeList;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
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
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_Part: Integer;
    function Get_IconID: Integer;
    function Get_Member: IXMLMemberType;
    function Get_Post: IXMLPostTypeList;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
    procedure Set_Part(Value: Integer);
    procedure Set_IconID(Value: Integer);
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
    function Get_ID: Integer;
    function Get_DateTime: Integer;
    function Get_IconID: Integer;
    function Get_Member: IXMLMemberType;
    procedure Set_ID(Value: Integer);
    procedure Set_DateTime(Value: Integer);
    procedure Set_IconID(Value: Integer);
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

{ TXMLEventType }

  TXMLEventType = class(TXMLNode, IXMLEventType)
  private
    FTitle: IXMLString_List;
  protected
    { IXMLEventType }
    function Get_Title: IXMLString_List;
    function Get_Date: Integer;
    procedure Set_Date(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLEventTypeList }

  TXMLEventTypeList = class(TXMLNodeCollection, IXMLEventTypeList)
  protected
    { IXMLEventTypeList }
    function Add: IXMLEventType;
    function Insert(const Index: Integer): IXMLEventType;
    function Get_Item(Index: Integer): IXMLEventType;
  end;

{ TXMLLinkType }

  TXMLLinkType = class(TXMLNode, IXMLLinkType)
  protected
    { IXMLLinkType }
    function Get_ID: Integer;
    function Get_Title: WideString;
    function Get_DateTime: Integer;
    function Get_Forum: IXMLForumType;
    function Get_Member: IXMLMemberType;
    procedure Set_ID(Value: Integer);
    procedure Set_Title(Value: WideString);
    procedure Set_DateTime(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLinkTypeList }

  TXMLLinkTypeList = class(TXMLNodeCollection, IXMLLinkTypeList)
  protected
    { IXMLLinkTypeList }
    function Add: IXMLLinkType;
    function Insert(const Index: Integer): IXMLLinkType;
    function Get_Item(Index: Integer): IXMLLinkType;
  end;

{ TXMLNewsType }

  TXMLNewsType = class(TXMLNode, IXMLNewsType)
  protected
    { IXMLNewsType }
    function Get_ID: Integer;
    function Get_DateTime: Integer;
    function Get_Title: WideString;
    procedure Set_ID(Value: Integer);
    procedure Set_DateTime(Value: Integer);
    procedure Set_Title(Value: WideString);
  end;

{ TXMLNewsTypeList }

  TXMLNewsTypeList = class(TXMLNodeCollection, IXMLNewsTypeList)
  protected
    { IXMLNewsTypeList }
    function Add: IXMLNewsType;
    function Insert(const Index: Integer): IXMLNewsType;
    function Get_Item(Index: Integer): IXMLNewsType;
  end;

{ TXMLForumInfoType }

  TXMLForumInfoType = class(TXMLNode, IXMLForumInfoType)
  protected
    { IXMLForumInfoType }
    function Get_Name: WideString;
    function Get_ID: Integer;
    function Get_ParentID: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_ID(Value: Integer);
    procedure Set_ParentID(Value: Integer);
  end;

{ TXMLForumInfoTypeList }

  TXMLForumInfoTypeList = class(TXMLNodeCollection, IXMLForumInfoTypeList)
  protected
    { IXMLForumInfoTypeList }
    function Add: IXMLForumInfoType;
    function Insert(const Index: Integer): IXMLForumInfoType;
    function Get_Item(Index: Integer): IXMLForumInfoType;
  end;

{ TXMLString_List }

  TXMLString_List = class(TXMLNodeCollection, IXMLString_List)
  protected
    { IXMLString_List }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
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
  RegisterChildNode('error', TXMLErrorType);
  RegisterChildNode('PM', TXMLPMType);
  RegisterChildNode('PMRead', TXMLPMReadType);
  RegisterChildNode('Forum', TXMLForumType);
  RegisterChildNode('Event', TXMLEventType);
  RegisterChildNode('Link', TXMLLinkType);
  RegisterChildNode('News', TXMLNewsType);
  RegisterChildNode('ForumInfo', TXMLForumInfoType);
  FPM := CreateCollection(TXMLPMTypeList, IXMLPMType, 'PM') as IXMLPMTypeList;
  FPMRead := CreateCollection(TXMLPMReadTypeList, IXMLPMReadType, 'PMRead') as IXMLPMReadTypeList;
  FForum := CreateCollection(TXMLForumTypeList, IXMLForumType, 'Forum') as IXMLForumTypeList;
  FEvent := CreateCollection(TXMLEventTypeList, IXMLEventType, 'Event') as IXMLEventTypeList;
  FLink := CreateCollection(TXMLLinkTypeList, IXMLLinkType, 'Link') as IXMLLinkTypeList;
  FNews := CreateCollection(TXMLNewsTypeList, IXMLNewsType, 'News') as IXMLNewsTypeList;
  FForumInfo := CreateCollection(TXMLForumInfoTypeList, IXMLForumInfoType, 'ForumInfo') as IXMLForumInfoTypeList;
  inherited;
end;

function TXMLNLDelphiDataType.Get_SessionID: WideString;
begin
  Result := ChildNodes['SessionID'].Text;
end;

procedure TXMLNLDelphiDataType.Set_SessionID(Value: WideString);
begin
  ChildNodes['SessionID'].NodeValue := Value;
end;

function TXMLNLDelphiDataType.Get_RowCount: Integer;
begin
  Result := ChildNodes['RowCount'].NodeValue;
end;

procedure TXMLNLDelphiDataType.Set_RowCount(Value: Integer);
begin
  ChildNodes['RowCount'].NodeValue := Value;
end;

function TXMLNLDelphiDataType.Get_Error: IXMLErrorType;
begin
  Result := ChildNodes['error'] as IXMLErrorType;
end;

function TXMLNLDelphiDataType.Get_PM: IXMLPMTypeList;
begin
  Result := FPM;
end;

function TXMLNLDelphiDataType.Get_PMRead: IXMLPMReadTypeList;
begin
  Result := FPMRead;
end;

function TXMLNLDelphiDataType.Get_Forum: IXMLForumTypeList;
begin
  Result := FForum;
end;

function TXMLNLDelphiDataType.Get_Event: IXMLEventTypeList;
begin
  Result := FEvent;
end;

function TXMLNLDelphiDataType.Get_Link: IXMLLinkTypeList;
begin
  Result := FLink;
end;

function TXMLNLDelphiDataType.Get_News: IXMLNewsTypeList;
begin
  Result := FNews;
end;

function TXMLNLDelphiDataType.Get_ForumInfo: IXMLForumInfoTypeList;
begin
  Result := FForumInfo;
end;

{ TXMLErrorType }

function TXMLErrorType.Get_Text: WideString;
begin
  Result := ChildNodes['text'].Text;
end;

procedure TXMLErrorType.Set_Text(Value: WideString);
begin
  ChildNodes['text'].NodeValue := Value;
end;

{ TXMLPMType }

procedure TXMLPMType.AfterConstruction;
begin
  RegisterChildNode('Member', TXMLMemberType);
  inherited;
end;

function TXMLPMType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLPMType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLPMType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLPMType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
end;

function TXMLPMType.Get_Member: IXMLMemberType;
begin
  Result := ChildNodes['Member'] as IXMLMemberType;
end;

function TXMLPMType.Get_DateTime: Integer;
begin
  Result := ChildNodes['DateTime'].NodeValue;
end;

procedure TXMLPMType.Set_DateTime(Value: Integer);
begin
  ChildNodes['DateTime'].NodeValue := Value;
end;

{ TXMLPMTypeList }

function TXMLPMTypeList.Add: IXMLPMType;
begin
  Result := AddItem(-1) as IXMLPMType;
end;

function TXMLPMTypeList.Insert(const Index: Integer): IXMLPMType;
begin
  Result := AddItem(Index) as IXMLPMType;
end;

function TXMLPMTypeList.Get_Item(Index: Integer): IXMLPMType;
begin
  Result := List[Index] as IXMLPMType;
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

{ TXMLPMReadType }

procedure TXMLPMReadType.AfterConstruction;
begin
  RegisterChildNode('Member', TXMLMemberType);
  inherited;
end;

function TXMLPMReadType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLPMReadType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLPMReadType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLPMReadType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
end;

function TXMLPMReadType.Get_Member: IXMLMemberType;
begin
  Result := ChildNodes['Member'] as IXMLMemberType;
end;

function TXMLPMReadType.Get_DateTime: Integer;
begin
  Result := ChildNodes['DateTime'].NodeValue;
end;

procedure TXMLPMReadType.Set_DateTime(Value: Integer);
begin
  ChildNodes['DateTime'].NodeValue := Value;
end;

{ TXMLPMReadTypeList }

function TXMLPMReadTypeList.Add: IXMLPMReadType;
begin
  Result := AddItem(-1) as IXMLPMReadType;
end;

function TXMLPMReadTypeList.Insert(const Index: Integer): IXMLPMReadType;
begin
  Result := AddItem(Index) as IXMLPMReadType;
end;

function TXMLPMReadTypeList.Get_Item(Index: Integer): IXMLPMReadType;
begin
  Result := List[Index] as IXMLPMReadType;
end;

{ TXMLForumType }

procedure TXMLForumType.AfterConstruction;
begin
  RegisterChildNode('Thread', TXMLThreadType);
  FThread := CreateCollection(TXMLThreadTypeList, IXMLThreadType, 'Thread') as IXMLThreadTypeList;
  inherited;
end;

function TXMLForumType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLForumType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLForumType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLForumType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
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

function TXMLThreadType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLThreadType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLThreadType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLThreadType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
end;

function TXMLThreadType.Get_Part: Integer;
begin
  Result := ChildNodes['Part'].NodeValue;
end;

procedure TXMLThreadType.Set_Part(Value: Integer);
begin
  ChildNodes['Part'].NodeValue := Value;
end;

function TXMLThreadType.Get_IconID: Integer;
begin
  Result := ChildNodes['IconID'].NodeValue;
end;

procedure TXMLThreadType.Set_IconID(Value: Integer);
begin
  ChildNodes['IconID'].NodeValue := Value;
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

function TXMLPostType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLPostType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLPostType.Get_DateTime: Integer;
begin
  Result := ChildNodes['DateTime'].NodeValue;
end;

procedure TXMLPostType.Set_DateTime(Value: Integer);
begin
  ChildNodes['DateTime'].NodeValue := Value;
end;

function TXMLPostType.Get_IconID: Integer;
begin
  Result := ChildNodes['IconID'].NodeValue;
end;

procedure TXMLPostType.Set_IconID(Value: Integer);
begin
  ChildNodes['IconID'].NodeValue := Value;
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

{ TXMLEventType }

procedure TXMLEventType.AfterConstruction;
begin
  FTitle := CreateCollection(TXMLString_List, IXMLNode, 'Title') as IXMLString_List;
  inherited;
end;

function TXMLEventType.Get_Title: IXMLString_List;
begin
  Result := FTitle;
end;

function TXMLEventType.Get_Date: Integer;
begin
  Result := ChildNodes['Date'].NodeValue;
end;

procedure TXMLEventType.Set_Date(Value: Integer);
begin
  ChildNodes['Date'].NodeValue := Value;
end;

{ TXMLEventTypeList }

function TXMLEventTypeList.Add: IXMLEventType;
begin
  Result := AddItem(-1) as IXMLEventType;
end;

function TXMLEventTypeList.Insert(const Index: Integer): IXMLEventType;
begin
  Result := AddItem(Index) as IXMLEventType;
end;

function TXMLEventTypeList.Get_Item(Index: Integer): IXMLEventType;
begin
  Result := List[Index] as IXMLEventType;
end;

{ TXMLLinkType }

procedure TXMLLinkType.AfterConstruction;
begin
  RegisterChildNode('Forum', TXMLForumType);
  RegisterChildNode('Member', TXMLMemberType);
  inherited;
end;

function TXMLLinkType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLLinkType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLLinkType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLLinkType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
end;

function TXMLLinkType.Get_DateTime: Integer;
begin
  Result := ChildNodes['DateTime'].NodeValue;
end;

procedure TXMLLinkType.Set_DateTime(Value: Integer);
begin
  ChildNodes['DateTime'].NodeValue := Value;
end;

function TXMLLinkType.Get_Forum: IXMLForumType;
begin
  Result := ChildNodes['Forum'] as IXMLForumType;
end;

function TXMLLinkType.Get_Member: IXMLMemberType;
begin
  Result := ChildNodes['Member'] as IXMLMemberType;
end;

{ TXMLLinkTypeList }

function TXMLLinkTypeList.Add: IXMLLinkType;
begin
  Result := AddItem(-1) as IXMLLinkType;
end;

function TXMLLinkTypeList.Insert(const Index: Integer): IXMLLinkType;
begin
  Result := AddItem(Index) as IXMLLinkType;
end;

function TXMLLinkTypeList.Get_Item(Index: Integer): IXMLLinkType;
begin
  Result := List[Index] as IXMLLinkType;
end;

{ TXMLNewsType }

function TXMLNewsType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLNewsType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLNewsType.Get_DateTime: Integer;
begin
  Result := ChildNodes['DateTime'].NodeValue;
end;

procedure TXMLNewsType.Set_DateTime(Value: Integer);
begin
  ChildNodes['DateTime'].NodeValue := Value;
end;

function TXMLNewsType.Get_Title: WideString;
begin
  Result := ChildNodes['Title'].Text;
end;

procedure TXMLNewsType.Set_Title(Value: WideString);
begin
  ChildNodes['Title'].NodeValue := Value;
end;

{ TXMLNewsTypeList }

function TXMLNewsTypeList.Add: IXMLNewsType;
begin
  Result := AddItem(-1) as IXMLNewsType;
end;

function TXMLNewsTypeList.Insert(const Index: Integer): IXMLNewsType;
begin
  Result := AddItem(Index) as IXMLNewsType;
end;

function TXMLNewsTypeList.Get_Item(Index: Integer): IXMLNewsType;
begin
  Result := List[Index] as IXMLNewsType;
end;

{ TXMLForumInfoType }

function TXMLForumInfoType.Get_Name: WideString;
begin
  Result := ChildNodes['Name'].Text;
end;

procedure TXMLForumInfoType.Set_Name(Value: WideString);
begin
  ChildNodes['Name'].NodeValue := Value;
end;

function TXMLForumInfoType.Get_ID: Integer;
begin
  Result := ChildNodes['ID'].NodeValue;
end;

procedure TXMLForumInfoType.Set_ID(Value: Integer);
begin
  ChildNodes['ID'].NodeValue := Value;
end;

function TXMLForumInfoType.Get_ParentID: Integer;
begin
  Result := ChildNodes['ParentID'].NodeValue;
end;

procedure TXMLForumInfoType.Set_ParentID(Value: Integer);
begin
  ChildNodes['ParentID'].NodeValue := Value;
end;

{ TXMLForumInfoTypeList }

function TXMLForumInfoTypeList.Add: IXMLForumInfoType;
begin
  Result := AddItem(-1) as IXMLForumInfoType;
end;

function TXMLForumInfoTypeList.Insert(const Index: Integer): IXMLForumInfoType;
begin
  Result := AddItem(Index) as IXMLForumInfoType;
end;

function TXMLForumInfoTypeList.Get_Item(Index: Integer): IXMLForumInfoType;
begin
  Result := List[Index] as IXMLForumInfoType;
end;

{ TXMLString_List }

function TXMLString_List.Add(const Value: WideString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := Value;
end;


function TXMLString_List.Insert(const Index: Integer; const Value: WideString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := Value;
end;


function TXMLString_List.Get_Item(Index: Integer): WideString;
begin
  Result := List[Index].NodeValue;
end;

end.

