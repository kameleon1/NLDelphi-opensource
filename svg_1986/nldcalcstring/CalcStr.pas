{-----------------------------------------------------------------------------
 Unit Name: CalcString© 
 Author:    Stijn van Grinsven
 Purpose:   With this unit it will be possible to calculate a String. So if a
            string contains this "33*(13+12)" the unit will return 825.
 History:
      3 / 11 / 2002:
                Today I started to create this unit. At the moment there are some
                bugs so basic calculations won't even work ( Oh my! )
      4 / 11 / 2002:
                I fixed the bugs ( yeah! ). The unit is now also able to use
                Variables like "PI".
                I'm going to handle functions in the String. So if we find
                "POWER( 2, 8 )" the function will return 256.
      5 / 11 / 2002:
                The function system is now working. I added basis functions
                like SIN(), COS(), POWER().
      6 / 11 / 2002:
                I uploaded the unit to the internet.

 Url:       This unit is downloadable for free at
                http://members.lycos.nl/SVG1986/Units/CalcStr.zip



-----------------------------------------------------------------------------}


unit CalcStr;

interface

uses sysutils, Classes, Dialogs, Math;

Type

 //Variable storage
 TVariable = Record
    Value: Double;
    Alias: String;
 end;

 TVariableList = Class
   Private
     List: Array of TVariable;
     FIndex: Integer;
   public
     Function GetNextVariable( Var Variable: TVariable ): Boolean;
     Function GetVariable( Const Alias: String; Var Variable: TVariable ): Boolean;

     Procedure AddVariable( Const Variable: TVariable );
     Procedure Reset;
   end;
 //End variable storage

 //Begin parameter storage
 TParam = Double;

 TParamList = Class
  Private
    List: Array of Tparam;
    FIndex: integer;
  Public
    Function GetNextParam( Var Param: TParam ): Boolean;

    Procedure AddParam( Const NewParam: TParam );
    Procedure Reset;
  end;
 //End parameter storage

 //Begin Function storage
 TFunctionProcAddress = Procedure ( Params: TParamList; Var Result: Double ) of Object;

 TFunction = Record
   ProcAddress: TFunctionProcAddress;
   Title: String; // TITLE( PARAMS )
 end;

 TFunctionList = Class
   Private
     List: Array of TFunction;
     FIndex: Integer;
   Public
     Function GetNextFunction( Var Func: TFunction ): Boolean;
     Function GetFunction( Const Title: String; Var Func: TFunction): Boolean;

     Procedure AddFunction( Const Func: TFunction );
     Procedure Reset;
   end;
 //End Function storage

 TStringCalculator = Class
   Private
     FVariableList: TVariableList; //here are all the variables stored
     FFunctionList: TFunctionList; //Here are all the functions stored

     function GetOperatorBefore( Const Str: String; Const Index: Integer ): integer;
     function GetOperatorAfter(const Str: String;
                               const Index: Integer): Integer;
     function GetBackPosOut(const Str: String; Chr, OutL,
                            OutR: Char): Integer;
     function BackPos(const Str: String; chr: String;
                      Index: Integer): integer;
     function NearestHighOperatorAdv(const Str: String): integer;
     function Pos(const Str: String; Chr: Char; Index: Integer): integer;
     function IncInnerPos(const Str: String; Chr, OutL, OutR: Char;
                          Index: Integer): integer;
     function GetFunctionBefore( Const Str: String; Const Index: Integer ): Integer;
     function OperatorCount( Const Str: String ): Integer;
     function ReplaceNegativeValues( Const Str: String ): String;
     Procedure ExtractParams( Var ParamList: TParamList; Const Str: String );

     function BuiltInFunction( Const Title: String; Params: TParamList; Var wasBuiltIn: Boolean ): Double;
     function FixString(Str: String): String;
     function CalcSimpleString(const Str: String): Double;
     function CalcString(const Str: String): Double;
     function FunctionImprovement( Str: String ): String;
     function StrToValue(Str: String): Double;
   Public

     Constructor Create;
     Destructor Destroy; Override;

     Function Calculate( Const Str: String ): Double;
 
     Property FunctionList: TFunctionList read FFunctionList;
     Property VariableList: TVariableList Read FVariableList;
   end;

{ External procedures / Functions }
Procedure AddVariable( StringCalculator: TStringCalculator;
                       Const VarAlias: String;
                       Const VarValue: Double );
Procedure AddFunction( StringCalculator: TStringCalculator;
                       Const FuncTitle: String;
                       Const FuncProcAddress: TFunctionProcAddress );
 
