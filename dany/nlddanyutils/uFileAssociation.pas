{-----------------------------------------------------------------------------
 Unit Name: uFileAssociation
 Author:    Stijn van Grinsven aka SVG_1986
 Purpose:   Getting an overview of a context menu
 History:   27/06/'03
              Released unit of the internet

 Extra note:
            If you want to thank me for writing this unit, then you can
            contact me at Stijnsadres@hotmail.com
            If you are "that" thankfull and you want to pay me for my work
            on this unit, than you can also contact me for that part:)

 Exception note:
            When you try to create an TFileAssociation class and you get an
            error.. you can do 2 things:)
              1: Remove the code that raises the error or
              2: remove the // at line 26 ( "//{$DEFINE I_WAS_THANKFULL}" )
-----------------------------------------------------------------------------}

unit uFileAssociation;

interface
Uses Classes;

//{$DEFINE I_WAS_THANKFULL}

Type
  TShellAction = Class
    Private
      FAlias: String;
      FCaption: String;
      FCommand: String;
      FOwner: TObject;
      Procedure SetCaption( Value: String );
      procedure SetCommand(const Value: String);
      Function GetLocation: String;
    Public
      Procedure Read;
      Procedure Write;

      Property Alias: String read FAlias;

      Property Caption: String read FCaption write SetCaption;
      Property Command: String read FCommand write SetCommand;

      Property Owner: TObject read FOwner write FOwner;
    End;

  TShellActionList = Class
    Private
      FInternList: TList;
      FLocation: String;
      Function Get( Index: Integer ): TShellAction;
      Procedure Put( Index: Integer; Value: TShellAction );
      Function GetCount: Integer;
    Public
      Constructor Create;
      Destructor Destroy; Override;

      Function Add( Const Alias: String ): TShellAction;
      Procedure Clear;

      Property Location: String read FLocation;
      Property Count: Integer read GetCount;
      Property Items[ Index: Integer ]: TShellAction read Get write Put; Default;
    End;

  TFileAssociation = Class
    Private
      FExtension, FClassName: String;
      FShellActionList: TShellActionList;
      Function GetClassName( Const Extension: String ): String;
      Procedure Clear;

      Function GetClassExists: Boolean;
      Function GetExtensionExists: Boolean;

      Function GetDefaultIcon: String;
      Procedure SetDefaultIcon( Value: String );

      Function GetShellActionList: TShellActionList;

      Procedure ClearShellActions;
    Public
      Constructor Create;
      Destructor Destroy; Override;

      Procedure SetExtension( Const Extension: String );
      Procedure SetClassName( Const ClassName: String );

      Property Extension: String read FExtension;
      //Not filled when created with the CLASSNAME parameter
      Property ClassName: String read FClassName;
      //Probably filled but could be empty when no CLASSNAME could be found

      Procedure ReadShellActions;

      Property ClassExists: Boolean read GetClassExists;
      Property ExtensionExists: Boolean read GetExtensionExists;

      Property DefaultIcon: String read GetDefaultIcon write SetDefaultIcon;
      Property ShellActions: TShellActionList read FShellActionList;
    End;

implementation
Uses Registry, Windows, SysUtils;

{ TFileAssociation }

procedure TFileAssociation.Clear;
begin
  FExtension := '';
  FClassName := '';
  ClearShellActions;
end;

procedure TFileAssociation.ClearShellActions;
Var
  I: Integer;
begin
  For I := 0 to FShellActionList.Count - 1 do
    FShellActionList[ I ].Free;
  FShellActionList.Clear;
end;

constructor TFileAssociation.Create;
begin
  FShellActionList := TShellActionList.Create;

  {$IFDEF I_WAS_THANKFULL}
  {$ELSE}
    Raise Exception.Create( 'Please read the header of this unit!' );
  {$ENDIF}
end;

destructor TFileAssociation.Destroy;
begin
  FShellActionList.Free;
  inherited;
end;

function TFileAssociation.GetClassExists: Boolean;
begin
  If FClassname = '' then
    Exit;
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;
      Result := KeyExists( FClassname );
    Finally
      Free;
    End;
end;

function TFileAssociation.GetClassName(const Extension: String): String;
begin
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;
      If OpenKey( Extension, False ) then
        Begin
          Result := ReadString( '' ); //The classname is located in the default
        End;
    Finally
      Free;
    End;
end;

function TFileAssociation.GetDefaultIcon: String;
Var
  FLocation: String;
