{
    MSNP - implementation of the MSN Messenger protocol
    Copyright (C) 2003-2004 Jelmer Vos

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

    Web:   http://www.nldelphi.com/
}

unit MSNProtocol;

interface

uses
  Classes, SysUtils, Windows, Contnrs, TCPClient, RegExpr, MD5, IdURI, Graphics,
  HTTPSClient;

type
  TServerConnection = (scsDispatch, scsNotification);
  TConnectionState = (csDisconnected, csConnected, csReady);
  TMSNSessionType = (stIncoming, stOutgoing);
  TMSNList = (blForwardList, blReverseList, blAllowList, blBlockList);
  TMSNLists = set of TMSNList;
  TMSNStatus = (msOnline, msOffline, msHidden, msIdle, msAway, msBusy, msBRB,
    msPhone, msLunch);

type
  EMSNNotConnected = class(Exception);
  EMSNAlreadyConnected = class(Exception);
  EMSNMaximumMessageLentghReached = class(Exception);
  EMSNAlreadySynchronised = class(Exception);

type
  TMSNSessions = class;
  TMSNSession = class;
  TMSNUser = class;
  TMSNHTTPSLogon = class;
  TMSNMessage = class;

  TDebugEvent = procedure(Sender: TObject; DebugText: String) of object;
  TConnectionStateChangeEvent = procedure(Sender: TObject) of object;
  TNewSessionEvent = procedure(Sender: TObject; Session: TMSNSession) of object;
  TErrorEvent = procedure(Sender: TObject; const ErrorCode: Integer) of object;
  TIncomingMessageEvent = procedure(Sender: TObject; Session: TMSNSession;
    FromUser: TMSNUser; Text: String; Font: TFont) of object;
  TOutgoingMessageEvent = procedure(Sender: TObject; Session: TMSNSession;
    Text: String) of object;
  TSessionReady = procedure(Sender: TObject; Session: TMSNSession) of object;
  TTypingUserEvent = procedure(Sender: TObject; Session: TMSNSession;
    FromUser: TMSNUser; TypingPassport: String) of object;
  TUserLeaveSessionEvent = procedure(Sender: TObject; Session: TMSNSession;
    User: TMSNUser) of object;
  TUserEnterSessionEvent = procedure(Sender: TObject; Session: TMSNSession;
    User: TMSNUser) of object;
  TUserIsInSessionEvent = procedure(Sender: TObject; Session: TMSNSession;
    User: TMSNUser) of object;
  TLocalStatusChangeEvent = procedure(Sender: TObject;
    OldStatus, NewStatus: TMSNStatus) of object;
  TLocalDisplaynameChangeEvent = procedure(Sender: TObject;
    OldDisplayname: String) of object;
  TUserChangeEvent = procedure(Sender: TObject; User: TMSNUser;
    Status: TMSNStatus) of object;
  TUserOfflineEvent = procedure(Sender: TObject; Passport: String) of object;
  TUserAddedToListEvent = procedure(Sender: TObject; List: TMSNList;
    User: TMSNUser) of object;
  TUserRemovedFromListEvent = procedure(Sender: TObject; List: TMSNList;
    Passport: String) of object;
  TUserIsInListEvent = procedure(Sender: TObject; Lists: TMSNLists;
    User: TMSNUser; Groups: String) of object;
  TReceivingSettingsEvent = procedure(Sender: TObject;
    UserCount, GroupCount: Integer) of object;
  TSettingsUpToDateEvent = procedure(Sender: TObject) of object;
  TReadyEvent = procedure(Sender: TObject) of object;
  TDisconnectedEvent = procedure(Sender: TObject) of object;
  TConnectedEvent = procedure(Sender: TObject) of object;
  TSessionDestroyEvent = procedure(Sender: TObject;
    Session: TMSNSession) of object;
  TMessageNotReceivedEvent = procedure(Sender: TObject;
    Session: TMSNSession) of object;
  TSessionConnectedEvent = procedure(Sender: TObject;
    Session: TMSNSession) of object;
  TSessionDisconnectedEvent = procedure(Sender: TObject;
    Session: TMSNSession) of object;
  TMessageEvent = procedure(Sender: TObject; MSNMessage: TMSNMessage) of object;
  TUserIsOnlineEvent = procedure(Sender: TObject; User: TMSNUser;
    Status: TMSNStatus) of object;
  TUserGroupEvent = procedure(Sender: TObject; Id: Integer;
    Title: String) of object;

  TMSNDataComponent = class(TComponent)
  private
    FRegEx: TRegExpr;
  protected
    property RegEx: TRegExpr read FRegEx;

    function StringDecode(Str: String): String;
    function StringEncode(Str: String): String;

    function RegExMatch(Expression, Str: String): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TMSNBase = class(TMSNDataComponent)
  private
    FTCPClient: TTCPClient;
    FInMessageMode: Boolean;
    FConnectionState: TConnectionState;
    FTransID: Integer;
    FMSNMessage: TMSNMessage;

    FOnDebug: TDebugEvent;

    procedure SendText(Text: String; AddCRLF: Boolean = True);

    procedure SetConnectionState(const Value: TConnectionState);
    procedure MSNMessageComplete(Sender: TObject);
  protected
    property TransID: Integer read FTransID;
    property TCPClient: TTCPClient read FTCPClient;

    //Binnen gekomen data verwerken
    procedure Process(Data: String); virtual;

    //Binnen gekomen MSG bericht verwerken
    procedure ProcessMessage(MSNMessage: TMSNMessage); virtual; abstract;

    //TCP client events
    {TODO: Connect error event handler}
    procedure TCPClientConnected(Sender: TObject); virtual;
    procedure TCPClientDisconnected(Sender: TObject); virtual;
    procedure TCPClientDataAvailable(Sender: TObject); virtual;

    procedure IncrementTransID;
    procedure ResetTransID;

    procedure DoDebug(DebugText: String); virtual;
  public
    property ConnectionState: TConnectionState read FConnectionState
      write SetConnectionState;
    property OnDebug: TDebugEvent read FOnDebug write FOnDebug;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LogOff;
  end;

  TMSNMessage = class(TMSNDataComponent)
  private
    FDataSize: Integer;
    FData: String;
    FFromDisplayname: String;
    FFromPassport: String;
    FOnComplete: TNotifyEvent;
    FContentType: String;
    FContent: String;
    FHeader: String;
    procedure DataComplete;
    procedure GetContentType;
    procedure SplitHeaderAndContent;
  protected
    procedure DoComplete;
  public
    property OnComplete: TNotifyEvent read FOnComplete write FOnComplete;

    property FromPassport: String read FFromPassport write FFromPassport;
    property FromDisplayname: String read FFromDisplayname
      write FFromDisplayname;
    property DataSize: Integer read FDataSize write FDataSize;
    property Data: String read FData;
    property ContentType: String read FContentType;
    property Content: String read FContent;
    property Header: String read FHeader;

    constructor Create; reintroduce;

    procedure AddData(Data: String);
  end;

  TMSNP = class(TMSNBase)
  private
    FOnNewSession: TNewSessionEvent;
    FOnError: TErrorEvent;
    FOnIncomingMessage: TIncomingMessageEvent;
    FOnOutgoingMessage: TOutgoingMessageEvent;
    FOnSessionReady: TSessionReady;
    FOnTypingUser: TTypingUserEvent;
    FOnUserLeaveSession: TUserLeaveSessionEvent;
    FOnUserEnterSession: TUserEnterSessionEvent;
    FOnUserIsInSession: TUserIsInSessionEvent;
    FOnLocalStatusChange: TLocalStatusChangeEvent;
    FOnLocalDisplaynameChange: TLocalDisplaynameChangeEvent;
    FOnUserChange: TUserChangeEvent;
    FOnUserOffline: TUserOfflineEvent;
    FOnUserAddedToList: TUserAddedToListEvent;
    FOnUserRemovedFromList: TUserRemovedFromListEvent;
    FOnReady: TReadyEvent;
    FOnDisconnected: TDisconnectedEvent;
    FOnConnected: TConnectedEvent;
    FOnLoginError: TNotifyEvent;
    FOnUserIsInList: TUserIsInListEvent;
    FOnReceivingSettings: TReceivingSettingsEvent;
    FOnUserIsOnline: TUserIsOnlineEvent;
    FOnUserGroup: TUserGroupEvent;

    FSessions: TMSNSessions;
    FHTTPSLogon: TMSNHTTPSLogon;
    FServerConnection: TServerConnection;
    FSwitchingServers: Boolean;
    FSynchronisedSettings: Boolean;
    FNotificationServerHost: String;
    FNotificationServerPort: Integer;

    FPassword: String;
    FPassport: String;
    FDisplayname: String;
    FStatus: TMSNStatus;
    FLastErrorCode: Integer;
    FSettingsVersion: Integer;
    FAcceptAllSessions: Boolean;
    FPromptOnReverseListAdd: Boolean;
    FOnMessageNotReceived: TMessageNotReceivedEvent;
    FOnSessionConnected: TSessionConnectedEvent;
    FOnSessionDisconnected: TSessionDisconnectedEvent;
    FAutoOnline: Boolean;
    FAutoSyncLists: Boolean;
    FAutoCloseEmptySessions: Boolean;
    FOnSettingsUpToDate: TSettingsUpToDateEvent;
    FDefaultMessageFont: TFont;
    FOnMessage: TMessageEvent;

    procedure ConnectToNotificationServer(Host: String; Port: Integer);
    procedure NewSessionAndConnect(Host: String; Port: Integer; Hash: String;
      SessionID: Integer; SessionType: TMSNSessionType);
    function NewSession(SessionID: Integer;
      SessionType: TMSNSessionType): TMSNSession;
    procedure SetLastErrorCode(ErrorCode: Integer);
    procedure ProcessPassportAuth(AuthData: String);
    procedure HTTPSLogonSuccess(Sender: TObject);
    procedure HTTPSLogonError(Sender: TObject);
    procedure HTTPSDebug(Sender: TObject; DebugText: String);

    procedure ProcessListRecord(Passport, Displayname: String;
      ListNumber: Integer; Groups: String);
    procedure ProcessGroupRecord(Id: Integer; Title: String);

    //Private houden, methods hebben betrekking op het protocol
    function StatusToText(MSNStatus: TMSNStatus): String;
    function TextToStatus(Text: String): TMSNStatus;
    function TextToList(Text: String): TMSNList;
    function ListToText(List: TMSNList): String;

    procedure SetStatus(const Value: TMSNStatus);
    procedure SetDisplayname(const Value: String);
    procedure SetAcceptAllSessions(const Value: Boolean);
    procedure SetPromptOnReverseListAdd(const Value: Boolean);
    procedure SetDefaultMessageFont(const Value: TFont);
  protected
    procedure TCPClientConnected(Sender: TObject); override;
    procedure TCPClientDisconnected(Sender: TObject); override;
    procedure Process(Data: String); override;
    procedure ProcessMessage(MSNMessage: TMSNMessage); override;
    procedure SessionDisconnected(Session: TMSNSession);

    procedure DoNewSession(Session: TMSNSession);
    procedure DoError(ErrorCode: Integer);
    procedure DoIncomingMessage(Session: TMSNSession; FromUser: TMSNUser;
      Text: String; Font: TFont);
    procedure DoOutgoingMessage(Session: TMSNSession; Text: String);
    procedure DoSessionReady(Session: TMSNSession);
    procedure DoTypingUser(Session: TMSNSession; FromUser: TMSNUser;
      TypingPassport: String);
    procedure DoUserLeaveSession(Session: TMSNSession; User: TMSNUser);
    procedure DoUserEnterSession(Session: TMSNSession; User: TMSNUser);
    procedure DoUserIsInSession(Session: TMSNSession; User: TMSNUser);
    procedure DoLocalStatusChange(OldStatus, NewStatus: TMSNStatus);
    procedure DoLocalDisplaynameChange(OldDisplayname: String);
    procedure DoUserChange(User: TMSNUser; Status: TMSNStatus);
    procedure DoUserOffline(Passport: String);
    procedure DoUserAddedToList(List: TMSNList; User: TMSNUser);
    procedure DoUserRemovedFromList(List: TMSNList; Passport: String);
    procedure DoUserIsInList(Lists: TMSNLists; User: TMSNUser; Groups: String);
    procedure DoReceivingSettings(UserCount, GroupCount: Integer);
    procedure DoSettingsUpToDate;
    procedure DoReady;
    procedure DoDisconnected;
    procedure DoConnected;
    procedure DoMessageNotReceived(Session: TMSNSession);
    procedure DoSessionConnected(Session: TMSNSession);
    procedure DoSessionDisconnected(Session: TMSNSession);
    procedure DoLoginError;
    procedure DoMessage(MSNMessage: TMSNMessage);
    procedure DoUserIsOnline(User: TMSNUser; Status: TMSNStatus);
    procedure DoUserGroup(Id: Integer; Title: String);
  published
    property OnDebug;
    property OnNewSession: TNewSessionEvent read FOnNewSession
      write FOnNewSession;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnIncomingMessage: TIncomingMessageEvent read FOnIncomingMessage
      write FOnIncomingMessage;
    property OnOutgoingMessage: TOutgoingMessageEvent read FOnOutgoingMessage
      write FOnOutgoingMessage;
    property OnSessionReady: TSessionReady read FOnSessionReady
      write FOnSessionReady;
    property OnTypingUser: TTypingUserEvent read FOnTypingUser
      write FOnTypingUser;
    property OnUserLeaveSession: TUserLeaveSessionEvent read FOnUserLeaveSession
      write FOnUserLeaveSession;
    property OnUserEnterSession: TUserEnterSessionEvent read FOnUserEnterSession
      write FOnUserEnterSession;
    property OnUserIsInSession: TUserIsInSessionEvent read FOnUserIsInSession
      write FOnUserIsInSession;
    property OnLocalStatusChange: TLocalStatusChangeEvent
      read FOnLocalStatusChange write FOnLocalStatusChange;
    property OnLocalDisplaynameChange: TLocalDisplaynameChangeEvent
      read FOnLocalDisplaynameChange write FOnLocalDisplaynameChange;
    property OnUserChange: TUserChangeEvent read FOnUserChange
      write FOnUserChange;
    property OnUserOffline: TUserOfflineEvent read FOnUserOffline
      write FOnUserOffline;
    property OnUserAddedToList: TUserAddedToListEvent read FOnUserAddedToList
      write FOnUserAddedToList;
    property OnUserRemovedFromList: TUserRemovedFromListEvent
      read FOnUserRemovedFromList write FOnUserRemovedFromList;
    property OnUserIsInList: TUserIsInListEvent read FOnUserIsInList
      write FOnUserIsInList;
    property OnReceivingSettings: TReceivingSettingsEvent
      read FOnReceivingSettings write FOnReceivingSettings;
    property OnSettingsUpToDate: TSettingsUpToDateEvent
      read FOnSettingsUpToDate write FOnSettingsUpToDate;
    property OnReady: TReadyEvent read FOnReady write FOnReady;
    property OnDisconnected: TDisconnectedEvent read FOnDisconnected
      write FOnDisconnected;
    property OnConnected: TConnectedEvent read FOnConnected write FOnConnected;
    property OnMessageNotReceived: TMessageNotReceivedEvent
      read FOnMessageNotReceived write FOnMessageNotReceived;
    property OnSessionConnected: TSessionConnectedEvent
      read FOnSessionConnected write FOnSessionConnected;
    property OnSessionDisconnected: TSessionDisconnectedEvent
      read FOnSessionDisconnected write FOnSessionDisconnected;
    property OnLoginError: TNotifyEvent read FOnLoginError write FOnLoginError;
    property OnMessage: TMessageEvent read FOnMessage write FOnMessage;
    property OnUserIsOnline: TUserIsOnlineEvent read FOnUserIsOnline
      write FOnUserIsOnline;
    property OnUserGroup: TUserGroupEvent read FOnUserGroup write FOnUserGroup;
  published
    property Passport: String read FPassport write FPassport;
    property Password: String read FPassword write FPassword;
    property SettingsVersion: Integer read FSettingsVersion
      write FSettingsVersion default 0;
    property AutoOnline: Boolean read FAutoOnline
      write FAutoOnline default True;
    property AutoSyncLists: Boolean read FAutoSyncLists
      write FAutoSyncLists default True;
    property AutoCloseEmptySessions: Boolean read FAutoCloseEmptySessions
      write FAutoCloseEmptySessions default True;
    property DefaultMessageFont: TFont read FDefaultMessageFont
      write SetDefaultMessageFont;
  public
    property Sessions: TMSNSessions read FSessions;
    property Status: TMSNStatus read FStatus write SetStatus;
    property Displayname: String read FDisplayname write SetDisplayname;

    //True: Accepteer alle sessies behalve van users die op de block-list staan
    //False: Accepteer alleen sessies van users die op de allow-list staan
    property AcceptAllSessions: Boolean read FAcceptAllSessions
      write SetAcceptAllSessions;

    //Updates over toevoegingen op de reverse lijst
    property PromptOnReverseListAdd: Boolean read FPromptOnReverseListAdd
      write SetPromptOnReverseListAdd;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Logon;
    function CreateSession: TMSNSession;
    procedure SendMessage(Passport, Text: String);
    procedure SyncSettings(SettingsVersion: Integer);

    //Het is blijkbaar mogelijk een gebruikersnaam van iemand te veranderen
    //die in je buddy-lijst voorkomt, dit is niet volledig getest
    procedure ChangeDisplayname(Passport, Displayname: String);

    procedure RemoveUserFromList(List: TMSNList; Passport: String);
    procedure AddUserToList(List: TMSNList; Passport, Displayname: String);
  end;

  TMSNSessions = class(TObject)
  private
    FList: TObjectList;

    function GetCount: Integer;
    function GetItem(Index: Integer): TMSNSession;
  protected
    procedure Remove(Session: TMSNSession);
    procedure Add(Session: TMSNSession);
    procedure Clear;
  public
    property Items[Index: Integer]: TMSNSession read GetItem;
    property Count: Integer read GetCount;

    constructor Create;
    destructor Destroy; override;

    function IndexOf(Session: TMSNSession): Integer;
    function FindSession(SessionID: Integer): TMSNSession;
  end;

  TMSNSession = class(TMSNBase)
  private
    FMSNP: TMSNP;
    FPassportsToInvite: TStringList;
    FMessagesToSend: TStringList;
    FUsers: TObjectList;
    FSessionType: TMSNSessionType;
    FSessionID: Integer;
    FHash: String;
    FMessageFont: TFont;
    FData: Pointer;

    procedure AddUser(Passport, Displayname: String; Invited: Boolean);
    procedure RemoveUser(Passport: String);
    procedure FlushMessagesToSend;
    procedure FlushPassportsToInvite;
    function FindUser(Passport: String): TMSNUser;
    function GetMessageData(MessageText: String): String;
    procedure ProcessInstantMessage(User: TMSNUser; Header, Content: String);
    function StrToFontStyle(Str: String): TFontStyles;
    function StrToFontColor(Str: String): TColor;
    function FontStyleToStr(FontStyle: TFontStyles): String;
    function FontColorToStr(Color: TColor): String;
    function FontPitchToStr(FontPitch: TFontPitch): String;

    function GetUser(Index: Integer): TMSNUser;
    function GetUserCount: Integer;
    function GetIndex: Integer;
  protected
    procedure TCPClientConnected(Sender: TObject); override;
    procedure TCPClientDisconnected(Sender: TObject); override;

    procedure Process(Data: String); override;
    procedure ProcessMessage(MSNMessage: TMSNMessage); override;
    procedure ConnectToServer(Host: String; Port: Integer; Hash: String);
  public
    property SessionType: TMSNSessionType read FSessionType;
    property SessiondID: Integer read FSessionID;
    property User[Index: Integer]: TMSNUser read GetUser;
    property UserCount: Integer read GetUserCount;
    property MessageFont: TFont read FMessageFont write FMessageFont;
    property Index: Integer read GetIndex;
    property Data: Pointer read FData write FData;

    constructor Create(MSNP: TMSNP; SessionType: TMSNSessionType;
      SessionID: Integer; DefaultFont: TFont); reintroduce;
    destructor Destroy; override;

    procedure InviteUser(Passport: String);
    procedure SendMessage(Text: String);
    procedure TypingUser(Passport: String);
  end;

  TMSNUser = class(TObject)
  private
    FPassport: String;
    FDisplayname: String;
  public
    property Passport: String read FPassport;
    property Displayname: String read FDisplayname write FDisplayname;

    constructor Create(Passport, Displayname: String);
  end;

  TMSNHTTPSConnectionState = (scDispatch, scLogin);

  TMSNHTTPSLogon = class(TMSNDataComponent)
  private
    FConnectionState: TMSNHTTPSConnectionState;
    FHTTPSClient: THTTPSClient;
    FOnSuccess: TNotifyEvent;
    FTicket: String;
    FPassport: String;
    FPassword: String;
    FAuthData: String;
    FOnError: TNotifyEvent;
    FOnDebug: TDebugEvent;

    procedure GetHeader(Server, Filename: String);
    procedure HTTPSSuccess(Sender: TObject);
    procedure HTTPSError(Sender: TObject);
    procedure ProcessDispatch(Data: String);
    procedure ProcessLogin(Data: String);
    procedure HandleOK(HeaderData: String);
    procedure HandleRedirect(HeaderData: String);
    procedure AddLoginHeaders;
  protected
    procedure DoSuccess;
    procedure DoError;
    procedure DoDebug(DebugText: String);
  public
    property OnSuccess: TNotifyEvent read FOnSuccess write FOnSuccess;
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnDebug: TDebugEvent read FOnDebug write FOnDebug;
    property Ticket: String read FTicket;

    constructor Create; reintroduce;

    procedure GetTicket(Passport, Password, AuthData: String);
    procedure Abort;
  end;

