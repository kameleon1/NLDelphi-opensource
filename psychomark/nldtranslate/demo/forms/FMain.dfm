object frmMain: TfrmMain
  Left = 200
  Top = 136
  Width = 399
  Height = 299
  Caption = 'NLDTranslate Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    391
    272)
  PixelsPerInch = 96
  TextHeight = 13
  object sbStatus: TStatusBar
    Left = 0
    Top = 253
    Width = 391
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 30
      end
      item
        Width = 65
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object lstLanguages: TListBox
    Left = 4
    Top = 4
    Width = 381
    Height = 197
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
    OnClick = lstLanguagesClick
  end
  object pnlEnum: TPanel
    Left = 4
    Top = 208
    Width = 381
    Height = 41
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Enumeration property test...'
    TabOrder = 1
  end
  object nldTranslate: TNLDTranslate
    Manager = dmLanguage.nldtManager
    Section = 'frmMain'
    Left = 12
    Top = 12
  end
end
