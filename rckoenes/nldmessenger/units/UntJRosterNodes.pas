{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntJRosterNodes;

{*******************************************************************************
* In this unit the classes that will hold the roster elements are declared     *
* Each element has it own collection with its own options.                     *
* The main TCollectionItem is TJRosterItem.                                    *
* Which will all have the following optionS                                    *
* The collections are as followed:                                             *
*   FJID  : wideString;                                                        *
*   Pnode : PVirtualNode;                                                      *
*                                                                              *
* TJGroups                                                                     *
*       |-*TJGroupItem                                                          *
*                                                                              *
* TJContacts                                                                   *
*       |-*TJContact                                                            *
*              |-TJResources                                                   *
*                     |-*TJResource                                             *
*                                                                              *
* TJAgents                                                                     *
*       |-TJAgent                                                              *
*                                                                              *
* TJGroups                                                                     *
*       |-TJGroup                                                              *
*                                                                              *
* at each end of the collection there will be a pnode wich is a pointer to a   *
* RosterItem                                                                   *
*                                                                              *
*******************************************************************************}
interface

Uses
  Classes, VirtualTrees, JabberCOM_TLB, UntRoster, SysUtils;

Type

  {Forward declaration for TJContact, TJRoster}
  TJContact = Class;
  TJRoster = Class;

  {TJRosterItem}
  TJRosterItem = Class(TCollectionItem) //Default CollectItem
    Protected
      FJID    : WideString;
      FpNode  : pVirtualNode;
    Public
      Property JID  : WideString Read FJID Write FJID;
      Property Node : pVirtualNode Read FpNode;
      Procedure AddToRoster(Parent: pVirtualNode);
      Procedure RemoveFormRoster();
  end;

  {TJGroupItem}
  TJGroupItem = Class(TJRosterItem)
    Protected
      Property JID;
    Public
      Property Name : WideString Read FJID Write FJID;
      Procedure RemoveIfEmpty;
      Procedure AddToRoster;
  end;

  {TJGroups}                                                                
  TJGroups = Class (TCollection)
    private
      fJRoster : TJRoster;
      function GetItem(Index: Integer): TJGroupItem;
    Public
      property    Items[Index: Integer]: TJGroupItem read GetItem;
      property    Roster : TJRoster read fJRoster;
      function    Add(GroupName : String): TJGroupItem;
      function    IndexOf(GroupName: String): Integer;
      constructor Create(jRoster : TJRoster); reintroduce;
  end;

  {TJResource}
  TJResource = Class(TJRosterItem)
    Private
      FStatusMsg  : WideString;
      FStatus     : Integer;
      function GetJID  : WideString;
      function GetName : WideString;
    Public
      property Name       : WideString Read GetName;
      property JID        : WideString Read GetJID;
      property Resource   : WideString Read FJID;
      property Status     : Integer    Read FStatus    Write FStatus;
      property StatusMsg  : WideString Read FStatusMsg Write FStatusMsg;
  end;

  {TJResources}
  TJResources = Class(TCollection)
    Private
      FParent : TJContact;
      Function GetItem(Index: Integer): TJResource;
    Public
      property    Parent : TJContact read FParent;
      function    IndexOf(resource: WideString) : Integer;
      property    Items[Index: Integer]: TJResource read GetItem;
      function    Add: TJResource;
      Constructor Create(Parent : TJContact); reintroduce;
      procedure   AddAllToRoster(Parent: pVirtualNode);
      procedure   RemoveAllFormRoster();
  end;

  {TJContact}
  TJContact = Class(TJRosterItem)
    Private
      FName      : WideString;
      FGroup     : TJGroupItem;
      FSubType   : JabberSubscriptionType;
      FResources : TJResources;
      Function  GetGroupName : WideString;
    Public
      property Name             : WideString    read FName write FName;
      property Group            : TJGroupItem   read FGroup write FGroup;
      property GroupName        : WideString    read GetGroupName;
      property Resources        : TJResources   read FResources;
      property SubscriptionType : JabberSubscriptionType read FSubType write FSubType;
      destructor Destroy; override;
      procedure AddToRoster;
      procedure AddResource(AResource, AStatusMsg : WideString; AStatus : Integer);
      procedure DelResource(AResource : WideString);
      procedure ChangeNick(NewNick : WideString);
      procedure DeleteUser();
  end;

  {TJContacts}
  TJContacts = Class(TCollection)
    Private
      fJRoster   : TJRoster;
      FShowOffline   : Boolean;
      procedure setShowOffline(aValue : Boolean);
      function  GetItem(Index: Integer): TJContact;
    Public
      Property    ShowOffline : Boolean  read FShowOffline  write setShowOffline;
      property    JRoster     : TJRoster read fJRoster;
      procedure   removeAllFromRoster;
      procedure   addAllToRoster;
      function    Add: TJContact;
      function    IndexOf(JID: string): integer;
      property    Items[Index: Integer]: TJContact read GetItem;
      Constructor Create(JRoster : TJRoster); reintroduce;
  end;

  {TJAgent}
  TJAgent = Class(TJRosterItem)
    Private
      Fname           : WideString;
      FOnline         : Boolean;
      FStatus         : Integer;
      Fregistered     : Boolean;
      FTransport      : Boolean;
      FTransPortType  : WideString;
      FKey            : WideString;
    Public
      Property name           : WideString  Read Fname          Write Fname;
      Property Status         : Integer     Read FStatus        Write FStatus;
      Property Online         : Boolean     Read FOnline        Write FOnline;
      Property registered     : Boolean     Read Fregistered    Write Fregistered;
      Property Transport      : Boolean     Read FTransport     Write FTransport;
      Property TransPortType  : WideString  Read FTransPortType Write FTransPortType;
      Property Key            : WideString  Read FKey           Write FKey;
  end;

  {TJAgents}
  TJAgents = Class(TCollection)
    Private
      fJRoster : TJRoster;
      Node : pVirtualNode;
      fGroup : TJGroupItem;
      Function GetItem(Index: Integer): TJAgent;
    Public
      property  Items[Index: Integer]: TJAgent read GetItem;
      property  JRoster : TJRoster read fJRoster;
      constructor Create(JRoster : TJRoster); reintroduce;
      function  Add: TJAgent;
      function  IndexOf(Name : WideString) : integer;
      function  IndexOfJid(JID : WideString) : Integer;
      procedure RemoveFromRoster;
      procedure AddToRoster;
  end;

  TJRoster = Class
    private
      fGroups : TJGroups;
      fAgents : TJAgents;
      fContacts : TJContacts;
    Public
      procedure Clear;
      property Groups   : TJGroups    read fGroups;
      property Agents   : TJAgents    read fAgents;
      property Contacts : TJContacts  read fContacts;
      constructor Create(); 
      destructor Destroy(); reintroduce;
  end;


implementation

Uses  UntJabber;

{ TJRosterItem }

procedure TJRosterItem.AddToRoster(Parent: pVirtualNode);
Var
 pNode, pNodeParent : PVirtualNode;
 pData : PnodeData;
begin
  if (self.Node = NIL) then
    begin
      pNode := FrmRoster.vtRoster.AddChild(Parent,NIL);
      pData := FrmRoster.vtRoster.GetNodeData(pNode);
      pData.Data := self;
      self.FpNode := pNode;
      pNodeParent := pNode.Parent;
      if pNodeParent.ChildCount =1 then
        FrmRoster.vtRoster.expanded[pNodeParent] := True;
    end;
end;

procedure TJRosterItem.RemoveFormRoster;
begin
  if not(self.FpNode = NIL) then
  begin
   FrmRoster.vtRoster.DeleteNode(Self.Node,True);
   Self.FpNode := Nil;
  end;
end;

{ TJResource }

function TJResource.GetJID: WideString;
begin
  Result := TJResources(Self.Collection).Parent.JID;
  if self.Resource <> '' then
    Result := Result + '/' + self.Resource;
end;

function TJResource.GetName: WideString;
begin
  Result := TJResources(Self.Collection).Parent.Name;
end;

{ TJResources }

constructor TJResources.Create(Parent : TJContact);
begin
 inherited Create(TJResource);
 self.FParent := Parent;
end;

function TJResources.GetItem(Index: Integer): TJResource;
begin
  result := inherited Items[Index] as TJResource;
end;

function TJResources.Add: TJResource;
begin
 result := inherited Add as TJResource;
end;

procedure TJResources.RemoveAllFormRoster;
var
  I : Integer;
begin
  if self.Count > 0 then
   for I := 0 to Self.Count -1 do
      Self.Items[I].RemoveFormRoster;
end;

procedure TJResources.AddAllToRoster(Parent: pVirtualNode);
var
  I : Integer;
begin
  for I := 0 to Self.Count -1 do
      Self.Items[I].AddToRoster(Parent);
end;

function TJResources.IndexOf(resource: WideString): Integer;
var
  index, I : integer;
begin
  resource := WideLowerCase(resource);
  index := -1;

  for I :=0 to self.Count -1 do
    if (WideLowerCase(self.Items[I].Resource) = resource) then
      begin
        index := I;
        break;
      end;

  result := index;
end;

{ TJContact }

procedure TJContact.AddResource(AResource, AStatusMsg: WideString;
  AStatus: Integer);
var
   I, ResourceCount : Integer;
   //tmpResource : TJResource;
   tmpParent : pVirtualNode;
begin
  FrmRoster.vtRoster.BeginUpdate;

  tmpParent := self.Node;

  self.Group.AddToRoster;

   ResourceCount := Self.Resources.Count;

   I := self.Resources.IndexOf(AResource);

   if ResourceCount = 0  then
      begin
         self.RemoveFormRoster;
         tmpParent := self.Group.Node;
      end
   else
   if (ResourceCount = 1) and ( I = -1) then
      begin
         self.Resources.RemoveAllFormRoster;
         self.AddToRoster;
         tmpParent := self.Node;
         self.Resources.AddAllToRoster(tmpParent);
      end;

   if (I = -1) then
      With self.Resources.Add do
      begin
         fJID := AResource;
         Status := AStatus;
         StatusMsg := AStatusMsg;
         AddToRoster(tmpParent);
      end
   else
      with self.Resources.Items[I] do
      begin
         Status := AStatus;
         StatusMsg := AStatusMsg;
      end;

  FrmRoster.vtRoster.EndUpdate;
end;

procedure TJContact.AddToRoster;
begin
  if self.FSubType = jstFrom then exit;

  self.Group.AddToRoster;
  Inherited AddToRoster(self.Group.Node);
end;



procedure TJContact.ChangeNick(NewNick : WideString);
var
 I : Integer;
begin
For I :=0 to DmJabber.JabberSession.Roster.Count -1 do
  begin
     if WideLowerCase(DmJabber.JabberSession.Roster.Items[I].JID)=WideLowerCase(self.JID) then
      begin
        DmJabber.JabberSession.Roster.Items[I].NickName := NewNick;
        DmJabber.JabberSession.Roster.Items[I].Update;
        exit;
      end;
  end;
end;

procedure TJContact.DeleteUser;
var
 I : Integer;
begin
  self.RemoveFormRoster;
  self.Group.RemoveIfEmpty;
  For I :=0 to DMJabber.JabberSession.Roster.Count -1 do
    begin
     if LowerCase(DMJabber.JabberSession.Roster.Items[I].JID)=LowerCase(self.JID) then
       begin
        DMJabber.JabberSession.Roster.Delete(i);
        exit;
       end;
    end;
end;

procedure TJContact.DelResource(AResource: WideString);
var
   I, ResourceCount : integer;
begin
   I := self.Resources.IndexOf(AResource);

   if (I = -1) then exit;

   with self.Resources do
      begin
         Items[I].RemoveFormRoster;
         Delete(I);
      end;

   ResourceCount := self.Resources.Count;

   if ResourceCount = 1 then
      begin
        self.Resources.RemoveAllFormRoster;
        self.RemoveFormRoster;
        self.Resources.AddAllToRoster(self.Group.Node);
      end
   else if ResourceCount = 0 then
      begin
         self.RemoveFormRoster;
         if TJContacts(self.Collection).ShowOffline then
            self.AddToRoster;

         if self.Group.Node.ChildCount = 0 then
            self.Group.RemoveFormRoster;
      end;
end;


destructor TJContact.Destroy;
begin
   Self.Resources.Clear;
   self.Resources.Free;
   inherited Destroy;
end;

function TJContact.GetGroupName: WideString;
begin
  result := self.Group.JID;
end;

{ TJContacts }

function TJContacts.Add: TJContact;
begin
 result := inherited Add as TJContact;
 result.FResources := TJResources.Create(Result);
end;

procedure TJContacts.addAllToRoster;
var
  I,J : Integer;
begin
  FrmRoster.vtRoster.BeginUpdate;
  for I := 0 to self.Count -1 do
    begin // begin for loop
      J := self.Items[I].Resources.Count;

      if self.ShowOffline then
        begin // begin true
          case J of
           0 : self.Items[I].AddToRoster;
           1 : begin
                self.Items[I].Group.AddToRoster;
                self.Items[I].Resources.AddAllToRoster(self.Items[I].Group.Node);
               end
          else
            begin
              self.Items[I].AddToRoster;
              self.Items[I].Resources.AddAllToRoster(self.Items[I].Node);
            end;
          end;// end case
        end // end true
      else
        if J = 1 then
          begin
            self.Items[I].Group.AddToRoster;
            self.Items[I].Resources.AddAllToRoster(self.Items[I].Group.Node)
          end
        else if J > 1 then
            begin
              self.Items[I].AddToRoster;
              self.Items[I].Resources.AddAllToRoster(self.Items[I].Node);
            end;
    end;// end for loop
    FrmRoster.vtRoster.EndUpdate;
end;

procedure TJContacts.removeAllFromRoster;
var
  I : integer;
begin
  for I := 0 to self.Count -1 do
    begin
      self.Items[I].Resources.RemoveAllFormRoster;
      self.Items[I].RemoveFormRoster;
      self.Items[I].Group.RemoveIfEmpty;
    end;
end;

constructor TJContacts.Create(JRoster : TJRoster);
begin
  inherited Create(TJContact);
  self.fJRoster := JRoster;
end;

function TJContacts.GetItem(Index: Integer): TJContact;
begin
  result := inherited Items[Index] as TJContact;
end;

function TJContacts.IndexOf(JID: string): integer;
var
  index, I : integer;
begin
  index := -1;

  JID := WideLowerCase(JID);

  for I :=0 to self.Count -1 do
    if (WideLowerCase(self.Items[I].JID) = JID) then
      begin
        index := I;
        break;
      end;

  result := index;
end;

procedure TJContacts.setShowOffline(aValue: Boolean);
begin
  self.FShowOffline := aValue;
  self.removeAllFromRoster;
  self.addAllToRoster;
end;

{ TJAgents }

function TJAgents.Add: TJAgent;
begin
 result := inherited Add as TJAgent;
end;

procedure TJAgents.AddToRoster;
Var
 pNode, pNodeParent : PVirtualNode;
 pData : PnodeData;
 I : Integer;
begin
  if (self.Node = NIL) then
    begin
      pNode := FrmRoster.vtRoster.AddChild(NIL,NIL);
      pData := FrmRoster.vtRoster.GetNodeData(pNode);
      pData.Data := self.fGroup;
      self.Node := pNode;
      pNodeParent := pNode.Parent;
      if pNodeParent.ChildCount =1 then
        FrmRoster.vtRoster.expanded[pNodeParent] := True;
    end;

    for I:= 0 to self.Count -1 do
      if self.Items[I].registered then
        self.Items[I].AddToRoster(self.Node);
end;

constructor TJAgents.Create(JRoster : TJRoster);
begin
  inherited Create(TJAgent);

  self.fJRoster := JRoster;
  self.fGroup  := self.JRoster.Groups.Add('Gateway');
end;

function TJAgents.GetItem(Index: Integer): TJAgent;
begin
  result := inherited Items[Index] as TJAgent;
end;

function TJAgents.IndexOf(Name: WideString): integer;
var
  index, I : integer;
begin
  index := -1;

  Name := WideLowerCase(Name);

  for I :=0 to self.Count -1 do
    if (WideLowerCase(self.Items[I].name) = Name) then
      begin
        index := I;
        break;
      end;

  result := index;
end;

function TJAgents.IndexOfJid(JID: WideString): Integer;
var
  index, I : integer;
begin
  index := -1;

  JID := WideLowerCase(JID);

  for I :=0 to self.Count -1 do
    if (WideLowerCase(self.Items[I].JID) = JID) then
      begin
        index := I;
        break;
      end;

  result := index;
end;

procedure TJAgents.RemoveFromRoster;
var
  I : Integer;
begin
  if not(self.Node = NIL) then
  begin
   for I :=0 to  self.Count -1 do
    self.items[I].RemoveFormRoster;
    
   FrmRoster.vtRoster.DeleteNode(Self.Node,True);
   Self.Node := Nil;
  end;
end;

{ TJGroups }

function TJGroups.Add(GroupName: String): TJGroupItem;
var
  GroupIndex : integer;
begin
  //Check if name all ready exists
  GroupIndex := self.IndexOf(GroupName);


  if (GroupIndex = -1) then
    begin
      //add a new group te the list
      result := inherited Add as TJGroupItem;
      result.Name := GroupName;
    end
  else
    //return the found group
    result := self.GetItem(GroupIndex);
end;

constructor TJGroups.Create(JRoster : TJRoster);
begin
  inherited Create(TJGroupItem);
  self.fJRoster := JRoster;
end;

function TJGroups.GetItem(Index: Integer): TJGroupItem;
begin
  //get the requested groupitem
  result := inherited Items[Index] as TJGroupItem;
end;

function TJGroups.IndexOf(GroupName: String): Integer;
var
  index, I : integer;
begin
  // Try to find an group by its name
  index := -1;
  GroupName := WideLowerCase(GroupName);

  for I :=0 to self.Count -1 do
    if (WideLowerCase(self.Items[I].JID) = GroupName) then
      begin
        index := I;
        break;
      end;
  // will retsurn the groupindex number or -1 if none is found.
  result := index;
end;

{ TJGroupItem }

procedure TJGroupItem.AddToRoster;
begin
  TJGroups(self.Collection).Roster.Agents.RemoveFromRoster;
  Inherited AddToRoster(NIL);
  TJGroups(self.Collection).Roster.Agents.AddToRoster;
end;

procedure TJGroupItem.RemoveIfEmpty;
begin
  if self.Node = nil then
    exit;

  if self.Node.ChildCount = 0 then
    self.RemoveFormRoster;
end;

{ TJRoster }

procedure TJRoster.Clear;
var
  I : Integer;
begin
  self.Agents.RemoveFromRoster;
  self.Contacts.removeAllFromRoster;
  for I := 0 to self.Groups.Count -1 do
    self.Groups.Items[I].RemoveFormRoster;
end;

constructor TJRoster.Create;
begin
  inherited Create();
  fGroups := TJGroups.Create(Self);
  fAgents := TJAgents.Create(Self);
  fContacts := TJContacts.Create(Self);
end;

destructor TJRoster.Destroy;
begin
  Groups.Clear;
  Groups.Free;
  Agents.Clear;
  Agents.Free;
  Contacts.Clear;
  Contacts.Free;
  inherited Destroy;
end;

end.