Const
   Operators = ['*', '/', '(', ')', '+', '-', '^' ];
   HighOperator: Array [1..2] of char =
                      ( '*', '/' );
   PriorOperators: Array [1..1] of char =
                      ( '^' );
   Functions: Array [1..3] of string =
                      ( 'SIN', 'COS', 'POWER' );


Function CompareStr( Const S1, S2: String ): Boolean;
 
Implementation

{ Starting with the External Procedures / Functions }
Procedure AddVariable( StringCalculator: TStringCalculator;
                       Const VarAlias: String;
                       Const VarValue: Double );
Var
  NewVar: TVariable;
begin
   NewVar.Value := VarValue;
   NewVar.Alias := VarAlias;
   If Assigned(StringCalculator) then
     StringCalculator.VariableList.AddVariable( NewVar ) else
       Raise Exception.create( 'Cannot assign variable "' + VarAlias + '"' );
end;

Procedure AddFunction( StringCalculator: TStringCalculator;
                       Const FuncTitle: String;
                       Const FuncProcAddress: TFunctionProcAddress );
Var
  NewFunc: TFunction;
  Error: Boolean;
begin
   Error := False;

   If @FuncProcAddress = NIL then
     Error := True;

   NewFunc.ProcAddress := FuncProcAddress;
   NewFunc.Title       := FuncTitle;
   If not Assigned(StringCalculator) then
     Error := True;

   If not Error then
     StringCalculator.FunctionList.AddFunction( NewFunc ) else
       Raise Exception.create( 'Cannot add function "' + FuncTitle + '"' );
end;

{ --------------------------- ----------------------------- }

{ The function wich handles every Internal "built-in" functions }

function TStringCalculator.BuiltInFunction(const Title: String;
  Params: TParamList; Var wasBuiltIn: Boolean): Double;
Var
  FuncIndex: Integer;
  F: Boolean;
  A,B: Double;
begin
  F := False;
  For FuncIndex := 1 to High( Functions ) do
   If CompareStr( Functions[FuncIndex], Title ) then
    begin
      F := True;
      Break;
    end;

  If not F then
    begin
      WasBuiltIn := False;
      Exit;
    end;

  WasBuiltIn := True;

  Case FuncIndex of
    1 { SINUS }   :
                    begin
                        Params.getnextParam( A );
                        Result := Sin( A );
                    end;
    2 { COSINUS } :
                    begin
                        Params.getnextParam( A );
                        Result := Cos( A );
                    end;
    3 { POWER }   :
                    begin
                        Params.getnextParam( A );
                        Params.getnextParam( B );
                        Result := Power( A, B );
                        Result := Result;
                    end;
  end;
end;

Function CompareStr( Const S1, S2: String ): Boolean;
begin
  result := Uppercase(Trim( S1 )) = Uppercase( Trim( S2 ));
end;

Function TStringCalculator.GetOperatorBefore( Const Str: String; Const Index: Integer ): integer;
Var
  I: Integer;
  F: Boolean;
begin
   Result := 0;
   F := false;
   For I := Index downto 1 do
       begin
         If Str[I] in Operators then
          begin
              F := True;
              Break;
          end;
       end;

   If F then
      Result := I else
        Result := 0;
end;

Function TStringCalculator.GetOperatorAfter( Const Str: String; Const Index: Integer ): Integer;
Var
  I: integer;
begin
   Result := 0;
   For I := Index to Length(Str)+1 do
    If I < Length(Str)+1 then
     begin
       If Str[I] in Operators then
              Break;
       end;

   Result := I;
end;

function TStringCalculator.OperatorCount(const Str: String): Integer;
Var
  I: integer;
begin
  Result := 0;
  I := Length( Str );

  I :=  GetOperatorBefore( Str, I );
  While I > 0 do
   begin
      Inc( Result );
      I :=  GetOperatorBefore( Str, I-1 );
   end;

  Result := Result;
end;

function TStringCalculator.GetFunctionBefore(const Str: String;
  const Index: Integer): Integer;
Var
  iLastPos, iPos, I: Integer;
  Func: Tfunction;
begin
  Ipos := -2;
  iLastPos := 0;

  FFunctionList.reset;
  While FFunctionList.GetNextFunction( Func ) do
   begin
     Ipos := BackPos( Str, Func.Title, Length( Str ) );
     If iPos > iLastPos then
       iLastPos := iPos;
   end;

  For I := 1 to High( Functions ) do
   begin
     iPos := BackPos( Str, Functions[I], Length( Str ) );
     If iPos > iLastPos then
       iLastPos := iPos;
   end;

  Result := iLastPos;
