unit roIdentDock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, roDockWin, ScktComp, ComCtrls, StdCtrls, ExtCtrls, OleCtrls,
  SHDocVw, dsDocHost, MSHTML_TLB, Menus, ActnList;

type
  TIdentDock = class(TDockWin)
    ServerSocket1: TServerSocket;
    Web1: TRestrictedWebBrowser;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    aListen: TAction;
    aTTime: TAction;
    aWordWrap: TAction;
    StartStopserver1: TMenuItem;
    N1: TMenuItem;
    imetags1: TMenuItem;
    Wordwrap1: TMenuItem;
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1Listen(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Web1BeforeNavigate2(Sender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure Web1DocumentComplete(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aListenExecute(Sender: TObject);
    procedure aTTimeExecute(Sender: TObject);
    procedure aWordWrapExecute(Sender: TObject);
  private
    { Private declarations }

    WebDoc:IHTMLDocument2;
    WebNavOk,WebNavKeepContent:boolean;
    WebNavKeptContent:WideString;
    rotateLine,rotateBlockPos:integer;
    rotateBlock:IHTMLElement;

    procedure Msg(s:string);
    procedure DoIncoming(Socket: TCustomWinSocket;s:string);
    procedure NetSend(Socket: TCustomWinSocket;s:string);
  public
    { Public declarations }
  end;

var
  IdentDock: TIdentDock;

implementation

uses roMain, roStuff, roConWin, roHTMLHelp;

{$R *.dfm}

type
 TSData=class(TObject)
  private
  public
   inbuffer:string;
 end;

procedure TIdentDock.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  inherited;
 Msg('Connect '+Socket.RemoteHost+' ('+Socket.RemoteAddress+')');
 Socket.Data:=TSData.Create;
end;

procedure TIdentDock.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  inherited;
 Msg('Disconnect '+Socket.RemoteHost+' ('+Socket.RemoteAddress+')');
 if not(Socket.Data=nil) then
  begin
   TSData(Socket.Data).Free;
   Socket.Data:=nil;
  end;
end;

procedure TIdentDock.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  inherited;
 Msg('Error: '+SysErrorMessage(ErrorCode));
 ErrorCode:=0;
 Socket.Close;
 //Disconnect event??
end;

procedure TIdentDock.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
 s:string;
 i:integer;
begin
  inherited;
 with TSData(Socket.Data) do
  begin
   repeat
    s:=Socket.ReceiveText;
    inbuffer:=inbuffer+s;
   until s='';
   repeat
    i:=1;
    while (i<=length(inbuffer)) and not(inbuffer[i]=#13) do inc(i);
    if i<=length(inbuffer) then
     begin
      DoIncoming(Socket,copy(inbuffer,1,i-1));
      if (i<length(inbuffer)) and (inbuffer[i+1]=#10) then inc(i);
      inbuffer:=copy(inbuffer,i+1,length(inbuffer)-i);
      i:=1;
     end;
   until i>length(inbuffer);
  end;
end;

procedure TIdentDock.ServerSocket1Listen(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  inherited;
 aListen.Caption:='Stop server';
 Msg('Listening on port '+IntToStr(ServerSocket1.Port));
end;

procedure TIdentDock.FormCreate(Sender: TObject);
begin
  inherited;
 rotateLine:=0;
 rotateBlockPos:=0;
 rotateBlock:=nil;
 Web1.PopupMenu:=PopupMenu1;
 //Web1.OnTranslateAccelerator:=WebTranslateAccelerator;
 WebDoc:=nil;
 if not(Web1.HandleAllocated) then Web1.HandleNeeded;
 WebNavOk:=true;
 WebNavKeepContent:=false;
 Web1.Navigate('res://'+application.ExeName+'/base');

 while WebDoc=nil do Application.ProcessMessages;

 aTTime.Checked:=true;
 SetStyle(WebDoc,'.time',true);

 try
  ServerSocket1.Open;
 except
  on e:Exception do
   begin
    Msg('Error starting server, port possibly in use.');
    Msg(e.Message);
   end;
 end;
 ToggleMenu:=MainWin.aDWIndentD;
end;

procedure TIdentDock.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
 //let op! wordt ook aangeroepen bij sluiten toolbar, beter OnDestroy 
end;

procedure TIdentDock.DoIncoming(Socket: TCustomWinSocket;s:string);
var
 cw:TConnectionWin;
begin
 Msg('Request "'+s+'"');
 cw:=MainWin.HexTree.GetObject(htIdentD+s);
 if cw=nil then
  NetSend(Socket,s+' : ERROR : NO-USER')
 else
  begin
   NetSend(Socket,
    cw.IdentdReply(Socket.RemoteHost+' ('+Socket.RemoteAddress+')'));
  end;
end;

procedure TIdentDock.NetSend(Socket: TCustomWinSocket;s:string);
begin
 Socket.SendText(s+#13#10);
 Msg('Reply "'+s+'"');
end;

procedure TIdentDock.Web1BeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  inherited;
 if WebNavOk then
  begin
   if not(WebNavKeepContent) then
    begin
     rotateLine:=0;
     rotateBlockPos:=0;
     rotateBlock:=nil;
    end;
   WebNavOk:=false;
   WebDoc:=nil;
   //SetCaption(VarToStr(URL));
  end
 else
  begin
   {
   s:=URL;
   if (length(s)>9) and (copy(s,1,9)='ro:paste?') then
    Com.Text:=Com.Text+URLDecode(copy(s,10,length(s)-9));
   }
   Cancel:=true;
  end;
end;

procedure TIdentDock.Web1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  inherited;
 if WebDoc=nil then
 WebDoc:=Web1.Document as IHTMLDocument2;//pdisp?
 //if OnComplete then Do...;

 if WebNavKeepContent then
  begin
   WebNavKeepContent:=false;

   //styles terug zetten
   SetStyle(WebDoc,'.time',aTTime.Checked);
   if aWordWrap.Checked then
    WebDoc.body.style.whiteSpace:='nowrap'
   else
    WebDoc.body.style.whiteSpace:='';

   //content terug zetten
   WebDoc.body.innerHTML:=WebNavKeptContent;

   //rotate terug opzoeken!
   rotateBlock:=WebDoc.all.item(rotateBlockName+IntToStr(rotateBlockPos),EmptyParam) as IHTMLElement;
  end
 else
  begin
   //styles nagaan
   StyleShown(WebDoc,aTTime,'.time');
   aWordWrap.Checked:=not(WebDoc.body.style.whiteSpace='');
  end;

end;

procedure TIdentDock.Msg(s:string);
var
 ScrollY,FirstY:integer;
 rid:string;
 e:IHTMLElement;
begin
 {Memo1.Lines.Add('['+TimeToStr(Now)+'] '+s);
 Memo1.ScrollBy(0,200);}

 //in het begin web1 nog aan het laden
 while WebDoc=nil do Application.ProcessMessages;

 if rotateLine>=rotateBlockSize then
  begin
   rotateLine:=0;
   rotateBlock:=nil;//volgende zoeken!
  end;
 inc(rotateLine);

 if (rotateBlock=nil) then
  begin
   if rotateBlockPos>=rotateBlockCount then rotateBlockPos:=0;
   inc(rotateBlockPos);
   rid:=rotateBlockName+IntToStr(rotateBlockPos);
   //oude wissen
   e:=WebDoc.all.item(rid,EmptyParam) as IHTMLElement;
   if not(e=nil) then e.outerHTML:='';
   //nieuwe bij
   WebDoc.body.insertAdjacentHTML('BeforeEnd','<span id="'+rid+'"></span>');
   rotateBlock:=WebDoc.all.item(rid,EmptyParam) as IHTMLElement;
  end;

 //coors nemen voor nieuwe content
 with (WebDoc.body as IHTMLElement2) do
  begin
   FirstY:=scrollHeight;
   ScrollY:=FirstY-(clientHeight+scrollTop);
  end;

 //assert not(rotateBlock=nil);
 rotateBlock.insertAdjacentHTML('BeforeEnd',SysTimeHTML+HTMLEncode(s)+'<br />');

 //scroll down
 if ScrollY<16 then WebDoc.parentWindow.scrollBy(0,
   (WebDoc.body as IHTMLElement2).scrollHeight-FirstY);

end;

procedure TIdentDock.FormDestroy(Sender: TObject);
begin
  inherited;
 ServerSocket1.Close;
end;

procedure TIdentDock.FormShow(Sender: TObject);
begin
 //kludge om de WebBrowser te restoren!!

 if WebDoc=nil then WebNavKeptContent:='' else
  WebNavKeptContent:=WebDoc.body.innerHTML;

 inherited;

 if not(Web1.HandleAllocated) then Web1.HandleNeeded;
 WebNavOk:=true;
 WebNavKeepContent:=true;
 Web1.Navigate('res://'+Application.ExeName+'/base');

end;

procedure TIdentDock.aListenExecute(Sender: TObject);
begin
  inherited;
 if ServerSocket1.Active then
  try
   ServerSocket1.Close;
   aListen.Caption:='Start server';
   Msg('Stopped listening.');
  except
   on e:Exception do
    begin
     Msg('Error stopping server.');
     Msg(e.Message);
    end;
  end
 else
  try
   ServerSocket1.Open;
  except
   on e:Exception do
    begin
     Msg('Error starting server, port possibly in use.');
     Msg(e.Message);
    end;
  end;
end;

procedure TIdentDock.aTTimeExecute(Sender: TObject);
begin
  inherited;
 ToggleStyle(WebDoc,aTTime,'.time');
end;

procedure TIdentDock.aWordWrapExecute(Sender: TObject);
var
 a:boolean;
begin
  inherited;
 a:=not(aWordWrap.Checked);

 aWordWrap.Checked:=a;
 if a then
  WebDoc.body.style.whiteSpace:='nowrap'
 else
  WebDoc.body.style.whiteSpace:='';
end;

end.
