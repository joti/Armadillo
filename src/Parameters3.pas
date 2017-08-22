unit Parameters3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TParametersForm3 = class(TForm)
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
  ParametersForm3: TParametersForm3;

implementation

{$R *.DFM}

uses Main;

procedure TParametersForm3.FormCreate(Sender: TObject);
begin
  AbraGroup.ItemIndex:=0;
end;

procedure TParametersForm3.Button1Click(Sender: TObject);
begin
  if AbraGroup.Itemindex=0 then fel:=True else fel:=False;
  ParametersForm3.Close;
end;

end.
