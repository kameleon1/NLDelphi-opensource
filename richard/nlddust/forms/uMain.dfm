object frmMain: TfrmMain
  Left = 506
  Top = 121
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Down & Up Stream Traffic'
  ClientHeight = 515
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000077777777770000007F8888778700000007000000000000000788
    888880777770070777778087787007999999800000000799999980888800079F
    999980777800079F9999800008000799999980000800007777777F0008000000
    00700F000800000000700000080000000007777777000000000000000000803F
    0000001F0000001F000080010000800000008000000080010000800100008001
    00008001000080010000C0010000FC010000FC010000FE030000FFFF0000}
  Menu = MnufrmMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BvMainMenu: TBevel
    Left = 0
    Top = 0
    Width = 313
    Height = 9
    Align = alTop
    Shape = bsTopLine
  end
  object BvDevider: TBevel
    Left = 0
    Top = 209
    Width = 313
    Height = 2
    Shape = bsTopLine
  end
  object LblDummy: TLabel
    Left = 24
    Top = 450
    Width = 281
    Height = 26
    Caption = 
      '<--CbDummy, dummy checkbox om de focus over te nemen'#13#10'    size =' +
      ' 0,0 dus niet zichtbaar. !!!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object GbReceived: TGroupBox
    Left = 8
    Top = 216
    Width = 145
    Height = 233
    Caption = 'Received '
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object LblSessionCurrentReceived: TLabel
      Left = 8
      Top = 24
      Width = 80
      Height = 13
      Caption = 'Session Current :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblSessionAverageReceived: TLabel
      Left = 8
      Top = 64
      Width = 86
      Height = 13
      Caption = 'Session Average :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblSessionMaxReceived: TLabel
      Left = 8
      Top = 104
      Width = 66
      Height = 13
      Caption = 'Session Max :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblSessionTotalReceived: TLabel
      Left = 8
      Top = 144
      Width = 70
      Height = 13
      Caption = 'Session Total :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblWindowsTotalReceived: TLabel
      Left = 8
      Top = 184
      Width = 77
      Height = 13
      Caption = 'Windows Total :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EdtSessionCurrentReceived: TJvEdit
      Left = 8
      Top = 40
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 0
    end
    object EdtSessionAverageReceived: TJvEdit
      Left = 8
      Top = 80
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 1
    end
    object EdtSessionMaxReceived: TJvEdit
      Left = 8
      Top = 120
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 2
    end
    object EdtSessionTotalReceived: TJvEdit
      Left = 8
      Top = 160
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 3
    end
    object EdtWindowsTotalReceived: TJvEdit
      Left = 8
      Top = 200
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 4
    end
  end
  object GbSent: TGroupBox
    Left = 160
    Top = 216
    Width = 145
    Height = 233
    Caption = 'Sent '
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object LblWindowsTotalSent: TLabel
      Left = 8
      Top = 184
      Width = 77
      Height = 13
      Caption = 'Windows Total :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblSessionTotalSent: TLabel
      Left = 8
      Top = 144
      Width = 70
      Height = 13
      Caption = 'Session Total :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblSessionMaxSent: TLabel
      Left = 8
      Top = 104
      Width = 66
      Height = 13
      Caption = 'Session Max :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblSessionAverageSent: TLabel
      Left = 8
      Top = 64
      Width = 86
      Height = 13
      Caption = 'Session Average :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblSessionCurrentSent: TLabel
      Left = 8
      Top = 24
      Width = 80
      Height = 13
      Caption = 'Session Current :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EdtSessionCurrentSent: TJvEdit
      Left = 8
      Top = 40
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 0
    end
    object EdtSessionAverageSent: TJvEdit
      Left = 8
      Top = 80
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 1
    end
    object EdtSessionMaxSent: TJvEdit
      Left = 8
      Top = 120
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 2
    end
    object EdtSessionTotalSent: TJvEdit
      Left = 8
      Top = 160
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 3
    end
    object EdtWindowsTotalSent: TJvEdit
      Left = 8
      Top = 200
      Width = 129
      Height = 21
      Alignment = taRightJustify
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = False
      TabOrder = 4
    end
  end
  object GbAdapter: TGroupBox
    Left = 8
    Top = 8
    Width = 297
    Height = 49
    Caption = 'Adapter '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object CmbAdapterLijst: TComboBox
      Left = 8
      Top = 16
      Width = 281
      Height = 21
      Hint = 'Select the adapter to be monitored.'
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
  end
  object GbDecimal: TGroupBox
    Left = 8
    Top = 160
    Width = 297
    Height = 41
    Caption = 'Decimals '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Rb1Decimaal: TRadioButton
      Left = 16
      Top = 16
      Width = 55
      Height = 17
      Hint = 'Show the rates with one decimal.'
      Caption = '1 Dec.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object Rb2Decimaal: TRadioButton
      Left = 88
      Top = 16
      Width = 55
      Height = 17
      Hint = 'Show the rates with two decimals.'
      Caption = '2 Dec.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object Rb3Decimaal: TRadioButton
      Left = 160
      Top = 16
      Width = 55
      Height = 17
      Hint = 'Show the rates with three decimals.'
      Caption = '3 Dec.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object Rb4Decimaal: TRadioButton
      Left = 232
      Top = 16
      Width = 55
      Height = 17
      Hint = 'Show the rates with four decimals.'
      Caption = '4 Dec.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
  end
  object GbUnits: TGroupBox
    Left = 8
    Top = 64
    Width = 297
    Height = 41
    Caption = 'Units '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object RbBits: TRadioButton
      Left = 16
      Top = 16
      Width = 105
      Height = 17
      Hint = 
        'Show all rates in bits instead of bytes.'#13#10'Eight bits equal one b' +
        'yte,'#13#10'LAN speed is usually shown in bits.'
      Caption = 'bits per second.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object RbBytes: TRadioButton
      Left = 160
      Top = 16
      Width = 113
      Height = 17
      Hint = 
        'Show all rates in bytes instead of bits.'#13#10'One byte equals eight ' +
        'bits,'#13#10'LAN speed is usually shown in bits.'
      Caption = 'Bytes per second.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object GbStandard: TGroupBox
    Left = 8
    Top = 112
    Width = 297
    Height = 41
    Caption = 'Standard '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object RbStandardBinary: TRadioButton
      Left = 16
      Top = 16
      Width = 113
      Height = 17
      Hint = 
        'Binary mode. '#13#10'This makes 1 Kilobyte equal to 1024 bytes, '#13#10'1 Me' +
        'gabyte equal to 1024 Kilobytes, etc.'
      Caption = 'Binary mode.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object RbStandartDecimal: TRadioButton
      Left = 160
      Top = 16
      Width = 113
      Height = 17
      Hint = 
        'Decimal mode. '#13#10'This makes 1 Kilobyte equal to 1000 bytes, '#13#10'1 M' +
        'egabyte to 1000 Kilobytes, etc.'
      Caption = 'Decimal mode.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object StatusbarMain: TStatusBar
    Left = 0
    Top = 496
    Width = 313
    Height = 19
    Panels = <
      item
        Text = 'Current uptime :'
        Width = 140
      end
      item
        Alignment = taRightJustify
        Width = 50
      end>
    SimplePanel = False
  end
  object CbDummy: TCheckBox
    Left = 8
    Top = 456
    Width = 0
    Height = 0
    TabOrder = 4
  end
  object TmrSequence: TTimer
    Enabled = False
    OnTimer = TmrSequenceTimer
    Left = 216
    Top = 464
  end
  object JvTray: TJvTrayIcon
    Icon.Data = {
      0000010001001010100000000000280100001600000028000000100000002000
      00000100040000000000C0000000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      00000000000077777777770000007F8888778700000007000000000000000788
      888880777770070777778087787007000000800000000700000080888800070F
      000080777800070F0000800008000700000080000800007777777F0008000000
      00700F000800000000700000080000000007777777000000000000000000803F
      0000001F0000001F000080010000800000008000000080010000800100008001
      00008001000080010000C0010000FC010000FC010000FE030000FFFF0000}
    IconIndex = -1
    Hint = 'test'
    OnClick = JvTrayClick
    Left = 280
    Top = 464
  end
  object MnufrmMain: TMainMenu
    Left = 248
    Top = 464
    object FFile1: TMenuItem
      Caption = '&File'
      object Minimize1: TMenuItem
        Caption = '&Minimize'
        OnClick = Minimize1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object Settings1: TMenuItem
      Caption = '&Settings'
      object Layout1: TMenuItem
        Caption = '&Layout'
        OnClick = Layout1Click
      end
      object Colors1: TMenuItem
        Caption = '&Colors'
        OnClick = Colors1Click
      end
      object Program1: TMenuItem
        Caption = '&Program'
        OnClick = Program1Click
      end
      object Alarms1: TMenuItem
        Caption = '&Alarms'
        OnClick = Alarms1Click
      end
    end
    object Runtime1: TMenuItem
      Caption = '&Runtime'
      object ResetCounters1: TMenuItem
        Caption = '&Reset Counters'
        OnClick = ResetCounters1Click
      end
      object StopDust1: TMenuItem
        Caption = 'St&op Dust'
        OnClick = StopDust1Click
      end
      object StartTimer1: TMenuItem
        Caption = 'St&art Dust'
        Enabled = False
        OnClick = StartTimer1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ShowAlarm11: TMenuItem
        Caption = 'Show Alarm &1'
        Enabled = False
        OnClick = ShowAlarm11Click
      end
      object ShowAlarm21: TMenuItem
        Caption = 'Show Alarm &2'
        Enabled = False
        OnClick = ShowAlarm21Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object History1: TMenuItem
        Caption = '&History'
        OnClick = History1Click
      end
      object About1: TMenuItem
        Caption = '&About'
        OnClick = About1Click
      end
    end
  end
  object TmrAlarm1: TTimer
    Enabled = False
    OnTimer = TmrAlarm1Timer
    Left = 152
    Top = 464
  end
  object TmrAlarm2: TTimer
    Enabled = False
    OnTimer = TmrAlarm2Timer
    Left = 184
    Top = 464
  end
end
