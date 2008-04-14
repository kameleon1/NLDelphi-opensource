object FrmAdd: TFrmAdd
  Left = 402
  Top = 304
  BorderStyle = bsDialog
  Caption = 'Add an User'
  ClientHeight = 226
  ClientWidth = 373
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = TntFormClose
  OnCreate = TntFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LblJID: TTntLabel
    Left = 8
    Top = 96
    Width = 39
    Height = 13
    Caption = '&User ID:'
    FocusControl = EdtJID
  end
  object LblGroup: TTntLabel
    Left = 8
    Top = 144
    Width = 66
    Height = 13
    Caption = 'Add to &Group:'
    FocusControl = CboGroup
  end
  object Bevel1: TTntBevel
    Left = -8
    Top = 192
    Width = 385
    Height = 2
  end
  object LblSupAsk: TTntLabel
    Left = 8
    Top = 168
    Width = 43
    Height = 13
    Caption = '&Request:'
    FocusControl = EdtSupAsk
  end
  object LblNick: TTntLabel
    Left = 8
    Top = 120
    Width = 81
    Height = 13
    Caption = 'User &Nick Name:'
    FocusControl = EdtNick
  end
  object LblAgent: TTntLabel
    Left = 8
    Top = 72
    Width = 45
    Height = 13
    Caption = '&Transport'
    FocusControl = CboAgent
    Transparent = False
  end
  object EdtSupAsk: TTntEdit
    Left = 100
    Top = 160
    Width = 265
    Height = 21
    TabOrder = 4
    Text = 'Standard subscription request'
    OnChange = ChangeBTN
  end
  object EdtNick: TTntEdit
    Left = 100
    Top = 112
    Width = 265
    Height = 21
    TabOrder = 2
    OnChange = ChangeBTN
  end
  object CboAgent: TTntComboBox
    Left = 100
    Top = 64
    Width = 265
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = ChangeBTN
    Items.WideStrings = (
      'Jabber')
  end
  object CboGroup: TTntComboBox
    Left = 100
    Top = 136
    Width = 265
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 3
    OnChange = ChangeBTN
  end
  object BtnAdd: TTntButton
    Left = 217
    Top = 200
    Width = 75
    Height = 25
    Caption = '&Add User'
    Enabled = False
    TabOrder = 5
    OnClick = BtnAddClick
  end
  object BtnClose: TTntButton
    Left = 297
    Top = 200
    Width = 75
    Height = 25
    Caption = '&Close'
    TabOrder = 6
    OnClick = BtnCloseClick
    OnKeyDown = BtnCloseKeyDown
  end
  object EdtJID: TTntEdit
    Left = 100
    Top = 89
    Width = 265
    Height = 21
    TabOrder = 1
    OnChange = ChangeBTN
  end
  inline FrameTitle1: TFrameTitle
    Left = 0
    Top = 0
    Width = 373
    Height = 55
    Align = alTop
    TabOrder = 7
    inherited PnlTop: TTntPanel
      Width = 373
      Caption = 'Add a user '
      inherited ImgLogo: TImage
        Left = 320
      end
    end
  end
end
