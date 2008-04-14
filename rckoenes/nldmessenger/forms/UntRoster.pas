{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntRoster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, VirtualTrees, ExtCtrls, StdCtrls,
  TntStdCtrls, ImgList, TntExtCtrls, JabberCOM_TLB, Menus, TntMenus;

Type
  PNodeData = ^TNodeData;
    TNodeData = record
      Caption     : Widestring;
      Data        : TCollectionItem;
  end;

type
  TFrmRoster = class(TTntForm)
    PnlTop: TTntPanel;
    vtRoster: TVirtualStringTree;
    ImgStatus: TImage;
    LblMyStatus: TTntLabel;
    LblStatus: TTntLabel;
    ImgLsStatus: TImageList;
    ImgLstRoster: TImageList;
    PupUser: TTntPopupMenu;
    mmChat: TTntMenuItem;
    mmMessage: TTntMenuItem;
    N7: TTntMenuItem;
    mmClientInfo: TTntMenuItem;
    mmGetVersion: TTntMenuItem;
    mmGetTime: TTntMenuItem;
    mmGetVcard: TTntMenuItem;
    N12: TTntMenuItem;
    mnRename: TTntMenuItem;
    mmDelete: TTntMenuItem;
    PupAgent: TTntPopupMenu;
    GwLogon: TTntMenuItem;
    GwLogoff: TTntMenuItem;
    N5: TTntMenuItem;
    GwProperties: TTntMenuItem;
    GwRemove: TTntMenuItem;
    mmLastSeen: TTntMenuItem;
    PupStatus: TTntPopupMenu;
    stOnline: TTntMenuItem;
    stFreeForChat: TTntMenuItem;
    stAway: TTntMenuItem;
    stExtendedAway: TTntMenuItem;
    stDoNotDisturb: TTntMenuItem;
    stCustom: TTntMenuItem;
    procedure TntFormCreate(Sender: TObject);
    procedure vtRosterGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtRosterPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtRosterGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure TntFormClose(Sender: TObject; var Action: TCloseAction);
    procedure vtRosterMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vtRosterDblClick(Sender: TObject);
    procedure vtRosterMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mmChatClick(Sender: TObject);
    procedure mmMessageClick(Sender: TObject);
    procedure mmGetVersionClick(Sender: TObject);
    procedure mmGetTimeClick(Sender: TObject);
    procedure mmLastSeenClick(Sender: TObject);
    procedure LblStatusClick(Sender: TObject);
    procedure mmDeleteClick(Sender: TObject);
    procedure mnRenameClick(Sender: TObject);
    procedure vtRosterGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure GwLogonClick(Sender: TObject);
    procedure GwLogoffClick(Sender: TObject);
  private
    { Private declarations }
    ClicktNode : TCollectionItem;
    procedure PopUpOffline(mouseX, mouseY : Integer);
    procedure PopUpOnline(mouseX, mouseY : Integer);
  public
    { Public declarations }
    procedure SetStatus(Value : JabberShowType; StatusMsg: WideString);
  end;

var
  FrmRoster: TFrmRoster;

implementation

uses UntJabber, UntMain, UntJRosterNodes;

{$R *.dfm}

procedure TFrmRoster.TntFormCreate(Sender: TObject);
begin
  vtRoster.NodeDataSize := SizeOf(TNodeData);
end;

procedure TFrmRoster.vtRosterGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
 pData : PNodeData;
begin
 pData    := sender.GetNodeData(Node);

 if (pData^.Data is TJGroupItem) then
   pData^.Caption := TJGroupItem(pData^.Data).Name
 else
 if (pData^.Data is TJContact) then
   pData^.Caption := TJContact(pData^.Data).Name
 else
  if (pData^.Data is TJAgent) then
   pData^.Caption := TJAgent(pData^.Data).Name
 else
 if (pData^.Data is TJResource) then
   begin
      if TJResource(pData^.Data).Collection.Count = 1 then
         pData^.Caption := TJResources(TJResource(pData^.Data).Collection).Parent.Name
      else
         pData^.Caption := TJResource(pData^.Data).Resource;
   end;

 CellText := pData^.Caption;
end;

procedure TFrmRoster.vtRosterPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
 pData : PNodeData;
begin
  pData := vtRoster.GetNodeData(node);
  if (pData^.Data is TJGroupItem) then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];
  If (pData^.Data is TJContact) and (TJContact(pData^.Data).SubscriptionType = jstNone ) then
    TargetCanvas.Font.Color := clRed;
end;

procedure TFrmRoster.vtRosterGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
   pData:    PNodeData;
begin
   pData      := Sender.GetNodeData(Node);

   if (pData^.Data is TJGroupItem) then
      exit
   else
   if (pData^.Data is TJContact) then
      if node.ChildCount > 0 then
         ImageIndex := 6
      else
         ImageIndex := 5
   else
   if (pData^.Data is TJAgent) then
      begin
        if TJAgent(pData^.Data).Online then
          ImageIndex := 8
        else
          ImageIndex := 7;
      end
   else
   if (pData^.Data is TJResource) then
      ImageIndex := TJResource(pData^.Data).Status;
   
end;

procedure TFrmRoster.TntFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   vtRoster.Clear;
end;

procedure TFrmRoster.vtRosterMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
 pData   : PNodeData;
 HitInfo : THitInfo;
begin
  // Get the node which is selected
  vtroster.GetHitTestInfoAt(x,y,true,HitInfo);

  //Put the recive Hitnode in clicktnode
  pData := vtRoster.GetNodeData(HitInfo.HitNode);
  if assigned(pData) then
      ClicktNode := pData^.Data
  else
    begin
      ClicktNode := nil;
      vtRoster.ClearSelection;
    end;
