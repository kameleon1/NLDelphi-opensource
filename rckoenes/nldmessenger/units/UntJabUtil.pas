unit UntJabUtil;

{*******************************************************************************
* In this unit are the classes that will hold the roster elements              *
* Each element has it own collection with its onw options.                     *
* The collections are as followed:                                             *
* TContacts                                                                    *
*       |-TContact                                                             *
*              |-TResources                                                    *
*                     |-TResource                                              *
*                                                                              *
* TAgents                                                                      *
*       |-Tagent                                                               *
*                                                                              *
* TJabGroups                                                                   *
*       |-TJabGroup                                                            *
*                                                                              *
* at each end of the collection there will be a pnode wich is a pointer to a   *
* RosterItem                                                                   *
*                                                                              *
* This Unit is copyright Remmelt Koenes (remmelt@triplesoftware.com) 2003      *
* ©1999-2003 TRIPLE software                                                   *
*******************************************************************************}

interface

uses
  Classes, VirtualTrees, Dialogs, UntConfig, SysUtils, JabberCOM_TLB;

Type
 TRosterType  = (itGateway, itContact, itGroup);

{ Resource Class}
 TResource  = class(TCollectionItem)
    Private
      FJID        : WideString;
      FStatus     : Integer;
      FStatusMsg  : WideString;
      FPNode      : PVirtualNode;
    Published
      property JID        : WideString  read FJID       write FJID;
      property Status     : Integer     read FStatus    write FStatus;
      property StatusMsg  : WideString  read FStatusMsg write FStatusMsg;
    Public
      property PNode  : PVirtualNode  read FPNode write FPNode;
    end;

 TResources  = class(TCollection)
    private
      function GetItem(Index: Integer): TResource;
    public
      constructor Create(); reintroduce;
      function  Add: TResource;
      property  Items[Index: Integer]: TResource read GetItem;
    end;

{ Contact Class}
 TContact   = class(TCollectionItem)
    private
      FJID          : WideString;
      FNickName     : WideString;
      FGroup        : WideString;
      FAuth         : JabberSubscriptionType;
      FTypemsg      : WideString;
      FPNode        : PVirtualNode;
      Resources     : TResources;
    published
      property JID          : WideString              read FJID         write FJID;
      property NickName     : WideString              read FNickName    write FNickName;
      property Group        : WideString              read FGroup       write FGroup;
      property Auth         : JabberSubscriptionType  read FAuth        write FAuth;
      property Typemsg      : WideString              read FTypemsg     write FTypemsg;
    public
      property  PNode       : PVirtualNode   read FPNode       write FPNode;
      Procedure DelUser;
      Procedure ChangeNick(NewNick: WideString);
      Procedure MoveToGroup(NewGroup: WideString);
    end;

 TContacts = class(TCollection)
    private
      function GetItem(Index: Integer): Tcontact;
    public
      ShowOffline   :   Boolean
      constructor Create(); reintroduce;
      function  Add: Tcontact;
      property  Items[Index: Integer]: Tcontact read GetItem;
      function  JIDexists(JID: WideString): boolean;
      function  FindJID(JID: WideString): integer;
      Procedure ClearRoster;
    end;

{ Agent Class}
 TAgent = class(TCollectionItem)
    private
      FJID            : WideString;
      Fname           : WideString;
      FOnline         : Boolean;
      Fregistered     : Boolean;
      FTransport      : Boolean;
      FTransPortType  : WideString;
      FKey            : WideString;
    published
      property JID            : WideString  read FJID           write FJID;
      property name           : WideString  read Fname          write Fname;
      property Online         : Boolean     read FOnline        write FOnline;
      property registered     : Boolean     read Fregistered    write Fregistered;
      property Transport      : Boolean     read FTransport     write FTransport;
      property TransPortType  : WideString  read FTransPortType write FTransPortType;
      property Key            : WideString  read FKey           write FKey;
    end;

 TAgents = class(TCollection)
    private
      function GetItem(Index: Integer): Tagent;
    public
      constructor Create(); reintroduce;
      function Add: Tagent;
      function JIDexists(JID: WideString): boolean;
      function FindJID(JID: WideString): integer;
      property Items[Index: Integer]: Tagent read GetItem;
    end;


implementation

uses
 UntRoster, UntJabber;


{ TResources }

constructor TResources.Create;
begin
  inherited Create(TResource);
end;

function TResources.Add: TResource;
begin
  result := inherited Add as TResource;
end;

function TResources.GetItem(Index: Integer): TResource;
begin
  result := inherited Items[Index] as TResource;
end;

{ TContacts }

constructor TContacts.Create;
begin
  inherited Create(TContact);
end;

procedure TContacts.ClearRoster;
Var
  I : Integer;
begin
FrmRoster.Roster.Clear;
 for I := 0 to self.Count -1 do
  begin
    self.Items[I].PNode := NIL;
  end;
end;

function TContacts.Add: Tcontact;
begin
  result := inherited Add as Tcontact;
end;

function TContacts.FindJID(JID: WideString): integer;
var
 I: Integer;
begin
  result := -1;
  For I := 0 To self.Count -1 do
    If self.Items[I].JID = JID Then
      begin
       result := I;
       Exit;
      end;
end;

function TContacts.GetItem(Index: Integer): Tcontact;
begin
  result := inherited Items[Index] as Tcontact;
end;

function TContacts.JIDexists(JID: WideString): boolean;
var
 I: Integer;
begin
 result := false;
  For I := 0 To self.count -1 do
    If self.Items[I].JID = JID Then
      begin
       result := True;
       Exit;
      end;
end;

{ Tcontact }

procedure TContact.DelUser;
var
 I : Integer;
begin
  For I :=0 to DmJabber.JabberSession.Roster.Count -1 do
    begin
     if WideLowerCase(DmJabber.JabberSession.Roster.Items[I].JID)= WideLowerCase(self.JID) then
       begin
        DmJabber.JabberSession.Roster.Delete(i);
        exit;
       end;
    end;
end;

procedure TContact.ChangeNick(NewNick: WideString);
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

procedure TContact.MoveToGroup(NewGroup: WideString);
var
 I : Integer;
begin
For I :=0 to DmJabber.JabberSession.Roster.Count -1 do
  begin
     if WideLowerCase(DmJabber.JabberSession.Roster.Items[I].JID)=WideLowerCase(self.JID) then
      begin
        DmJabber.JabberSession.Roster.Items[I].ClearGroups;
        DmJabber.JabberSession.Roster.Items[I].AddGroup(NewGroup);
        DmJabber.JabberSession.Roster.Items[I].Update;
        exit;
      end;
  end
end;

{ TAgents }

constructor TAgents.Create;
begin
  inherited Create(TAgent);
end;

function TAgents.Add: TAgent;
begin
 result := inherited Add as TAgent;
end;

function TAgents.FindJID(JID: WideString): integer;
var
 I: Integer;
begin
  result := -1;
  For I := 0 To TAgents(self).count -1 do
    If TAgents(self).Items[I].JID = JID Then
      begin
       result := I;
       Exit;
      end;
end;

function TAgents.GetItem(Index: Integer): TAgent;
begin
 result := inherited Items[Index] as TAgent;
end;

function TAgents.JIDexists(JID: WideString): boolean;
var
 I: Integer;
begin
 result := false;
  For I := 0 To TAgents(self).count -1 do
    If TAgents(self).Items[I].JID = JID Then
      begin
       result := True;
       Exit;
      end;
end;


end.
