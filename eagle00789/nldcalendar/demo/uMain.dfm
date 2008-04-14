object Form1: TForm1
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Kleuren en Hints in TNLDCalendar door Henkie'
  ClientHeight = 347
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    528
    347)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 513
    Height = 13
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 160
    Width = 137
    Height = 17
    Caption = 'NLDCalendar1.ShowHint'
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object Button1: TButton
    Left = 280
    Top = 152
    Width = 105
    Height = 25
    Caption = 'ZetKleurenEnHints'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 392
    Top = 152
    Width = 129
    Height = 25
    Caption = 'VerwijderKleurenEnHints'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ListBox1: TListBox
    Left = 0
    Top = 185
    Width = 527
    Height = 161
    Anchors = [akLeft, akRight, akBottom]
    ItemHeight = 13
    Items.Strings = (
      'Dit zijn de datums, hun kleuren en hun hints (6 stuks):'
      
        '----------------------------------------------------------------' +
        '----------------------------------------------------------------' +
        '----------------------------------------------'
      '    datum             kleuren(back, Text)             hint'
      
        '================================================================' +
        '======================='
      '1) 01/07/2004: [clRed, clWindowText]        :1 juli 2004'
      
        '2) 05/07/2004: [clLime, clRed]                     :de vijfde da' +
        'g van de zevende maand in het jaar tweeduizend vier'
      '3) 10/07/2004: [clBlue, clYellow]                 :10 juli 2004'
      
        '4) 21/07/2004: [clTeal, clWhite]                  :Nationale fee' +
        'stdag Belgi'#235
      
        '                                                                ' +
        '     :1ste man landde 35 jaar geleden op de maan'
      '5) 23/07/2004: [clFuchsia, clLime]               :23 juli 2004'
      
        '6) 25/07/2004: [clYellow, clMaroon]            :Je staat nu link' +
        'sonder in de kalender'
      
        '================================================================' +
        '=======================')
    TabOrder = 4
  end
  object NLDCalendar1: TNLDCalendar
    Left = 6
    Top = 32
    Width = 514
    Height = 115
    Anchors = [akLeft, akTop, akRight]
    Day = 21
    Month = 7
    StartOfWeek = 0
    TabOrder = 3
    UseCurrentDate = False
    Year = 2004
    OnMouseMove = NLDCalendar1MouseMove
  end
end
