unit DirListBox;

{ History of this unit:
  24-07-2006: * Initial version
  27-07-2006: * Simplified version
  12-05-2007: * even more simplified and faster version
  14-05-2007: * implemented the cursor hourglass during "busy" state
  15-07-2007: * removed an error in routine "SetSelection"
}

interface

uses Classes,
  SysUtils,
  ComCtrls,
  FileCtrl,
  StdCtrls,
  RcsStrings,
  RcsFileUtils;

type
  TViewChangeEvent = procedure(Selection: string);
  TDirectoryView = class
  private
    View: TTreeView;
    EditBox: TEdit;
    DriveBox: TDriveComboBox;
    fDrive: char;
    fSelection: string;
    BusySelecting: boolean;
    BusyExpandingNode: boolean;
    BusyDriveSelecting: boolean;
    BusyDriveSetting: boolean;
    HourGlassCounter: Integer;
    procedure SetHourGlass;
    procedure SetDefaultCursor;
    function GetPath(Item: TTreeNode): string;
    procedure ExpandNode(Item: TTreeNode);
    procedure SelectDrive(Drve: char);
    procedure SetDrive(Drve: Char);
    function GetDrive: char;
    procedure SetSelection(Dir: string);
    function GetSelection: string;
    procedure OnViewExpand(Sender: TObject; Node: TTreeNode);
    procedure OnViewChange(Sender: TObject; Node: TTreeNode);
    procedure OnDriveChange(Sender: TObject);
    procedure OnEditBoxChange(Sender: TObject);
  public
    OnChangeEvent: TViewChangeEvent;
    constructor Create(_View: TTreeView; _Drive: TDriveComboBox; _Edit: TEdit);
    property Drive: Char read GetDrive write SetDrive;
    property Selection: string read GetSelection write SetSelection;
  end;

implementation

uses Controls;

constructor TDirectoryView.Create(_View: TTreeView; _Drive: TDriveComboBox; _Edit: TEdit);
begin
  inherited Create;
  View := _View;
  EditBox := _Edit;
  DriveBox := _Drive;
  BusySelecting := false;
  BusyExpandingNode := false;
  BusyDriveSelecting := false;
  BusyDriveSetting := false;
  OnChangeEvent := nil;
  View.HideSelection := false;
  View.OnExpanded := OnViewExpand;
  View.OnChange := OnViewChange;
  if Drivebox <> nil then DriveBox.OnChange := OnDriveChange;
  if EditBox <> nil
    then EditBox.OnChange := OnEditBoxChange;
end;

procedure TDirectoryView.SetHourGlass;
begin
  if HourGlassCounter = 0 then View.Cursor := crHourGlass;
  Inc(HourGlassCounter);
end;

procedure TDirectoryView.SetDefaultCursor;
begin
  if HourGlassCounter > 0 then
  begin
    Dec(HourGlassCounter);
    if HourGlassCounter = 0 then View.Cursor := crDefault;
  end;
end;

// ExpandNode creates the children in the node to expand and sorts them

procedure TDirectoryView.ExpandNode(Item: TTreeNode);
const TmpText = '__~~_dummy^^^~~^';
var
  L: TFileList;
  I: Integer;
  Rec: TSearchrec;
  Node: TTreeNode;
  Tmp : Integer;
  TmpS : string;
begin
  if (not BusyExpandingNode) and (Item <> nil) then
  begin
    try
      BusyExpandingNode := true;
      SetHourGlass;

      View.Items.BeginUpdate;
      Item.AlphaSort(false);

      Tmp := Item.Count;
      for I := 0 to Tmp - 1 do Item[I].Text := TmpText;

      L := TFileList.Create;
      TmpS := IncludeTrailingBackSlash(GetPath(Item)) + '*.*';
      L.MakeFileList(TmpS, faDirectory, 0);
      for I := 1 to L.Count do
      begin
        L.GetEntry(I, Rec);
        if (Rec.Name <> '.') and (Rec.Name <> '..')
          then
        begin
          Node := View.Items.AddChild(Item, Rec.Name);
          Node.ImageIndex := 0;
          Node.SelectedIndex := 1;
          TmpS := IncludeTrailingBackSlash(GetPath(Item)) + IncludeTrailingBackSlash(Rec.Name) + '*.*';
          if DirectoryNameExists(TmpS) > '' then View.Items.AddChild(Node, TmpText);
        end;
      end;
      Item.AlphaSort(false);
      L.Free;
      Tmp := Item.Count;
      for I := Tmp - 1 downto 0 do   // delete the children that were already present
      begin
        Node := Item[I];
        if Node.Text = TmpText then Node.Delete;
      end;
    finally
      Item.AlphaSort(true);
      View.Items.EndUpdate;
      SetDefaultCursor;
      BusyExpandingNode := false;
    end;
  end;
