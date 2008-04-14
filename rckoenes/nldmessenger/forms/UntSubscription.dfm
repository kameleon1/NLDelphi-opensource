object FrmSubscription: TFrmSubscription
  Left = 439
  Top = 335
  BorderStyle = bsDialog
  Caption = 'Subscription Request'
  ClientHeight = 248
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  TaskBarButton = True
  PixelsPerInch = 96
  TextHeight = 13
  object LblTheUser: TTntLabel
    Left = 8
    Top = 8
    Width = 50
    Height = 13
    Caption = 'The User: '
  end
  object LblUser: TTntLabel
    Left = 64
    Top = 8
    Width = 82
    Height = 13
    Caption = '<user name/JID>'
  end
  object Lblinfo: TTntLabel
    Left = 8
    Top = 24
    Width = 195
    Height = 13
    Caption = 'This user would like to see your presnce. '
  end
  object BtnOk: TTntButton
    Left = 200
    Top = 216
    Width = 75
    Height = 25
    Caption = '&Ok'
    Enabled = False
    TabOrder = 0
    OnClick = BtnOkClick
  end
  object EdtSubAsp: TTntMemo
    Left = 8
    Top = 56
    Width = 273
    Height = 49
    BorderStyle = bsNone
    Color = clBtnFace
    Lines.WideStrings = (
      '')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object GbSubType: TTntGroupBox
    Left = 8
    Top = 112
    Width = 273
    Height = 97
    TabOrder = 2
    object RbAccept: TTntRadioButton
      Left = 8
      Top = 24
      Width = 113
      Height = 17
      Caption = 'Accept'
      TabOrder = 0
      OnClick = CheckEnabled
    end
    object RbAcceptAdd: TTntRadioButton
      Left = 8
      Top = 48
      Width = 241
      Height = 17
      Caption = 'Accept and add to Roster'
      TabOrder = 1
      OnClick = CheckEnabled
    end
    object RbDecline: TTntRadioButton
      Left = 8
      Top = 72
      Width = 113
      Height = 17
      Caption = 'Decline'
      TabOrder = 2
      OnClick = CheckEnabled
    end
  end
end
