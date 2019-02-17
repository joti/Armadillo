unit Layers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Buttons, General;

type
  TLayersForm = class(TForm)
    RetegBox: TListBox;
    RetegfelBtn: TBitBtn;
    RetegleBtn: TBitBtn;
    OKBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure RetegleBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure RetegfelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LayersForm: TLayersForm;

// A rétegek neve
const LAYERNAMES : array[0..4] of TCodeName = (
  (Code: 'FOK'; Name: 'Fokhálózat'),
  (Code: 'SEGED'; Name: 'Segédhálózat'),
  (Code: 'PART'; Name: 'Partvonalak'),
  (Code: 'HATAR'; Name: 'Országhatárok'),
  (Code: 'TO'; Name: 'Tavak'));

// A rétegek alapértelmezett sorrendje
const DEFLAYERORDER : array[0..4] of ShortString = ('FOK', 'SEGED', 'TO', 'HATAR', 'PART');

function GetLayerName(Code : ShortString) : String;

implementation

{$R *.DFM}

function GetLayerName(Code : ShortString) : String;
var j : Byte;
begin
  for j := 0 to High(LAYERNAMES) do begin
    if LAYERNAMES[j].Code = Code then begin
      result := LAYERNAMES[j].Name;
      break;
    end;
  end;
end;

procedure TLayersForm.FormCreate(Sender: TObject);
var i, j : Byte;
begin
  for i := 0 to High(DEFLAYERORDER) do begin
    RetegBox.Items.Add(GetLayerName(DEFLAYERORDER[i]));
  end;

  RetegBox.Itemindex := 0;
end;

procedure TLayersForm.RetegleBtnClick(Sender: TObject);
var tart : String;
begin
  if RetegBox.Itemindex <> -1 then
    if RetegBox.Itemindex < 4 then begin
       tart := RetegBox.Items[RetegBox.Itemindex];
       RetegBox.Items[RetegBox.Itemindex] := RetegBox.Items[RetegBox.Itemindex + 1];
       RetegBox.Items[RetegBox.Itemindex + 1] := tart;
       RetegBox.Itemindex:=RetegBox.Itemindex+1;
    end;
end;

procedure TLayersForm.OKBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TLayersForm.RetegfelBtnClick(Sender: TObject);
var tart: String;
begin
  if RetegBox.Itemindex<>-1 then
    if RetegBox.Itemindex>0 then
     begin
       tart:=RetegBox.Items[RetegBox.Itemindex];
       RetegBox.Items[RetegBox.Itemindex]:=RetegBox.Items[RetegBox.Itemindex-1];
       RetegBox.Items[RetegBox.Itemindex-1]:=tart;
       RetegBox.Itemindex:=RetegBox.Itemindex-1;
     end;

end;

end.
