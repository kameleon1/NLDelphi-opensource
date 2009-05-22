object GetValWin: TGetValWin
  Left = 269
  Top = 166
  Width = 297
  Height = 92
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'GetValWin'
  Color = clBtnFace
  Constraints.MaxHeight = 92
  Constraints.MinHeight = 92
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    289
    65)
  PixelsPerInch = 96
  TextHeight = 13
  object Val: TEdit
    Left = 8
    Top = 8
    Width = 273
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'Val'
  end
  object Button1: TButton
    Left = 144
    Top = 32
    Width = 65
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 216
    Top = 32
    Width = 65
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
