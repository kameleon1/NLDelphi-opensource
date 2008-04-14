object frmProgram: TfrmProgram
  Left = 418
  Top = 314
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmProgram'
  ClientHeight = 334
  ClientWidth = 320
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
  object Panel1: TPanel
    Left = 2
    Top = 2
    Width = 317
    Height = 298
    TabOrder = 0
    object Bevel1: TBevel
      Left = 4
      Top = 212
      Width = 308
      Height = 3
      Shape = bsTopLine
    end
    object GbAdapter: TGroupBox
      Left = 10
      Top = 8
      Width = 297
      Height = 49
      Caption = 'Adapter '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
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
        OnClick = ObjectClick
      end
    end
    object GbUnits: TGroupBox
      Left = 10
      Top = 64
      Width = 297
      Height = 41
      Caption = 'Units '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
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
        OnClick = ObjectClick
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
        OnClick = ObjectClick
      end
    end
    object GbStandard: TGroupBox
      Left = 10
      Top = 112
      Width = 297
      Height = 41
      Caption = 'Standard '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
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
        OnClick = ObjectClick
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
        OnClick = ObjectClick
      end
    end
    object GbDecimal: TGroupBox
      Left = 10
      Top = 160
      Width = 297
      Height = 41
      Caption = 'Decimals '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
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
        OnClick = ObjectClick
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
        OnClick = ObjectClick
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
        OnClick = ObjectClick
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
        OnClick = ObjectClick
      end
    end
    object GbCommon: TGroupBox
      Left = 8
      Top = 220
      Width = 297
      Height = 66
      Caption = 'Common '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object CbShowhints: TCheckBox
        Left = 8
        Top = 16
        Width = 81
        Height = 17
        Hint = 'Enable hints.'
        Caption = 'Show hints.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = ObjectClick
      end
      object CbSaveonexit: TCheckBox
        Left = 200
        Top = 16
        Width = 89
        Height = 17
        Hint = 'Saves changes when you exit the program'
        Caption = 'Save on Exit.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = ObjectClick
      end
      object CbMinimizeonrun: TCheckBox
        Left = 96
        Top = 16
        Width = 97
        Height = 17
        Hint = 'Start application in system tray.'
        Caption = 'Minimize on run.'
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
      object CbConfirmExit: TCheckBox
        Left = 8
        Top = 40
        Width = 81
        Height = 17
        Hint = 'If Checked, the program will ask a confirmation before closing.'
        Caption = 'Confirm Exit.'
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
      object CbStayOnTop: TCheckBox
        Left = 96
        Top = 40
        Width = 97
        Height = 17
        Hint = 'Keep main screen always on top.'
        Caption = 'Stay on top.'
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
    end
  end
  object BtCancel: TBitBtn
    Left = 238
    Top = 306
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
    TabOrder = 1
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
    Left = 142
    Top = 306
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
    TabOrder = 2
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
    Top = 306
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
    TabOrder = 3
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
end
