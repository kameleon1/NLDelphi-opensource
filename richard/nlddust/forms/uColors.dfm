object frmColors: TfrmColors
  Left = 414
  Top = 277
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmColors'
  ClientHeight = 365
  ClientWidth = 392
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
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 2
    Top = 2
    Width = 388
    Height = 327
    TabOrder = 0
    object GbColorSent: TGroupBox
      Left = 200
      Top = 8
      Width = 178
      Height = 305
      Caption = '  Sent  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object GbColorSessionCurrentSent: TGroupBox
        Left = 8
        Top = 20
        Width = 161
        Height = 49
        Caption = 'Session Current '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object ClrbColorSessionCurrentSent: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorSessionCurrentSent: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
      object GbColorSessionAverageSent: TGroupBox
        Left = 8
        Top = 76
        Width = 161
        Height = 49
        Caption = 'Session Average '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object ClrbColorSessionAverageSent: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorSessionAverageSent: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
      object GbColorSessionMaxSent: TGroupBox
        Left = 8
        Top = 132
        Width = 161
        Height = 49
        Caption = 'Session Max '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object ClrbColorSessionMaxSent: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorSessionMaxSent: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
      object GbColorSessionTotalSent: TGroupBox
        Left = 8
        Top = 188
        Width = 161
        Height = 49
        Caption = 'Session Total '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object ClrbColorSessionTotalSent: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorSessionTotalSent: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
      object GbColorWindowsTotalSent: TGroupBox
        Left = 8
        Top = 244
        Width = 161
        Height = 49
        Caption = 'Windows Total '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object ClrbColorWindowsTotalSent: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorWindowsTotalSent: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
    end
    object GbColorReceived: TGroupBox
      Left = 10
      Top = 8
      Width = 178
      Height = 305
      Caption = '  Received  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object GbColorSessionCurrentReceived: TGroupBox
        Left = 8
        Top = 20
        Width = 161
        Height = 49
        Caption = 'Session Current '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object ClrbColorSessionCurrentReceived: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorSessionCurrentReceived: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
      object GbColorSessionAverageReceived: TGroupBox
        Left = 8
        Top = 76
        Width = 161
        Height = 49
        Caption = 'Session Average '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object ClrbColorSessionAverageReceived: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorSessionAverageReceived: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
      object GbColorSessionMaxReceived: TGroupBox
        Left = 8
        Top = 132
        Width = 161
        Height = 49
        Caption = 'Session Max '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object ClrbColorSessionMaxReceived: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorSessionMaxReceived: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
      object GbColorSessionTotalReceived: TGroupBox
        Left = 8
        Top = 188
        Width = 161
        Height = 49
        Caption = 'Session Total '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object ClrbColorSessionTotalReceived: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorSessionTotalReceived: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
      object GbColorWindowsTotalReceived: TGroupBox
        Left = 8
        Top = 244
        Width = 161
        Height = 49
        Caption = 'Windows Total '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object ClrbColorWindowsTotalReceived: TColorBox
          Left = 8
          Top = 17
          Width = 89
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          OnClick = ObjectClick
        end
        object CbColorWindowsTotalReceived: TCheckBox
          Left = 104
          Top = 19
          Width = 50
          Height = 17
          Caption = 'Bold.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ObjectClick
        end
      end
    end
  end
  object BtCancel: TBitBtn
    Left = 310
    Top = 336
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
    Left = 220
    Top = 336
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
    Top = 336
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
