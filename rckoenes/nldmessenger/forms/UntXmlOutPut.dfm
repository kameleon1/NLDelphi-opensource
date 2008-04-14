object FrmXml: TFrmXml
  Left = 456
  Top = 258
  Width = 408
  Height = 520
  Caption = 'XML output'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object EdtOutput: TTntRichEdit
    Left = 0
    Top = 0
    Width = 400
    Height = 460
    Align = alClient
    PopupMenu = FrmMain.EdtPopup
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object PnlBottum: TTntPanel
    Left = 0
    Top = 460
    Width = 400
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      400
      31)
    object BtnClose: TTntButton
      Left = 322
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      BiDiMode = bdRightToLeft
      Caption = 'Close'
      ParentBiDiMode = False
      TabOrder = 0
      OnClick = BtnCloseClick
    end
  end
end
