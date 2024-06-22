object RegistratieForm: TRegistratieForm
  Left = 256
  Top = 169
  ActiveControl = BitBtn1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registratie'
  ClientHeight = 175
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 0
    Width = 385
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DaysLeft: TLabel
    Left = 8
    Top = 32
    Width = 385
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 56
    Width = 385
    Height = 113
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 28
      Height = 13
      Caption = 'Naam'
    end
    object Label3: TLabel
      Left = 8
      Top = 72
      Width = 81
      Height = 13
      Caption = 'Registratie Code:'
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
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 352
    Top = 72
  end
end
