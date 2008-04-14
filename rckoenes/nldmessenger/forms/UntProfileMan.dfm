object FrmProfileMan: TFrmProfileMan
  Left = 350
  Top = 325
  Width = 430
  Height = 383
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Profile Manager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = TntFormLXClose
  TaskBarButton = True
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TTntPanel
    Left = 0
    Top = 322
    Width = 422
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Bevel2: TBevel
      Left = 0
      Top = 0
      Width = 422
      Height = 2
      Align = alTop
    end
    object btnNext: TTntButton
      Left = 254
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Next >'
      TabOrder = 0
    end
    object btnBack: TTntButton
      Left = 174
      Top = 6
      Width = 75
      Height = 25
      Caption = '< &Back'
      TabOrder = 1
    end
    object btnCancel: TTntButton
      Left = 342
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Cancel'
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object TntPageControl1: TTntPageControl
    Left = 0
    Top = 55
    Width = 422
    Height = 267
    ActivePage = tabWelkom
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object tabWelkom: TTntTabSheet
      Caption = 'tabWelkom'
      object TntRadioButton1: TTntRadioButton
        Left = 96
        Top = 112
        Width = 297
        Height = 17
        Caption = 'Edit a exciting or add a profiles'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object TntRadioButton2: TTntRadioButton
        Left = 96
        Top = 136
        Width = 217
        Height = 17
        Caption = 'Create a new profile and account'
        TabOrder = 1
      end
      object TntGroupBox1: TTntGroupBox
        Left = 8
        Top = 16
        Width = 377
        Height = 81
        Caption = 'Profile manager'
        TabOrder = 2
        object lblInfo: TTntStaticText
          Left = 16
          Top = 24
          Width = 353
          Height = 49
          Align = alCustom
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBiDiMode = False
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowAccelChar = False
          ShowHint = False
          TabOrder = 0
        end
      end
    end
    object tabOverview: TTntTabSheet
      Caption = 'tabOverview'
      object TntListView1: TTntListView
        Left = 0
        Top = 0
        Width = 337
        Height = 225
        Columns = <
          item
            Caption = 'Acoount'
            Width = 100
          end
          item
            Caption = 'JID'
            Width = 200
          end>
        TabOrder = 0
        ViewStyle = vsReport
      end
      object btnNew: TTntButton
        Left = 344
        Top = 8
        Width = 68
        Height = 25
        Caption = '&New'
        TabOrder = 1
      end
      object btnEdit: TTntButton
        Left = 344
        Top = 40
        Width = 68
        Height = 25
        Caption = '&Edit'
        TabOrder = 2
      end
      object btnDel: TTntButton
        Left = 344
        Top = 72
        Width = 68
        Height = 25
        Caption = '&Delete'
        TabOrder = 3
      end
    end
    object tabAccount: TTntTabSheet
      Caption = 'tabAccount'
      object TntGroupBox3: TTntGroupBox
        Left = 0
        Top = 0
        Width = 401
        Height = 161
        Caption = '<Accoutname>'
        TabOrder = 0
        object TntLabel1: TTntLabel
          Left = 24
          Top = 68
          Width = 46
          Height = 13
          Caption = '&Resource'
        end
        object TntLabel2: TTntLabel
          Left = 24
          Top = 44
          Width = 46
          Height = 13
          Caption = '&Password'
        end
        object TntLabel3: TTntLabel
          Left = 24
          Top = 20
          Width = 48
          Height = 13
          Caption = '&Username'
        end
        object TntLabel4: TTntLabel
          Left = 24
          Top = 116
          Width = 25
          Height = 13
          Caption = '&Poort'
        end
        object TntLabel6: TTntLabel
          Left = 24
          Top = 92
          Width = 31
          Height = 13
          Caption = '&Server'
        end
        object TntEdit1: TTntEdit
          Left = 94
          Top = 16
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object TntEdit2: TTntEdit
          Left = 94
          Top = 40
          Width = 200
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
        object TntEdit3: TTntEdit
          Left = 94
          Top = 64
          Width = 200
          Height = 21
          TabOrder = 2
          Text = 'TSIM'
        end
        object TntComboBox2: TTntComboBox
          Left = 93
          Top = 88
          Width = 200
          Height = 21
          ItemHeight = 13
          TabOrder = 3
          Text = 'jabber.org'
          Items.WideStrings = (
            'myjabber.net'
            'jabber.org'
            'jabber.com')
        end
        object SpinEdit1: TSpinEdit
          Left = 93
          Top = 112
          Width = 200
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 5222
        end
        object TntCheckBox1: TTntCheckBox
          Left = 93
          Top = 136
          Width = 200
          Height = 17
          Caption = 'Use SSL'
          TabOrder = 5
        end
      end
      object TntButton2: TTntButton
        Left = 296
        Top = 176
        Width = 100
        Height = 25
        Caption = 'Proxy Setting'
        TabOrder = 1
      end
    end
    object tabNewprofile: TTntTabSheet
      Caption = 'tabNewprofile'
      object TntLabel5: TTntLabel
        Left = 8
        Top = 4
        Width = 60
        Height = 13
        Caption = '&Profile Name'
      end
      object TntEdit4: TTntEdit
        Left = 71
        Top = 0
        Width = 138
        Height = 21
        TabOrder = 0
      end
      object TntGroupBox2: TTntGroupBox
        Left = 16
        Top = 32
        Width = 385
        Height = 161
        Caption = 'Account'
        TabOrder = 1
        object lblNewResource: TTntLabel
          Left = 24
          Top = 68
          Width = 46
          Height = 13
          Caption = '&Resource'
        end
        object lblNewPassword: TTntLabel
          Left = 24
          Top = 44
          Width = 46
          Height = 13
          Caption = '&Password'
        end
        object lblNewUserName: TTntLabel
          Left = 24
          Top = 20
          Width = 48
          Height = 13
          Caption = '&Username'
        end
        object lblNewPoort: TTntLabel
          Left = 24
          Top = 116
          Width = 25
          Height = 13
          Caption = '&Poort'
        end
        object lblNewServer: TTntLabel
          Left = 24
          Top = 92
          Width = 31
          Height = 13
          Caption = '&Server'
        end
        object edtNewUsername: TTntEdit
          Left = 94
          Top = 16
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object edtNewPassword: TTntEdit
          Left = 94
          Top = 40
          Width = 200
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
        object edtNewResource: TTntEdit
          Left = 94
          Top = 64
          Width = 200
          Height = 21
          TabOrder = 2
          Text = 'TSIM'
        end
        object TntComboBox1: TTntComboBox
          Left = 93
          Top = 88
          Width = 200
          Height = 21
          ItemHeight = 13
          TabOrder = 3
          Text = 'jabber.org'
          Items.WideStrings = (
            'myjabber.net'
            'jabber.org'
            'jabber.com')
        end
        object EdtPoort: TSpinEdit
          Left = 93
          Top = 112
          Width = 200
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 5222
        end
        object cbNewSSL: TTntCheckBox
          Left = 93
          Top = 136
          Width = 200
          Height = 17
          Caption = 'Use SSL'
          TabOrder = 5
        end
      end
      object TntButton1: TTntButton
        Left = 296
        Top = 200
        Width = 100
        Height = 25
        Caption = 'Proxy Settings'
        TabOrder = 2
      end
    end
  end
  inline FrameTitle1: TFrameTitle
    Left = 0
    Top = 0
    Width = 422
    Height = 55
    Align = alTop
    TabOrder = 2
    inherited PnlTop: TTntPanel
      Width = 422
      inherited ImgLogo: TImage
        Left = 369
      end
    end
  end
end
