unit NLDXMLData;

interface

uses
  Windows, Messages, SysUtils, Classes, NLDXMLIntf, ExtCtrls, XMLDoc,
  xmldom, Contnrs;

type
  TNLDXMLData = class;
  TPosts = class;

  TSortType = (stDateTime, stForum, stMember, stThread);

  TPostItem = class
  private
    FThreadName: string;
    FForumName: string;
    FMemberName: string;
    FDateTime: Int64;
    FPost: IXMLPostType;
    FPostList: TPosts;
  public
    property DateTime: Int64 read FDateTime write FDateTime;
    property MemberName: string read FMemberName write FMemberName;
    property ForumName: string read FForumName write FForumName;
    property ThreadName: string read FThreadName write FThreadName;
    property Post: IXMLPostType read FPost write FPost;
    property PostList: TPosts read FPostList write FPostList;

    constructor Create(PostList: TPosts; Post: IXMLPostType);
  end;

  TPosts = class(TObjectList)
  private
    FTracker: TNLDXMLData;
    FSortDirection: Integer;
    FSortType: TSortType;
    function GetItem(Index: Integer): TPostItem;
    procedure SetItem(Index: Integer; const Value: TPostItem);
  public
    procedure Sort;
    property Items[Index: Integer]: TPostItem
      read GetItem write SetItem; default;
    property Tracker: TNLDXMLData read FTracker;
    property SortType: TSortType read FSortType write FSortType;
    property SortDirection: Integer read FSortDirection write FSortDirection;

    constructor Create;
  end;

  TOnNewData = procedure(Sender: TObject;
    NewData: IXMLNLDelphiDataType) of object;
  TOnError = procedure(Sender: TObject; const Error: string) of object;

  TTrackXMLDocument = class(TXMLDocument)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TNLDXMLData = class(TComponent)
  private
    FOnNewData: TOnNewData;
    FBeforeUpdate: TNotifyEvent;
    FAfterUpdate: TNotifyEvent;
    FURL: string;
    FTimer: TTimer;
    FOnError: TOnError;
    FData: IXMLNLDelphiDataType;
    FOnDataChange: TNotifyEvent;
    FIgnoreUser: string;
    FUpdateTimer: Integer;
    FPosts: TPosts;
    FChangeCount: Integer;
    FUserAgent: string;
    FTimeDiff: Int64;
    FSessionID: string;
    procedure ThreadAfterGet(Sender: TObject);
    procedure Timer(Sender: TObject);
    procedure MergeData(NewData: IXMLNLDelphiDataType);
    function FindForum(ForumID: Integer): IXMLForumType;
    function FindThread(Forum: IXMLForumType;
      ThreadID: Integer): IXMLThreadType;
    procedure SetUpdateTimer(const Value: Integer);
    function GetConnected: Boolean;
    procedure LoadForumInfo;
  protected
    procedure DoDataChange; virtual;
    procedure SyncPosts;
    procedure GetTimeDiff;
  public
    function FindPost(Thread: IXMLThreadType;
      PostID: Integer): IXMLPostType; overload;
    function FindPost(PostID: Integer): IXMLPostType; overload;
    procedure Update(DateTime: Integer = 0);
    procedure LoadFromFile(const FileName: string);
    procedure DeletePost(Index: Integer); overload;
    procedure DeletePost(Post: IXMLPostType); overload;
    procedure DeleteThread(Thread: IXMLThreadType); overload;
    procedure DeleteThread(Post: IXMLPostType); overload;
    procedure SaveToFile(const FileName: string);
    procedure BeginUpdate;
    procedure EndUpdate;
    function Login(const UserName, Password, Location: string;
      var Error: string): Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Data: IXMLNLDelphiDataType read FData;
    property Posts: TPosts read FPosts;
    property Connected: Boolean read GetConnected;
    procedure Disconnect;
  published
    property OnNewData: TOnNewData read FOnNewData write FOnNewData;
    property OnError: TOnError read FOnError write FOnError;
    property UpdateTimer: Integer read FUpdateTimer write SetUpdateTimer;
    property URL: string read FURL write FURL;
    property IgnoreUser: string read FIgnoreUser write FIgnoreUser;
    property OnDataChange: TNotifyEvent read FOnDataChange write FOnDataChange;
    property BeforeUpdate: TNotifyEvent read FBeforeUpdate write FBeforeUpdate;
    property AfterUpdate: TNotifyEvent read FAfterUpdate write FAfterUpdate;
    property UserAgent: string read FUserAgent write FUserAgent;
  end;

