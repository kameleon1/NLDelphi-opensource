object FrmPassword: TFrmPassword
  Left = 459
  Top = 430
  BorderStyle = bsToolWindow
  Caption = 'Change Password'
  ClientHeight = 161
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = TntFormLXClose
  TaskBarButton = True
  PixelsPerInch = 96
  TextHeight = 13
  object TntLabel1: TTntLabel
    Left = 17
    Top = 63
    Width = 65
    Height = 13
    Caption = '&Old Password'
    FocusControl = EdtOld
  end
  object TntLabel2: TTntLabel
    Left = 11
    Top = 87
    Width = 71
    Height = 13
    Caption = '&New Password'
    FocusControl = EdtNew
  end
  object TntLabel3: TTntLabel
    Left = 24
    Top = 111
    Width = 58
    Height = 13
    Caption = '&Confirmation'
    FocusControl = EdtNewConfirm
  end
  object BtnChange: TTntButton
    Left = 132
    Top = 137
    Width = 75
    Height = 25
    Caption = 'Change'
    Enabled = False
    TabOrder = 4
    OnClick = BtnChangeClick
  end
  object BtnCancel: TTntButton
    Left = 215
    Top = 137
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = BtnCancelClick
  end
  object EdtOld: TTntEdit
    Left = 88
    Top = 60
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    OnChange = EdtOldChange
  end
  object EdtNew: TTntEdit
    Left = 88
    Top = 84
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    OnChange = EdtOldChange
  end
  object EdtNewConfirm: TTntEdit
    Left = 88
    Top = 108
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    OnChange = EdtOldChange
  end
  inline FrameTitle1: TFrameTitle
    Left = 0
    Top = 0
    Width = 291
    Height = 55
    Align = alTop
    TabOrder = 5
    inherited PnlTop: TTntPanel
      Width = 291
      Caption = 'Change password'
      inherited ImgLogo: TImage
        Left = 238
      end
    end
  end
end
