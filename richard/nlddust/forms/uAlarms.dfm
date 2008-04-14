object frmAlarms: TfrmAlarms
  Left = 359
  Top = 131
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmAlarms'
  ClientHeight = 260
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtCancel: TBitBtn
    Left = 350
    Top = 230
    Width = 81
    Height = 25
    Hint = 'Cancel changes.'
    Cancel = True
    Caption = 'C&ancel.'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = BtCancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BtOk: TBitBtn
    Left = 254
    Top = 230
    Width = 81
    Height = 25
    Hint = 'Apply changes.'
    Caption = '&Ok'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtOkClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BtDefault: TBitBtn
    Left = 2
    Top = 230
    Width = 81
    Height = 25
    Hint = 'Restore default settings.'
    Caption = '&Default'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtDefaultClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
      33333333333F8888883F33330000324334222222443333388F3833333388F333
      000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
      F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
      223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
      3338888300003AAAAAAA33333333333888888833333333330000333333333333
      333333333333333333FFFFFF000033333333333344444433FFFF333333888888
      00003A444333333A22222438888F333338F3333800003A2243333333A2222438
      F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
      22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
      33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
      3333333333338888883333330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object Panel1: TPanel
    Left = 2
    Top = 2
    Width = 431
    Height = 223
    TabOrder = 3
    object GbAlarmSettings1: TGroupBox
      Left = 8
      Top = 8
      Width = 417
      Height = 97
      Caption = 'Alarm 1 Settings '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 24
        Height = 13
        Caption = 'Limit.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 80
        Top = 16
        Width = 27
        Height = 13
        Caption = 'Units.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 168
        Top = 16
        Width = 59
        Height = 13
        Caption = 'Referenced.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 340
        Top = 16
        Width = 57
        Height = 13
        Caption = 'Timer delay.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 8
        Top = 60
        Width = 397
        Height = 4
        Shape = bsTopLine
      end
      object CmbAlarmUnits1: TComboBox
        Left = 80
        Top = 32
        Width = 81
        Height = 21
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
        OnChange = ObjectClick
        Items.Strings = (
          'Bits.'
          'Kilobits.'
          'Megabits.'
          'Gigabits.'
          'Bytes.'
          'Kilobytes.'
          'Megabytes.'
          'Gigabytes.')
      end
      object CmbAlarmAttachedTo1: TComboBox
        Left = 168
        Top = 32
        Width = 164
        Height = 21
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
        TabOrder = 1
        OnChange = ObjectClick
        Items.Strings = (
          'Session Current - Received.'
          'Session Average - Received.'
          'Session Total - Received.'
          'Windows Total - Received.'
          'Session Current - Sent.'
          'Session Average - Sent.'
          'Session Total - Sent.'
          'Windows Total - Sent.')
      end
      object CbAlarmTimerActive1: TCheckBox
        Left = 106
        Top = 68
        Width = 87
        Height = 17
        Hint = 'Activates Alarm delay timer after an alarm.'
        Caption = 'Timer Active.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = ObjectClick
      end
      object CbAlarmOnTop1: TCheckBox
        Left = 210
        Top = 68
        Width = 87
        Height = 17
        Hint = 'Show Alarm 1 always on top.'
        Caption = 'Show on Top.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = ObjectClick
      end
      object CbAlarmActive1: TCheckBox
        Left = 10
        Top = 68
        Width = 87
        Height = 17
        Hint = 'Activates Alarm 1.'
        Caption = 'Alarm Active.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = ObjectClick
      end
      object CbAlarmSound1: TCheckBox
        Left = 314
        Top = 68
        Width = 87
        Height = 17
        Hint = 'Enable sound.'
        Caption = 'Sound on/off.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = ObjectClick
      end
      object SpeAlarmLimit1: TRxSpinEdit
        Left = 8
        Top = 32
        Width = 65
        Height = 21
        Alignment = taRightJustify
        ButtonKind = bkStandard
        Increment = 0.1
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 1023
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnChange = ObjectClick
      end
      object SpeAlarmTimer1: TRxSpinEdit
        Left = 340
        Top = 32
        Width = 65
        Height = 21
        Alignment = taRightJustify
        ButtonKind = bkStandard
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 1800
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnChange = ObjectClick
      end
    end
    object GbAlarmSettings2: TGroupBox
      Left = 6
      Top = 112
      Width = 417
      Height = 97
      Caption = 'Alarm 2 Settings '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label5: TLabel
        Left = 8
        Top = 16
        Width = 24
        Height = 13
        Caption = 'Limit.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 80
        Top = 16
        Width = 27
        Height = 13
        Caption = 'Units.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 168
        Top = 16
        Width = 59
        Height = 13
        Caption = 'Referenced.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 340
        Top = 16
        Width = 57
        Height = 13
        Caption = 'Timer delay.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 8
        Top = 60
        Width = 397
        Height = 4
        Shape = bsTopLine
      end
      object CmbAlarmUnits2: TComboBox
        Left = 80
        Top = 32
        Width = 81
        Height = 21
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
        OnChange = ObjectClick
        Items.Strings = (
          'Bits.'
          'Kilobits.'
          'Megabits.'
          'Gigabits.'
          'Bytes.'
          'Kilobytes.'
          'Megabytes.'
          'Gigabytes.')
      end
      object CmbAlarmAttachedTo2: TComboBox
        Left = 168
        Top = 32
        Width = 164
        Height = 21
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
        TabOrder = 1
        OnChange = ObjectClick
        Items.Strings = (
          'Session Current - Received.'
          'Session Average - Received.'
          'Session Total - Received.'
          'Windows Total - Received.'
          'Session Current - Sent.'
          'Session Average - Sent.'
          'Session Total - Sent.'
          'Windows Total - Sent.')
      end
      object CbAlarmTimerActive2: TCheckBox
        Left = 106
        Top = 68
        Width = 87
        Height = 17
        Hint = 'Activates Alarm delay timer after an alarm.'
        Caption = 'Timer Active.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = ObjectClick
      end
      object CbAlarmOnTop2: TCheckBox
        Left = 210
        Top = 68
        Width = 87
        Height = 17
        Hint = 'Show Alarm 2 always on top.'
        Caption = 'Show on Top.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = ObjectClick
      end
      object CbAlarmActive2: TCheckBox
        Left = 10
        Top = 68
        Width = 87
        Height = 17
        Hint = 'Activates Alarm 2.'
        Caption = 'Alarm Active.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = ObjectClick
      end
      object CbAlarmSound2: TCheckBox
        Left = 314
        Top = 68
        Width = 87
        Height = 17
        Hint = 'Enable sound.'
        Caption = 'Sound on/off.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = ObjectClick
      end
      object SpeAlarmLimit2: TRxSpinEdit
        Left = 8
        Top = 32
        Width = 65
        Height = 21
        Alignment = taRightJustify
        ButtonKind = bkStandard
        Increment = 0.1
        MaxValue = 1023
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnChange = ObjectClick
      end
      object SpeAlarmTimer2: TRxSpinEdit
        Left = 340
        Top = 32
        Width = 65
        Height = 21
        Alignment = taRightJustify
        ButtonKind = bkStandard
        MaxValue = 1800
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnChange = ObjectClick
      end
    end
  end
end
