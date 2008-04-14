object FrmChangeUserName: TFrmChangeUserName
  Left = 382
  Top = 283
  BorderStyle = bsDialog
  Caption = 'Change Username'
  ClientHeight = 120
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = TntFormClose
  PixelsPerInch = 96
  TextHeight = 13
  object LblOldNick: TTntLabel
    Left = 88
    Top = 16
    Width = 30
    Height = 13
    Caption = '<Foo>'
  end
  object LblNick: TTntLabel
    Left = 16
    Top = 16
    Width = 41
    Height = 13
    Caption = 'Old Nick'
  end
  object LblNewNick: TTntLabel
    Left = 16
    Top = 48
    Width = 47
    Height = 13
    Caption = '&New Nick'
    FocusControl = EdtNewNick
  end
  object EdtNewNick: TTntEdit
    Left = 88
    Top = 40
    Width = 201
    Height = 21
    TabOrder = 0
    OnChange = EdtNewNickChange
  end
  object BtnOk: TTntButton
    Left = 128
    Top = 72
    Width = 75
    Height = 25
    Caption = '&Ok'
    Enabled = False
    TabOrder = 1
    OnClick = BtnOkClick
  end
  object BtnCancel: TTntButton
    Left = 216
    Top = 71
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 2
    OnClick = BtnCancelClick
  end
  object StatusBar: TTntStatusBar
    Left = 0
    Top = 101
    Width = 293
    Height = 19
    Panels = <
      item
        Text = 'foo@bar.org'
        Width = 50
      end>
  end
end