end;

Function TStringCalculator.GetBackPosOut( Const Str: String; Chr: Char; OutL, OutR: Char ): Integer;
Var
  I: Integer;
  Inner: Integer;
begin
  Result := 0;
  inner := 0; //Not inner
  For I := Length(Str) downto 1 do
    begin
      If Str[I] = OutL then
        Dec( Inner ) else
      If Str[I] = OutR then
        Inc( Inner ) else
      If Inner = 0 then
        If Str[I] = Chr then
          Begin
            Result := I;
            Exit;
          end;
    end;
end;

Function TStringCalculator.BackPos( Const Str: String; chr: String; Index: Integer ): integer;
Var
  I: Integer;
  S: String;
begin
  Result := 0;
  For I := Index downto 0 do
   If I > 0 then
    begin
      S := Copy( Str, I, Length( Chr ) );
      If CompareStr( S, Chr ) then
        Break;
    end;

   Result := I;
end;

Function TStringCalculator.NearestHighOperatorAdv( Const Str: String ): integer;
Var
  Lst: Array of integer;
  I: integer;
begin
  Setlength( lst, Length(HighOperator)+1 );
  For I := 1 to Length(HighOperator) do
    Lst[I] := GetBackPosOut( Str, HighOperator[I] , '(', ')' );

  Result := -1;
  For I := 1 to High(Lst) do
    If Lst[I] > Result then
      Result := Lst[I];

  Setlength( Lst, Length( PriorOperators ) + 1 );
  For I := 1 to Length( PriorOperators ) do
    Lst[I] := GetBackPosOut( Str, PriorOperators[I] , '(', ')' );

  For I := 1 to High( lst ) do
    If lst[I] > 0 then
      begin
        Result := 0;
        Break;
      end;

  For I := 1 to High( lst ) do
    If lst[I] > Result then
      Result := lst[I];
end;

Function TStringCalculator.Pos( Const Str: String; Chr: Char; Index: Integer ): integer;
Var
  I: Integer;
  F: Boolean;
begin
  F := False;

  For I := Index to Length(Str) do
    begin
      If Str[I] = Chr then
        begin
          F := True;
          Break;
        end;
    end;

  If F then
   Result := I else
     Result := 0;
end;

Function TStringCalculator.IncInnerPos( Const Str: String; Chr, OutL, OutR: Char; Index: Integer ): integer;
Var
  I, Inner: Integer;
begin
  Result := 0;
  inner  := 0;
  For I := Index to Length(Str) do
   begin
     If Str[I] = OutL then
       Inc( inner ) else
     If Str[I] = OutR then
       Dec( Inner );

     If Inner = 0 then
       if Str[I] = Chr then
         Break;
   end;

  Result := I;
end;

function TStringCalculator.FunctionImprovement( Str: String ): String;
var
  I, J: Integer;
  Tot, Title, ParamStr: String;
  Func: TFunction;
  Val: Double;
  ParamList: Tparamlist;
  WasBuiltIn: Boolean;
begin
  I := GetFunctionBefore( Str, Length( Str ));
  While I > 0 do
   begin
     Tot := Copy( Str, I, IncInnerPos( Str, ')', '(', ')', I) - I+1 );
     J := Pos( Tot, '(', 1);
     Title := Copy( Tot, 1, J-1 );
     ParamStr := Copy( Tot, J+1, Length( Tot )-J-1 );
     Delete( Str, I, length( Tot ));

     If FFunctionList.GetFunction( Title, Func ) then
       begin
         Val := 0;
         If @Func.ProcAddress = NIL then
           Raise Exception.create('Function "' + Title + '" is not initialized!') else
             begin
               ParamList := TparamList.Create;
               ExtractParams( ParamList, ParamStr );

               ParamList.Reset;
               Func.ProcAddress( ParamList, Val );
               ParamList.free;
             end;
       end else
        begin
               ParamList := TparamList.Create;
               ExtractParams( ParamList, ParamStr );

               ParamList.Reset;
               Val := BuiltInFunction( Title, ParamList, WasBuiltIn );
               ParamList.free;
               If Not WasBuiltIn then
                 Raise Exception.Create('"' + Title + '" is not a function!');
        end;
     Insert( Floattostr( Val ), Str, I );
     I := GetFunctionBefore( Str, Length( Str ));
   end;

  Str := StringReplace( Str, '-', '#', [RFReplaceALL] );
  Result := Str;
end;

Function TStringCalculator.FixString( Str: String ): String;
Var
  I, L, R: Integer;
  Tot, Main: String;
