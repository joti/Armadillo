unit Parameters3;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ExtCtrls;

  type
    TParametersForm3 = class(TForm)
      AbraGroup: TRadioGroup;
      OKBtn: TButton;
      procedure FormCreate(Sender: TObject);
      procedure OKBtnClick(Sender: TObject);
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
    AbraGroup.ItemIndex := 0;
  end;

  procedure TParametersForm3.OKBtnClick(Sender: TObject);
  begin
    Felgomb := (AbraGroup.Itemindex = 0);
    ParametersForm3.Close;
  end;

end.
