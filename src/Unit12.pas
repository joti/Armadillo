unit Parameters4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm12 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.DFM}

uses Main, Page;

procedure TForm12.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8]) then Key:=#0;
end;

procedure TForm12.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',',',#8]) then Key:=#0;
end;

procedure TForm12.Button1Click(Sender: TObject);
begin
  if not szamvizsgal(Edit2.Text)
           then
             begin
              Edit2.Setfocus;
              MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
              Exit;
             end
           else
            begin
             fia2:=StrToFloat(Edit2.Text);
            end;
  if (Edit1.Text='') or (StrToInt(Edit1.Text)=0) then
             begin
              Edit1.Setfocus;
              MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
              Exit;
             end
           else
            begin
             fih:=StrToInt(Edit1.Text);
            end;
  Close;
end;

end.
