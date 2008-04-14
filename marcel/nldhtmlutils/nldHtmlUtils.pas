1111
unit NLDHtmlUtils;

interface

uses
  Contnrs, SysUtils, Classes;

type
  TFontStyle = (hsBold, hsItalics);
  TFontStyles = set of TFontStyle;
  TCellAlign = (caDefault, caLeft, caRight, caCenter, caJustify, caChar);
  TVCellAlign = (vcaDefault, vcaTop, vcaCenter, vcaBottom);
  TInputType = (itText, itPassword, itCheckbox, itRadio, itSubmit,
    itReset, itFile, itHidden);
TFormMethod = (fmGet, fmPost);

  TNLDHtmlTable = class;
  TNLDHtml = class;
  TNLDHtmlObject = class;
  TNLDHtmlList = class;
  TNLDHtmlInput = class;
  TNLDHtmlSelect = class;
  TNLDHtmlForm = class;
  TNLDHtmlChart = class;
  TNLDTextArea = class;
  TNLDHtmlParagraph = class;

  TNLDHtmlClass = class of TNLDHtml;

  TChartItem = class
  private
    FValue: Integer;
    FText: string;
  public
    property Value: Integer read FValue write FValue;
    property Text: string read FText write FText;
  end;

  { Classe om Html items aan te maken. Ervende classen zullen de uiteindelijke
    invulling geven, bijvoorbeeld documents, tables ([TNLDHtmlTable]) enz. }
  TNLDHtml = class(TObject)
  private
    FOwner: TNLDHtml;
    FItems: TObjectList;
    FText: string;
    FTag: string;
    FCssClass: string;
    FWriteAllowed: Boolean;
    FPrepared: Boolean;
    FExtraParams: string;
    procedure SetText(const Value: string);
  protected
    function AddItem(ItemClass: TNLDHtmlClass): TNLDHtml;
    function InternalExtraParams: string; virtual;
  public
    property Text: string read FText write SetText;
    property Owner: TNLDHtml read FOwner;
    property CssClass: string read FCssClass write FCssClass;
    property ExtraParams: string read FExtraParams write FExtraParams;

    constructor Create(AOwner: TNLDHtml); virtual;
    destructor Destroy; override;

    procedure Clear; virtual;
    procedure AddText(const Text: string); virtual;
    procedure AddComment(const Text: string); virtual;
    procedure AddHyperlink(const Address: string; Text: string = '';
      NewPage: boolean = False);
    procedure AddLine(Line: string); virtual;

    procedure Prepare; virtual;
    procedure OpenFontStyles(Styles: TFontStyles);
    procedure CloseFontStyles(Styles: TFontStyles);
    procedure AddHorLine; virtual;
    function AddTable: TNLDHtmlTable;
    function AddChart: TNLDHtmlChart;
    function AddForm: TNLDHtmlForm;
    function AddInput: TNLDHtmlInput;
    function AddSelect: TNLDHtmlSelect;
    function AddTextArea: TNLDTextArea;
    function AddList: TNLDHtmlList;
    function AddParagraph: TNLDHtmlParagraph;
    function AddObject: TNLDHtmlObject;
    function AddSiteMap(const Name, Local, FrameName: string): TNLDHtmlObject;
    procedure AddImage(const ImageSource: string; Text: string = '';
      Target: string = ''; Border: Integer = 0; Width: string = '';
      Height: string = '');
  end;

  TNLDHtmlParagraph = class(TNLDHtml)
  public
    constructor Create(AOwner: TNLDHtml); override;
  end;

  TNLDHtmlAnchor = class(TNLDHtml)
  public
    procedure Prepare; override;
  end;

  TNLDHtmlPar = class(TNLDHtml)
  private
    FPreformatted: Boolean;
  public
    property Preformatted: Boolean read FPreformatted write FPreformatted;
    procedure AddLine(Line: string); override;
    procedure Prepare; override;
    constructor Create(AOwner: TNLDHtml); override;
  end;

  TNLDHtmlParam = class(TNLDHtml)
  private
    FValue: string;
    FName: string;
  public
    procedure Prepare; override;
    property Name: string read FName write FName;
    property Value: string read FValue write FValue;
  end;

  TNLDHtmlListItem = class(TNLDHtml)
  public
    constructor Create(AOwner: TNLDHtml); override;
  end;

  TNLDHtmlList = class(TNLDHtml)
  public
    constructor Create(AOwner: TNLDHtml); override;
    function AddListItem: TNLDHtmlListItem;
  end;

  TNLDHtmlObject = class(TNLDHtml)
  private
    FObjectType: string;
    FClassID: string;
  public
    property ObjectType: string read FObjectType write FObjectType;
    property ClassID: string read FClassID write FClassID;
    constructor Create(AOwner: TNLDHtml); override;
    procedure Prepare; override;
    function AddParam(const Name, Value: string): TNLDHtmlParam;
  end;

  TNLDHtmlBody = class(TNLDHtml)
  public
    constructor Create(AOwner: TNLDHtml); override;
    function AddPar: TNLDHtmlPar;
    function AddAnchor: TNLDHtmlAnchor;
    procedure AddAnchorText(AnchorText: string; cssClassName: string = '');
  end;

  TNLDHtmlTitle = class(TNLDHtml)
  private
  public
    constructor Create(AOwner: TNLDHtml); override;
  end;

  TNLDHtmlHead = class(TNLDHtml)
  private
    FTitle: TNLDHtmlTitle;
  public
    constructor Create(AOwner: TNLDHtml); override;
    property Title: TNLDHtmlTitle read FTitle;
  end;

  TNLDHtmlPage = class(TNLDHtml)
  private
    FBody: TNLDHtmlBody;
    FHead: TNLDHtmlHead;
    FFileName: string;
    FFramePage: Boolean;
    function GetTitle: string;
    procedure SetTitle(const Value: string);
  public
    property Body: TNLDHtmlBody read FBody;
    property Head: TNLDHtmlHead read FHead;
    property FileName: string read FFileName write FFileName;
    property Title: string read GetTitle write SetTitle;

    constructor Create(AOwner: TNLDHtml); override;
    procedure Save;
    procedure AddFrame(const Name, Target, Source: string;
      MarginWidth: string = '');
    procedure AddRedirect(const URL: string; Timeout: Integer);
  end;

  TNLDHtmlTableCol = class(TNLDHtml)
  private
    FHeader: Boolean;
    FAlign: TCellAlign;
    FColSpan: string;
    FWidth: string;
    FVAlign: TVCellAlign;
    procedure SetHeader(const Value: Boolean);
  public
    constructor Create(AOwner: TNLDHtml); override;
    function InternalExtraParams: string; override;

    property Header: Boolean read FHeader write SetHeader;
    property Align: TCellAlign read FAlign write FAlign;
    property VAlign: TVCellAlign read FVAlign write FVAlign;
    property ColSpan: string read FColSpan write FColSpan;
    property Width: string read FWidth write FWidth;
  end;

  TNLDHtmlTableRow = class(TNLDHtml)
  private
    FHeader: Boolean;
  public
    constructor Create(AOwner: TNLDHtml); override;
    function AddCol: TNLDHtmlTableCol;
    property Header: Boolean read FHeader write FHeader;
  end;

  TNLDHtmlTable = class(TNLDHtml)
  private
    FCellSpacing: string;
    FCellPadding: string;
    FWidth: string;
  protected
    function InternalExtraParams: String; override;
  public
    constructor Create(AOwner: TNLDHtml); override;
    function AddRow: TNLDHtmlTableRow;
    procedure AddStrings(Strings: Variant); overload;
    procedure AddStrings(Strings: TStrings); overload;
    procedure AddHorLine; override;

    property CellSpacing: string read FCellSpacing write FCellSpacing;
    property CellPadding: string read FCellPadding write FCellPadding;
    property Width: string read FWidth write FWidth;
  end;

  TNLDHtmlForm = class(TNLDHtml)
  private
    FAction: string;
    FMethod: TFormMethod;
  protected
    function InternalExtraParams: string; override;
  public
    constructor Create(AOwner: TNLDHtml); override;

    property Action: string read FAction write FAction;
    property Method: TFormMethod read FMethod write FMethod;
  end;

  TNLDTextArea = class(TNLDHtml)
  private
    FRows: Integer;
    FName: string;
    FCols: Integer;
    FValue: string;
  public
    property Name: string read FName write FName;
    property Rows: Integer read FRows write FRows;
    property Cols: Integer read FCols write FCols;
    property Value: string read FValue write FValue;

    constructor Create(AOwner: TNLDHtml); override;
    function InternalExtraParams: string; override;
    procedure Prepare; override;
  end;

  TNLDSelectOption = class(TObject)
  private
    FSelected: Boolean;
    FText: string;
    FValue: string;
  public
    property Text: string read FText write FText;
    property Value: string read FValue write FValue;
    property Selected: Boolean read FSelected write FSelected;
  end;

  TNLDHtmlSelect = class(TNLDHtml)
  private
    FSelectOptions: TObjectList;
    FName: string;
  protected
    function InternalExtraParams: String; override;
  public
    constructor Create(AOwner: TNLDHtml); override;
    destructor Destroy; override;
    procedure AddOption(const Text, Value: string; Selected: Boolean);
    procedure Prepare; override;

    property Name: string read FName write FName;
  end;

  TNLDHtmlInput = class(TNLDHtml)
  private
    FName: string;
    FInputType: TInputType;
    FValue: string;
    FSize: string;
    FMaxLength: string;
  public
    property Name: string read FName write FName;
    property InputType: TInputType read FInputType write FInputType;
    property Value: string read FValue write FValue;
    property Size: string read FSize write FSize;
    property MaxLength: string read FMaxLength write FMaxLength;

    constructor Create(AOwner: TNLDHtml); override;
    function InternalExtraParams: string; override;
  end;

  TNLDHtmlChart = class(TNLDHtmlTable)
  private
    FChartItems: TObjectList;
    FPercentage: Boolean;
  public
    property Percentage: Boolean read FPercentage write FPercentage;
    constructor Create(AOwner: TNLDHtml); override;
    destructor Destroy; override;

    procedure AddItem(Text: string; Value: Integer);
    procedure Prepare; override;
  end;

  function Hyperlink(const Address: string; Text: string = '';
    NewPage: boolean = False): string;
  function SelectMonthOptions(Selected: Integer = -1): string;
  function CheckListBox(List: TStrings; Name: string = ''): string;


