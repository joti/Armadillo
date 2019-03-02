unit Unit6;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ComCtrls;

  type
    TProgressForm = class(TForm)
    DrawProgressLab: TLabel;
      ProgressBar1: TProgressBar;
    ProgressCancelBtn: TButton;
    PltProgressLab: TLabel;
    PrintProgressLab: TLabel;
      procedure ProgressCancelBtnClick(Sender: TObject);
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

  procedure TProgressForm.ProgressCancelBtnClick(Sender: TObject);
  begin
    Megse := True;
  end;

end.
