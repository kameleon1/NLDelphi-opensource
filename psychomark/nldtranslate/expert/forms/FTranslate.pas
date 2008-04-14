unit FTranslate;

interface

uses
  SysUtils,
  Classes,
  Controls,
  Forms,
  StdCtrls,
  ComCtrls,
  ToolsAPI,
  TypInfo,
  ImgList,
  ExtCtrls,
  UProperties;

type
  TfrmNLDTTranslate = class(TForm)
    sbStatus:         TStatusBar;
    tvComponents:     TTreeView;
    ilsTree:          TImageList;
    lvProperties:     TListView;
    sptProps:         TSplitter;

    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tvComponentsChange(Sender: TObject; Node: TTreeNode);
    procedure lvPropertiesChange(Sender: TObject; Item: TListItem; Change: TItemChange);
  private
    FEditor:          IOTAFormEditor;
    FProperties:      TNLDComponents;
    FPropFile:        String;
    FActiveComp:      TNLDComponentItem;
    FFormName:        String;

    procedure ListComponents(const AParent: IOTAComponent;
                             const AParentNode: TTreeNode;
                             const AImageIndex: TImageIndex);

    procedure GetComponent(Sender: TObject; const Name: String;
                           out Component: TComponent);
  public
    property Editor:    IOTAFormEditor  read FEditor  write FEditor;
  end;

implementation
uses
  Dialogs;

const
  CIMGForm      = 0;
  CIMGControl   = 1;
  CIMGComponent = 2;
  CIMGProperty  = 3;

{$R *.dfm}

{****************************************
  TfrmNLDTTranslate
****************************************}
procedure TfrmNLDTTranslate.FormShow;
var
  otaRoot:            IOTAComponent;

begin
  // If the editor is hidden, show it first, this prevents Access Violations
  // from occuring...
  FEditor.Show();
  FPropFile   := ChangeFileExt(FEditor.FileName, '.ntp');
  FProperties := TNLDComponents.Create();
  FProperties.OnGetComponent  := GetComponent;

  // Get form as component
  otaRoot := FEditor.GetRootComponent();

  if otaRoot <> nil then begin
    otaRoot.GetPropValueByName('Name', FFormName);
    Caption := Caption + ' - ' + FFormName;

    if FileExists(FPropFile) then
      FProperties.LoadFromFile(FPropFile);

    ListComponents(otaRoot, nil, CIMGForm);
    otaRoot := nil;
  end;
end;

procedure TfrmNLDTTranslate.FormDestroy;
begin
  if Assigned(FProperties) then begin
    FProperties.SaveToFile(FPropFile);
    FreeAndNil(FProperties);
  end;
end;


{****************************************
  Recursively list components
****************************************}
procedure TfrmNLDTTranslate.ListComponents;
var
  otaComponent:       IOTAComponent;
  iComponent:         Integer;
  pNode:              TTreeNode;
  sName:              String;
  sType:              String;
  pType:              TClass;
  pTemp:              TTreeNode;

begin
  // Add tree node
  AParent.GetPropValueByName('Name', sName);
  pNode               := tvComponents.Items.AddChild(AParentNode, sName);
  pNode.ImageIndex    := AImageIndex;
  pNode.SelectedIndex := AImageIndex;
  pNode.Data          := AParent.GetComponentHandle();

  // List components
  for iComponent  := 0 to AParent.GetComponentCount() - 1 do begin
    otaComponent  := AParent.GetComponent(iComponent);

    try
      sType := otaComponent.GetComponentType();
      pType := GetClass(sType);

      if Assigned(pType) then begin
        if pType.InheritsFrom(TWinControl) then
          // List sub-components
          ListComponents(otaComponent, pNode, CIMGControl)
        else begin
          otaComponent.GetPropValueByName('Name', sName);

          // It added a TTimer otherwise :confused:
          if Length(sName) > 0 then begin
            // Add tree node
            pTemp := tvComponents.Items.AddChild(pNode, sName);
            with pTemp do begin
              ImageIndex    := CIMGComponent;
              SelectedIndex := CIMGComponent;
              Data          := otaComponent.GetComponentHandle();
            end;
          end;
        end;
      end;
    finally
      otaComponent  := nil;
    end;
  end;

  if AParentNode = nil then
    pNode.Expand(True);