implementation

uses
  FileCtrl
{$IFDEF VER140}
  , Variants
{$ENDIF}
{$IFDEF VER150}
  , Variants
{$ENDIF}
  ;

const
  CR = #13#10;

function Hyperlink(const Address: string; Text: string = '';
  NewPage: boolean = False): string;
var
  Params: string;
begin
  if Text = '' then
    Text := Address;

  Params := '';

  if NewPage then
    Params := Params + 'target = "_blank"';

  Result := Format('<A HREF="%s" %s>%s</A>', [Address, Params, Text]);
end;

{ TNLDHtml }

function ItemTag(Index: Integer): string;
begin
  Result := Format('<#ItemTag %0:3d>', [Index]);
end;

function TNLDHtml.AddChart: TNLDHtmlChart;
begin
  Result := TNLDHtmlChart(AddItem(TNLDHtmlChart));
end;

procedure TNLDHtml.AddComment(const Text: string);
begin
  FText := FText + Format('<!--%s-->', [Text]);
end;

function TNLDHtml.AddForm: TNLDHtmlForm;
begin
  Result := TNLDHtmlForm(AddItem(TNLDHtmlForm));
end;

procedure TNLDHtml.AddHorLine;
begin
  FText := FText + '<hr>';
end;

procedure TNLDHtml.AddHyperlink(const Address: string; Text: string;
  NewPage: boolean);
