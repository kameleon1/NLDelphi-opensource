unit Diff;

{define this if you want to use the debug facilities}
{.$DEFINE Debug}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TaaLCSDir = (
     ldNorth,
     ldNorthWest,
     ldWest);

  PaaLCSData = ^TaaLCSData;
  TaaLCSData = packed record
    ldLen  : integer;
    ldPrev : TaaLCSDir;
  end;

  TaaLCSMatrix = class
    private
      FCols     : integer;
      FMatrix   : TList;
      FRows     : integer;
    protected
      function mxGetItem(aRow, aCol : integer) : PaaLCSData;
      procedure mxSetItem(aRow, aCol : integer;
                          aValue : PaaLCSData);
    public
      constructor Create(aRowCount, aColCount : integer);
      destructor Destroy; override;

      procedure Clear;

      {$IFDEF Debug}
      procedure Dump;
      {$ENDIF}

      property Items[aRow, aCol : integer] : PaaLCSData
                  read mxGetItem write mxSetItem; default;

      property RowCount : integer read FRows;
      property ColCount : integer read FCols;
  end;

  TaaStringLCS = class
    private
      FFromStr : string;
      FMatrix  : TaaLCSMatrix;
      FToStr   : string;
    protected
      procedure slFillMatrix;
      function slGetCell(aFromInx, aToInx : integer) : integer;
      procedure slWriteChange(F : TStrings;
                                  aFromInx, aToInx : integer);
    public
      constructor Create(const aFromStr, aToStr : string);
      destructor Destroy; override;

      procedure WriteChanges(F : TStrings);
  end;

  TaaFileLCS = class
    private
      FFromFile : TStringList;
      FMatrix   : TaaLCSMatrix;
      FToFile   : TStringList;
    protected
      function slGetCell(aFromInx, aToInx : integer) : integer;
      procedure slWriteChange(F : TStrings;
                                  aFromInx, aToInx : integer);
    public
      Added, Deleted: Integer;
      constructor Create(aFromFile, aToFile : TStrings);
      destructor Destroy; override;
      procedure WriteChanges(F : TStrings = nil);
  end;


implementation

{===TaaLCSMatrix=====================================================}
constructor TaaLCSMatrix.Create(aRowCount, aColCount : integer);
var
  Row     : integer;
  ColList : TList;