procedure Register;

implementation

uses
  GetDataU, DateUtils,
{$IFDEF LOg}
  Udbg,
{$ENDIF}
  XMLIntf, IdHTTP;
procedure Register;
begin
  RegisterComponents('NLDelphi', [TNLDXMLData]);
end;

{ TNLDXMLData }

constructor TNLDXMLData.Create(AOwner: TComponent);
begin
  inherited;
  FSessionID := '';
  FTimer := TTimer.Create(self);
  FTimer.Enabled := False;
  FTimer.OnTimer := Timer;
  FData := NewNLDelphiData;
  FPosts := TPosts.Create;
  FTimeDiff := -1;
end;

destructor TNLDXMLData.Destroy;
begin
  FTimer.Free;
  FPosts.Free;
  inherited;
end;

procedure TNLDXMLData.DoDataChange;
begin
{$IFDEF Log}
  Debugger.EnterProc('TNLDXMLData.DoDataChange');
{$ENDIF}

  if FChangeCount = 0 then
  begin
    SyncPosts;
    Posts.Sort;

    if Assigned(FOnDataChange) then
      FOnDataChange(Self);
  end;

{$IFDEF Log}
  Debugger.LeaveProc('TNLDXMLData.DoDataChange');
{$ENDIF}
end;

procedure TNLDXMLData.LoadFromFile(const FileName: string);
begin
{$IFDEF Log}
  Debugger.EnterProc('TNLDXMLData.LoadFromFile');
  Debugger.LogMsg(FileName);
{$ENDIF}

  if FileExists(FileName) then
  begin
    FData := LoadNLDelphiData(FileName);
    SyncPosts;
    DoDataChange;
  end;

{$IFDEF Log}
  Debugger.LeaveProc('TNLDXMLData.LoadFromFile');
{$ENDIF}
end;

procedure TNLDXMLData.SaveToFile(const FileName: string);
var
  SaveDocument: TTrackXMLDocument;
begin
{$IFDEF Log}
  Debugger.EnterProc('TNLDXMLData.SaveToFile');
  Debugger.LogMsg(FileName);
{$ENDIF}
  SaveDocument := TTrackXMLDocument.Create(self);
  try
    SaveDocument.LoadFromXML(FData.XML);

    if not SaveDocument.IsEmptyDoc then
    begin
      DeleteFile(FileName);
      SaveDocument.SaveToFile(FileName);
    end;
  finally
    SaveDocument.Free;
  end;
{$IFDEF Log}
  Debugger.LeaveProc('TNLDXMLData.SaveToFile');
{$ENDIF}
end;

procedure TNLDXMLData.MergeData(NewData: IXMLNLDelphiDataType);

  function AddPost(Thread: IXMLThreadType; Post: IXMLPostType): IXMLPostType;
  begin
    Result := Thread.Post.Add;
    Result.DateTime := Post.DateTime + FTimeDiff;
    Result.ID := Post.ID;
    Result.IconID := Post.IconID;
    Result.Member.ID := Post.Member.ID;
    Result.Member.Name := Post.Member.Name;
  end;

  function AddThread(Forum: IXMLForumType; Thread: IXMLThreadType): IXMLThreadType;
  var
    i: Integer;
  begin
    Result := Forum.Thread.Add;
    Result.Title := Thread.Title;
    Result.ID := Thread.ID;
    Result.IconID := Thread.IconID;
    Result.Member.ID := Thread.Member.ID;
    Result.Member.Name := Thread.Member.Name;

    for i := 0 to Thread.Post.Count - 1 do
      AddPost(Result, Thread.Post[i]);
  end;

  function AddForum(Forum: IXMLForumType): IXMLForumType;
  var
    i: Integer;
  begin
    Result := FData.Forum.Add;
    Result.Title := Forum.Title;
    Result.ID := Forum.ID;

    for i := 0 to Forum.Thread.Count - 1 do
      AddThread(Result, Forum.Thread[i]);
  end;

