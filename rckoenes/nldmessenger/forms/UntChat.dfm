inherited FrmChat: TFrmChat
  Left = 405
  Top = 242
  Width = 410
  Height = 317
  Caption = 'FrmChat'
  Constraints.MinHeight = 280
  Constraints.MinWidth = 366
  Menu = TntMainMenu
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TTntSplitter [0]
    Left = 0
    Top = 164
    Width = 402
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    ResizeStyle = rsLine
  end
  object PnlBottum: TTntPanel [1]
    Left = 0
    Top = 168
    Width = 402
    Height = 100
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MinHeight = 100
    ParentBackground = True
    ParentColor = True
    TabOrder = 0
    object StatusBar: TTntStatusBar
      Left = 0
      Top = 81
      Width = 402
      Height = 19
      Panels = <
        item
          Alignment = taCenter
          Width = 200
        end
        item
          Alignment = taCenter
          Text = 'foo@bar.com'
          Width = 50
        end>
    end
    object PnlButtons: TTntPanel
      Left = 0
      Top = 0
      Width = 402
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        402
        30)
      object BtnSend: TTntSpeedButton
        Left = 343
        Top = 4
        Width = 55
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '&Send'
        Flat = True
        OnClick = BtnSendClick
      end
      object BtnBold: TTntSpeedButton
        Left = 270
        Top = 3
        Width = 22
        Height = 22
        AllowAllUp = True
        GroupIndex = 3
        Caption = 'B'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object BtnUnderLine: TTntSpeedButton
        Left = 246
        Top = 3
        Width = 22
        Height = 22
        AllowAllUp = True
        GroupIndex = 2
        Caption = 'U'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsUnderline]
        ParentFont = False
        Visible = False
      end
      object BtnItalic: TTntSpeedButton
        Left = 222
        Top = 3
        Width = 21
        Height = 22
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'I'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsItalic]
        ParentFont = False
        Visible = False
      end
      object CbxFont: TTSFontBox
        Left = 7
        Top = 4
        Width = 154
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Visible = False
      end
      object CbxFonstSize: TTntComboBox
        Left = 163
        Top = 4
        Width = 57
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        Visible = False
        Items.WideStrings = (
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          '11'
          '12'
          '14'
          '16'
          '18'
          '24'
          '36'
          '72')
      end
    end
    object EdtSend: TTntRichEditLX
      Left = 0
      Top = 30
      Width = 402
      Height = 51
      AutoUrlDetect = False
      Align = alClient
      PopupMenu = FrmMain.EdtPopup
      ScrollBars = ssVertical
      TabOrder = 0
      OnKeyDown = EdtSendKeyDown
    end
  end
  object EdtRecive: TTntRichEditLX [2]
    Left = 0
    Top = 0
    Width = 402
    Height = 164
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = '@Arial Unicode MS'
    Font.Style = []
    HideSelection = False
    ParentFont = False
    PopupMenu = FrmMain.EdtPopup
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  inherited TmrFlash: TTimer
    Left = 8
    Top = 8
  end
  object TntMainMenu: TTntMainMenu
    Left = 8
    Top = 40
    object Contact1: TTntMenuItem
      Caption = 'Contact'
      object Rename1: TTntMenuItem
        Caption = 'Rename'
        OnClick = Rename1Click
      end
      object Addtoroster1: TTntMenuItem
        Caption = 'Add to roster'
        Visible = False
        OnClick = Addtoroster1Click
      end
      object N3: TTntMenuItem
        Caption = '-'
      end
      object Clientversion1: TTntMenuItem
        Caption = 'Client version'
        OnClick = Clientversion1Click
      end
      object Clienttime1: TTntMenuItem
        Caption = 'Client time'
        OnClick = Clienttime1Click
      end
      object Lastseen1: TTntMenuItem
        Caption = 'Last seen'
        Visible = False
        OnClick = Lastseen1Click
      end
      object N2: TTntMenuItem
        Caption = '-'
      end
      object Closeconversation1: TTntMenuItem
        Caption = 'Close conversation'
        OnClick = Closeconversation1Click
      end
    end
    object Edit1: TTntMenuItem
      Caption = 'Edit'
      object Cut2: TTntMenuItem
        Action = FrmMain.EditCut
      end
      object Copy2: TTntMenuItem
        Action = FrmMain.EditCopy
      end
      object Paste2: TTntMenuItem
        Action = FrmMain.EditPaste
      end
      object Delete2: TTntMenuItem
        Action = FrmMain.EditDelete
      end
      object SelectAll1: TTntMenuItem
        Action = FrmMain.EditSelectAll
      end
    end
    object View1: TTntMenuItem
      Caption = 'View'
      OnClick = View1Click
      object MMClearChat: TTntMenuItem
        Caption = 'Clear chat window'
        OnClick = MMClearChatClick
      end
      object N1: TTntMenuItem
        Caption = '-'
      end
      object MMStayonTop: TTntMenuItem
        Caption = 'Stay on &Top'
        OnClick = MMStayonTopClick
      end
    end
  end
  object RecivePopUp: TTntPopupMenu
    Left = 8
    Top = 72
    object Copy1: TTntMenuItem
      Action = FrmMain.EditCopy
    end
    object SelectAll2: TTntMenuItem
      Action = FrmMain.EditSelectAll
    end
  end
end
