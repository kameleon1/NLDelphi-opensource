object FrmNewUser: TFrmNewUser
  Left = 354
  Top = 206
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Creating a new jabber user'
  ClientHeight = 329
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PnlBottum: TTntPanel
    Left = 0
    Top = 300
    Width = 457
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      457
      29)
    object BtnCancel: TTntButton
      Left = 377
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = BtnCancelClick
    end
    object BtnNext: TTntButton
      Left = 286
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Next >'
      TabOrder = 1
    end
    object BtnBack: TTntButton
      Left = 201
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '< &Back'
      TabOrder = 2
    end
  end
  object PageControle: TTntPageControl
    Left = 0
    Top = 55
    Width = 457
    Height = 245
    ActivePage = TabWelkom
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object TabWelkom: TTntTabSheet
      Caption = 'TabWelkom'
      OnShow = TabWelkomShow
    end
    object TabUsername: TTntTabSheet
      Caption = 'TabUsername'
      OnShow = TabUsernameShow
      object TntLabel1: TTntLabel
        Left = 77
        Top = 29
        Width = 48
        Height = 13
        Caption = '&Username'
        FocusControl = EdtUserName
      end
      object TntLabel2: TTntLabel
        Left = 77
        Top = 53
        Width = 46
        Height = 13
        Caption = '&Password'
      end
      object TntLabel3: TTntLabel
        Left = 77
        Top = 101
        Width = 31
        Height = 13
        Caption = '&Server'
        FocusControl = EdtServer
      end
      object TntLabel4: TTntLabel
        Left = 77
        Top = 77
        Width = 58
        Height = 13
        Caption = '&Confirmation'
      end
      object TntLabel5: TTntLabel
        Left = 77
        Top = 128
        Width = 25
        Height = 13
        Caption = 'P&oort'
      end
      object EdtUserName: TTntEdit
        Left = 144
        Top = 24
        Width = 145
        Height = 21
        TabOrder = 0
      end
      object EdtPassword1: TTntEdit
        Left = 144
        Top = 48
        Width = 145
        Height = 21
        TabOrder = 1
      end
      object EdtServer: TTntComboBox
        Left = 144
        Top = 96
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 2
      end
      object EdtPassword2: TTntEdit
        Left = 144
        Top = 72
        Width = 145
        Height = 21
        TabOrder = 3
      end
      object SpinEdit1: TSpinEdit
        Left = 144
        Top = 120
        Width = 145
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 4
        Value = 5222
      end
    end
    object TabRegistering: TTntTabSheet
      Caption = 'TabRegistering'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnHide = TabRegisteringHide
      OnShow = TabRegisteringShow
      object LblWait: TTntStaticText
        Left = 200
        Top = 80
        Width = 65
        Height = 17
        Caption = 'PLease Wait'
        TabOrder = 0
      end
      object PrBarWait: TTntProgressBar
        Left = 40
        Top = 96
        Width = 377
        Height = 16
        TabOrder = 1
      end
    end
    object TabMoreInfo: TTntTabSheet
      Caption = 'TabMoreInfo'
      object LblExtra: TTntLabel
        Left = 96
        Top = 32
        Width = 38
        Height = 13
        Caption = 'LblExtra'
      end
      object LblMoreInfo: TTntLabel
        Left = 8
        Top = 0
        Width = 270
        Height = 13
        Caption = 'To create your account the server needs some more info:'
      end
      object EdtExtra: TTntEdit
        Left = 152
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'EdtExtra'
      end
    end
    object TabFinished: TTntTabSheet
      Caption = 'TabFinished'
      OnShow = TabFinishedShow
      object LblCongrats: TTntLabel
        Left = 32
        Top = 168
        Width = 3
        Height = 13
        Color = clBtnFace
        ParentColor = False
      end
      object LblFinal: TTntStaticText
        Left = 24
        Top = 72
        Width = 330
        Height = 113
        AutoSize = False
        Caption = 'LblFinal'
        TabOrder = 0
      end
    end
  end
  inline FrameTitle1: TFrameTitle
    Left = 0
    Top = 0
    Width = 457
    Height = 55
    Align = alTop
    TabOrder = 2
    inherited PnlTop: TTntPanel
      Width = 457
      Caption = 'Create a new user'
      inherited ImgLogo: TImage
        Left = 404
      end
    end
  end
  object WaitTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = WaitTimerTimer
    Left = 4
    Top = 296
  end
  object JabNew: TJabberSession
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 32
    Top = 296
  end
end
