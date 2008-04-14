unit ToolsAPITools;

interface
uses
  ToolsAPI;
  
  function GetActiveFormEditor: IOTAFormEditor;

implementation

function GetActiveFormEditor;
var
  otaModule:      IOTAModule;
  otaEditor:      IOTAEditor;
  iModule:        Integer;

begin
  Result    := nil;
  otaModule := (BorlandIDEServices as IOTAModuleServices).CurrentModule;

  if otaModule <> nil then begin
    for iModule := 0 to otaModule.GetModuleFileCount - 1 do begin
      otaEditor := otaModule.GetModuleFileEditor(iModule);
      otaEditor.QueryInterface(IOTAFormEditor, Result);

      if Result <> nil then
        break;
    end;
  end;
end;

end.
