object EditFileForm: TEditFileForm
  Left = 314
  Top = 205
  AutoScroll = False
  BorderIcons = [biSystemMenu, biMaximize]
  ClientHeight = 415
  ClientWidth = 611
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
    Width = 611
    Height = 357
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WantTabs = True
    OnChange = Memo1Change
    OnKeyPress = Memo1KeyPress
  end
  object Panel1: TPanel
    Left = 0
    Top = 374
    Width = 611
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      611
      41)
    object SluitenButton: TButton
      Left = 512
      Top = 8
      Width = 89
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
      OnClick = SluitenButtonClick
    end
    object BewaarButton: TButton
      Left = 408
      Top = 8
      Width = 89
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Save'
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
      Left = 272
      Top = 8
      Width = 89
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Print'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = PrintButtonClick
    end
    object FindButton: TButton
      Left = 24
      Top = 8
      Width = 81
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Find'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = FindButtonClick
    end
    object FindNextButton: TButton
      Left = 112
      Top = 8
      Width = 81
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Find &Next'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = FindNextButtonClick
    end
  end
  object Title: TPanel
    Left = 0
    Top = 0
    Width = 611
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