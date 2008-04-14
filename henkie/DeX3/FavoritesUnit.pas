unit FavoritesUnit;

interface

uses
  Classes, ContNrs, VirtualTrees, XMLDoc, XMLIntf;

type
  TFavoritesSortType = (stThread, stMember, stForum, stDateTime);

  TGroup = class
  private
    fID: integer;
    fCaption: string;
    fExpanded: boolean;
    fSelected: boolean;
    fDeleted: boolean;
  public
    property Caption: string read fCaption write fCaption;
    property Deleted: boolean read fDeleted write fDeleted;
    property Expanded: boolean read fExpanded write fExpanded;
    property ID: integer read fID write fID;
    property Selected: boolean read fSelected write fSelected;
  end;

  TGroupsList = class(TObjectList)
  private
    fOnDataChange: TNotifyEvent;
    fXmlDocument: IXmlDocument;
    fFileName: string;
    fUpdateCount: integer;
    function GenerateUniqueID: integer;
    function GetCount: integer;
    procedure SetCount(const Value: integer);
  protected
    function GetItem(Index: Integer): TGroup;
    procedure SetItem(Index: Integer; AObject: TGroup);
    procedure DoDataChange; virtual;
    function InitXMLDocument: boolean;
  public
    function Add(AObject: TGroup): Integer;
    function Remove(AObject: TGroup): Integer;
    function IndexOf(AObject: TGroup): Integer;
    procedure Insert(Index: Integer; AObject: TGroup);
    property Items[Index: Integer]: TGroup read GetItem write SetItem; default;
    procedure LoadFromFile(FileName: string);
    procedure SaveToFile(FileName: string);
    procedure BeginUpdate;
    procedure EndUpdate;
    property Count: integer read GetCount write SetCount;
    property OnDataChange: TNotifyEvent read fOnDataChange write fOnDataChange;
  end;

  TFavorite = class
  private
    fIconID: integer;
    fMembername: string;
    fForumName: string;
    fID: integer;
    fDateTime: int64;
    fThreadName: string;
    fGroupID: integer;
    fSelected: boolean;
    fDeleted: boolean;
  public
    property DateTime: int64 read fDateTime write fDateTime;
    property Deleted: boolean read fDeleted write fDeleted;
    property ForumName: string read fForumName write fForumName;
    property GroupID: integer read fGroupID write fGroupID;
    property IconID: integer read fIconID write fIconID;
    property ID: integer read fID write fID;
    property MemberName: string read fMembername write fMemberName;
    property ThreadName: string read fThreadName write fThreadName;
    property Selected: boolean read fSelected write fSelected;
  end;

  TFavoritesList = class(TObjectList)
  private
    fOnDataChange: TNotifyEvent;
    fXmlDocument: IXMLDocument;
    fFileName: string;
    fUpdateCount: integer;
    fSortType: TFavoritesSortType;
    fSortDirection: integer;
    function GetCount: integer;
    procedure SetCount(const Value: integer);
  protected
    function GetItem(Index: Integer): TFavorite;
    procedure SetItem(Index: Integer; AObject: TFavorite);
    procedure DoDataChange; virtual;
    function InitXMLDocument: boolean;
  public
    constructor Create(AOwnsObjects: Boolean);
    function Add(AObject: TFavorite): Integer;
    function Remove(AObject: TFavorite): Integer;
    function IndexOf(AObject: TFavorite): Integer;
    procedure Insert(Index: Integer; AObject: TFavorite);
    property Items[Index: Integer]: TFavorite read GetItem write SetItem; default;
    procedure LoadFromFile(FileName: string);
    procedure SaveToFile(FileName: string);
    procedure BeginUpdate;
    procedure EndUpdate;
    property Count: integer read GetCount write SetCount;
    property SortType: TFavoritesSortType read fSortType write fSortType;
    property SortDirection: integer read fSortDirection write fSortDirection;
    property OnDataChange: TNotifyEvent read fOnDataChange write fOnDataChange;
  end;

  TNodeType = (ntGroup, ntFavorite);

  pFavoritesNodeData = ^TFavoritesNodeData;
  TFavoritesNodeData = record
    ListIndex: integer;
    NodeType: TNodeType;
  end;

implementation

uses
  Sysutils;

{ TFavoritesList }

constructor TFavoritesList.Create(AOwnsObjects: Boolean);
begin
  inherited;
  fSortDirection := 1;
end;

function TFavoritesList.IndexOf(AObject: TFavorite): Integer;
begin
  Result := inherited IndexOf(AObject);
end;


function TFavoritesList.Add(AObject: TFavorite): Integer;
begin
  Result := inherited Add(AObject);
end;

function TFavoritesList.GetItem(Index: Integer): TFavorite;
begin
  Result := TFavorite(inherited Items[Index]);
end;

procedure TFavoritesList.SetItem(Index: Integer; AObject: TFavorite);
begin
  inherited Items[Index] := AObject;
end;

