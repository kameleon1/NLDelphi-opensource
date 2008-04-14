object frmMain: TfrmMain
  Left = 197
  Top = 140
  BorderStyle = bsSingle
  Caption = 'NLDMessageBox Demo'
  ClientHeight = 229
  ClientWidth = 174
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cmdNormal: TButton
    Left = 4
    Top = 4
    Width = 165
    Height = 25
    Hint = 'This will display a normal MessageBox'
    Caption = '&Normal MessageBox'
    TabOrder = 0
    OnClick = cmdNormalClick
  end
  object cmdCustomIcon: TButton
    Left = 4
    Top = 32
    Width = 165
    Height = 25
    Hint = 'This will display a MessageBox with a custom icon'
    Caption = 'MessageBox with &custom icon'
    TabOrder = 1
    OnClick = cmdCustomIconClick
  end
  object cmdCheckbox: TButton
    Left = 4
    Top = 60
    Width = 165
    Height = 25
    Hint = 'This will add a CheckBox to the MessageBox'
    Caption = 'MessageBox with Check&Box'
    TabOrder = 2
    OnClick = cmdCheckboxClick
  end
  object cmdPositioned: TButton
    Left = 4
    Top = 88
    Width = 165
    Height = 25
    Hint = 'This will show the MessageBox at a custom position'
    Caption = '&Positioned MessageBox'
    TabOrder = 3
    OnClick = cmdPositionedClick
  end
  object cmdCentered: TButton
    Left = 4
    Top = 116
    Width = 165
    Height = 25
    Hint = 'This will center the MessageBox to this form'
    Caption = 'C&entered MessageBox'
    TabOrder = 4
    OnClick = cmdCenteredClick
  end
  object cmdCenterText: TButton
    Left = 4
    Top = 144
    Width = 165
    Height = 25
    Hint = 'This will center the MessageBox text'
    Caption = 'Centered &Text MessageBox'
    TabOrder = 5
    OnClick = cmdCenterTextClick
  end
  object cmdAutoClose: TButton
    Left = 4
    Top = 172
    Width = 165
    Height = 25
    Hint = 'This MessageBox will close automatically after 5 seconds'
    Caption = '&Auto-Closing MessageBox'
    TabOrder = 6
    OnClick = cmdAutoCloseClick
  end
  object cmdFull: TButton
    Left = 4
    Top = 200
    Width = 165
    Height = 25
    Hint = 'This shows that you can combine the options freely'
    Caption = 'The &Full Arsenal'
    TabOrder = 7
    OnClick = cmdFullClick
  end
  object mbTest: TNLDMessageBox
    Caption = 'Hoera!'
    CheckBoxCaption = 'Laat mij nooooooooooit meer zien!'
    Checked = False
    CloseDelay = 5
    Icon.Data = {
      0000010001002020000001000800A80800001600000028000000200000004000
      0000010008000000000000040000000000000000000000010000000100000000
      0000000080000080000000808000800000008000800080800000C0C0C000C0DC
      C000F0CAA60000003E0000005D0000007C0000009B000000BA000000D9000000
      F0002424FF004848FF006C6CFF009090FF00B4B4FF0000143E00001E5D000028
      7C0000329B00003CBA000046D9000055F000246DFF004885FF006C9DFF0090B5
      FF00B4CDFF00002A3E00003F5D0000547C0000699B00007EBA000093D90000AA
      F00024B6FF0048C2FF006CCEFF0090DAFF00B4E6FF00003E3E00005D5D00007C
      7C00009B9B0000BABA0000D9D90000F0F00024FFFF0048FFFF006CFFFF0090FF
      FF00B4FFFF00003E2A00005D3F00007C5400009B690000BA7E0000D9930000F0
      AA0024FFB60048FFC2006CFFCE0090FFDA00B4FFE600003E1400005D1E00007C
      2800009B320000BA3C0000D9460000F0550024FF6D0048FF85006CFF9D0090FF
      B500B4FFCD00003E0000005D0000007C0000009B000000BA000000D9000000F0
      000024FF240048FF48006CFF6C0090FF9000B4FFB400143E00001E5D0000287C
      0000329B00003CBA000046D9000055F000006DFF240085FF48009DFF6C00B5FF
      9000CDFFB4002A3E00003F5D0000547C0000699B00007EBA000093D90000AAF0
      0000B6FF2400C2FF4800CEFF6C00DAFF9000E6FFB4003E3E00005D5D00007C7C
      00009B9B0000BABA0000D9D90000F0F00000FFFF2400FFFF4800FFFF6C00FFFF
      9000FFFFB4003E2A00005D3F00007C5400009B690000BA7E0000D9930000F0AA
      0000FFB62400FFC24800FFCE6C00FFDA9000FFE6B4003E1400005D1E00007C28
      00009B320000BA3C0000D9460000F0550000FF6D2400FF854800FF9D6C00FFB5
      9000FFCDB4003E0000005D0000007C0000009B000000BA000000D9000000F000
      0000FF242400FF484800FF6C6C00FF909000FFB4B4003E0014005D001E007C00
      28009B003200BA003C00D9004600F0005500FF246D00FF488500FF6C9D00FF90
      B500FFB4CD003E002A005D003F007C0054009B006900BA007E00D9009300F000
      AA00FF24B600FF48C200FF6CCE00FF90DA00FFB4E6003E003E005D005D007C00
      7C009B009B00BA00BA00D900D900F000F000FF24FF00FF48FF00FF6CFF00FF90
      FF00FFB4FF002A003E003F005D0054007C0069009B007E00BA009300D900AA00
      F000B624FF00C248FF00CE6CFF00DA90FF00E6B4FF0014003E001E005D002800
      7C0032009B003C00BA004600D9005500F0006D24FF008548FF009D6CFF00B590
      FF00CDB4FF0006060600121212001F1F1F002C2C2C0039393900454545005252
      52005F5F5F006C6C6C007878780085858500929292009F9F9F00ABABAB00B8B8
      B800C5C5C500D2D2D200DEDEDE00EBEBEB00F8F8F800F0FBFF00A4A0A0008080
      80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      000000000000F2EAE6E5E5E4E4E4E4E4E4E5E5E6EAF200000000000000000000
      0000000000EDE200E4E7E8E9E9E9EAEAE9E9E7E500E2EE000000000000000000
      00000000EC0000E8EDEDEDEDEDEDEDEDEDEDEDEDEBE200ED0000000000000000
      000000F10000E7EDEDEDEDEDEDEDEDEDEDEDEDEDEDEBE2E2F100000000000000
      000000E900E5EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEA00EA00000000000000
      000000E600F8EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE4E600000000000000
      000000E400F8EDEDEDE4E2F8EDEDEDEDEDE5E2EBEDEDEDE5E500000000000000
      000000E300E4ECEDE800E3ECEDEDEDEDEDE600E4EDEDE800E300000000000000
      000000E20000E2E4E2EAEDEDEDEDEDEDEDEDF8E5E3E30000E300000000000000
      000000E200E4E500E2E8E9EAEAEAEAEAEAEAE9E5E2E6E300E200000000000000
      000000E2E5F5FFEE0000000000000000000000E3F2FFF2E2E200000000000000
      000000E2ECFFFFFFEC000000000000000000E207FFFFFFE7E200000000000000
      0000F2E2EBFFFFFFFFF0EAE8E8E8E8E8E9F8F2FFFFFFFFE5E2F2000000000000
      F7E30000E4F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2000000E3F7000000F1
      0000000000EEFFFFFFFFFFF4F5FFFFFFF4FFFFFFFFFFE800000000E2F20000EA
      E2EAE90000E4F5FFFFFFF700E7FFFFED00E8FFFFFFF2000000E9EA00EA0000E6
      EB0000EC0000ECFFFFFFF800E4FFFFEA00E6FFFFFFE70000ED0000EAE70000E6
      F2000000E400E3F3FFFFF5EFF3FFFFF5EFF4FFFFEF0000E4000000F2E70000EB
      00000000EA0000E8FFFFFFFFFFFFFFFFFFFFFFF4E40000EA00000000F8000000
      00000000ED000000EFFFFFFFFFFFFFFFFFFFFFEA000000EE0000000000000000
      000000F0E8000000E3F4FFFFFFFFFFFFFFFFF000000000E8F000000000000000
      00EFE4000000000000E7FFFFFFFFFFFFFFF4E3000000000000E4EF0000000000
      EE000000000000000000EBFFFFFFFFFFF5E6000000000000000000F700000000
      E400000000000000000000EDFFFFFFF5E800000000000000000000E500000000
      E300000000E8EFF3F3F0EBE2F8F5F4E7E3EBF0F3F3EFE800000000E300000000
      E6000000EB000000000000F2E4E3E2E5F3000000000000EA000000E700000000
      EF000000000000000000000000EDED000000000000000000000000EF00000000
      00E8000000000000000000000000000000000000000000000000E80000000000
      0000E500EF000000000000000000000000000000000000F700E5000000000000
      000000E5E5000000000000000000000000000000000000E5E500000000000000
      00000000E9EB00000000000000000000000000000000EAE90000000000000000
      0000000000F0F20000000000000000000000000000F20700000000000000FF00
      00FFFE00007FFC00003FF800001FF800001FF800001FF800001FF800001FF800
      001FF800001FF800001FF800001FF000000FC000000380000001800000019800
      00199C000039BC00003DFC00003FF800001FE0000007C0000003C0000003C000
      0003C1F81F83C3FE7FC3E3FFFFC7F1FFFF8FF9FFFF9FFCFFFF3FFE7FFE7F}
    MessageLeft = 100
    MessageTop = 100
    Options = []
    Style = [mbOkCancel, mbIconInformation]
    Text.Strings = (
      'Een NLDMessageBox testje bla '
      'bla bla bla bla bla bla!')
    Left = 4
    Top = 4
  end
end