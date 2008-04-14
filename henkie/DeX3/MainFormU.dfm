object MainForm: TMainForm
  Left = 445
  Top = 170
  Width = 640
  Height = 514
  Caption = 'DeX 3'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  Visible = True
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 467
    Width = 632
    Height = 19
    Panels = <
      item
        Width = 350
      end
      item
        Width = 50
      end>
  end
  object MainPanel: TPanel
    Left = 0
    Top = 45
    Width = 632
    Height = 422
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PageControl: TPageControl
      Left = 0
      Top = 23
      Width = 632
      Height = 399
      ActivePage = TabSheet1
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object ForumSheet: TTabSheet
        Caption = 'Forum'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        object ForumList: TDeXTree
          Left = 0
          Top = 0
          Width = 624
          Height = 368
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvRaised
          BevelKind = bkFlat
          BorderStyle = bsNone
          DefaultNodeHeight = 16
          DragMode = dmAutomatic
          DragType = dtVCL
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Lucida Sans'
          Font.Style = []
          Header.AutoSizeIndex = 4
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoDblClickResize, hoDrag, hoShowSortGlyphs, hoVisible]
          Header.SortColumn = 0
          Header.SortDirection = sdDescending
          Header.Style = hsXPStyle
          HintMode = hmHintAndDefault
          Images = PostImages
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
          OnDblClick = TreesDblClick
          OnDragOver = ForumListDragOver
          OnFreeNode = ForumListFreeNode
          OnGetText = ForumListGetText
          OnGetImageIndex = ForumListGetImageIndex
          OnGetPopupMenu = TreesGetPopupMenu
          OnHeaderClick = ForumListHeaderClick
          OnHotChange = ForumListHotChange
          OnIncrementalSearch = ForumListIncrementalSearch
          OnKeyDown = TreesKeyDown
          Columns = <
            item
              MinWidth = 150
              Position = 0
              Width = 150
              WideText = 'Wanneer'
            end
            item
              Position = 1
              Width = 75
              WideText = 'Forum'
            end
            item
              Position = 2
              Width = 75
              WideText = 'Wie'
            end
            item
              Position = 3
              Width = 324
              WideText = 'Thread'
            end>
        end
      end
      object PMSheet: TTabSheet
        Caption = 'PM'
        ImageIndex = 1
        object PMList: TDeXTree
          Left = 0
          Top = 0
          Width = 581
          Height = 368
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvRaised
          BevelKind = bkFlat
          BorderStyle = bsNone
          DragMode = dmAutomatic
          DragType = dtVCL
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Lucida Sans'
          Font.Style = []
          Header.AutoSizeIndex = 3
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoDblClickResize, hoDrag, hoVisible]
          Header.SortColumn = 0
          Header.SortDirection = sdDescending
          Header.Style = hsXPStyle
          HintAnimation = hatNone
          ParentFont = False
          TabOrder = 0
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
          OnDblClick = TreesDblClick
          OnDragOver = ForumListDragOver
          OnFreeNode = PMListFreeNode
          OnGetText = PMListGetText
          OnGetPopupMenu = TreesGetPopupMenu
          OnHotChange = PMListHotChange
          OnKeyDown = TreesKeyDown
          Columns = <
            item
              Position = 0
              Width = 130
              WideText = 'Wanneer'
            end
            item
              Position = 1
              Width = 130
              WideText = 'Van'
            end
            item
              Position = 2
              Width = 321
              WideText = 'Onderwerp'
            end>
        end
      end
      object LinkSheet: TTabSheet
        Caption = 'Links'
        ImageIndex = 3
        object LinkList: TDeXTree
          Left = 0
          Top = 0
          Width = 581
          Height = 368
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvRaised
          BevelKind = bkFlat
          BorderStyle = bsNone
          DragMode = dmAutomatic
          DragType = dtVCL
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Lucida Sans'
          Font.Style = []
          Header.AutoSizeIndex = 3
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoDblClickResize, hoDrag, hoVisible]
          Header.SortColumn = 0
          Header.SortDirection = sdDescending
          Header.Style = hsXPStyle
          HintAnimation = hatNone
          HintMode = hmHintAndDefault
          ParentFont = False
          TabOrder = 0
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
          OnDblClick = TreesDblClick
          OnDragOver = ForumListDragOver
          OnFreeNode = LinkListFreeNode
          OnGetText = LinkListGetText
          OnGetPopupMenu = TreesGetPopupMenu
          OnHotChange = LinkListHotChange
          OnKeyDown = TreesKeyDown
          Columns = <
            item
              Position = 0
              Width = 130
              WideText = 'Wanneer'
            end
            item
              Position = 1
              Width = 100
              WideText = 'Sectie'
            end
            item
              Position = 2
              Width = 351
              WideText = 'Titel'
            end>
        end
      end
      object NewsSheet: TTabSheet
        Caption = 'Nieuws'
        ImageIndex = 4
        object NewsList: TDeXTree
          Left = 0
          Top = 0
          Width = 581
          Height = 368
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvRaised
          BevelKind = bkFlat
          BorderStyle = bsNone
          DragMode = dmAutomatic
          DragType = dtVCL
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Lucida Sans'
          Font.Style = []
          Header.AutoSizeIndex = 2
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoDblClickResize, hoDrag, hoVisible]
          Header.SortColumn = 0
          Header.SortDirection = sdDescending
          Header.Style = hsXPStyle
          HintAnimation = hatNone
          HintMode = hmHintAndDefault
          ParentFont = False
          TabOrder = 0
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
          OnDblClick = TreesDblClick
          OnDragOver = ForumListDragOver
          OnFreeNode = NewsListFreeNode
          OnGetText = NewsListGetText
          OnGetPopupMenu = TreesGetPopupMenu
          OnHotChange = NewsListHotChange
          OnKeyDown = TreesKeyDown
          Columns = <
            item
              Position = 0
              Width = 130
              WideText = 'Wanneer'
            end
            item
              Position = 1
              Width = 451
              WideText = 'Titel'
            end>
        end
      end
      object Favorieten: TTabSheet
        Caption = 'Favorieten'
        ImageIndex = 5
        object FavoritesList: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 624
          Height = 368
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvRaised
          BevelKind = bkFlat
          BorderStyle = bsNone
          ButtonStyle = bsTriangle
          DragMode = dmAutomatic
          DragType = dtVCL
          DrawSelectionMode = smBlendedRectangle
          EditDelay = 200
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Lucida Sans'
          Font.Style = []
          Header.AutoSizeIndex = 4
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoDblClickResize, hoDrag, hoShowSortGlyphs, hoVisible]
          Header.SortDirection = sdDescending
          Header.Style = hsXPStyle
          HintMode = hmHintAndDefault
          Images = PostImages
          IncrementalSearch = isAll
          IncrementalSearchStart = ssLastHit
          IncrementalSearchTimeout = 750
          Indent = 8
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toVariableNodeHeight]
          TreeOptions.PaintOptions = [toThemeAware, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
          TreeOptions.StringOptions = [toSaveCaptions, toShowStaticText, toAutoAcceptEditChange]
          OnBeforeCellPaint = FavoritesListBeforeCellPaint
          OnCompareNodes = FavoritesListCompareNodes
          OnContextPopup = FavoritesListContextPopup
          OnDblClick = TreesDblClick
          OnDragAllowed = FavoritesListDragAllowed
          OnDragOver = FavoritesListDragOver
          OnDragDrop = FavoritesListDragDrop
          OnEditing = FavoritesListEditing
          OnGetText = FavoritesListGetText
          OnPaintText = FavoritesListPaintText
          OnGetImageIndex = FavoritesListGetImageIndex
          OnGetNodeDataSize = FavoritesListGetNodeDataSize
          OnGetPopupMenu = TreesGetPopupMenu
          OnHeaderClick = FavoritesListHeaderClick
          OnHotChange = FavoritesListHotChange
          OnInitNode = FavoritesListInitNode
          OnKeyDown = TreesKeyDown
          OnNewText = FavoritesListNewText
          Columns = <
            item
              Position = 0
              Width = 250
              WideText = 'Thread'
            end
            item
              Position = 1
              Width = 100
              WideText = 'Wie'
            end
            item
              Position = 2
              Width = 100
              WideText = 'Forum'
            end
            item
              Position = 3
              Width = 174
              WideText = 'Wanneer'
            end>
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Website'
        ImageIndex = 4
        object SiteTree: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 624
          Height = 368
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvRaised
          BevelKind = bkFlat
          BorderStyle = bsNone
          ButtonFillMode = fmShaded
          ButtonStyle = bsTriangle
          DrawSelectionMode = smBlendedRectangle
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Lucida Sans'
          Font.Style = []
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = []
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          HintMode = hmHintAndDefault
          IncrementalSearch = isAll
          IncrementalSearchStart = ssLastHit
          IncrementalSearchTimeout = 750
          ParentFont = False
          TabOrder = 0
          TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowRoot, toUseBlendedImages, toUseBlendedSelection]
          OnBeforeCellPaint = SiteTreeBeforeCellPaint
          OnGetText = SiteTreeGetText
          OnPaintText = SiteTreePaintText
          OnGetNodeDataSize = SiteTreeGetNodeDataSize
          OnHotChange = SiteTreeHotChange
          OnMouseUp = SiteTreeMouseUp
          Columns = <>
        end
      end
    end
    object TabBar: TJvTabBar
      Left = 0
      Top = 0
      Width = 632
      CloseButton = False
      RightClickSelect = False
      Painter = JvModernTabBarPainter1
      Images = ActionImagesSmall
      Tabs = <
        item
          Caption = 'Forum'
          Selected = True
          ImageIndex = 10
        end
        item
          Caption = 'PM'
          ImageIndex = 11
        end
        item
          Caption = 'Link'
          ImageIndex = 12
        end
        item
          Caption = 'Nieuws'
          ImageIndex = 13
        end
        item
          Caption = 'Favorieten'
          ImageIndex = 14
        end
        item
          Caption = 'Website'
          ImageIndex = 15
        end>
      OnTabSelected = TabBarTabSelected
      OnDragOver = TabBarDragOver
    end
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 632
    Height = 45
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object CommandsPageScroller: TPageScroller
      Left = 0
      Top = 23
      Width = 632
      Height = 22
      Align = alClient
      Control = CommandsToolbar
      TabOrder = 0
      object CommandsToolbar: TToolBar
        Left = 0
        Top = 0
        Width = 632
        Height = 22
        Align = alClient
        AutoSize = True
        ButtonWidth = 106
        Caption = 'CommandsToolbar'
        DisabledImages = ActionImagesSmallDisabled
        EdgeBorders = []
        Flat = True
        Images = ActionImagesSmall
        List = True
        ShowCaptions = True
        TabOrder = 0
        Transparent = False
        object OpenToolbutton: TToolButton
          Left = 0
          Top = 0
          Action = OpenAction
          AutoSize = True
        end
        object FetchToolbutton: TToolButton
          Left = 60
          Top = 0
          Action = FetchDataAction
          AutoSize = True
        end
        object SaveToolbutton: TToolButton
          Left = 170
          Top = 0
          Action = SaveAction
          AutoSize = True
        end
        object DeleteToolbutton: TToolButton
          Left = 240
          Top = 0
          Action = DeleteAction
          AutoSize = True
        end
        object ToolButton6: TToolButton
          Left = 326
          Top = 0
          Width = 8
          Caption = 'ToolButton6'
          ImageIndex = 17
          Style = tbsSeparator
        end
        object NewGroupToolbutton: TToolButton
          Left = 334
          Top = 0
          Action = NewGroupAction
          AutoSize = True
        end
        object ToolButton7: TToolButton
          Left = 440
          Top = 0
          Width = 8
          Caption = 'ToolButton7'
          ImageIndex = 17
          Style = tbsSeparator
        end
        object SettingsToolbutton: TToolButton
          Left = 448
          Top = 0
          Action = SettingsAction
          AutoSize = True
        end
        object InfoToolbutton: TToolButton
          Left = 532
          Top = 0
          Action = InfoAction
          AutoSize = True
        end
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 632
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object MenuPageScroller: TPageScroller
        Left = 0
        Top = 0
        Width = 473
        Height = 23
        Align = alClient
        Control = MenuToolbar
        TabOrder = 0
        object MenuToolbar: TToolBar
          Left = 0
          Top = 0
          Width = 164
          Height = 23
          Align = alLeft
          AutoSize = True
          ButtonWidth = 66
          Caption = 'MenuToolbar'
          DisabledImages = ActionImagesSmallDisabled
          EdgeBorders = []
          Flat = True
          Images = ActionImagesSmall
          List = True
          ShowCaptions = True
          TabOrder = 0
          object FileToolbutton: TToolButton
            Left = 0
            Top = 0
            AutoSize = True
            Caption = 'Bestand'
            Grouped = True
            MenuItem = Bestand1
          end
          object ServerToolButton: TToolButton
            Left = 50
            Top = 0
            AutoSize = True
            Caption = 'Server'
            Grouped = True
            MenuItem = Server1
          end
          object NodeToolButton: TToolButton
            Left = 92
            Top = 0
            AutoSize = True
            Caption = 'Regel'
            Grouped = True
            MenuItem = Regel1
          end
          object HelpToolButton: TToolButton
            Left = 131
            Top = 0
            AutoSize = True
            Caption = 'Help'
            Grouped = True
            MenuItem = Help1
          end
        end
      end
      object SearchPanel: TPanel
        Left = 473
        Top = 0
        Width = 159
        Height = 23
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          159
          23)
        object EraseButton: TSpeedButton
          Left = 125
          Top = 0
          Width = 33
          Height = 21
          Hint = 'Wis zoektekst'
          Anchors = [akTop, akRight]
          Enabled = False
          Flat = True
          Glyph.Data = {
            36060000424D3606000000000000360000002800000020000000100000000100
            18000000000000060000C40E0000C40E00000000000000000000DC00FF9266C1
            4753854F298FDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00
            FFDC00FFDC00FFDC00FFDC00FF8686866060604B4B4BDC00FFDC00FFDC00FFDC
            00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF8A6BB17479AE
            5B62A5555DA6533790BA05DEDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00
            FFDC00FFDC00FFDC00FF8383838888887575757171715454545A5A5ADC00FFDC
            00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF8788B39F9FDB
            7677C14F4FA15F5E9B50396CB214CBDC00FFDC00FFDC00FFDC00FFDC00FFDC00
            FFDC00FFDC00FFDC00FF949494B0B0B08D8D8DB4B4B47070704A4A4A5C5C5CDC
            00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF7878A0BAB8E9
            A4A1E17E7AC14946758782919485889F2AA7DC00FFDC00FFDC00FFDC00FFDC00
            FFDC00FFDC00FFDC00FF838383C6C6C6B4B4B48F8F8F5454548787878787875C
            5C5CDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF807AA5
            ADADD78888B2999DAFA1A296B3AE927F79598F2592DC00FFDC00FFDC00FFDC00
            FFDC00FFDC00FFDC00FFDC00FF878787B9B9B9949494A1A1A19E9E9EA6A6A670
            7070515151DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF
            6E6483ACB5BBD2DDCECED5AE7F7E488B8351ADA78E84428EDC00FFDC00FFDC00
            FFDC00FFDC00FFDC00FFDC00FFDC00FF6E6E6EB5B5B5D7D7D7C8C8C86D6D6D74
            7474A0A0A0606060DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF
            DC00FF9A86A0B4C6A7B2C18EBEC38ABBC08DA4AF99748790594489BC04E2DC00
            FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF909090BABABAB0B0B0B1B1B1B0
            B0B0A7A7A78787875B5B5B5B5B5BDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF
            DC00FFDC00FF875F85B1BC9AE0EDC5CAE7C16093884287984088A9475999AB0B
            D7DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF6E6E6EB0B0B0DFDFDFD8
            D8D88989898484848989896A6A6A5A5A5ADC00FFDC00FFDC00FFDC00FFDC00FF
            DC00FFDC00FFDC00FFA153AC9DB3A783BEB354C1C720ACC9099AC21D92B52E83
            959723C5DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF767676ACACACB3
            B3B3B6B6B6A4A4A49595958F8F8F7E7E7E606060DC00FFDC00FFDC00FFDC00FF
            DC00FFDC00FFDC00FFDC00FF9C41BE75A8B672E7F032CBE006ADD108A0BE2099
            AC478AA09446CCDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF707070A6
            A6A6DCDCDCBFBFBFA4A4A4979797909090888888767676DC00FFDC00FFDC00FF
            DC00FFDC00FFDC00FFDC00FFDC00FFA153AC9DB3A780E7F443CBDC14AEC213A7
            BE168FAF3693BA8C72E2DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF76
            7676ACACACDFDFDFC0C0C0A2A2A29D9D9D8A8A8A949494969696DC00FFDC00FF
            DC00FFDC00FFDC00FFDC00FFDC00FFDC00FF9C41BE75A8B67CD8E25AD1E230B1
            C92EA8C6248FB36BBCDEDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC
            00FF707070A6A6A6D0D0D0C8C8C8A9A9A9A3A3A38D8D8DBCBCBCDC00FFDC00FF
            DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFA21ECA676EAD8ADAE96FD2
            E642ADC33BA4BD69C0D7DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC
            00FFDC00FF606060808080D5D5D5CCCCCCA7A7A79F9F9FBCBCBCDC00FFDC00FF
            DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF9C41BE7156AE7CC0
            D189DCEB63BDCC79C7D6DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC
            00FFDC00FFDC00FF707070737373BDBDBDD7D7D7B7B7B7C2C2C2DC00FFDC00FF
            DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFA21ECA833C
            B783B9C99DC1E4DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC
            00FFDC00FFDC00FFDC00FF606060B4B4B4B7B7B7C7C7C7DC00FFDC00FFDC00FF
            DC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00
            FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC
            00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FFDC00FF}
          NumGlyphs = 2
          OnClick = EraseButtonClick
        end
        object SearchEdit: TJvEdit
          Left = 4
          Top = 0
          Width = 121
          Height = 21
          EmptyValue = 'Zoek naar thread'
          Flat = False
          ParentFlat = False
          Modified = False
          Anchors = [akTop, akRight]
          AutoSize = False
          HideSelection = False
          TabOrder = 0
          OnChange = SearchEditChange
        end
      end
    end
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = FetchDataAction
            Caption = '&Ophalen vanaf...'
          end>
      end
      item
        Items = <
          item
            Action = FetchDataAction
            Caption = '&Ophalen vanaf...'
          end
          item
            Action = DeleteAction
            Caption = '&Verwijderen'
            ShortCut = 46
          end
          item
            Action = DeleteThreadAction
            Caption = 'V&erwijder thread'
            ShortCut = 16430
          end>
      end
      item
        Items = <
          item
            Action = FetchDataAction
            Caption = '&Ophalen vanaf...'
          end
          item
            Action = DeleteAction
            Caption = '&Verwijderen'
            ShortCut = 46
          end
          item
            Action = DeleteThreadAction
            Caption = 'V&erwijder thread'
            ShortCut = 16430
          end>
      end
      item
        Items = <
          item
            Items = <
              item
                Action = LoginAction
                Caption = 'Aa&nmelden...'
              end
              item
                Action = FetchDataAction
                Caption = '&Ophalen vanaf...'
              end
              item
                Action = SettingsAction
                Caption = '&Instellingen'
              end
              item
                Action = SaveAction
                Caption = 'O&pslaan'
                ShortCut = 16467
              end
              item
                Action = HideAction
                Caption = '&Verbergen'
                ShortCut = 32837
              end
              item
                Caption = '-'
              end
              item
                Action = CloseAction
                Caption = '&Afsluiten'
              end>
            Caption = '&Bestand'
          end
          item
            Items = <
              item
                Action = OpenAction
                ShortCut = 13
              end
              item
                Action = DeleteAction
                Caption = '&Verwijderen'
                ShortCut = 46
              end
              item
                Action = DeleteThreadAction
                Caption = 'V&erwijder thread'
                ShortCut = 16430
              end>
            Caption = '&Regel'
          end
          item
            Items = <
              item
                Action = InfoAction
                Caption = '&Info'
              end>
            Caption = '&Help'
          end>
      end
      item
        Items = <
          item
            Action = FetchDataAction
            Caption = '&Ophalen vanaf...'
            ImageIndex = 3
          end
          item
            Action = DeleteAction
            Caption = '&Verwijderen'
            ShortCut = 46
          end
          item
            Action = DeleteThreadAction
            Caption = 'V&erwijder thread'
            ShortCut = 16430
          end
          item
            Action = OpenAction
            ShortCut = 13
          end
          item
            Action = InfoAction
            Caption = '&Info'
          end>
      end
      item
        Items = <
          item
            Action = OpenAction
            ImageIndex = 3
            ShortCut = 13
          end
          item
            Action = DeleteAction
            Caption = '&Verwijderen'
            ImageIndex = 6
            ShortCut = 46
          end
          item
            Action = FetchDataAction
            Caption = 'O&phalen vanaf...'
            ImageIndex = 7
          end
          item
            Action = SaveAction
            Caption = 'Op&slaan'
            ImageIndex = 8
            ShortCut = 16467
          end
          item
            Action = HideAction
            Caption = 'V&erbergen'
            ImageIndex = 5
            ShortCut = 32837
          end
          item
            Action = InfoAction
            Caption = '&Info'
            ImageIndex = 1
          end>
      end
      item
        Items = <
          item
            Action = SaveAction
            Caption = 'O&pslaan'
            ImageIndex = 8
            ShortCut = 16467
          end
          item
            Action = HideAction
            Caption = '&Verbergen'
            ImageIndex = 5
            ShortCut = 32837
          end
          item
            Action = CloseAction
            Caption = '&Afsluiten'
            ImageIndex = 4
          end
          item
            Action = InfoAction
            Caption = '&Info'
            ImageIndex = 1
          end
          item
            Action = OpenAction
            ImageIndex = 3
            ShortCut = 13
          end
          item
            Action = DeleteThreadAction
            Caption = 'Ve&rwijder thread'
            ShortCut = 16430
          end
          item
            Action = DeleteAction
            Caption = 'V&erwijderen'
            ImageIndex = 6
            ShortCut = 46
          end
          item
            Action = FetchDataAction
            Caption = '&Ophalen vanaf...'
            ImageIndex = 7
          end>
      end
      item
        Items = <
          item
            Action = OpenAction
            ImageIndex = 5
            ShortCut = 13
          end
          item
            Action = FetchDataAction
            Caption = 'O&phalen vanaf...'
            ImageIndex = 1
          end
          item
            Action = NewGroupAction
            ImageIndex = 16
          end
          item
            Action = SaveAction
            Caption = 'Op&slaan'
            ImageIndex = 3
            ShortCut = 16467
          end
          item
            Action = DeleteAction
            Caption = '&Verwijderen'
            ImageIndex = 6
            ShortCut = 46
          end
          item
            Action = SettingsAction
            ImageIndex = 2
          end
          item
            Action = HideAction
            Caption = 'V&erbergen'
            ImageIndex = 4
            ShortCut = 32837
          end
          item
            Action = InfoAction
            Caption = '&Info'
            ImageIndex = 7
          end>
        Visible = False
      end
      item
        Items = <
          item
            Items = <
              item
                Action = SettingsAction
                Caption = '&Instellingen'
                ImageIndex = 2
              end
              item
                Action = HideAction
                Caption = '&Verbergen'
                ImageIndex = 4
                ShortCut = 32837
              end
              item
                Action = CloseAction
                Caption = '&Afsluiten'
              end>
            Caption = '&Bestand'
          end
          item
            Items = <
              item
                Action = FetchDataAction
                Caption = '&Ophalen vanaf...'
                ImageIndex = 1
              end
              item
                Action = LoginAction
                Caption = '&Aanmelden...'
                ImageIndex = 0
              end>
            Caption = '&Server'
          end
          item
            Items = <
              item
                Action = OpenAction
                Caption = '&Lezen'
                ImageIndex = 5
                ShortCut = 13
              end
              item
                Action = DeleteAction
                Caption = '&Verwijderen'
                ImageIndex = 6
                ShortCut = 46
              end
              item
                Action = DeleteThreadAction
                Caption = 'V&erwijder thread'
                ShortCut = 16430
              end
              item
                Action = SaveAction
                Caption = '&Opslaan'
                ImageIndex = 3
                ShortCut = 16467
              end
              item
                Action = AddToFavoritesAction
                Caption = '&Toevoegen aan favorieten'
              end>
            Caption = '&Regel'
          end
          item
            Items = <
              item
                Action = InfoAction
                Caption = '&Info'
                ImageIndex = 7
              end>
            Caption = '&Help'
          end>
      end
      item
        Items = <
          item
            Items = <
              item
                Action = SettingsAction
                Caption = '&Instellingen'
                ImageIndex = 2
              end
              item
                Action = HideAction
                Caption = '&Verbergen'
                ImageIndex = 4
                ShortCut = 32837
              end
              item
                Action = CloseAction
                Caption = '&Afsluiten'
              end>
            Caption = '&Bestand'
          end
          item
            Items = <
              item
                Action = FetchDataAction
                Caption = '&Ophalen vanaf...'
                ImageIndex = 1
              end
              item
                Action = LoginAction
                Caption = '&Aanmelden...'
                ImageIndex = 0
              end>
            Caption = '&Server'
          end
          item
            Items = <
              item
                Action = OpenAction
                Caption = '&Lezen'
                ImageIndex = 5
                ShortCut = 13
              end
              item
                Action = DeleteAction
                Caption = '&Verwijderen'
                ImageIndex = 6
                ShortCut = 46
              end
              item
                Action = DeleteThreadAction
                Caption = 'V&erwijder thread'
                ShortCut = 16430
              end
              item
                Action = SaveAction
                Caption = '&Opslaan'
                ImageIndex = 3
                ShortCut = 16467
              end
              item
                Action = AddToFavoritesAction
                Caption = '&Toevoegen aan favorieten'
              end>
            Caption = '&Regel'
          end
          item
            Items = <
              item
                Action = InfoAction
                Caption = '&Info'
                ImageIndex = 7
              end>
            Caption = '&Help'
          end>
      end
      item
        Items = <
          item
            Items = <
              item
                Action = SettingsAction
                Caption = '&Instellingen'
                ImageIndex = 2
              end
              item
                Action = HideAction
                Caption = '&Verbergen'
                ImageIndex = 4
                ShortCut = 32837
              end
              item
                Action = CloseAction
                Caption = '&Afsluiten'
              end>
            Caption = '&Bestand'
          end
          item
            Items = <
              item
                Action = FetchDataAction
                Caption = '&Ophalen vanaf...'
                ImageIndex = 1
              end
              item
                Action = LoginAction
                Caption = '&Aanmelden...'
                ImageIndex = 0
              end>
            Caption = '&Server'
          end
          item
            Items = <
              item
                Action = OpenAction
                Caption = '&Lezen'
                ImageIndex = 5
                ShortCut = 13
              end
              item
                Action = DeleteAction
                Caption = '&Verwijderen'
                ImageIndex = 6
                ShortCut = 46
              end
              item
                Action = DeleteThreadAction
                Caption = 'V&erwijder thread'
                ShortCut = 16430
              end
              item
                Action = SaveAction
                Caption = '&Opslaan'
                ImageIndex = 3
                ShortCut = 16467
              end
              item
                Action = AddToFavoritesAction
                Caption = '&Toevoegen aan favorieten'
              end>
            Caption = '&Regel'
          end
          item
            Items = <
              item
                Action = InfoAction
                Caption = '&Info'
                ImageIndex = 7
              end>
            Caption = '&Help'
          end>
      end>
    Images = ActionImagesSmall
    OnUpdate = ActionManagerUpdate
    Left = 72
    Top = 152
    StyleName = 'Standard'
    object LoginAction: TAction
      Category = 'Server'
      Caption = 'Aanmelden...'
      Hint = 
        'Meld je aan bij de server, zo kan je de geposte berichten ontvan' +
        'gen.'
      ImageIndex = 0
      OnExecute = LoginActionExecute
    end
    object FetchDataAction: TAction
      Category = 'Server'
      Caption = 'Ophalen vanaf...'
      Hint = 'Regels ophalen vanaf een bepaalde datum/tijd'
      ImageIndex = 1
      OnExecute = FetchDataActionExecute
    end
    object OpenAction: TAction
      Category = 'Regel'
      Caption = 'Lezen'
      Enabled = False
      ImageIndex = 5
      ShortCut = 13
      OnExecute = OpenActionExecute
      OnUpdate = OpenActionUpdate
    end
    object DeleteAction: TAction
      Category = 'Regel'
      Caption = 'Verwijderen'
      Enabled = False
      Hint = 'Verwijder geselecteerde regels'
      ImageIndex = 6
      ShortCut = 46
      OnExecute = DeleteActionExecute
      OnUpdate = DeleteActionUpdate
    end
    object DeleteThreadAction: TAction
      Category = 'Regel'
      Caption = 'Verwijder thread'
      Enabled = False
      ShortCut = 16430
      OnExecute = DeleteThreadActionExecute
    end
    object InfoAction: TAction
      Category = 'Help'
      Caption = 'Info'
      ImageIndex = 7
      OnExecute = InfoActionExecute
    end
    object SettingsAction: TAction
      Category = 'Bestand'
      Caption = 'Instellingen'
      ImageIndex = 2
      OnExecute = SettingsActionExecute
    end
    object SaveAction: TAction
      Category = 'Regel'
      Caption = 'Opslaan'
      ImageIndex = 3
      ShortCut = 16467
      OnExecute = SaveActionExecute
    end
    object HideAction: TAction
      Category = 'Bestand'
      Caption = 'Verbergen'
      ImageIndex = 4
      ShortCut = 32837
      OnExecute = HideActionExecute
    end
    object CloseAction: TAction
      Category = 'Bestand'
      Caption = 'Afsluiten'
      OnExecute = CloseActionExecute
    end
    object AddToFavoritesAction: TAction
      Tag = -1
      Category = 'Regel'
      Caption = 'Toevoegen aan favorieten'
      OnExecute = AddToFavoritesActionExecute
      OnUpdate = AddToFavoritesActionUpdate
    end
    object NewGroupAction: TAction
      Category = 'Favorieten'
      Caption = 'Nieuwe groep...'
      ImageIndex = 16
      OnExecute = NewGroupActionExecute
      OnUpdate = NewGroupActionUpdate
    end
    object ExpandCollapseGroupAction: TAction
      Category = 'Favorieten'
      Caption = 'Uitklappen'
      ImageIndex = 8
      Visible = False
      OnExecute = ExpandCollapseGroupActionExecute
    end
    object SelectForumTabAction: TAction
      Category = 'Shortcuts'
      Caption = 'SelectForumTabAction'
      ShortCut = 32838
      OnExecute = SelectForumTabActionExecute
    end
    object SelectPMTabAction: TAction
      Category = 'Shortcuts'
      Caption = 'SelectPMTabAction'
      ShortCut = 32848
      OnExecute = SelectPMTabActionExecute
    end
    object SelectLinkTabAction: TAction
      Category = 'Shortcuts'
      Caption = 'SelectLinkTabAction'
      ShortCut = 32844
      OnExecute = SelectLinkTabActionExecute
    end
    object SelectNewsTabAction: TAction
      Category = 'Shortcuts'
      Caption = 'SelectNewsTabAction'
      ShortCut = 32846
      OnExecute = SelectNewsTabActionExecute
    end
    object SelectFavoritesTabAction: TAction
      Category = 'Shortcuts'
      Caption = 'SelectFavoritesTabAction'
      ShortCut = 32833
      OnExecute = SelectFavoritesTabActionExecute
    end
    object SelectWebsiteTabAction: TAction
      Category = 'Shortcuts'
      Caption = 'SelectWebsiteTabAction'
      ShortCut = 32855
      OnExecute = SelectWebsiteTabActionExecute
    end
  end
  object TrayIcon: TJvTrayIcon
    Active = True
    Icon.Data = {
      0000010001001010100000000000280100001600000028000000100000002000
      00000100040000000000C0000000000000000000000000000000000000000000
      0000000080000080000000808000800000008000800080800000C0C0C0008080
      80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCCC
      CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      CCCCCCCCCCCCCCCCCCCCCCCCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF99999999999999999999
      9999999999999999999999999999999999999999999999999999999999990000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    IconIndex = -1
    PopupMenu = TrayPopup
    Visibility = [tvVisibleTaskList, tvAutoHide, tvRestoreDbClick, tvMinimizeDbClick, tvAnimateToTray]
    OnDblClick = TrayIconDblClick
    Left = 352
    Top = 140
  end
  object ActionImagesSmallDisabled: TImageList
    Left = 192
    Top = 180
    Bitmap = {
      494C010111001400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000077777700777777007777
      7700777777007777770077777700777777007777770077777700777777007777
      7700777777007777770000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077777700BFBFBF0077777700E8E8
      E800C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0009E9E9E00E6E6E60077777700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077777700C4C4C40077777700E7E7
      E700C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8
      C8009E9E9E00E6E6E60077777700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077777700CBCBCB0077777700E6E6
      E600D0D0D000D0D0D000D0D0D000D0D0D000D0D0D000D0D0D000D0D0D000D0D0
      D0009E9E9E00E8E8E80077777700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077777700D0D0D00077777700E8E8
      E800D7D7D700D7D7D700D7D7D700D7D7D700D7D7D700D7D7D700D7D7D700D7D7
      D700A7A7A700EAEAEA0077777700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077777700D7D7D70077777700EAEA
      EA00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00A7A7A700EAEAEA0077777700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077777700DCDCDC0077777700EFEF
      EF00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00CBCBCB00EFEFEF0077777700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077777700E1E1E100777777007777
      7700777777007777770077777700777777007777770077777700777777007777
      7700777777007777770077777700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077777700E8E8E800E8E8E800E8E8
      E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8
      E800767676000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000077777700EFEFEF00EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00767676000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000077777700EFEFEF00E9E9
      E900E9E9E900E9E9E90077777700777777007777770077777700777777007777
      7700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000777777007777
      7700777777007777770000000000000000000000000000000000000000000000
      0000000000004C4C4C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004C4C4C004C4C4C004C4C4C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004C4C4C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C00AEAEAE00CDCDCD00C3C3C3008F8F8F0064646400A4A4A4009C9C9C00AEAE
      AE00CDCDCD00C3C3C3008F8F8F00646464003F3F3F0078787800515151007E7E
      7E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000787878007878
      7800787878007878780000000000000000000000000000000000787878007878
      7800787878007878780000000000000000001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D000000000000000000B1B1B100CDCD
      CD009E9E9E0085858500A3A3A300262626002424240024242400242424005B5B
      5B0085858500A3A3A300B6B6B6009393930078787800CDCDCD00B1B1B100B1B1
      B100313131000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007A7A7A00C3C3
      C3009F9F9F007A7A7A007A7A7A0000000000000000007A7A7A007A7A7A009F9F
      9F00C3C3C3007A7A7A0000000000000000001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D00000000000000000099999900FFFF
      FF0040404000DADADA00BDBDBD00FFFFFF00F6F6F600E8E8E800D8D8D800CECE
      CE0086868600E2E2E200A0A0A000CDCDCD0098989800E9E9E900CDCDCD003131
      31005D5D5D003131310000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007D7D7D00B4B4
      B400C5C5C500B4B4B4007D7D7D007D7D7D007D7D7D007D7D7D00B4B4B400C5C5
      C500B4B4B4007D7D7D0000000000000000001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D000000000000000000B4B4B400DDDD
      DD008C8C8C003B3B3B004444440093939300AEAEAE00A3A3A300B8B8B800A8A8
      A8005959590066666600A8A8A800ADADAD00B1B1B100E9E9E900484848006E6E
      6E005D5D5D005D5D5D0031313100000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00A5A5
      A500C5C5C500C5C5C500C5C5C500B7B7B700B7B7B700C5C5C500C5C5C500C5C5
      C500A5A5A5007F7F7F0000000000000000001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D000000000000000000C5C5C500A8A8
      A800D6D6D600F6F6F600F1F1F100BDBDBD007F7F7F0064646400A3A3A300D6D6
      D600F6F6F600F1F1F100BDBDBD008E8E8E00000000005D5D5D00A1A1A1008888
      88006E6E6E005D5D5D005D5D5D00313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000828282008282
      8200C4C4C400BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00C4C4
      C400828282008282820000000000000000001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D000000000000000000A4A4A4008484
      84008C8C8C009292920088888800747474005F5F5F0059595900666666008E8E
      8E00A0A0A0009C9C9C00B1B1B1000000000000000000000000005D5D5D00A1A1
      A100888888006E6E6E005D5D5D005D5D5D003131310000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008585
      8500C0C0C000B7B7B700B3B3B300B3B3B300B3B3B300B3B3B300B7B7B700C0C0
      C000858585000000000000000000000000001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D
      1D001D1D1D001D1D1D001D1D1D001D1D1D0000000000000000008C8C8C009393
      93008B8B8B006A6A6A0075757500757575006D6D6D00727272005D5D5D005252
      5200000000000000000000000000000000000000000000000000000000005D5D
      5D00A1A1A100888888006E6E6E005D5D5D005D5D5D0031313100000000000000
      0000000000000000000000000000000000000000000000000000898989008989
      8900C5C5C500B1B1B100ACACAC00ACACAC00ACACAC00ACACAC00B1B1B100C5C5
      C50089898900898989000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000B4B4B400969696009696
      960065656500777777008585850081818100868686007B7B7B005A5A5A005D5D
      5D007E7E7E000000000000000000000000000000000000000000000000000000
      00005D5D5D00A1A1A100888888006E6E6E005D5D5D005D5D5D00313131000000
      000000000000000000000000000000000000000000008D8D8D008D8D8D00CACA
      CA00C2C2C200ACACAC00A5A5A500A5A5A500A5A5A500A5A5A500ACACAC00C2C2
      C200CACACA008D8D8D008D8D8D0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000009E9E9E009C9C9C007777
      7700787878008383830081818100949494008B8B8B0081818100727272006A6A
      6A00585858000000000000000000000000000000000000000000000000000000
      0000000000005D5D5D00A1A1A100888888006E6E6E005D5D5D005D5D5D003131
      3100000000000000000000000000000000009191910091919100D0D0D000CCCC
      CC00C9C9C900D1D1D100DCDCDC00E2E2E200E2E2E200DCDCDC00D1D1D100C9C9
      C900CCCCCC00D0D0D0009191910091919100FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000A2A2A2008F8F8F007C7C
      7C00999999009E9E9E008C8C8C00939393008D8D8D008B8B8B00757575006F6F
      6F00595959000000000000000000000000000000000000000000000000000000
      000000000000000000005D5D5D00A1A1A100888888006E6E6E005D5D5D005D5D
      5D003131310000000000000000000000000095959500FBFBFB00F3F3F300EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00EAEAEA00F3F3F300FBFBFB0095959500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000BABABA00838383009292
      9200B0B0B000C3C3C300C2C2C200B7B7B7008E8E8E0091919100818181007171
      7100888888000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005D5D5D00A1A1A100888888006E6E6E005D5D
      5D005D5D5D003131310000000000000000009898980098989800989898009898
      980098989800C4C4C400F0F0F000F0F0F000F0F0F000F0F0F000C4C4C4009898
      980098989800989898009898980098989800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000D2D2D200969696009797
      9700BBBBBB00D7D7D700E2E2E200EBEBEB00CCCCCC0084848400848484007171
      7100EBEBEB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005D5D5D00A1A1A100888888006E6E
      6E005D5D5D005D5D5D0066666600000000000000000000000000000000000000
      0000000000009C9C9C00F4F4F400F4F4F400F4F4F400F4F4F4009C9C9C000000
      0000000000000000000000000000000000004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C000000000000000000BABABA00A2A2
      A200B4B4B400D7D7D700E9E9E90093939300B6B6B6008B8B8B006F6F6F009999
      9900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005D5D5D00A1A1A1008888
      88006E6E6E0088888800BBBBBB00666666000000000000000000000000000000
      0000000000009E9E9E00CBCBCB00F8F8F800F8F8F800CBCBCB009E9E9E000000
      0000000000000000000000000000000000004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C00000000000000000000000000BABA
      BA00ABABAB00B9B9B900BCBCBC00BDBDBD009B9B9B0081818100A4A4A4000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005D5D5D00A1A1
      A100AAAAAA00CCCCCC0088888800606060000000000000000000000000000000
      00000000000000000000A1A1A100FBFBFB00FBFBFB00A1A1A100000000000000
      0000000000000000000000000000000000004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C000000000000000000000000000000
      0000D2D2D200BABABA00A2A2A2009E9E9E00B1B1B100D2D2D200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009999
      9900DDDDDD00AAAAAA0089898900606060000000000000000000000000000000
      00000000000000000000A4A4A400CFCFCF00CFCFCF00A4A4A400000000000000
      0000000000000000000000000000000000004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000999999009393930093939300000000000000000000000000000000000000
      00000000000000000000A5A5A500A5A5A500A5A5A500A5A5A500000000000000
      0000000000000000000000000000000000004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C4C004C4C
      4C004C4C4C004C4C4C004C4C4C004C4C4C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F8F8F0096969600A0A0
      A000ACACAC00B6B6B600BDBDBD00BDBDBD00B6B6B600ACACAC00A0A0A0009696
      96008F8F8F00000000000000000000000000000000008F8F8F0096969600A0A0
      A000ACACAC00B6B6B600BDBDBD00BDBDBD00B6B6B600ACACAC00A0A0A0009696
      96008F8F8F000000000000000000000000000000000000000000000000006A6A
      6A0070707000767676007C7C7C0080808000808080007C7C7C00767676007070
      70006A6A6A000000000000000000000000000000000000000000000000006A6A
      6A0070707000767676007C7C7C0080808000808080007C7C7C00767676007070
      70006A6A6A0000000000000000000000000091919100BEBEBE00EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00BEBEBE0091919100000000000000000091919100BEBEBE00EAEAEA00EAEA
      EA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00BEBEBE009191910000000000000000000000000000000000818181009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999008181810000000000000000000000000000000000818181009999
      9900999999009999990099999900999999009999990099999900999999009999
      99009999990081818100000000000000000094949400ECECEC00ECECEC00ECEC
      EC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC009494
      9400ECECEC0094949400000000000000000094949400ECECEC00ECECEC00ECEC
      EC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC009494
      9400ECECEC00949494000000000000000000000000006C6C6C009C9C9C009C9C
      9C009C9C9C009C9C9C00929292008E8E8E008E8E8E00929292009C9C9C009C9C
      9C009C9C9C009C9C9C006C6C6C0000000000000000006C6C6C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C006C6C6C000000000097979700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009797
      9700EDEDED0097979700000000000000000097979700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009797
      9700EDEDED00979797000000000000000000000000006F6F6F00A0A0A000A0A0
      A000A0A0A000A0A0A00091919100EAEAEA00EAEAEA0091919100A0A0A000A0A0
      A000A0A0A000A0A0A0006F6F6F0000000000000000006F6F6F00A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A0006F6F6F00000000009A9A9A00A0A0A000A9A9A900B4B4
      B400BEBEBE00C4C4C400C4C4C400BEBEBE00B4B4B400A9A9A900A0A0A000AFAF
      AF00EEEEEE009A9A9A0000000000000000009A9A9A00A0A0A000A9A9A900B4B4
      B400BEBEBE00C4C4C400C4C4C400BEBEBE00B4B4B400A9A9A900A0A0A000AFAF
      AF00EEEEEE009A9A9A0000000000000000000000000074747400A5A5A500A5A5
      A500A5A5A500A5A5A50095959500ECECEC00ECECEC0095959500A5A5A500A5A5
      A500A5A5A500A5A5A50074747400000000000000000074747400A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A500A5A5A500747474000000000000000000000000009E9E9E00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0009E9E9E00000000000000000000000000000000009E9E9E00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0009E9E9E0000000000000000000000000078787800AAAAAA009D9D
      9D00999999009999990099999900EFEFEF00EFEFEF0099999900999999009999
      99009D9D9D00AAAAAA0078787800000000000000000078787800AAAAAA009D9D
      9D00999999009999990099999900999999009999990099999900999999009999
      99009D9D9D00AAAAAA0078787800000000000000000000000000A2A2A200F1F1
      F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1
      F100F1F1F100A2A2A20000000000000000000000000000000000A2A2A2009797
      9700BFBFBF00F1F1F100F1F1F10097979700BFBFBF00F1F1F100EDEDED007171
      7100E8E8E800A2A2A2000000000000000000000000007D7D7D00B0B0B0009D9D
      9D00F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3
      F3009D9D9D00B0B0B0007D7D7D0000000000000000007D7D7D00B0B0B0009D9D
      9D00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA009D9D9D00B0B0B0007D7D7D00000000000000000000000000A6A6A600F4F4
      F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400A6A6A60000000000000000000000000000000000A6A6A6009999
      9900C0C0C000F4F4F400F4F4F40099999900C0C0C0009D9D9D00DBDBDB007171
      7100E9E9E900A6A6A60000000000000000000000000082828200B5B5B500A1A1
      A100F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
      F600A1A1A100B5B5B50082828200000000000000000082828200B5B5B500A1A1
      A100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A1A1A100B5B5B50082828200000000000000000000000000ABABAB00F5F5
      F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500ABABAB0000000000000000000000000000000000ABABAB009595
      95000000000000000000A1A1A1009A9A9A00B9B9B90044444400A8A8A8007272
      7200EBEBEB00ABABAB0000000000000000000000000087878700BBBBBB00ABAB
      AB00A6A6A600A6A6A600A6A6A600FAFAFA00FAFAFA00A6A6A600A6A6A600A6A6
      A600ABABAB00BBBBBB0087878700000000000000000087878700BBBBBB00ABAB
      AB00A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600ABABAB00BBBBBB0087878700000000000000000000000000AFAFAF00F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700AFAFAF0000000000000000000000000000000000AFAFAF009C9C
      9C00C3C3C300EFEFEF006C6C6C009C9C9C0063636300BFBFBF006F6F6F006868
      6800EDEDED00AFAFAF000000000000000000000000008B8B8B00C0C0C000C0C0
      C000C0C0C000C0C0C000A9A9A900FCFCFC00FCFCFC00A9A9A900C0C0C000C0C0
      C000C0C0C000C0C0C0008B8B8B0000000000000000008B8B8B00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0008B8B8B00000000000000000000000000B3B3B300F9F9
      F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9
      F900F9F9F900B3B3B30000000000000000000000000000000000B3B3B3009898
      980000000000000000007C7C7C00989898004F4F4F00F9F9F900BDBDBD003131
      3100EEEEEE00B3B3B30000000000000000000000000090909000C5C5C500C5C5
      C500C5C5C500C5C5C500ADADAD00FFFFFF00FFFFFF00ADADAD00C5C5C500C5C5
      C500C5C5C500C5C5C50090909000000000000000000090909000C5C5C500C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C50090909000000000000000000000000000B7B7B700FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00B7B7B70000000000000000000000000000000000B7B7B700FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00B7B7B70000000000000000000000000093939300C9C9C900C9C9
      C900C9C9C900C9C9C900B6B6B600B0B0B000B0B0B000B6B6B600C9C9C900C9C9
      C900C9C9C900C9C9C90093939300000000000000000093939300C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C90093939300000000000000000000000000BABABA00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00A4A4A40000000000000000000000000000000000BABABA00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00A4A4A40000000000000000000000000000000000B2B2B200CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00B2B2B20000000000000000000000000000000000B2B2B200CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00B2B2B20000000000000000000000000000000000BDBDBD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FFFF
      FF00FFFFFF008F8F8F0000000000000000000000000000000000BDBDBD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD008F8F8F0000000000000000000000000000000000000000009D9D
      9D00A3A3A300A9A9A900AFAFAF00B3B3B300B3B3B300AFAFAF00A9A9A900A3A3
      A3009D9D9D000000000000000000000000000000000000000000000000009D9D
      9D00A3A3A300A9A9A900AFAFAF00B3B3B300B3B3B300AFAFAF00A9A9A900A3A3
      A3009D9D9D000000000000000000000000000000000000000000C0C0C000E0E0
      E000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E0E0E000000000000000000000000000C0C0C000E0E0
      E000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E0E0E000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C2C2
      C200C7C7C700CECECE00D5D5D500DCDCDC00E1E1E100E1E1E100DCDCDC00D5D5
      D500CECECE00C7C7C700C2C2C20000000000000000000000000000000000C2C2
      C200C7C7C700CECECE00D5D5D500DCDCDC00E1E1E100E1E1E100DCDCDC00D5D5
      D500CECECE00C7C7C700C2C2C200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7E7E700CFCFCF00D0D0D000E3E3E300000000000000
      0000000000000000000000000000000000000000000000000000000000004C4C
      4C00585858006A6A6A007C7C7C0088888800888888007C7C7C006A6A6A005858
      58004C4C4C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000505050005050
      5000505050000000000000000000000000000000000000000000000000005050
      5000505050005050500000000000000000000000000000000000000000000000
      0000CDCDCD009F9F9F009595950098989800929292008686860086868600BABA
      BA00000000000000000000000000000000000000000000000000000000006E6E
      6E00C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
      C3006E6E6E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000053535300535353008383
      8300535353005353530000000000000000000000000000000000535353005353
      530083838300535353005353530000000000000000000000000000000000B5B5
      B500B1B1B100B5B5B500A5A5A50099999900989898009F9F9F00A2A2A2008A8A
      8A008F8F8F000000000000000000000000000000000000000000000000009090
      9000959595009D9D9D00A4A4A400AAAAAA00AAAAAA00A4A4A4009D9D9D009595
      9500909090000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000050505000505050000000
      0000000000000000000000000000000000000000000057575700BFBFBF008787
      8700878787005757570057575700000000000000000057575700575757008787
      870087878700BFBFBF0057575700000000000000000000000000BEBEBE00C2C2
      C200B4B4B400898989007D7D7D007777770072727200757575007C7C7C00A3A3
      A300919191009292920000000000000000000000000000000000000000004C4C
      4C009090900090909000909090004C4C4C004C4C4C0090909000909090009090
      90004C4C4C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000054545400727272005454
      540000000000000000000000000000000000000000005C5C5C005C5C5C00BFBF
      BF008B8B8B008B8B8B005C5C5C005C5C5C005C5C5C005C5C5C008B8B8B008B8B
      8B00BFBFBF005C5C5C005C5C5C000000000000000000DADADA00CBCBCB00B9B9
      B900898989008A8A8A008C8C8C00C6C6C600C3C3C30077777700797979007373
      7300A5A5A5008D8D8D00BABABA00000000000000000000000000000000004C4C
      4C0090909000909090004C4C4C007F7F7F007F7F7F004C4C4C00909090009090
      90004C4C4C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A5A5A005A5A5A00909090005A5A
      5A00000000000000000000000000000000000000000000000000616161006161
      6100BFBFBF00919191009191910061616100616161009191910091919100BFBF
      BF006161610061616100000000000000000000000000CDCDCD00CECECE009595
      9500919191009595950098989800A9A9A900ABABAB00848484007F7F7F007979
      79007D7D7D00ABABAB0092929200000000000000000000000000000000005151
      5100909090005151510080808000909090009090900080808000515151009090
      9000515151000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000606060007A7A7A00949494006060
      6000000000000000000000000000000000000000000000000000000000006767
      670067676700BFBFBF0097979700979797009797970097979700BFBFBF006767
      67006767670000000000000000000000000000000000D1D1D100BABABA009A9A
      9A009C9C9C00A0A0A00095959500CFCFCF00BABABA008C8C8C00868686007C7C
      7C0075757500A7A7A7008F8F8F00E5E5E5000000000000000000000000005858
      580058585800C3C3C300ACACAC009595950095959500ACACAC00C3C3C3005858
      5800585858000000000000000000000000000000000000000000000000000000
      000000000000000000000000000067676700676767009A9A9A008D8D8D006767
      6700000000000000000000000000000000000000000000000000000000000000
      00006D6D6D006D6D6D00AFAFAF009E9E9E009E9E9E00AFAFAF006D6D6D006D6D
      6D0000000000000000000000000000000000EEEEEE00DDDDDD00B2B2B200A2A2
      A200A7A7A700A6A6A600A1A1A100EEEEEE00E0E0E00093939300878787008484
      84007A7A7A009B9B9B00A7A7A700CDCDCD000000000000000000000000006060
      60006060600060606000606060009C9C9C009C9C9C0060606000606060006060
      6000606060000000000000000000000000000000000000000000000000006E6E
      6E006E6E6E00000000006E6E6E006E6E6E00A2A2A200A2A2A200888888006E6E
      6E00000000000000000000000000000000000000000000000000000000000000
      00007373730073737300A4A4A400A4A4A400A4A4A400A4A4A400737373007373
      730000000000000000000000000000000000EFEFEF00E2E2E200B7B7B700AAAA
      AA00B0B0B000B2B2B200AFAFAF00ABABAB00D2D2D200EBEBEB00ABABAB008484
      84007E7E7E009E9E9E00AEAEAE00D3D3D3000000000000000000000000000000
      0000A5A5A500A5A5A50000000000A5A5A500A5A5A50000000000A5A5A500A5A5
      A500000000000000000000000000000000000000000000000000000000007575
      7500909090007575750075757500AAAAAA00AAAAAA009D9D9D00757575007575
      7500000000000000000000000000000000000000000000000000000000007979
      790079797900ABABAB00ABABAB00BFBFBF00BFBFBF00ABABAB00ABABAB007979
      79007979790000000000000000000000000000000000E0E0E000C5C5C500B0B0
      B000B9B9B900B7B7B700ADADAD00AEAEAE009C9C9C00EDEDED00E2E2E2007F7F
      7F0082828200AEAEAE00AAAAAA00E8E8E8000000000000000000000000007373
      7300AEAEAE00AEAEAE0073737300AEAEAE00AEAEAE0073737300AEAEAE00AEAE
      AE00737373000000000000000000000000000000000000000000000000007C7C
      7C00B1B1B10097979700B1B1B100B1B1B100C3C3C3007C7C7C007C7C7C000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F00B2B2B200B2B2B200BFBFBF007F7F7F007F7F7F00BFBFBF00B2B2B200B2B2
      B2007F7F7F007F7F7F00000000000000000000000000E4E4E400DEDEDE00B3B3
      B300BDBDBD00C1C1C100D2D2D200B7B7B700CBCBCB00EDEDED00DBDBDB008585
      850086868600C6C6C600B5B5B500000000000000000000000000000000007C7C
      7C00B7B7B700B7B7B7007C7C7C00B7B7B700B7B7B7007C7C7C00B7B7B700B7B7
      B7007C7C7C000000000000000000000000000000000000000000000000008282
      8200B9B9B900B9B9B900B9B9B900C3C3C3008282820082828200000000000000
      000000000000000000000000000000000000000000008484840084848400B7B7
      B700B7B7B700BFBFBF0084848400848484008484840084848400BFBFBF00B7B7
      B700B7B7B70084848400848484000000000000000000F0F0F000F1F1F100C6C6
      C600B8B8B800BDBDBD00E0E0E000EDEDED00E8E8E800D3D3D300A1A1A1008989
      8900B6B6B600CCCCCC00D0D0D000000000000000000000000000000000008484
      8400BEBEBE00BEBEBE0084848400BEBEBE00BEBEBE0084848400BEBEBE00BEBE
      BE00848484000000000000000000000000000000000000000000000000008888
      8800BFBFBF00BFBFBF00C3C3C300A4A4A4008888880000000000000000000000
      0000000000000000000000000000000000000000000089898900BFBFBF00BCBC
      BC00BFBFBF00898989008989890000000000000000008989890089898900BFBF
      BF00BCBCBC00BFBFBF0089898900000000000000000000000000E7E7E700F4F4
      F400C8C8C800B4B4B400AEAEAE00A6A6A600A0A0A0009999990093939300BCBC
      BC00D9D9D900C0C0C00000000000000000000000000000000000000000008B8B
      8B00C3C3C300C3C3C3008B8B8B00C3C3C300C3C3C3008B8B8B00C3C3C300C3C3
      C3008B8B8B000000000000000000000000000000000000000000000000008D8D
      8D00C3C3C300C3C3C300C3C3C300C3C3C300A8A8A8008D8D8D00000000000000
      000000000000000000000000000000000000000000008D8D8D008D8D8D00BFBF
      BF008D8D8D008D8D8D00000000000000000000000000000000008D8D8D008D8D
      8D00BFBFBF008D8D8D008D8D8D0000000000000000000000000000000000E6E6
      E600F3F3F300E4E4E400C8C8C800B8B8B800B3B3B300BEBEBE00DADADA00DBDB
      DB00CACACA000000000000000000000000000000000000000000000000009090
      9000909090009090900090909000909090009090900090909000909090009090
      9000909090000000000000000000000000000000000000000000000000009090
      9000909090009090900090909000909090009090900090909000000000000000
      00000000000000000000000000000000000000000000000000008F8F8F008F8F
      8F008F8F8F000000000000000000000000000000000000000000000000008F8F
      8F008F8F8F008F8F8F0000000000000000000000000000000000000000000000
      0000F0F0F000EAEAEA00E8E8E800EEEEEE00ECECEC00DEDEDE00D8D8D800E0E0
      E000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F2F2F200F0F0F00000000000000000000000
      0000000000000000000000000000000000000000000078787800787878007878
      7800787878007878780078787800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000066666600666666006666
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007A7A7A00A5A5A500A5A5A500B1B1
      B1007A7A7A00A5A5A50078787800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000666666006666660066666600666666006666660066666600666666006666
      6600000000000000000000000000000000006868680099999900AAAAAA009999
      9900666666000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005C5C5C006464
      6400808080008C8C8C0099999900A2A2A200A2A2A200999999008C8C8C008080
      8000646464005F5F5F0000000000000000007D7D7D00E1E1E10078787800A5A5
      A500B3B3B3007D7D7D0078787800787878000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006868
      680070707000A1A1A100CBCBCB00EAEAEA00EAEAEA00CBCBCB00A1A1A1007070
      7000686868000000000000000000000000006B6B6B00C5C5C500ACACAC00ACAC
      AC009A9A9A006666660000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005E5E5E005E5E5E006464
      6400CCCCCC008F8F8F008F8F8F00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00646464008F8F8F005E5E5E00000000007F7F7F00FBFBFB00CACACA007878
      7800A5A5A500B7B7B7007F7F7F00A5A5A5000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006C6C6C008484
      8400C9C9C900ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00C9C9
      C900848484006C6C6C0000000000000000006E6E6E00DDDDDD00B0B0B000B0B0
      B000B0B0B0009D9D9D0066666600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000062626200929292007070
      7000D3D3D3008080800080808000D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300707070009292920062626200000000008282820082828200FBFBFB00CDCD
      CD0078787800A5A5A500BABABA00828282000000000000000000000000000000
      000000000000000000000000000000000000000000006F6F6F0077777700CBCB
      CB00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00CBCBCB00777777006F6F6F00000000000000000071717100DDDDDD00B3B3
      B300B3B3B300B3B3B300A0A0A000666666000000000000000000000000000000
      0000000000000000000000000000000000000000000065656500969696008080
      8000DDDDDD006B6B6B006B6B6B00DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
      DD0080808000969696006565650000000000000000000000000085858500FBFB
      FB00D2D2D20078787800A5A5A500BFBFBF008585850085858500000000000000
      0000000000000000000000000000000000000000000074747400AAAAAA00EFEF
      EF00EFEFEF00AAAAAA00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00AAAAAA007474740000000000000000000000000075757500DDDD
      DD00B8B8B800B8B8B800B8B8B800A3A3A3006666660000000000000000000000
      000000000000000000000000000000000000000000006A6A6A009B9B9B009191
      9100E7E7E7005C5C5C005C5C5C00E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700919191009B9B9B006A6A6A0000000000000000000000000089898900C3C3
      C300D7D7D700D7D7D70078787800A5A5A500BFBFBF0090909000787878007878
      7800787878007878780000000000000000000000000078787800D5D5D500F1F1
      F100F1F1F100F1F1F100ABABAB00F1F1F100F1F1F100F1F1F100F1F1F100F1F1
      F100F1F1F100D5D5D50078787800000000000000000000000000000000007979
      7900DDDDDD00BCBCBC00BCBCBC00BCBCBC00A6A6A60066666600000000000000
      000000000000000000000000000000000000000000006E6E6E00A0A0A000A0A0
      A000DADADA00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00DADA
      DA00A0A0A000A0A0A0006E6E6E000000000000000000000000008D8D8D00FBFB
      FB008D8D8D00FBFBFB00DCDCDC00A5A5A500DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00ACACAC007C7C7C0000000000000000007D7D7D00F4F4F400F4F4
      F400F4F4F400F4F4F400F4F4F40066666600666666006666660066666600ACAC
      AC00F4F4F400F4F4F4007D7D7D00000000000000000000000000000000000000
      00007D7D7D00DDDDDD00C1C1C100C1C1C100C1C1C100AAAAAA00666666006666
      6600666666006666660000000000000000000000000073737300A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A60073737300000000000000000000000000919191009191
      91009191910091919100FBFBFB00E2E2E200E2E2E200E2E2E200E2E2E200E2E2
      E200E2E2E200E2E2E200B1B1B100808080000000000082828200F5F5F500F5F5
      F500F5F5F500F5F5F500F5F5F5008989890089898900F5F5F500F5F5F500F5F5
      F500F5F5F500F5F5F50082828200000000000000000000000000000000000000
      00000000000082828200DDDDDD00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600B5B5B50066666600000000000000000078787800ABABAB009696
      96008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F0096969600ABABAB0078787800000000000000000000000000000000000000
      00000000000095959500A9A9A900FBFBFB00E7E7E700E7E7E700F1F1F100FBFB
      FB00FBFBFB00F1F1F100E7E7E700858585000000000087878700DEDEDE00F8F8
      F800F8F8F800F8F8F800F8F8F800AEAEAE00AEAEAE00F8F8F800F8F8F800F8F8
      F800F8F8F800DEDEDE0087878700000000000000000000000000000000000000
      0000000000000000000086868600DDDDDD00CBCBCB00CBCBCB00D4D4D400DDDD
      DD00DDDDDD00CBCBCB00BABABA0076767600000000007D7D7D00B1B1B100D4D4
      D400EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEAEA00EAEA
      EA00D4D4D400B1B1B1007D7D7D00000000000000000000000000000000000000
      0000000000000000000098989800FBFBFB00ECECEC00ECECEC00C9C9C900A5A5
      A500A5A5A500C9C9C900ECECEC008C8C8C00000000008B8B8B00BBBBBB00FAFA
      FA00FAFAFA00FAFAFA00FAFAFA00AFAFAF00AFAFAF00FAFAFA00FAFAFA00FAFA
      FA00FAFAFA00BBBBBB008B8B8B00000000000000000000000000000000000000
      00000000000000000000000000008A8A8A00DDDDDD00CFCFCF00B4B4B4009999
      990099999900DDDDDD00CFCFCF008A8A8A000000000081818100B6B6B600EEEE
      EE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE00B6B6B60081818100000000000000000000000000000000000000
      000000000000000000009C9C9C00FBFBFB00F1F1F100F1F1F100989898000000
      00009898980098989800F1F1F10092929200000000009090900097979700DFDF
      DF00FCFCFC00FCFCFC00FCFCFC00D6D6D600D6D6D600FCFCFC00FCFCFC00FCFC
      FC00DFDFDF009797970090909000000000000000000000000000000000000000
      00000000000000000000000000008E8E8E00DDDDDD00D4D4D4008F8F8F000000
      00008E8E8E008E8E8E00DDDDDD008E8E8E000000000086868600BBBBBB00F4F4
      F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400BBBBBB0086868600000000000000000000000000000000000000
      000000000000000000009E9E9E00FBFBFB00F4F4F400F4F4F400858585008585
      850085858500F4F4F400C6C6C60098989800000000000000000093939300A7A7
      A700E0E0E000FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00E0E0
      E000A7A7A7009393930000000000000000000000000000000000000000000000
      000000000000000000000000000091919100DDDDDD00D7D7D700808080008080
      8000000000009191910091919100000000000000000089898900BFBFBF00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00BFBFBF0089898900000000000000000000000000000000000000
      00000000000000000000A1A1A100CDCDCD00FBFBFB00F8F8F800B8B8B8007878
      7800F8F8F800E1E1E1009D9D9D00000000000000000000000000000000009797
      97009E9E9E00C5C5C500E7E7E7000000000000000000E7E7E700C5C5C5009E9E
      9E00979797000000000000000000000000000000000000000000000000000000
      000000000000000000000000000094949400DDDDDD00DBDBDB00C0C0C0007070
      700070707000000000000000000000000000000000008D8D8D00C2C2C2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C2C2C2008D8D8D00000000000000000000000000000000000000
      0000000000000000000000000000A4A4A400CFCFCF00FBFBFB00FBFBFB00FBFB
      FB00CFCFCF00A2A2A200FBFBFB00000000000000000000000000000000000000
      0000999999009999990099999900999999009999990099999900999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000097979700DDDDDD00DDDDDD00DDDD
      DD0066666600000000000000000000000000000000000000000092929200C7C7
      C700CECECE00D5D5D500DCDCDC00E1E1E100E1E1E100DCDCDC00D5D5D500CECE
      CE00C7C7C7009292920000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00FFFF0000000000008003000000000000
      0001000000000000000100000000000000010000000000000001000000000000
      0001000000000000000100000000000000010000000000000007000000000000
      0007000000000000800F000000000000C3FB000000000000FFF1000000000000
      FFFB000000000000FFFF000000000000E0000FFFC3C30000C00007FFC1830000
      C00003FFC0030000C00001FFC0030000C00080FFC0030000C001C07FE0070000
      C00FE03FC00300008007F01F800100008007F80F000000008007FC0700000000
      8007FE03000000008007FF01F81F0000C00FFF80F81F0000E01FFFC0FC3F0000
      F03FFFE0FC3F0000FFFFFFF1FC3F0000FFFFFFFF80078007E007E00700030003
      C003C003000300038001800100030003800180010003000380018001C003C003
      80018001C003C00380018001C003C00380018001C003C00380018001C003C003
      80018001C003C00380018001C003C00380018001C003C003C003C003C003C003
      E007E007C001C001FFFFFFFFE001E001FFFFFFFFFFFFFC3FE007FFFFC7E3F00F
      E007FFFF83C1E007E007FF9F8181C003E007FF8F80018001E007FF0FC0038001
      E007FF0FE0078000E007FE0FF00F0000E007E40FF00F0000F24FE00FE0078000
      E007E01FC0038001E007E03F80018001E007E07F8181C003E007E03F83C1E007
      E007E03FC7E3F00FFFFFFFFFFFFFFE7F81FFFFFF8FFFFFFF01FFF00F07FFC003
      00FFE00703FF800100FFC00301FF800100FF800180FF8001C03F8001C07F8001
      C0038001E03F8001C0018001F0038001C0008001F8018001F8008001FC008001
      FC008001FE008001FC108001FE108001FC00C003FE098001FC01E187FE079FF9
      FE01F00FFF07C003FF07FFFFFF8FFFFF00000000000000000000000000000000
      000000000000}
  end
  object TreesPopupMenu: TPopupMenu
    Images = ActionImagesSmall
    OnPopup = TreesPopupMenuPopup
    Left = 112
    Top = 188
    object OpenMenu: TMenuItem
      Action = OpenAction
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object DeleteMenu: TMenuItem
      Action = DeleteAction
    end
    object DeleteThreadMenu: TMenuItem
      Action = DeleteThreadAction
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object FavoritesMenu: TMenuItem
      Caption = 'Favorieten'
      ImageIndex = 14
      object AddToGroupMenu: TMenuItem
        Caption = 'Toevoegen aan groep'
      end
      object AddToFavoritesMenu: TMenuItem
        Tag = -1
        Action = AddToFavoritesAction
      end
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object NewGroupMenu: TMenuItem
      Action = NewGroupAction
    end
    object ExpandCollapseMenu: TMenuItem
      Action = ExpandCollapseGroupAction
    end
  end
  object ActionImagesSmall: TImageList
    DrawingStyle = dsTransparent
    Left = 192
    Top = 216
    Bitmap = {
      494C010111001400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000274AC000274AC000274
      AC000274AC000274AC000274AC000274AC000274AC000274AC000274AC000274
      AC000274AC000274AC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC0049BEEE000274AC0091EF
      FC004BBFF0004BBFF0004BBFF0004BBFF0004BBFF0004BBFF0004BBFF0004BBF
      F000289CCF009BECFA000274AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC0051C4F3000274AC0095ED
      FB0054C8F50054C8F50054C8F50054C8F50054C8F50054C8F50054C8F50054C8
      F500289CCF009BECFA000274AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC005ACCF6000274AC009BEC
      FA005FD2F9005FD2F9005FD2F9005FD2F9005FD2F9005FD2F9005FD2F9005FD2
      F900289CCF00A2EDFA000274AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC005FD2F9000274AC00A2ED
      FA006ADCFA006ADCFA006ADCFA006ADCFA006ADCFA006ADCFA006ADCFA006ADC
      FA0032A6D800AAEFFA000274AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC006ADCFA000274AC00AAEF
      FA0073E5FB0073E5FB0073E5FB0073E5FB0073E5FB0073E5FB0073E5FB0073E5
      FB0032A6D800AAEFFA000274AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC0071E2FB000274AC00C7F2
      FA00B8F2FC00B8F2FC00B8F2FC00B8F2FC00B8F2FC00B8F2FC00B8F2FC00B8F2
      FC005ACCF600C7F2FA000274AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC0078E9FC000274AC000274
      AC000274AC000274AC000274AC000274AC000274AC000274AC000274AC000274
      AC000274AC000274AC000274AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC0084F1FD0084F1FD0084F1
      FD0084F1FD0084F1FD0084F1FD0084F1FD0084F1FD0084F1FD0084F1FD0084F1
      FD000273AB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC00C7F2FA0089F4FD0089F4
      FD0089F4FD0089F4FD0089F4FD0089F4FD0089F4FD0089F4FD0089F4FD0089F4
      FD000273AB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000274AC00C7F2FA008DF2
      FD008DF2FD008DF2FD000274AC000274AC000274AC000274AC000274AC000274
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000274AC000274
      AC000274AC000274AC0000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B99D
      8F00D0B0A000E0D0C000E0C8B000B090810081665800B7A59C00B99D8F00D0B0
      A000E0D0C000E0C8B000B09081008166580099362F0078787800333399003366
      CC00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000077AA000077
      AA000077AA000077AA00000000000000000000000000000000000077AA000077
      AA000077AA000077AA000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000C8B2A700E0D0
      C000B79F9300A48A7100BEA4970051291100412911004129110041291100745F
      4A00A48A7100BEA49700CFB7AB00B09881007878780099BFFF006699FF006699
      FF00005500000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000079AC0000CC
      FF0000A3D6000079AC000079AC0000000000000000000079AC000079AC0000A3
      D60000CCFF000079AC000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000B49E8700FFFF
      FF0066432E00E1DBD800D8BEB100FFFFFF00FFF8F000FFE8E000F0D8D000F0D0
      C0009C8A7900EAE4DE00B9A48F00E0D0C0004D80E500CCE5FF0099BFFF000055
      0000228822000055000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007CAF0008BA
      EB000ACDFD0008BAEB00007CAF00007CAF00007CAF00007CAF0008BAEB000ACD
      FD0008BAEB00007CAF000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000C8B7A700F0E0
      D0009D8F81005B3D2E0061493100B0988100D0B0A000C0A89000D0B8B000C3AD
      9600715D4A007E6A5700B7AB9F00C0B0A0006699FF00CCE5FF00116F11003399
      3300228822002288220000550000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007FB2000EA9
      D90017CCFA0017CCFA0017CCFA0014BDEC0014BDEC0017CCFA0017CCFA0017CC
      FA000EA9D900007FB2000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000CFC7BF00C0A8
      A000E0D8D000FFF8F000FFF0F000D0C0B000A081710081695100C0A89000E0D8
      D000FFF8F000FFF0F000D0C0B000AB8F8100000000002288220066CC66004DB3
      4D00339933002288220022882200005500000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000082B5000082
      B50022CBF60019C3F00019C3F00019C3F00019C3F00019C3F00019C3F00022CB
      F6000082B5000082B5000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000B2A79C00D088
      6100C0907100A0988100A090710090796100318821007169310090695100AB8F
      8100B9A48F00B99D8F00C3B4A5000000000000000000000000002288220066CC
      66004DB34D003399330022882200228822000055000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000086
      B90031C6ED0019BDEA0013B9E70013B9E70013B9E70013B9E70019BDEA0031C6
      ED000086B900000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000C0907100FF98
      6100E09061006179510051A0310051A0310081902100D0794100716941006159
      4100000000000000000000000000000000000000000000000000000000002288
      220066CC66004DB34D0033993300228822002288220000550000000000000000
      0000000000000000000000000000000000000000000000000000008ABD00008A
      BD0042CAEE0014B6E5000BB1E1000BB1E1000BB1E1000BB1E10014B6E50042CA
      EE00008ABD00008ABD000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C8B7A700F0987100F098
      7100617151006198410061B0410090A04100E0886100D0815100516941004179
      3100918171000000000000000000000000000000000000000000000000000000
      00002288220066CC66004DB34D00339933002288220022882200005500000000
      00000000000000000000000000000000000000000000008EC100008EC10053CF
      EF0036C7EE000DB1E10000AADD0000AADD0000AADD0000AADD000DB1E10036C7
      EE0053CFEF00008EC100008EC10000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000B49E9600FFA071008181
      610041A0410051B0410090906100E0987100E0906100E088510061A021004198
      21006A5B4C000000000000000000000000000000000000000000000000000000
      0000000000002288220066CC66004DB34D003399330022882200228822000055
      0000000000000000000000000000000000000093C6000093C60064D5F10052D2
      F20049CEF0005CD7F40072E2FA0080E8FE0080E8FE0072E2FA005CD7F40049CE
      F00052D2F20064D5F1000093C6000093C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000B4A59600E09071006198
      510041C8610041C8710071A07100B0A07100D0986100E0906100A090310041A0
      2100795B4C000000000000000000000000000000000000000000000000000000
      000000000000000000002288220066CC66004DB34D0033993300228822002288
      2200005500000000000000000000000000000097CA00DDFFFF00BDF8FF009CF0
      FF009CF0FF009CF0FF009CF0FF009CF0FF009CF0FF009CF0FF009CF0FF009CF0
      FF009CF0FF00BDF8FF00DDFFFF000097CA00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C8BDB200A090610051B8
      610061D8810090E0A00081E0A000A0D09000B0A06100F0986100E08851005198
      31009C8B7C000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002288220066CC66004DB34D00339933002288
      220022882200005500000000000000000000009BCE00009BCE00009BCE00009B
      CE00009BCE0058C8E700B0F5FF00B0F5FF00B0F5FF00B0F5FF0058C8E700009B
      CE00009BCE00009BCE00009BCE00009BCE00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000DCBAFF00A0A0810031C8
      610071E09000C0F0B000D0F0D000F0F8D000B0E8A00081986100D09841008188
      4100DCE4FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002288220066CC66004DB34D003399
      3300228822002288220066666600000000000000000000000000000000000000
      000000000000009FD200C2F9FF00C2F9FF00C2F9FF00C2F9FF00009FD2000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000C8BDB20090B8
      810081D88100C0F0B000E0F8D00081A8710071D8900041B0610090814100A79C
      9100000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002288220066CC66004DB3
      4D003399330088888800BBBBBB00666666000000000000000000000000000000
      00000000000000A2D50069CFEA00D2FCFF00D2FCFF0069CFEA0000A2D5000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00000000000000000000000000C8BD
      B200B0B89000B0D09000A0D8900081E0900051C0710090906100B2A79C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002288220066CC
      6600AAAAAA00CCCCCC00888888003333CC000000000000000000000000000000
      0000000000000000000000A5D800DDFFFF00DDFFFF0000A5D800000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000DCBAFF00C8BDB200B4A59600B49E9600C8B2A700DCBAFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009999
      9900DDDDDD00AAAAAA006666DD003333CC000000000000000000000000000000
      0000000000000000000000A8DB006FD4ED006FD4ED0000A8DB00000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000999999006666FF006666FF00000000000000000000000000000000000000
      0000000000000000000000AADD0000AADD0000AADD0000AADD00000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC996600D09F6F00D6A9
      7C00DCB48B00E2BD9800E6C4A200E6C4A200E2BD9800DCB48B00D6A97C00D09F
      6F00CC99660000000000000000000000000000000000CC996600D09F6F00D6A9
      7C00DCB48B00E2BD9800E6C4A200E6C4A200E2BD9800DCB48B00D6A97C00D09F
      6F00CC9966000000000000000000000000000000000000000000000000006A6A
      6A0070707000767676007C7C7C0080808000808080007C7C7C00767676007070
      70006A6A6A000000000000000000000000000000000000000000000000006A6A
      6A0070707000767676007C7C7C0080808000808080007C7C7C00767676007070
      70006A6A6A00000000000000000000000000CE9B6800E7C5A300FFEEDD00FFEE
      DD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEE
      DD00E7C5A300CE9B68000000000000000000CE9B6800E7C5A300FFEEDD00FFEE
      DD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEE
      DD00E7C5A300CE9B680000000000000000000000000000000000818181009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999008181810000000000000000000000000000000000818181009999
      9900999999009999990099999900999999009999990099999900999999009999
      990099999900818181000000000000000000D19E6B00FFEFDF00FFEFDF00FFEF
      DF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00D19E
      6B00FFEFDF00D19E6B000000000000000000D19E6B00FFEFDF00FFEFDF00FFEF
      DF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00D19E
      6B00FFEFDF00D19E6B000000000000000000000000006C6C6C009C9C9C009C9C
      9C009C9C9C009C9C9C00929292008E8E8E008E8E8E00929292009C9C9C009C9C
      9C009C9C9C009C9C9C006C6C6C0000000000000000006C6C6C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C006C6C6C0000000000D4A16E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D4A1
      6E00FFF0E100D4A16E000000000000000000D4A16E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D4A1
      6E00FFF0E100D4A16E000000000000000000000000006F6F6F00A0A0A000A0A0
      A000A0A0A000A0A0A00091919100FFEEDD00FFEEDD0091919100A0A0A000A0A0
      A000A0A0A000A0A0A0006F6F6F0000000000000000006F6F6F00A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A0006F6F6F0000000000D7A47100DAAA7900DFB28600E4BC
      9500E8C5A100EBCBAA00EBCBAA00E8C5A100E4BC9500DFB28600DAAA7900E1B7
      8E00FFF1E300D7A471000000000000000000D7A47100DAAA7900DFB28600E4BC
      9500E8C5A100EBCBAA00EBCBAA00E8C5A100E4BC9500DFB28600DAAA7900E1B7
      8E00FFF1E300D7A4710000000000000000000000000074747400A5A5A500A5A5
      A500A5A5A500A5A5A50095959500FFF0E000FFF0E00095959500A5A5A500A5A5
      A500A5A5A500A5A5A50074747400000000000000000074747400A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A500A5A5A50074747400000000000000000000000000DBA87500FFF3
      E600FFF3E600FFF3E600FFF3E600FFF3E600FFF3E600FFF3E600FFF3E600FFF3
      E600FFF3E600DBA8750000000000000000000000000000000000DBA87500FFF3
      E600FFF3E600FFF3E600FFF3E600FFF3E600FFF3E600FFF3E600FFF3E600FFF3
      E600FFF3E600DBA8750000000000000000000000000078787800AAAAAA009D9D
      9D00999999009999990099999900FFF2E500FFF2E50099999900999999009999
      99009D9D9D00AAAAAA0078787800000000000000000078787800AAAAAA009D9D
      9D00999999009999990099999900999999009999990099999900999999009999
      99009D9D9D00AAAAAA0078787800000000000000000000000000DFAC7900FFF4
      E900FFF4E900FFF4E900FFF4E900FFF4E900FFF4E900FFF4E900FFF4E900FFF4
      E900FFF4E900DFAC790000000000000000000000000000000000DFAC79006689
      C800FFD28300FFF4E900FFF4E9006689C800FFD28300FFF4E900DBF4E9009062
      8300FFF4C800DFAC79000000000000000000000000007D7D7D00B0B0B0009D9D
      9D00FFF5EB00FFF5EB00FFF5EB00FFF5EB00FFF5EB00FFF5EB00FFF5EB00FFF5
      EB009D9D9D00B0B0B0007D7D7D0000000000000000007D7D7D00B0B0B0009D9D
      9D00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEE
      DD009D9D9D00B0B0B0007D7D7D00000000000000000000000000E3B07D00FFF6
      EC00FFF6EC00FFF6EC00FFF6EC00FFF6EC00FFF6EC00FFF6EC00FFF6EC00FFF6
      EC00FFF6EC00E3B07D0000000000000000000000000000000000E3B07D00668A
      CA00FFD38400FFF6EC00FFF6EC00668ACA00FFD38400908ACA00DBF6A8009062
      8400FFF6CA00E3B07D0000000000000000000000000082828200B5B5B500A1A1
      A100FFF8F100FFF8F100FFF8F100FFF8F100FFF8F100FFF8F100FFF8F100FFF8
      F100A1A1A100B5B5B50082828200000000000000000082828200B5B5B500A1A1
      A100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A1A1A100B5B5B50082828200000000000000000000000000E8B58200FFF7
      F000FFF7F000FFF7F000FFF7F000FFF7F000FFF7F000FFF7F000FFF7F000FFF7
      F000FFF7F000E8B5820000000000000000000000000000000000E8B582003A8B
      CE000000000000000000FFB06000668BCE00B6D487003A386000DBB087009063
      8700FFF7CE00E8B5820000000000000000000000000087878700BBBBBB00ABAB
      AB00A6A6A600A6A6A600A6A6A600FFFBF700FFFBF700A6A6A600A6A6A600A6A6
      A600ABABAB00BBBBBB0087878700000000000000000087878700BBBBBB00ABAB
      AB00A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600ABABAB00BBBBBB0087878700000000000000000000000000ECB98600FFF9
      F300FFF9F300FFF9F300FFF9F300FFF9F300FFF9F300FFF9F300FFF9F300FFF9
      F300FFF9F300ECB9860000000000000000000000000000000000ECB98600668C
      D100FFD68900B6F9F300B6646100668CD10066646100DBD68900666489009064
      6100FFF9D100ECB986000000000000000000000000008B8B8B00C0C0C000C0C0
      C000C0C0C000C0C0C000A9A9A900FFFDFC00FFFDFC00A9A9A900C0C0C000C0C0
      C000C0C0C000C0C0C0008B8B8B0000000000000000008B8B8B00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0008B8B8B00000000000000000000000000F0BD8A00FFFA
      F600FFFAF600FFFAF600FFFAF600FFFAF600FFFAF600FFFAF600FFFAF600FFFA
      F600FFFAF600F0BD8A0000000000000000000000000000000000F0BD8A003A8D
      D3000000000000000000DB8D38003A8DD300B6640000FFFAF60066B2F6009039
      0000FFFAD300F0BD8A0000000000000000000000000090909000C5C5C500C5C5
      C500C5C5C500C5C5C500ADADAD00FFFFFF00FFFFFF00ADADAD00C5C5C500C5C5
      C500C5C5C500C5C5C50090909000000000000000000090909000C5C5C500C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C50090909000000000000000000000000000F4C18E00FFFC
      F900FFFCF900FFFCF900FFFCF900FFFCF900FFFCF900FFFCF900FFFCF900FFFC
      F900FFFCF900F4C18E0000000000000000000000000000000000F4C18E00FFFC
      F900FFFCF900FFFCF900FFFCF900FFFCF900FFFCF900FFFCF900FFFCF900FFFC
      F900FFFCF900F4C18E0000000000000000000000000093939300C9C9C900C9C9
      C900C9C9C900C9C9C900B6B6B600B0B0B000B0B0B000B6B6B600C9C9C900C9C9
      C900C9C9C900C9C9C90093939300000000000000000093939300C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C90093939300000000000000000000000000F7C49100FFFD
      FB00FFFDFB00FFFDFB00FFFDFB00FFFDFB00FFFDFB00FFFDFB00FFFDFB00FFFD
      FB00FFFDFB00E1AE7B0000000000000000000000000000000000F7C49100FFFD
      FB00FFFDFB00FFFDFB00FFFDFB00FFFDFB00FFFDFB00FFFDFB00FFFDFB00FFFD
      FB00FFFDFB00E1AE7B0000000000000000000000000000000000B2B2B200CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00B2B2B20000000000000000000000000000000000B2B2B200CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00B2B2B20000000000000000000000000000000000FAC79400FFFE
      FD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFF
      FF00FFFFFF00CC99660000000000000000000000000000000000FAC79400FFFE
      FD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFE
      FD00FFFEFD00CC99660000000000000000000000000000000000000000009D9D
      9D00A3A3A300A9A9A900AFAFAF00B3B3B300B3B3B300AFAFAF00A9A9A900A3A3
      A3009D9D9D000000000000000000000000000000000000000000000000009D9D
      9D00A3A3A300A9A9A900AFAFAF00B3B3B300B3B3B300AFAFAF00A9A9A900A3A3
      A3009D9D9D000000000000000000000000000000000000000000FDCA9700FEE5
      CB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEE5CB00000000000000000000000000FDCA9700FEE5
      CB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEE5CB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFCC
      9900FFD0A100FFD6AC00FFDCB900FFE2C400FFE6CC00FFE6CC00FFE2C400FFDC
      B900FFD6AC00FFD0A100FFCC990000000000000000000000000000000000FFCC
      9900FFD0A100FFD6AC00FFDCB900FFE2C400FFE6CC00FFE6CC00FFE2C400FFDC
      B900FFD6AC00FFD0A100FFCC9900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EAE9E300CDCFD000CED1D200E3E5E100000000000000
      0000000000000000000000000000000000000000000000000000000000001177
      11001D831D002F952F0041A741004DB34D004DB34D0041A741002F952F001D83
      1D00117711000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000022CC000022
      CC000022CC000000000000000000000000000000000000000000000000000022
      CC000022CC000022CC0000000000000000000000000000000000000000000000
      0000C8CDCF00979FA50095959700A39993009D938E00858687007E868C00B6BA
      BE00000000000000000000000000000000000000000000000000000000003399
      330088EE880088EE880088EE880088EE880088EE880088EE880088EE880088EE
      8800339933000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000325CE000325CE003355
      FF000325CE000325CE00000000000000000000000000000000000325CE000325
      CE003355FF000325CE000325CE0000000000000000000000000000000000B3B5
      B800B7B2B000C4B7AC00C6AA8F00D0A17500D1A17300C5A58600B4A69500938B
      8700918E920000000000000000000000000000000000000000000000000055BB
      55005AC05A0062C8620069CF69006FD56F006FD56F0069CF690062C862005AC0
      5A0055BB55000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000157B1500157B15000000
      000000000000000000000000000000000000000000000729D20088AAFF00385A
      FF00385AFF000729D2000729D20000000000000000000729D2000729D200385A
      FF00385AFF0088AAFF000729D200000000000000000000000000BCBEC100D2C4
      BA00D9BA9C00D3965500D78C3F00D4853900D3813100D7863000D08B4000CEAA
      8600A79386009391940000000000000000000000000000000000000000001177
      110055BB550055BB550055BB5500117711001177110055BB550055BB550055BB
      5500117711000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000197F1900379D3700197F
      190000000000000000000000000000000000000000000C2ED5000C2ED50088AA
      FF003E60FF003E60FF000C2ED5000C2ED5000C2ED5000C2ED5003E60FF003E60
      FF0088AAFF000C2ED5000C2ED5000000000000000000D6DADD00D0CCC900DEBF
      A000D4955600E3994D00D0956200EAC8B600EEC6AF00C7824300E28B3000CB81
      3900CFAC8800968E8A00B6BABD00000000000000000000000000000000001177
      110055BB550055BB55001177110044AA440044AA44001177110055BB550055BB
      5500117711000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001F851F001F851F0055BB55001F85
      1F000000000000000000000000000000000000000000000000001234DA001234
      DA0088AAFF004668FF004668FF001234DA001234DA004668FF004668FF0088AA
      FF001234DA001234DA00000000000000000000000000C8CDD200E7D2BE00D7A1
      6700E49F5900ECA35A00E3A46700DEB08800E2B28900D3914F00E28E3C00DB89
      3500CF8A4600BDB09B008B909A0000000000000000000000000000000000167C
      160055BB5500167C160045AB450055BB550055BB550045AB4500167C160055BB
      5500167C16000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000258B25003FA53F0059BF5900258B
      250000000000000000000000000000000000000000000000000000000000183A
      DE00183ADE0088AAFF004F71FF004F71FF004F71FF004F71FF0088AAFF00183A
      DE00183ADE0000000000000000000000000000000000CFD1D500DDC0A200E8A8
      6400ECA96500F1AD6900D09E6D00EAD2BF00DABEA700D7995900EB964100D88E
      3800DA843200C9AD8F008D8D9700E8E6E3000000000000000000000000001D83
      1D001D831D0088EE880071D771005AC05A005AC05A0071D7710088EE88001D83
      1D001D831D000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002C922C002C922C005FC55F0052B852002C92
      2C00000000000000000000000000000000000000000000000000000000000000
      00001F41E3001F41E3007193FF00597BFF00597BFF007193FF001F41E3001F41
      E30000000000000000000000000000000000F0EFED00DFDEDD00D7B99800F1B0
      6B00F7B47000F7B36E00D9AA7D00F8EFEB00EBE0DC00C79C6F00DC964C00D896
      4100E8893500CEA07F00ABA5AB00CBD0CB00000000000000000000000000258B
      2500258B2500258B2500258B250061C7610061C76100258B2500258B2500258B
      2500258B25000000000000000000000000000000000000000000000000003399
      33003399330000000000339933003399330067CD670067CD67004DB34D003399
      3300000000000000000000000000000000000000000000000000000000000000
      00002547E8002547E8006284FF006284FF006284FF006284FF002547E8002547
      E80000000000000000000000000000000000F0F0ED00E3E3E200DABD9E00F5B7
      7500FCBC7C00F9BE8000F4BB8000E4B48600F1D8BB00FDEFDE00D0B09500D295
      4500EB8C3A00D2A48100B2ACB100CED5D1000000000000000000000000002E94
      2E006AD06A006AD06A002E942E006AD06A006AD06A002E942E006AD06A006AD0
      6A002E942E000000000000000000000000000000000000000000000000003AA0
      3A0055BA55003AA03A003AA03A006FD46F006FD46F0062C762003AA03A003AA0
      3A00000000000000000000000000000000000000000000000000000000002C4E
      ED002C4EED006C8EFF006C8EFF0088AAFF0088AAFF006C8EFF006C8EFF002C4E
      ED002C4EED0000000000000000000000000000000000DEE0E300E3CAB000F5BC
      7F00FDC48C00EDC09400E9B78500EEB88200CEA37D00FCEFE600F5E4D900CB8D
      4800E4904200D5B59300AAA8B000E8E8EA00000000000000000000000000389E
      380073D9730073D97300389E380073D9730073D97300389E380073D9730073D9
      7300389E380000000000000000000000000000000000000000000000000041A7
      410076DC76005CC25C0076DC760076DC760088EE880041A7410041A741000000
      00000000000000000000000000000000000000000000000000003254F1003254
      F1007597FF007597FF0088AAFF003254F1003254F10088AAFF007597FF007597
      FF003254F1003254F100000000000000000000000000E1E4E800F3E2D100EBBD
      8D00FDC69400E7C7A800EAD6C200D2BAA800E2CEBF00FEF1E200FAE1C500D492
      4E00D1925300DCCCB500B0B4BC000000000000000000000000000000000041A7
      41007CE27C007CE27C0041A741007CE27C007CE27C0041A741007CE27C007CE2
      7C0041A7410000000000000000000000000000000000000000000000000047AD
      47007EE47E007EE47E007EE47E0088EE880047AD470047AD4700000000000000
      00000000000000000000000000000000000000000000385AF600385AF6007D9F
      FF007D9FFF0088AAFF00385AF600385AF600385AF600385AF60088AAFF007D9F
      FF007D9FFF00385AF600385AF6000000000000000000EEF1F100F5F3EE00E4CB
      B400F2BF9500E8C3A300F3E4D400FDEDE800FBE8E100F0D6C300DEA87C00D495
      5500DCBC9E00D1CDCA00CCD1D2000000000000000000000000000000000049AF
      490083E9830083E9830049AF490083E9830083E9830049AF490083E9830083E9
      830049AF49000000000000000000000000000000000000000000000000004DB3
      4D0084EA840084EA840088EE880069CF69004DB34D0000000000000000000000
      000000000000000000000000000000000000000000003D5FF90088AAFF0083A5
      FF0088AAFF003D5FF9003D5FF90000000000000000003D5FF9003D5FF90088AA
      FF0083A5FF0088AAFF003D5FF900000000000000000000000000E4E9E700FCF7
      EC00E7CCB500EBBD9000F2BA7F00EFB27300EDAC6C00E6A56700D59D6800E2C2
      A400E8DBD100BEC0C300000000000000000000000000000000000000000050B6
      500088EE880088EE880050B6500088EE880088EE880050B6500088EE880088EE
      880050B6500000000000000000000000000000000000000000000000000052B8
      520088EE880088EE880088EE880088EE88006DD36D0052B85200000000000000
      000000000000000000000000000000000000000000004163FD004163FD0088AA
      FF004163FD004163FD00000000000000000000000000000000004163FD004163
      FD0088AAFF004163FD004163FD0000000000000000000000000000000000E3E8
      E600F7F5F000F4E6DC00E5CCB700E2BE9D00E0BA9600DFC3A900EEDCCF00E0DC
      DA00C7CACC0000000000000000000000000000000000000000000000000055BB
      550055BB550055BB550055BB550055BB550055BB550055BB550055BB550055BB
      550055BB550000000000000000000000000000000000000000000000000055BB
      550055BB550055BB550055BB550055BB550055BB550055BB5500000000000000
      00000000000000000000000000000000000000000000000000004466FF004466
      FF004466FF000000000000000000000000000000000000000000000000004466
      FF004466FF004466FF0000000000000000000000000000000000000000000000
      0000EEF0F100E7E9EF00E9E7EC00F4EEED00F2EDEB00DDDEDF00D3D7DC00DCE1
      E200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F0F2F300EEF1F20000000000000000000000
      000000000000000000000000000000000000000000000077AA000077AA000077
      AA000077AA000077AA000077AA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000066666600666666006666
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000079AC0000AADD0000AADD0000B7
      EA000079AC0000AADD000077AA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000666666006666660066666600666666006666660066666600666666006666
      6600000000000000000000000000000000006868680099999900AAAAAA009999
      9900666666000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099663300A16E
      3B00808080008C8C8C0099999900A2A2A200A2A2A200999999008C8C8C008080
      8000A16E3B009C6936000000000000000000007CAF0074E7FF000077AA0000AA
      DD0007B9EB00007CAF000077AA000077AA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006868
      680073717000AAA39B00DBCEC100FFEEDD00FFEEDD00DBCEC100AAA39B007371
      7000686868000000000000000000000000006B6B6B00C5C5C500ACACAC00ACAC
      AC009A9A9A006666660000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009B6835009B683500A16E
      3B00CCCCCC00CC996600CC996600CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00A16E3B00CC9966009B68350000000000007FB200DDFFFF0018D2FF000077
      AA0000AADD0012BDEC00007FB20000AADD000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006C6C6C008885
      8200D7CCC000FFEFDF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00FFEFDF00D7CC
      C000888582006C6C6C0000000000000000006E6E6E00DDDDDD00B0B0B000B0B0
      B000B0B0B0009D9D9D0066666600000000000000000000000000000000000000
      000000000000000000000000000000000000000000009F6C3900CF9C6900AD7A
      4700D3D3D300BD8A5700BD8A5700D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300AD7A4700CF9C69009F6C3900000000000082B5000082B500DDFFFF0028D5
      FF000077AA0000AADD001EC0EC000082B5000000000000000000000000000000
      000000000000000000000000000000000000000000006F6F6F0079787700D8CD
      C300FFF0E200FFF0E200FFF0E200FFF0E200FFF0E200FFF0E200FFF0E200FFF0
      E200D8CDC300797877006F6F6F00000000000000000071717100DDDDDD00B3B3
      B300B3B3B300B3B3B300A0A0A000666666000000000000000000000000000000
      00000000000000000000000000000000000000000000A26F3C00D3A06D00BD8A
      5700DDDDDD00A8754200A8754200DDDDDD00DDDDDD00DDDDDD00DDDDDD00DDDD
      DD00BD8A5700D3A06D00A26F3C000000000000000000000000000086B900DDFF
      FF003BDAFF000077AA0000AADD002CC5ED000086B9000086B900000000000000
      0000000000000000000000000000000000000000000074747400B1ABA600FFF2
      E500FFF2E500B2ACA500FFF2E500FFF2E500FFF2E500FFF2E500FFF2E500FFF2
      E500FFF2E500B1ABA6007474740000000000000000000000000075757500DDDD
      DD00B8B8B800B8B8B800B8B8B800A3A3A3006666660000000000000000000000
      00000000000000000000000000000000000000000000A7744100D8A57200CE9B
      6800E7E7E7009966330099663300E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700CE9B6800D8A57200A7744100000000000000000000000000008ABD003BC9
      EE004FDEFF004FDEFF000077AA0000AADD003BC4EA001491BF000077AA000077
      AA000077AA000077AA0000000000000000000000000078787800E0D7CE00FFF4
      E800FFF4E800FFF4E800B2ADA700FFF4E800FFF4E800FFF4E800FFF4E800FFF4
      E800FFF4E800E0D7CE0078787800000000000000000000000000000000007979
      7900DDDDDD00BCBCBC00BCBCBC00BCBCBC00A6A6A60066666600000000000000
      00000000000000000000000000000000000000000000AB784500DDAA7700DDAA
      7700EADDD000EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EADD
      D000DDAA7700DDAA7700AB784500000000000000000000000000008EC100DDFF
      FF00008EC100DDFFFF0064E3FF0000AADD0064E3FF0064E3FF0064E3FF0064E3
      FF0064E3FF0032AFD700007BAE0000000000000000007D7D7D00FFF6EC00FFF6
      EC00FFF6EC00FFF6EC00FFF6EC0066666600666666006666660066666600B2AE
      A900FFF6EC00FFF6EC007D7D7D00000000000000000000000000000000000000
      00007D7D7D00DDDDDD00C1C1C100C1C1C100C1C1C100AAAAAA00666666006666
      66006666660066666600000000000000000000000000B07D4A00E3B07D00E3B0
      7D00E3B07D00E3B07D00E3B07D00E3B07D00E3B07D00E3B07D00E3B07D00E3B0
      7D00E3B07D00E3B07D00B07D4A000000000000000000000000000093C6000093
      C6000093C6000093C600DDFFFF0079E8FF0079E8FF0079E8FF0079E8FF0079E8
      FF0079E8FF0079E8FF003DB4D9000080B3000000000082828200FFF7F000FFF7
      F000FFF7F000FFF7F000FFF7F0008C8A88008C8A8800FFF7F000FFF7F000FFF7
      F000FFF7F000FFF7F00082828200000000000000000000000000000000000000
      00000000000082828200DDDDDD00C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600B5B5B500666666000000000000000000B5824F00E8B58200D3A0
      6D00CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600D3A06D00E8B58200B5824F00000000000000000000000000000000000000
      0000000000000097CA0024ADD700DDFFFF008EEDFF008EEDFF00B6F6FF00DDFF
      FF00DDFFFF00B6F6FF008EEDFF000086B9000000000087878700E3DFDB00FFF9
      F400FFF9F400FFF9F400FFF9F400B2AFAD00B2AFAD00FFF9F400FFF9F400FFF9
      F400FFF9F400E3DFDB0087878700000000000000000000000000000000000000
      0000000000000000000086868600DDDDDD00CBCBCB00CBCBCB00D4D4D400DDDD
      DD00DDDDDD00CBCBCB00BABABA007676760000000000BA875400EEBB8800F2D9
      BF00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEEDD00FFEE
      DD00F2D9BF00EEBB8800BA875400000000000000000000000000000000000000
      00000000000000000000009BCE00DDFFFF00A2F1FF00A2F1FF0051CEEE0000AA
      DD0000AADD0051CEEE00A2F1FF00008DC000000000008B8B8B00BEBCBA00FFFB
      F700FFFBF700FFFBF700FFFBF700B2B0AE00B2B0AE00FFFBF700FFFBF700FFFB
      F700FFFBF700BEBCBA008B8B8B00000000000000000000000000000000000000
      00000000000000000000000000008A8A8A00DDDDDD00CFCFCF00B4B4B4009999
      990099999900DDDDDD00CFCFCF008A8A8A0000000000BE8B5800F3C08D00FFF1
      E400FFF1E400FFF1E400FFF1E400FFF1E400FFF1E400FFF1E400FFF1E400FFF1
      E400FFF1E400F3C08D00BE8B5800000000000000000000000000000000000000
      00000000000000000000009FD200DDFFFF00B5F6FF00B5F6FF00009BCE000000
      0000009BCE00009BCE00B5F6FF000094C700000000009090900098989700E1E0
      DD00FFFDFA00FFFDFA00FFFDFA00D9D7D500D9D7D500FFFDFA00FFFDFA00FFFD
      FA00E1E0DD009898970090909000000000000000000000000000000000000000
      00000000000000000000000000008E8E8E00DDDDDD00D4D4D4008F8F8F000000
      00008E8E8E008E8E8E00DDDDDD008E8E8E0000000000C3905D00F8C59200FFF6
      EE00FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6EE00FFF6
      EE00FFF6EE00F8C59200C3905D00000000000000000000000000000000000000
      0000000000000000000000A2D500DDFFFF00C5F9FF00C5F9FF000086B9000086
      B9000086B900C5F9FF0063CAE700009BCE00000000000000000093939300A7A7
      A700E2E1E000FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00E2E1
      E000A7A7A7009393930000000000000000000000000000000000000000000000
      000000000000000000000000000091919100DDDDDD00D7D7D700808080008080
      80000000000091919100919191000000000000000000C6936000FCC99600FFFC
      F800FFFCF800FFFCF800FFFCF800FFFCF800FFFCF800FFFCF800FFFCF800FFFC
      F800FFFCF800FCC99600C6936000000000000000000000000000000000000000
      0000000000000000000000A5D8006AD1EC00DDFFFF00D3FDFF006ABAD5000077
      AA00D3FDFF009EE6F40000A1D400000000000000000000000000000000009797
      97009E9E9E00C5C5C500E7E7E7000000000000000000E7E7E700C5C5C5009E9E
      9E00979797000000000000000000000000000000000000000000000000000000
      000000000000000000000000000094949400DDDDDD00DBDBDB00C0C0C0007070
      70007070700000000000000000000000000000000000CA976400FFCC99000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFCC9900CA976400000000000000000000000000000000000000
      000000000000000000000000000000A8DB006FD4ED00DDFFFF00DDFFFF00DDFF
      FF006FD3EC0000A6D900DDFFFF00000000000000000000000000000000000000
      0000999999009999990099999900999999009999990099999900999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000097979700DDDDDD00DDDDDD00DDDD
      DD00666666000000000000000000000000000000000000000000CF9C6900FFD0
      A100FFD6AC00FFDCB900FFE2C400FFE6CC00FFE6CC00FFE2C400FFDCB900FFD6
      AC00FFD0A100CF9C690000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000AADD0000AADD0000AADD0000AA
      DD0000AADD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00FFFF0000000000008003000000000000
      0001000000000000000100000000000000010000000000000001000000000000
      0001000000000000000100000000000000010000000000000007000000000000
      0007000000000000800F000000000000C3FB000000000000FFF1000000000000
      FFFB000000000000FFFF000000000000E0000FFFC3C30000C00007FFC1830000
      C00003FFC0030000C00001FFC0030000C00080FFC0030000C001C07FE0070000
      C00FE03FC00300008007F01F800100008007F80F000000008007FC0700000000
      8007FE03000000008007FF01F81F0000C00FFF80F81F0000E01FFFC0FC3F0000
      F03FFFE0FC3F0000FFFFFFF1FC3F0000FFFFFFFF80078007E007E00700030003
      C003C003000300038001800100030003800180010003000380018001C003C003
      80018001C003C00380018001C003C00380018001C003C00380018001C003C003
      80018001C003C00380018001C003C00380018001C003C003C003C003C003C003
      E007E007C001C001FFFFFFFFE001E001FFFFFFFFFFFFFC3FE007FFFFC7E3F00F
      E007FFFF83C1E007E007FF9F8181C003E007FF8F80018001E007FF0FC0038001
      E007FF0FE0078000E007FE0FF00F0000E007E40FF00F0000E007E00FE0078000
      E007E01FC0038001E007E03F80018001E007E07F8181C003E007E03F83C1E007
      E007E03FC7E3F00FFFFFFFFFFFFFFE7F81FFFFFF8FFFFFFF01FFF00F07FFC003
      00FFE00703FF800100FFC00301FF800100FF800180FF8001C03F8001C07F8001
      C0038001E03F8001C0018001F0038001C0008001F8018001F8008001FC008001
      FC008001FE008001FC108001FE108001FC00C003FE098001FC01E187FE079FF9
      FE01F00FFF07C003FF07FFFFFF8FFFFF00000000000000000000000000000000
      000000000000}
  end
  object JvModernTabBarPainter1: TJvModernTabBarPainter
    Color = 16053492
    BorderColor = clBtnFace
    ControlDivideColor = clWindowFrame
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    DisabledFont.Charset = DEFAULT_CHARSET
    DisabledFont.Color = clGrayText
    DisabledFont.Height = -11
    DisabledFont.Name = 'Tahoma'
    DisabledFont.Style = []
    SelectedFont.Charset = DEFAULT_CHARSET
    SelectedFont.Color = clWindowText
    SelectedFont.Height = -11
    SelectedFont.Name = 'Tahoma'
    SelectedFont.Style = [fsBold]
    Left = 312
    Top = 136
  end
  object PostImages: TImageList
    Left = 188
    Top = 144
    Bitmap = {
      494C010111001300040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      000000000000000000000000000000000000000000000274AC000274AC000274
      AC000274AC000274AC000274AC000274AC000274AC000274AC000274AC000274
      AC000274AC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC00168ABE0041B5E40063D2
      F8004FC2F2004FC2F2004FC2F2004FC2F2004FC2F2004FC2F2004FC2F2004FC2
      F2002297C9000F83B90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC0035A9D8001D91C40071DC
      F90053C6F60053C6F60053C6F60053C6F60053C6F60053C6F60053C6F60053C6
      F600269BCD00B8F2F9000274AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC0059CBF7000274AC0098F5
      FC005ECFF8005ECFF8005ECFF8005ECFF8005ECFF80061D1F8005ECFF8005ECF
      F8002A9FD000B8F2F9000274AC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC005ECFF8000B7FB60071DC
      F90078E6FB006CDAF9006CDAF9006CDAF9006CDAF9006CDAF9006CDAF9006CDA
      F90030A4D400B8F2F900097DB400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC006CDAF9002A9FD0003BAF
      DF0098F5FC0074E2FA0074E2FA0074E2FA0074E2FA0074E2FA0074E2FA0074E2
      FA0035A9D800B8F2F900B8F2F9000274AC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC0074E2FA005CCDF7000F83
      B900D6F6FA00B8F2F900B8F2F900B8F2F900B8F2F900B8F2F900B8F2F900B8F2
      F90071DCF900D6F6FA00C3F3F9000274AC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC007DEBFC007DEBFC000B7F
      B6000274AC000274AC000274AC000274AC000274AC000274AC000274AC000274
      AC000274AC000274AC000274AC000274AC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC0083F1FD0084F3FD0084F3
      FD0083F1FD0084F3FD0084F3FD0083F1FD0084F3FD0083F1FD0084F3FD0084F3
      FD000273AB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000274AC00D6F6FA0089F6FD0089F6
      FD0089F6FD008BF7FD008BF7FD0089F6FD008BF7FD008BF7FD0089F6FD008BF7
      FD000273AB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000274AC00D6F6FA008EF7
      FD008EF7FD008EF7FD000274AC000274AC000274AC000274AC000274AC000274
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000274AC000274
      AC000274AC000274AC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBDDDB00BBB1AC008E847C0091837B00C2B4AF00EBDDDA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000364483002A3E8A00D8CFD200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A3999700B6C0C800B2CBD80095BDD0007FB6CD0087C4DE0080C9
      E3003897C0003C87A7000000000000000000000000000274AC000274AC000274
      AC000274AC000274AC000274AC000274AC000274AC000274AC000274AC000274
      AC000274AC000274AC000000000000000000000000000000000000000000EBDD
      DB00746C5C00534021007D573300A16B4400A56641008E4D2A00713619008D68
      5400ECDEDB000000000000000000000000000000000000000000000000000000
      000000000000000000004D5B93000226AA00143ABF0000108E00E9DDDC000000
      000000000000000000000000000000000000000000000000000000000000BCCB
      D6002BB4E8002DD9FF000F85A1000D83B70018AFED001BBCFC0020D2FF0023D6
      FF001F9FD600004E7300CACCD000000000000274AC0049BEEE000274AC0091EF
      FC004BBFF0004BBFF0004BBFF0004BBFF0004BBFF0004BBFF0004BBFF0004BBF
      F000289CCF009BECFA000274AC00000000000000000000000000DCCFCA00594D
      28009B7B4900DDA16900FFB47600FFC17D00FFBC7B00FFA66D00EC895A00BC5E
      3700863E1E00DFCEC80000000000000000000000000000000000000000000000
      000000000000000000000B2A9F00234FF5002852F6000F3DEC008089B8000000
      000000000000000000000000000000000000000000000000000064ADCE000BB9
      F50029DDFF0032E3FF002ED2F60015627E001F97CA0021A2D60025B0E50027BD
      EF0028B5E7001881AD00157DA900000000000274AC0051C4F3000274AC0095ED
      FB0054C8F50054C8F50054C8F50054C8F50054C8F50054C8F50054C8F50054C8
      F500289CCF009BECFA000274AC000000000000000000EADCD80070613400BE9C
      6400FFC38000FFEA9900F7CA8500B7946100B8926100F9C38000FFD48B00FFA2
      6B00E2744A009C462200EADAD700000000000000000000000000000000000000
      000000000000000000004F66CC001B4FFF002E69FF002861FF001638BF00F5E7
      E50000000000000000000000000000000000000000009FBDCD0006B7F8002FDC
      FF002CD3FF002BCFFF002BD0FF00219DCB0022A3D90026B6F00029C8FF0029C5
      FD0029C0FC001B7EA80000557A00DCD6D7000274AC005ACCF6000274AC009BEC
      FA005FD2F9005FD2F9005FD2F9005FD2F9005FD2F9005FD2F9005FD2F9005FD2
      F900289CCF00A2EDFA000274AC0000000000000000008E7E5800BB9F6200FFD0
      8800FFFAA3006F6543003535230071744F0070724D00323021007C664400FFDD
      9100FFA66D00E16E4200A45E3F00000000000000000000000000000000000000
      0000000000000000000000000000083BED002F73FF002E6BFF000938E300EBDE
      DD0000000000000000000000000000000000000000002F8FB90026D5FF0024AB
      D6001D89AA00229FBC002DD4FF001C87B0002099CC0025AAE3002BC8FB002DCE
      FB002ED7FF0025A6DD000A658900CDCDD0000274AC005FD2F9000274AC00A2ED
      FA006ADCFA006ADCFA006ADCFA006ADCFA006ADCFA006ADCFA006ADCFA006ADC
      FA0032A6D800AAEFFA000274AC0000000000E7D9D300A28D4F00F1C88400FFFF
      AB00615B3C0066664700FFFFC500FFFFC700FFFFC400FFFFBA0058583B00705C
      3D00FFDB9000FF956200C2552C00E6D3CE000000000000000000000000000000
      0000000000000000000000000000B2B5E4001B54FF003178FE00194FFA006673
      B10000000000000000000000000000000000D4D4D70017A4DB002DD7FF002BC8
      F4002DCFEF0029BBDB001B7B9A002093C30026B6F00022A9E20026B8F10025B5
      F00026BBF70022A5DA000047660078919C000274AC006ADCFA000274AC00AAEF
      FA0073E5FB0073E5FB0073E5FB0073E5FB0073E5FB0073E5FB0073E5FB0073E5
      FB0032A6D800AAEFFA000274AC0000000000CEBEAC00CCAE6900FFEE9C00C5BE
      7B0028271E00FFFFD200FFFFC200FFFFBD00FFFFBA00FFFFBB00FFFFBD002322
      1800D4AD7200FFB77800E36A3E00CDA799000000000000000000E0D5D300B2AD
      BB00AAA6B500B4AFB900D6CCCE00D3C9CA00153AC9002C66FF002D65FF00103B
      D70022357F00A6A3B60000000000000000007EA2B10014A4DD002BCBFF002CCE
      FF002DD4FF002FDEFF0028BAE7001359780023A7DE0024AAE10026B2E10027B9
      E20022A4D6000B6F990061818E00000000000274AC0071E2FB000274AC00C7F2
      FA00B8F2FC00B8F2FC00B8F2FC00B8F2FC00B8F2FC00B8F2FC00B8F2FC00B8F2
      FC005ACCF600C7F2FA000274AC0000000000B9A68100E7C67E00FFF6A100DEDF
      9500DAD99E00FFFFCB00FFFFC400FFFFC600FFFFC300FFFFBD00FFFFBC00D4D3
      8900E4C58200FFC17E00F67F4F00B47A610000000000DED4D600000056000327
      AE000B30C200062DC100052DBE00072CB1001937AD002C61FF002D67FF002A59
      FF001B45EA000022BC008186AB0000000000E2DAD90011678B001AB7F7002CCF
      FF002AC6FF002BCBFF002CD1FF001C88B40026C7FF0027CAFF002AD0FF002ACE
      FF002ACAFF00006C9A0091A4AC00000000000274AC0078E9FC000274AC000274
      AC000274AC000274AC000274AC000274AC000274AC000274AC000274AC000274
      AC000274AC000274AC000274AC0000000000BBAA8100F0CE8400FFF39E00FFFF
      B700FFFFD300FFFFDC00FFFFDB00FFFFCC00FFFFC600FFFFCA00FFFFC800FFFF
      B500FFEC9900FFBD7D00F6815300B0745C0000000000D6CDD100001887002B58
      FC00306AFF002E68FF002D5FFF002C5CFF001B37A700295CF0002C65FF00295E
      FF002C61FF002B5BFF000024B100AEACC00000000000EDE0DE0000648B000284
      B90021B9F7002DD3FF002DD5FF001B8EC2001764830010749B00056C9600086F
      970003678F00003A5400DFD7D700000000000274AC0084F1FD0084F1FD0084F1
      FD0084F1FD0084F1FD0084F1FD0084F1FD0084F1FD0084F1FD0084F1FD0084F1
      FD000273AB00000000000000000000000000D5C4AD00E8C67A00FFF39D00FFFF
      C200C2C08E004745340096927400FFFFDB00FFFFD300E3E1A80095936800FAF8
      A300FFEB9900FFBB7A00E4724200C7A19200EADEDD0048517D000C2A94001F44
      CE00224CD300214CD9001F44CF00224ADD0017349D001C3EAA003271FF003072
      FF002E69FF002D5FFF001D4EFD008F93BC000000000000000000EFE1DE00ADB1
      B500137CA80024C8FF002ED0F80016B1EB00CECFD400F5E7E400EBDDDA00E6DA
      D800E9DCDA00F2E3E00000000000000000000274AC00C7F2FA0089F4FD0089F4
      FD0089F4FD0089F4FD0089F4FD0089F4FD0089F4FD0089F4FD0089F4FD0089F4
      FD000273AB00000000000000000000000000E9DAD100D4B46B00FFF8A100D0D0
      8D0027251E00D1D1A9004C48370095937300FFFFDD00110B0B00000000004B44
      2F00FFF3A000FFAC7200BC562C00E2CFCA0070759A00001670002146D2002C5E
      FF002B5FFF002B60FF002650EC002650ED002142C5002147BA002150A800265E
      C5002659D2002E6BFF000D3CDD00E0D5DA000000000000000000000000000000
      0000DCD5D5000AA6E20030DDFF002AD7FF0025AFEA00F3E4E100000000000000
      000000000000000000000000000000000000000000000274AC00C7F2FA008DF2
      FD008DF2FD008DF2FD000274AC000274AC000274AC000274AC000274AC000274
      AC000000000000000000000000000000000000000000BEA66C00FFE69200A08F
      5E00BDC08300FFFFD900F2F3B10077755500FFFFD10051503800000000008876
      5000FFDC9100F4895600904E320000000000E8DCDD001A3186001B3BB9002B62
      FB002A5EF3002A5DFA00254FEA002249DA001C3AB3002D64FF00295FF100224C
      D0002553E2002A64FF001135BE00000000000000000000000000000000000000
      0000000000001994C80028D2FF0031DEFF0014C2FE0081BDD900000000000000
      00000000000000000000000000000000000000000000000000000274AC000274
      AC000274AC000274AC0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EADCD600C3A66000FFDF
      9100FFFEA500FFFFA700FFFFB200FFFFB600FFFFAF00FFFFAD00F5DB9000FFDD
      9200FFA56B0095492200E1D2CE0000000000D8CFD500001D890016339E002853
      F6002B61FF00295DFA002550EB002145D0001C3DAD002A5FFB002B60FF002D67
      FF002E6EFF00043DF6009DA2D100000000000000000000000000000000000000
      00000000000073A5BB0018C2FF002CCBFF002ACCFF000B91C900F2E3E0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E1D3C800B79C
      5A00E8C37B00FFDF9100FFEA9800FFEC9900FFE49500FFDB8F00FFCB8500F09B
      61008D4D2500CDBDB800000000000000000000000000939AC900072495002246
      C8002857F2002652EB00244FE900234ADF00183197002356C1003785FF00246C
      FF000D40E800A0A4D20000000000000000000000000000000000000000000000
      000000000000D9D4D5000083BC0025AFE80023AFE700006B9800EDDFDD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EADC
      D700A8966800AD925500CFA66600E7B47400EAAF7100D3945C00A16B3A007B5B
      4200E0D4D1000000000000000000000000000000000000000000000D7600183B
      C3001E5EFF001C5BFF001243F500113ADD001137CF000F2F92001741B0005D73
      D400E7DBDE000000000000000000000000000000000000000000000000000000
      0000000000000000000034748E000075A30000719F0046788D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E8DAD500C4B8A9009E907A00978A7500B6A99F00E0D3D0000000
      0000000000000000000000000000000000000000000000000000BFBCD2006371
      B900C1BFDA00D1CBDC00CEC8D800D5CDD900E6DADE00EBDFE000E9DAD7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009AA8B0006F8B9600F3E4E100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBDDDB00B5ACB1007E7987007D788800B7AEB500EADCDB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ECDEDC00C7B2B200A5838600A7828400CEB3B400EDDDDB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E4DCD500A5B29A006D8865006D896300A7B59B00E5DED5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBDDDB00B8AEB000867D8400877C8400BDB0B300EADCDB000000
      000000000000000000000000000000000000000000000000000000000000EBDE
      DB005255770005125500152073002B3086002B2F82001B1964000C0A4B004F4C
      7400EBDDDC00000000000000000000000000000000000000000000000000EDDE
      DC0095636B008B2A3700BB384600DB485600DF465400CB323F00AF222F00B55C
      6400EEDEDC00000000000000000000000000000000000000000000000000E7E0
      D8002C692900000600001E281B00282524002422210020291C00000700002F69
      2700E7E0D700000000000000000000000000000000000000000000000000EBDD
      DB00635E70002C224A00493362006545760066417100532C56003D1A3F006D55
      6C00EBDDDC000000000000000000000000000000000000000000D6CBCF000414
      670021309D00424ECA004A54DA004E55DC004E53D7004E4EC8004541AB002923
      7900100D5500D4C8CE0000000000000000000000000000000000E2CDCD00922F
      3C00D84C5D00FF697B00FF6F8200FF718500FF6F8200FF687C00FF5B6C00F23D
      4C00C7263300E7CBCB0000000000000000000000000000000000CED7C2000034
      00001D1D1A00DACDD800FFFFFF009E9B9D008E8B8D00FFFFFF00DAD0DB00211F
      1D0000270000CCD4BD00F5E7E500000000000000000000000000D9CDCE002F29
      58005B4A88008C6BB000A075BF00AA77C300AD74BF00A66CB000955A96006F38
      69004A1F4800D9CACD00000000000000000000000000E7DADB00081C8000364B
      D2005063FE005563FF005C66FF005F69FF006265FF006060FD005B59EB005851
      D30042399D00140F5F00E5D8D9000000000000000000EDDBDA00AD374700F663
      7600FF7D9200FF819800FF849D00FF879F00FF859C00FF7F9500FF768B00FF6A
      7E00FF4D5C00DD293700EED9D8000000000000000000E3E1D400004F0000281B
      2500736A7200FFFFFF00FFFFFF008887870079777700FFFFFF00FFFFFF007A73
      78002A1C280000390000E1DED1000000000000000000E8DBDA003B346D007665
      AB00AD89E000D19DFF00D99CFF00D998FA00DC95F600E294F300E18EEA00BE72
      BD008B4B800056235000E7D9D90000000000F6E7E400354397002F48D8003C4C
      C4004B59D2006F82FF006B78FF006E77FF006F77FF006F72FF007776FF00524E
      CA00433C94003B319800342F72000000000000000000BF5A6800F6607500FF82
      9800F6859D00FF9FBB00FF9AB500FF98B300FF96B200FF93AD00FF93AE00F677
      8C00FF6A7E00FF475600DD4550000000000000000000148814003B433900E1D7
      DF0058545400FFFFFF00FFFFFF00888787007A777700FFFFFF00FFFFFF005B59
      5800DDD7DD0044464100136505000000000000000000625889006F63AF00B695
      F500AB84DA0021192A00100B110019121A001A121900120C110021172200B771
      B900CF7AC700874379006C3F660000000000DFD4D9001730B7004C67FF004656
      C300000000004E57AF008090FF008591FF00878FFF008589FF005654B4000000
      00004B45B000584DC8001F167100DACED300ECD6D500E64F6300FF7E9400FF98
      B2001D121300995F7000FFB6D800FFB7D800FFB5D500FFAFCE00A05E6E001A10
      0F00FF819700FF637400F7314100EDD1D000DDE3CE00003E0000DFC9DD00DEDE
      DD004F4C4B00FFFFFF00FFFFFF008887870079777700FFFFFF00FFFFFF005552
      5200D8D8D700E6D7E600001D0000D9DBC800E3D5D8005C509C00A18BE700AB8A
      E40000000000533D5300DEA3DF00F8B0F800F8AEF800E39CE1005E3D5B000000
      0000BC71BA00B968AC006D2C6000E0D0D200A4A3CA002A47E200506AFF006A86
      FF00596ACF00120F15000F0A0D0015111900151219000F0C0D00120F13005F5C
      C9007671FF005C52D60033278A009B92B000E5ADB300FF677D00FF89A200FFA5
      C200D68BA3001C131400120C0C001F1617001F151600130C0C0019121300D27A
      8F00FF8DA600FF6E8100FF425200E89CA00098D090001C451B00FFFFFF00D5D5
      D40057555400FFFFFF00FFFFFF009191900082818000FFFFFF00FFFFFF005D5B
      5900CFCFCE00FFFFFF0023351C0090B48000B9ADC200776BC100B39BFF00AC89
      D600B389C100FFD3FF00FFCCFF00FFC6FF00FFC4FF00FFC1FF00FFC3FF00C67C
      C700BC73BD00CE77C50087407700B49AAA006570C0003C5AFA005471FF00667F
      FF007F98FF0092ABFF008394FF007480E100757EE100868CFF009A9EFF008987
      FF00706BFF006159E90043389F005C568A00E2839000FF789000FF91AB00FFA0
      BB00FFBEE000FFD6FC00FFB8D900E19EBB00E19CB700FFB0CF00FFC6EB00FFAD
      CA00FF8AA200FF758A00FF536300E06670004FB24C0040343E00EFD5EE00A991
      A800442D4400E5CFE600E2CCE300725C7300664F6600E2CDE400E4CFE7004931
      4800A48DA600EFDBF000483D4700468339008E83AF008E81DB00B69CFF00E1B5
      FF00FFCFFF00FFD3FF00FFCAFF00FFC8FF00FFC6FF00FFC1FF00FFC2FF00FFB7
      FF00FC9AFF00CF7BC9009A528B0088617F00626DC500405EFF005673FF006C8A
      FF00687DE500393F70006674C80093A3FF0095A1FF006C71CB003B3970006E6D
      E3007773FF00625BEF00443BA20056508500E6828E00FF7D9400FF95B000FFAE
      CE00E69CB800724E5B00CA91AA00FFCCF100FFC9EE00CE8CA60072495500E48B
      A300FF97B100FF788F00FF546500DE626A005EC25B0015711300166D13001F76
      190025771F0021701900247019002B7720002C78200025711700246F16002876
      1B00227514001A5C0D00174A0A00538E46008D83B2009385E400BCA3FF00E9BC
      FF00DFACE600C59AC500FFD8FF00FFD3FF00FFCEFF00FFCFFF00C68FC500E698
      E400FF9FFF00D47FD3009C538F00825D7A00A1A3D3003553FB005574FF007291
      FF0022263F00000000000A0603008EA0FF00929FFF000F0B0B0000000000211E
      36007C7BFF006059EB00332B9200968CA900EEADB400FF768F00F88FA800FFB8
      D9004B333A000000000000000000FFC0E200FFC0E20000000000000000004329
      2E00FF9EBB00F8728700FF485900E3979B00A2D5990029FF2B004AFF480055FF
      4F0061FF570067FF58006DFF5B006FFF59006FFF5A006FFF56006BFF510068FF
      4D005CFF430053F43A0029A3150096B38A00BAAFC9008D7FE200B09AFA00F8C9
      FF0064506A00000000003B303A00FFDDFF00FFD9FF0042344000000000006340
      6200FFAAFF00C678C5008C468200AE94A300DAD1DC002546EB00516FFF006785
      FF005C71D700363D6C00272A46007280DF007682E5002928460038386B006062
      D3006E6EFF005854D9001D177300D6CACF00F1D3D400FF708B00B26071004831
      3900FDA5C200573B4500AA758900FFC0E300FFBDDF00AF74870055363F00FA8F
      A9004E313800AE485400FF3A4C00EACDCC00DCDECE0018D8190045FF45001C4B
      1A004FF247006DFF6000327D290046B239004AB93B003176260071FF580054F9
      41001E4317004ADA340011760200D9D5CA00E1D4D9008778DC007367AB003D30
      3D00FFD8FF007E617F007D5E7A00FFD1FF00FFCFFF00805D7E007E557B00FFBA
      FF00472F49007749750078377200DCCBCD0000000000394FD1003E5CFF005B7B
      FF00799AFF005A6AC200110D0E007383F1007783F600110E1000585CBC008085
      FF006364FF003F3BAE00262263000000000000000000F66D8000FF89A4003C23
      2700563C4500FFC1E300FFC3E600FFADCB00FFAAC800FFB8DA00FFB0D1005D3B
      4300371D1F00FF607300CE3A4700000000000000000034C4350033FF330030AC
      2E001B33160033832C00192F15005DFF4E0060FF4F001A321600348228001D3D
      1700338E260034BC2200256F1B0000000000000000007C6FB900A594FB002823
      39004B3B4D00FFD2FF00FFDAFF00FFC0FF00FFBCFF00FFCCFF00FFBFFF005539
      5A00291C2800A561A8005D335A000000000000000000E1D6DD002041E7003D55
      D30019192A0012111C006276E9007589FF007586FF006571EE00141121001B17
      3000413FAA0014136F00DBCED1000000000000000000F1D8D700FE617900FF92
      AD00693C45000E0A0900E08EA600FFA5C400FFA2C000E488A100100D0B006533
      3A00FF738900DC2E3E00E8D1D0000000000000000000E5E1D50013C714003DFF
      3C0037C634002B87260050FB460058FF4A0057FF490051FF42002C8523003AAB
      2C003FD62F00096B0000E1D9D2000000000000000000E5D8DB007567C200B19C
      FF00494069000C090E00C89AE200F3B6FF00F4B0FF00D194E7000F0B11004B33
      5200BB78C90057285C00DED0D000000000000000000000000000CCC6DB00162E
      B100283AB1005975FF006078FF005D6FFF005D6DFF00626EFF005E67FF002A2F
      8A00080A5200C2B8C10000000000000000000000000000000000EECACB00F85B
      7000FF86A000FF889F00FF8EA800FF91AA00FF8DA600FF869D00FF7A8F00FF6E
      8500D02F3E00D9BCBC0000000000000000000000000000000000D4DBC60012BE
      15002CF22D0047FF430048FF410049FF3F0049FF3E004AFD3D004AF93C002FC4
      2400086D0100CCCBBF0000000000000000000000000000000000D6C9D4006B5F
      B400A38FF600AD91F000C09AFD00CB9BFF00CC98FB00C490ED00B580D300AB73
      C50050295C00C7B9BD000000000000000000000000000000000000000000E4D9
      DE004658C5001B37C3002E45D8004053E5004251DF002F3DC0001A248F00353A
      7B00DFD3D400000000000000000000000000000000000000000000000000EFDA
      D900DD6A7800EC566C00F9647A00FF708500FF6E8200FB5B6E00DE415200B048
      5400E5D5D300000000000000000000000000000000000000000000000000E9E0
      D9004DB34A0011B113001FC41E0031D02D0031CA2D0020AF1B000F870900407E
      3A00E6DBD600000000000000000000000000000000000000000000000000E7DA
      DB00736AA1006558A7007C68BA009076C6009272C1007F5DA6005D3E7C005543
      6300DFD3D2000000000000000000000000000000000000000000000000000000
      000000000000E3D6DA00A8A5BF006C719F006A6C9600A19CAE00DED2D2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ECD8D700D8ADB000C17F8700BA7B8100CAA4A600E5D4D2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E8DFD800B3C7A90077A9700075A26E00ADBAA300E5DAD6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E5D8D900B6ABB900857C95007F778E00ACA0AA00DFD2D1000000
      0000000000000000000000000000000000000000000040535C001B5D7D00185C
      7E00195C7C00195C7C00195C7C00195C7D00195C7D00195C7D00195C7C001A5C
      7C001A5E7E001D5C7A003F4B5400000000000000000000000000000000000000
      000000000000CFC4C300AA9C95009A806E009B806D00AD9D9500D0C5C3000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ECDEDC00C2B7B2009A9088009C908800C8BBB500ECDEDB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBDEDC00B7B6B600848F9000838E9000BBBABA00EADEDC000000
      000000000000000000000000000000000000345563000FB9F90031DCFF0033DC
      FF0033DCFF0034DCFF0034DEFF0038F2FF0038F0FF0034DDFF0034DBFF0035DB
      FF0035DDFF0033DCFF0014A7E50033424C00000000000000000000000000C8BD
      BC00A1744C00D6690800F4770B00FF811600FF7E1600FE6E0A00FA660700C87C
      4C00C6BCBA00000000000000000000000000000000000000000000000000ECDE
      DC00847E72006A5D460096755900B9886B00BF866A00A5684F0088533C009C7B
      6D00EDDFDC00000000000000000000000000000000000000000000000000ECDE
      DC005C7C800017586300296E7B003F808D00417C89002F6470001F4E58005D78
      7E00EBDFDD00000000000000000000000000206685002DE4FF0036DFFF0034DC
      FF0034DDFF0034DEFF0035E4FF0021728300247C900036E7FF0035DCFF0035DB
      FF0035DBFF0038E0FF0032D8FF001A4156000000000000000000B1A5A300E477
      0C00FF8C1000FFA42200FFB12500FFBD2700FFB62500FFA42200FF921F00FF78
      0C00FF6D0800B1A39F0000000000000000000000000000000000DFD3CE00706B
      4F00B2997700F0BE9900FFCDA500FFCEA400FFC29B00FFD9AE00FFAF8C00D37A
      5E009E5C4300E2D1CD0000000000000000000000000000000000D7D2D1001765
      72003592A20059B6C90067CADF0071D8ED0073D4E8006BBCCF005E9EAE004076
      810026566200D6D1D00000000000000000005D5D600015CAFF0036E1FF0034DB
      FF0034DBFF0034DCFF0036E2FF001A4B56001C58670038E8FF0035DBFF0035DA
      FF0035D8FF0038E2FF0019ACEA005E58590000000000C2B7B600FF860B00FFA1
      1D00FFB72700FFC82A00FCC62900C79C2000DFAE2400FFCA2A00FFB52500FFA2
      2200FF861700FF720700C0B5B3000000000000000000EBDEDA0087806000D4BC
      9400FFDFB200FFF0BF00FFFBC700FFFBCC006865510061524100F0CAA100FFD7
      AC00F6917300B3634900ECDCD9000000000000000000E7DDDC001C7A880048B2
      C50066D9F00080FFFF0072E0F10059A5B4005BA4B5007AD8EE0088EDFF0070B8
      C900568A98002B5E6B00E6DCDB0000000000000000003497C00029E0FF0035DD
      FF0034DCFF0034DBFF0038ECFF002DB2CB002EBAD30037EAFF0035DAFF0035DA
      FF0036DDFF002BD5FF00377595000000000000000000E8903A00FFA51600FFC0
      2900FFD02B00FFF131004B410D000000000000000000E9C42800FFD42D00FFBB
      2700FFA42300FF821100F87E2F000000000000000000A1987C00D1BF9500FFEC
      BB00FFFFCF00FFFFDA00FFFFE100FFFFE600FFFFEE00B9BBA20045443500AA95
      7700FFDCB100F78D6D00B8766000000000000000000047939F0041B6CA0069E8
      FD0083FFFF003A717000233634004873700048716F002233320045717E0090F5
      FF0075BCCF005184920047737D0000000000000000005655590015C9FF0036E3
      FF0034DBFF0033DCFF003AF9FF0015353F001A4C5A0039F8FF0035D9FF0035DB
      FF0038E3FF0017A8E50058514E0000000000BFB2AF00FFA10E00FFBF2800FFD5
      2C00FFE32F00FFF33300F1E32F00B9B02400CCBF2700FFF13200FFDE2E00FFCE
      2B00FFB82600FF9A2100FF790500BDAEAA00E9DCD700BAAE8400FCEAB900FFFF
      D300FFFFE500FFFFF000FFFFF800FFFFF700FFFFF500FFFFFC00FFFFF1005759
      4800977E6400FFC79E00D9745500E8D6D200E1DBDA002FA5B90060DFF90084FF
      FF0034615F003F646400A7FFFF00AEFFFF00B0FFFF00ACFFFF003A5956004167
      720093F4FF006DA9BA00376D7C00DCD6D50000000000000000003A91B60027E1
      FF0035DFFF0035DCFF003AFAFF00142A310018404B003AFAFF0035DAFF0036DE
      FF002AD4FF003B718F000000000000000000BB9A8000FFB21400FFCD2C00FFE2
      2F00FFF03200FFF93400FFFF3800CAC72A00FFFF3700FFFC3300FFE93000FFDB
      2D00FFC62900FFA92400FF810C00BE917800D6C9BC00E2D2A200FFFECB00FFFF
      E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      E1002A271F00FFCEA400F78C6C00D7B3A700ABC8CC0043C6DF0072FFFF0060C4
      C2001E252600ACFFFF00A4FFFF00A5FFFF00A7FFFF00ABFFFF00B2FFFF001C23
      210074C0D30080CDE1004D829100A5B0B4000000000000000000615B5F0014C9
      FF0036E4FF0035DDFF003AF4FF0010181900142C32003AF8FF0035DCFF0038E4
      FF0017A8E400645B5A000000000000000000D4954D00FFBF2000FFD72E00FFEC
      3100FFF93400FFFF3600FFFF3C0053541200B4B62500FFFF3E00FFF93400FFE2
      2F00FFCF2B00FFB42500FF8D1700D97C4200CEC1AA00F8E8B500FFFFDA00FFFF
      FF00D6D5D400B3B0B100FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4B2AB00DCDC
      C200FFFFE100FFDEB100FF9B7900C892800074B5C10056DEF60076FFFF0074DD
      DD007FD9D900A6FFFF00A6FFFF00AAFFFF00ACFFFF00ABFFFF00B0FFFF0085D4
      D30081DBE60084D7ED005D95A3006B8B91000000000000000000000000003A90
      B40027E1FF0037E3FF0037EBFF000E090800121C1F0038F0FF0037E2FF0028D3
      FF003C708C00000000000000000000000000D9974900FFC52200FFDB2D00FFF0
      3200FFFF3400FFFF3900FFFF3E00DADA2F000000000078781900FFFF3500FFF3
      3200FFD22B00FFB62700FF8F1900DA793C00D3C5AC00FDF1BB00FFFFF7009290
      89000000000000000000221D1C00FFFFFF00FFFFFF0027222100000000000000
      0000908D7200FFFBC900FE9E7D00C58E7D0071B9C60059E6FD0074FFFF008AFF
      FF00A0FFFF00AFFFFF00B0FFFF00ADFFFF00AFFFFF00B5FFFF00B8FFFF00ACFF
      FF0097FFFF0081D4EB005F97A60066868D000000000000000000000000006761
      620016C7FF0037E9FF0037E6FF00080000000C06060038EEFF0038E6FF0017A3
      E0006B605E00000000000000000000000000BE9D7C00FFC31900FFDA2E00FFF0
      3200FFFF3800C8C82A00D3D32D00FFFF4200717118000000000025240700FFF0
      3200FFD52B00FFB52600FF850D00BF8E7300E0D2C100FFF7BF00FBFBD6000000
      000005010200120E0E0000000000A2A09F00ABA9A70000000000130E0E000704
      060000000000F8D1A700FC997700D2AFA300AACDD4004FE0F80070FFFF008BFF
      FF0091FBFC005C94940091DEDE00B4FFFF00B5FFFF0098E1E2006092930099FB
      FA0096FFFF007DD0E7004E8897009FABAF000000000000000000000000000000
      00003E87AA0025E2FF0038E5FF0022748700237D920039EAFF0026D1FF003F6A
      820000000000000000000000000000000000BDAEAA00FFBD1200FFD32D00FFF5
      3300DFD92D000000000000000000FFFF3E00E4E32F000000000000000000D3B6
      2500FFD72C00FFAC2400FF780300BAAAA600EEE0DA00FFFAC200D3D1AA000000
      0000000000000000000000000000635F5F006B68670000000000000000000000
      000000000000D29E7F00F1906D0000000000DDDDDD0040CFE9006BFEFF008EFF
      FF0032505000000000000C060600ADFFFF00B1FFFF00110C0E0000000000314A
      490099FFFF0075C2D700356E7D00D8D2D2000000000000000000000000000000
      0000766C6C0017C6FF0037E8FF0039F3FF0039F1FF0037E5FF0018A1DC00796E
      6A000000000000000000000000000000000000000000FFAD3400FFC72100FFE0
      2F00FFF4320036340A0002040100D0D22D0047490F0000000000645A1200FFE2
      2F00FFBE2800FF951600FA77260000000000AFA4A300726A540081785F004443
      39004D4A45004E4B490045434100686564006B66640046413E004F4B42004E4C
      3E00473D33007E5341005C3A2E00AEA5A400000000004EBBCF0058EBFF007FFF
      FF004D8F8D000000000030474700A7FFFF00A9FFFF00364E4E00000000004D82
      8A0089F4FF0059A1B1003A646F00000000000000000000000000000000000000
      0000000000004283A20024DFFF0037DFFF0037E1FF0024CDFF0042677D000000
      00000000000000000000000000000000000000000000BCAFAD00FFB51100FFC9
      2700FFE13000FFFF3500EAD82C00C1B02300C3B02400F9DB2D00FFEE3200FFC5
      2900FFA52000FF710200B7ABA9000000000000000000F4E6E000ECDCA800FFFF
      E100FFFFFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFEE00FFFF
      D700FFDEB000C0765800EBDBD7000000000000000000E3DEDE0037BFD80062F2
      FF007FFFFF007DF8F60092FFFF0092FFFF0092FFFF0095FFFF0080EFF80085F5
      FF0067BCCF0027616E00DDD4D300000000000000000000000000000000000000
      0000000000007D71710015C4FE0038E9FF0038E6FF00179ED9007F726F000000
      0000000000000000000000000000000000000000000000000000B19F9800FFAE
      1100FFBE1D00FFCE2B00FFDF2F00FFE42F00FFE12F00FFD12C00FFBB2700FFA0
      1800FF730400AA97920000000000000000000000000000000000E6D9D100CFBF
      9100F7E8B200FFFECB00FFFFD200FFFFD500FFFFCF00FFFAC500FFE6B500FCB9
      9200A66A4E00D3C3BE0000000000000000000000000000000000D0D7D90035B4
      CC0054DDF40071FDFF0079FFFF007AFFFF007CFBFF007BF2FF0077E2F90058B2
      C50025657200C5C2C20000000000000000000000000000000000000000000000
      00000000000000000000447C950017DDFF0016C6FF0046627400000000000000
      000000000000000000000000000000000000000000000000000000000000BDB1
      B000EA983E00FFA61100FFAD1600FFB42100FFAF2100FFA01500FF880C00CD75
      3300B8ADAD00000000000000000000000000000000000000000000000000ECDE
      DA00BCAE9100C4B48900E0CA9B00F4D6A800F8D0A400E5B58C00B98A69008F74
      5F00E3D5D200000000000000000000000000000000000000000000000000E5DE
      DD0053A8B70032AAC00045BED60058CBE3005AC6DD0048ADC0002E8292004170
      7900E0D5D4000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003A708A003B63760000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6B9B700B3988600B3825A00AE7F5700AB928300C2B6B4000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EADDD800CDC1B600ACA29200A69A8B00BFB3AA00E2D6D2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E4DCDB00AEBFC200779FA50074989D00A7B1B300DFD5D4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000443F
      3F007A797500918F8B004D4C480039383400474342006D66650091888600B8AD
      AA00DFD1CE000000000000000000000000000000000000000000000000000000
      000000000000EBDEDB00B8B5A700848E7000838E6E00BAB8A700EADED9000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C9B8B700C6A5A500C8A09F00CDADAC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002F2C
      2B00CDCDCB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DADAD700A7A7A400706F
      6B003C3A38001D1C1900D4C7C40000000000000000000000000000000000EADD
      D9005A79420018540000296B00003F7C0000407800002E6000001F4B00005C75
      3600EBDFD9000000000000000000000000000000000000000000000000000000
      0000000000006865650098808000B8949400BA8F8F00A26F6F006A4040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001D1B
      1A00E9E9E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E4D8D3000000000000000000D7D1C4001660
      0000358D000058B2000062BC000067BE000068BA000067AF00005D9900004171
      000026530000D6D0C00000000000000000000000000000000000000000000000
      0000000000007E7373005B4D4D006C5858006E55550064494900725A59000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0D2CF001211
      1100FFFFFF00E6DDDD00E4DAD800EDE6E600F4F1F000F9F7F800FDFEFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F2E3E00000000000E6DCD3001C7600004AAD
      000065CE000070DF00007FF2000090FF000092FF000088ED000078C900006EAF
      0000568600002B5C0000E3DAD000000000000000000000000000000000000000
      0000DCCFCD00A48E8E00A38888009876760099747400A3878700A38F8F00DCCE
      CD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8BCB9001616
      1400FFFFFF00DDD3D200D8CCCB00D9CBCA00DACFCE00D0C7C700EBE9E900FFFE
      FF00FFFFFF00FFFFFF00ECEAE700F6E7E400000000003E8B030043B1000067DA
      000077F200008AFF000060B10300273F0900344F08006CB603009EFF000082D4
      000072B2000053820000436C000000000000000000000000000000000000C4B6
      B600AF9C9C00E5BCBC00FFD1D200DEB2B100DEACAD00FFCECE00E5B4B400B294
      9400C3B3B2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AFA5A2002929
      2700FFFFFF00D7CDCD00D4CBCA00D6CBCC00E0D8D700DAD2D200D7D1CF00D5D1
      D100C8C3C100FCFBFD00DCD6D20000000000DDD9C8002EA0000060D7000076F9
      000084FF000093FF00009FFF0000384F09000000100000000E006FB60300A5FF
      000082D200006DA40000396A0000DAD4C3000000000000000000D7C8C700B5A2
      A200EEC1C100E6D3D3008EF3F50067FCFC006AFCFC0090F4F400E7CCCC00F0B4
      B400B8979700D4C5C40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000948B89004241
      3F00FFFFFF00D3CCCB00DBD6D500D5CCCB00D5CCCB00C8BEBC00D0C8C800F4F2
      F300FCFCFC00FFFFFF00DBD2CD0000000000A2C17C0046C200006CF2000085FF
      000099FF0000A5FF0000B3FF0000C9FF00005D85060000000D0000000E0067A8
      0400A3FF00007ABE00004E8000009AA971000000000000000000B1A0A000E3C0
      C000ECD5D50063FFFF005AFFFF006FFFFF0070FFFF0060FFFF006AFFFF00EFCD
      CD00E4B2B200AF93930000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000078716F005F5F
      5A00FFFFFF00FEFDFE00FFFFFF00FFFFFF00FDFDFC00F7F6F600EAE7E600D6D2
      D000FEFEFE00FFFFFF00E8DBD7000000000066AE290058D900007EFF00003964
      080010080C001A1E0B001A1D0B001E210A0027320A000F0A0C000B040C000000
      0E00548306008ADA0000619400006180240000000000E4D6D400C4B0B000FECA
      CA00A0F1F1005AFFFF007AFFFF007DFFFF007FFFFF007FFFFF0063FFFF00A5ED
      ED00FFBCBC00C19E9E00E2D3D100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005D5856008182
      7D00FFFFFF00C6BEBE00D1CACA00D5CDCD00E3DCDE00DCD6D600F5F5F500FFFF
      FF00FFFFFF00FFFFFF00F5E7E5000000000061B020005DE1000082FF00002841
      090000000F0000000D0000000D0000000D0009000D000F0A0C00100B0C000000
      0E002F4209008BDF0000639700005A7B1C0000000000CEBEBD00D5BFBF00FFD1
      D2007CFCFC006DFFFF007EFFFF0083FFFF0083FFFF0083FFFF0074FFFF0081FB
      FB00FFC3C300D2ABAB00C7B5B400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F5E7E40047424100A6A7
      A300FFFCFC00D2CACA00D2CDCD00CCC5C500CBC3C300C1B9B900F8F8F600FFFF
      FF00FFFFFF00EAE9E600F5E7E400000000009AC66C0052DB000076FF00007DEC
      000085E101008FE7010097E80100B2FF00006B9D050007000C0000000E004162
      0700A2FF000082D30000538800008D9E620000000000CAB9B800D9C2C200FFD3
      D3008EF9F90069FFFF0080FFFF0083FFFF0086FFFF0084FFFF0071FFFF0092F7
      F700FFC6C600D5AEAE00C3AFAE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E8D9D6002E2B2A00C8C8
      C500F0EBEC00C8BFBF00C7C0C000C7C0C000D4CFCE00D0C7C700D7D0CF00D7CE
      CF00FFFFFF00DED9D6000000000000000000D5D9BB0041CA00006CF9000084FF
      000096FF0000A3FF0000BBFF000076B1030000000D0000000E00486E0700ABFF
      00008FF3000075BF0000396E0000CFCBB70000000000DECECD00D0BCBC00FDD2
      D200D6EBEB005AFFFF007AFFFF0083FFFF0084FFFF007EFFFF0062FFFF00D7E2
      E200FFC4C400C9A5A500D5C6C400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5C8C60022201F00E3E5
      E300FFFFFF00E2DDDD00E5E1E000E8E4E300E0D9D800DAD5D400DED8D700D3CB
      CA00FFFFFF00D9D3CE000000000000000000F3E4E10047B600005CE6000075FF
      000085FF000098FF00006DB1040004000D0009000E004C750600ABFF000090FD
      00007ED600005EA20000335E0000F3E4E1000000000000000000C2AEAE00E8CE
      CE00FFD9D900BBF3F30069FFFF0068FFFF006AFFFF006DFFFF00BBEFEF00FFCD
      CD00E9BFBF00B193930000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0B4B10025252200FFFF
      FF00EFEEEE00F0F0F000F7F6F600F4F2F400EEEDEE00F6F4F400F6F6F600FFFF
      FF00FFFFFF00D9D1CC00000000000000000000000000D7DABF0039BD000064EA
      000076FF000084FF000087FC000096FF000099FF00009AFF00008AFC00007CDD
      00006AB800002A630000CFCABA00000000000000000000000000C8B7B600D1BB
      BB00F0D2D200FFD9D900F5E5E500CEEDED00CFECEC00F5DFDF00FFCFCF00F2C6
      C600CCA9A900B29F9F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009D94920035353200FFFF
      FF00A09A9A00AAA5A500B6ADAE00ACA6A600CDCAC800D0CCCB00D2D0D000FFFF
      FF00FFFFFF00DCD1CD0000000000000000000000000000000000C0D0A00036B2
      000057D900006FF100007AFC00007EFF00007EF900007AEA000073D500005DB0
      000027660000B2B49A0000000000000000000000000000000000F3E4E100BBA8
      A800D2BCBC00EBCFCF00FED4D400FFD4D400FFD2D200FECECE00EBC7C700CEAE
      AE00A48E8E00F2E3E10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B0A5A30082817C00FFFF
      FF00D6D3D200E5E2E100DFDCDC00EFECEC00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E2D6D1000000000000000000000000000000000000000000DCDA
      C60041A0010034A900004ABE00005CC900005CC400004CAD0000328400003065
      0000D4CCC300000000000000000000000000000000000000000000000000F2E4
      E100BCACAC00BDAAAA00D1BABA00DDC4C400DDC2C200D0B4B400B69E9E00AB9A
      9A00F1E3E0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E5DFDB00E4DEDA00DED8D300DCD4D000E3DBD600DED6D100DDD4
      D000D9D2CE000000000000000000000000000000000000000000000000000000
      000000000000D9D6C5009CB67D0069974000668F400094A57900D2CCC1000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7DAD800CBBDBC00B7A8A800B5A6A500C6B7B600E4D7D5000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF0080070000000000000003000000000000
      0001000000000000000100000000000000010000000000000000000000000000
      0000000000000000000000000000000000070000000000000007000000000000
      800F000000000000C3FF000000000000FFFF000000000000FFFF000000000000
      FFFF000000000000FFFF000000000000F81FFE3FF8038003E007FC1FE0010001
      C003FC1FC00100018001FC0F800000018001FE0F800000010000FE0F00000001
      0000C003000100010000800100010001000080008001000700000000C0030007
      00000000F03F800F80010001F83FC3FF80010001F81FFFFFC0038003F81FFFFF
      E007C007FC3FFFFFF81FC01FFE3FFFFFF81FF81FF81FF81FE007E007E007E007
      C003C003C001C003800180018001800100018001800180010000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000080018001800180018001800180018001C003C003C003C003
      E007E007E007E007F81FF81FF81FF81F8001F81FF81FF81F0000E007E007E007
      0000C003C003C003000080018001800180018001800180018001000000000000
      C003000000000000C003000000000000E007000000000000E007000000000000
      F00F000000010000F00F800100008001F81F800180018001F81FC003C003C003
      FC3FE007E007E007FE7FF81FF81FF81FFFFFE007F81FFC3FFFFFE001E007F81F
      FFFFE000C003F81FFFFFC0008001F00FFFFFC0008001E007FFFFC0010000C003
      FFFFC0010000C003FFFFC00100008001FFFFC00100008001FFFF800100008001
      FFFF800300008001FFFF80030000C003FFFF80038001C003FFFF8003C003C003
      FFFF8003E007E007FFFFF807F81FF81F00000000000000000000000000000000
      000000000000}
  end
  object ErrorTimer: TTimer
    Enabled = False
    Interval = 2500
    OnTimer = ErrorStatusTimerTimer
    Left = 152
    Top = 152
  end
  object StatusTimer: TTimer
    Interval = 3000
    OnTimer = ErrorStatusTimerTimer
    Left = 152
    Top = 192
  end
  object ApplicationEvents1: TApplicationEvents
    OnShowHint = ApplicationEvents1ShowHint
    Left = 32
    Top = 152
  end
  object TrayPopup: TPopupMenu
    Images = ActionImagesSmall
    Left = 112
    Top = 152
    object TrayFetchMenuItem: TMenuItem
      Action = FetchDataAction
    end
    object TraySettingsMenuItem: TMenuItem
      Action = SettingsAction
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object TrayCloseMenuItem: TMenuItem
      Action = CloseAction
    end
  end
  object Notifier: TNLDNotifier
    TextColor = clBlack
    LinkColor = clBlack
    TopColor = clBlack
    BottomColor = clBlack
    Timeout = 0
    Enabled = True
    OnClick = NotifierClick
    Left = 264
    Top = 144
  end
  object Tracker: TNLDXMLData
    OnNewData = TrackerNewData
    OnError = TrackerError
    UpdateTimer = 0
    URL = 'http://www.nldelphi.com/DeX'
    OnDataChange = TrackerDataChange
    BeforeUpdate = TrackerBeforeUpdate
    AfterUpdate = TrackerAfterUpdate
    UserAgent = 'DeX 3'
    Left = 224
    Top = 144
  end
  object MainMenu1: TMainMenu
    Images = ActionImagesSmall
    Left = 112
    Top = 232
    object Bestand1: TMenuItem
      Caption = 'Bestand'
      object Instellingen1: TMenuItem
        Action = SettingsAction
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Verbergen1: TMenuItem
        Action = HideAction
      end
      object Afsluiten1: TMenuItem
        Action = CloseAction
      end
    end
    object Server1: TMenuItem
      Caption = 'Server'
      object Aanmelden1: TMenuItem
        Action = LoginAction
      end
      object Ophalenvanaf1: TMenuItem
        Action = FetchDataAction
      end
    end
    object Regel1: TMenuItem
      Caption = 'Regel'
      object Lezen1: TMenuItem
        Action = OpenAction
      end
      object Toevoegen1: TMenuItem
        Action = AddToFavoritesAction
        ImageIndex = 14
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Verwijderen1: TMenuItem
        Action = DeleteAction
      end
      object Verwijderthread1: TMenuItem
        Action = DeleteThreadAction
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Opslaan1: TMenuItem
        Action = SaveAction
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Info1: TMenuItem
        Action = InfoAction
      end
    end
  end
end