var
  Params: string;
begin
  if Text = '' then
    Text := Address;

  Params := '';

  if NewPage then
    Params := Params + 'target = "_blank"';

  AddText(Format('<A HREF="%s" %s>%s</A>', [Address, Params, Text]));
end;

procedure TNLDHtml.AddImage(const ImageSource: string; Text: string;
  Target: string; Border: Integer; Width: string; Height: string);
begin
  if Target <> '' then
    AddText(Format('<a href="%s">', [Target]));

  if (Width = '') or (Height = '') then
    AddText(Format('<img src="%s" alt="%s" border="%d">',
      [ImageSource, Text, Border]))
  else
    AddText(Format('<img src="%s" alt="%s" border="%d" width="%s" height="%s">',
      [ImageSource, Text, Border, Width, Height]));


  if Target <> '' then
    AddText('</a>');
end;

function TNLDHtml.AddInput: TNLDHtmlInput;
begin
  Result := TNLDHtmlInput(AddItem(TNLDHtmlInput));
end;

function TNLDHtml.AddItem(ItemClass: TNLDHtmlClass): TNLDHtml;
begin
  Result := ItemClass.Create(Self);
  FItems.Add(Result);
  FText := FText + ItemTag(FItems.Count-1);
end;

procedure TNLDHtml.AddLine(Line: string);
begin
  inherited;
  AddText(Line);
  AddText(CR);
