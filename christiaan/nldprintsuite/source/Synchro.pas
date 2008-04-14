//******************************************************************************
//                                                                             *
//    Original Borland's SyncObjs, I added some new features                   *
//                                                                             *
//    Copyright © 1999-2001 by Lucian Radulescu                                *
//    mailto  :  lucian@ez-delphi.com                                          *
//    http    :  http://www.ez-delphi.com                                      *
//                                                                             *
//******************************************************************************

// -----------------------------------------------------------------------------
//  TObject
//     |
//     +-- TSynchroObject
//     |     |
//     |     +-- TCriticalSection                            
//     |     |    |
//     |     |    +-- TValueCriticalSection
//     |     |    |      |
//     |     |    |      +-- TIntCriticalSection
//     |     |    |      +-- TBoolCriticalSection
//     |     |    |      +-- TGlobalPtrCriticalSection
//     |     |    |
//     |     |    +-- TThreadStrings
//     |     |
//     |     +-- TMREWS
//     |     |    |
//     |     |    +-- TMREWSIntValue
//     |     |
//     |     +-- THandleObject
//     |     |    |
//     |     |    +-- TEvent
//     |     |    |      |
//     |     |    |      +-- TSimpleEvent
//     |     |    |      +-- TMREWS_Event
//     |     |    |
//     |     |    +-- TMultipleHandleObject
//     |     |           +-- TPrinterChangeNotify
//     |     |           |
//     |     |           +-- TFileChangeNotify
//     |     |
//     |     +-- TSemaphore
//     |     |    |
//     |     |    +-- TSemaphoreLink
//     |     |
//     |     +-- TMutex
//     |
//     +-- THandleArray
//           |
//           +-- TMutexArray
//
// -----------------------------------------------------------------------------

unit Synchro;

{$H+,X+}

interface

uses

  {$IFDEF MSWINDOWS} Windows,
                     Messages,
                     WinSpool,
                     Forms,
  {$ENDIF MSWINDOWS}

  {$IFDEF LINUX}     Libc,
  {$ENDIF LINUX}

  SysUtils, Classes;

const
  SYNC_OUT_OF_STRINGS = #255;

