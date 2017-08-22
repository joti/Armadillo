unit Parameters2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm9 = class(TForm)
    OKBtn: TButton;
    Finbox: TComboBox;
    Foklabel2: TLabel;
    Finlabel: TLabel;
    pmlabel2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ParametersForm2: TForm9;

implementation

{$R *.DFM}

uses Main;

procedure TForm9.FormShow(Sender: TObject);
begin
  case aktiv of
  89:
   begin
     Finlabel.caption:='A k�t vet�let k�z�tti hat�rol� sz�less�g:';
     Finlabel.Left:=42;
   end;
  102:
   begin
     Finlabel.caption:='A hengervet�let hossztart� paraleljeinek sz�less�ge:';
     Finlabel.Left:=8;
   end;
  end;
end;

procedure TForm9.OKBtnClick(Sender: TObject);
begin
  fis:=strtofloat(Finbox.Items[Finbox.Itemindex]);
  ParametersForm2.Close;
end;

end.