end;

function TNLDHtml.AddList: TNLDHtmlList;
begin
  Result := TNLDHtmlList(AddItem(TNLDHtmlList));
end;

function TNLDHtml.AddObject: TNLDHtmlObject;
begin
  Result := TNLDHtmlObject(AddItem(TNLDHtmlObject));
end;

function TNLDHtml.AddParagraph: TNLDHtmlParagraph;
begin
  Result := TNLDHtmlParagraph(AddItem(TNLDHtmlParagraph));
end;

function TNLDHtml.AddSelect: TNLDHtmlSelect;
begin
  Result := TNLDHtmlSelect(AddItem(TNLDHtmlSelect));
end;

function TNLDHtml.AddSiteMap(const Name, Local, FrameName: string): TNLDHtmlObject;
begin
  Result := AddObject;

  with Result do
  begin
    ObjectType := 'text/sitemap';

    AddParam('name', Name);
    AddParam('local', Local);
    AddParam('FrameName', FrameName);
  end;
end;

function TNLDHtml.AddTable: TNLDHtmlTable;
begin
  Result := TNLDHtmlTable(AddItem(TNLDHtmlTable));
end;

procedure TNLDHtml.AddText(const Text: string);
begin
  if not FWriteAllowed then
    raise Exception.Create('Unable to write directly to ' + ClassName);

  FText := FText + Text;
end;

function TNLDHtml.AddTextArea: TNLDTextArea;
begin
  Result := TNLDTextArea(AddItem(TNLDTextArea));
end;

procedure TNLDHtml.Clear;
begin
  FText := '';
end;

procedure TNLDHtml.CloseFontStyles(Styles: TFontStyles);
begin
  if hsBold in Styles then
    FText := FText + '</b>';

  if hsItalics in Styles then
    FText := FText + '</i>';
end;

constructor TNLDHtml.Create(AOwner: TNLDHtml);
begin
  inherited Create;
  FOwner := AOwner;
  FItems := TObjectList.Create;
  FWriteAllowed := True;
end;

destructor TNLDHtml.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TNLDHtml.InternalExtraParams: string;
begin
  Result := '';
end;

procedure TNLDHtml.OpenFontStyles(Styles: TFontStyles);
begin
  if hsBold in Styles then
    FText := FText + '<b>';

  if hsItalics in Styles then
    FText := FText + '<i>';
