{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntProfile;

interface

uses
  { Delphi umits}
  Classes;

type
  TProfileCollectionItem = Class(TCollectionItem)
    Protected
      FProfile  : WideString;
      FUserName : WideString;
      FServer   : WideString;
      FResource : WideString;
      FPassword : WideString;
      FPort     : Integer;
      FPriority : Integer;
      Function GetJID : WideString;
    Public
      Property Profile  : WideString read FProfile Write FProfile;
      Property JID      : WideString Read GetJID;
      Property UserName : WideString Read FUserName Write FUserName;
      Property Server   : WideString Read FServer   Write FServer;
      Property Resource : WideString Read FResource Write FResource;
      Property Password : WideString Read FPassword Write FPassword;
      Property Port     : Integer    Read FPort     Write FPort;
      Property Priority : Integer    Read FPriority Write FPriority;
  end;

  TProfileCollection = Class(TCollection)
  private
    Protected
      Function  GetItem(Index: Integer): TProfileCollectionItem;
    Public
      Property  Items[Index: Integer]: TProfileCollectionItem read GetItem;
      Function  Add: TProfileCollectionItem;
      Procedure Open;
      Procedure Save;
  end;

implementation


{ TProfileCollection }

function TProfileCollection.Add: TProfileCollectionItem;
begin
 result := inherited Add as TProfileCollectionItem;
end;

function TProfileCollection.GetItem(Index: Integer): TProfileCollectionItem;
begin
  result := inherited Items[Index] as TProfileCollectionItem;
end;

procedure TProfileCollection.Open;
begin
 //
end;

procedure TProfileCollection.Save;
begin
//
end;


{ TProfileCollectionItem }

function TProfileCollectionItem.GetJID: WideString;
begin
 Result := FUserName+'@'+FServer+'/'+FResource;
end;

end.
