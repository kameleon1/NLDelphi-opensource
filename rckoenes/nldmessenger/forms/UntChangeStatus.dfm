object FrmChangeStatus: TFrmChangeStatus
  Left = 415
  Top = 440
  BorderStyle = bsDialog
  Caption = 'Change status:'
  ClientHeight = 137
  ClientWidth = 283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = TntFormCreate
  TaskBarButton = True
  PixelsPerInch = 96
  TextHeight = 13
  object LblStatusMessage: TTntLabel
    Left = 8
    Top = 56
    Width = 76
    Height = 13
    Caption = 'Status Message'
  end
  object LblStatus: TTntLabel
    Left = 8
    Top = 8
    Width = 33
    Height = 13
    Caption = 'Status:'
  end
  object CboxStatus: TTntComboBox
    Left = 24
    Top = 24
    Width = 193
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 0
    OnDrawItem = CboxStatusDrawItem
    Items.WideStrings = (
      'Availble'
      'Free for chat'
      'Away'
      'Extended Away'
      'Do not disturb')
  end
  object EdtStatusMessage: TTntEdit
    Left = 24
    Top = 72
    Width = 249
    Height = 21
    TabOrder = 1
  end
  object BtnOk: TTntButton
    Left = 112
    Top = 104
    Width = 75
    Height = 25
    Caption = '&Ok'
    TabOrder = 2
    OnClick = BtnOkClick
  end
  object BtnCancel: TTntButton
    Left = 200
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 3
    OnClick = BtnCancelClick
  end
end