begin
  {create the ancestor}
  inherited Create;

  {simple validation}
  if (aRowCount <= 0) or (aColCount < 0) then
    raise Exception.Create(
                  'TaaLCSMatrix.Create: Invalid Row or column count');
  FRows := aRowCount;
  FCols := aColCount;

  {create the matrix: it'll be a TList of TLists in row order}
  FMatrix := TList.Create;
  FMatrix.Count := aRowCount;
  for Row := 0 to pred(aRowCount) do begin
    ColList := TList.Create;
    ColList.Count := aColCount;
    TList(FMatrix.List^[Row]) := ColList;
  end;
end;
{--------}
destructor TaaLCSMatrix.Destroy;
var
  Row : integer;
begin
  {destroy the matrix}
  if (FMatrix <> nil) then begin
    Clear;
    for Row := 0 to pred(FRows) do
      TList(FMatrix.List^[Row]).Free;
    FMatrix.Free;
  end;

  {destroy the ancestor}
  inherited Destroy;
end;
{--------}
procedure TaaLCSMatrix.Clear;
var
  Row, Col : integer;
  ColList  : TList;
begin
  for Row := 0 to pred(FRows) do begin
    ColList := TList(FMatrix.List^[Row]);
    if (ColList <> nil) then
      for Col := 0 to pred(FCols) do begin
        Dispose(PaaLCSData(ColList.List^[Col]));
        ColList.List^[Col] := nil;
      end;
  end;
end;
{--------}
{$IFDEF Debug}
procedure TaaLCSMatrix.Dump;
var
  Row, Col : integer;
  LCSData  : PaaLCSData;
begin
  for Row := 0 to pred(FRows) do begin
    for Col := 0 to pred(FCols) do begin
      LCSData := Items[Row, Col];
      if (LCSData = nil) then begin
        write('  ? 0');
      end
      else begin
        case LCSData^.ldPrev of
          ldNorth     : write('  |');
          ldNorthWest : write('  \');
          ldWest      : write('  -');
        end;
        write(LCSData^.ldLen:2);
      end;
    end;
    writeln;
  end;
end;
{$ENDIF}
{--------}
function TaaLCSMatrix.mxGetItem(aRow, aCol : integer) : PaaLCSData;
begin
  if not ((0 <= aRow) and (aRow < RowCount) and
          (0 <= aCol) and (aCol < ColCount)) then
    raise Exception.Create(
         'TaaLCSMatrix.mxGetItem: Row or column index out of bounds');
  Result := PaaLCSData(TList(FMatrix.List^[aRow]).List^[aCol]);
end;
{--------}
procedure TaaLCSMatrix.mxSetItem(aRow, aCol : integer;
                    aValue : PaaLCSData);
begin
  if not ((0 <= aRow) and (aRow < RowCount) and
          (0 <= aCol) and (aCol < ColCount)) then
    raise Exception.Create(
         'TaaLCSMatrix.mxSetItem: Row or column index out of bounds');
  TList(FMatrix.List^[aRow]).List^[aCol] := aValue;
end;
{====================================================================}


{===TaaStringLCS=====================================================}
constructor TaaStringLCS.Create(const aFromStr, aToStr : string);
begin
  {create the ancestor}
  inherited Create;

  {save the strings}
  FFromStr := aFromStr;
  FToStr := aToStr;

  {create the matrix}
  FMatrix := TaaLCSMatrix.Create(succ(length(aFromStr)),
                                 succ(length(aToStr)));

  {now fill in the matrix}
  slGetCell(length(aFromStr), length(aToStr));
//  slFillMatrix;

  {$IFDEF Debug}
  writeln('Matrix for ', aFromStr, ' -> ', aToStr);
  FMatrix.Dump;
  {$ENDIF}
end;
{--------}
destructor TaaStringLCS.Destroy;
begin
  {destroy the matrix}
  FMatrix.Free;

  {destroy the ancestor}
  inherited Destroy;
end;
{--------}
procedure TaaStringLCS.slFillMatrix;
var
  FromInx : integer;
  ToInx   : integer;
  FromCh  : PAnsiChar;
  ToCh    : PAnsiChar;
  NorthLen: integer;
  WestLen : integer;
  LCSData : PaaLCSData;
begin
  {Create the empty items along the top and left sides}
  for ToInx := 0 to length(FToStr) do begin
    New(LCSData);
    LCSData.ldLen := 0;
    LCSData.ldPrev := ldWest;
    FMatrix[0, ToInx] := LCSData;
  end;
  for FromInx := 1 to length(FFromStr) do begin
    New(LCSData);
    LCSData.ldLen := 0;
    LCSData.ldPrev := ldNorth;
    FMatrix[FromInx, 0] := LCSData;
  end;

  {fill in the matrix, row by row, from left to right}
  FromCh := PAnsiChar(FFromStr);
  for FromInx := 1 to length(FFromStr) do begin
    ToCh := PAnsiChar(FToStr);
    for ToInx := 1 to length(FToStr) do begin
      {create the new item}
      New(LCSData);

      {if the two current chars are equal, increment the count
      from the northwest, that's our previous item}
      if (FromCh^ = ToCh^) then begin
        LCSData^.ldPrev := ldNorthWest;
        LCSData^.ldLen := succ(FMatrix[FromInx-1, ToInx-1]^.ldLen);
      end

      {otherwise the current characters are different: use the
      maximum of the north or west (west preferred}
      else begin
        NorthLen := FMatrix[FromInx-1, ToInx]^.ldLen;
        WestLen := FMatrix[FromInx, ToInx-1]^.ldLen;
        if (NorthLen > WestLen) then begin
          LCSData^.ldPrev := ldNorth;
          LCSData^.ldLen := NorthLen;
        end
        else begin
          LCSData^.ldPrev := ldWest;
          LCSData^.ldLen := WestLen;
        end;
      end;

      {set the item in the matrix}
      FMatrix[FromInx, ToInx] := LCSData;

      {move one char on in the to string}
      inc(ToCh);
    end;

    {move one char on in the from string}
    inc(FromCh);
  end;
  {at this point the item in the bottom right hand corner has
   the length of the LCS and the calculation is complete}
end;
{--------}
function TaaStringLCS.slGetCell(aFromInx, aToInx : integer) : integer;
var
  LCSData : PaaLCSData;
  NorthLen: integer;
  WestLen : integer;
begin
  if (aFromInx = 0) or (aToInx = 0) then
    Result := 0
  else begin
    LCSData := FMatrix[aFromInx, aToInx];
    if (LCSData <> nil) then
      Result := LCSData^.ldLen
    else begin
      {create the new item}
      New(LCSData);

      {if the two current chars are equal, increment the count
      from the northwest, that's our previous item}
      if (FFromStr[aFromInx] = FToStr[aToInx]) then begin
        LCSData^.ldPrev := ldNorthWest;
        LCSData^.ldLen := slGetCell(aFromInx-1, aToInx-1) + 1;
      end

      {otherwise the current characters are different: use the
      maximum of the north or west (west preferred}
      else begin
        NorthLen := slGetCell(aFromInx-1, aToInx);
        WestLen := slGetCell(aFromInx, aToInx-1);
        if (NorthLen > WestLen) then begin
          LCSData^.ldPrev := ldNorth;
          LCSData^.ldLen := NorthLen;
        end
        else begin
          LCSData^.ldPrev := ldWest;
          LCSData^.ldLen := WestLen;
        end;
      end;

      {set the item in the matrix}
      FMatrix[aFromInx, aToInx] := LCSData;

      {return the length of this LCS}
      Result := LCSData^.ldLen;
    end;
  end;
end;
{--------}
procedure TaaStringLCS.slWriteChange(F : TStrings;
                                         aFromInx, aToInx : integer);
var
  Cell : PaaLCSData;
begin
  {if both indexes are zero, this is the first
   cell of the LCS matrix, so just exit}
  if (aFromInx = 0) and (aToInx = 0) then
    Exit;

  {if the from index is zero, we're flush against the left
   hand side of the matrix, so go up; this'll be a deletion}
  if (aFromInx = 0) then begin
    slWriteChange(F, aFromInx, aToInx-1);
    F.Add('-> ' + FToStr[aToInx]);
  end
  {if the to index is zero, we're flush against the top side
   of the matrix, so go left; this'll be an insertion}
  else if (aToInx = 0) then begin
    slWriteChange(F, aFromInx-1, aToInx);
    F.Add('<- ' + FFromStr[aFromInx]);
  end
  {otherwise see what the cell says to do}
  else begin
    Cell := FMatrix[aFromInx, aToInx];
    case Cell^.ldPrev of
      ldNorth :
        begin
          slWriteChange(F, aFromInx-1, aToInx);
          F.Add('<- ' + FFromStr[aFromInx]);
        end;
      ldNorthWest :
        begin
          slWriteChange(F, aFromInx-1, aToInx-1);
          F.Add('   ' + FFromStr[aFromInx]);
        end;
      ldWest :
        begin
          slWriteChange(F, aFromInx, aToInx-1);
          F.Add('-> ' + FToStr[aToInx]);
        end;
    end;
  end;
end;
{--------}
procedure TaaStringLCS.WriteChanges(F : TStrings);
begin
  slWriteChange(F, length(FFromStr), length(FToStr));
end;
{====================================================================}


{===TaaFileLCS=====================================================}
constructor TaaFileLCS.Create(aFromFile, aToFile : TStrings);
begin
  {create the ancestor}
  inherited Create;

  {read the files}
  FFromFile := TStringList.Create;
  FFromFile.Assign(aFromFile);
  FToFile := TStringList.Create;
  FToFile.Assign(aToFile);

  {create the matrix}
  FMatrix := TaaLCSMatrix.Create(FFromFile.Count, FToFile.Count);

  {now fill in the matrix}
  slGetCell(pred(FFromFile.Count), pred(FToFile.Count));

  Added := 0;
  Deleted := 0;
end;
{--------}
destructor TaaFileLCS.Destroy;
begin
  {destroy the matrix}
  FMatrix.Free;

  {free the string lists}
  FFromFile.Free;
  FToFile.Free;

  {destroy the ancestor}
  inherited Destroy;
end;
{--------}
function TaaFileLCS.slGetCell(aFromInx, aToInx : integer) : integer;
var
  LCSData : PaaLCSData;
  NorthLen: integer;
  WestLen : integer;
begin
  if (aFromInx = -1) or (aToInx = -1) then
    Result := 0
  else begin
    LCSData := FMatrix[aFromInx, aToInx];
    if (LCSData <> nil) then
      Result := LCSData^.ldLen
    else begin
      {create the new item}
      New(LCSData);

      {if the two current lines are equal, increment the count
      from the northwest, that's our previous item}
      if (FFromFile[aFromInx] = FToFile[aToInx]) then begin
        LCSData^.ldPrev := ldNorthWest;
        LCSData^.ldLen := slGetCell(aFromInx-1, aToInx-1) + 1;
      end

      {otherwise the current lines are different: use the
      maximum of the north or west (west preferred}
      else begin
        NorthLen := slGetCell(aFromInx-1, aToInx);
        WestLen := slGetCell(aFromInx, aToInx-1);
        if (NorthLen > WestLen) then begin
          LCSData^.ldPrev := ldNorth;
          LCSData^.ldLen := NorthLen;
        end
        else begin
          LCSData^.ldPrev := ldWest;
          LCSData^.ldLen := WestLen;
        end;
      end;

      {set the item in the matrix}
      FMatrix[aFromInx, aToInx] := LCSData;

      {return the length of this LCS}
      Result := LCSData^.ldLen;
    end;
  end;
end;
{--------}
procedure TaaFileLCS.slWriteChange(F : TStrings;
                                         aFromInx, aToInx : integer);
var
  Cell : PaaLCSData;
begin
  {if both indexes are less than zero, this is the first
   cell of the LCS matrix, so just exit}
  if (aFromInx = -1) and (aToInx = -1) then
    Exit;

  {if the from index is less than zero, we're flush against the
   left hand side of the matrix, so go up; this'll be a deletion}
  if (aFromInx = -1) then begin
    slWriteChange(F, aFromInx, aToInx-1);
    if Assigned(F) then F.Add('-> ' + FToFile[aToInx]);
    Inc(Added);
  end
  {if the to index is less than zero, we're flush against the
   top side of the matrix, so go left; this'll be an insertion}
  else if (aToInx = -1) then begin
    slWriteChange(F, aFromInx-1, aToInx);
    if Assigned(F) then F.Add('<- ' + FFromFile[aFromInx]);
    Inc(Deleted);
  end
  {otherwise see what the cell says to do}
  else begin
    Cell := FMatrix[aFromInx, aToInx];
    case Cell^.ldPrev of
      ldNorth :
        begin
          slWriteChange(F, aFromInx-1, aToInx);
          if Assigned(F) then F.Add('<- ' + FFromFile[aFromInx]);
          Inc(Deleted);
        end;
      ldNorthWest :
        begin
          slWriteChange(F, aFromInx-1, aToInx-1);
          if Assigned(F) then F.Add('   ' + FFromFile[aFromInx]);
        end;
      ldWest :
        begin
          slWriteChange(F, aFromInx, aToInx-1);
          if Assigned(F) then F.Add('-> ' + FToFile[aToInx]);
          Inc(Added);
        end;
    end;
  end;
end;
{--------}
procedure TaaFileLCS.WriteChanges(F : TStrings = nil);
begin
  slWriteChange(F, pred(FFromFile.Count), pred(FToFile.Count));
end;
{====================================================================}

end.