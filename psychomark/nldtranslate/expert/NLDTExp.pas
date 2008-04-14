unit NLDTExp;

interface
  procedure Register;

implementation
uses
  ToolsAPI,
  ToolsAPITools,
  DesignIntf,
  Windows,
  CommCtrl,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Menus,
  FTranslate,
  MImages;

type
  TEventHandler = class(TObject)
  public
    procedure TranslateFormClick(Sender: TObject);
    procedure UpdateMenu(Sender: TObject);
  end;


var
  FEventHandler:        TEventHandler;

  FNLDTMenu:            TMenuItem;
  FNLDTTranslateForm:   TMenuItem;
  FImages:              TdmImages;

procedure Register;
  // GRAAAAAAWL! :yell:
  //
  // Yes, I mean that. Somehow, setting SubMenuImages won't work in the IDE.
  // It seems even GExperts uses bitmaps, so I'll use it too... *sigh*
  procedure SetImageIndex(const AMenu: TMenuItem;
                          const AImageIndex: Integer);
  begin
    AMenu.ImageIndex  := -1;
    FImages.ilsMenu.GetBitmap(AImageIndex, AMenu.Bitmap);
  end;

var
  pMain:        TMainMenu;
  pTools:       TMenuItem;
  pSubItem:     TMenuItem;

begin
  FEventHandler   := TEventHandler.Create();
  FImages         := TdmImages.Create(nil);

  // Find main menu
  pMain := (BorlandIDEServices as INTAServices).MainMenu;

  if Assigned(pMain) then begin
    // Create NLDTranslate menu item
    FNLDTMenu               := TMenuItem.Create(nil);
    FNLDTMenu.Caption       := '&NLDTranslate';
    FNLDTMenu.OnClick       := FEventHandler.UpdateMenu;

    // Create subitems
    FNLDTTranslateForm  := TMenuItem.Create(FNLDTMenu);
    with FNLDTTranslateForm do begin
      Caption           := '&Translate form';
      OnClick           := FEventHandler.TranslateFormClick;
      SetImageIndex(FNLDTTranslateForm, 0);
    end;
    FNLDTMenu.Add(FNLDTTranslateForm);

    pSubItem              := TMenuItem.Create(FNLDTMenu);
    with pSubItem do begin
      Caption             := '-';
    end;
    FNLDTMenu.Add(pSubItem);

    pSubItem              := TMenuItem.Create(FNLDTMenu);
    with pSubItem do begin
      Caption             := '&Repository';
      Enabled             := False;
    end;
    FNLDTMenu.Add(pSubItem);

    // Check for 'Tools' item
    pTools  := pMain.Items.Find('Tools');
    if Assigned(pTools) then
      pMain.Items.Insert(pTools.MenuIndex + 1, FNLDTMenu)
    else
      // No 'Tools' item found, just add it at the back
      pMain.Items.Add(FNLDTMenu);

    FNLDTMenu.SubMenuImages := FImages.ilsMenu;
  end;
end;


{****************************************
  TEventHandler
****************************************}
procedure TEventHandler.UpdateMenu;
var
  otaFormEditor:      IOTAFormEditor;

begin
  // Get active form editor
  otaFormEditor := GetActiveFormEditor();
  try
    FNLDTTranslateForm.Enabled  := (otaFormEditor <> nil);
  finally
    otaFormEditor := nil;
  end;
end;

procedure TEventHandler.TranslateFormClick;
var
  otaFormEditor:      IOTAFormEditor;

begin
  // Get active form editor
  otaFormEditor := GetActiveFormEditor();
  try
    if otaFormEditor <> nil then begin
      // Show translation form
      with TfrmNLDTTranslate.Create(nil) do begin
        Editor  := otaFormEditor;
        ShowModal();
        Free();
      end;
    end;
  finally
    otaFormEditor := nil;
  end;
end;


initialization
finalization
  // Remove menu item
  FreeAndNil(FNLDTMenu);
  FreeAndNil(FImages);

  // Remove event handler
  FreeAndNil(FEventHandler);

end.
