object SettingsForm: TSettingsForm
  Left = 301
  Top = 180
  Width = 503
  Height = 342
  BorderIcons = [biSystemMenu]
  Caption = 'DeX instellingen'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 495
    Height = 274
    ActivePage = GeneralSheet
    Align = alClient
    TabOrder = 0
    TabStop = False
    object GeneralSheet: TTabSheet
      Caption = 'Algemeen'
      object Label4: TLabel
        Left = 248
        Top = 68
        Width = 28
        Height = 13
        Caption = 'Naam'
      end
      object Bevel1: TBevel
        Left = 224
        Top = 8
        Width = 5
        Height = 233
      end
      object Label7: TLabel
        Left = 232
        Top = 20
        Width = 71
        Height = 13
        Caption = 'Controleer elke'
      end
      object Label8: TLabel
        Left = 344
        Top = 20
        Width = 37
        Height = 13
        Caption = 'minuten'
      end
      object Label9: TLabel
        Left = 248
        Top = 120
        Width = 39
        Height = 13
        Caption = 'Bestand'
      end
      object OpenSoundButton: TSpeedButton
        Left = 436
        Top = 116
        Width = 23
        Height = 22
        Hint = 'Zoek bestand'
        Caption = '...'
        Flat = True
        OnClick = OpenSoundButtonClick
      end
      object PlayWavButton: TSpeedButton
        Left = 460
        Top = 116
        Width = 23
        Height = 22
        Hint = 'Speel bestand af'
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000130B0000130B00000001000000010000004A00000052
          000000630000089C2100109C210010A5290010AD390039AD390010B5390018B5
          4A004ABD520052BD52005ABD52005AC65A0063C663006BC663006BC66B007BD6
          7B008CD68C00FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00131313131313
          1313131313131313131313131313131313131313131313131313131313131300
          0200131313131313131313131313130203020013131313131313131313131302
          0403020013131313131313131313130205050302001313131313131313131302
          0805030302001313131313131313130209060606050201131313131313131302
          0B0C0A0A0A02011313131313131313020D100F0A020013131313131313131302
          101111020013131313131313131313020E120200131313131313131313131302
          0702001313131313131313131313130002001313131313131313131313131313
          1313131313131313131313131313131313131313131313131313}
        OnClick = PlayWavButtonClick
      end
      object PopupCheck: TCheckBox
        Left = 10
        Top = 16
        Width = 169
        Height = 17
        Caption = 'Popup bij nieuwe berichten'
        TabOrder = 0
      end
      object PopupGroup: TGroupBox
        Left = 28
        Top = 40
        Width = 189
        Height = 201
        Caption = 'Popupinstellingen'
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 28
          Width = 24
          Height = 13
          Caption = 'Kleur'
        end
        object Label2: TLabel
          Left = 8
          Top = 120
          Width = 35
          Height = 13
          Caption = 'Sluit na'
        end
        object Label3: TLabel
          Left = 96
          Top = 120
          Width = 47
          Height = 13
          Caption = 'seconden'
        end
        object Label5: TLabel
          Left = 8
          Top = 92
          Width = 43
          Height = 13
          Caption = 'Linkkleur'
        end
        object Label6: TLabel
          Left = 8
          Top = 60
          Width = 50
          Height = 13
          Caption = 'Tekstkleur'
        end
        object PopupColorSelect: TColorBox
          Left = 60
          Top = 24
          Width = 117
          Height = 22
          ItemHeight = 16
          TabOrder = 0
        end
        object PopupTimeEdit: TMaskEdit
          Left = 60
          Top = 116
          Width = 28
          Height = 21
          EditMask = '99;0; '
          MaxLength = 2
          TabOrder = 3
        end
        object DeleteOnPopClickCheck: TCheckBox
          Left = 8
          Top = 144
          Width = 165
          Height = 17
          Caption = 'Verwijder bericht bij openen'
          TabOrder = 4
        end
        object LinkColorSelect: TColorBox
          Left = 60
          Top = 88
          Width = 117
          Height = 22
          ItemHeight = 16
          TabOrder = 2
        end
        object TextColorSelect: TColorBox
          Left = 60
          Top = 56
          Width = 117
          Height = 22
          ItemHeight = 16
          TabOrder = 1
        end
        object TestPopupButton: TButton
          Left = 10
          Top = 168
          Width = 167
          Height = 25
          Caption = 'Test popup'
          TabOrder = 5
          OnClick = TestPopupButtonClick
        end
      end
      object IgnoreselfCheck: TCheckBox
        Left = 234
        Top = 44
        Width = 133
        Height = 17
        Caption = 'Negeer eigen berichten'
        TabOrder = 3
      end
      object SelfNameEdit: TEdit
        Left = 296
        Top = 64
        Width = 141
        Height = 21
        TabOrder = 4
      end
      object AutoSaveCheck: TCheckBox
        Left = 234
        Top = 144
        Width = 169
        Height = 17
        Caption = 'Gegevens automatisch opslaan'
        TabOrder = 7
      end
      object IntervalEdit: TMaskEdit
        Left = 308
        Top = 16
        Width = 28
        Height = 21
        EditMask = '99;0; '
        MaxLength = 2
        TabOrder = 2
      end
      object RunOnStartupCheck: TCheckBox
        Left = 234
        Top = 164
        Width = 171
        Height = 17
        Caption = 'DeX automatisch starten'
        TabOrder = 8
      end
      object NotifySoundEdit: TEdit
        Left = 296
        Top = 116
        Width = 141
        Height = 21
        TabOrder = 6
      end
      object NotifySoundCheck: TCheckBox
        Left = 234
        Top = 96
        Width = 153
        Height = 17
        Caption = 'Geluid bij nieuwe berichten'
        TabOrder = 5
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 274
    Width = 495
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      495
      41)
    object Button1: TButton
      Left = 409
      Top = 8
      Width = 75
      Height = 25
      Action = CancelAction
      Anchors = [akTop, akRight]
      Cancel = True
      TabOrder = 1
    end
    object Button2: TButton
      Left = 325
      Top = 8
      Width = 75
      Height = 25
      Action = OKAction
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 0
    end
  end
  object ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 64
    object OKAction: TAction
      Caption = 'OK'
      OnExecute = OKActionExecute
    end
    object CancelAction: TAction
      Caption = 'Annuleren'
      OnExecute = CancelActionExecute
    end
  end
  object OpenWavDialog: TJvOpenDialog
    DefaultExt = 'wav'
    Filter = 'Wave bestanden (*.wav)|*.wav'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Selecteer wav bestand'
    Height = 0
    Width = 0
    Left = 160
    Top = 16
  end
  object Notifier: TNLDNotifier
    Color = clBlack
    TextColor = clBlack
    LinkColor = clBlack
    Timeout = 0
    Enabled = True
    Left = 236
    Top = 156
  end
end
