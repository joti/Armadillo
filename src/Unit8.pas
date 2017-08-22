unit Layers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Buttons;

type
  TForm8 = class(TForm)
    RetegBox: TListBox;
    RetegfelBtn: TBitBtn;
    RetegleBtn: TBitBtn;
    RetegOK: TButton;
    procedure FormCreate(Sender: TObject);
    procedure RetegleBtnClick(Sender: TObject);
    procedure RetegOKClick(Sender: TObject);
    procedure RetegfelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LayersForm: TForm8;

implementation

{$R *.DFM}

procedure TForm8.FormCreate(Sender: TObject);
begin
  RetegBox.Itemindex:=0;
end;

procedure TForm8.RetegleBtnClick(Sender: TObject);
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

procedure TForm8.RetegOKClick(Sender: TObject);
begin
  Close;
end;

procedure TForm8.RetegfelBtnClick(Sender: TObject);
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
