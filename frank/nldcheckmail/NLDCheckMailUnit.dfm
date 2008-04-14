object Form1: TForm1
  Left = 261
  Top = 103
  Width = 696
  Height = 480
  Caption = 'CheckMail'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object IdPOP31: TIdPOP3
    MaxLineAction = maException
    Left = 8
    Top = 8
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 40
    Top = 8
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer2Timer
    Left = 72
    Top = 8
  end
end