function TFavoritesList.Remove(AObject: TFavorite): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TFavoritesList.Insert(Index: Integer; AObject: TFavorite);
begin
  inherited Insert(Index, AObject);
end;

procedure TFavoritesList.DoDataChange;
begin
  if Assigned(fOnDataChange) then
    fOnDataChange(Self)
end;

procedure TFavoritesList.SaveToFile(FileName: string);
var
  NLDelphiXMLNode: IXMLNode;
  FavoriteXMLNode, favoriteNode, Node: IXMLNode;
  Index: integer;
  Favorite: TFavorite;
begin
  fFileName := FileName;
  if not InitXMLDocument then
    Exit;
  NLDelphiXMLNode := fXMLDocument.DocumentElement;
  if not Assigned(NLDelphiXMLNode) then
    NLDelphiXMLNode := fXmlDocument.AddChild('NLDelphiData');
  FavoriteXMLNode := NLDelphiXMLNode.ChildNodes.FindNode('Favorites');
  if Assigned(FavoriteXMLNode) then
    FavoriteXMLNode.ChildNodes.Clear
  else
    FavoriteXMLNode := NLDelphiXMLNode.AddChild('Favorites');
  for Index := 0 to Pred(Count) do
  begin
    Favorite := Items[Index];
    if Favorite.Deleted then
      Continue;
    FavoriteNode := FavoriteXMLNode.AddChild('Favorite');
    Node := FavoriteNode.AddChild('DateTime');
    Node.Text := IntToStr(Favorite.DateTime);
    Node := FavoriteNode.AddChild('ForumName');
    Node.Text := favorite.ForumName;
    Node := FavoriteNode.AddChild('GroupID');
    Node.Text := IntToStr(Favorite.GroupID);
    Node := FavoriteNode.AddChild('IconID');
    Node.Text := IntToStr(Favorite.IconID);
    Node := FavoriteNode.AddChild('ID');
    Node.Text := IntToStr(Favorite.ID);
    Node := FavoriteNode.AddChild('MemberName');
    Node.Text := favorite.MemberName;
    Node := FavoriteNode.AddChild('ThreadName');
    Node.Text := favorite.ThreadName;
  end;
  fXmlDocument.SaveToFile(FileName);
end;

procedure TFavoritesList.LoadFromFile(FileName: string);
var
  NLDelphiXMLNode, FavoriteXMLNode, FavoriteNode: IXMLNode;
  Favorite: TFavorite;
  FavoriteDateTime: int64;
  FavoriteForumName, FavoriteMemberName, FavoriteThreadName: string;
  FavoriteGroupID, FavoriteIconID, FavoriteID: integer;
begin
  fFileName := FileName;
  if not InitXMLDocument then
    Exit;
  Clear;
  NLDelphiXMLNode := fXMLDocument.DocumentElement;
  if not Assigned(NLDelphiXMLNode) then
    Exit;
  FavoriteXMLNode := NLDelphiXMLNode.ChildNodes.FindNode('Favorites');
  if not Assigned(FavoriteXMLNode) then
    Exit;
  FavoriteNode := FavoriteXMLNode.ChildNodes.FindNode('Favorite');
  while Assigned(FavoriteNode) do
  begin
    FavoriteForumName := FavoriteNode.ChildNodes['ForumName'].Text;
    FavoriteGroupID := StrToInt(FavoriteNode.ChildNodes['GroupID'].Text);
    FavoriteIconID := StrToint(FavoriteNode.ChildNodes['IconID'].Text);
    FavoriteID := StrToint(FavoriteNode.ChildNodes['ID'].Text);
    FavoriteMemberName := FavoriteNode.ChildNodes['MemberName'].Text;
    FavoriteThreadName := FavoriteNode.ChildNodes['ThreadName'].Text;
    FavoriteDateTime := StrToInt(FavoriteNode.ChildNodes['DateTime'].Text);
    Favorite := TFavorite.Create;
    with Favorite do
    begin
      DateTime := FavoriteDateTime;
      Forumname := FavoriteForumName;
      GroupID := FavoriteGroupID;
      IconID := FavoriteIconID;
      ID := FavoriteID;
      MemberName := FavoriteMemberName;
      ThreadName := FavoriteThreadName;
    end;
    Add(Favorite);
    FavoriteNode := FavoriteNode.NextSibling;
  end;
  DoDataChange;
end;

function TFavoritesList.InitXMLDocument: boolean;
begin
  Result := FileExists(fFileName);
  if Result then
    fXmlDocument := LoadXMLDocument(fFileName);
end;

procedure TFavoritesList.EndUpdate;
begin
  if fUpdateCount <= 0 then
    Exit;
  Dec(fUpdateCount);
  if fUpdateCount = 0 then
    DoDataChange;
end;

procedure TFavoritesList.BeginUpdate;
begin
  Inc(fUpdateCount);
end;

function TFavoritesList.GetCount: integer;
var
  Index: integer;
begin
  Result := 0;
  for Index := 0 to Pred(TList(Self).Count) do
    if not Self[Index].Deleted then
      Inc(Result);