var
  i, ForumIndex, ThreadIndex, PostIndex: Integer;
  Forum, NewForum: IXMLForumType;
  Thread, NewThread: IXMLThreadType;
begin
{$IFDEF Log}
  Debugger.EnterProc('TNLDXMLData.MergeData');
{$ENDIF}

  for ForumIndex := 0 to NewData.Forum.Count - 1 do
  begin
    NewForum := NewData.Forum[ForumIndex];
    Forum := FindForum(NewForum.ID);

    if Forum = nil then
      AddForum(NewForum)
    else
      for ThreadIndex := 0 to NewForum.Thread.Count - 1 do
      begin
        NewThread := NewForum.Thread[ThreadIndex];
        Thread := FindThread(Forum, NewThread.ID);

        if Thread = nil then
          AddThread(Forum, NewThread)
        else
          for PostIndex := 0 to NewThread.Post.Count - 1 do
            if FindPost(Thread, NewThread.Post[PostIndex].ID) = nil then
              AddPost(Thread, NewThread.Post[PostIndex]);
      end;
  end;

  for i := 0 to NewData.PM.Count - 1 do
  begin
    with FData.PM.Add do
    begin
      ID := NewData.PM[i].ID;
      Title := NewData.PM[i].Title;
      Member.ID := NewData.PM[i].Member.ID;
      Member.Name := NewData.PM[i].Member.Name;
      DateTime := NewData.PM[i].DateTime;
    end;
  end;

  for i := 0 to NewData.Link.Count - 1 do
  begin
    with FData.Link.Add do
    begin
      ID := NewData.Link[i].ID;
      Title := NewData.Link[i].Title;
      DateTime := NewData.Link[i].DateTime;
      Forum.ID := NewData.Link[i].Forum.ID;
      Forum.Title := NewData.Link[i].Forum.Title;
      Member.ID := NewData.Link[i].Member.ID;
      Member.Name := NewData.Link[i].Member.Name;
    end;
  end;

  for i := 0 to NewData.News.Count - 1 do
  begin
    with FData.News.Add do
    begin
      ID := NewData.News[i].ID;
      Title := NewData.News[i].Title;
      DateTime := NewData.News[i].DateTime;
    end;
  end;

  SyncPosts;
{$IFDEF Log}
  Debugger.LeaveProc('TNLDXMLData.MergeData');
{$ENDIF}
end;

function TNLDXMLData.FindForum(ForumID: Integer): IXMLForumType;
var
  ForumIndex: Integer;
begin
  Result := nil;

  for ForumIndex := 0 to FData.Forum.Count - 1 do
    if FData.Forum[ForumIndex].ID = ForumID then
    begin
      Result := FData.Forum[ForumIndex];
      Break;
    end;
end;

function TNLDXMLData.FindThread(Forum: IXMLForumType;
  ThreadID: Integer): IXMLThreadType;
var
  ThreadIndex: Integer;
begin
  Result := nil;

  for ThreadIndex := 0 to Forum.Thread.Count - 1 do
    if Forum.Thread[ThreadIndex].ID = ThreadID then
    begin
      Result := Forum.Thread[ThreadIndex];
      Break;
    end;
end;

function TNLDXMLData.FindPost(Thread: IXMLThreadType;
  PostID: Integer): IXMLPostType;
var
  PostIndex: Integer;
