object ProxySetupForm: TProxySetupForm
  Left = 358
  Top = 308
  ActiveControl = Button1
  BorderIcons = [biSystemMenu]
  Caption = 'Proxy'
  ClientHeight = 281
  ClientWidth = 473
  Color = clBtnFace
  Constraints.MinHeight = 319
  Constraints.MinWidth = 489
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 400
    Top = 240
    Width = 57
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 144
    Width = 337
    Height = 121
    Caption = ' Authorisatie '
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 56
      Width = 28
      Height = 13
      Caption = 'Naam'
    end
    object Label2: TLabel
      Left = 16
      Top = 88
      Width = 47
      Height = 13
      Caption = 'Paswoord'
    end
    object Password: TEdit
      Left = 96
      Top = 88
      Width = 225
      Height = 21
      PasswordChar = '*'
      TabOrder = 0
      OnChange = ProxyAddressChange
    end
    object Name: TEdit
      Left = 96
      Top = 56
      Width = 225
      Height = 21
      TabOrder = 1
      OnChange = ProxyAddressChange
    end
    object AuthorisationCheckBox: TCheckBox
      Left = 24
      Top = 24
      Width = 297
      Height = 17
      Caption = 'Proxy authorisatie gebruiken'
      TabOrder = 2
      OnClick = AuthorisationCheckBoxClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 24
    Top = 16
    Width = 337
    Height = 113
    Caption = ' Configuratie '
    TabOrder = 2
    object Label3: TLabel
      Left = 16
      Top = 48
      Width = 27
      Height = 13
      Caption = 'Adres'
    end
    object Label4: TLabel
      Left = 16
      Top = 80
      Width = 25
      Height = 13
      Caption = 'Poort'
    end
    object ConfigCheckbox: TCheckBox
      Left = 24
      Top = 24
      Width = 297
      Height = 17
      Caption = 'Ik gebruik een proxy server'
      TabOrder = 0
      OnClick = ConfigCheckboxClick
    end
    object ProxyAddress: TEdit
      Left = 96
      Top = 48
      Width = 225
      Height = 21
      TabOrder = 1
      OnChange = ProxyAddressChange
    end
    object ProxyPort: TEdit
      Left = 96
      Top = 80
      Width = 57
      Height = 21
      TabOrder = 2
      Text = '1234'
      OnChange = ProxyAddressChange
    end
  end
end
