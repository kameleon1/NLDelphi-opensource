object Form1: TForm1
  Left = 194
  Top = 149
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 345
  ClientWidth = 775
  Color = clGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 162
    Top = 36
    object Spel1: TMenuItem
      Caption = '&Spel'
      object Deel1: TMenuItem
        Caption = '&Deel'
        OnClick = Deel1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Afsluiten1: TMenuItem
        Caption = '&Afsluiten'
        OnClick = Afsluiten1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object Doelvanhetspel1: TMenuItem
        Caption = '&Doel van het spel'
        OnClick = Doelvanhetspel1Click
      end
      object Info1: TMenuItem
        Caption = '&Info'
        OnClick = Info1Click
      end
    end
  end
end
