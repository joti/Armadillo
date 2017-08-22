unit Parameters3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm11 = class(TForm)
    AbraGroup: TRadioGroup;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

{$R *.DFM}

uses Main;

procedure TForm11.FormCreate(Sender: TObject);
begin
  AbraGroup.ItemIndex:=0;
end;

procedure TForm11.Button1Click(Sender: TObject);
begin
  if AbraGroup.Itemindex=0 then fel:=True else fel:=False;
  Form11.Close;
end;

end.