type

  TProcData                    = procedure ( Data: Pointer );
  TClassMethod                 = procedure of object;
  TSynchronizedMethod          = procedure ( Data: Pointer ) of object;
  TSynchronizedMsgMethod       = procedure ( wParam, lParam: Longint ) of object;
  TNotifySynchronizedMethod    = procedure ( Sender: TObject; Data: Pointer ) of object;
  TNotifySynchronizedMsgMethod = procedure ( Sender: TObject; wParam, lParam: Longint ) of object;

  TWaitResult = ( wrSignaled, wrInput, wrTimeout, wrAbandoned, wrError );

  // TSynchroObject
  TSynchroObject = class( TObject )
  protected
    procedure     Acquire; virtual;
    procedure     Release; virtual;
  end;

  // THandleObject
  THandleObject = class( TSynchroObject )
  {$IFDEF MSWINDOWS}
  private
    FHandle     : THandle;
    FLastError  : Integer;
  protected
    procedure     ReleaseHandle; virtual;
  public
    destructor    Destroy; override;
    function      Signaled: Boolean; overload; dynamic;
    function      Signaled( Timeout: LongWord ): Boolean; overload; dynamic; 
    function      MsgWaitFor( Timeout: LongWord = 0 ): TWaitResult; dynamic;
    function      WaitFor( Timeout: LongWord = 0 ): TWaitResult; dynamic;
    property      LastError: Integer read FLastError;
    property      Handle: THandle read FHandle;
  {$ENDIF MSWINDOWS}
  end;

  {$IFDEF MSWINDOWS}
  // TSemaphore
  TSemaphore = class( THandleObject )
  private
    FOnRelease: TNotifyEvent;
  public
    constructor Create( Attributes: PSecurityAttributes; InitialCount, MaximumCount: Longint; Name: PChar );
    function ReleaseSemaphore( ReleaseCount: Longint; lpPreviousCount: PLongint ): Boolean;
    procedure Release; override;
    property OnRelease: TNotifyEvent read FOnRelease write FOnRelease;
  end;
  {$ENDIF MSWINDOWS}

  // TMutex
  TMutex = class( THandleObject )
  protected
    procedure     ReleaseHandle; override;
  public
    constructor Create( Attributes: PSecurityAttributes; InitialOwner: Boolean;
                       Name: PChar );
    function ReleaseMutex: Boolean;
  end;

  // TEvent
  TEvent = class(THandleObject)
  {$IFDEF LINUX}
  private
    FEvent      : TSemaphore;
  {$ENDIF LINUX}
  public
    constructor   Create( {$IFDEF MSWINDOWS} Attributes: PSecurityAttributes;
                          {$ENDIF MSWINDOWS}
                          ManualReset, InitialState: Boolean; Name: PChar );
    {$IFDEF MSWINDOWS}
    function      PulseEvent: Boolean; virtual;
    {$ENDIF MSWINDOWS}
    function      SetEvent: Boolean; virtual;
    function      ResetEvent: Boolean; virtual;
    {$IFDEF LINUX}
    function      WaitFor( Timeout: LongWord = 0 ): TWaitResult; override;
    {$ENDIF LINUX}
  end;

  // TSimpleEvent
  TSimpleEvent = class(TEvent)
  public
    constructor Create;
  end;

  // TMREWS_Event
  TMREWS_Event = class( TEvent )
  private
    FLock    : TMultiReadExclusiveWriteSynchronizer;
  public
    constructor Create( EventAttributes: PSecurityAttributes; ManualReset,
                       InitialState: Boolean; Name: PChar );
    destructor  Destroy; override;
    function    PulseEvent: Boolean; override;
    function    SetEvent: Boolean; override;
    function    ResetEvent: Boolean; override;
    function    Signaled: Boolean; override;
  end;

  // TMultipleHandleObject
  TMultipleHandleObject = class( THandleObject )
  private
    FIOCompletion : Boolean;
    FOtherHandles : array of THandle;
    FWaitResult : DWORD;
  protected
    function    CheckWait: Boolean;
    procedure   ReleaseHandle; override;
  public
    procedure   SetWaitHandles( const WaitHandles: array of THandle );
    property    IOCompletion: Boolean read FIOCompletion write FIOCompletion;
  end;

  // TPrinterChangeNotify
  TPrinterChangeNotify = class( TMultipleHandleObject )
  private
    FFlags      : DWORD;
    FOptions    : PPrinterNotifyOptions;
    FNotification: PPrinterNotifyInfo; // The stuff that changed to cause the notification
    FOnOverflow : TNotifyEvent;
    procedure   FreeNotifyInfo;
  protected
    procedure   DoOnOverflow; dynamic;
    procedure   ReleaseHandle; override;
  public
    constructor Create(
      APrinter: THandle;      // handle to printer or print server to monitor for changes
      fdwFlags: DWORD;        // flags that specify the conditions to monitor
      pNotifyOptions: Pointer // pointer to structure specifying printer information to monitor
    );
    function    HasFlag( Flag: DWORD ): Boolean;
    function    Signaled: Boolean; override;

    property    pNotification: PPrinterNotifyInfo read FNotification;
    property    OnOverflow: TNotifyEvent read FOnOverflow write FOnOverflow;
  end;

  // TFileChangeNotify
  TFileChangeNotify = class( TMultipleHandleObject )
  protected
    procedure   ReleaseHandle; override;
  public
    constructor Create(
      lpPathName: PChar;        // pointer to name of directory to watch
      bWatchSubtree: Boolean;   // flag for monitoring directory or directory tree
      dwNotifyFilter: DWORD     // filter conditions to watch for
    );
    function    Signaled: Boolean; override;
  end;

  // TMREWS
  TMREWS = class( TSynchroObject )
  private
    FLock    : TMultiReadExclusiveWriteSynchronizer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure BeginRead; virtual;
    procedure EndRead; virtual;
    procedure BeginWrite; virtual;
    procedure EndWrite; virtual;
  end;

  // TMREWSIntValue
  TMREWSIntValue = class( TMREWS )
  private
    FValue  : DWORD;
    function GetValue: DWORD;
    procedure SetValue( AValue: DWORD );
  public
    constructor Create( InitialValue: DWORD );
    procedure Inc;
    procedure Dec;
    property Value: DWORD read GetValue write SetValue;
  end;

  //TCriticalSection
  TCriticalSection = class(TSynchroObject)
  protected
    FSection    : TRTLCriticalSection;
  protected
    procedure     Acquire; override;
    procedure     Release; override;
  public
    constructor   Create;
    destructor    Destroy; override;
    procedure     Enter; virtual;
    procedure     Leave; virtual;
  end;

  // TTryableCriticalSection
  TTryableCriticalSection = class( TCriticalSection )
  protected
    FKOB        : TMutex;
  protected
  public
    constructor   Create;
    destructor    Destroy; override;
    procedure     Enter; virtual;
    procedure     Leave; virtual;
    procedure     MsgTryToEnter; virtual;
    function      TryToEnter: Boolean;
    procedure     ProcessMessages;
  end;

  // TValueCriticalSection
  TValueCriticalSection = class( TTryableCriticalSection )
  public
    procedure GetIn;
  end;

  // TIntCriticalSection
  TIntCriticalSection = class( TValueCriticalSection )
  private
    FValue  : DWORD;
    function GetValue: DWORD;
    procedure SetValue( AValue: DWORD );
  public
    constructor Create( InitialValue: DWORD );
    procedure Inc;
    procedure Dec;
    function TryValue( MiliSec: Integer ): DWORD;
    function FastValue: DWORD;
    property Value: DWORD read GetValue write SetValue;
  end;

  // TBoolCriticalSection
  TBoolCriticalSection = class( TValueCriticalSection )
  private
    FValue  : Boolean;
    function GetValue: Boolean;
    procedure SetValue( AValue: Boolean );
  public
    constructor Create( InitialValue: Boolean );
    property Value: Boolean read GetValue write SetValue;
  end;

  // TGlobalPtrCriticalSection
  TGlobalPtrCriticalSection = class( TValueCriticalSection )
  private
    FValue  : Pointer;
    function GetValue: Pointer;
    procedure SetValue( AValue: Pointer );
  public
    constructor Create( InitialValue: Pointer );
    destructor Destroy; override;
    property Value: Pointer read GetValue write SetValue;
  end;

  // TThreadStrings
  TThreadStrings = class( TCriticalSection )
  public
    FList       : TStrings; // WARNING: this is not thread safe. Still, in a
                            // multithreaded application there might be a possibility
                            // you will need to access directly the list (as when
                            // you need to pass the list as a parameter and no other
                            // threads are accessing it )
                            // that's why is public.
    constructor   Create( AList: TStrings );
    destructor    Destroy; override;

    function      LockList: TStrings;
    procedure     UnlockList;

    function      Add( const S: string ): Integer;
    procedure     Clear;
    function      Count: Integer;
    function      ExtractFirst: String;
    function      ExtractLast: String;
  end;

  // THandleArray
  THandleArray = class( TObject )
    Count: Integer;
    Handles: array of THandle;
    destructor Destroy; override;
    procedure SetWaitHandles( const WaitHandles: array of THandle );
    function WaitFor( Timeout: DWORD; bWaitAll, bAlertable: Boolean ): DWORD; dynamic;
  end;

  // TMutexArray
  TMutexArray = class( THandleArray )
    constructor Create( ACount: Integer; MutexAttributes: PSecurityAttributes;
                       InitialOwner: Boolean );
    destructor Destroy; override;
    function ReleaseMutex( Index: Integer ): Boolean;
  end;

  TLinkedNode = class
  private
    FData       : TObject;
    FNext       : TLinkedNode;
    FPrev       : TLinkedNode;
    procedure   SetNext(Value: TLinkedNode);
  protected
  public
    constructor CreateNextTo(Node: TLinkedNode);
    property    Data: TObject read FData write FData;
    property    Next: TLinkedNode read FNext write SetNext;
  end;

  // TSemaphoreLink
  TSemaphoreLink = class(TSemaphore)
  private
    FCount      : Longint;            // number if items
    FSize       : Longint;            // number of allocated items (FSize can be > FCount)
    FLock       : TCriticalSection;   // handle to critical section
    FHead       : TLinkedNode;
    function    GetCount: Longint;
  protected
  public
    // critical section protection
    procedure   EnterCS;
    procedure   LeaveCS;

    constructor Create(ArraySize: Longint); virtual;
    destructor  Destroy; override;

    procedure   Delete(Node: TLinkedNode);
    function    Insert(Data: TObject): TLinkedNode;

    function    FirstThat(Test: Pointer): Pointer;
    procedure   ForEach( Method: Pointer );

    property    Count: Longint read GetCount; // threadsafe, precise
    property    InCount: Longint read FCount; // not threadsafe, not precise
  end;

  