end;

procedure TFrmRoster.vtRosterDblClick(Sender: TObject);
begin
 // Check if there is a node selected
 if ClicktNode = nil then exit;

 if ClicktNode is TJContact then
   begin
      ScreenHandler.NewChat(TJContact(ClicktNode).JID,True);
   end
 else if ClicktNode is TJResource then
   begin
      ScreenHandler.NewChat(TJResource(ClicktNode).JID,True);
   end;

end;

procedure TFrmRoster.SetStatus(Value: JabberShowType; StatusMsg: WideString);
begin
  // clear the image (Status Logo)
  ImgStatus.Canvas.Brush.Color := clWhite;
  ImgStatus.Canvas.FillRect(ImgStatus.Canvas.ClipRect);

  // Draw status logo in image
  ImgLsStatus.Draw(ImgStatus.Canvas,0,0,Value,True);

  // Set the status label
  LblStatus.Caption := StatusMsg;
  LblStatus.Hint := StatusMsg;
end;

procedure TFrmRoster.vtRosterMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if assigned(ClicktNode) and (Button = mbRight) then
    begin
      if (ClicktNode is TJResource) then
        PopUpOnline(mouse.CursorPos.X,mouse.CursorPos.y);
      if (ClicktNode is TJAgent) then
        PupAgent.Popup(mouse.CursorPos.X,mouse.CursorPos.y);
      if (ClicktNode is TJContact) then
        PopUpOffline(mouse.CursorPos.X,mouse.CursorPos.y);
    end;
end;

procedure TFrmRoster.mmChatClick(Sender: TObject);
begin
if ClicktNode is TJResource then
      ScreenHandler.NewChat(TJResource(ClicktNode).JID,True);

if ClicktNode is TJContact then
      ScreenHandler.NewChat(TJContact(ClicktNode).JID,True);
end;

procedure TFrmRoster.mmMessageClick(Sender: TObject);
begin
if ClicktNode is TJResource then
      ScreenHandler.NewMessage(TJResource(ClicktNode).JID);

if ClicktNode is TJContact then
      ScreenHandler.NewMessage(TJContact(ClicktNode).JID);
end;

procedure TFrmRoster.mmGetVersionClick(Sender: TObject);
begin
if ClicktNode is TJResource then
      DmJabber.GetVersion(TJResource(ClicktNode).JID);
end;

procedure TFrmRoster.mmGetTimeClick(Sender: TObject);
begin
if ClicktNode is TJResource then
      DmJabber.GetTime(TJResource(ClicktNode).JID);
end;

procedure TFrmRoster.mmLastSeenClick(Sender: TObject);
begin
if ClicktNode is TJResource then
      DmJabber.GetLastSeen(TJResource(ClicktNode).JID);

if ClicktNode is TJContact then
      DmJabber.GetLastSeen(TJContact(ClicktNode).JID);
end;

procedure TFrmRoster.LblStatusClick(Sender: TObject);
var
 pt : TPoint;
begin
 pt := LblStatus.ClientToScreen(Point(0, LblStatus.Height));
 PupStatus.popup(pt.x, pt.y);
end;

procedure TFrmRoster.mmDeleteClick(Sender: TObject);

Function CanDelete : Integer;
begin
  result := windows.MessageBoxW(Application.Handle,
          'Are you sure you want to delete user' ,'Delete User?',
          MB_YESNO + MB_ICONEXCLAMATION + MB_DEFBUTTON2)
end;
begin
  if ClicktNode is TJResource then
    if CanDelete = IDYES then
      TJResources(TJResource(ClicktNode).Collection).Parent.DeleteUser;

  if ClicktNode is TJContact then
    if CanDelete = IDYES then
      TJContact(ClicktNode).DeleteUser;
end;

procedure TFrmRoster.mnRenameClick(Sender: TObject);
begin
  if ClicktNode is TJContact then
    ScreenHandler.ShowRenameUser(TJContact(ClicktNode).JID);

  if ClicktNode is TJResource then
    ScreenHandler.ShowRenameUser(TJResources(TJResource(ClicktNode).Collection).Parent.JID);
end;

procedure TFrmRoster.vtRosterGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  pData:    PNodeData;
begin
  pData    := Sender.GetNodeData(Node);

  if pData.Data is TJContact then
    With TJContact(pData.Data) do
      CellText := Name + #13#10 + JID;

  if pData.Data is TJResource then
    With TJResource(pData.Data) do
      CellText := Name + #13#10 + JID + #13#10 + 'Status: '+ StatusMsg;

  if pData.Data is TJAgent then
    begin
    end;
  //application.HintPause := 500 ;

end;

procedure TFrmRoster.PopUpOffline(mouseX, mouseY : Integer);
begin
  with PupUser do
  begin
    mmGetVersion.Visible := False;
    mmGetTime.Visible := False;
    Popup(mouseX, mouseY);
  end;
end;

procedure TFrmRoster.PopUpOnline(mouseX, mouseY : Integer);
begin
  with PupUser do
  begin
    mmGetVersion.Visible := True;
    mmGetTime.Visible := True;
    Popup(mouseX, mouseY);
  end;
end;

procedure TFrmRoster.GwLogonClick(Sender: TObject);
begin
  if ClicktNode is TJAgent then
    DMjabber.JabberSession.SendPresence( TJAgent(ClicktNode).JID, jptNormal, '', nil);
end;

procedure TFrmRoster.GwLogoffClick(Sender: TObject);
begin
  if ClicktNode is TJAgent then
    DMjabber.JabberSession.SendPresence( TJAgent(ClicktNode).JID, jptUnavailable, '', nil);
end;

end.