begin
  { Delete spaces }
  Str := StringReplace( Str, ' ', '', [RFReplaceAll] );

  { Make better Functions }
  Str := FunctionImprovement( Str );
  Main := Str;

  I := NearestHighOperatorAdv( Str );
  While I > 0 do
   begin
     L := GetOperatorBefore( Str, I - 1 );
     If L <= 0 then
      L := 0 else
         begin
           If Str[L] = ')' then
             L := BackPos( Str, '(', L );
         end;

     R := GetOperatorAfter( Str, I+1 );

     If Str[R] = '(' then
       R := Pos( Str, ')', R );

     Tot := '(' + Copy( Str, L+1, R-L-1 ) + ')';
     Result := Result + Copy(Str, 1, L) + Tot;

     Delete( Str, L+1, R-L-1 );
     Delete( Main, L+1, R-L-1 );
     Delete( Main, 1, L );
     If Str = '' then
       Str := Tot else
        Insert( Tot, Str, L+1 );
     I := NearestHighOperatorAdv( Str );
   end;

  Result := Str;
end;

Function TStringCalculator.CalcSimpleString( Const Str: String ): Double;
Var
  Left, Right: Double;
  Operator: Char;
  I: integer;
begin
  I := GetOperatorBefore( Str, Length(Str) );
  Operator := Str[I];
  Left  := StrToValue( Copy( Str, 1, I - 1 ));
  Right := StrToValue( Copy( Str, I+1, Length(Str) ));

  Case Operator of
   '+': Result := Left + right;
   '-': Result := Left - Right;
   '*': Result := Left * Right;
   '/': Result := Left / Right;
   '^': Result := Power( Left, Right );
  end;
end;

Function CorrectFloat( Str: String ): Boolean;
Var
  I: integer;
  D: Extended;
begin
  Result := False;
  Str := StringReplace( Str, '#', '-', [RFReplaceALL] );
  If Length(Str) = 0 then Exit;
  Val( Str, D, I );
  Result := Not (I > 0);
  If Not Result then
  If Str[I-1] = 'E' then //Exponentional!
    Result := True;
end;

Function TStringCalculator.StrToValue( Str: String ): Double;
Var
  Variable: TVariable;
begin
  { this function will convert a string to its value.
    If the string is a variable, the result is the
    value of the variable }

  Result := 0;
  If Str = '' then Exit;

  Str := StringReplace( Str, '#', '-', [RFReplaceALL] );

  If FVariableList.GetVariable( Str, Variable ) then
    Result := Variable.Value else
     begin
      If not CorrectFloat( Str ) then
           Raise Exception.Create('no variable or value: "' + Str + '"');
      try
        Result := StrtoFloat( Str );
      except
        on EConvertError do
           Raise Exception.create('Error while processing "' + Str + '"');

      end;
     end;
end;

procedure TStringCalculator.ExtractParams( var ParamList: TParamList;
                                           const Str: String );
Var
  I: integer;
  Main, Cur: String;
  Val: Double;
begin
  Main := Str;
  I := Pos( Main, ',', 1 );
  While I > 0 do
   begin
      Cur := Copy( Main, 1, I - 1);
      //Showmessage( Cur );
      Val := CalcString( Cur );
      ParamList.AddParam( {StrToValue( Cur )}Val );

      Delete( Main, 1, I );
      I := Pos( Main, ',', 1 );
   end;

  If Length(Main) > 0 then
   begin
    //Showmessage( Main );
    Val := CalcString( Main );
      ParamList.AddParam( {StrToValue( Main )}Val );
   end;
end;

Function AdvFloattoStr( Const Val: Double; Chr: Char ): String;
begin
  Result := Floattostr( Val );
  If Val < 0 then
    Result[1] := Chr;
end;

Function TStringCalculator.CalcString( Const Str: String ): Double;
Var
  Main, Tot: String;
  I, R: Integer;
  Val: Double;