implementation

uses MSNPConstants;

{ TMSNP }

procedure TMSNP.ConnectToNotificationServer(Host: String; Port: Integer);
begin
  FSwitchingServers := True;
  TCPClient.Disconnect;
  FNotificationServerHost := Host;
  FNotificationServerPort := Port;
end;

constructor TMSNP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSessions := TMSNSessions.Create;

  FHTTPSLogon := TMSNHTTPSLogon.Create;
  FHTTPSLogon.OnSuccess := HTTPSLogonSuccess;
  FHTTPSLogon.OnError := HTTPSLogonError;
  FHTTPSLogon.OnDebug := HTTPSDebug;

  FDefaultMessageFont := TFont.Create;

  //Sommige variabelen ook bij TCPClientDisconnected ook resetten
  FPassword := '';
  FPassport := '';
  FDisplayname := '';
  ConnectionState := csDisconnected;
  FStatus := msOffline;
  FAutoOnline := True;
  FAutoSyncLists := True;
  FAutoCloseEmptySessions := True;
  FSynchronisedSettings := False;
  FSettingsVersion := 0;
end;

function TMSNP.CreateSession: TMSNSession;
var
  Session: TMSNSession;
begin
  if ConnectionState <> csReady then
    raise EMSNNotConnected.Create('Not connected');

  Session := NewSession(TransID, stOutgoing);
  SendText('XFR $id SB');

  Result := Session;