end;

procedure TNLDHtml.Prepare;
var
  i: Integer;
  NewText: string;
begin
  for i := 0 to FItems.Count - 1 do
  begin
    TNLDHtml(FItems[i]).Prepare;
    FText := StringReplace(FText, ItemTag(i), TNLDHtml(FItems[i]).Text + CR, []);
  end;

  if FTag <> '' then
  begin
    NewText := '<' + FTag;

    if FCssClass <> '' then
      NewText := NewText + ' class="' + FCssClass + '"';

    if FExtraParams <> '' then
      NewText := NewText + ' ' + FExtraParams + ' ';

    if InternalExtraParams <> '' then
      NewText := NewText + ' ' + InternalExtraParams + ' ';

    NewText := NewText + '>' + FText + '</' + FTag + '>';
    FText := NewText;
  end;

  FPrepared := True;
end;

procedure TNLDHtml.SetText(const Value: string);
begin
  FText := Value;
end;

{ TNLDHtmlTable }

procedure TNLDHtmlTable.AddHorLine;
begin
  with AddRow, AddCol do
  begin
    ColSpan := '0';
    AddHorLine;
  end;
end;

function TNLDHtmlTable.AddRow: TNLDHtmlTableRow;
begin
  Result := TNLDHtmlTableRow(AddItem(TNLDHtmlTableRow));
end;

procedure TNLDHtmlTable.AddStrings(Strings: TStrings);
var
  i: Integer;
begin
  for i := 0 to Strings.Count - 1 do
    with AddRow do
    begin
      with AddCol do
        AddText(Strings.Names[i]);

      with AddCol do
        AddText(Strings.Values[Strings.Names[i]]);
    end;
end;

procedure TNLDHtmlTable.AddStrings(Strings: Variant);
var
  i: Integer;
begin

  if not VarIsArray(Strings) then
    raise Exception.Create('TNLDHtmlTable.AddStrings: Strings is geen array');

  with AddRow do
    for i := VarArrayLowBound(Strings, 1) to VarArrayHighBound(Strings, 1) do
      with AddCol do
        AddText(Strings[i]);
end;

constructor TNLDHtmlTable.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'table';
  FWriteAllowed := False;
end;

function TNLDHtmlTable.InternalExtraParams: String;
begin
  Result := '';

  if FCellSpacing <> '' then
    Result := Format('cellspacing="%s"', [FCellSpacing]);

  if FCellPadding <> '' then
    Result := Format('cellPadding="%s"', [FCellPadding]);

  if FWidth <> '' then
    Result := Format('Width="%s"', [FWidth]);
end;

{ TNLDHtmlTableRow }

function TNLDHtmlTableRow.AddCol: TNLDHtmlTableCol;
begin
  Result := TNLDHtmlTableCol(AddItem(TNLDHtmlTableCol));
  Result.Header := FHeader;
end;

constructor TNLDHtmlTableRow.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'tr';
  FWriteAllowed := False;
end;

{ TNLDHtmlPage }

procedure TNLDHtmlPage.AddFrame(const Name, Target, Source: string;
  MarginWidth: string = '');
begin
  { Framepage heeft geen body }
  FBody.Text := '';
  FBody.FTag := '';

  if not FFramePage then
    FText := FText + '<frameset cols="250,*">' + CR;

  FFramePage := True;

  FText := FText + '  <frame ';

  if Name <> '' then
    FText := FText + Format('name="%s" ', [Name]);

  if Target <> '' then
    FText := FText + Format('target="%s" ', [Target]);

  if Source <> '' then
    FText := FText + Format('src="%s" ', [Source]);

  if MarginWidth <> '' then
    FText := FText + Format('marginwidth="%s"', [MarginWidth]);

  FText := FText + '>' + CR;
end;

