{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntJabber;

interface

uses
  SysUtils, Classes, OleServer, JabberCOM_TLB, UntJRosterNodes, Windows, Forms,
  ExtCtrls, Dialogs;

type
  TDmJabber = class(TDataModule)
    JabberSession: TJabberSession;
    Timer: TTimer;
    procedure JabberSessionConnect(Sender: TObject);
    procedure JabberSessionAgentItem(ASender: TObject;
      const Agent: IJabberAgentItem; const iqID: WideString);
    procedure JabberSessionAgentsEnd(Sender: TObject);
    procedure JabberSessionAgentsStart(Sender: TObject);
    procedure JabberSessionRosterStart(Sender: TObject);
    procedure JabberSessionRosterEnd(Sender: TObject);
    procedure JabberSessionTimeGet(ASender: TObject;
      const FromJID: WideString; const Tag: IXMLTag);
    procedure JabberSessionVersionGet(ASender: TObject;
      const FromJID: WideString; const Tag: IXMLTag);
    procedure JabberSessionTimeResult(ASender: TObject; const FromJID,
      Display: WideString; const Tag: IXMLTag);
    procedure JabberSessionXML(ASender: TObject; Direction: Integer;
      const Text: WideString);
    procedure JabberSessionVersionResult(ASender: TObject; const FromJID,
      AppName, AppVer, OS: WideString; const Tag: IXMLTag);
    procedure TimerTimer(Sender: TObject);
    procedure JabberSessionMessage(ASender: TObject; const Msg: IJabberMsg;
      const Tag: IXMLTag);
    procedure JabberSessionAuthError(ASender: TObject;
      const ErrorText: WideString);
    procedure JabberSessionCommError(ASender: TObject;
      const ErrorText: WideString);
    procedure JabberSessionPresence(ASender: TObject;
      const PresJID: WideString; Available: WordBool;
      const Status: WideString; InRoster: WordBool; const Tag: IXMLTag);
    procedure JabberSessionDisconnect(Sender: TObject);
    procedure JabberSessionQuery(ASender: TObject; const iqType, iqFrom,
      iqID, NameSpace: WideString; const Tag: IXMLTag);
    procedure JabberSessionSubscriptionRequest(ASender: TObject;
      const FromJID, SubType, Status: WideString);
    procedure JabberSessionSubscriptionDenied(ASender: TObject;
      const FromJID, Status: WideString);
    procedure JabberSessionSubscriptionApproved(ASender: TObject;
      const FromJID, Status: WideString);
    procedure JabberSessionRosterItemEx(ASender: TObject;
      const Item: IJabberRosterItem; const Tag: IXMLTag);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure SetStatus(Value: JabberShowType; SatusMsg: WideString);
    Procedure GetVersion(JID: WideString);
    Procedure GetTime(JID: WideString);
    Procedure GetLastSeen(JID: WideString);
  end;

var
  DmJabber      : TDmJabber;

implementation

uses UntRoster, UntMain, UntConnect, UntXmlOutPut, UntDialog, UntUtil, UntIQ;

{$R *.dfm}

//--------------- JabberSesison --------------//

procedure TDmJabber.JabberSessionConnect(Sender: TObject);
begin
 //FrmMain.ShowConnect;
 Timer.Enabled := true;
 FrmConnect.SetLabeltext('Getting gateways ...');
 Jabbersession.Agents.Fetch('AGENTLIST');
 FrmMain.OnlineControls(True);
 ProgSettings.OpenSettings;
end;

procedure TDmJabber.JabberSessionAgentItem(ASender: TObject;
  const Agent: IJabberAgentItem; const iqID: WideString);
var
   tmpAgent : TJAgent;
   I : Integer;
begin

   I := JRoster.agents.IndexOf(agent.Name);

   if I = -1 then
      begin
         tmpAgent := JRoster.agents.Add;
         tmpAgent.registered := False;
      end
   else
      tmpAgent := JRoster.agents.Items[I];

   with tmpAgent do
   begin
      name := Agent.Name;
      Key := Agent.Key;
      JID := Agent.JID;
      if Agent.GetProp('Transport') <> '' then
         Transport := true else
         Transport := False;
   end;
end;

procedure TDmJabber.JabberSessionAgentsEnd(Sender: TObject);
begin
 FrmConnect.SetLabeltext('Getting Contacts...');
 jabbersession.Roster.Fetch;
end;

procedure TDmJabber.JabberSessionAgentsStart(Sender: TObject);
begin
  JRoster.Agents.Clear;
end;

procedure TDmJabber.JabberSessionRosterStart(Sender: TObject);
begin
  JRoster.Contacts.Clear;
end;

procedure TDmJabber.JabberSessionRosterEnd(Sender: TObject);
begin
  FrmMain.ShowRoster;
  FrmMain.StatusBar.Panels[0].Text := JabberSession.MyJID;
  DmJabber.SetStatus(jshowNone,'Online');
end;

procedure TDmJabber.SetStatus(Value: JabberShowType; SatusMsg: WideString);
begin
  if not JabberSession.Available then
    JabberSession.Available := true;

  JabberSession.ShowType := Value;
  JabberSession.Status := SatusMsg;
  JabberSession.SendMyPresence;

  with FrmMain.TrayIcon do
    begin
      ImageIndex := Value;
      Hint := JabberSession.MyJID+#13#10+'Satus: '+SatusMsg;
    end;

  FrmRoster.SetStatus(Value,SatusMsg);
end;

procedure TDmJabber.JabberSessionTimeGet(ASender: TObject;
  const FromJID: WideString; const Tag: IXMLTag);
var
    reply: IJabberIQ;
    tzi: TTimeZoneInformation;
    utc: TDateTime;
    res: integer;
begin
    // send back a ctcp time response..
    reply := Jabbersession.CreateIQ;
    reply.ToJID := FromJID;
    reply.ID := Tag.GetAttrib('id');
    with reply do begin
        NameSpace := 'jabber:iq:time';
        iqType := 'result';
        res := GetTimeZoneInformation(tzi);
        if res = TIME_ZONE_ID_DAYLIGHT then
            utc := Now + ((tzi.Bias - 60) / 1440.0)
        else
            utc := Now + (tzi.Bias / 1440.0);
        SetField('utc', FormatDateTime('yyyymmdd', utc)+'T'+FormatDateTime('hh:nn:ss', utc) );
        SetField('tz', tzi.StandardName);
        SetField('display', DateTimeToStr(Now));
        end;
    Jabbersession.SendIQ(reply);
end;


procedure TDmJabber.JabberSessionVersionGet(ASender: TObject;
  const FromJID: WideString; const Tag: IXMLTag);
var
    reply: IJabberIQ;
begin
    // send back a ctcp version response..
    reply := Jabbersession.CreateIQ;
    reply.NameSpace := 'jabber:iq:version';
    reply.ToJID := FromJID;
    with reply do
      begin
        iqType := 'result';
        ID := Tag.GetAttrib('id');
        SetField('name', application.Title);
        SetField('version', FileVersion);
        SetField('os', GetOperatingSystem);
      end;
    Jabbersession.SendIQ(reply);
end;

procedure TDmJabber.JabberSessionTimeResult(ASender: TObject;
  const FromJID, Display: WideString; const Tag: IXMLTag);
begin
  if WideLowerCase(fromJID) = WideLowerCase(JabberSession.Server) then
    ScreenHandler.SetServerTime(Display)
  else
    begin
      ScreenHandler.ShowTime(FromJID, Display);
    end;
end;

procedure TDmJabber.JabberSessionXML(ASender: TObject; Direction: Integer;
  const Text: WideString);
begin
 if (direction = 1) then
  FrmXml.EdtOutput.Lines.Append('sent:' + Text + #13#10) else
  FrmXml.EdtOutput.Lines.Append('recive' + Text + #13#10);
end;

procedure TDmJabber.JabberSessionVersionResult(ASender: TObject;
  const FromJID, AppName, AppVer, OS: WideString; const Tag: IXMLTag);
begin
  if WideLowerCase(fromJID) = WideLowerCase(JabberSession.Server) then
    ScreenHandler.SetServerVersion(Appname+' '+Appver,OS)
  else
    ScreenHandler.ShowVersion(FromJID, Appname, AppVer, OS);
end;


procedure TDmJabber.TimerTimer(Sender: TObject);
begin
  if JabberSession.Active then
     JabberSession.SendXML('  ' + Chr(9) + '  ');
end;

procedure TDmJabber.JabberSessionMessage(ASender: TObject;
  const Msg: IJabberMsg; const Tag: IXMLTag);
begin
  case Msg.MsgType of
    jmtChat       : ScreenHandler.AddChatMsg(Msg.FromJID,Msg.Body);
    jmtNormal     : ScreenHandler.NewMessage(Msg.FromJID,Msg.Subject, Msg.Body,Tag);
    jmtError      : ScreenHandler.NewError(Msg.FromJID, JabberSession.LastErrorCode, Msg.Body);
    jmtGroupChat  : ScreenHandler.AddGroupChatMsg(Msg.FromJID,Msg.Body);
  end;
end;

procedure TDmJabber.JabberSessionAuthError(ASender: TObject;
  const ErrorText: WideString);
begin
  ScreenHandler.NewError(JabberSession.Server, JabberSession.LastErrorCode,
    ErrorText);
 FrmMain.ResetConnect;
end;

procedure TDmJabber.JabberSessionCommError(ASender: TObject;
  const ErrorText: WideString);
begin
   ScreenHandler.NewError(JabberSession.Server, 'in Communication with server',
      ErrorText);
   JabberSession.DoDisconnect(True);
end;

procedure TDmJabber.JabberSessionPresence(ASender: TObject;
  const PresJID: WideString; Available: WordBool; const Status: WideString;
  InRoster: WordBool; const Tag: IXMLTag);
var
 Icontact, IAgent : Integer;
 Pres : IJabberPres;
 tmpContact : TJContact;
begin
   // do nothing if user not in roster
   if not InRoster then Exit;

   // Get the index of the user
   Icontact := JRoster.Contacts.IndexOf(GetJID(PresJID));
   IAgent := JRoster.Agents.IndexOfJID(GetJID(PresJID));

   Pres := JabberSession.GetPres(GetJID(PresJID),GetResource(PresJID),True);

   if not(Icontact = -1) then
   begin

    tmpContact := JRoster.Contacts.Items[Icontact];

    if Available then
      begin
        tmpContact.AddResource(GetResource(PresJID),Pres.Status,Pres.ShowType);
      end
    else
      begin
        tmpContact.DelResource(GetResource(PresJID));
      end;
    end
    else if not(IAgent = -1 ) then
    begin
      JRoster.Agents.Items[IAgent].Online := Available;
      if Available then
        JRoster.Agents.Items[IAgent].Status := Pres.ShowType;
    end;

   ScreenHandler.ShowUserStatus(PresJID,Status);
end;

procedure TDmJabber.JabberSessionDisconnect(Sender: TObject);
begin
   JRoster.Clear;
   FrmMain.ShowConnect;
   FrmMain.OnlineControls(False);
   Self.SetStatus(5,'NLDMessenger not Connected');
   FrmMain.StatusBar.Panels[0].Text := '';
end;

procedure TDmJabber.GetLastSeen(JID: WideString);
var
 Iq    : IJabberIQ;
begin
 Iq := JabberSession.CreateIQ;
 With Iq do
  Begin
    NameSpace := 'jabber:iq:last';
    iqType := 'get';
    ToJID  := JID;
    FromJID := JabberSession.MyJID;
  end;
  JabberSession.SendIQ(Iq);

end;

procedure TDmJabber.GetTime(JID: WideString);
var
 Iq    : IJabberIQ;
begin
 Iq := JabberSession.CreateIQ;
 With Iq do
  Begin
    NameSpace := 'jabber:iq:time';
    iqType := 'get';
    ToJID  := JID;
    FromJID := JabberSession.MyJID;
  end;
  JabberSession.SendIQ(Iq);

end;

procedure TDmJabber.GetVersion(JID: WideString);
var
 Iq    : IJabberIQ;
begin
 Iq := JabberSession.CreateIQ;
 With Iq do
  Begin
    NameSpace := 'jabber:iq:version';
    iqType := 'get';
    ToJID  := JID;
    FromJID := JabberSession.MyJID;
  end;
  JabberSession.SendIQ(Iq);

end;

procedure TDmJabber.JabberSessionQuery(ASender: TObject; const iqType,
  iqFrom, iqID, NameSpace: WideString; const Tag: IXMLTag);
var
  lowIqType, lowNameSpace : WideString;
begin
  lowIqType := WideLowerCase(iqType);
  lowNameSpace := WideLowerCase(NameSpace);

  if (lowIqType = 'result') then  // have a result on a request (get)
    begin
      if (lowNameSpace = 'jabber:iq:last') then
        begin
          resultLastSeen(iqFrom,Tag);
        end;
    end;
  if (lowIqType = 'set') then // some one want us to edit something
    begin
    end;
  if (lowIqType = 'get') then // some one want some information
    begin
    end;
  if (lowIqType = 'error') then
    begin
    end; 
end;

procedure TDmJabber.JabberSessionSubscriptionRequest(ASender: TObject;
  const FromJID, SubType, Status: WideString);
var
  I : Integer;
begin
  if SubType = 'subscribe' then
    ScreenHandler.NewSubscription(FromJID,Status);

  if SubType = 'unsubscribe' then
    begin
      I := JRoster.Contacts.IndexOf(getJID(FromJID));
      if not( I = -1) then
          if JRoster.Contacts.Items[I].SubscriptionType = jstNone then
            JRoster.Contacts.Items[I].DeleteUser;
    end;
end;

procedure TDmJabber.JabberSessionSubscriptionDenied(ASender: TObject;
  const FromJID, Status: WideString);
var
  MsgApproved : WideString;
  I : Integer;
begin
  MsgApproved := 'The User ';

  I := JRoster.Contacts.IndexOf(getJID(FromJID));

  if (I = -1) then
      MsgApproved := MsgApproved + FromJID
  else
    MsgApproved := MsgApproved + JRoster.Contacts.Items[I].Name;

  MsgApproved := MsgApproved + ' has denied your request to see its presence.'
     + #13#10 + 'You will not be able to see if the user is online or his status.';

  ScreenHandler.ShowSubscription(FromJID,'Supscription Denied',MsgApproved);
end;

procedure TDmJabber.JabberSessionSubscriptionApproved(ASender: TObject;
  const FromJID, Status: WideString);
var
  MsgApproved : WideString;
  I : Integer;
begin
  MsgApproved := 'The User ';

  I := JRoster.Contacts.IndexOf(getJID(FromJID));

  if (I = -1) then
      MsgApproved := MsgApproved + FromJID
  else
    MsgApproved := MsgApproved + JRoster.Contacts.Items[I].Name;

  MsgApproved := MsgApproved + ' has approved your request to see its presence.'
     + #13#10 + 'You will now see if the user is online or not and his status.';

  ScreenHandler.ShowSubscription(FromJID,'Supscription Approved',MsgApproved);
end;

procedure TDmJabber.JabberSessionRosterItemEx(ASender: TObject;
  const Item: IJabberRosterItem; const Tag: IXMLTag);
var
   I,J : Integer;
   tmpContact : TJContact;
begin
   // Check if Contact exsist
   I := JRoster.Contacts.IndexOf(Item.JID);
   // Check if RosterItem is a Agent
   J := JRoster.Agents.IndexOfJid(GetJID(Item.JID));

   if not(J = -1) then
      JRoster.Agents.Items[J].registered := True
   else
   // RostersItem wants to be removed
   if (Item.Subscription = jstRemove) and not (I = -1) then
      begin
         JRoster.Contacts.Items[I].Resources.RemoveAllFormRoster;
         JRoster.Contacts.Items[I].RemoveFormRoster;
         JRoster.Contacts.Delete(I);
      end
   else   // We will add the RosterItem
      begin
         // Get/Add the correct RosterItem
         if (I = -1) then
            begin
             tmpContact := JRoster.Contacts.Add;
             tmpContact.JID := Item.JID;
            end
         else
            begin
              tmpContact := JRoster.Contacts.Items[I];
              tmpContact.RemoveFormRoster;
            end;

         tmpContact.Name := Item.NickName;
         tmpContact.SubscriptionType := Item.Subscription;
         tmpContact.Group := JRoster.Groups.Add(Item.Group[0]);

         if JRoster.contacts.ShowOffline then
            tmpContact.AddToRoster;
      end;
end;

end.
