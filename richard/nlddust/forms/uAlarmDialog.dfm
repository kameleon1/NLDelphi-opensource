object frmAlarmDialog: TfrmAlarmDialog
  Left = 288
  Top = 129
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'frmAlarmDialog'
  ClientHeight = 156
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblAttachedTo: TLabel
    Left = 8
    Top = 56
    Width = 230
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Session Average - Received .'
  end
  object LblAlarmId: TLabel
    Left = 8
    Top = 72
    Width = 230
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Alarm1 limit.'
  end
  object Bevel1: TBevel
    Left = 3
    Top = 130
    Width = 246
    Height = 9
    Shape = bsTopLine
  end
  object JvBlAlarm: TJvBlinkingLabel
    Left = 56
    Top = 8
    Width = 146
    Height = 44
    Caption = 'Alarm 1.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -37
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clHotLight
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    BlinkingDelay = 800
    BlinkingTime = 1200
  end
  object BtAlarmReset: TBitBtn
    Left = 70
    Top = 98
    Width = 107
    Height = 25
    Caption = '&Reset Alarm.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BtAlarmResetClick
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
  object CbDontShowAgain: TCheckBox
    Left = 8
    Top = 138
    Width = 201
    Height = 17
    Caption = 'Don'#39't show again during this session.'
    TabOrder = 1
    OnClick = CbDontShowAgainClick
  end
end
