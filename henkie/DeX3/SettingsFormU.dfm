object SettingsForm: TSettingsForm
  Left = 301
  Top = 180
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'DeX 3 instellingen'
  ClientHeight = 486
  ClientWidth = 628
  Color = clBtnFace
  Constraints.MinHeight = 466
  Constraints.MinWidth = 560
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    628
    486)
  PixelsPerInch = 96
  TextHeight = 13
  object BottomBevel: TBevel
    Left = 8
    Top = 434
    Width = 612
    Height = 52
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
    Visible = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      628
      65)
    object Bevel2: TBevel
      Left = 0
      Top = 48
      Width = 628
      Height = 17
      Align = alBottom
      Shape = bsBottomLine
    end
    object Label10: TLabel
      Left = 16
      Top = 8
      Width = 66
      Height = 13
      Caption = 'Instellingen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label11: TLabel
      Left = 24
      Top = 24
      Width = 521
      Height = 33
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = 
        'Pas de verschillende instellingen aan naargelang je eigen voorke' +
        'uren.'
      Transparent = True
      WordWrap = True
    end
    object Image1: TImage
      Left = 553
      Top = 6
      Width = 68
      Height = 53
      Anchors = [akTop, akRight]
      AutoSize = True
      Picture.Data = {
        0A544A504547496D616765E0120000FFD8FFE000104A46494600010101006000
        600000FFE1006645786966000049492A000800000004001A010500010000003E
        0000001B0105000100000046000000280103000100000003002E023101020010
        0000004E00000000000000A3930000E8030000A3930000E80300005061696E74
        2E4E45542076332E323200FFDB00430001010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101FFDB0043010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101FFC0001108003500440301
        2200021101031101FFC4001F0000010501010101010100000000000000000102
        030405060708090A0BFFC400B5100002010303020403050504040000017D0102
        0300041105122131410613516107227114328191A1082342B1C11552D1F02433
        627282090A161718191A25262728292A3435363738393A434445464748494A53
        5455565758595A636465666768696A737475767778797A838485868788898A92
        939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7
        C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FA
        FFC4001F0100030101010101010101010000000000000102030405060708090A
        0BFFC400B5110002010204040304070504040001027700010203110405213106
        1241510761711322328108144291A1B1C109233352F0156272D10A162434E125
        F11718191A262728292A35363738393A434445464748494A535455565758595A
        636465666768696A737475767778797A82838485868788898A92939495969798
        999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4
        D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002
        110311003F00FE803F680B0F8A907C43F10CF63E35F1BFFC23B79AC5C4D6E6C7
        57BD4B7B27699CBD9BB5BCAA2D953E5F259FCA89E2DBB19B61AD5F87DA67C4DB
        5B789EE7C7DE389A0701D52F35AB997782BE6A219AE37C8D1C8DB5118B3ED1B8
        E0F43E922D74FF00166ADE27F17FC31F1C5F5969C3C59AFE9B7BA5EBB6F3DEE8
        31EB5A66AB3D8EA566B05FBDB5FE9337DB848A0D85DCB03BB235B44CF218C77D
        6B67E26886CD4345859C7CA67B1BD8EE607C63E745BA5B2B8453D93C820752C7
        8AFC79612ABC5621D5AF8D9525566A34E35AAF23BDB6A94E74B9AD6D6F0B2E96
        BBBFD1C6A52F654FD9D3A4B47CDEE3DFDDEEF4D9F45AEA52D2FC41E34B1B4482
        7F14EB734DF33CF27DBE6CBCD2312FB4B83FBA51B52203002282C4B6E66ABAE7
        8E7C596BA75CCCFE29D6605489DCCCD7F3651506E24636679C617B9EE2B6A5B3
        D4DC6D874C995F07059A123A8EA64962C7E01B3C8E3A1E2F5CF0E016973ABF8B
        2EE2B4F0FE9914FA8DFDA4667B857B7B58CCD3CB7CD6F6E5DADE38A37926B5B4
        59A5980F2F711946E99C6A4692A54EA55574EF3954B415AC9733B3B6FA77B3D4
        8389BBF89BE27F09786BC2136A1E38FECCB9D5355924B66F14EA3AD9B2B9B9BD
        9AEB5386D0EA51BDC4563724CC92C4BA86EB49D226B648D06147D3567E36F104
        F696F70BE23BE99678229BCF86F256B797746A4CB032CACA60901F32320B7EED
        C735F9DDF11FC5BE20D47C49AAF8ADE1F1AF873E19F80F40FEDFB5D63C2F168F
        F147C03F17FC1DAA5919B50B6BDF01DAD8DCF8974CF13785B55B7D934B65613C
        5676A218EE35BD31758B1BC877BE1943E32F1778723F15FC40F1658EADA45D68
        579A3E9DE2BD1B53BBB5F0D78FBE1B6BD09D6744F12C1A179F6F37837C4D10BD
        4B2BD574951E0B5FB3C2F3DB342D6F30AD89A14E553DAD6AB0E5A5152F6BC975
        14D37F0CFBAD2FA5AD7EC495294E11F676BA7AF36D6B744BAEBADD77D3A7DFC9
        E2BF15300DFDBF7C010194A5CCFB181E41DC25048FC38A6B78BFC52FD75ED440
        195CC13CD9C71FC4CE0AE47A023DEBE364F8C7E08D06E8C51F8B2F2F2F4D945A
        5CB791E8FABEA16AA608E4885C451DBD8DC5AC6C04ACCBE5A88965114AC8CD1A
        9AF65F09FC49F0DF88E084E97ACE9D78B6DA74ED72CB7264BB92EA2699E3DF68
        B10BBB2F35047691C5716B12ACFE5996E009C14D28E610AF2E4A78A6E6D5F97D
        BBF7B4D7EC7CAD67A5BD072A695BDA42FDB5DB66FA7C8FA9B43D6356BDD3E39A
        EB50BAB8943BA89269A491F6643AAEE66CE1779F6CE4E06700AE6FC35711CBA4
        5BCCCCB109CC92A2C859494673B5970AC194E0E181C1E7818C515F5F86855961
        E84BDBDAF4E0EDCBB5E31D3E2F97CFD6FE54AFCCF4EBD979793FE9FDFF008E7F
        16BC3DABFC55FDA1FE28FEC7DE3AF087C4AF0DFC16F0DF8AF57F89367E29F0D4
        3A92DB78BB4EBFBBD0FC5D05A477B73A0EA1A201E1BF10F8DEF7C433C8D36A93
        6B2FE1682D751B58A28B567BEE053E2EFC4CF887A4F807C75F05BE307C43D23E
        1F7ECAC6F2C7F681D135987C4115DF8E2D34ED0ED5358B2B6B2B5D3275F12269
        5E1FF0178C6F2C753BF274BB4BDD4E258E7B5BD6B9974DFB6BE25FED19F15BC3
        9F193C79A149F04DB598FC33A86A5ACE9D7961AADD69D3EA30BDB7862348D94E
        9DAB958F52B28A5B296688346D1DECA02294E7C862FDA83F664F1B7C39F17782
        7C49F0E350F84FA2F8E2E6FF00C29E22D3116D34DB1D45757F056A3A44DA8DEF
        8B342D352EC6A891CF1C13DF6B9A45ACEEF1AFDAEEF64CF00F1296270D3A9528
        C6B469D575B485753A17F6B6E4717520AEAC9BD13E556BEEADE8C9CE51A4FD8D
        2568A524D36E5ECDA7AB5649BBDA765EF257BEA5BF1C7ED3C936BBE37B9B7F89
        9AA27C15F14D9E97A6F81BE23785F4BBB8C68FE29B9F0825CC9A6E8F7FA7E99F
        6FB9126A171E65C8027923BF166022446696BE678FF6AFF17691A6F83F56D62E
        FC41AA7C4AF0D5EC9A1CF7D771CBABF843C49E1DD454C9336A5A841F61BC91F4
        E9CDA68FAB5A5EDBB79FA8CD1CFA7DD4771E6C107D6DF177C296DE34FD9EBE18
        FC2DF80BA568F3783FC33E2ED3EFAF7C49AAF8A745BF96DB4FD5B4EF14C07C47
        617FA5DB7F65DD5FDADD6A978F1C11C76CA1DEDA3D3ED5CDB4B18F903E31FC30
        D1AC3C69E17F85FF00067C33E33F11F8BE4F0ADB794D777D06B3A3F872CB478D
        5F50D7AF0693A1469F688AEA192EED7FD36E96CAE6F67D42F84D742D631E663F
        2ECD284255E74DCB0F09C63ED6328D9CEAEB1A14A37FDE7B251F7A7757E65EE4
        7AF4E1F194A5178771A2F99CBDE941CA7EF72B8FBDCC9C795C6EBD5F35D58EDF
        E1A6AD7BF117C55E0CB3D77E15FC5EF86FA6DD7C40BBF1A7833E23FC22F136A3
        2687E1A9F50B9679746F1D786649F55D120F0EDFC4FF00D8B79AB6B3A45A4F0E
        9F7B6BA518208E47693EA2B4D75E1B8D65F59D1FC55E22D2B4ED5EDE2B7D262B
        5BDBB927BB934B6D4AEF5516D7D322CBA6416A235B5F24359194BCB16D660CBF
        9E1FB34FC61FD9CB46F8A1E1EF0ADBF8F3E30F863E2EEA7E248FC29AB7851A5B
        6B8F875E2DBBD51AD74E90DD4505BDC5C59CEF726D6556BFB4B7BA4BE1A7DBC9
        AA1B973247FA452F89D6DADBC5572DA4799F67D527D09A26BF8501493C357AB2
        5F33BDB848F61077DA3E1976E1A61D46F0C0CEAD1C3C654DB8D49529BA774EF2
        9295B54DA92BA767A2F42635A8C255E34E117CFECDCDBBF34791CADCAEDA735E
        D2496AAC96BA8CD5BC4DA57887C29A84565E15D5747F2EFB463040746F2AF353
        B09F57B6B791F4E96CA13733BC64F917D05BC8EF0F981599924C9C1B1D4BC2DE
        22D02FEC6E7C25E22F0FEA7A7F866FFECDE2386C6E6C6F64D4B4DD37FD312D6E
        229A1963D5410D710DB99D66B8892491CC4C8C062F8D3E282D8699AB78A34ED0
        84367A5EA96A74E96E6EE1FB1BDD6A9AC68AA16E4DA2EC8DAD22B27BFBBB6B6B
        B964612081A5B7370D347CDF887E28E97E1DD3B44D2AC6C6E2FEFB5BF00C7E29
        818DD416E4496FE10D6EDEF1B55905B0B5D3A1598319EEC040678FFB3B4BD36F
        B5092CECAE78B11468D194A9BA517385F9E2D27C8D46126B7D5F2C937F24B5D0
        D5548A82828A769F3C65AF36BCB149B6B58AE56D2D126F4B5EE7E81FECF9A76A
        A9F0BF47FB46A336AAC6FB5B11CBE20FB4DA6B169143AADD5BA69F7D14F71732
        6FB4F24A47279816480C4C234CE28AC0FD9A3C77A6F8E3E13E97E265B9B1866D
        4B58F123DDDBDACA7ECF05E26B57893C7092CAED0330135B34837B5B4B0B10A0
        8552BEC3072C22C2E1D59DD51A6B769DF963F8A763CBABEF559BEF36F45A6AD6
        CB4B6FB7A2EA7E84DCDA45793CC2E6C34EB8491DD5FCEB389DD823602B38C160
        70A403C0E3D0578D7C42FD987E117C4AB19A0D5BC29A7E9D753090AEA3A6DB41
        6F2A4CD91E68554111DBBB18D8095CE58135EF6268A36964768E08E332177964
        DA8ABBDB2CCE542A28EE588EBC027356ADA6B6BB432DB5C4170818A992DE5499
        370EA37C6C54FE04E6BD0C4E0E862E3C988A74EA46EF4924DA4ED769F476D1F7
        D3B6BCB4EA4A9C94A329AB6AD465CA9EDBE8F6E9A1F8CFE29F831F1C3F63BD66
        E3C61F09B533E20F02CF72B73ADF866EE17BBF0FEA712B02D1EA7A526C36373B
        17645ADE9A6DEFE02021BD92D9EE2D6EBEAFF097C5BB4FDA03E1178CF5FF0081
        16DA0785FE37DB68ADA75D687E27823371E19D72E0469E64AD18B51A9E9D3431
        4F36817D7221D26FAFED2D21D69206B4BCB2B7FBAAFAC6CF52B49EC750B686EE
        CEE627867827459239237055D591B2A415241047BE462BF21FE3F7C27F11FECB
        BF13B47F8EBF08D258B4A3745755D2159C585FE9B72E93EA9E1ED4951591EC75
        18D03C3200CF63751DBDF4005CDAC2EBF3589C362723BD4A6E75F28A9EED6A15
        66E75B05B72D6A33B2E75ACD5487246F686AAD63B635238A924E94218857E594
        34524ED7D2CB5564F57D5A3C734CF839FB4EFECC9A17867C0FF052CFF671F885
        F13FC61ABEA1E32D7FE1A78C3478C78E3C31A3828355F1EEA3F1193C79E1B97C
        490CFAC4B069B7F7B77A3C5159EB1ACDBD8F86E6D42DA1DEBF627C4EF01DEF89
        2C7C1B3EBC2D7C2FAADF369F0F8862D3D4EA3A6D9EB773A64C9369D04F30B733
        DBADE4F736769A8796AF3ADB5A1685E49E30FC57C65D2FF65AD3F4197FE0A2DA
        D7853E216BFAD2781F46D1AF2DBC05E21D7AC7589219EFADF418ECF54D2F46D6
        F44B1F3F41BBB9934CD665D53525D0ADA2B0FB64965757F0C33C9E75F0BBC5DF
        B2EFC33834BF81B63F163C55E2EBBFDA43C49AAF8D7C21A6EA1FF093EBFA3786
        25F11D9DADF69DE18D13C437965729A5B5A5C416ED670EB9AC5CEBB3EBF23DF6
        A2964FA8595AC9D5C91A74AD85AF193A7429D4A1CF3539D48595A5CDCBBB5656
        69BBB7AEAD99D0A97AA9CA3686A9B4ED08B76B72C52D2FADFDE7D1762AFED312
        DCD868F7DA668B6C8DAB456C2F2CE136FB6169A2218A00CAB1C8655F36312296
        50F2292490CA3F2EBC2DF16AF3585D4BC25E24D41EC60BBBC9CE9FAAC8B1ACBA
        56A654DB3DB6A292152B6C5D58279A9E4DBB4974A891C777E60FD86F12782A7F
        184F3F857C4D78DA6F8E3C336EA916AAF01934FF00177872491A3B0D5A28A368
        9A39C6E306A314251ED6F818668A48248E4AF80BE29FEC45E21F12F8924D5B45
        B9B5D06EEE1CA5E6B169750FD96F611F2F9B369C616BB698841BB65A79AC400F
        32805ABF3FC5E1E753135A53A551D2C4271F691579D2A916B9A3529B4927AAB7
        BCAFABB24B5F5E32514A378AB6EE52E5BAD15D2B3BDBAD9F63EE1FD98FE1DF8D
        340F85B696BAEDCE91F6AB9D5F50D42036B2C8E8D65751DA1B7790C71BC2256D
        8ECE209658B054AB825910AEABF66DF84CBF0D3E1769DE147F10EB1AC4969A8D
        FCD25ECB7335AA3C92F90AEB6D6B02ECB7B60D1131C459DC1672EC58900AFBBC
        14E14F078687B34F96853576D5DDA31D5FBAF576BFADBB6BE554B7B49EBF6DF5
        B758FF00C1FBBC8FBF75CF015CEB7AB48DA9F892F6E2CA399E6874E16A915BC4
        B7059821F2E75F35A1DC16396659182285006493ADE10F86F1F876FE3FB26B97
        AF1B3492BC4F0A88CEE62CC8144E57CB39036B2BE00E3193928AF62950A5F5AA
        B57D9C79FDB54F7B5BE8A95B4BDBABE9D4E3552765EF3D91EBA74C8E4E923263
        FBA0739C75E7B60FE75C5FC40F87BA378E7C29ABF85B5AF9ECB53B49232EB12B
        3412E3F75711AB3106489B91F328232A4F390515E9E2A119E1F11192E68CA854
        8C93D9A6E374FEE32A32946B53E56D5DEBF268F9DFF673F81B17C25D37C5FE0E
        B7F155EEBFA05DEA475DB0B3BED36DE01A55D4E8D05EC5015B9B8592DEF160B3
        92488AC6A2E2DE49C876BA9B3C5E9FE0CD4BC4DF11F58F15F8E6F7C23E2293C1
        3A3EBD27C39B4B6F0243A7CBE109F52BFF00B06A77D1EAD7FAEEBDA9DCEA7A8D
        843636579756171A2C525AC1731ADAA7F685D3128AF27034294705878A845462
        A508A57568A51B477D91D15A5295472936E4D45B7D6FCA99D4E83F08EEBC6BE1
        DF33C53E2D96F7C45A36B3A8C7A7F89AC344B5D2AF607548DCECB786EE5805A4
        9B85BCD61CDACF69144B3AC97B18D42B61BE08DA4B10FB4788269650B89255D2
        E08C48CA30CC23FB536DDC4671BDB6E7009EE515E7BC261AF27EC617718B6DAB
        DDE9BEBE6FEF36F693FE666AC3F0EAD7C396F05845A94B72B223DDEF6B58A12A
        669A54F2F6879010A22186C8CE71B463928A2BD3A187A1EC697EEE3F047A791C
        752AD45395A4F7F2F2FF00247FFFD9}
    end
  end
  object OkButton: TButton
    Left = 458
    Top = 450
    Width = 75
    Height = 25
    Action = OKAction
    Anchors = [akRight, akBottom]
    Default = True
    TabOrder = 3
  end
  object CancelButton: TButton
    Left = 542
    Top = 450
    Width = 75
    Height = 25
    Action = CancelAction
    Anchors = [akRight, akBottom]
    Cancel = True
    TabOrder = 4
  end
  object PageControl: TPageControl
    Left = 184
    Top = 65
    Width = 441
    Height = 384
    ActivePage = GeneralSheet
    Style = tsFlatButtons
    TabOrder = 2
    TabStop = False
    object GeneralSheet: TTabSheet
      Caption = 'GeneralSheet'
      object GeneralGroup: TGroupBox
        Left = 4
        Top = 4
        Width = 425
        Height = 349
        Caption = ' Algemeen '
        TabOrder = 0
        object StartWithWindowsCheck: TCheckBox
          Left = 8
          Top = 72
          Width = 409
          Height = 17
          Caption = 'Opstarten met Windows'
          TabOrder = 2
        end
        object AlignTabbarToTopCheck: TCheckBox
          Left = 8
          Top = 24
          Width = 409
          Height = 17
          Caption = 'Tabbar boven uitlijnen'
          TabOrder = 0
        end
        object UseTDeXHintCheck: TCheckBox
          Left = 8
          Top = 48
          Width = 409
          Height = 17
          Caption = 'TDeXHint gebruiken'
          TabOrder = 1
        end
        object SiteColorsGroup: TRadioGroup
          Left = 8
          Top = 272
          Width = 409
          Height = 65
          Caption = ' Kleuren gebruikt op tabblad Website'
          Items.Strings = (
            'NLDelphi VB3 Style'
            'Wit-Paars')
          TabOrder = 5
        end
        object FontGroup: TGroupBox
          Left = 8
          Top = 200
          Width = 409
          Height = 65
          Caption = ' Lettertype dat gebruikt wordt in de lijsten: '
          TabOrder = 4
          object PreviewLabel: TLabel
            Left = 8
            Top = 46
            Width = 179
            Height = 13
            Caption = 'Dit is een voorbeeld van het lettertype'
          end
          object FontCombobox: TJvFontComboBox
            Left = 8
            Top = 19
            Width = 393
            Height = 22
            AutoComplete = True
            DroppedDownWidth = 393
            MaxMRUCount = 0
            FontName = '@Gungsuh'
            ItemIndex = 8
            UseImages = False
            Sorted = True
            TabOrder = 0
            OnChange = FontComboboxChange
          end
        end
        object HideGroup: TGroupBox
          Left = 8
          Top = 104
          Width = 409
          Height = 89
          Caption = ' Verbergen naar Tray Notification Area (SystemTray): '
          TabOrder = 3
          object MinimizeToTrayCheck: TCheckBox
            Left = 8
            Top = 16
            Width = 385
            Height = 17
            Caption = 'bij minimaliseren'
            TabOrder = 0
          end
          object CloseToTrayCheck: TCheckBox
            Left = 8
            Top = 40
            Width = 385
            Height = 17
            Caption = 'bij klikken op de [X] knop om te sluiten'
            TabOrder = 1
          end
          object HideOnStartCheck: TCheckBox
            Left = 8
            Top = 64
            Width = 385
            Height = 17
            Caption = 'bij opstarten'
            TabOrder = 2
          end
        end
      end
    end
    object MessagesSheet: TTabSheet
      Caption = 'MessagesSheet'
      ImageIndex = 3
      object GroupBox2: TGroupBox
        Left = 4
        Top = 4
        Width = 425
        Height = 349
        Caption = ' Berichten '
        TabOrder = 0
        object DeleteMessagesAfterBeingReadCheck: TCheckBox
          Left = 8
          Top = 96
          Width = 401
          Height = 17
          Caption = 'Berichten verwijderen na lezen'
          TabOrder = 3
        end
        object DeleteItemsCheck: TCheckBox
          Left = 8
          Top = 24
          Width = 409
          Height = 17
          Caption = 'Berichten verwijderen na toevoegen aan favorieten '
          TabOrder = 0
        end
        object MultipleItemsDeletionCheck: TCheckBox
          Left = 8
          Top = 48
          Width = 409
          Height = 17
          Caption = 'Altijd om bevestiging vragen bij verwijderen meerdere berichten'
          TabOrder = 1
        end
        object GroupDeletionCheck: TCheckBox
          Left = 8
          Top = 72
          Width = 409
          Height = 17
          Caption = 'Altijd om bevestiging vragen bij verwijderen groepen'
          TabOrder = 2
        end
      end
    end
    object PopupSheet: TTabSheet
      Caption = 'PopupSheet'
      ImageIndex = 1
      object PopupGroup: TGroupBox
        Left = 4
        Top = 4
        Width = 429
        Height = 349
        Caption = ' Popup '
        TabOrder = 0
        DesignSize = (
          429
          349)
        object Label16: TLabel
          Left = 8
          Top = 152
          Width = 68
          Height = 13
          Caption = 'Sluit popup na'
        end
        object Label2: TLabel
          Left = 152
          Top = 152
          Width = 50
          Height = 13
          Caption = 'seconden.'
        end
        object Label3: TLabel
          Left = 24
          Top = 96
          Width = 73
          Height = 13
          Caption = 'Bestandsnaam:'
        end
        object SpeedButton1: TSpeedButton
          Left = 360
          Top = 111
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SpeedButton1Click
        end
        object PlaySoundButton: TSpeedButton
          Left = 384
          Top = 111
          Width = 23
          Height = 22
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            0800000000000002000000000000000000000001000000000000000000000101
            0100020202000303030004040400050505000606060007070700080808000909
            09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
            1100121212001313130014141400151515001616160017171700181818001919
            19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002E2B
            2800453B3100644F3B007D5F4400926E4C00AB815A00C6986C00D7A67800DFAE
            7F00E5B48600E9B88A00EBBB8D00EDBE9100EFC09400F0C39700F2C49800F1C3
            9600F1C29500F1C19300F0BD8C00EFB88500EEB37D00EDB07700ECAC7200EBA9
            6C00EAA56600E8A05F00E69D5B00E49A5800E3975400E1944F00DF8F4900DD89
            4100DB853C00D8803700D67C3200D4782D00D3752A00CF6E2100CC661700CA62
            1200C65D0E00C55A0B00C4580A00C2560800C2540700C2530600C2510500C250
            0300C24F0200C14E0200BE4D0100BC4B0100BB4A0000BB4A0000BA490000B948
            0000B8480000B5480200B1480300AE460400A9440400A4430500A04106009C40
            07009B3F0700993E0700963D0800923B09008E3909008B380A0088370B008536
            0C0080340D00773010006F2D1200692A130064281500612716005C2517005823
            18005522190053211A0054221A0056231A0059251A005D281B00612C1E006635
            26006B4031006F4D410074615B007A7776007E7E7E007F7F7F00808080008181
            8100828282008383830084848400858585008686860087878700888888008989
            89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
            9100929292009393930094949400959595009696960097979700989898009999
            99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
            A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
            A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
            B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
            B900BABABA00BEBCBA00C2BFBB00C9C3BD00CEC6BE00D5CAC000DBCEC200E0D2
            C400E5D5C600E9D7C700ECD9C600EDDAC800EEDCCA00F1DECB00F3E0CE00F5E2
            D100F6E5D300F8E6D500F9E8D700FAE9D900FAEADA00FAEBDB00FAECDD00FAEC
            DE00FAEEE100FAEEE200FBEFE300FBF0E500FBF1E700FCF2E800FCF3E900FCF4
            EB00FCF5EE00FDF7F200FDF9F500FEFAF600FEFBF800FEFBF900FEFCFB00FEFD
            FC00FEFDFC00FEFEFD00FEFEFE00FEFEFE00FEFEFE00FEFEFD00FEFCFD00FEFA
            FD00FEF3FC00FEE7FC00FED8FC00FEC3FB00FEABFB00FE8EFB00FE6AFC00FE41
            FD00FE1DFD00FE04FE00FE02FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
            FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00F5F5F5F5F573
            736D6D7373F5F5F5F5F5F5F5F5F5F598999C9C9998F5F5F5F5F5F5F5F5756E63
            5C56555B626D73F5F5F5F5F5F5999CA3A5A7A7A7A49C98F5F5F5F5F56F655151
            5459545453516573F5F5F5F59BA2AAAAA8A7A7A8A8AAA298F5F5F56D6352594F
            29475A565555516573F5F59CA3A9A7B0C6BBA6A7A7A7AAA298F5F56A53545850
            C6D3465A565555516DF5F59FA9A8A7ADDAE0BCA6A7A7A7AA9CF5655D4D4C4C4B
            C4E4D83F595955536073A2A7ADAEAEB0DAE1E1BFA7A6A7A8A498624B48484847
            C4E4E4E4295559545B73A3B0B6B9B7B9DAE1E1E1C6ABA6A8A798604745464545
            C7E4E4E4E4C44C585573A5BBBCBCBCBCDAE1E1E1E1D6B0A7A8985F413C414141
            C9E4E4E4E42D4F565571A6BEC1BEBEBEDCE1E1E1E1D1AEA7A899613F333C3E3D
            CAE4E4E43A5959545B73A3BFD3C1C0C0DCE1E1E1C1A8A6A8A7986044C433393A
            CDE4D43E535855536273A4BDDAD3C2C2DCE1E0BFAAA7A7A8A498F55C33CE3039
            D2CE41494B5556516EF5F5ACD3DFD3C6E0DFBEB5B0A8A7AA9BF5F55F45C6D030
            303F47484B51516775F5F5A3BCDAE0D6D6BFBBB7B0AAAAA199F5F5F5604530CE
            C534393D4349666EF5F5F5F5A4BCD6DFDAD1C2C0BDB3A19CF5F5F5F5F55F5C41
            292C29404A6A6FF5F5F5F5F5F5A3AEBEC2D1C6BFB5A19BF5F5F5F5F5F5F5F561
            6060656467F5F5F5F5F5F5F5F5F5F5A4A8A8A5A4A2F5F5F5F5F5}
          NumGlyphs = 2
          OnClick = PlaySoundButtonClick
        end
        object PopupColorsGroup: TGroupBox
          Left = 8
          Top = 192
          Width = 413
          Height = 145
          Anchors = [akLeft, akTop, akRight]
          Caption = ' Kleuren '
          TabOrder = 5
          object TopColorLabel: TLabel
            Left = 16
            Top = 24
            Width = 74
            Height = 13
            Caption = 'Bovenste kleur:'
          end
          object BottomColorlabel: TLabel
            Left = 16
            Top = 55
            Width = 72
            Height = 13
            Caption = 'Onderste kleur:'
          end
          object LinkLabel: TLabel
            Left = 16
            Top = 86
            Width = 46
            Height = 13
            Caption = 'Linkkleur:'
          end
          object Label4: TLabel
            Left = 16
            Top = 117
            Width = 53
            Height = 13
            Caption = 'Tekstkleur:'
          end
          object TestPopupButton: TSpeedButton
            Left = 328
            Top = 109
            Width = 75
            Height = 25
            Caption = '&Test popup'
            OnClick = TestPopupButtonClick
          end
          object TopColorBox: TColorBox
            Left = 120
            Top = 19
            Width = 145
            Height = 22
            DefaultColorColor = clMoneyGreen
            ItemHeight = 16
            TabOrder = 0
          end
          object BottomColorBox: TColorBox
            Left = 120
            Top = 50
            Width = 145
            Height = 22
            DefaultColorColor = clTeal
            ItemHeight = 16
            TabOrder = 1
          end
          object LinkColorBox: TColorBox
            Left = 120
            Top = 81
            Width = 145
            Height = 22
            DefaultColorColor = clNavy
            ItemHeight = 16
            TabOrder = 2
          end
          object TextColorbox: TColorBox
            Left = 120
            Top = 112
            Width = 145
            Height = 22
            ItemHeight = 16
            TabOrder = 3
          end
        end
        object ShowPopupCheck: TCheckBox
          Left = 8
          Top = 24
          Width = 409
          Height = 17
          Caption = 'Toon popup bij nieuwe berichten'
          TabOrder = 0
        end
        object DeleteMessageCheck: TCheckBox
          Left = 8
          Top = 48
          Width = 409
          Height = 17
          Caption = 'Verwijder bericht bij openen'
          TabOrder = 1
        end
        object DurationEdit: TJvSpinEdit
          Left = 88
          Top = 149
          Width = 57
          Height = 21
          ButtonKind = bkStandard
          TabOrder = 4
        end
        object PlaySoundCheck: TCheckBox
          Left = 8
          Top = 72
          Width = 409
          Height = 17
          Caption = 'Speel geluid af bij nieuwe berichten:'
          TabOrder = 2
        end
        object SoundEdit: TJvEdit
          Left = 24
          Top = 112
          Width = 329
          Height = 21
          EmptyValue = 'Geef hier de naam van het af te spelen bestand op'
          Modified = False
          TabOrder = 3
        end
      end
    end
    object TrackerSheet: TTabSheet
      Caption = 'TrackerSheet'
      ImageIndex = 2
      object TrackerGroup: TGroupBox
        Left = 4
        Top = 4
        Width = 425
        Height = 349
        Caption = ' Ophalen '
        TabOrder = 0
        DesignSize = (
          425
          349)
        object Label17: TLabel
          Left = 8
          Top = 56
          Width = 74
          Height = 13
          Caption = 'Controleer elke '
        end
        object Label1: TLabel
          Left = 152
          Top = 56
          Width = 40
          Height = 13
          Caption = 'minuten.'
        end
        object AutoSaveCheck: TCheckBox
          Left = 8
          Top = 24
          Width = 193
          Height = 17
          Caption = 'Gegevens automatisch opslaan'
          TabOrder = 0
        end
        object IgnoreGroup: TGroupBox
          Left = 8
          Top = 87
          Width = 409
          Height = 161
          Anchors = [akLeft, akRight, akBottom]
          Caption = ' Negeer berichten van volgende personen: '
          TabOrder = 2
          object NamesList: TListBox
            Left = 8
            Top = 48
            Width = 297
            Height = 105
            ItemHeight = 13
            MultiSelect = True
            TabOrder = 4
            OnKeyDown = NamesListKeyDown
          end
          object AddButton: TButton
            Left = 320
            Top = 24
            Width = 75
            Height = 25
            Action = AddAction
            TabOrder = 1
          end
          object DeleteButton: TButton
            Left = 320
            Top = 56
            Width = 75
            Height = 25
            Caption = 'Verwijderen'
            TabOrder = 2
            OnClick = DeleteButtonClick
          end
          object NameEdit: TJvEdit
            Left = 8
            Top = 24
            Width = 297
            Height = 21
            EmptyValue = 'Van wie wil je geen berichten ontvangen?'
            Modified = False
            TabOrder = 0
            OnKeyDown = NameEditKeyDown
          end
          object ClearButton: TButton
            Left = 320
            Top = 88
            Width = 75
            Height = 25
            Caption = 'Alles wissen'
            TabOrder = 3
            OnClick = ClearButtonClick
          end
        end
        object IntervalEdit: TJvSpinEdit
          Left = 88
          Top = 53
          Width = 57
          Height = 21
          ButtonKind = bkStandard
          TabOrder = 1
        end
      end
    end
  end
  object CategoriesGroup: TGroupBox
    Left = 8
    Top = 75
    Width = 177
    Height = 349
    Caption = ' Categorie '
    TabOrder = 0
    DesignSize = (
      177
      349)
    object ButtonGroup: TButtonGroup
      Left = 8
      Top = 16
      Width = 161
      Height = 327
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
      Items = <
        item
          Caption = 'Algemeen'
          ImageIndex = -1
        end
        item
          Caption = 'Berichten'
          ImageIndex = -1
        end
        item
          Caption = 'Popup'
          ImageIndex = -1
        end
        item
          Caption = 'Ophalen'
          ImageIndex = -1
        end>
      TabOrder = 0
      OnButtonClicked = ButtonGroupButtonClicked
    end
  end
  object ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 16
    Top = 440
    object OKAction: TAction
      Caption = 'OK'
      OnExecute = OKActionExecute
    end
    object CancelAction: TAction
      Caption = 'Annuleren'
      OnExecute = CancelActionExecute
    end
    object AddAction: TAction
      Caption = 'Toevoegen'
      OnExecute = AddActionExecute
      OnUpdate = AddActionUpdate
    end
  end
  object Notifier: TNLDNotifier
    TextColor = clBlack
    LinkColor = clBlack
    TopColor = clBlack
    BottomColor = clBlack
    Timeout = 0
    Enabled = True
    Left = 80
    Top = 440
  end
  object OpenSoundDialog: TJvOpenDialog
    DefaultExt = 'wav'
    Filter = 'Wave bestanden (*.wav)|*.wav'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofEnableSizing]
    Title = 'Selecteer wav bestand'
    Height = 432
    Width = 565
    Left = 48
    Top = 440
  end
end
