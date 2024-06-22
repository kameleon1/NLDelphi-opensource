unit QuickSort;

interface

type
  TQuickSortCompare = function(I, J: integer): integer;
  TQuickSortExchange = procedure(I, J: integer);

procedure QSort(L, R: Integer; Compare: TQuickSortCompare; Exchange: TQuickSortExchange);

implementation

procedure QSort(L, R: Integer; Compare: TQuickSortCompare; Exchange: TQuickSortExchange);
  var
    I, J, P: Integer;
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
      if L < J then QSort(L, J, Compare, Exchange);
      L := I;
    until I >= R;
  end;

end.