end;

destructor TMSNP.Destroy;
begin
  FSessions.Free;
  FHTTPSLogon.Free;
  inherited;
end;

procedure TMSNP.DoNewSession(Session: TMSNSession);
begin
  if Assigned(FOnNewSession) then
    FOnNewSession(Self, Session);
end;

procedure TMSNP.Logon;
begin
  if TCPClient.Connected then
    raise EMSNAlreadyConnected.Create('Already connected');

  TCPClient.Host := MSNServerHost;
  TCPClient.Port := MSNServerPort;

  FServerConnection := scsDispatch;
  TCPClient.Connect;
end;

function TMSNP.NewSession(SessionID: Integer;
  SessionType: TMSNSessionType): TMSNSession;
var
  Session: TMSNSession;
begin
  Session := TMSNSession.Create(Self, SessionType, SessionID,
    FDefaultMessageFont);
  Session.OnDebug := OnDebug;
  FSessions.Add(Session);
  DoNewSession(Session);

  Result := Session;
end;

procedure TMSNP.NewSessionAndConnect(Host: String; Port: Integer;
  Hash: String; SessionID: Integer; SessionType: TMSNSessionType);
var
  Session: TMSNSession;
begin
  //Controleren of er al een sessie aanwezig is met een gelijk ID
  Session := Sessions.FindSession(SessionID);

  //Geen sessie aanwezig, nieuwe maken
  if not Assigned(Session) then
    Session := NewSession(SessionID, SessionType);

  //En verbinding maken
  Session.ConnectToServer(Host, Port, Hash);
end;

procedure TMSNP.Process(Data: String);
var
  OldStatus: TMSNStatus;
  OldDisplayname: String;
  User: TMSNUser;
  List: TMSNList;