begin
  Result := nil;

  for PostIndex := 0 to Thread.Post.Count - 1 do
    if Thread.Post[PostIndex].ID = PostID then
    begin
      Result := Thread.Post[PostIndex];
      Break;
    end;
end;

procedure TNLDXMLData.ThreadAfterGet(Sender: TObject);
var
  NewData: IXMLNLDelphiDataType;
  UpdateDocument: TTrackXMLDocument;
begin
{$IFDEF Log}
  Debugger.EnterProc('TNLDXMLData.ThreadAfterGet');
  Debugger.LogString('XML data: ', TGetData(Sender).XMLText);
{$ENDIF}

  if Assigned(FAfterUpdate) then
  begin
{$IFDEF name}
    Debugger.LogMsg('Start AfterUpdate');
{$ENDIF}
    FAfterUpdate(Self);
{$IFDEF Log}
    Debugger.LogMsg('Einde AfterUpdate');
{$ENDIF}
  end;

{$IFDEF Log}
  Debugger.LogMsg('Controleren op error');
{$ENDIF}

  if TGetData(Sender).Error <> '' then
  begin
{$IFDEF Log}
    Debugger.LogError(TGetData(Sender).Error);
{$ENDIF}

    if Assigned(FOnError) then
      FOnError(Self, TGetData(Sender).Error);
  end;

{$IFDEF Log}
  Debugger.LogMsg('XMLDocument maken');
{$ENDIF}
  UpdateDocument := TTrackXMLDocument.Create(self);
  try
    UpdateDocument.XML.Text := TGetData(Sender).XMLText;
    NewData := GetNLDelphiData(UpdateDocument);

    if NewData.Error.Text <> '' then
    begin
{$IFDEF Log}
      Debugger.LogError(NewData.Error.Text);
{$ENDIF}

      if Assigned(FOnError) then
        FOnError(Self, NewData.Error.Text);
    end;

    if NewData.Forum.Count > 0 then
    begin
{$IFDEF Log}
      Debugger.LogMsg(Format('%d regels opgehaald', [NewData.RowCount]));
{$ENDIF}

      if Assigned(FOnNewData) then
      begin
{$IFDEF Log}
        Debugger.LogMsg('Start OnNewData');
{$ENDIF}
        FOnNewData(Self, NewData);
{$IFDEF Log}
        Debugger.LogMsg('Einde OnNewData');
{$ENDIF}
      end;

      MergeData(NewData);

      DoDataChange;
    end;
  finally
    UpdateDocument.Free;
  end;

{$IFDEF Log}
  Debugger.LeaveProc('TNLDXMLData.ThreadAfterGet');
{$ENDIF}
end;

procedure TNLDXMLData.Timer(Sender: TObject);
begin
  Update;
end;

procedure TNLDXMLData.Update(DateTime: Integer = 0);
var
  FullURL: string;
begin
  if FSessionID = '' then
    Exit;

{$IFDEF Log}
  Debugger.EnterProc('TNLDXMLData.Update');
  Debugger.LogMsg('Datetime: ' + DateTimeToStr(UnixToDateTime(DateTime)));
{$ENDIF}

  FullURL := FURL + '?SessionID=' + FSessionID;

  if DateTime <> 0 then
    FullURL := FullURL + '&LastDateTime=' + IntToStr(DateTime);

  if FTimeDiff = -1 then
    GetTimeDiff;

  if Assigned(FBeforeUpdate) then
    FBeforeUpdate(Self);

  with TGetData.Create do
  begin
    UserAgent := FUserAgent;
    AfterGet := ThreadAfterGet;
    URL := FullURL;
    Resume;
  end;

{$IFDEF Log}
  Debugger.LeaveProc('TNLDXMLData.Update');
{$ENDIF}
end;

function TNLDXMLData.FindPost(PostID: Integer): IXMLPostType;
var
  ForumIndex, ThreadIndex, PostIndex: Integer;
  Forum: IXMLForumType;
  Thread: IXMLThreadType;
