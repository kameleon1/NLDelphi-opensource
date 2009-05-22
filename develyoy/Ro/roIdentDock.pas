unit roIdentDock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, roDockWin, ScktComp, ComCtrls, StdCtrls, ExtCtrls, OleCtrls,
  SHDocVw, roDocHost, MSHTML, Menus, ActnList, Sockets;

type
  TIdentDock = class(TDockWin)
    TcpServer1: TTcpServer;
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
    procedure TcpServer1Listening(Sender: TObject);
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
    procedure TcpServer1GetThread(Sender: TObject;
      var ClientSocketThread: TClientSocketThread);
    procedure TcpServer1Accept(Sender: TObject;
      ClientSocket: TCustomIpClient);
  private
    WebDoc:IHTMLDocument2;
    WebNavOk,WebNavKeepContent:boolean;
    WebNavKeptContent:WideString;
    rotateLine,rotateBlockPos:integer;
    rotateBlock:IHTMLElement;

    procedure Msg(s:string);
    function DoIncoming(Socket:TCustomIpClient; s:string):string;
  end;

var
  IdentDock: TIdentDock;

implementation

uses roMain, roStuff, roConWin, roHTMLHelp;

{$R *.dfm}

type
  TSThread=class(TClientSocketThread)
  private
    FOutMsg:string;
    procedure Msg(x:string);
    procedure DoOutMsg;
    procedure DoProcess;
  public
    procedure DoAccept;
  end;

procedure TIdentDock.TcpServer1Listening(Sender: TObject);
begin
  inherited;
 aListen.Caption:='Stop server';
 Msg('Listening on port '+TcpServer1.LocalPort);
end;

procedure TIdentDock.FormCreate(Sender: TObject);
begin
  inherited;
 rotateLine:=0;
 rotateBlockPos:=0;
 rotateBlock:=nil;
 Web1.PopupMenu:=PopupMenu1;
 if not(Web1.HandleAllocated) then Web1.HandleNeeded;
 //Web1.OnTranslateAccelerator:=WebTranslateAccelerator;
 WebDoc:=nil;
 WebNavOk:=true;
 WebNavKeepContent:=false;
 Web1.Navigate('res://'+application.ExeName+'/base');

 while WebDoc=nil do Application.ProcessMessages;

 aTTime.Checked:=true;
 SetStyle(WebDoc,'.time',true);

 try
  TcpServer1.Open;
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

function TIdentDock.DoIncoming(Socket:TCustomIpClient; s:string):string;
var
 cw:TConnectionWin;
begin
 Msg('Request "'+s+'"');
 cw:=MainWin.HexTree.GetObject(htIdentD+s);
 if cw=nil then
   Result:=s+' : ERROR : NO-USER'
 else
   Result:=cw.IdentdReply(Socket.RemoteHost+':'+Socket.RemotePort+')');
 Msg('Reply "'+Result+'"');
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
 TcpServer1.Close;
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
 if TcpServer1.Active then
  try
   TcpServer1.Close;
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
   TcpServer1.Open;
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

procedure TIdentDock.TcpServer1GetThread(Sender: TObject;
  var ClientSocketThread: TClientSocketThread);
begin
  inherited;
  ClientSocketThread:=TSThread.Create(TcpServer1.ServerSocketThread);
end;

{ TSThread }

procedure TSThread.DoOutMsg;
begin
  IdentDock.Msg(FOutMsg);
end;

procedure TSThread.Msg(x: string);
begin
  FOutMsg:=x;
  Synchronize(DoOutMsg);
end;

procedure TSThread.DoProcess;
begin
  FOutMsg:=IdentDock.DoIncoming(ClientSocket,FOutMsg);
end;

procedure TIdentDock.TcpServer1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
begin
  inherited;
  (ClientSocket.GetThreadObject as TSThread).DoAccept;
end;

procedure TSThread.DoAccept;
var
  tc:Cardinal;
begin
  tc:=GetTickCount;
  Msg('Connect '+ClientSocket.RemoteHost+':'+ClientSocket.RemotePort);
  try
    while not(Terminated) and ClientSocket.Connected do
     begin
      if ClientSocket.WaitForData(1000) then
       begin
        FOutMsg:=ClientSocket.Receiveln;
        Synchronize(DoProcess);
        ClientSocket.Sendln(FOutMsg);
        tc:=GetTickCount;
       end
      else
        if cardinal(GetTickCount-tc)>30000 then
          raise Exception.Create('Connection timed out');
     end;
  except
    on e:Exception do
     begin
      Msg('Error: '+e.Message);
      ClientSocket.Disconnect;
     end;
  end;
  Msg('Disconnect '+ClientSocket.RemoteHost+':'+ClientSocket.RemotePort);
end;

end.