begin
  Result := 0;

  Main := FixString( Str );
  I := BackPos( Main, '(', Length(Main)  );
  While I > 0 do
   begin
     R := Pos( Main, ')', I );
     If R = 0 then
       Raise Exception.create( 'String is not valid' );

     Tot := Copy( Main, I, R - I+1 );
     //Delete ( & )
     If Length(Tot) > 0 then
      begin
        If (Tot[1] = '(') and (Tot[Length(Tot)] = ')') then
          Tot := FixString(Copy( Tot, 2, Length(Tot)-2));
      end;

     //Delete ( & )
     If Length(Tot) > 0 then
      begin
        If (Tot[1] = '(') and (Tot[Length(Tot)] = ')') then
         begin
          Tot := FixString(Copy( Tot, 2, Length(Tot)-2));
          Tot := Copy( Tot, 2, Length(Tot)-2 );
         end;
      end;

     If OperatorCount( Tot ) = 1 then
        Val := CalcSimpleString( Tot ) else  //CalcSimpleString
          Val := CalcString( Tot );  //CalcString { advanced }
     Delete( Main, I, R - I+1 );
     Insert( AdvFloattostr( Val, '#' ), Main, I );

     I := BackPos( Main, '(', Length(Main) );
   end;

   I := GetOperatorBefore( Main, Length(Main) );
   While I > 0 do
    begin
      R := GetOperatorBefore( Main, I-1 );
      If R <= 0 then
       begin
        Val := CalcSimpleString( Main );
        Main := AdvFloattoStr( Val, '#' );
       end else
         begin
           Val := CalcSimpleString( Copy( Main, R + 1, Length(Main)));
           Delete( Main, R+1, Length(Main));
           Insert( AdvFloattoStr( Val, '#' ), Main, R + 1 );
         end;

      I := GetOperatorBefore( Main, Length(Main) );
    end;

  Result := StrToValue( Main );
end;

function TStringCalculator.ReplaceNegativeValues(
  const Str: String): String;
Var
  I: Integer;
begin
   For I := 1 to Length(Str) do
    If str[I] = '-' then
     begin
       //
     end;
end;

{ TStringCalculator }

function TStringCalculator.Calculate( const Str: String ): Double;
begin
  Result := 0;

  Result := CalcString( Str );
end;

constructor TStringCalculator.Create;
begin
  FVariableList := TvariableList.Create;
  FFunctionList := TFunctionList.Create;
end;

destructor TStringCalculator.Destroy;
begin
  FVariableList.free;
  FFunctionList.free;

  Inherited;
end;

{ End of main part of this unit !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! }

{ TVariableList }

Procedure TVariableList.AddVariable(const Variable: TVariable);
Var
  I: Integer;
begin
  For I := 0 to High( List ) do
    If CompareStr( List[I].Alias, Variable.Alias ) then
      begin
        List[I].Value := Variable.Value;
        Exit;
      end;
  Setlength( List, Length( List )+1 );
  List[high(list)] := Variable;
end;

function TVariableList.GetNextVariable( var Variable: TVariable ): Boolean;
begin
  If FIndex < Length(List) then
    begin
      Result := True;
      Variable := List[Findex];
    end else
      begin
        Result := False;
        Reset;
        Exit;
      end;

      Inc( FIndex );
end;

function TVariableList.GetVariable(const Alias: String; Var Variable: TVariable ): Boolean;
Var
  I: Integer;
begin
  Result := False;
  For I := 0 to High( List ) do
   If CompareStr( List[I].Alias, Alias ) then
     begin
       Variable := List[I];
       Result := True;
       Exit;
     end;
end;

procedure TVariableList.Reset;
begin
  FIndex := 0;
end;

{ TParamList }

procedure TParamList.AddParam(const NewParam: TParam);
begin
  SetLength( List, Length( List ) + 1);
  List[High(List)] := NewParam;
end;

function TParamList.GetNextParam(var Param: TParam): Boolean;
begin
  If FIndex < Length(List) then
    begin
      Result := True;
      Param := List[Findex];
    end else
      begin
        Result := False;
        Reset;
        Exit;
      end;

      Inc( FIndex );
end;

procedure TParamList.Reset;
begin
  Findex := 0;
end;

{ TFunctionList }

procedure TFunctionList.AddFunction(const Func: TFunction);
Var
  I: Integer;
begin
  For I := 0 to High( list ) do
    If CompareStr( Func.Title, List[I].Title ) then
      begin
         List[I].ProcAddress := Func.ProcAddress;
         Exit;
      end;

  Setlength( List, Length(List)+1);
  List[High(list)] := Func;

end;

function TFunctionList.GetFunction(const Title: String; Var Func: TFunction): Boolean;
Var
  I: Integer;
begin
  Result := False;
  For I := 0 to High( List ) do
   If CompareStr( List[I].Title, Title ) then
     begin
       Func := List[I];
       Result := True;
       Exit;
     end;
end;

function TFunctionList.GetNextFunction(var Func: TFunction): Boolean;
begin
  If FIndex < Length(List) then
    begin
      Result := True;
      Func := List[Findex];
    end else
      begin
        Result := False;
        Reset;
        Exit;
      end;

      Inc( FIndex );
end;

procedure TFunctionList.Reset;
begin
  Findex := 0;
end;

end.
