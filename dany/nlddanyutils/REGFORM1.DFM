object RegistratieForm: TRegistratieForm
  Left = 325
  Top = 201
  Width = 423
  Height = 221
  Caption = 'Registration'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 8
    Width = 238
    Height = 20
    Caption = 'This program is not yet registered.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DaysLeft: TLabel
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
    Caption = ' Register now: (ask registration code on rcs@skynet.be) '
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 28
      Height = 13
      Caption = 'Name'
    end
    object Label3: TLabel
      Left = 8
      Top = 72
      Width = 87
      Height = 13
      Caption = 'Registration Code:'
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