begin
  //Protocol handler, misschien een eigen class voor maken

  inherited;

  if RegExMatch('^VER (\d*) (.*)$', Data) then
    SendText(Format('CVR $id 0x0409 win 4.10 i386 MSNMSGR 5.0.0544 MSMSGS %s',
      [FPassport]))
  else if RegExMatch('^CVR (\d*) (.*) (.*) (.*) (.*) (.*)$', Data) then
    SendText(Format('USR $id TWN I %s', [FPassport]))
  else if RegExMatch('^XFR (\d*) NS (.*):(\d*)(\D)', Data) then
    //Volgende server
    ConnectToNotificationServer(RegEx.Match[2], StrToInt(RegEx.Match[3]))
  else if RegExMatch('^USR 5 TWN S (.*)$', Data) then
    //Inlog procedure
    ProcessPassportAuth(RegEx.Match[1])
  else if RegExMatch('^USR (\d*) OK (.*) (.*) (\d) (.*)$', Data) then
  begin
    //Succesvol aangemeld
    FDisplayname := StringDecode(RegEx.Match[3]);
    if ConnectionState <> csReady then
    begin
      ConnectionState := csReady;
      if FAutoSyncLists then
        SyncSettings(FSettingsVersion);
      if FAutoOnline then
        Status := msOnline;
      DoReady;
    end;
  end else if RegExMatch('^CHL (\d*) (.*)$', Data) then
    //Client controle
    SendText(Format('QRY $id msmsgs@msnmsgr.com 32' + CRLF + '%s',
      [MD5Print(MD5String(RegEx.Match[2] + 'Q1P7W2E4J9R8U3S5'))]), False)
  else if RegExMatch('^RNG (\d*) (.*):(\d*) CKI (.*) (.*) (.*)$', Data) then
    //Uitnodiging voor een sessie
    NewSessionAndConnect(RegEx.Match[2], StrToInt(RegEx.Match[3]),
      RegEx.Match[4], StrToInt(RegEx.Match[1]), stIncoming)
  else if RegExMatch('^XFR (\d*) SB (.*):(\d*) CKI (.*)$', Data) then
    //Gegevens voor aangevraagde sessie
    NewSessionAndConnect(RegEx.Match[2], StrToInt(RegEx.Match[3]),
      RegEx.Match[4], StrToInt(RegEx.Match[1]), stOutgoing)
  else if RegExMatch('^CHG (\d*) (NLN|FLN|HDN|IDL|AWY|BSY|BRB|PHN|LUN)$', Data) then
  begin
    //Status van een gebruiker veranderd
    OldStatus := FStatus;
    FStatus := TextToStatus(RegEx.Match[2]);
    DoLocalStatusChange(OldStatus, FStatus);
  end else if RegExMatch('^REA (\d*) (\d*) (.*) (.*)$', Data) then
  begin
    //Gegevens over een gebruiker
    if RegEx.Match[3] = FPassport then
    begin
      OldDisplayname := FDisplayname;
      FDisplayname := StringDecode(RegEx.Match[4]);
      DoLocalDisplaynameChange(OldDisplayname)
    end;
  end else if RegExMatch('^(\d\d\d) (\d*)$', Data) then
    //Server meldt een fout
    SetLastErrorCode(StrToInt(RegEx.Match[1]))
  else if RegExMatch('^FLN (.*)$', Data) then
    //Gebruiker gaat offline
    DoUserOffline(RegEx.Match[1])
  else if RegExMatch('^SYN (\d*) (\d*)$', Data) then
    //Gevraagde server-side gegevens zijn niet veranderd
    DoSettingsUpToDate
  else if RegExMatch('^SYN (\d*) (\d*) (\d*) (\d*)$', Data) then
  begin
    //Gevraagde server-side gegevens zijn veranderd en komen binnen
    FSettingsVersion := StrToInt(FRegEx.Match[2]);
    DoReceivingSettings(StrToInt(FRegEx.Match[3]), StrToInt(FRegEx.Match[4]));
  end else if RegExMatch('^GTC (\d*) (\d*) (A|N)$', Data) then
  begin
    //Instelling mbt het vragen van reverse list bewerkingen
    FSettingsVersion := StrToInt(RegEx.Match[2]);
    if UpperCase(RegEx.Match[3]) = 'A' then
      FPromptOnReverseListAdd := True
    else if UpperCase(RegEx.Match[3]) = 'N' then
      FPromptOnReverseListAdd := False;
  end else if RegExMatch('^BLP (\d*) (\d*) (AL|BL)$', Data) then
  begin
    //Instelling mbt het accepteren van sessies van andere gebruikers
    FSettingsVersion := StrToInt(RegEx.Match[2]);
    if UpperCase(RegEx.Match[3]) = 'AL' then
      FAcceptAllSessions := True
    else if UpperCase(RegEx.Match[3]) = 'BL' then
      FAcceptAllSessions := False;
  end else if RegExMatch('^LSG (\d*) (.*) (\d*)', Data) then
  begin
    //Group record
    ProcessGroupRecord(StrToInt(RegEx.Match[1]), StringDecode(RegEx.Match[2]));
  end else if RegExMatch('^LST (.*) (.*) (\d*)( (.*)$|$)', Data) then
  begin
    //Lijst record\
    if RegEx.SubExprMatchCount = 5 then
      ProcessListRecord(RegEx.Match[1], StringDecode(RegEx.Match[2]),
        StrToInt(RegEx.Match[3]), RegEx.Match[5])
    else
      ProcessListRecord(RegEx.Match[1], StringDecode(RegEx.Match[2]),
        StrToInt(RegEx.Match[3]), '');
  end else if RegExMatch('^ADD (\d*) (RL|FL|AL|BL) (\d*) (.*) (.*)$', Data) then
  begin
    //Gebruiker is toegevoegd aan lijst
    FSettingsVersion := StrToInt(RegEx.Match[3]);
    List := TextToList(RegEx.Match[2]);
    User := TMSNUser.Create(RegEx.Match[4], StringDecode(RegEx.Match[5]));
    try
      DoUserAddedToList(List, User);
    finally
      User.Free;
    end;
  end else if RegExMatch('^REM (\d*) (RL|FL|AL|BL) (\d*) (.*)( (\d*)|$)', Data) then
  begin
    //Gebruiker is verwijderd uit lijst
    FSettingsVersion := StrToInt(RegEx.Match[3]);
    List := TextToList(RegEx.Match[2]);
    DoUserRemovedFromList(List, RegEx.Match[4]);
  end else if RegExMatch('^ILN (\d*) (NLN|FLN|HDN|IDL|AWY|BSY|BRB|PHN|LUN) (.*) (.*) (\d*)$', Data) then
  begin
    //Gebruiker is online
    User := TMSNUser.Create(RegEx.Match[3], StringDecode(RegEx.Match[4]));
    try
      DoUserIsOnline(User, TextToStatus(RegEx.Match[2]));
    finally
      User.Free;
    end;
  end else if RegExMatch('^NLN (NLN|FLN|HDN|IDL|AWY|BSY|BRB|PHN|LUN) (.*) (.*) (\d*)$', Data) then
  begin
    //Gegevens gebruiker updaten
    User := TMSNUser.Create(RegEx.Match[2], StringDecode(RegEx.Match[3]));
    try
      DoUserChange(User, TextToStatus(RegEx.Match[1]));
    finally
      User.Free;
    end;
  end;
end;

procedure TMSNP.SendMessage(Passport, Text: String);
var
  Session: TMSNSession;
begin
  Session := CreateSession;
  Session.InviteUser(Passport);
  Session.SendMessage(Text);
end;

procedure TMSNP.TCPClientConnected(Sender: TObject);
begin
  inherited;

  if FServerConnection = scsDispatch then
    ResetTransID;

  if not FSwitchingServers then
    DoConnected
  else
    FSwitchingServers := False;

  SendText('VER $id MSNP8');
end;

procedure TMSNP.TCPClientDisconnected(Sender: TObject);
begin
  inherited;
  if FSwitchingServers then
  begin
    FServerConnection := scsNotification;
    TCPClient.Host := FNotificationServerHost;
    TCPClient.Port := FNotificationServerPort;
    TCPClient.Connect;
  end
  else
  begin
    FSessions.Clear;
    FHTTPSLogon.Abort;
    FStatus := msOffline;
    FSynchronisedSettings := False;
    FSettingsVersion := 0;
    DoDisconnected;
  end;
end;

procedure TMSNP.DoIncomingMessage(Session: TMSNSession;
  FromUser: TMSNUser; Text: String; Font: TFont);
begin
  if Assigned(FOnIncomingMessage) then
    FOnIncomingMessage(Self, Session, FromUser, Text, Font);
end;

procedure TMSNP.DoSessionReady(Session: TMSNSession);
begin
  if Assigned(FOnSessionReady) then
    FOnSessionReady(Self, Session);
end;

procedure TMSNP.DoTypingUser(Session: TMSNSession; FromUser: TMSNUser;
  TypingPassport: String);
begin
  if Assigned(FOnTypingUser) then
    FOnTypingUser(Self, Session, FromUser, TypingPassport);
end;

procedure TMSNP.DoUserLeaveSession(Session: TMSNSession; User: TMSNUser);
begin
  if Assigned(FOnUserLeaveSession) then
    FOnUserLeaveSession(Self, Session, User);
