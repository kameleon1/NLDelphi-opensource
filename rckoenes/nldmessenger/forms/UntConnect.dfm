object FrmConnect: TFrmConnect
  Left = 437
  Top = 296
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsNone
  ClientHeight = 312
  ClientWidth = 179
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = TntFormCreate
  OnResize = TntFormResize
  DesignSize = (
    179
    312)
  PixelsPerInch = 96
  TextHeight = 13
  object LblConnect: TTntLabel
    Left = 0
    Top = 80
    Width = 150
    Height = 20
    Alignment = taCenter
    Caption = 'Click here to logon'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = LblConnectClick
    OnMouseEnter = LblConnectMouseEnter
    OnMouseLeave = LblConnectMouseLeave
  end
  object ImgConnect: TImage
    Left = 34
    Top = 16
    Width = 55
    Height = 55
    Anchors = [akTop]
  end
  object TmrAnimate: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TmrAnimateTimer
    Left = 32
    Top = 216
  end
end