procedure TNLDHtmlPage.AddRedirect(const URL: string; Timeout: Integer);
begin
  Head.AddText(Format('<meta HTTP-EQUIV="refresh" CONTENT="%d; URL=%s">',
    [Timeout, URL]));
end;

constructor TNLDHtmlPage.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'html';
  FHead := TNLDHtmlHead(AddItem(TNLDHtmlHead));
  FBody := TNLDHtmlBody(AddItem(TNLDHtmlBody));
  FWriteAllowed := False;
end;

function TNLDHtmlPage.GetTitle: string;
begin
  Result := FHead.Title.Text;
end;

procedure TNLDHtmlPage.Save;
var
  FileStream: TFileStream;
begin
  if FFilename = '' then
    raise Exception.Create('TmbHTMLPage: Empty filename not allowed');

  if ExtractFileExt(FileName) = '' then
    FileName := FileName + '.htm';

  if FileExists(FFilename) then
    if not DeleteFile(FFilename) then
      raise Exception.Create('TmbHTMLPage: file access denied');

  if not FPrepared then
    Prepare;

  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    FileStream.WriteBuffer(Pointer(FText)^, Length(FText));
  finally
    FileStream.Free;
  end;
end;

procedure TNLDHtmlPage.SetTitle(const Value: string);
begin
  FHead.Title.Text := Value;
end;

{ TNLDHtmlTableCol }

constructor TNLDHtmlTableCol.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'td';
end;

function TNLDHtmlTableCol.InternalExtraParams: string;
var
  AlignStr: string;
begin
  Result := '';
  AlignStr := '';

  case FAlign of
    caLeft: AlignStr := 'left';
    caRight: AlignStr := 'right';
    caCenter: AlignStr := 'center';
    caJustify: AlignStr := 'justify';
    caChar: AlignStr := 'char';
  end;

  if AlignStr <> '' then
    Result := Format('align="%s" ', [AlignStr]);

  AlignStr := '';

  case FVAlign of
    vcaTop: AlignStr := 'top';
    vcaBottom: AlignStr := 'bottom';
    vcaCenter: AlignStr := 'center';
  end;

  if AlignStr <> '' then
    Result := Format('valign="%s" ', [AlignStr]);

  if FColSpan <> '' then
    Result := Result + Format('ColSpan="%s"', [FColSpan]);

  if FWidth <> '' then
    Result := Result + Format('Width="%s"', [FWidth]);
end;

procedure TNLDHtmlTableCol.SetHeader(const Value: Boolean);
begin
  FHeader := Value;

  if FHeader then
    FTag := 'th'
  else
    FTag := 'td';
end;

{ TNLDHtmlBody }

function TNLDHtmlBody.AddAnchor: TNLDHtmlAnchor;
begin
  Result := TNLDHtmlAnchor(AddItem(TNLDHtmlAnchor));
end;

procedure TNLDHtmlBody.AddAnchorText(AnchorText, cssClassName: string);
begin
  with AddAnchor do
    Text := AnchorText;

  with AddPar do
  begin
    CssClass := 'chapter';
    AddText(AnchorText);
  end;
end;

function TNLDHtmlBody.AddPar: TNLDHtmlPar;
begin
  Result := TNLDHtmlPar(AddItem(TNLDHtmlPar));
end;

constructor TNLDHtmlBody.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'body';
  FWriteAllowed := False;
end;

{ TNLDHtmlHead }

constructor TNLDHtmlHead.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTitle := TNLDHtmlTitle(AddItem(TNLDHtmlTitle));
  FTag := 'head';
end;

{ TNLDHtmlPar }

procedure TNLDHtmlPar.AddLine(Line: string);
begin
  AddText(Line);

  if not FPreFormatted then
    AddText('<br>');

  AddText(CR);
end;

constructor TNLDHtmlPar.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'p';
end;

procedure TNLDHtmlPar.Prepare;
var
  PreText: string;