end;

procedure TMSNP.DoUserEnterSession(Session: TMSNSession;
  User: TMSNUser);
begin
  if Assigned(FOnUserEnterSession) then
    FOnUserEnterSession(Self, Session, User);
end;

procedure TMSNP.SetStatus(const Value: TMSNStatus);
var
  OldStatus: TMSNStatus;
begin
  if Value <> FStatus then
  begin
    if ConnectionState = csDisconnected then
    begin
      //Geen verbinding met server, status gewoon wijzigen
      OldStatus := FStatus;
      FStatus := Value;
      DoLocalStatusChange(OldStatus, FStatus)
    end
    else if ConnectionState = csReady then
      //Status op de server wijzigen
      SendText(Format('CHG $id %s %d', [StatusToText(Value), 32]));
  end;
end;

function TMSNP.StatusToText(MSNStatus: TMSNStatus): String;
begin
  case MSNStatus of
    msOnline: Result := 'NLN';
    msOffline: Result := 'FLN';
    msHidden: Result := 'HDN';
    msIdle: Result := 'IDL';
    msAway: Result := 'AWY';
    msBusy: Result := 'BSY';
    msBRB: Result := 'BRB';
    msPhone: Result := 'PHN';
    msLunch: Result := 'LUN';
  else
    Result := 'NLN';
  end;
end;

function TMSNP.TextToStatus(Text: String): TMSNStatus;
const
  StatusArray: array[0..8] of String =
    ('NLN', 'FLN', 'HDN', 'IDL', 'AWY', 'BSY', 'BRB', 'PHN', 'LUN');
var
  x, Index: Integer;
  NewText: String;
begin
  NewText := UpperCase(Text);
  Index := -1;
  for x := 0 to High(StatusArray) do
  begin
    if NewText = StatusArray[x] then
    begin
      Index := x;
      Break;
    end;
  end;

  case Index of
    0: Result := msOnline;
    1: Result := msOffline;
    2: Result := msHidden;
    3: Result := msIdle;
    4: Result := msAway;
    5: Result := msBusy;
    6: Result := msBRB;
    7: Result := msPhone;
    8: Result := msLunch;
  else
    Result := msOnline;
  end;
end;

procedure TMSNP.DoLocalStatusChange(OldStatus, NewStatus: TMSNStatus);
begin
  if Assigned(FOnLocalStatusChange) then
    FOnLocalStatusChange(Self, OldStatus, NewStatus);
end;

procedure TMSNP.SetDisplayname(const Value: String);
var
  NewDisplayName: String;
begin
  if ConnectionState <> csReady then
    raise EMSNNotConnected.Create('Not connected');

  if Value <> FDisplayname then
  begin
    NewDisplayName := Value;
    NewDisplayName := AnsiToUtf8(NewDisplayName);
    NewDisplayName := StringEncode(NewDisplayName);
    SendText(Format('REA $id %s %s ', [FPassport, NewDisplayName]));
  end;
end;

procedure TMSNP.DoLocalDisplaynameChange(OldDisplayname: String);
begin
  if Assigned(FOnLocalDisplaynameChange) then
    FOnLocalDisplaynameChange(Self, OldDisplayname);
end;

procedure TMSNP.ChangeDisplayname(Passport, Displayname: String);
begin
  if ConnectionState <> csReady then
    raise EMSNNotConnected.Create('Not connected');

  SendText(Format('REA $id %s %s', [Passport, StringEncode(Displayname)]));
end;

procedure TMSNP.DoUserChange(User: TMSNUser; Status: TMSNStatus);
begin
  if Assigned(FOnUserChange) then
    FOnUserChange(Self, User, Status);
end;

procedure TMSNP.SyncSettings(SettingsVersion: Integer);
begin
  if ConnectionState <> csReady then
    raise EMSNNotConnected.Create('Not connected');

  if FSynchronisedSettings then
    raise EMSNAlreadySynchronised.Create('Settings already synchronised');

  SendText(Format('SYN $id %d', [SettingsVersion]));
end;

procedure TMSNP.SetAcceptAllSessions(const Value: Boolean);
begin
  if ConnectionState <> csReady then
    raise EMSNNotConnected.Create('Not connected');

  if Value then
    //Alle binnenkomende sessies accepteren behalve van gebruikers in de block-lijst
    SendText('BLP $id AL')
  else
    //Alle binnenkomende sessies weigeren behalve van gebruikers in de allow-lijst
    SendText('BLP $id BL');
end;

procedure TMSNP.SetLastErrorCode(ErrorCode: Integer);
begin
  FLastErrorCode := ErrorCode;
  DoError(ErrorCode);
end;

procedure TMSNP.DoError(ErrorCode: Integer);
begin
  if csDestroying in ComponentState then Exit;
  if Assigned(FOnError) then
    FOnError(Self, ErrorCode);
end;

procedure TMSNP.DoUserOffline(Passport: String);
begin
  if Assigned(FOnUserOffline) then
    FOnUserOffline(Self, Passport);
end;

procedure TMSNP.DoUserAddedToList(List: TMSNList; User: TMSNUser);
begin
  if Assigned(FOnUserAddedToList) then
    FOnUserAddedToList(Self, List, User);
end;

procedure TMSNP.DoUserRemovedFromList(List: TMSNList; Passport: String);
begin
  if Assigned(FOnUserRemovedFromList) then
    FOnUserRemovedFromList(Self, List, Passport);
end;

function TMSNP.TextToList(Text: String): TMSNList;
var
  NewText: String;
begin
  NewText := UpperCase(Text);
  if NewText = 'RL' then
    Result := blReverseList
  else if NewText = 'AL' then
    Result := blAllowList
  else if NewText = 'BL' then
    Result := blBlockList
  else
    Result := blForwardList;
end;

procedure TMSNP.SetPromptOnReverseListAdd(const Value: Boolean);
begin
  if ConnectionState <> csReady then
    raise EMSNNotConnected.Create('Not connected');

  if Value then
    SendText('GTC $id A')
  else
    SendText('GTC $id N');
end;

procedure TMSNP.DoOutgoingMessage(Session: TMSNSession; Text: String);
begin
  if Assigned(FOnOutgoingMessage) then
    FOnOutgoingMessage(Self, Session, Text);
end;

procedure TMSNP.DoUserIsInSession(Session: TMSNSession; User: TMSNUser);
begin
  if Assigned(FOnUserIsInSession) then
    FOnUserIsInSession(Self, Session, User);
end;

procedure TMSNP.DoReady;
begin
  if Assigned(FOnReady) then
    FOnReady(Self);
end;

procedure TMSNP.DoDisconnected;
begin
  if not (csDestroying in ComponentState) then
    if Assigned(FOnDisconnected) then
      FOnDisconnected(Self);
end;

procedure TMSNP.DoConnected;
begin
  if Assigned(FOnConnected) then
    FOnConnected(Self);
end;

procedure TMSNP.DoMessageNotReceived(Session: TMSNSession);
begin
  if Assigned(FOnMessageNotReceived) then
    FOnMessageNotReceived(Self, Session);
end;

procedure TMSNP.DoSessionConnected(Session: TMSNSession);
begin
  if csDestroying in ComponentState then Exit;
  if Assigned(FOnSessionConnected) then
    FOnSessionConnected(Self, Session);
end;

procedure TMSNP.DoSessionDisconnected(Session: TMSNSession);
begin
  if not (csDestroying in ComponentState) then
    if Assigned(FOnSessionDisconnected) then
      FOnSessionDisconnected(Self, Session);
end;

procedure TMSNP.ProcessPassportAuth(AuthData: String);
begin
  DoDebug('HTTPS passport authentication');
  FHTTPSLogon.GetTicket(FPassport, FPassword, AuthData);
end;

procedure TMSNP.HTTPSLogonError(Sender: TObject);
begin
  DoDebug('HTTPS passport authentication error');
  LogOff;
  DoLoginError;
end;

procedure TMSNP.HTTPSLogonSuccess(Sender: TObject);
begin
  DoDebug('HTTPS passport authentication succeeded');
  SendText(Format('USR 6 TWN S %s', [FHTTPSLogon.Ticket]), True);
end;

procedure TMSNP.HTTPSDebug(Sender: TObject; DebugText: String);
begin
  DoDebug('HTTPS: ' + DebugText);
end;

procedure TMSNP.DoLoginError;
begin
  if Assigned(FOnLoginError) then
    FOnLoginError(Self);
end;

procedure TMSNP.SessionDisconnected(Session: TMSNSession);
begin
  DoSessionDisconnected(Session);
  Session.Free;
end;

procedure TMSNP.ProcessListRecord(Passport, Displayname: String;
  ListNumber: Integer; Groups: String);
