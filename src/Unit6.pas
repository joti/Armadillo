unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TProgressForm = class(TForm)
    ProgressLabel: TLabel;
    ProgressBar1: TProgressBar;
    ProgressMegseBtn: TButton;
    ProgressLabel2: TLabel;
    ProgressLabel3: TLabel;
    procedure ProgressMegseBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProgressForm: TProgressForm;
  Megse: Boolean;

implementation

{$R *.DFM}

procedure TProgressForm.ProgressMegseBtnClick(Sender: TObject);
begin
  Megse:=True;
end;

end.