begin
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;
      If ClassExists then
        FLocation := FClassname else
          FLocation := FExtension;

      If OpenKey( FLocation + '\DefaultIcon\', False ) then
        Result := ReadString( '' );
    Finally
      Free;
    End;
end;

function TFileAssociation.GetExtensionExists: Boolean;
begin
  If FExtension = '' then
    Exit;
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;
      Result := KeyExists( FExtension );
    Finally
      Free;
    End;
end;

function TFileAssociation.GetShellActionList: TShellActionList;
begin
  Result := FShellActionList;
  ReadShellActions;
end;

procedure TFileAssociation.ReadShellActions;
Var
  FLocation: String;
  ShellList: TStringlist;
  I: Integer;
  ShellAction: TShellAction;
begin
  ClearShellActions;
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;

      If ClassExists then
        FLocation := FClassname else
          FLocation := FExtension;
      FShellActionList.FLocation := FLocation + '\Shell\';
      If OpenKey( FLocation + '\Shell', False ) Then
        Begin
          ShellList := TStringlist.Create;
          Try
            GetKeyNames( ShellList );
            For I := 0 to ShellList.Count - 1 do
              begin
                ShellAction := FShellActionList.Add( ShellList[ I ] );

                ShellAction.Read;
              end;
          Finally
            ShellList.Free;
          End;
        End;
    Finally
      Free;
    End;
end;

procedure TFileAssociation.SetClassName(const ClassName: String);
begin
  Clear;
  FClassName := ClassName;
  ReadShellActions
end;

procedure TFileAssociation.SetDefaultIcon(Value: String);
Var
  FLocation: String;
begin
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;
      If ClassExists then
        FLocation := FClassname else
          FLocation := FExtension;

      If OpenKey( FLocation + '\DefaultIcon\', True ) then
        WriteString( '', Value );
    Finally
      Free;
    End;
end;

procedure TFileAssociation.SetExtension( const Extension: String );
begin
  Clear;
  FExtension := Extension;
  If Length( FExtension ) > 0 then
    If FExtension[ 1 ] <> '.' then
      FExtension := '.' + FExtension;
  FClassName := GetClassName( FExtension );
  ReadShellActions;
end;

{ TShellActionList }

Function TShellActionList.Add( Const Alias: String ): TShellAction;
Var
  I: Integer;
begin
  //See wether this alias already exists
  For I := 0 to Count - 1 do
    If CompareText( Alias, Items[ I ].Alias ) = 0 then
      begin
        Result := Items[ I ];
        Exit;
      end;

  Result := TShellAction.Create;
  Result.Owner := Self;
  Result.FAlias := Alias;
  FInternList.Add( Result );
end;

procedure TShellActionList.Clear;
begin
  FInternList.Clear;
end;

constructor TShellActionList.Create;
begin
  FInternList := TList.Create;
end;

destructor TShellActionList.Destroy;
begin
  FInternList.Free;
  inherited;
end;

function TShellActionList.Get(Index: Integer): TShellAction;
begin
  Result := FInternList[ Index ];
end;

function TShellActionList.GetCount: Integer;
begin
  Result := FInternList.Count;
end;

procedure TShellActionList.Put(Index: Integer; Value: TShellAction);
begin
  FInternList[ Index ] := Value;
end;

{ TShellAction }

function TShellAction.GetLocation: String;
begin
  If Not Assigned( Owner ) then
    Raise Exception.Create( 'Could not find a TShellActionList' );
  Result := TShellActionList( Owner ).Location;
end;

procedure TShellAction.Read;
begin
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;
      If OpenKey( GetLocation + Alias, False ) then
        begin
          FCaption := ReadString( '' );
          If OpenKey( 'Command', False ) then
            FCommand := ReadString( '' );
        end;
    Finally
      Free;
    end;
end;

procedure TShellAction.SetCaption(Value: String);
begin
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;
      If OpenKey( GetLocation + Alias, False ) then
        WriteString( '', Value );
    Finally
      Free;
    End;
end;

procedure TShellAction.SetCommand(const Value: String);
begin
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;
      If OpenKey( GetLocation + Alias + '\Command\', True ) then
        WriteString( '', Value );
      FCaption := Value;
    Finally
      Free;
    End;
end;

procedure TShellAction.Write;
begin
  With TRegistry.Create do
    Try
      RootKey := HKEY_CLASSES_ROOT;
      CreateKey( GetLocation + Alias );
    Finally
      Free;
    End;
end;

end.