var
  User: TMSNUser;
  Lists: TMSNLists;
begin
  Lists := [];
  if ListNumber and 1 = 1 then
    Lists := Lists + [blForwardList];
  if ListNumber and 2 = 2 then
    Lists := Lists + [blAllowList];
  if ListNumber and 4 = 4 then
    Lists := Lists + [blBlockList];
  if ListNumber and 8 = 8 then
    Lists := Lists + [blReverseList];

  User := TMSNUser.Create(Passport, Displayname);
  try
    DoUserIsInList(Lists, User, Groups);
  finally
    User.Free;
  end;
end;

procedure TMSNP.DoUserIsInList(Lists: TMSNLists; User: TMSNUser;
  Groups: String);
begin
  if Assigned(FOnUserIsInList) then
    FOnUserIsInList(Self, Lists, User, Groups);
end;

procedure TMSNP.DoReceivingSettings(UserCount, GroupCount: Integer);
begin
  if Assigned(FOnReceivingSettings) then
    FOnReceivingSettings(Self, UserCount, GroupCount);
end;

procedure TMSNP.DoSettingsUpToDate;
begin
  if Assigned(FOnSettingsUpToDate) then
    FOnSettingsUpToDate(Self);
end;

procedure TMSNP.RemoveUserFromList(List: TMSNList; Passport: String);
begin
  if ConnectionState <> csReady then
    raise EMSNNotConnected.Create('Not connected');

  SendText(Format('REM $id %s %s', [ListToText(List), Passport]));
end;

procedure TMSNP.AddUserToList(List: TMSNList; Passport, Displayname: String);
begin
  if ConnectionState <> csReady then
    raise EMSNNotConnected.Create('Not connected');

  SendText(Format('ADD $id %s %s %s', [ListToText(List), Passport,
    StringEncode(Displayname)]));
end;

function TMSNP.ListToText(List: TMSNList): String;
begin
  case List of
    blForwardList: Result := 'FL';
    blReverseList: Result := 'RL';
    blAllowList: Result := 'AL';
    blBlockList: Result := 'BL';
  else
    Result := '';
  end;
end;

procedure TMSNP.SetDefaultMessageFont(const Value: TFont);
begin
  FDefaultMessageFont.Assign(Value);
end;

procedure TMSNP.ProcessMessage(MSNMessage: TMSNMessage);
begin
  DoMessage(MSNMessage);
end;

procedure TMSNP.DoMessage(MSNMessage: TMSNMessage);
begin
  if Assigned(FOnMessage) then
    FOnMessage(Self, MSNMessage);
end;

procedure TMSNP.DoUserIsOnline(User: TMSNUser; Status: TMSNStatus);
begin
  if Assigned(FOnUserIsOnline) then
    FOnUserIsOnline(Self, User, Status);
end;

procedure TMSNP.ProcessGroupRecord(Id: Integer; Title: String);
begin
  DoUserGroup(Id, Title);
end;

procedure TMSNP.DoUserGroup(Id: Integer; Title: String);
begin
  if Assigned(FOnUserGroup) then
    FOnUserGroup(Self, Id, Title);
end;

{ TMSNSession }

procedure TMSNSession.AddUser(Passport, Displayname: String; Invited: Boolean);
var
  User: TMSNUser;
begin
  if FindUser(Passport) = nil then
  begin
    User := TMSNUser.Create(Passport, Displayname);
    FUsers.Add(User);
    if Invited then
      FMSNP.DoUserEnterSession(Self, User)
    else
      FMSNP.DoUserIsInSession(Self, User);
  end;
end;

constructor TMSNSession.Create(MSNP: TMSNP; SessionType: TMSNSessionType;
  SessionID: Integer; DefaultFont: TFont);
begin
  inherited Create(nil);

  FUsers := TObjectList.Create(False);
  FMessagesToSend := TStringList.Create;
  FPassportsToInvite := TStringList.Create;
  FMessageFont := TFont.Create;
  FMessageFont.Assign(DefaultFont);

  FMSNP := MSNP;
  FSessionID := SessionID;
  FHash := '';
  FSessionType := SessionType;
  FData := nil;
end;

destructor TMSNSession.Destroy;
begin
  FMSNP.Sessions.Remove(Self);

  FUsers.Free;
  FMessagesToSend.Free;
  FPassportsToInvite.Free;
  FMessageFont.Free;

  inherited;
end;

procedure TMSNSession.InviteUser(Passport: String);
begin
  if ConnectionState <> csReady then
    FPassportsToInvite.Append(Passport)
  else
    SendText(Format('CAL $id %s', [Passport]));
end;

function TMSNSession.FindUser(Passport: String): TMSNUser;
var
  x: Integer;
begin
  Result := nil;
  for x := 0 to UserCount  - 1 do
  begin
    if User[x].Passport = Passport then
    begin
      Result := User[x];
      Break;
    end;
  end;
end;

procedure TMSNSession.Process(Data: String);
begin
  inherited;

  if RegExMatch('^ANS (\d*) OK$', Data) then
  begin
    //Aangemeld in een bestaande sessie
    ConnectionState := csReady;
    FlushMessagesToSend;
    FMSNP.DoSessionReady(Self);
  end else if RegExMatch('^USR (\d*) OK (.*) (.*)$', Data) then
  begin
    //Aangemeld in een nieuwe sessie
    ConnectionState := csReady;
    FlushPassportsToInvite;
    FMSNP.DoSessionReady(Self);
  end else if RegExMatch('^IRO (\d*) (\d*) (\d*) (.*) (.*)$', Data) then
  begin
    //Gebruiker al aanwezig in huidige sessie
    AddUser(RegEx.Match[4], StringDecode(RegEx.Match[5]), False);
  end else if RegExMatch('^JOI (.*) (.*)$', Data) then
  begin
    //De uitgenodigde gebruiker is aanwezig in sessie
    AddUser(RegEx.Match[1], StringDecode(RegEx.Match[2]), True);
    FlushMessagesToSend;
  end else if RegExMatch('^BYE (.*)$', Data) then
  begin
    //Gebruiker heeft er genoeg van en verlaat de sessie :-)
    RemoveUser(RegEx.Match[1]);
  end else if RegExMatch('^BYE (.*) 1$', Data) then
  begin
    //Server heeft een gebruiker verwijderd
    RemoveUser(RegEx.Match[1]);
  end else if RegExMatch('^NAK (.*)$', Data) then
  begin
    //Een verzonden bericht is niet aangekomen
    FMSNP.DoMessageNotReceived(Self);
  end;
end;

procedure TMSNSession.RemoveUser(Passport: String);
var
  User: TMSNUser;
begin
  User := FindUser(Passport);
  if Assigned(User) then
  begin
    FUsers.Remove(User);
    if (FMSNP.AutoCloseEmptySessions) and (FUsers.Count = 0) then
      LogOff;
    FMSNP.DoUserLeaveSession(Self, User);
    User.Free;
  end;
end;

procedure TMSNSession.SendMessage(Text: String);
var
  MessageData: String;
begin
  if ConnectionState <> csReady then
    FMessagesToSend.Append(Text)
  else
  begin
    if UserCount = 0 then Exit;

    MessageData := GetMessageData(Text);

    if Length(MessageData) > MaxMSNMessageLength then
      raise EMSNMaximumMessageLentghReached.Create('Maximum message length ' +
        'reached');

    SendText(Format('MSG $id N %d' + CRLF + '%s',
      [Length(MessageData), MessageData]), False);
    FMSNP.DoOutgoingMessage(Self, Text);
  end;
end;

procedure TMSNSession.TCPClientConnected(Sender: TObject);
begin
  inherited;
  FMSNP.DoSessionConnected(Self);

  case FSessionType of
    stIncoming: SendText(Format('ANS $id %s %s %d',
      [FMSNP.Passport, FHash, FSessionID]));
    stOutgoing: SendText(Format('USR $id %s %s', [FMSNP.Passport, FHash]));
  end;
end;

procedure TMSNSession.TCPClientDisconnected(Sender: TObject);
begin
  inherited;
  FMSNP.SessionDisconnected(Self);
end;

function TMSNSession.GetUser(Index: Integer): TMSNUser;
begin
  Result := TMSNUser(FUsers.Items[Index]);
end;

function TMSNSession.GetUserCount: Integer;
begin
  Result := FUsers.Count;
end;

procedure TMSNSession.ConnectToServer(Host: String; Port: Integer;
  Hash: String);
begin
  if not TCPClient.Connected then
  begin
    FHash := Hash;
    TCPClient.Host := Host;
    TCPClient.Port := Port;
    TCPClient.Connect;
  end;
