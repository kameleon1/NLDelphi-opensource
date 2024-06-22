object EditFileForm: TEditFileForm
  Left = 427
  Top = 128
  BorderIcons = [biSystemMenu, biMaximize]
  ClientHeight = 410
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Memo1: TMemo
    Left = 0
    Top = 17
    Width = 603
    Height = 352
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WantTabs = True
    WordWrap = False
    OnChange = Memo1Change
    OnKeyPress = Memo1KeyPress
  end
  object Panel1: TPanel
    Left = 0
    Top = 369
    Width = 603
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      603
      41)
    object SluitenButton: TButton
      Left = 488
      Top = 8
      Width = 89
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Sluiten'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = SluitenButtonClick
    end
    object BewaarButton: TButton
      Left = 376
      Top = 8
      Width = 89
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Bewaar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = BewaarButtonClick
    end
    object PrintButton: TButton
      Left = 16
      Top = 8
      Width = 89
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Print'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = PrintButtonClick
    end
    object ZoekButton: TButton
      Left = 272
      Top = 8
      Width = 91
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Zoek'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ZoekButtonClick
    end
  end
  object Title: TPanel
    Left = 0
    Top = 0
    Width = 603
    Height = 17
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
