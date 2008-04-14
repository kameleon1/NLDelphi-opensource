{*******************************************************}
{                                                       }
{                     NLDMessenger                      }
{                                                       }
{  Copyright (c) 2000-2004 TRIPLE Software Corporation  }
{            Released under MPL on 1-3-2004             }
{   Author Remmelt Koenes (remmelt@triplesoftware.com)  }
{*******************************************************}

unit UntConfig;

interface

uses Graphics, SysUtils;

type
   TSoundList = Class
      Online        : WideString;
      Offline       : WideString;
      MsgRecive     : WideString;
      SubScription  : WideString;
   end;

   TTextFont = Class
      FontName      : WideString;
      FontSize      : Integer;
      BackGround    : TColor;
      System        : TColor;
      Time          : TColor;
      Error         : TColor;
      Normal        : TColor;
      Username      : TColor;
      YourUsername  : TColor;
   end;

   TProgSettings = Class
   Private
     FStayOnTop     : Boolean;
     FSounds        : TSoundList;
     FTextFont      : TTextFont;
     Function   GetShowOffline : Boolean;
     Procedure  SetShowOffline(Value : Boolean);
   Public
      Property StayOnTop      : Boolean         Read FStayOnTop       Write FStayOnTop;
      Property Sounds         : TSoundList      Read FSounds          Write FSounds;
      Property TextFont       : TTextFont       Read FTextFont        Write FTextFont;
      Property ShowOffline    : Boolean         Read GetShowOffline   Write SetShowOffline;
      Procedure   SaveSettings;
      Procedure   OpenSettings;
      constructor Create(); reintroduce;
      destructor  Destroy; override;
   end;

implementation

{ TProgSettings }

Uses  UntMain, UntJRosterNodes;

constructor TProgSettings.Create();
begin
  FTextFont       := TTextFont.Create;
  FSounds         := TSoundList.Create;
  inherited;
end;

destructor TProgSettings.Destroy;
begin
  FreeAndNil(FTextFont) ;
  FreeAndNil(FSounds);
  inherited;
end;

function TProgSettings.GetShowOffline: Boolean;
begin
   Result := JRoster.Contacts.ShowOffline;
end;

procedure TProgSettings.OpenSettings;
begin
  // check needed for existing settings?
  // check user dir

  // if not found load default!
  ProgSettings.TextFont.FontName := 'Arial';
  ProgSettings.TextFont.FontSize := 8;

  ProgSettings.TextFont.BackGround    := clWhite;
  ProgSettings.TextFont.Username      := clGreen;
  ProgSettings.TextFont.YourUsername  := clBlue;
  ProgSettings.TextFont.System        := clSilver;
  ProgSettings.TextFont.Time          := clSilver;
  ProgSettings.TextFont.Error         := clRed;
  ProgSettings.TextFont.Normal        := clBlack;

end;

procedure TProgSettings.SaveSettings;
begin
//
end;

procedure TProgSettings.SetShowOffline(Value: Boolean);
begin
   JRoster.Contacts.ShowOffline := Value;
end;

end.