begin
  Result := nil;

  for ForumIndex := 0 to FData.Forum.Count - 1 do
  begin
    Forum := FData.Forum[ForumIndex];
    for ThreadIndex := 0 to Forum.Thread.Count - 1 do
    begin
      Thread := Forum.Thread[ThreadIndex];
      for PostIndex := 0 to Thread.Post.Count - 1 do
        if Thread.Post[PostIndex].ID = PostID then
        begin
          Result := Thread.Post[PostIndex];
          Break;
        end;
    end;
  end;
end;

procedure TNLDXMLData.DeletePost(Index: Integer);
var
  Post: IXMLPostType;
begin
{$IFDEF Log}
  Debugger.EnterProc('TNLDXMLData.DeletePost');
{$ENDIF}

  Post := Posts[Index].Post;
  DeletePost(Post);

{$IFDEF Log}
  Debugger.LeaveProc('TNLDXMLData.DeletePost');
{$ENDIF}
end;

procedure TNLDXMLData.DeletePost(Post: IXMLPostType);
var
 Thread: IXMLThreadType;
begin
  Thread := (Post.ParentNode as IXMLThreadType);
  Thread.Post.Remove(Post);

  if Thread.Post.Count = 0 then
    DeleteThread(Thread);

  DoDataChange;
end;

procedure TNLDXMLData.DeleteThread(Thread: IXMLThreadType);
var
  Forum: IXMLForumType;
begin
  Forum := Thread.ParentNode as IXMLForumType;
  Forum.Thread.Remove(Thread);
  DoDataChange;
end;

procedure TNLDXMLData.DeleteThread(Post: IXMLPostType);
begin
  DeleteThread(Post.ParentNode as IXMLThreadType);
end;


procedure TNLDXMLData.SetUpdateTimer(const Value: Integer);
begin
  FUpdateTimer := Value;

  if not (csDesigning in ComponentState) then
  begin
    FTimer.Interval := FUpdateTimer;
    FTimer.Enabled := FUpdateTimer > 0;
  end;
end;

procedure TNLDXMLData.SyncPosts;
var
  ForumIndex, ThreadIndex, PostIndex: Integer;
  Forum: IXMLForumType;
  Thread: IXMLThreadType;
begin
  FPosts.Clear;

  for ForumIndex := 0 to FData.Forum.Count - 1 do
  begin
    Forum := FData.Forum[ForumIndex];
    for ThreadIndex := 0 to Forum.Thread.Count - 1 do
    begin
      Thread := Forum.Thread[ThreadIndex];
      for PostIndex := 0 to Thread.Post.Count - 1 do
        FPosts.Add(TPostItem.Create(Posts, Thread.Post[PostIndex]));
    end;
  end;
end;

procedure TNLDXMLData.BeginUpdate;
begin
  Inc(FChangeCount);
end;

procedure TNLDXMLData.EndUpdate;
begin
  if FChangeCount > 0 then
  begin
    Dec(FChangeCount);

    if FChangeCount = 0 then
      DoDataChange;
  end;
end;

procedure TNLDXMLData.GetTimeDiff;
var
  ServerTime: string;
begin
  try
    with TIdHTTP.Create(Self) do
    try
      ServerTime := get(FURL + '/servertime');
      FTimeDiff := DateTimeToUnix(Now) - StrToInt(ServerTime);
    finally
      Free;
    end;
  except;
  end;
end;

function TNLDXMLData.Login(const UserName, Password, Location: string;
  var Error: string): Boolean;
var
  UpdateDocument: TTrackXMLDocument;
  NewData: IXMLNLDelphiDataType;
begin
 
  if (UserName = '') or (Password = '') then
  begin
    Result := False;
    Exit;
  end;


  UpdateDocument := TTrackXMLDocument.Create(self);
  try
    try
      with TIdHTTP.Create(Self) do
      try
        UpdateDocument.XML.Text :=
          Get(FURL + Format('/login?username=%s&password=%s&location=%s',
            [UserName, Password, Location]));

        NewData := GetNLDelphiData(UpdateDocument);
        Result := NewData.Error.Text = '';
        Error := NewData.Error.Text;

        if Result then
          FSessionID := NewData.SessionID;
      finally
        Free;
      end;
    except;
      Result := False;
      raise;
    end;
  finally
    UpdateDocument.Free;
  end;

  if Result then
    LoadForumInfo;
