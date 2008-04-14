object FrmBaseForm: TFrmBaseForm
  Left = 564
  Top = 286
  Width = 232
  Height = 203
  Caption = 'FrmBaseForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = TntFormLXActivate
  OnClose = TntFormLXClose
  OnPaint = TntFormLXPaint
  TaskBarButton = True
  PixelsPerInch = 96
  TextHeight = 13
  object TmrFlash: TTimer
    Interval = 500
    OnTimer = TmrFlashTimer
    Left = 32
    Top = 56
  end
end
