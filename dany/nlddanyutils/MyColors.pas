unit MyColors;

interface

uses UiTypes, Graphics;

  const
  _clActiveBorder = $00B4B4B4;
  _clActiveCaption = $00D1B499;
  _clAppWorkSpace = $00ABABAB;
  _clBackground = $00000000;
  _clBtnFace = $00F0F0F0;
  _clBtnHighlight = $00FFFFFF;
  _clBtnShadow = $00A0A0A0;
  _clBtnText = $00000000;
  _clCaptionText = $00000000;
  _clDefault = $20000000;
  _clGradientActiveCaption = $00EAD1B9;
  _clGradientInactiveCaption = $00F2E4D7;
  _clGrayText = $006D6D6D;
  _clHighlight = $00D77800;
  _clHighlightText = $00FFFFFF;
  _clHotLight = $00CC6600;
  _clInactiveBorder = $00FCF7F4;
  _clInactiveCaption = $00DBCDBF;
  _clInactiveCaptionText = $00000000;
  _clInfoBk = $00E1FFFF;
  _clInfoText = $00000000;
  _clMenu = $00F0F0F0;
  _clMenuBar = $00F0F0F0;
  _clMenuHighlight = $00D77800;
  _clMenuText = $00000000;
  _clScrollBar = $00C8C8C8;
  _cl3DDkShadow = $00696969;
  _cl3DLight = $00E3E3E3;
  _clWindow = $00FFFFFF;
  _clWindowFrame = $00646464;
  _clWindowText = $00000000;
  _clBlack = $00000000;
  _clWhite = $00FFFFFF;
  _clGray = $808080;
  _clFuchsia = $FF00FF;
  _clred = $000000FF;
  _clGreen = $0000FF00;
  _clBlue = $FF0000;
  _clYellow = $0000FFFF;

function ReplaceSystemColor(Orig: TColor): integer;

implementation

function ReplaceSystemColor(Orig: TColor): integer;
begin
  case Orig of
    clActiveBorder: Result := _clActiveBorder;
    clActiveCaption: Result := _clActiveCaption;
    clAppWorkSpace: result := _clAppWorkSpace;
    clBackground: Result := _clBackground;
    clBtnFace: Result := _clBtnFace;
    clBtnHighlight: Result := _clBtnHighlight;
    clBtnShadow: Result := _clBtnShadow;
    clBtnText: Result := _clBtnText;
    clCaptionText: Result := _clCaptionText;
    clDefault: Result := _clDefault;
    clGradientActiveCaption: Result := _clGradientActiveCaption;
    clGradientInactiveCaption: Result := _clGradientInactiveCaption;
    clGrayText: Result := _clGrayText;
    clHighlight: Result := _clHighlight;
    clHighlightText: Result := _clHighlightText;
    clHotLight: Result := _clHotLight;
    clInactiveBorder: Result := _clInactiveBorder;
    clInactiveCaption: Result := _clInactiveCaption;
    clInactiveCaptionText: Result := _clInactiveCaptionText;
    clInfoBk: Result := _clInfoBk;
    clInfoText: Result := _clInfoText;
    clMenu: Result := _clMenu;
    clMenuBar: Result := _clMenuBar;
    clMenuHighlight: Result := _clMenuHighlight;
    clMenuText: Result := _clMenuText;
    clScrollBar: Result := _clScrollBar;
    cl3DDkShadow: Result := _cl3DDkShadow;
    cl3DLight: Result := _cl3DLight;
    clWindow: Result := _clWindow;
    clWindowFrame: Result := _clWindowFrame;
    clWindowText: Result := _clWindowText
  else Result := Orig;
  end;
end;

end.