end;

procedure TNLDXMLData.LoadForumInfo;
var
  UpdateDocument: TTrackXMLDocument;
  ForumInfo: IXMLForumInfoTypeList;
  i: Integer;
begin
  Data.ForumInfo.Clear;

  UpdateDocument := TTrackXMLDocument.Create(self);
  try
    with TIdHTTP.Create(Self) do
    try
      UpdateDocument.XML.Text := Get(FURL + '/ForumInfo' + '?SessionID=' + FSessionID);
    finally
      Free;
    end;

    ForumInfo := GetNLDelphiData(UpdateDocument).ForumInfo;

    for i := 0 to ForumInfo.Count - 1 do
      with Data.ForumInfo.Add do
      begin
        ID := ForumInfo[i].ID;
        Name := ForumInfo[i].Name;
        ParentID := ForumInfo[i].ParentID;
      end;

  finally
    UpdateDocument.Free;
  end;
end;

function TNLDXMLData.GetConnected: Boolean;
begin
  Result := FSessionID <> '';
end;


procedure TNLDXMLData.Disconnect;
begin
  FSessionID := '';
end;

{ TTrackXMLDocument }

constructor TTrackXMLDocument.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DOMVendor := DOMVendors.Find('MSXML');
end;

constructor TPosts.Create;
begin
  inherited;
  FSortDirection := 1;
end;

function TPosts.GetItem(Index: Integer): TPostItem;
begin
  Result := TPostItem(inherited Items[Index]);
end;

procedure TPosts.SetItem(Index: Integer; const Value: TPostItem);
begin
  inherited Items[Index] := Value;
end;

function Compare(Item1, Item2: Pointer): Integer;
var
  Post1, Post2: TPostItem;
begin
  Result := 0;

  Post1 := TPostItem(Item1);
  Post2 := TPostItem(Item2);

  if Post1.PostList.SortType = stDateTime then
  begin
    if Post1.DateTime = Post2.DateTime then
      Result  := 0
    else if Post1.DateTime > Post2.DateTime then
      Result := 1
    else
      Result := -1;
  end
  else if Post1.PostList.SortType = stForum then
  begin
    if Post1.ForumName = Post2.ForumName then
      Result  := 0
    else if Post1.ForumName > Post2.ForumName then
      Result := 1
    else
      Result := -1;
  end
  else if Post1.PostList.SortType = stMember then
  begin
    if Post1.MemberName = Post2.MemberName then
      Result  := 0
    else if Post1.MemberName > Post2.MemberName then
      Result := 1
    else
      Result := -1;
  end
  else if Post1.PostList.SortType = stThread then
  begin
    if Post1.ThreadName = Post2.ThreadName then
    begin
      if Post1.DateTime = Post2.DateTime then
        Result  := 0
      else if Post1.DateTime > Post2.DateTime then
        Result := 1
      else
        Result := -1;
    end
    else if Post1.ThreadName > Post2.ThreadName then
      Result := 1
    else
      Result := -1;
  end;

  Result := Result * Post1.PostList.SortDirection;
end;

procedure TPosts.Sort;
begin
  inherited Sort(Compare);
end;

{ TPostItem }

constructor TPostItem.Create(PostList: TPosts; Post: IXMLPostType);
begin
  inherited Create;
  FPost := Post;
  FPostList := PostList;
  FThreadName := (Post.ParentNode as IXMLThreadType).Title;
  FForumName := (Post.ParentNode.ParentNode as IXMLForumType).Title;
  FMemberName := Post.Member.Name;
  FDateTime := FPost.DateTime;
end;

end.

