object NetworkPropWin: TNetworkPropWin
  Left = 444
  Top = 156
  Width = 305
  Height = 356
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Network properties'
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
    329)
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
    Top = 48
    Width = 56
    Height = 13
    Caption = '&Description:'
    FocusControl = aDescription
  end
  object Label3: TLabel
    Left = 8
    Top = 136
    Width = 95
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '&Preferred nickname:'
    FocusControl = aNick
  end
  object Label4: TLabel
    Left = 8
    Top = 176
    Width = 213
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '&Alternate nicknames: (seperate with space '#39' '#39')'
    FocusControl = aAltNick
  end
  object Label5: TLabel
    Left = 8
    Top = 216
    Width = 91
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '&Full name (or URL):'
    FocusControl = aFullName
  end
  object Label6: TLabel
    Left = 8
    Top = 256
    Width = 133
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'E-mail address (login@host):'
    FocusControl = aEmail
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
  object aDescription: TMemo
    Left = 8
    Top = 64
    Width = 281
    Height = 65
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'aDescription')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object aNick: TEdit
    Left = 8
    Top = 152
    Width = 281
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    Text = 'aNick'
  end
  object aAltNick: TEdit
    Left = 8
    Top = 192
    Width = 281
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
    Text = 'aAltNick'
  end
  object aFullName: TEdit
    Left = 8
    Top = 232
    Width = 281
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
    Text = 'aFullName'
  end
  object aEmail: TEdit
    Left = 8
    Top = 272
    Width = 281
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 5
    Text = 'aEmail'
  end
  object Button1: TButton
    Left = 152
    Top = 296
    Width = 65
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
  object Button2: TButton
    Left = 224
    Top = 296
    Width = 65
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object Button3: TButton
    Left = 8
    Top = 296
    Width = 81
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Connect'
    TabOrder = 6
    OnClick = Button3Click
  end
end
