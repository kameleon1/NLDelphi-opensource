object ErrorForm: TErrorForm
  Left = 237
  Top = 182
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Fout'
  ClientHeight = 90
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 16
  object Error: TLabel
    Left = 75
    Top = 16
    Width = 4
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 49
    Height = 49
  end
  object BitBtn1: TBitBtn
    Left = 128
    Top = 56
    Width = 73
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    TabOrder = 0
    Kind = bkOK
  end
end