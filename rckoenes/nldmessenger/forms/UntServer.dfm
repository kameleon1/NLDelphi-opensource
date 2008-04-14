object FrmServer: TFrmServer
  Left = 305
  Top = 211
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Server Information'
  ClientHeight = 237
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = TntFormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GbServer: TTntGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 97
    Caption = 'Server'
    TabOrder = 0
    object LblName: TTntLabel
      Left = 16
      Top = 24
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object LblVersionS: TTntLabel
      Left = 16
      Top = 40
      Width = 38
      Height = 13
      Caption = 'Version:'
    end
    object LblTimeS: TTntLabel
      Left = 16
      Top = 72
      Width = 26
      Height = 13
      Caption = 'Time:'
    end
    object LblServer: TTntLabel
      Left = 58
      Top = 24
      Width = 62
      Height = 13
      Caption = '<geting Info>'
      ParentShowHint = False
      ShowHint = True
    end
    object LblTime: TTntLabel
      Left = 58
      Top = 72
      Width = 61
      Height = 13
      Caption = '<geting info>'
      ParentShowHint = False
      ShowHint = True
    end
    object LblVersion: TTntLabel
      Left = 58
      Top = 40
      Width = 62
      Height = 13
      Caption = '<geting Info>'
      ParentShowHint = False
      ShowHint = True
    end
    object LblOsS: TTntLabel
      Left = 16
      Top = 56
      Width = 18
      Height = 13
      Caption = 'OS:'
    end
    object LblOs: TTntLabel
      Left = 58
      Top = 56
      Width = 61
      Height = 13
      Caption = '<geting info>'
      ParentShowHint = False
      ShowHint = True
    end
  end
  object BtnClose: TTntButton
    Left = 112
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = BtnCloseClick
  end
  object LsbGateways: TTntListBox
    Left = 8
    Top = 112
    Width = 281
    Height = 89
    ItemHeight = 13
    Sorted = True
    TabOrder = 2
  end
end