end;

procedure TFavoritesList.SetCount(const Value: integer);
begin
  //
end;

{ TGoupsList }

function TGroupsList.IndexOf(AObject: TGroup): Integer;
begin
  Result := inherited IndexOf(AObject);
end;


function TGroupsList.Add(AObject: TGroup): Integer;
begin
  if aObject.ID = 0 then
    AObject.ID := GenerateUniqueID;
  Result := inherited Add(AObject);
end;

function TGroupsList.GetItem(Index: Integer): TGroup;
begin
  Result := TGroup(inherited Items[Index]);
end;

procedure TGroupsList.SetItem(Index: Integer; AObject: TGroup);
begin
  inherited Items[Index] := AObject;
end;

function TGroupsList.Remove(AObject: TGroup): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TGroupsList.Insert(Index: Integer; AObject: TGroup);
begin
  if aObject.ID = 0 then
    AObject.ID := GenerateUniqueID;
  inherited Insert(Index, AObject);
end;

procedure TGroupsList.DoDataChange;
begin
  if Assigned(fOnDataChange) then
    fOnDataChange(Self)
end;

procedure TGroupsList.SaveToFile(FileName: string);
var
  NLDelphiXMLNode: IXMLNode;
  GroupXMLNode, GroupNode, Node: IXMLNode;
  Index: integer;
  Group: TGroup;
begin
  fFileName := FileName;
  if not InitXMLDocument then
    Exit;
  NLDelphiXMLNode := fXMLDocument.DocumentElement;
  if not Assigned(NLDelphiXMLNode) then
    NLDelphiXMLNode := fXmlDocument.AddChild('NLDelphiData');
  GroupXMLNode := NLDelphiXMLNode.ChildNodes.FindNode('Groups');
  if Assigned(GroupXMLNode) then
    GroupXMLNode.ChildNodes.Clear;
  if not Assigned(GroupXMLNode) then
    GroupXMLNode := NLDelphiXMLNode.AddChild('Groups');
  for Index := 0 to Pred(Count) do
  begin
    Group := Items[Index];
    if Group.Deleted then
      Continue;
    GroupNode := GroupXMLNode.AddChild('Group');
    Node := GroupNode.AddChild('Caption');
    Node.Text := Group.Caption;
    Node := GroupNode.AddChild('ID');
    Node.Text := IntToStr(Group.ID);
  end;
  fXmlDocument.SaveToFile(FileName);
end;

procedure TGroupsList.LoadFromFile(FileName: string);
var
  NLDelphiXMLNode, GroupXMLNode, GroupNode: IXMLNode;
  Group: TGroup;
  GroupID: integer;
  GroupCaption: string;
begin
  fFileName := FileName;
  if not InitXMLDocument then
    Exit;
  Clear;
  NLDelphiXMLNode := fXMLDocument.DocumentElement;
  if not Assigned(NLDelphiXMLNode) then
    Exit;
  GroupXMLNode := NLDelphiXMLNode.ChildNodes.FindNode('Groups');
  if not Assigned(GroupXMLNode) then
    Exit;
  GroupNode := GroupXMLNode.ChildNodes.FindNode('Group');
  while Assigned(GroupNode) do
  begin
    GroupCaption := GroupNode.ChildNodes['Caption'].Text;
    if GroupCaption = '' then
    begin
      GroupNode := GroupNode.NextSibling;
      Continue;
    end;
    GroupID := StrToInt(GroupNode.ChildNodes['ID'].Text);
    Group := TGroup.Create;
    Group.Caption := GroupCaption;
    Group.ID := GroupID;
    Add(Group);
    GroupNode := GroupNode.NextSibling;
  end;
  DoDataChange;
end;

function TGroupsList.InitXMLDocument: boolean;
begin
  Result := FileExists(fFileName);
  if Result then
    fXmlDocument := LoadXMLDocument(fFileName);
end;

procedure TGroupsList.EndUpdate;
begin
  if fUpdateCount <= 0 then
    Exit;
  Dec(fUpdateCount);
  if fUpdateCount = 0 then
    DoDataChange;
end;

procedure TGroupsList.BeginUpdate;
begin
  Inc(fUpdateCount);
end;

function TGroupsList.GenerateUniqueID: integer;
var
  StringList: TStringList;
  ID: integer;
  aPointer: pointer;
begin
  StringList := TStringList.Create;
  try
    for aPointer in Self do
    begin
      StringList.Add(IntToStr(TGroup(aPointer).ID));
    end;
    Result := 0;
    repeat
      Inc(Result);
      ID := StringList.IndexOf(IntToStr(Result));
    until ID = -1;
  finally
    StringList.Free;
  end;
end;

function TGroupsList.GetCount: integer;
var
  Index: integer;
begin
  Result := 0;
  for Index := 0 to Pred(TList(Self).Count) do
    if not Self[Index].Deleted then
      Inc(Result);
end;

procedure TGroupsList.SetCount(const Value: integer);
begin
  //
end;

end.
