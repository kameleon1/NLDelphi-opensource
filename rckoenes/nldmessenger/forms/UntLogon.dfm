object FrmLogon: TFrmLogon
  Left = 381
  Top = 224
  ActiveControl = CbProxy
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Logon to Server'
  ClientHeight = 321
  ClientWidth = 267
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = TntFormLXCreate
  TaskBarButton = True
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TTntPageControl
    Left = 0
    Top = 55
    Width = 267
    Height = 240
    ActivePage = TsProxy
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object TsUser: TTntTabSheet
      Caption = 'User &Info'
      object LblUsername: TTntLabel
        Left = 0
        Top = 16
        Width = 48
        Height = 13
        Caption = '&Username'
        FocusControl = EdtUserName
      end
      object LblPassword: TTntLabel
        Left = 0
        Top = 40
        Width = 46
        Height = 13
        Caption = '&Password'
        FocusControl = EdtPassword
      end
      object LblServer: TTntLabel
        Left = 0
        Top = 64
        Width = 31
        Height = 13
        Caption = '&Server'
        FocusControl = EdtServer
      end
      object LblPort: TTntLabel
        Left = 0
        Top = 88
        Width = 19
        Height = 13
        Caption = 'P&ort'
        FocusControl = EdtPort
      end
      object LblPriority: TTntLabel
        Left = 0
        Top = 152
        Width = 31
        Height = 13
        Caption = 'Pr&iority'
        FocusControl = EdtPriority
      end
      object LblrResource: TTntLabel
        Left = 0
        Top = 128
        Width = 46
        Height = 13
        Caption = '&Rescoure'
        FocusControl = EdtResource
      end
      object Line: TTntBevel
        Left = 0
        Top = 112
        Width = 249
        Height = 2
      end
      object EdtUserName: TTntEdit
        Left = 56
        Top = 8
        Width = 193
        Height = 21
        TabOrder = 0
        OnKeyPress = EnterKeyPress
      end
      object EdtPort: TSpinEdit
        Left = 56
        Top = 80
        Width = 57
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 5222
        OnKeyPress = EnterKeyPress
      end
      object EdtPriority: TSpinEdit
        Left = 54
        Top = 144
        Width = 41
        Height = 22
        MaxValue = 10
        MinValue = 0
        TabOrder = 5
        Value = 1
        OnKeyPress = EnterKeyPress
      end
      object EdtResource: TTntEdit
        Left = 54
        Top = 120
        Width = 193
        Height = 21
        TabOrder = 4
        Text = 'TSIM'
        OnKeyPress = EnterKeyPress
      end
      object EdtServer: TTntComboBox
        Left = 56
        Top = 56
        Width = 193
        Height = 21
        AutoCloseUp = True
        ItemHeight = 13
        TabOrder = 2
        Text = 'Jabber.org'
        OnKeyPress = EnterKeyPress
        Items.WideStrings = (
          'Jabber.org'
          'myjabber.net'
          'jabber.com')
      end
      object EdtPassword: TTntEdit
        Left = 56
        Top = 32
        Width = 193
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
        OnKeyPress = EnterKeyPress
      end
      object CbSsl: TCheckBox
        Left = 56
        Top = 168
        Width = 97
        Height = 17
        Caption = 'Use ssl '
        TabOrder = 6
        Visible = False
        OnClick = CbSslClick
      end
    end
    object TsProxy: TTntTabSheet
      Caption = 'Prox&y Settings'
      ImageIndex = 1
      object LblProxy: TTntLabel
        Left = 8
        Top = 8
        Width = 26
        Height = 13
        Caption = 'Pro&xy'
        FocusControl = CbProxy
      end
      object GbProxyServer: TTntGroupBox
        Left = 0
        Top = 40
        Width = 247
        Height = 73
        Caption = 'Proxy Server'
        TabOrder = 1
        object LblProxyServer: TTntLabel
          Left = 8
          Top = 24
          Width = 31
          Height = 13
          Caption = '&Server'
          Enabled = False
          FocusControl = EdtProxyServer
        end
        object LblProxyPort: TTntLabel
          Left = 8
          Top = 48
          Width = 19
          Height = 13
          Caption = 'P&ort'
          Enabled = False
          FocusControl = EdtProxyPort
        end
        object EdtProxyServer: TTntEdit
          Left = 64
          Top = 16
          Width = 177
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object EdtProxyPort: TSpinEdit
          Left = 64
          Top = 40
          Width = 65
          Height = 22
          Enabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 8080
        end
      end
      object GbProxyUser: TTntGroupBox
        Left = 0
        Top = 120
        Width = 247
        Height = 73
        Caption = 'Proxy User'
        TabOrder = 2
        object LblProxyUser: TTntLabel
          Left = 8
          Top = 24
          Width = 22
          Height = 13
          Caption = '&User'
          Enabled = False
          FocusControl = EdtProxyUser
        end
        object LblProxyPassword: TTntLabel
          Left = 8
          Top = 48
          Width = 46
          Height = 13
          Caption = '&Password'
          Enabled = False
          FocusControl = EdtProxyPassword
        end
        object EdtProxyUser: TTntEdit
          Left = 64
          Top = 16
          Width = 177
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object EdtProxyPassword: TTntEdit
          Left = 64
          Top = 40
          Width = 177
          Height = 21
          Enabled = False
          PasswordChar = '*'
          TabOrder = 1
        end
      end
      object CbProxy: TTntComboBox
        Left = 56
        Top = 0
        Width = 145
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        ItemIndex = 0
        TabOrder = 0
        Text = 'None'
        OnChange = CbProxyChange
        Items.WideStrings = (
          'None'
          'Socks 4'
          'Socks 5')
      end
    end
    object TabSheet3: TTntTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      TabVisible = False
    end
  end
  object PnlBottom: TTntPanel
    Left = 0
    Top = 295
    Width = 267
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnLogon: TTntButton
      Left = 88
      Top = 0
      Width = 75
      Height = 25
      Caption = '&Logon'
      ModalResult = 1
      TabOrder = 0
      OnClick = BtnLogonClick
    end
    object BtnClose: TTntButton
      Left = 176
      Top = 0
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  inline FrameTitle1: TFrameTitle
    Left = 0
    Top = 0
    Width = 267
    Height = 55
    Align = alTop
    TabOrder = 2
    inherited PnlTop: TTntPanel
      Width = 267
      Caption = 'TSIM'
      inherited ImgLogo: TImage
        Left = 214
      end
    end
  end
end
