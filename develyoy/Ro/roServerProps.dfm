object ServerPropWin: TServerPropWin
  Left = 504
  Top = 127
  Width = 305
  Height = 340
  Caption = 'Server properties'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    297
    313)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = '&Name:'
    FocusControl = aName
  end
  object Label2: TLabel
    Left = 8
    Top = 160
    Width = 51
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '&Hostname:'
    FocusControl = aHost
  end
  object Label3: TLabel
    Left = 8
    Top = 200
    Width = 174
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Default&port: (leave empty for random)'
    FocusControl = aPort
  end
  object Label4: TLabel
    Left = 8
    Top = 48
    Width = 56
    Height = 13
    Caption = '&Description:'
    FocusControl = aDescription
  end
  object Label5: TLabel
    Left = 8
    Top = 240
    Width = 139
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '&Available ports: (use '#39','#39' and '#39'-'#39')'
    FocusControl = aPorts
  end
  object aName: TEdit
    Left = 8
    Top = 24
    Width = 281
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'aName'
  end
  object aHost: TEdit
    Left = 8
    Top = 176
    Width = 281
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    Text = 'aHost'
  end
  object aPort: TEdit
    Left = 8
    Top = 216
    Width = 281
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
    Text = 'aPort'
  end
  object aDescription: TMemo
    Left = 8
    Top = 64
    Width = 281
    Height = 89
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'aDesription')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object aPorts: TEdit
    Left = 8
    Top = 256
    Width = 281
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
    Text = 'aPorts'
  end
  object Button1: TButton
    Left = 152
    Top = 280
    Width = 65
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object Button2: TButton
    Left = 224
    Top = 280
    Width = 65
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object Button3: TButton
    Left = 8
    Top = 280
    Width = 81
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Connect'
    TabOrder = 7
    OnClick = Button3Click
  end
end
