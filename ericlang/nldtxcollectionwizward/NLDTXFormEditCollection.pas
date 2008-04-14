{-------------------------------------------------------------------------------
  Form om CollectionItem te editen
-------------------------------------------------------------------------------}

unit NLDTXFormEditCollection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
  NLDTXCreateCollection;

type
  TFormEditCollection = class(TForm)
    EditItemName: TEdit;
    BtnCancel: TBitBtn;
    BtnInterface: TBitBtn;
    BtnImplementation: TBitBtn;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnInterfaceClick(Sender: TObject);
    procedure BtnImplementationClick(Sender: TObject);
  private
    fEditResult: TCollectionCreateMode;
  public
  end;

// functie voor modal form
function InputCollectionItem(var S: string; var EditResult: TCollectionCreateMode): Boolean;

implementation

{$R *.dfm}

var
  GlobalLastItem: string = 'TMyItem';

function InputCollectionItem(var S: string; var EditResult: TCollectionCreateMode): Boolean;
var
  FormEditCollection: TFormEditCollection;
begin
  Result := False;
  EditResult := ccmNone;
  S := GlobalLastItem;
  FormEditCollection := TFormEditCollection.Create(nil);
  try
    with FormEditCollection do
    begin
      EditItemName.Text := S;
      Result := ShowModal = mrOK;
      if Result then
      begin
        S := EditItemName.Text;
        EditResult := fEditResult;
        GlobalLastItem := S;
      end;
    end;
  finally
    FormEditCollection.Free;
  end;
end;



procedure TFormEditCollection.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOK then
    if EditItemName.Text = '' then
    begin
      ShowMessage('Invalid input');
      CanClose := False;
    end;
end;

procedure TFormEditCollection.BtnInterfaceClick(Sender: TObject);
begin
  fEditResult := ccmInterface;
end;

procedure TFormEditCollection.BtnImplementationClick(Sender: TObject);
begin
  fEditResult := ccmImplementation;
end;

end.