begin
  if FPreformatted then
  begin
    PreText := '<pre';

    if CssClass <> '' then
      PreText := PreText + ' class="' + FCssClass + '"';

    CssClass := '';

    PreText := PreText + '>';
    Text := PreText + Text + '</pre>';
  end;

  inherited;
end;

{ TNLDHtmlAnchor }

procedure TNLDHtmlAnchor.Prepare;
begin
  inherited;
  FText := '<a name="' + FText + '"></a>';
end;

{ TNLDHtmlTitle }

constructor TNLDHtmlTitle.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'title';
end;

{ TNLDHtmlObject }

function TNLDHtmlObject.AddParam(const Name, Value: string): TNLDHtmlParam;
begin
  Result := TNLDHtmlParam(AddItem(TNLDHtmlParam));
  Result.Name := Name;
  Result.Value := Value;
end;

constructor TNLDHtmlObject.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'object';
end;

procedure TNLDHtmlObject.Prepare;
var
  Buffer: string;
begin
  inherited;
  Buffer := Format(' type="%s"', [FObjectType]);

  if FClassID <> '' then
    Buffer := Buffer + Format(' classid="%s"', [FClassID]);

  Insert(Buffer, FText, 8);
end;

{ TNLDHtmlParam }

procedure TNLDHtmlParam.Prepare;
begin
  inherited;
  FText := Format('<param name="%s" value="%s">', [FName, FValue]);
end;

{ TNLDHtmlList }

function TNLDHtmlList.AddListItem: TNLDHtmlListItem;
begin
  Result := TNLDHtmlListItem(AddItem(TNLDHtmlListItem));
end;

constructor TNLDHtmlList.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'ul';
end;

{ TNLDHtmlListItem }

constructor TNLDHtmlListItem.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'li';
end;

{ TNLDHtmlForm }

constructor TNLDHtmlForm.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'form';
end;

function TNLDHtmlForm.InternalExtraParams: string;
var
  MethodStr: string;
begin
  Result := '';

  if FAction <> '' then
    Result := Format('action="%s" ', [FAction]);

  case FMethod of
    fmGet: MethodStr := 'get';
    fmPost: MethodStr := 'post'
  else
    MethodStr := '';
  end;

  if MethodStr <> '' then
    Result := Result + Format('method="%s"', [MethodStr]);
end;

{ TNLDHtmlInput }

constructor TNLDHtmlInput.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'input';
end;

function TNLDHtmlInput.InternalExtraParams: string;
begin
  Result := '';

  case FInputType of
    itText: Result := 'Text';
    itPassword: Result := 'Password';
    itCheckbox: Result := 'Checkbox';
    itRadio: Result := 'Radio';
    itSubmit: Result := 'Submit';
    itReset: Result := 'Reset';
    itFile: Result := 'File';
    itHidden: Result := 'Hidden';
  end;

  if Result <> '' then
    Result := Format('type="%s"', [Result]);

  if FName <> '' then
    Result := Result + Format(' name="%s"', [FName]);

  if FValue <> '' then
    Result := Result + Format(' Value="%s"', [FValue]);

  if FSize <> '' then
    Result := Result + Format(' Size="%s"', [FSize]);

  if FMaxLength <> '' then
    Result := Result + Format(' MaxLength="%s"', [FMaxLength]);
end;

{ TNLDHtmlChart }

procedure TNLDHtmlChart.AddItem(Text: string; Value: Integer);
var
  ChartItem: TChartItem;
begin
  ChartItem := TChartItem.Create;
  ChartItem.Text := Text;
  ChartItem.Value := Value;

  FChartItems.Add(ChartItem);
end;

constructor TNLDHtmlChart.Create;
begin
  inherited;
  FChartItems := TObjectList.Create;
  FTag := '';
end;

destructor TNLDHtmlChart.Destroy;
begin
  FChartItems.Free;
  inherited;
end;

procedure TNLDHtmlChart.Prepare;
var
  i: Integer;
  Max: Integer;
  Total: Integer;