end;

procedure TDirectoryView.SelectDrive(Drve: char);
var
  RootNode: TTreeNode;
begin
  if not BusyDriveSelecting then
  begin
    try
      BusyDriveSelecting := true;
      fDrive := Drve;
      with View.Items do
      begin
        try
          SetHourGlass;
          BeginUpdate;
          Clear; { remove any existing nodes }
          RootNode := Add(nil, Drve + ':\');
          RootNode.ImageIndex := 0;
          RootNode.SelectedIndex := 1;
          ExpandNode(RootNode);
          View.Select(RootNode);
          fSelection := GetPath(View.Selected);
        finally
          EndUpdate;
          SetDefaultCursor;
        end;
      end;
    finally
      BusyDriveSelecting := false;
    end;
  end;
end;

procedure TDirectoryView.SetDrive(Drve: char);
begin
  if not BusyDriveSetting then
  begin
    try
      BusyDriveSetting := true;
      Drve := UpCase(Drve);
      if DriveBox <> nil then DriveBox.Drive := Drve;
      SelectDrive(Drve);
    finally
      BusyDriveSetting := false;
    end;
  end;
end;

function TDirectoryView.GetDrive: char;
begin
  Result := fDrive;
end;

procedure TDirectoryView.SetSelection(Dir: string);
var
  Node: TTreeNode;
  Pth:  TStrings;
  I, J, N: Integer;
begin
  Dir := ExpandFileName(Dir);
  if (not BusySelecting) and (SysUtils.DirectoryExists(Dir)) then
  begin
    try
      BusySelecting := true;
      SetHourGlass;
      View.Items.BeginUpdate;

      if (fSelection = '') or (UpCase(Dir[1]) <> UpCase(FSelection[1]))
      then SetDrive(UpCase(Dir[1]));

      Pth := TstringList.Create;
      StringToTStrings(Dir, Pth, '\');
      TrimTStrings(Pth);

      Node := View.Items[0]; // rootnode
      Node.Expand(false);

      I := 1;
      N := -1;
      while I < Pth.Count do // find the next level in the path
      begin
        for J := 0 to Node.Count - 1 do
        begin
          N := -1;
          if Node[J].Text = Pth[I] then
          begin
            N := J;
            break;
          end;
        end;

        if N >= 0 then // subnode found
        begin
          Node := Node[J];
          Node.Expand(false);
        end;

        Inc(I);
      end;

      View.Select(Node);

      Pth.Free;
    finally
      View.Items.EndUpdate;
      SetDefaultCursor;
      BusySelecting := false;
    end;
  end;
end;

function TDirectoryView.GetSelection: string;
begin
  Result := fSelection;
end;

function TDirectoryView.GetPath(Item: TTreeNode): string;
var
  TmpNode: TTreeNode;
begin
  Result := '';
  if Item <> nil then
  begin
    TmpNode := Item;
    Result := TmpNode.Text;
    while TmpNode.Parent <> nil do
    begin
      TmpNode := TmpNode.Parent;
      Result := IncludeTrailingBackSlash(TmpNode.Text) + Result;
    end;
  end;
end;

// Event handlers

procedure TDirectoryView.OnViewExpand(Sender: TObject; Node: TTreeNode);
begin
  ExpandNode(Node);
end;

procedure TDirectoryView.OnViewChange(Sender: TObject; Node: TTreeNode);
begin
  fSelection := GetPath(View.Selected);
  if EditBox <> nil
    then EditBox.Text := fSelection
  else
    if (Assigned(OnChangeEvent)) and (not BusySelecting)
    then OnChangeEvent(fSelection);
end;

procedure TDirectoryView.OnDriveChange(Sender: TObject);
begin
  SelectDrive(DriveBox.Drive);
end;

procedure TDirectoryView.OnEditBoxChange(Sender: TObject);
begin
  if (Assigned(OnChangeEvent)) and (EditBox <> nil)
    then OnChangeEvent(fSelection);
end;

end.
