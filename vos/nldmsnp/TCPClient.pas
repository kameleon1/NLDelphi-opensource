unit TCPClient;

interface

uses
  Windows, SysUtils, Classes, IdTCPClient, IdGlobal, IdTCPConnection,
  IdException, IdResourceStrings;

type
  TTCPDataAvailableEvent = procedure(Sender: TObject) of object;
  TTCPConnectErrorEvent = procedure(Sender: TObject) of object;

type
  TTCPClient = class;

  TTCPClientThread = class(TThread)
  private
    FTCPClient: TTCPClient;
    FConnectTimeOut: Integer;
    FLastBufferSize: Integer;
    procedure Disconnected;
  protected
    procedure Execute; override;
    procedure ResetLastBufferSize;
  public
    constructor Create(TCPClient: TTCPClient;
      ConnectTimeOut: Integer); reintroduce;
  end;

  TTCPClient = class(TIdTCPClient)
  private
    FOnDataAvailable: TTCPDataAvailableEvent;
    FThread: TTCPClientThread;
    FOnConnectError: TTCPConnectErrorEvent;
    FOnDisconnected: TNotifyEvent;
  protected
    procedure InternalDisconnect; virtual;
    procedure InternalConnect(const ATimeout: Integer = IdTimeoutDefault); virtual;
    procedure Disconnected;
    procedure DoDataAvailableEvent; virtual;
    procedure DoConnectErrorEvent; virtual;
    procedure DoDisconnectedEvent; virtual;
    procedure DoConnectedEvent; virtual;
    procedure DoOnConnected; override;
    procedure DoOnDisconnected; override;
  public
    property OnDataAvailable: TTCPDataAvailableEvent read FOnDataAvailable
      write FOnDataAvailable;
    property OnConnectError: TTCPConnectErrorEvent read FOnConnectError
      write FOnConnectError;
    property OnDisconnected: TNotifyEvent read FOnDisconnected
      write FOnDisconnected;

    destructor Destroy; override;

    procedure Connect(const ATimeout: Integer = IdTimeoutDefault); override;
    procedure Disconnect; override;
    function ReadFromStack(const ARaiseExceptionIfDisconnected: Boolean = True;
     ATimeout: Integer = IdTimeoutDefault;
     const ARaiseExceptionOnTimeout: Boolean = True): Integer; override;
  end;

implementation

{ TTCPClientThread }

constructor TTCPClientThread.Create(TCPClient: TTCPClient;
  ConnectTimeOut: Integer);
begin
  inherited Create(True);
  FTCPClient := TCPClient;
  FreeOnTerminate := True;
  FConnectTimeOut := ConnectTimeOut;
  Resume;
end;

procedure TTCPClientThread.Disconnected;
begin
  Synchronize(FTCPClient.Disconnected);
end;

procedure TTCPClientThread.Execute;
var
  MustFreeIOHandler: Boolean;
  BufferSize: Integer;
begin
  MustFreeIOHandler := False;
  try
    MustFreeIOHandler := FTCPClient.FFreeIOHandlerOnDisconnect;
    FTCPClient.FFreeIOHandlerOnDisconnect := False;

    try
      FTCPClient.InternalConnect(FConnectTimeOut);
    except
      Synchronize(FTCPClient.DoConnectErrorEvent);
      raise;
    end;

    Synchronize(FTCPClient.DoConnectedEvent);

    while FTCPClient.Connected do
    begin
      BufferSize := FTCPClient.InputBuffer.Size;
      if (BufferSize = 0) or (BufferSize = FLastBufferSize) then
        FLastBufferSize := BufferSize + FTCPClient.ReadFromStack(True)
      else
        FLastBufferSize := BufferSize;
      Synchronize(FTCPClient.DoDataAvailableEvent);
    end;
    raise EIdConnClosedGracefully.Create(RSConnectionClosedGracefully);
  except
    try
      if FTCPClient.Connected then
        FTCPClient.InternalDisconnect;
    except

    end;

    if MustFreeIOHandler then
      FreeAndNil(FTCPClient.FIOHandler);

    try
      Disconnected;
    except

    end;
  end;
end;

procedure TTCPClientThread.ResetLastBufferSize;
begin
  FLastBufferSize := 0;
end;

{ TTCPClient }

procedure TTCPClient.Connect(const ATimeout: Integer);
begin
  if not Assigned(FThread) then
    FThread := TTCPClientThread.Create(Self, ATimeOut);
end;

destructor TTCPClient.Destroy;
var
  Thread: TTCPClientThread;
begin
  FOnConnected := nil;
  FOnConnectError := nil;
  FOnDisconnected := nil;
  FOnDataAvailable := nil;

  Thread := FThread;
  if Assigned(Thread) then
  begin
    Thread.FreeOnTerminate := False;
    try
      if Connected then
        inherited Disconnect;
    except

    end;
    Thread.WaitFor;
    Thread.Free;
  end;

  inherited;
end;

procedure TTCPClient.Disconnect;
begin
  if Assigned(FThread) then
    inherited;
end;

procedure TTCPClient.Disconnected;
begin
  FThread := nil;
  DoDisconnectedEvent;
end;

procedure TTCPClient.DoConnectedEvent;
begin
  if Assigned(FOnConnected) then
    FOnConnected(Self);
end;

procedure TTCPClient.DoConnectErrorEvent;
begin
  if Assigned(FOnConnectError) then
    FOnConnectError(Self);
end;

procedure TTCPClient.DoDataAvailableEvent;
begin
  if Assigned(FOnDataAvailable) then
    FOnDataAvailable(Self);
end;

procedure TTCPClient.DoDisconnectedEvent;
begin
  if Assigned(FOnDisconnected) then
    FOnDisconnected(Self);
end;

procedure TTCPClient.DoOnConnected;
begin
  //Ignore
end;

procedure TTCPClient.DoOnDisconnected;
begin
  //Ignore
end;

procedure TTCPClient.InternalConnect(const ATimeout: Integer);
begin
  inherited Connect(ATimeout);
end;

procedure TTCPClient.InternalDisconnect;
begin
  inherited Disconnect;
end;

function TTCPClient.ReadFromStack(
  const ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer;
  const ARaiseExceptionOnTimeout: Boolean): Integer;
begin
  FThread.ResetLastBufferSize;
  Result := inherited ReadFromStack(ARaiseExceptionIfDisconnected, ATimeout,
    ARaiseExceptionOnTimeout);
end;

end.

