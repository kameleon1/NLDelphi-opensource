object RegistratieForm: TRegistratieForm
  Left = 181
  Top = 194
  Width = 423
  Height = 221
  Caption = 'Registratie'
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
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 386
    Height = 29
    Caption = 'Dit programma is niet geregistreerd.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Mess: TLabel
    Left = 16
    Top = 40
    Width = 3
    Height = 13
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 64
    Width = 385
    Height = 113
    Caption = ' Registreer nu: (aanvraag code bij dany.rosseel@advalvas.be) '
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 31
      Height = 13
      Caption = 'Naam:'
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 78
      Height = 13
      Caption = 'RegistratieCode:'
    end
    object Edit1: TEdit
      Left = 104
      Top = 32
      Width = 185
      Height = 21
      MaxLength = 15
      TabOrder = 0
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 104
      Top = 72
      Width = 185
      Height = 21
      TabOrder = 1
      OnChange = Edit1Change
    end
    object BitBtn1: TBitBtn
      Left = 304
      Top = 72
      Width = 73
      Height = 25
      TabOrder = 2
      OnClick = BitBtn1Click
      Kind = bkOK
    end
  end
end
