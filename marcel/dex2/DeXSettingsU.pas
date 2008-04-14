
{*****************************************************************}
{                                                                 }
{                     Delphi XML Data Binding                     }
{                                                                 }
{         Generated on: 5-5-2002 15:54:53                         }
{       Generated from: D:\Delphi6\NLDelphiTracker\Settings.xml   }
{   Settings stored in: D:\Delphi6\NLDelphiTracker\Settings.xdb   }
{                                                                 }
{*****************************************************************}
unit DeXSettingsU;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLSettingsType = interface;
  IXMLPopupType = interface;
  IXMLIgnoreSelfType = interface;
  IXMLNotifySoundType = interface;
  IXMLUserType = interface;
  IXMLSortType = interface;

{ IXMLSettingsType }

  IXMLSettingsType = interface(IXMLNode)
    ['{D61D3C42-E930-4718-8481-797814C984E9}']
    { Property Accessors }
    function Get_Version: WideString;
    function Get_Popup: IXMLPopupType;
    function Get_IgnoreSelf: IXMLIgnoreSelfType;
    function Get_AutoSave: Boolean;
    function Get_Interval: Integer;
    function Get_NotifySound: IXMLNotifySoundType;
    function Get_User: IXMLUserType;
    function Get_Sort: IXMLSortType;
    function Get_SiteURL: WideString;
    procedure Set_Version(Value: WideString);
    procedure Set_AutoSave(Value: Boolean);
    procedure Set_Interval(Value: Integer);
    procedure Set_SiteURL(Value: WideString);
    { Methods & Properties }
    property Version: WideString read Get_Version write Set_Version;
    property Popup: IXMLPopupType read Get_Popup;
    property IgnoreSelf: IXMLIgnoreSelfType read Get_IgnoreSelf;
    property AutoSave: Boolean read Get_AutoSave write Set_AutoSave;
    property Interval: Integer read Get_Interval write Set_Interval;
    property NotifySound: IXMLNotifySoundType read Get_NotifySound;
    property User: IXMLUserType read Get_User;
    property Sort: IXMLSortType read Get_Sort;
    property SiteURL: WideString read Get_SiteURL write Set_SiteURL;
  end;

{ IXMLPopupType }

  IXMLPopupType = interface(IXMLNode)
    ['{199AEEDB-A4C0-44C3-BC50-7DC0C6FECB10}']
    { Property Accessors }
    function Get_Color: WideString;
    function Get_Time: Integer;
    function Get_Enabled: Boolean;
    function Get_DeleteOnClick: Boolean;
    function Get_TextColor: WideString;
    function Get_LinkColor: WideString;
    procedure Set_Color(Value: WideString);
    procedure Set_Time(Value: Integer);
    procedure Set_Enabled(Value: Boolean);
    procedure Set_DeleteOnClick(Value: Boolean);
    procedure Set_TextColor(Value: WideString);
    procedure Set_LinkColor(Value: WideString);
    { Methods & Properties }
    property Color: WideString read Get_Color write Set_Color;
    property Time: Integer read Get_Time write Set_Time;
    property Enabled: Boolean read Get_Enabled write Set_Enabled;
    property DeleteOnClick: Boolean read Get_DeleteOnClick write Set_DeleteOnClick;
    property TextColor: WideString read Get_TextColor write Set_TextColor;
    property LinkColor: WideString read Get_LinkColor write Set_LinkColor;
  end;

{ IXMLIgnoreSelfType }

  IXMLIgnoreSelfType = interface(IXMLNode)
    ['{F68945D0-EDAD-4739-A07E-22F24BD9A01A}']
    { Property Accessors }
    function Get_Enabled: Boolean;
    function Get_Username: WideString;
    procedure Set_Enabled(Value: Boolean);
    procedure Set_Username(Value: WideString);
    { Methods & Properties }
    property Enabled: Boolean read Get_Enabled write Set_Enabled;
    property Username: WideString read Get_Username write Set_Username;
  end;

