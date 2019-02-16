unit Layers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Buttons;

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

implementation

{$R *.DFM}

procedure TLayersForm.FormCreate(Sender: TObject);
begin
  RetegBox.Itemindex:=0;
end;

procedure TLayersForm.RetegleBtnClick(Sender: TObject);
var tart: String;
begin
  if RetegBox.Itemindex<>-1 then
    if RetegBox.Itemindex<4 then
     begin
       tart:=RetegBox.Items[RetegBox.Itemindex];
       RetegBox.Items[RetegBox.Itemindex]:=RetegBox.Items[RetegBox.Itemindex+1];
       RetegBox.Items[RetegBox.Itemindex+1]:=tart;
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