begin
  Max := -MaxInt;
  Total := 0;

  for i := 0 to FChartItems.Count - 1 do
  begin
    if TChartItem(FChartItems[i]).Value > Max then
      Max := TChartItem(FChartItems[i]).Value;

    Total := Total + TChartItem(FChartItems[i]).Value;
  end;

  for i := 0 to FChartItems.Count - 1 do
    with AddRow do
    begin
      AddCol.AddText(TChartItem(FChartItems[i]).Text);

      { Grafiek }
      with AddCol do
      begin
        ExtraParams := 'width="50%" nowrap';
        AddImage('/forum/images/polls/bar3.gif', '', '', 0,
          IntToStr(round(100 * TChartItem(FChartItems[i]).Value / Max)) + '%', '10');
      end;

      if FPercentage then
        AddCol.AddText(IntToStr(100 * TChartItem(FChartItems[i]).Value div Total) + '%')
      else
        AddCol.AddText(FloatToStr(TChartItem(FChartItems[i]).Value));

    end;

  inherited;
end;

function SelectMonthOptions(Selected: Integer = -1): string;
var
  i: Integer;
  IsSelected: string;
begin
  for i := 1 to 12 do
  begin
    if i = Selected then
      IsSelected := 'selected'
    else
      IsSelected := '';

    Result := Result + Format('<option %s Value="%d">%s</option>',
      [IsSelected, i, LongMonthNames[i]]);
  end;
end;

function CheckListBox(List: TStrings; Name: string = ''): string;
var
  i: Integer;
  TempName: string;
begin
  if List.Count = 0 then
  begin
    Result := '';
    Exit;
  end;

  for i := 0 to List.Count - 1 do
  begin
    if Name = '' then
      TempName := List[i]
    else
      TempName := Name;

    Result := Result +
      Format('<input type="checkbox" name="%0:s" value="%1:s">%1:s<br>'#13#10,
        [TempName, List[i]]);
  end;

  Result := Format('<fieldset>%s</fieldset>', [Result]);
end;

{ TNLDTextArea }

constructor TNLDTextArea.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'TextArea';
end;

function TNLDTextArea.InternalExtraParams: string;
begin
  Result := '';

  if FName <> '' then
    Result := Result + Format(' name="%s"', [FName]);

  Result := Result + Format(' rows="%d" cols="%d"', [FRows, FCols]);
end;

procedure TNLDTextArea.Prepare;
begin
  Text := FValue;
  inherited;
end;

{ TNLDHtmlSelect }


{ TNLDHtmlSelect }

procedure TNLDHtmlSelect.AddOption(const Text, Value: string;
  Selected: Boolean);
var
  Option: TNLDSelectOption;
begin
  Option := TNLDSelectOption.Create;
  FSelectOptions.Add(Option);
  Option.Text := Text;
  Option.Value := Value;
  Option.Selected := Selected;
end;

constructor TNLDHtmlSelect.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'select';
  FSelectOptions := TObjectList.Create;
end;

destructor TNLDHtmlSelect.Destroy;
begin
  FSelectOptions.Free;
  inherited;
end;

function TNLDHtmlSelect.InternalExtraParams: String;
begin
  Result := format('name="%s"', [FName]);
end;

procedure TNLDHtmlSelect.Prepare;
var
  i: Integer;
  Selected: string;
  Option: TNLDSelectOption;
begin
  for i := 0 to FSelectOptions.Count - 1 do
  begin
    Option := TNLDSelectOption(FSelectOptions[i]);

    if Option.Selected then
      Selected := 'SELECTED'
    else
      Selected := '';

    Text := Text + Format('<option %s value="%s">%s</option>',
      [Selected, Option.Value, Option.Text]);

  end;

  inherited;
end;

{ TNLDHtmlParagraph }

{ TNLDHtmlParagraph }

constructor TNLDHtmlParagraph.Create(AOwner: TNLDHtml);
begin
  inherited;
  FTag := 'p';
end;

end.