implementation

const

  // TDateTime Time Interval Constants
  MILLISECOND               = (1 / 86400000);

// TSynchroObject --------------------------------------------------------------

procedure TSynchroObject.Acquire;
begin
end;

procedure TSynchroObject.Release;
begin
end;
// ***

// THandleObject ---------------------------------------------------------------

{$IFDEF MSWINDOWS}
procedure THandleObject.ReleaseHandle;
begin
  CloseHandle( FHandle );
end;

destructor THandleObject.Destroy;
begin
  ReleaseHandle;
  inherited Destroy;
end;

function THandleObject.Signaled: Boolean;
begin
  Result := WaitFor = wrSignaled;
end;

function THandleObject.Signaled( Timeout: LongWord ): Boolean;
begin
  Result := WaitFor( Timeout ) = wrSignaled;
end;

function THandleObject.MsgWaitFor( Timeout: LongWord = 0 ): TWaitResult;
begin
  SetLastError(0);
  Result := wrError;
  case MsgWaitForMultipleObjects( 1, FHandle, TRUE, Timeout, QS_SENDMESSAGE ) of
    WAIT_OBJECT_0     : Result := wrSignaled;  // OBJECT IS SIGNALED
    WAIT_OBJECT_0 + 1 : Result := wrInput;     // INPUT AVAILABLE
    WAIT_ABANDONED    : Result := wrAbandoned; // OBJECT WAS ABANDONED
    WAIT_TIMEOUT      : Result := wrTimeout;   // TIMEOUT
    WAIT_FAILED       : FLastError := GetLastError;
  end;
end;

