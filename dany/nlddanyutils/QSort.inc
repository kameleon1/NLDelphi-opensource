  procedure QSort(L, R: LongInt);
  var
    I, J, P: LongInt;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while Compare(I, P) < 0 do Inc(I);
        while Compare(J, P) > 0 do Dec(J);
        if I <= J then
        begin
          Exchange(I, J);
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QSort(L, J);
      L := I;
    until I >= R;
  end;

(* TStringlist version

procedure TStringList.QuickSort(L, R: Integer; SCompare: TStringListSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;


*)