{ IXMLNotifySoundType }

  IXMLNotifySoundType = interface(IXMLNode)
    ['{6C1B23B0-FDB5-438A-92B4-DBD96CCFA9A0}']
    { Property Accessors }
    function Get_Enabled: Boolean;
    function Get_FileName: WideString;
    procedure Set_Enabled(Value: Boolean);
    procedure Set_FileName(Value: WideString);
    { Methods & Properties }
    property Enabled: Boolean read Get_Enabled write Set_Enabled;
    property FileName: WideString read Get_FileName write Set_FileName;
  end;

{ IXMLUserType }

  IXMLUserType = interface(IXMLNode)
    ['{41E85AA4-BDF7-4E02-AF06-6BD064FDE50C}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Password: WideString;
    function Get_Location: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Password(Value: WideString);
    procedure Set_Location(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Password: WideString read Get_Password write Set_Password;
    property Location: WideString read Get_Location write Set_Location;
  end;

{ IXMLSortType }

  IXMLSortType = interface(IXMLNode)
    ['{955D5C4A-77EC-432A-8508-8DDD6DB17847}']
    { Property Accessors }
    function Get_Direction: Integer;
    function Get_SortType: Integer;
    procedure Set_Direction(Value: Integer);
    procedure Set_SortType(Value: Integer);
    { Methods & Properties }
    property Direction: Integer read Get_Direction write Set_Direction;
    property SortType: Integer read Get_SortType write Set_SortType;
  end;

{ Forward Decls }

  TXMLSettingsType = class;
  TXMLPopupType = class;
  TXMLIgnoreSelfType = class;
  TXMLNotifySoundType = class;
  TXMLUserType = class;
  TXMLSortType = class;

{ TXMLSettingsType }

  TXMLSettingsType = class(TXMLNode, IXMLSettingsType)
  protected
    { IXMLSettingsType }
    function Get_Version: WideString;
    function Get_Popup: IXMLPopupType;
    function Get_IgnoreSelf: IXMLIgnoreSelfType;
    function Get_AutoSave: Boolean;
    function Get_Interval: Integer;
    function Get_NotifySound: IXMLNotifySoundType;
    function Get_User: IXMLUserType;
    function Get_Sort: IXMLSortType;
    function Get_SiteURL: WideString;
    procedure Set_Version(Value: WideString);
    procedure Set_AutoSave(Value: Boolean);
    procedure Set_Interval(Value: Integer);
    procedure Set_SiteURL(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPopupType }

  TXMLPopupType = class(TXMLNode, IXMLPopupType)
  protected
    { IXMLPopupType }
    function Get_Color: WideString;
    function Get_Time: Integer;
    function Get_Enabled: Boolean;
    function Get_DeleteOnClick: Boolean;
    function Get_TextColor: WideString;
    function Get_LinkColor: WideString;
    procedure Set_Color(Value: WideString);
    procedure Set_Time(Value: Integer);
    procedure Set_Enabled(Value: Boolean);
    procedure Set_DeleteOnClick(Value: Boolean);
    procedure Set_TextColor(Value: WideString);
    procedure Set_LinkColor(Value: WideString);
  end;

{ TXMLIgnoreSelfType }

  TXMLIgnoreSelfType = class(TXMLNode, IXMLIgnoreSelfType)
  protected
    { IXMLIgnoreSelfType }
    function Get_Enabled: Boolean;
    function Get_Username: WideString;
    procedure Set_Enabled(Value: Boolean);
    procedure Set_Username(Value: WideString);
  end;

{ TXMLNotifySoundType }

  TXMLNotifySoundType = class(TXMLNode, IXMLNotifySoundType)
  protected
    { IXMLNotifySoundType }
    function Get_Enabled: Boolean;
    function Get_FileName: WideString;
    procedure Set_Enabled(Value: Boolean);
    procedure Set_FileName(Value: WideString);
  end;

{ TXMLUserType }

  TXMLUserType = class(TXMLNode, IXMLUserType)
  protected
    { IXMLUserType }
    function Get_Name: WideString;
    function Get_Password: WideString;
    function Get_Location: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Password(Value: WideString);
    procedure Set_Location(Value: WideString);
  end;

{ TXMLSortType }

  TXMLSortType = class(TXMLNode, IXMLSortType)
  protected
    { IXMLSortType }
    function Get_Direction: Integer;
    function Get_SortType: Integer;
    procedure Set_Direction(Value: Integer);
    procedure Set_SortType(Value: Integer);
  end;

{ Global Functions }

function GetSettings(Doc: IXMLDocument): IXMLSettingsType;
function LoadSettings(const FileName: WideString): IXMLSettingsType;
function NewSettings: IXMLSettingsType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetSettings(Doc: IXMLDocument): IXMLSettingsType;
begin
  Result := Doc.GetDocBinding('Settings', TXMLSettingsType, TargetNamespace) as IXMLSettingsType;
end;

function LoadSettings(const FileName: WideString): IXMLSettingsType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Settings', TXMLSettingsType, TargetNamespace) as IXMLSettingsType;
end;

function NewSettings: IXMLSettingsType;
begin
  Result := NewXMLDocument.GetDocBinding('Settings', TXMLSettingsType, TargetNamespace) as IXMLSettingsType;
end;

{ TXMLSettingsType }

procedure TXMLSettingsType.AfterConstruction;
begin
  RegisterChildNode('Popup', TXMLPopupType);
  RegisterChildNode('IgnoreSelf', TXMLIgnoreSelfType);
  RegisterChildNode('NotifySound', TXMLNotifySoundType);
  RegisterChildNode('User', TXMLUserType);
  RegisterChildNode('Sort', TXMLSortType);
  inherited;
end;

function TXMLSettingsType.Get_Version: WideString;
begin
  Result := ChildNodes['Version'].Text;
end;

procedure TXMLSettingsType.Set_Version(Value: WideString);
begin
  ChildNodes['Version'].NodeValue := Value;
end;

function TXMLSettingsType.Get_Popup: IXMLPopupType;
begin
  Result := ChildNodes['Popup'] as IXMLPopupType;
end;

function TXMLSettingsType.Get_IgnoreSelf: IXMLIgnoreSelfType;
begin
  Result := ChildNodes['IgnoreSelf'] as IXMLIgnoreSelfType;
end;

function TXMLSettingsType.Get_AutoSave: Boolean;
begin
  Result := ChildNodes['AutoSave'].NodeValue;
end;

procedure TXMLSettingsType.Set_AutoSave(Value: Boolean);
begin
  ChildNodes['AutoSave'].NodeValue := Value;
end;

function TXMLSettingsType.Get_Interval: Integer;
begin
  Result := ChildNodes['Interval'].NodeValue;
end;

procedure TXMLSettingsType.Set_Interval(Value: Integer);
begin
  ChildNodes['Interval'].NodeValue := Value;
end;

function TXMLSettingsType.Get_NotifySound: IXMLNotifySoundType;
begin
  Result := ChildNodes['NotifySound'] as IXMLNotifySoundType;
end;

function TXMLSettingsType.Get_User: IXMLUserType;
begin
  Result := ChildNodes['User'] as IXMLUserType;
end;

function TXMLSettingsType.Get_Sort: IXMLSortType;
begin
  Result := ChildNodes['Sort'] as IXMLSortType;
end;

function TXMLSettingsType.Get_SiteURL: WideString;
begin
  Result := ChildNodes['SiteURL'].Text;
end;

procedure TXMLSettingsType.Set_SiteURL(Value: WideString);
begin
  ChildNodes['SiteURL'].NodeValue := Value;
end;

{ TXMLPopupType }

function TXMLPopupType.Get_Color: WideString;
begin
  Result := ChildNodes['Color'].Text;
end;

procedure TXMLPopupType.Set_Color(Value: WideString);
begin
  ChildNodes['Color'].NodeValue := Value;
end;

function TXMLPopupType.Get_Time: Integer;
begin
  Result := ChildNodes['Time'].NodeValue;
end;

procedure TXMLPopupType.Set_Time(Value: Integer);
begin
  ChildNodes['Time'].NodeValue := Value;
end;

function TXMLPopupType.Get_Enabled: Boolean;
begin
  Result := ChildNodes['Enabled'].NodeValue;
end;

procedure TXMLPopupType.Set_Enabled(Value: Boolean);
begin
  ChildNodes['Enabled'].NodeValue := Value;
end;

function TXMLPopupType.Get_DeleteOnClick: Boolean;
begin
  Result := ChildNodes['DeleteOnClick'].NodeValue;
end;

procedure TXMLPopupType.Set_DeleteOnClick(Value: Boolean);
begin
  ChildNodes['DeleteOnClick'].NodeValue := Value;
end;

function TXMLPopupType.Get_TextColor: WideString;
begin
  Result := ChildNodes['TextColor'].Text;
end;

procedure TXMLPopupType.Set_TextColor(Value: WideString);
begin
  ChildNodes['TextColor'].NodeValue := Value;
end;

function TXMLPopupType.Get_LinkColor: WideString;
begin
  Result := ChildNodes['LinkColor'].Text;
end;

procedure TXMLPopupType.Set_LinkColor(Value: WideString);
begin
  ChildNodes['LinkColor'].NodeValue := Value;
end;

{ TXMLIgnoreSelfType }

function TXMLIgnoreSelfType.Get_Enabled: Boolean;
begin
  Result := ChildNodes['Enabled'].NodeValue;
end;

procedure TXMLIgnoreSelfType.Set_Enabled(Value: Boolean);
begin
  ChildNodes['Enabled'].NodeValue := Value;
end;

function TXMLIgnoreSelfType.Get_Username: WideString;
begin
  Result := ChildNodes['Username'].Text;
end;

procedure TXMLIgnoreSelfType.Set_Username(Value: WideString);
begin
  ChildNodes['Username'].NodeValue := Value;
end;

{ TXMLNotifySoundType }

function TXMLNotifySoundType.Get_Enabled: Boolean;
begin
  Result := ChildNodes['Enabled'].NodeValue;
end;

procedure TXMLNotifySoundType.Set_Enabled(Value: Boolean);
begin
  ChildNodes['Enabled'].NodeValue := Value;
end;

function TXMLNotifySoundType.Get_FileName: WideString;
begin
  Result := ChildNodes['FileName'].Text;
end;

procedure TXMLNotifySoundType.Set_FileName(Value: WideString);
begin
  ChildNodes['FileName'].NodeValue := Value;
end;

{ TXMLUserType }

function TXMLUserType.Get_Name: WideString;
begin
  Result := ChildNodes['Name'].Text;
end;

procedure TXMLUserType.Set_Name(Value: WideString);
begin
  ChildNodes['Name'].NodeValue := Value;
end;

function TXMLUserType.Get_Password: WideString;
begin
  Result := ChildNodes['Password'].Text;
end;

procedure TXMLUserType.Set_Password(Value: WideString);
begin
  ChildNodes['Password'].NodeValue := Value;
end;

function TXMLUserType.Get_Location: WideString;
begin
  Result := ChildNodes['Location'].Text;
end;

procedure TXMLUserType.Set_Location(Value: WideString);
begin
  ChildNodes['Location'].NodeValue := Value;
end;

{ TXMLSortType }

function TXMLSortType.Get_Direction: Integer;
begin
  Result := ChildNodes['Direction'].NodeValue;
end;

procedure TXMLSortType.Set_Direction(Value: Integer);
begin
  ChildNodes['Direction'].NodeValue := Value;
end;

function TXMLSortType.Get_SortType: Integer;
begin
  Result := ChildNodes['SortType'].NodeValue;
end;

procedure TXMLSortType.Set_SortType(Value: Integer);
begin
  ChildNodes['SortType'].NodeValue := Value;
end;

end.