end;

procedure TMSNSession.FlushMessagesToSend;
begin
  //First-in-first-out
  while FMessagesToSend.Count > 0 do
  begin
    SendMessage(FMessagesToSend.Strings[0]);
    FMessagesToSend.Delete(0);
  end;
end;

procedure TMSNSession.FlushPassportsToInvite;
begin
  //First-in-first-out
  while FPassportsToInvite.Count > 0 do
  begin
    InviteUser(FPassportsToInvite.Strings[0]);
    FPassportsToInvite.Delete(0);
  end;
end;

procedure TMSNSession.ProcessMessage(MSNMessage: TMSNMessage);
var
  User: TMSNUser;
begin
  User := FindUser(MSNMessage.FromPassport);

  if MSNMessage.ContentType = 'text/plain' then
    ProcessInstantMessage(User, MSNMessage.Header, MSNMessage.Content)
  else if MSNMessage.ContentType = 'text/x-msmsgscontrol' then
  begin
    RegEx.Expression := 'TypingUser: (.*)($|\r\n| )';
    if RegEx.Exec(MSNMessage.Header) then
      FMSNP.DoTypingUser(Self, User, RegEx.Match[1])
    else
      FMSNP.DoTypingUser(Self, User, '');
  end;
end;

procedure TMSNSession.TypingUser(Passport: String);
var
  TypingUserData: String;
  MessageData: String;
begin
  if ConnectionState <> csReady then
    raise EMSNNotConnected.Create('Not connected');

  TypingUserData := 'MIME-Version: 1.0' + CRLF +
    'Content-Type: text/x-msmsgscontrol' + CRLF +
    'TypingUser: %s' + CRLF + CRLF;
  MessageData := Format(TypingUserData, [Passport]);

  SendText(Format('MSG $id U %d' + CRLF + '%s',
    [Length(MessageData), MessageData]), False);
end;

function TMSNSession.GetMessageData(MessageText: String): String;
var
  MessageHeaderData: String;
begin
  MessageHeaderData := 'MIME-Version: 1.0' + CRLF +
    'Content-Type: text/plain; charset=UTF-8' + CRLF +
    'X-MMS-IM-Format: FN=%s; EF=%s; CO=%s; CS=%s; PF=%s';

  MessageHeaderData := Format(MessageHeaderData,
    [StringEncode(FMessageFont.Name), FontStyleToStr(FMessageFont.Style),
    FontColorToStr(FMessageFont.Color), IntToHex(FMessageFont.Charset, 2),
    '0' + FontPitchToStr(FMessageFont.Pitch)]);

  Result := Result + MessageHeaderData + CRLF + CRLF + MessageText;
end;

function TMSNSession.StrToFontStyle(Str: String): TFontStyles;
var
  NewStr: String;
begin
  Result := [];
  NewStr := UpperCase(Str);
  if Pos('B', NewStr) > 0 then
    Result := Result + [fsBold];
  if Pos('I', NewStr) > 0 then
    Result := Result + [fsItalic];
  if Pos('S', NewStr) > 0 then
    Result := Result + [fsStrikeOut];
  if Pos('U', NewStr) > 0 then
    Result := Result + [fsUnderline];
end;

function TMSNSession.FontColorToStr(Color: TColor): String;
begin
  Result := Format('%.2x%.2x%.2x', [GetRValue(Color), GetGValue(Color),
    GetBValue(Color)]);
end;

function TMSNSession.FontStyleToStr(FontStyle: TFontStyles): String;
begin
  Result := '';
  if fsBold in FontStyle then
    Result := Result + 'B';
  if fsItalic in FontStyle then
    Result := Result + 'I';
  if fsUnderline in FontStyle then
    Result := Result + 'U';
  if fsStrikeOut in FontStyle then
    Result := Result + 'S';
end;

function TMSNSession.StrToFontColor(Str: String): TColor;
var
  NewStr: String;
begin
  NewStr := UpperCase(Str);
  while Length(NewStr) < 6 do
    NewStr := '0' + NewStr;
  Result := StringToColor('$00' + NewStr);
end;

procedure TMSNSession.ProcessInstantMessage(User: TMSNUser; Header,
  Content: String);
var
  Font: TFont;
begin
  Font := TFont.Create;
  try
    RegEx.Expression := 'X-MMS-IM-Format: (.*)';
    if RegEx.Exec(Header) then
    begin
      RegEx.Expression := 'FN=(.*);';
      if RegEx.Exec(Header) then
        Font.Name := StringDecode(RegEx.Match[1]);
      RegEx.Expression := 'EF=(.*);';
      if RegEx.Exec(Header) then
        Font.Style := StrToFontStyle(RegEx.Match[1]);
      RegEx.Expression := 'CO=(.*);';
      if RegEx.Exec(Header) then
        Font.Color := StrToFontColor(RegEx.Match[1]);
    end;

    FMSNP.DoIncomingMessage(Self, User, Content, Font);
  finally
    Font.Free;
  end;
end;

function TMSNSession.GetIndex: Integer;
begin
  Result := FMSNP.Sessions.IndexOf(Self);
end;

function TMSNSession.FontPitchToStr(FontPitch: TFontPitch): String;
begin
  case FontPitch of
    fpDefault: Result := '0';
    fpVariable: Result := '2';
    fpFixed: Result := '1';
  end;
end;

{ TMSNBase }

constructor TMSNBase.Create(AOwner: TComponent);
begin
  inherited;

  FTCPClient := TTCPClient.Create(nil);
  FTCPClient.OnConnected := TCPClientConnected;
  FTCPClient.OnDisconnected := TCPClientDisconnected;
  FTCPClient.OnDataAvailable := TCPClientDataAvailable;

  FMSNMessage := TMSNMessage.Create;
  FMSNMessage.OnComplete := MSNMessageComplete;

  ResetTransID;
  FInMessageMode := False;
end;

destructor TMSNBase.Destroy;
begin
  LogOff;
  FTCPClient.Free;
  FMSNMessage.Free;
  inherited;
end;

procedure TMSNBase.DoDebug(DebugText: String);
begin
  if csDestroying in ComponentState then Exit;
  if Assigned(FOnDebug) then
    FOnDebug(Self, DebugText);
end;

procedure TMSNBase.IncrementTransID;
begin
  Inc(FTransID);
end;

procedure TMSNBase.LogOff;
begin
  if TCPClient.Connected then
  begin
    if FConnectionState = csReady then
      SendText('OUT');
    TCPClient.Disconnect;
  end;
end;

procedure TMSNBase.Process(Data: String);
begin
  DoDebug('< ' + Data);
  RegEx.Expression := '^MSG (.*) (.*) (\d*)$';
  if RegEx.Exec(Data) then
  begin
    FInMessageMode := True;
    FMSNMessage.FromPassport := RegEx.Match[1];
    FMSNMessage.FromDisplayname := StringDecode(RegEx.Match[2]);
    FMSNMessage.DataSize := StrToInt(RegEx.Match[3]);
  end;
end;

procedure TMSNBase.ResetTransID;
begin
  FTransID := 0;
end;

procedure TMSNBase.SendText(Text: String; AddCRLF: Boolean);
var
  LineToSend: String;
begin
  LineToSend := Text;
  if Pos('$id', LineToSend) > 0 then
  begin
    LineToSend := StringReplace(Text, '$id', IntToStr(TransID), []);
    IncrementTransID;
  end;

  DoDebug('> ' + LineToSend);

  if AddCRLF then
    TCPClient.WriteLn(LineToSend)
  else
    TCPClient.Write(LineToSend);
end;

procedure TMSNBase.SetConnectionState(const Value: TConnectionState);
begin
  if Value <> FConnectionState then
    FConnectionState := Value;
end;

procedure TMSNBase.TCPClientConnected(Sender: TObject);
begin
  ConnectionState := csConnected;
  DoDebug(Format('*** Connected to %s:%d', [TCPClient.Host, TCPClient.Port]));
end;

procedure TMSNBase.TCPClientDataAvailable(Sender: TObject);
var
  Data: String;
begin
  try
    if not FInMessageMode then
      Data := TCPClient.ReadLn('', 1000)
    else
      Data := TCPClient.ReadString(FMSNMessage.DataSize);
  except
    TCPClient.Disconnect;
    Exit;
  end;

  if not FInMessageMode then
    Process(Data)
  else
    FMSNMessage.AddData(Data);
end;

procedure TMSNBase.TCPClientDisconnected(Sender: TObject);
begin
  ConnectionState := csDisconnected;
  DoDebug('*** Disconnected');
end;

{ TMSNSessionUser }

constructor TMSNUser.Create(Passport, Displayname: String);
begin
  inherited Create;

  FPassport := Passport;
  FDisplayname := Displayname;
