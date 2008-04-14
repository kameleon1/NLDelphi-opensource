{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntScreenHandler;

{*******************************************************************************
* This unit is used te keep track of all screens opened by NLDMessenger        *
*  it self o by the users.                                                     *
*******************************************************************************}

interface

uses
  { TSIM units }
  UntAbout, UntServer, UntSettings, UntVCard, UntChangeStatus, UntPassword,
  UntProfileMan,
  { Delphi Units}
  Forms, SysUtils, TntClasses, Classes, JabberCOM_TLB, Controls, Dialogs;

Type
  TScreenHandler = class(TComponent)
    Private
      FrmAbout          : TFrmAbout;
      FrmProfile        : TFrmProfileMan;
      FrmServer         : TFrmServer;
      FrmSettings       : TFrmSettings;
      FrmChangeStatus   : TFrmChangeStatus;
      FrmPassword       : TFrmPassword;
      ChatFrmList       : TTntStringList;
      GroupFrmList      : TTntStringList;
    public
      constructor Create(Aowner: TComponent); Override;
      Destructor Destroy; Override;

      {Dialogs One per session}
      function  Showlogon : Boolean;  //Show the logon screen (modal)
      procedure ShowProfileManager; // Show the profile manager.
      procedure ShowAbout;  //Show the About screen
      procedure ShowServer; //Show the Server info screen
      procedure ShowSettings; //Show the settings screen
      procedure ShowChangeStatus; //Show the ChangeStatus Screen
      procedure ShowPassword; //Show the change password Screen

      procedure SetServerTime (Time : WideString);
      procedure SetServerVersion(Version, OS :WideString);

      procedure FreeServer; //Set the Server screen var to nil
      procedure FreeAbout;  //Set the About screen var to nil
      procedure FreeSettings; //Set the Settings screen var to nil
      procedure FreeChangeStatus; //Set the ChangeStatus screen var to nil
      procedure FreePassword; // Set the Password screen var to nil
      procedure FreeProfileManager; // Set the FrmProfile screen var to nil

      {Message Dialogs}
      procedure NewMessage(JID, Subject, Body :WideString; const Tag: IXMLTag); Overload; //Get a recive message window
      procedure NewMessage(JID :WideString); Overload; //Get a new message window
      procedure ReplyMessage(JID, Subject, Body : WideString); // Reply to a recived to message
      procedure NewSubscription(FromJID, Subscription : WideString);
      procedure NewError(JID, Errorcode, Body: WideString);
      procedure ShowVersion(FromJID, Appname, AppVersion, OS :WideString);
      procedure ShowTime(FromJID, Time :WideString);
      procedure ShowLastSeen(FromJID, LastSeen : WideString);
      procedure ShowSubscription(FromJID, Caption, Status : WideString);


      {Chat Dialogs}
      function NewChat(JID: WideString; ShowOnTop: Boolean): Integer; //create a new chat window
      function NewGroupChat(JID: Widestring): Integer; //create a new groupchat window

      procedure AddChatMsg(JID, Msg : WideString);
      procedure AddGroupChatMsg(JID, Msg :WideString);
      procedure ShowUserStatus(FromJID, Status : WideString);
      Function  AddChatError(FromJID, Error : WideString) : Boolean;

      procedure RemoveChat(JID: WideString);
      procedure RemoveGroupChat(JID: WideString);

      {Other contact releaded forms}
      procedure ShowVcard(JID : WideString; const Tag: IXMLTag);

      { tool windows }
      procedure ShowAddUser;
      procedure ShowConnectGroupChat;
      procedure ShowRenameUser(JID : WideString);

  end;

implementation

uses
  UntLogon, UntDialog, UntChat, UntGroupChat, UntMessage, UntUtil,
  UntAdd, UntSubscription, UntMain, UntChangeUsername;



constructor TScreenHandler.Create;
begin
  inherited;
  ChatFrmList  := TTntStringList.Create;
  GroupFrmList := TTntStringList.Create;
end;

destructor TScreenHandler.Destroy;
begin
  FreeAndNil(ChatFrmList);
  FreeAndNil(GroupFrmList);
end;

{ Show the About screen }
procedure TScreenHandler.ShowAbout;
begin
  if not assigned(FrmAbout) then
    FrmAbout := TFrmAbout.Create(Application);
  FrmAbout.Show;
end;

{ Show The about server screen }
procedure TScreenHandler.ShowServer;
begin
  if not Assigned(FrmServer) then
    FrmServer := TFrmServer.Create(Application);
  FrmServer.Show;
end;

{ Show the LogOn screen }
Function TScreenHandler.ShowLogon : Boolean;
var
  FrmLogon : TFrmLogon;
begin
  FrmLogon := TFrmLogon.Create(Application);

  if (FrmLogon.ShowModal = mrOk) then
    result := true
  else
    result := false;

  FrmLogon.Free;
end;

{ Show the Settings Screen }
procedure TScreenHandler.ShowSettings;
begin
  if not assigned(FrmSettings) then
    FrmSettings := TFrmSettings.Create(FrmMain);
  FrmSettings.Show;
end;

{ Unasign FrmAbout }
procedure TScreenHandler.FreeAbout;
begin
  FrmAbout := NIL;
end;

{ Unasign FrmServer }
procedure TScreenHandler.FreeServer;
begin
  FrmServer := NIL;
end;
{ Unasign FrmSettings}
procedure TScreenHandler.FreeSettings;
begin
  FrmSettings := NIL;
end;

procedure TScreenHandler.NewError(JID, Errorcode, Body: WideString);
begin
  if not self.AddChatError(JID,Errorcode+' '+Body)then
  begin
    With TFrmDialog.Create(Application) do
      begin
       setCaption('Error from ' + JID);
       setFrom(JID);
       setSubject(ErrorCode);
       setSimpleMessage(Body);
       show;
      end;
  end;
end;

procedure TScreenHandler.NewMessage(JID, Subject, Body: WideString;
  const Tag: IXMLTag);
begin
  with TFrmMessage.Create(true,JID) do
    begin
      SetRecive(Body, Subject);
      Show;
    end;
end;

procedure TScreenHandler.ReplyMessage(JID, Subject, Body: WideString);
begin
  with TFrmMessage.Create(False,JID) do
    begin
      SetReply(Body, Subject);
      Show;
    end;
end;

procedure TScreenHandler.SetServerTime(Time: WideString);
begin
  If assigned(FrmServer)then
  begin
    FrmServer.LblTime.Caption := Time;
    FrmServer.LblTime.Hint := Time;
  end;
end;

procedure TScreenHandler.SetServerVersion(Version, OS: WideString);
begin
  If assigned(FrmServer)then
    begin
      FrmServer.LblVersion.Caption := Version;
      FrmServer.LblVersion.Hint := Version;
      FrmServer.LblOs.Caption := OS;
      FrmServer.LblOs.Hint := OS;
    end;
end;

Function TScreenHandler.NewChat(JID: WideString; ShowOnTop: Boolean) : Integer;
var
  tmpFrmChat : TFrmChat;
  I : Integer;
begin
  I := self.ChatFrmList.IndexOf(JID);
  if I = -1 then
    begin
      tmpFrmChat:= TFrmChat.Create(not ShowOnTop, JID);
      result := self.ChatFrmList.AddObject(JID,tmpFrmChat);
    end
  else
    begin
      TFrmChat(self.ChatFrmList.Objects[i]).BringToFront;
      result := I;
    end;
end;

Function TScreenHandler.NewGroupChat(JID: Widestring): Integer;
var
  tmpFrmChat : TFrmGroupChat;
  I : Integer;
begin
  JID := WideLowerCase(JID);
  I := self.ChatFrmList.IndexOf(JID);
  if I = -1 then
    begin
      tmpFrmChat:= TFrmGroupChat.Create(false);
      tmpFrmChat.JID := JID;

      result := self.GroupFrmList.AddObject(JID,tmpFrmChat);
    end
  else
   begin
    TFrmGroupChat(self.GroupFrmList.Objects[i]).BringToFront;
    result := I;
   end;
end;

procedure TScreenHandler.NewMessage(JID: WideString);
begin
  TFrmMessage.Create(False,JID);
end;

procedure TScreenHandler.AddChatMsg(JID, Msg: WideString);
var
  I : Integer;
begin
  I := Self.ChatFrmList.IndexOf(JID);
  if I = -1 then
    begin
      I := Self.ChatFrmList.IndexOf(GetJID(JID));
      if I = -1 then
        I := Self.NewChat(JID,False)
    end;

  TFrmChat(self.ChatFrmList.Objects[i]).AddReciveMessage(Msg);
  TFrmChat(self.ChatFrmList.Objects[i]).FlashForm;
end;

procedure TScreenHandler.AddGroupChatMsg(JID, Msg: WideString);
var
  I : Integer;
begin
  JID := WideLowerCase(JID);
  I := Self.ChatFrmList.IndexOf(JID);
  if I = -1 then
    begin
      I := Self.ChatFrmList.IndexOf(GetJID(JID));
      if I = -1 then
        I := Self.NewChat(JID,False);
    end;

  TFrmGroupChat(self.ChatFrmList.Objects[i]).AddReciveMessage(JID, Msg);
  TFrmGroupChat(self.ChatFrmList.Objects[i]).FlashForm;
end;


procedure TScreenHandler.RemoveChat(JID: WideString);
begin
  JID := WideLowerCase(JID);
  self.ChatFrmList.Delete(self.ChatFrmList.IndexOf(JID));
end;

procedure TScreenHandler.RemoveGroupChat(JID: WideString);
begin
  self.GroupFrmList.Delete(self.GroupFrmList.IndexOf(JID));
end;


procedure TScreenHandler.ShowVcard(JID: WideString; const Tag: IXMLTag);
begin
  With TFrmVcard.Create(Application) do
    begin
     show;
    end;
end;

procedure TScreenHandler.ShowProfileManager;
begin
  if not assigned(FrmProfile) then
    FrmProfile := TFrmProfileMan.Create(Application);
  FrmProfile.Show;
end;

procedure TScreenHandler.ShowTime(FromJID, Time: WideString);
begin
  with TFrmDialog.Create(Application) do
    begin
      setCaption('Time Result');
      setFrom(FromJID);
      setSubject('Time Request result');
      setNumberMessage('Time: '+Time);
      show;
    end;
end;

procedure TScreenHandler.ShowVersion(FromJID, Appname, AppVersion,
  OS: WideString);
begin
  with TFrmDialog.Create(Application) do
    begin
      setCaption('Version Result');
      setFrom(FromJID);
      setSubject('Version Request result');
      setNumberMessage('Name: '+Appname);
      setNumberMessage('Version: '+Appversion);
      setNumberMessage('OS: '+OS);
      show;
    end;
end;

procedure TScreenHandler.ShowAddUser;
begin
  TFrmAdd.Create(Application).Show;;
end;

procedure TScreenHandler.ShowConnectGroupChat;
begin
//
end;

procedure TScreenHandler.FreeChangeStatus;
begin
  FrmChangeStatus := NIL;
end;

procedure TScreenHandler.ShowChangeStatus;
begin
  if not assigned(FrmChangeStatus) then
    FrmChangeStatus := TFrmChangeStatus.Create(FrmMain);
  FrmChangeStatus.Show;
end;

procedure TScreenHandler.ShowUserStatus(FromJID, Status: WideString);
var
  I : Integer;
begin
  I := Self.ChatFrmList.IndexOf(FromJID);
  if not (I = -1) then
    begin
      TFrmChat(self.ChatFrmList.Objects[i]).AddUserStatus(Status);
    end;
end;

function TScreenHandler.AddChatError(FromJID, Error: WideString): Boolean;
var
  I : Integer;
begin
  result := False;
  I := Self.ChatFrmList.IndexOf(FromJID);
  if not (I = -1) then
    begin
      TFrmChat(self.ChatFrmList.Objects[i]).AddChatError(Error);
      result := True;
    end;
end;

procedure TScreenHandler.NewSubscription(FromJID, Subscription: WideString);
begin
  With TFrmSubscription.Create(Application) do
    begin
      setInfo(FromJID,Subscription);
      Show;
    end;
end;

procedure TScreenHandler.ShowLastSeen(FromJID, LastSeen: WideString);
begin
  with TFrmDialog.Create(Application) do
    begin
      setCaption('Last seen');
      setFrom(FromJID);
      setSubject('Last Seen Request result');
      setNumberMessage('Last seen: '+LastSeen);
      show;
    end;
end;

procedure TScreenHandler.ShowSubscription(FromJID, Caption, Status : WideString);
begin
  with TFrmDialog.Create(Application) do
    begin
      setCaption(Caption);
      setFrom(FromJID);
      setSubject(Caption);
      setSimpleMessage(Status);
      show;
    end;
end;



procedure TScreenHandler.ShowRenameUser(JID: WideString);
begin
  with TFrmChangeUserName.Create(Application)do
    begin
      SetJID(JID);
      show;
    end;
end;

procedure TScreenHandler.FreePassword;
begin
  FrmPassword := NIL;
end;

procedure TScreenHandler.ShowPassword;
begin
  if not assigned(FrmPassword) then
    FrmPassword := TFrmPassword.Create(Application);
  FrmPassword.Show;
end;

procedure TScreenHandler.FreeProfileManager;
begin
  self.FrmProfile := nil;
end;

end.
