{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntIQ;

interface

uses
  Windows, SysUtils, Forms, ShlObj, JabberCOM_TLB;

  procedure resultLastSeen(FromJID : WideString; const Tag: IXMLTag);
  procedure getLastSeen(FromJID : WideString; const Tag: IXMLTag);
  procedure resultVCard(FromJID: WideString; const Tag: IXMLTag);

implementation

uses
  UntMain;
  
procedure resultLastSeen(FromJID : WideString; const Tag: IXMLTag);
begin
//
end;

procedure getLastSeen(FromJID : WideString; const Tag: IXMLTag);
begin
//
end;

procedure resultVCard(FromJID: WideString; const Tag: IXMLTag);
begin
//
end;

end.
