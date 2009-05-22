unit roNetworks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, roChildWin, ComCtrls, Menus, ActnList, ADODB;

type
  TNetworkWin = class(TChildWin)
    MainMenu1: TMainMenu;
    oView: TTreeView;
    ActionList1: TActionList;
    aNewNetwork: TAction;
    aNewServer: TAction;
    Network1: TMenuItem;
    Newserver1: TMenuItem;
    Addnetwork1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Addnetwork2: TMenuItem;
    Addserver1: TMenuItem;
    aDelete: TAction;
    N1: TMenuItem;
    Delete1: TMenuItem;
    N2: TMenuItem;
    Delete2: TMenuItem;
    aProperties: TAction;
    N3: TMenuItem;
    Properties1: TMenuItem;
    N4: TMenuItem;
    Properties2: TMenuItem;
    aConnect: TAction;
    N5: TMenuItem;
    Connect1: TMenuItem;
    N6: TMenuItem;
    Connect2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure aNewNetworkExecute(Sender: TObject);
    procedure oViewExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure oViewDeletion(Sender: TObject; Node: TTreeNode);
    procedure aNewServerExecute(Sender: TObject);
    procedure oViewEdited(Sender: TObject; Node: TTreeNode; var S: String);
    procedure aDeleteExecute(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure aPropertiesExecute(Sender: TObject);
    procedure oViewDblClick(Sender: TObject);
    procedure aConnectExecute(Sender: TObject);
  private
    { Private declarations }
    procedure Refresh;

    function AddNetworkNode(const rs:_RecordSet):TTreeNode;
    function AddServerNode(const rs:_RecordSet;const p:TTreeNode):TTreeNode;

  public
    { Public declarations }
  end;

  TAmalgamation=(alNetwork,alServer);

  TNodeData=class
   public
    expanded:boolean;
    objtype:TAmalgamation;
    id:integer;
  end;

const
 TableName:array[TAmalgamation] of string=
  ('tblNetworks','tblServers');
 IdField:array[TAmalgamation] of string=
  ('network_id','server_id');
 TitleField:array[TAmalgamation] of string=
  ('network_name','server_name');

var
  NetworkWin: TNetworkWin;

implementation

uses roMain, roNetworkProps, roServerProps, roConWin, roStuff, ADOInt;

{$R *.dfm}

procedure TNetworkWin.FormShow(Sender: TObject);
begin
  inherited;
  Refresh;
end;

procedure TNetworkWin.aNewNetworkExecute(Sender: TObject);
var
 rs:_RecordSet;
begin
  inherited;
 with NetworkPropWin do
  begin
   aName.Text:='';
   aDescription.Text:='';
   aNick.Text:='';
   aAltNick.Text:='';
   aFullName.Text:='';
   aEmail.Text:='';
  end;
 if NetworkPropWin.ShowModal=mrOk then
  begin
    rs:=CoRecordset.Create;
    rs.Open('tblNetworks',//'SELECT * FROM tblNetworks WHERE 0=1',
     MainWin.dbCon.ConnectionObject,adOpenDynamic,adLockOptimistic,adCmdTable);
    with NetworkPropWin do
     begin
      rs.AddNew(
       VarArrayOf([
        'network_name',
        'network_description',
        'network_nick',
        'network_created',
        'network_modified',
        'network_altnicks',
        'network_fullname',
        'network_email']),
       VarArrayOf([
        aName.Text,
        aDescription.Text,
        aNick.Text,
        VarFromDateTime(Now),
        VarFromDateTime(Now),
        aAltNick.Text,
        aFullName.Text,
        aEmail.Text]));
       oView.Selected:=AddNetworkNode(rs);
       if DoConnect then aConnect.Execute;
     end;
    rs:=nil;
  end;
end;

procedure TNetworkWin.Refresh;
var
 rs:_Recordset;
begin
 try
  oView.Items.BeginUpdate;
  oView.Items.Clear;
  rs:=CoRecordset.Create;
  rs.Open('tblNetworks',
   MainWin.dbCon.ConnectionObject,adOpenDynamic,adLockReadOnly,adCmdTable);
  rs.Sort:='network_name';
  while not(rs.EOF) do
   begin
    AddNetworkNode(rs);
    rs.MoveNext;
   end;
  rs:=nil;
 finally
  oView.Items.EndUpdate;
 end;
end;

function TNetworkWin.AddNetworkNode(const rs:_RecordSet):TTreeNode;
var
 n:TTreeNode;
 nd:TNodeData;
begin
 n:=oView.Items.Add(nil,VarToStr(rs.Fields.Item['network_name'].Value));
 n.HasChildren:=true;
 n.ImageIndex:=iiNetwork;
 n.SelectedIndex:=iiNetwork;
 nd:=TNodeData.Create;
 n.Data:=nd;
 nd.expanded:=false;
 nd.objtype:=alNetwork;
 nd.id:=rs.Fields.Item['network_id'].Value;
 Result:=n;
end;

function TNetworkWin.AddServerNode(const rs:_RecordSet;const p:TTreeNode):TTreeNode;
var
 n:TTreeNode;
 nd:TNodeData;
begin
 n:=oView.Items.AddChild(p,VarToStr(rs.Fields.Item['server_name'].Value));
 //n.HasChildren:=false;
 n.ImageIndex:=iiServer;
 n.SelectedIndex:=iiServer;
 nd:=TNodeData.Create;
 n.Data:=nd;
 nd.expanded:=false;
 nd.objtype:=alServer;
 nd.id:=rs.Fields.Item['server_id'].Value;
 Result:=n;
end;

procedure TNetworkWin.oViewExpanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
var
 rs:_RecordSet;
 nd:TNodeData;
begin
  inherited;

 if not(Node.Data=nil) then
  begin
   nd:=Node.Data;
   if not(nd.expanded) then
    begin
     Node.HasChildren:=false;
     nd.expanded:=true;
     case nd.objtype of
      alNetwork:
       begin
        rs:=CoRecordset.Create;
        rs.Open('SELECT * FROM tblServers WHERE server_network_id = '+IntToStr(nd.id)+
         ' ORDER BY server_name',
         Mainwin.dbCon.ConnectionObject,adOpenDynamic,adLockReadOnly,adCmdText);
        while not(rs.EOF) do
         begin
          AddServerNode(rs,Node);
          rs.MoveNext;
         end;
        rs:=nil;
       end;
      alServer:;
     end;
    end;
  end;

end;

procedure TNetworkWin.oViewDeletion(Sender: TObject; Node: TTreeNode);
begin
  inherited;
 if not(Node.Data=nil) then TNodeData(Node.Data).Free;
end;

procedure TNetworkWin.aNewServerExecute(Sender: TObject);
var
 n:TTreeNode;
 rs:_Recordset;
 port:integer;
begin
  inherited;
 n:=oView.Selected;
 while not(n=nil) and not(n.Data=nil) and
  not(TNodeData(n.Data).objtype=alNetwork) do
   n:=n.Parent;
 if n=nil then
  begin
   Application.Messagebox(
    PChar(roNoNetwork),PChar(AppName),MB_OK or MB_ICONINFORMATION);
  end
 else
  begin
   with ServerPropWin do
    begin
     aName.Text:='';
     aDescription.Text:='';
     aHost.Text:='';
     aPort.Text:='';
     aPorts.Text:='';
    end;
   if ServerPropWin.ShowModal=mrOk then
    begin
      rs:=CoRecordset.Create;
      rs.Open('tblServers',
       MainWin.dbCon.ConnectionObject,adOpenDynamic,adLockOptimistic,adCmdTable);
      with ServerPropWin do
       begin
        try
         port:=StrToInt(aPort.Text);
        except
         port:=6667;
        end;

        rs.AddNew(
         VarArrayOf([
          'server_network_id',
          'server_name',
          'server_description',
          'server_host',
          'server_defaultport',
          'server_ports',
          'server_created',
          'server_modified']),
         VarArrayOf([
          TNodeData(n.Data).id,
          aName.Text,
          aDescription.Text,
          aHost.Text,
          port,
          aPorts.Text,
          VarFromDateTime(Now),
          VarFromDateTime(Now)]));
         oView.Selected:=AddServerNode(rs,n);
         if DoConnect then aConnect.Execute;
       end;
      rs:=nil;
    end;

   //new server
  end;
end;

procedure TNetworkWin.oViewEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
var
 nd:TNodeData;
 rs:_Recordset;
begin
  inherited;
 if not(Node.Data=nil) then
  begin
   nd:=Node.Data;
   rs:=CoRecordset.Create;
   rs.Open(TableName[nd.objtype],
    MainWin.dbCon.ConnectionObject,adOpenDynamic,adLockOptimistic,adCmdTable);
   rs.Filter:=IdField[nd.objtype]+' = '+IntToStr(nd.id);
   if not(rs.EOF) then
     rs.Fields.Item[TitleField[nd.objtype]].Value:=s;
   rs:=nil;
  end;
end;

procedure TNetworkWin.aDeleteExecute(Sender: TObject);
var
 n:TTreeNode;
 nd:TNodeData;
begin
 inherited;
 n:=oView.Selected;
 if not(n=nil) and not(n.Data=nil) then
  begin
   nd:=n.Data;
   if Application.MessageBox(PChar(roDeleteItem),
     PChar(AppName),MB_OKCANCEL or MB_ICONQUESTION)=idOk then
    begin
     MainWin.dbCon.Execute(
      'DELETE FROM '+TableName[nd.objtype]+
      ' WHERE '+IdField[nd.objtype]+' = '+IntToStr(nd.id));
     n.Delete;
    end;
  end;
end;

procedure TNetworkWin.PopupMenu1Popup(Sender: TObject);
begin
  inherited;
 //kludge!
 oView.Selected:=oView.Selected;
end;

procedure TNetworkWin.aPropertiesExecute(Sender: TObject);
var
 n:TTreeNode;
 nd:TNodeData;
 rs:_Recordset;
 port:integer;
 s:string;
begin
 inherited;
 n:=oView.Selected;
 if not(n=nil) and not(n.Data=nil) then
  begin
   nd:=n.Data;
   rs:=CoRecordset.Create;
   rs.Open(TableName[nd.objtype],
    MainWin.dbCon.ConnectionObject,adOpenDynamic,adLockOptimistic,adCmdTable);
   s:=IdField[nd.objtype]+' = '+IntToStr(nd.id);
   rs.Filter:=s;
   case nd.objtype of
    alNetwork:
     begin
      with NetworkPropWin do
       begin
        aName.Text:=VarToStr(rs.Fields.Item['network_name'].Value);
        aDescription.Text:=VarToStr(rs.Fields.Item['network_description'].Value);
        aNick.Text:=VarToStr(rs.Fields.Item['network_nick'].Value);
        aAltNick.Text:=VarToStr(rs.Fields.Item['network_altnicks'].Value);
        aFullName.Text:=VarToStr(rs.Fields.Item['network_fullname'].Value);
        aEmail.Text:=VarToStr(rs.Fields.Item['network_email'].Value);
       end;
      if NetworkPropWin.ShowModal=mrOk then
       begin
        with NetworkPropWin do
         begin
          rs.Update(
           VarArrayOf([
            'network_name',
            'network_description',
            'network_nick',
            'network_modified',
            'network_altnicks',
            'network_fullname',
            'network_email']),
           VarArrayOf([
            aName.Text,
            aDescription.Text,
            aNick.Text,
            VarFromDateTime(Now),
            aAltNick.Text,
            aFullName.Text,
            aEmail.Text]));
          n.Text:=aName.Text;
          if DoConnect then aConnect.Execute;
         end;
       end;
     end;
    alServer:
     begin
      with ServerPropWin do
       begin
        aName.Text:=VarToStr(rs.Fields.Item['server_name'].Value);
        aDescription.Text:=VarToStr(rs.Fields.Item['server_description'].Value);
        aHost.Text:=VarToStr(rs.Fields.Item['server_host'].Value);
        aPort.Text:=VarToStr(rs.Fields.Item['server_defaultport'].Value);
        aPorts.Text:=VarToStr(rs.Fields.Item['server_ports'].Value);
       end;
      if ServerPropWin.ShowModal=mrOk then
       begin
        with ServerPropWin do
         begin
          try
           port:=StrToInt(aPort.Text);
          except
           port:=6667;
          end;
          rs.Update(
           VarArrayOf([
            'server_name',
            'server_description',
            'server_host',
            'server_defaultport',
            'server_ports',
            'server_modified']),
           VarArrayOf([
            aName.Text,
            aDescription.Text,
            aHost.Text,
            port,
            aPorts.Text,
            VarFromDateTime(Now)]));
          n.Text:=aName.Text;
          if DoConnect then aConnect.Execute;
         end;
       end;
     end;
   end;
   rs:=nil;
  end;
end;

procedure TNetworkWin.oViewDblClick(Sender: TObject);
begin
 inherited;
 aProperties.Execute;
end;

procedure TNetworkWin.aConnectExecute(Sender: TObject);
var
 n:TTreeNode;
 nd:TNodeData;
 f:TConnectionWin;
begin
  inherited;
 //
 f:=TConnectionWin.Create(Application);
 n:=oView.Selected;
 if not(n=nil) and not(n.Data=nil) then
  begin
   nd:=n.Data;
   case nd.objtype of
    alNetwork:f.DataByNetwork(nd.id);
    alServer:f.DataByServer(nd.id);
   end;
   //f.DoConnect;
   f.ConnectOnComplete:=true;
  end;
end;

end.
