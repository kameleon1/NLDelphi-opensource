inherited FrmGroupChat: TFrmGroupChat
  Left = 332
  Top = 264
  Width = 601
  Height = 544
  Caption = 'Groupchat (gourp@server)'
  Constraints.MinHeight = 360
  Constraints.MinWidth = 430
  Menu = TntMainMenu1
  OldCreateOrder = True
  OnCreate = TntFormLXCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterBottom: TTntSplitter [0]
    Left = 0
    Top = 379
    Width = 593
    Height = 6
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    ResizeStyle = rsLine
  end
  object TntSplitter1: TTntSplitter [1]
    Left = 461
    Top = 0
    Width = 6
    Height = 379
    Align = alRight
    Beveled = True
    ResizeStyle = rsLine
  end
  object PnlBottom: TTntPanel [2]
    Left = 0
    Top = 385
    Width = 593
    Height = 110
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MinHeight = 100
    TabOrder = 0
    object PnlButton: TTntPanel
      Left = 0
      Top = 0
      Width = 593
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        593
        30)
      object TntSpeedButton1: TTntSpeedButton
        Left = 544
        Top = 3
        Width = 45
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '&Send'
        Flat = True
      end
      object BtnItalic: TTntSpeedButton
        Left = 222
        Top = 3
        Width = 21
        Height = 22
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
      object BtnUnderLine: TTntSpeedButton
        Left = 246
        Top = 3
        Width = 22
        Height = 22
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
      object BtnBold: TTntSpeedButton
        Left = 270
        Top = 3
        Width = 22
        Height = 22
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
      object CbxFonstSize: TTntComboBox
        Left = 163
        Top = 4
        Width = 57
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
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
      object CbxFont: TTSFontBox
        Left = 7
        Top = 4
        Width = 154
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Visible = False
      end
    end
    object EdtSend: TTntRichEdit
      Left = 0
      Top = 30
      Width = 593
      Height = 80
      Align = alClient
      PopupMenu = FrmMain.EdtPopup
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object PnlRoster: TTntPanel [3]
    Left = 467
    Top = 0
    Width = 126
    Height = 379
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object PnlStatus: TTntPanel
      Left = 0
      Top = 0
      Width = 126
      Height = 27
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        126
        27)
      object CboxStatus: TTntComboBox
        Left = 1
        Top = 3
        Width = 126
        Height = 22
        Style = csOwnerDrawFixed
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 16
        TabOrder = 0
        OnDrawItem = CboxStatusDrawItem
        Items.WideStrings = (
          'Online'
          'Chat'
          'Away'
          'Extened Away'
          'Do Not Disturb')
      end
    end
    object TntTreeView1: TTntTreeView
      Left = 0
      Top = 45
      Width = 126
      Height = 334
      Align = alClient
      HotTrack = True
      Indent = 19
      MultiSelectStyle = []
      TabOrder = 1
    end
    object pnlUsers: TTntPanel
      Left = 0
      Top = 27
      Width = 126
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      Caption = '0 users'
      TabOrder = 2
    end
  end
  object PnlChat: TTntPanel [4]
    Left = 0
    Top = 0
    Width = 461
    Height = 379
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object PnlSubject: TTntPanel
      Left = 0
      Top = 0
      Width = 461
      Height = 25
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      BorderWidth = 4
      Caption = 'Some one has sete up us the bomb'
      TabOrder = 0
      DesignSize = (
        461
        25)
      object TntSpeedButton2: TTntSpeedButton
        Left = 433
        Top = 2
        Width = 25
        Height = 21
        Hint = 'Set new groupchat subject'
        Anchors = [akTop, akRight]
        Caption = '...'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = TntSpeedButton2Click
      end
    end
    object EdtRecive: TTntRichEditLX
      Left = 0
      Top = 25
      Width = 461
      Height = 354
      Align = alClient
      PopupMenu = FrmMain.EdtPopup
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  inherited TmrFlash: TTimer
    Left = 8
  end
  object TntMainMenu1: TTntMainMenu
    Left = 39
    Top = 56
    object Contact1: TTntMenuItem
      Caption = '&Chat'
      object Closeconversation1: TTntMenuItem
        Caption = '&Close conversation'
      end
    end
    object Edit: TTntMenuItem
      Caption = '&Edit'
      object Cut1: TTntMenuItem
        Action = FrmMain.EditCut
      end
      object Cut2: TTntMenuItem
        Action = FrmMain.EditCopy
      end
      object Paste1: TTntMenuItem
        Action = FrmMain.EditPaste
      end
      object Delete1: TTntMenuItem
        Action = FrmMain.EditDelete
      end
      object SelectAll1: TTntMenuItem
        Action = FrmMain.EditSelectAll
      end
    end
    object MMView: TTntMenuItem
      Caption = '&View'
      OnClick = MMViewClick
      object mmClear: TTntMenuItem
        Caption = 'Clear Chat window'
        OnClick = mmClearClick
      end
      object mmStayontop: TTntMenuItem
        Caption = 'Stay on top'
        OnClick = mmStayontopClick
      end
    end
  end
  object PupUser: TTntPopupMenu
    Left = 480
    Top = 336
    object Chat: TTntMenuItem
      Caption = 'Chat'
    end
    object Message: TTntMenuItem
      Caption = 'Message'
    end
    object N7: TTntMenuItem
      Caption = '-'
    end
    object ClientInfo: TTntMenuItem
      Caption = 'Client Info'
      object GetVersion: TTntMenuItem
        Caption = 'Get Version'
      end
      object GetTime: TTntMenuItem
        Caption = 'Get Time'
      end
      object LastSeen: TTntMenuItem
        Caption = 'Last seen'
      end
    end
    object GetVcard: TTntMenuItem
      Caption = 'Get Vcard'
      Enabled = False
    end
  end
end