function THandleObject.WaitFor( Timeout: LongWord = 0 ): TWaitResult;
begin
  SetLastError(0);
  Result := wrError;
  case WaitForSingleObject( FHandle, Timeout ) of
    WAIT_OBJECT_0     : Result := wrSignaled;
    WAIT_ABANDONED    : Result := wrAbandoned;
    WAIT_TIMEOUT      : Result := wrTimeout;
    WAIT_FAILED       : FLastError := GetLastError;
  end;
end;
{$ENDIF MSWINDOWS}
// ***


// TMREWS_Event ----------------------------------------------------------------
constructor TMREWS_Event.Create( EventAttributes: PSecurityAttributes; ManualReset,
  InitialState: Boolean; Name: PChar );
begin
  inherited Create( EventAttributes, ManualReset, InitialState, Name );
  FLock := TMultiReadExclusiveWriteSynchronizer.Create;
end;

destructor TMREWS_Event.Destroy;
begin
  FLock.Free;
  inherited Destroy;
end;

function TMREWS_Event.PulseEvent: Boolean;
begin
  FLock.BeginWrite;
  try
    Result := inherited PulseEvent;
  finally
    FLock.EndWrite;
  end;
end;

function TMREWS_Event.SetEvent: Boolean;
begin
  FLock.BeginWrite;
  try
    Result := inherited SetEvent;
  finally
    FLock.EndWrite;
  end;
end;

function TMREWS_Event.ResetEvent: Boolean;
begin
  FLock.BeginWrite;
  try
    Result := inherited ResetEvent;
  finally
    FLock.EndWrite;
  end;
end;

function TMREWS_Event.Signaled: Boolean;
begin
  FLock.BeginRead;
  try
    Result := inherited Signaled;
  finally
    FLock.EndRead;
  end;
end;
// ***

{$IFDEF MSWINDOWS}
// TSemaphore ------------------------------------------------------------------
constructor TSemaphore.Create( Attributes: PSecurityAttributes;
  InitialCount, MaximumCount: Longint; Name: PChar );
begin
  FHandle := CreateSemaphore( Attributes, InitialCount, MaximumCount, Name );
end;

function TSemaphore.ReleaseSemaphore( ReleaseCount: Longint; lpPreviousCount: PLongint ): Boolean;
begin
  SetLastError(0);
   Windows.ReleaseSemaphore( FHandle, ReleaseCount, lpPreviousCount );
  Result := True;
  if Result then
    if Assigned( FOnRelease ) then
      FOnRelease( Self );
end;

procedure TSemaphore.Release;
begin
  ReleaseSemaphore( 1, nil );
end;
// ***
{$ENDIF MSWINDOWS}


// TMutex ----------------------------------------------------------------------
constructor TMutex.Create( Attributes: PSecurityAttributes;
  InitialOwner: Boolean; Name: PChar );
begin
  FHandle := CreateMutex( Attributes, InitialOwner, Name );
end;

procedure TMutex.ReleaseHandle;
begin
  if Signaled then ReleaseMutex
  else inherited ReleaseHandle;
end;

function TMutex.ReleaseMutex: Boolean;
begin
  Result := Windows.ReleaseMutex( FHandle );
end;
// ***


// TEvent ----------------------------------------------------------------------
constructor TEvent.Create;
{$IFDEF MSWINDOWS}
begin
  FHandle := CreateEvent( Attributes, ManualReset, InitialState, Name );
end;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
var
   Value: Integer;
begin
   if InitialState then Value := 1
   else Value := 0;
   sem_init( FEvent, False, Value );
end;
{$ENDIF LINUX}

{$IFDEF LINUX}
function TEvent.WaitFor( Timeout: LongWord ): TWaitResult;
begin
  if Timeout = LongWord( $FFFFFFFF ) then
  begin
    sem_wait( FEvent );
    Result := wrSignaled;
  end else
    Result := wrError;
end;
{$ENDIF LINUX}

{$IFDEF MSWINDOWS}
function TEvent.PulseEvent: Boolean;
begin
  Result := Windows.PulseEvent( FHandle );
end;
{$ENDIF MSWINDOWS}

function TEvent.SetEvent: Boolean;
{$IFDEF MSWINDOWS}
begin
  Result :=  Windows.SetEvent(Handle);
end;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
var
  I: Integer;
begin
  sem_getvalue( FEvent, I );
  if I = 0 then
    sem_post( FEvent );
end;
{$ENDIF LINUX}

function TEvent.ResetEvent: Boolean;
begin
{$IFDEF MSWINDOWS}
  Result :=  Windows.ResetEvent( Handle );
{$ENDIF}
{$IFDEF LINUX}
  // All events on Linux are auto-reset
  Result := TRUE;
{$ENDIF LINUX}
end;
// ***


// TSimpleEvent ----------------------------------------------------------------
constructor TSimpleEvent.Create;
begin
  inherited Create( {$IFDEF MSWINDOWS}nil,{$ENDIF} True, False, '' );
end;
// ***