end;

procedure TMSNBase.MSNMessageComplete(Sender: TObject);
begin
  FInMessageMode := False;
  DoDebug(Format('MSNMessage' + #13#10 +
    'FromDisplayname: %s'  + #13#10 +
    'FromPassport: %s' + #13#10 +
    'ContentType: %s' + #13#10 +
    'Header: %s' + #13#10 +
    'Content: %s',
    [FMSNMessage.FFromDisplayname, FMSNMessage.FFromPassport,
      FMSNMessage.FContentType, FMSNMessage.FHeader, FMSNMessage.FContent]));
  ProcessMessage(FMSNMessage);
end;

{ TMSNSessions }

procedure TMSNSessions.Add(Session: TMSNSession);
begin
  FList.Add(Session);
end;

procedure TMSNSessions.Clear;
var
  x: Integer;
begin
  for x := 0 to Count - 1 do
    Items[x].LogOff;
end;

constructor TMSNSessions.Create;
begin
  inherited;
  FList := TObjectList.Create(False);
end;

destructor TMSNSessions.Destroy;
begin
  FList.Clear;
{  if FList.Count > 0 then
    OutputDebugString('TMSNSessions not empty by Destroy');}
  FList.Free;
  inherited;
end;

function TMSNSessions.FindSession(SessionID: Integer): TMSNSession;
var
  x: Integer;
begin
  Result := nil;
  for x := 0 to Count - 1 do
  begin
    if Items[x].SessiondID = SessionID then
    begin
      Result := Items[x];
      Break;
    end;
  end;
end;

function TMSNSessions.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TMSNSessions.GetItem(Index: Integer): TMSNSession;
begin
  Result := FList.Items[Index] as TMSNSession;
end;

function TMSNSessions.IndexOf(Session: TMSNSession): Integer;
begin
  Result := FList.IndexOf(Session);
end;

procedure TMSNSessions.Remove(Session: TMSNSession);
begin
  FList.Remove(Session);
end;

{ TMSNHTTPSLogon }

procedure TMSNHTTPSLogon.Abort;
begin
  FHTTPSClient.Abort;
end;

procedure TMSNHTTPSLogon.AddLoginHeaders;
var
  Passport: String;
  Password: String;
begin
  Passport := StringReplace(FPassport, '@', '%40', [rfReplaceAll]);
  Password := FPassword; //Need URL encoding
  FHTTPSClient.Headers.Append(Format('Authorization: Passport1.4 ' +
    'OrgVerb=GET,OrgURL=http%%3A%%2F%%2Fmessenger%%2Emsn%%2Ecom,' +
    'sign-in=%s,pwd=%s,%s', [Passport, Password, FAuthData]));
end;

constructor TMSNHTTPSLogon.Create;
begin
  inherited Create(nil);
  FHTTPSClient := THTTPSClient.Create;
  FHTTPSClient.OnError := HTTPSError;
  FHTTPSClient.OnSuccess := HTTPSSuccess;
end;

procedure TMSNHTTPSLogon.DoDebug(DebugText: String);
begin
  if Assigned(FOnDebug) then
    FOnDebug(Self, DebugText);
end;

procedure TMSNHTTPSLogon.DoError;
begin
  if Assigned(FOnError) then
    FOnError(Self);
end;

procedure TMSNHTTPSLogon.DoSuccess;
begin
  if Assigned(FOnSuccess) then
    FOnSuccess(Self);
end;

procedure TMSNHTTPSLogon.GetHeader(Server, Filename: String);
var
  DebugText: String;
begin
  DebugText := Format('GetHeader: Server: %s, Filename: %s',
    [Server, Filename]);
  if FHTTPSClient.Headers.Count > 0 then
    DebugText := DebugText + ', Extra headers: ' + FHTTPSClient.Headers.Text;

  DoDebug(DebugText);
  FHTTPSClient.GetHeader(Server, Filename);
end;

procedure TMSNHTTPSLogon.GetTicket(Passport, Password, AuthData: String);
begin
  FPassport := Passport;
  FPassword := Password;
  FAuthData := AuthData;
  FConnectionState := scDispatch;
  GetHeader('nexus.passport.com', '/rdr/pprdr.asp');
end;

procedure TMSNHTTPSLogon.HandleOK(HeaderData: String);
begin
  DoDebug('HandleOK');
  case FConnectionState of
    scDispatch: ProcessDispatch(FHTTPSClient.HeaderData);
    scLogin: ProcessLogin(FHTTPSClient.HeaderData);
  end;
end;

procedure TMSNHTTPSLogon.HandleRedirect(HeaderData: String);
begin
  DoDebug('HandleRedirect');
  RegEx.Expression := 'Location: https://(.*)/(.*)\r\n';
  if RegEx.Exec(HeaderData) then
  begin
    AddLoginHeaders;
    GetHeader(RegEx.Match[1], RegEx.Match[2])
  end
  else
    DoError;
end;

procedure TMSNHTTPSLogon.HTTPSError(Sender: TObject);
begin
  DoDebug('Error');
  DoError;
end;

procedure TMSNHTTPSLogon.HTTPSSuccess(Sender: TObject);
begin
  DoDebug(Format('Success: StatusCode: %d, HeaderData:' + #13#10 + '%s',
    [FHTTPSClient.StatusCode, FHTTPSClient.HeaderData]));
  case FHTTPSClient.StatusCode of
    200: HandleOK(FHTTPSClient.HeaderData); //HTTP_STATUS_OK
    302: HandleRedirect(FHTTPSClient.HeaderData); //HTTP_STATUS_REDIRECT
  else
    DoError;
  end;
end;

procedure TMSNHTTPSLogon.ProcessDispatch(Data: String);
begin
  DoDebug('ProcessDispatch');
  RegEx.Expression := 'DALogin=(.*)/(.*)(,|\r\n)';
  if RegEx.Exec(Data) then
  begin
    FConnectionState := scLogin;
    AddLoginHeaders;
    GetHeader(RegEx.Match[1], '/' + RegEx.Match[2]);
  end
  else
    DoError;
end;

procedure TMSNHTTPSLogon.ProcessLogin(Data: String);
begin
  DoDebug('ProcessLogin');
  RegEx.Expression := 'from-PP=''(.*)''';
  if RegEx.Exec(Data) then
  begin
    FTicket := RegEx.Match[1];
    DoSuccess;
  end
  else
    DoError;
end;

{ TMSNMessage }

procedure TMSNMessage.AddData(Data: String);
begin
  FData := FData + Data;
  if Length(FData) >= FDataSize then
    DataComplete;
end;

constructor TMSNMessage.Create;
begin
  inherited Create(nil);
  FDataSize := 0;
end;

procedure TMSNMessage.DataComplete;
begin
  GetContentType;
  SplitHeaderAndContent;
  DoComplete;
  FData := '';
end;

procedure TMSNMessage.DoComplete;
begin
  if Assigned(FOnComplete) then
    FOnComplete(Self);
end;

procedure TMSNMessage.GetContentType;
begin
  RegEx.Expression := 'Content-Type: (.*)($|;|\r\n)';
  if RegEx.Exec(FData) then
    FContentType := RegEx.Match[1]
  else
    FContentType := '';
end;

procedure TMSNMessage.SplitHeaderAndContent;
begin
  RegEx.Expression := '^(.*)\r\n\r\n(.*)$';
  if RegEx.Exec(FData) then
  begin
    FHeader := Trim(RegEx.Match[1]);
    FContent := Trim(RegEx.Match[2]);
  end
  else
  begin
    FHeader := '';
    FContent := FData;
  end;
end;

{ TMSNDataComponent }

constructor TMSNDataComponent.Create(AOwner: TComponent);
begin
  inherited;
  FRegEx := TRegExpr.Create;
  FRegEx.ModifierI := True;
  FRegEx.ModifierR := False;
  FRegEx.ModifierS := True;
  FRegEx.ModifierG := False;
  FRegEx.ModifierM := False;
  FRegEx.ModifierX := False;
end;

destructor TMSNDataComponent.Destroy;
begin
  FRegEx.Free;
  inherited;
end;

function TMSNDataComponent.RegExMatch(Expression, Str: String): Boolean;
begin
  RegEx.Expression := Expression;
  Result := RegEx.Exec(Str);
end;

function TMSNDataComponent.StringDecode(Str: String): String;
begin
  Result := Str;
  Result := TIdURI.URLDecode(Result);
  Result := Utf8ToAnsi(Result);
end;

function TMSNDataComponent.StringEncode(Str: String): String;
begin
  Result := TIdURI.PathEncode(Str);
end;

end.
