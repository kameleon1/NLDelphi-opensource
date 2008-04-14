unit NLDTRTTIUtils;

{
  :: NLDTRTTIUtils contains some wrapper classes and functions around the
  :: RunTime Type Information API provided by Delphi. This makes working with
  :: RTTI a bit easier.

  :$
  :$
  :$ NLDTranslate is released under the zlib/libpng OSI-approved license.
  :$ For more information: http://www.opensource.org/
  :$ /n/n
  :$ /n/n
  :$ Copyright (c) 2002 M. van Renswoude
  :$ /n/n
  :$ This software is provided 'as-is', without any express or implied warranty.
  :$ In no event will the authors be held liable for any damages arising from
  :$ the use of this software.
  :$ /n/n
  :$ Permission is granted to anyone to use this software for any purpose,
  :$ including commercial applications, and to alter it and redistribute it
  :$ freely, subject to the following restrictions:
  :$ /n/n
  :$ 1. The origin of this software must not be misrepresented; you must not
  :$ claim that you wrote the original software. If you use this software in a
  :$ product, an acknowledgment in the product documentation would be
  :$ appreciated but is not required.
  :$ /n/n
  :$ 2. Altered source versions must be plainly marked as such, and must not be
  :$ misrepresented as being the original software.
  :$ /n/n
  :$ 3. This notice may not be removed or altered from any source distribution.
}

{$I NLDTDefines.inc}

interface
uses
  SysUtils,
  TypInfo;

type
  {
    :$ Provides access to an object's RTTI information

    :: TNLDTRTTIInfo tries to wrap RTTI functionality in an easy
    :: to use class. It is build on an on-demand basis, which means it may
    :: miss functionality which is not required by NLDTranslate itself.
  }
  TNLDTRTTIInfo = class(TObject)
  private
    FObject:        TObject;

    // Used for caching the last property name / info
    FCachedName:    String;
    FCachedInfo:    PPropInfo;
  protected
    procedure SetObject(const Value: TObject); virtual;

    procedure ClearInfo(); virtual;
    procedure CacheInfo(const AName: String); virtual;
  public
    //:$ Initializes a new TNLDTRTTIInfo instance
    //:: Set the AObject parameter to the object you want to get RTTI
    //:: information from.
    constructor Create(AObject: TObject); virtual;

    //:$ Searches for a property with the specified name
    //:: Returns True if the object has a published property with the
    //:: specified name. False otherwise.
    function HasProperty(const AName: String): Boolean; virtual;

    //:$ Returns the type for the specified property
    function GetPropertyType(const AName: String): TTypeKind; virtual;

    //:$ Returns the specified property as a string
    function GetPropertyAsString(const AName: String): String; virtual;

    //:$ Returns the specified property as an object
    function GetPropertyAsObject(const AName: String): TObject; virtual;

    //:$ Sets the specified property as a string
    procedure SetPropertyAsString(const AName, AValue: String); virtual;

    //:$ Gets or sets the object to retrieve RTTI information from
    //:: RTTIObject initially corresponds to the AObject passed in the
    //:: constructor.
    property RTTIObject:      TObject read FObject  write SetObject;
  end;

implementation

{************************* TNLDTRTTIInfo
  Constructor
****************************************}
constructor TNLDTRTTIInfo.Create;
begin
  inherited Create();

  RTTIObject  := AObject;
end;


{************************* TNLDTRTTIInfo
  Misc RTTI
****************************************}
procedure TNLDTRTTIInfo.ClearInfo;
begin
  FCachedName := '';
  FCachedInfo := nil;
end;

procedure TNLDTRTTIInfo.CacheInfo;
begin
  if AName <> FCachedName then begin
    FCachedName := AName;
    FCachedInfo := GetPropInfo(FObject, AName);
  end;
end;


function TNLDTRTTIInfo.HasProperty;
begin
  Result  := False;

  CacheInfo(AName);
  if Assigned(FCachedInfo) then
    Result  := Assigned(FCachedInfo);