// TMultipleHandleObject -------------------------------------------------------
procedure TMultipleHandleObject.SetWaitHandles( const WaitHandles: array of THandle );
var
  I, J: Integer;
begin
  SetLength( FOtherHandles, 0 );
  J := 1;
  if High(WaitHandles) >= Low(WaitHandles) then
    Inc( J, High(WaitHandles)+1 );
  SetLength( FOtherHandles, J );
  FOtherHandles[0] := FHandle;
  for I := Low(WaitHandles) to High(WaitHandles) do
    FOtherHandles[I+1] := WaitHandles[I];
end;

function TMultipleHandleObject.CheckWait: Boolean;
var
  Count, Res: DWORD;
begin
  FWaitResult   := 0;
  Count         := Length( FOtherHandles );
  FIOCompletion := FALSE;

  SetLastError(0);
  if Count = 1 then Res := WaitForSingleObjectEx( FHandle, INFINITE, TRUE )
  else Res := WaitForMultipleObjectsEx( Count, @FOtherHandles[0], FALSE, INFINITE, TRUE );

  if Res <> WAIT_FAILED then
   FIOCompletion := Res = WAIT_IO_COMPLETION; // it was a QueueUserAPC call
  Result := ( Res = WAIT_OBJECT_0 );              // handle signaled
end;

procedure TMultipleHandleObject.ReleaseHandle;
begin
  // Cleanup
  Finalize( FOtherHandles );
end;
// ***


// TPrinterChangeNotify --------------------------------------------------------
constructor TPrinterChangeNotify.Create;
begin
  FNotification := nil;
  FFlags        := fdwFlags;
  FOptions      := pNotifyOptions;
  FHandle       :=  FindFirstPrinterChangeNotification(
                          APrinter,     // handle to printer or print server to monitor for changes
                          FFlags,       // flags that specify the conditions to monitor
                          0,            // reserved, must be zero
                          FOptions ); // pointer to structure specifying printer information to monitor

  SetWaitHandles( [] );
end;

procedure TPrinterChangeNotify.FreeNotifyInfo;
begin
  if FNotification <> nil then
    FreePrinterNotifyInfo( FNotification );
  FNotification := nil;
end;

procedure TPrinterChangeNotify.ReleaseHandle;
begin
  // Done watching for notifications, cleanup
  FreeNotifyInfo;
  FindClosePrinterChangeNotification( FHandle );
  inherited ReleaseHandle;
end;

procedure TPrinterChangeNotify.DoOnOverflow;
begin
  if Assigned( FOnOverflow ) then
    FOnOverflow( Self );
end;

function TPrinterChangeNotify.HasFlag( Flag: DWORD ): Boolean;
begin
  Result := FWaitResult and Flag <> 0;
end;

function TPrinterChangeNotify.Signaled: Boolean;
var
  OldFlags    : DWORD;
  Overflow    : Boolean;
begin
  FreeNotifyInfo;
  repeat
    Overflow := False;
    Result   := CheckWait;
    if Result then
    begin
      // get the changes and reset the notification
       FindNextPrinterChangeNotification( FHandle, FWaitResult, FOptions, Pointer(FNotification) ) ;
      // Did a notification overflow occur?
      if Assigned( FNotification ) and ((FNotification.Flags and PRINTER_NOTIFY_INFO_DISCARDED) <> 0) then
      begin
        // An overflow of notifications occured, must refresh to continue
        if FOptions <> nil then
        begin
          OldFlags := FOptions.Flags;
          FOptions.Flags := PRINTER_NOTIFY_OPTIONS_REFRESH;
        end
        else OldFlags := 0; // just to get rid of Delphi warnings
        FreeNotifyInfo;
         FindNextPrinterChangeNotification( FHandle, FWaitResult, FOptions, Pointer(FNotification) );
        if FOptions <> nil then
          FOptions.Flags := OldFlags;
        DoOnOverflow;
        Overflow := True;
      end;
    end;
  until not Overflow;
end;
// ***


// TFileChangeNotify --------------------------------------------------------
constructor TFileChangeNotify.Create(
  lpPathName: PChar;        // pointer to name of directory to watch
  bWatchSubtree: Boolean;   // flag for monitoring directory or directory tree
  dwNotifyFilter: DWORD     // filter conditions to watch for
);
begin
  FHandle :=  FindFirstChangeNotification( lpPathName, bWatchSubTree, dwNotifyFilter );
  SetWaitHandles( [] );
end;

procedure TFileChangeNotify.ReleaseHandle;
begin
  // Done watching for notifications, cleanup
  FindCloseChangeNotification( FHandle );
  inherited ReleaseHandle;
end;

function TFileChangeNotify.Signaled: Boolean;
begin
  Result := CheckWait;
  if Result then
    // reset the notification
     FindNextChangeNotification( FHandle ) ;
end;
// ***


// TMREWS ----------------------------------------------------------------------
constructor TMREWS.Create;
begin
  inherited Create;
  FLock    := TMultiReadExclusiveWriteSynchronizer.Create;