end;


procedure TfrmNLDTTranslate.tvComponentsChange;
  procedure GetTypeAndValue(const AComponent: TComponent;
                            const AProp: PPropInfo; out AType: String;
                            out AValue: String);
  const
    CTypeNames:   array[Low(TTypeKind)..High(TTypeKind)] of String  =
                  ('Unknown', 'Integer', 'Char', 'Enumeration', 'Float',
                   'String', 'Set', 'Class', 'Method', 'WideChar', 'String',
                   'String', 'Variant', 'Array', 'Record', 'Interface',
                   'Int64', 'Dynamic Array');

  var
    iValue:     Integer;
    dValue:     Double;

  begin
    AType := CTypeNames[AProp^.PropType^.Kind];

    case AProp^.PropType^.Kind of
      tkInteger:
        begin
          iValue  := GetOrdProp(AComponent, AProp);
          Str(iValue, AValue);
        end;
      tkChar, tkWChar, tkString, tkLString, tkWString:
        begin
          AValue  := GetStrProp(AComponent, AProp);
        end;
      tkFloat:
        begin
          dValue  := GetFloatProp(AComponent, AProp);
          AValue  := FloatToStr(dValue);
        end;
      tkSet:
        begin
        AValue  := GetSetProp(AComponent, AProp, True);
        end;
      tkEnumeration:
        begin
          AValue  := GetEnumProp(AComponent, AProp);
        end;
    else
      AValue  := '(unknown)';
    end;
  end;

var
  pComponent:       TComponent;
  pProps:           PPropList;
  iCount:           Integer;
  iSize:            Integer;
  iProp:            Integer;
  sName:            String;
  sValue:           String;
  sType:            String;

begin
  lvProperties.Clear();
  if not Assigned(Node) then exit;

  pComponent  := TComponent(Node.Data);

  if (Assigned(pComponent)) and (TObject(pComponent) is TComponent) then begin
    FActiveComp := FProperties.GetFromComponent(pComponent);

    lvProperties.Items.BeginUpdate();
    try
      // Retrieve the number of properties
      iCount  := GetPropList(pComponent.ClassInfo, tkProperties, nil);
      iSize   := iCount * SizeOf(TPropInfo);
      GetMem(pProps, iSize);

      try
        // Get the properties list
        GetPropList(pComponent.ClassInfo, tkProperties, pProps);

        for iProp := 0 to iCount - 1 do begin
          sName   := pProps[iProp]^.Name;
          GetTypeAndValue(pComponent, pProps[iProp], sType, sValue);

          with lvProperties.Items.Add() do begin
            Caption       := sName;
            SubItems.Add(sValue);
            SubItems.Add(sType);
            ImageIndex    := CIMGProperty;
            Checked       := FActiveComp.Selected[sName];
          end;
        end;
      finally
        FreeMem(pProps, iSize);
      end;
    finally
      lvProperties.Items.EndUpdate();
    end;
  end;
end;

procedure TfrmNLDTTranslate.lvPropertiesChange;
begin
  if Change = ctState then
    if Assigned(FActiveComp) then
      FActiveComp.Selected[Item.Caption]  := Item.Checked;
end;


procedure TfrmNLDTTranslate.GetComponent;
var
  otaComponent:       IOTAComponent;

begin
  if CompareText(Name, FFormName) = 0 then
    otaComponent  := FEditor.GetRootComponent()
  else
    otaComponent  := FEditor.FindComponent(Name);

  if Assigned(otaComponent) then begin
    Component     := TComponent(otaComponent.GetComponentHandle());
    otaComponent  := nil;
  end;
end;

end.