end;

function TNLDTRTTIInfo.GetPropertyType;
begin
  Result  := tkUnknown;

  CacheInfo(AName);
  if Assigned(FCachedInfo) then
    Result  := FCachedInfo^.PropType^.Kind;
end;


{************************* TNLDTRTTIInfo
  GetPropertyAs
****************************************}
function TNLDTRTTIInfo.GetPropertyAsObject;
begin
  Result  := nil;

  CacheInfo(AName);
  if Assigned(FCachedInfo) then
    if FCachedInfo^.PropType^.Kind = tkClass then
      Result  := GetObjectProp(FObject, FCachedInfo);
end;

function TNLDTRTTIInfo.GetPropertyAsString;
var
  iValue:         Integer;
  dValue:         Extended;
  eValue:         Int64;

begin
  Result  := '';

  CacheInfo(AName);
  if Assigned(FCachedInfo) then begin
    case FCachedInfo^.PropType^.Kind of
      tkInteger, tkChar, tkWChar:
        begin
          iValue  := GetOrdProp(FObject, FCachedInfo);
          Str(iValue, Result);
        end;
      tkEnumeration:
        begin
          Result  := GetEnumProp(FObject, FCachedInfo);
        end;
      tkFloat:
        begin
          dValue  := GetFloatProp(FObject, FCachedInfo);
          Result  := FloatToStr(dValue);
        end;
      tkString, tkLString:
        begin
          Result  := GetStrProp(FObject, FCachedInfo);
        end;
      tkSet:
        begin
          Result  := GetSetProp(FObject, FCachedInfo, True);
        end;
      tkWString:
        begin
          Result  := GetWideStrProp(FObject, FCachedInfo);
        end;
      tkVariant:
        begin
          Result  := GetVariantProp(FObject, FCachedInfo);
        end;
      tkInt64:
        begin
          eValue  := GetInt64Prop(FObject, FCachedInfo);
          Str(eValue, Result);
        end;
    end;
  end;
end;


{************************* TNLDTRTTIInfo
  SetPropertyAs
****************************************}
procedure TNLDTRTTIInfo.SetPropertyAsString;
var
  iValue:         Integer;
  dValue:         Extended;
  eValue:         Int64;

begin
  CacheInfo(AName);
  if not Assigned(FCachedInfo) then
    exit;

  case FCachedInfo^.PropType^.Kind of
    tkInteger, tkChar, tkWChar:
      begin
        iValue  := GetOrdProp(FObject, FCachedInfo);
        iValue  := StrToIntDef(AValue, iValue);
        SetOrdProp(FObject, FCachedInfo, iValue);
      end;
    tkEnumeration:
      begin
        iValue  := GetEnumValue(FCachedInfo^.PropType^, AValue);

        if iValue > -1 then
          SetOrdProp(FObject, FCachedInfo, iValue);
      end;
    tkFloat:
      begin
        try
          dValue  := StrToFloat(AValue);
          SetFloatProp(FObject, FCachedInfo, dValue);
        except
          // Ignore...
        end;
      end;
    tkString, tkLString:
      begin
        SetStrProp(FObject, FCachedInfo, AValue);
      end;
    tkSet:
      begin
        SetSetProp(FObject, FCachedInfo, AValue);
      end;
    tkWString:
      begin
        SetWideStrProp(FObject, FCachedInfo, AValue);
      end;
    tkVariant:
      begin
        SetVariantProp(FObject, FCachedInfo, AValue);
      end;
    tkInt64:
      begin
        eValue  := GetInt64Prop(FObject, FCachedInfo);
        eValue  := StrToInt64Def(AValue, eValue);
        SetInt64Prop(FObject, FCachedInfo, eValue);
      end;
  end;
end;



{************************* TNLDTRTTIInfo
  Properties
****************************************}
procedure TNLDTRTTIInfo.SetObject;
begin
  if FObject <> Value then begin
    ClearInfo();
    FObject := Value;
  end;
end;

end.