end;

destructor TMREWS.Destroy;
begin
  FLock.Free;
  inherited Destroy;
end;

procedure TMREWS.BeginRead;
begin
  inherited Acquire;
  FLock.BeginRead;
end;

procedure TMREWS.BeginWrite;
begin
  inherited Acquire;
  FLock.BeginWrite;
end;

procedure TMREWS.EndRead;
begin
  inherited Release;
  FLock.EndRead;
end;

procedure TMREWS.EndWrite;
begin
  inherited Release;
  FLock.EndWrite;
end;

// TMREWSIntValue --------------------------------------------------------------
constructor TMREWSIntValue.Create( InitialValue: DWORD );
begin
  inherited Create;
  FValue := InitialValue;
end;

function TMREWSIntValue.GetValue: DWORD;
begin
  BeginRead;
  try
    Result := FValue;
  finally
    EndRead;
  end;
end;

procedure TMREWSIntValue.SetValue( AValue: DWORD );
begin
  BeginWrite;
  try
    FValue := AValue;
  finally
    EndWrite;
  end;
end;

procedure TMREWSIntValue.Inc;
begin
  BeginWrite;
  try
    System.Inc( FValue );
  finally
    EndWrite;
  end;
end;

procedure TMREWSIntValue.Dec;
begin
  BeginWrite;
  try
    System.Dec( FValue );
  finally
    EndWrite;
  end;
end;
// ***

// TCriticalSection ------------------------------------------------------------
constructor TCriticalSection.Create;
begin
  inherited Create;
  InitializeCriticalSection( FSection );
end;

destructor TCriticalSection.Destroy;
begin
  DeleteCriticalSection( FSection );
  inherited Destroy;
end;

procedure TCriticalSection.Acquire;
begin
  EnterCriticalSection( FSection );
end;

procedure TCriticalSection.Release;
begin
  LeaveCriticalSection( FSection );
end;

procedure TCriticalSection.Enter;
begin
  Acquire;
end;

procedure TCriticalSection.Leave;
begin
  Release;
end;
// ***

// TTryableCriticalSection -----------------------------------------------------
constructor TTryableCriticalSection.Create;
begin
  inherited Create;
  {$IFDEF MSWINDOWS}
  FKOB    := TMutex.Create( nil, False, '' ); // without ownership
  {$ENDIF MSWINDOWS}
  {$IFDEF LINUX}
  sem_init( FEvent, False, 1 ); // 1: InitialState
  {$ENDIF LINUX}
end;

destructor TTryableCriticalSection.Destroy;
begin
  {$IFDEF MSWINDOWS}
  FKOB.Free;
  {$ENDIF MSWINDOWS}
  inherited Destroy;
end;

procedure TTryableCriticalSection.Enter;
begin
  {$IFDEF MSWINDOWS}
  while not FKOB.Signaled do // take ownership of mutex
    Sleep( 0 );
  {$ENDIF MSWINDOWS}
  {$IFDEF LINUX}
  sem_wait( FSem );
  {$ENDIF LINUX}
  Acquire;
end;

procedure TTryableCriticalSection.Leave;
{$IFDEF MSWINDOWS}
begin
  Release;
  FKOB.ReleaseMutex;       // release ownership of the mutex
end;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
var
  I: Integer;
begin
  Release;
  sem_getvalue( FSem, I );
  if I = 0 then
    sem_post( FSem );
end;
{$ENDIF LINUX}

function TTryableCriticalSection.TryToEnter: Boolean;
{$IFDEF LINUX}
var
  I: Integer;
{$ENDIF LINUX}
begin
  {$IFDEF MSWINDOWS}
  Result := FKOB.Signaled; // if we're signaled, we got the ownership
  {$ENDIF MSWINDOWS}
  {$IFDEF LINUX}
  sem_getvalue( FEvent, I );
  Result := I = 0; not sure
  {$ENDIF LINUX}
  if Result then Acquire;
end;

procedure TTryableCriticalSection.MsgTryToEnter;
begin
  while not TryToEnter do
    ProcessMessages;
end;

procedure TTryableCriticalSection.ProcessMessages;
var
  Msg  : TMsg;
  H    : THandle;
begin
//  Application.ProcessMessages;
//  Exit;

  if GetCurrentThreadID <> MainThreadID then
    Application.ProcessMessages
  else
  begin
    H := GetCurrentThread;
    while MsgWaitForMultipleObjects( 1, H, False, 5, QS_ALLINPUT ) = WAIT_OBJECT_0 + 1 do
      PeekMessage( Msg, 0, 0, 0, PM_NOREMOVE );
  end;
end;
// ***


// TValueCriticalSection -------------------------------------------------------
procedure TValueCriticalSection.GetIn;
begin
  MsgTryToEnter;
end;
// ***


// TIntCriticalSection ---------------------------------------------------------
constructor TIntCriticalSection.Create( InitialValue: DWORD );
begin
  inherited Create;
  FValue := InitialValue;
end;

function TIntCriticalSection.FastValue: DWORD;
begin
  Result := Value;
end;

function TIntCriticalSection.TryValue( MiliSec: Integer ): DWORD;
var
  TimeOut: TDateTime;
  Okay: Boolean;
begin
  Result := DWORD(-1);
  Okay   := False;
  TimeOut := Now + MiliSec * MILLISECOND;
  repeat
    if TryToEnter then
      try       Result := FValue;
                Okay   := True;
      finally   Leave;
      end
    else
      ProcessMessages;
  until Okay or ( Now > Timeout );
end;

procedure TIntCriticalSection.SetValue( AValue: DWORD );
begin
  GetIn;
  try
    FValue := AValue;
  finally
    Leave;
  end;
end;

function TIntCriticalSection.GetValue: DWORD;
begin
  GetIn;
  try
    Result := FValue;
  finally
    Leave;
  end;
end;

procedure TIntCriticalSection.Inc;
begin
  GetIn;
  try
    System.Inc( FValue );
  finally
    Leave;
  end;
end;

procedure TIntCriticalSection.Dec;
begin
  GetIn;
  try
    System.Dec( FValue );
  finally
    Leave;
  end;
end;
// ***

// TBoolCriticalSection --------------------------------------------------------
constructor TBoolCriticalSection.Create( InitialValue: Boolean );
begin
  inherited Create;
  FValue := InitialValue;
end;

function TBoolCriticalSection.GetValue: Boolean;
begin
  GetIn;
  try
    Result := FValue;
  finally
    Leave;
  end;
end;

procedure TBoolCriticalSection.SetValue( AValue: Boolean );
begin
  GetIn;
  try
    FValue := AValue;
  finally
    Leave;
  end;
end;
// ***

// TGlobalPtrCriticalSection --------------------------------------------------------
constructor TGlobalPtrCriticalSection.Create( InitialValue: Pointer );
begin
  inherited Create;
  FValue := InitialValue;
end;

destructor TGlobalPtrCriticalSection.Destroy;
begin
  if Assigned( FValue ) then GlobalFreePtr( FValue );
  inherited Destroy;
end;

function TGlobalPtrCriticalSection.GetValue: Pointer;
begin
  GetIn;
  Result := FValue;
end;

procedure TGlobalPtrCriticalSection.SetValue( AValue: Pointer );
begin
  GetIn;
  if Assigned( FValue ) then GlobalFreePtr( FValue );
  FValue := AValue;
end;
// ***


// TThreadStrings ---------------------------------------------------------------
constructor TThreadStrings.Create( AList: TStrings );
begin
  inherited Create;
  FList := AList;
end;

destructor TThreadStrings.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

function TThreadStrings.LockList: TStrings;
begin
  Enter;
  Result := FList;
end;

procedure TThreadStrings.UnlockList;
begin
  Leave;
end;

function TThreadStrings.Add( const S: string ): Integer;
begin
  Enter;
  try
    Result := FList.Add( S );
  finally
    Leave;
  end;
end;

procedure TThreadStrings.Clear;
begin
  Enter;
  try
    FList.Clear;
  finally
    Leave;
  end;
end;

function TThreadStrings.Count: Integer;
begin
  Result := FList.Count;
end;

function TThreadStrings.ExtractFirst: String;
begin
  with LockList do
  try
    if Count = 0 then Result := SYNC_OUT_OF_STRINGS
    else
    begin
      Result := FList[0];
      Delete( 0 );
    end;
  finally
    UnlockList;
  end;
end;

function TThreadStrings.ExtractLast: String;
begin
  with LockList do
  try
    if Count = 0 then Result := SYNC_OUT_OF_STRINGS
    else
    begin
      Result := FList[Count-1];
      Delete( Count-1 );
    end;
  finally
    UnlockList;
  end;
end;
// ***


// THandleArray ----------------------------------------------------------------
destructor THandleArray.Destroy;
begin
  Finalize( Handles );
  inherited Destroy;
end;

procedure THandleArray.SetWaitHandles( const WaitHandles: array of THandle );
var
  I: Integer;
begin
  Finalize( Handles );
  Count := 0;
  if High(WaitHandles) >= Low(WaitHandles) then
    Inc( Count, High(WaitHandles)+1 );
  SetLength( Handles, Count );
  for I := Low(WaitHandles) to High(WaitHandles) do
    Handles[I] := WaitHandles[I];
end;

function THandleArray.WaitFor( Timeout: DWORD; bWaitAll, bAlertable: Boolean ): DWORD;
begin
//  Result := WaitForMultipleObjects( Count, @Handles[0], bWaitAll, Timeout );
  Result := WaitForMultipleObjectsEx( Count, @Handles[0], bWaitAll, Timeout, bAlertable );
end;
// ***

// TMutexArray -----------------------------------------------------------------
constructor TMutexArray.Create( ACount: Integer;
  MutexAttributes: PSecurityAttributes; InitialOwner: Boolean );
var
  I: Integer;
begin
  inherited Create;
  Count := ACount;
  SetLength( Handles, Count );
  for I := 0 to Count - 1 do
    Handles[ I ] := CreateMutex( MutexAttributes, InitialOwner, nil );
end;

destructor TMutexArray.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    CloseHandle( Handles[ I ] );
  inherited Destroy;
end;

function TMutexArray.ReleaseMutex( Index: Integer ): Boolean;
begin
  Result := ReleaseMutex( Handles[Index] );
end;
// ***


// TLinkedNode -----------------------------------------------------------------
constructor TLinkedNode.CreateNextTo(Node: TLinkedNode);
begin
  inherited Create;
  FData := nil;
  FNext := Self;
  FPrev := Self;
  Next  := Node;
end;

procedure TLinkedNode.SetNext(Value: TLinkedNode);
begin
  if Value <> nil then
  begin
    FPrev := Value;
    FNext := Value.FNext;
    if Value.FPrev = Value then
      Value.FPrev := Self;
    Value.FNext.FPrev := Self;
    Value.FNext := Self;
  end;
end;
// ***

// TSemaphoreLink ------------------------------------------------------------------
procedure TSemaphoreLink.EnterCS;
begin
  FLock.Enter;
end;

procedure TSemaphoreLink.LeaveCS;
begin
  FLock.Leave;
end;

constructor TSemaphoreLink.Create(ArraySize: Longint);
var
  I: Integer;
begin
  inherited Create( nil, ArraySize, ArraySize, nil );
  FLock   := TCriticalSection.Create;
  FCount  := 0;
  FHead   := nil;
  FSize   := ArraySize;
  for I := 0 to FSize - 1 do
    FHead := TLinkedNode.CreateNextTo(FHead);
end;

destructor TSemaphoreLink.Destroy;
var
  Node, Top: TLinkedNode;
begin
  EnterCS;
  Top := FHead;
  FHead := FHead.FNext;
  if FHead <> Top then
  repeat
    Node := FHead;
    FHead := FHead.FNext;
    Node.Free;
  until FHead = Top;
  FHead.Free;
  LeaveCS;
  FLock.Free;
  inherited Destroy;
end;

procedure TSemaphoreLink.Delete(Node: TLinkedNode);
begin
  EnterCS;
  try
    if Node <> nil then
    begin
      FHead := Node;
      FHead.FData := nil;
    end;
    Dec(FCount);
  finally
    LeaveCS;
    Release;
  end;
end;

function TSemaphoreLink.Insert(Data: TObject): TLinkedNode;
begin
  EnterCS;
  try
    Result := FHead;
    Result.FData := Data;
    Inc(FCount);
    if FCount < FSize then
    repeat
      FHead := FHead.FNext;
    until (FHead.FData = nil);
  finally
    LeaveCS;
  end;
end;

function TSemaphoreLink.GetCount: Longint;
begin
  EnterCS;
  try
    Result := FCount;
  finally
    LeaveCS;
  end;
end;

function TSemaphoreLink.FirstThat(Test: Pointer): Pointer;
label
  RETURN;
var
  Top, Node: TLinkedNode;
  Item     : Pointer;
  callerBP: Cardinal;
begin
  EnterCS;
  asm
    mov EAX,[EBP]
    mov callerBP,EAX
  end;
  try
    Result := nil;
    if FCount = 0 then Exit;
    Top  := FHead;
    Node := FHead;
    repeat
      Item := Node.FData;
      if Item <> nil then
      asm
          PUSH    Self
          PUSH	  Node
          PUSH	  Top
          PUSH	  Item
          PUSH    callerBP
          CALL	  Test
          POP	  ECX
          POP	  Item
          POP	  Top
          POP	  Node
          POP	  Self
          OR      AL,AL
          JNE     RETURN
      end;
      Node := Node.FNext;
      Item := nil;
    until (Node = Top);
  RETURN:
    Result := Item;
  finally
    LeaveCS;
  end;
end;

procedure TSemaphoreLink.ForEach( Method: Pointer );
var
  Top, Node: TLinkedNode;
  Item: Pointer;
  callerBP: Cardinal;
begin
  EnterCS;
  asm
    mov EAX,[EBP]
    mov callerBP,EAX
  end;
  if FCount = 0 then Exit;
  try
    Top  := FHead;
    Node := FHead;
    repeat
      Item := Node.FData;
      if Item <> nil then
      asm
          PUSH    Self
          PUSH	  Node
          PUSH	  Top
          PUSH	  Item
          PUSH    callerBP
          CALL	  Method
          POP	  ECX
          POP	  Item
          POP	  Top
          POP	  Node
          POP	  Self
      end;
      Node := Node.FNext;
    until (Node = Top);
  finally
    LeaveCS;
  end;
end;
// ***

end.



