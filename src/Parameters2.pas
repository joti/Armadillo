unit Parameters2;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls;

  type
    TParametersForm2 = class(TForm)
      OKBtn: TButton;
      FinCB: TComboBox;
      Foklabel2: TLabel;
      FinLab: TLabel;
      PMLab: TLabel;
      procedure FormShow(Sender: TObject);
      procedure OKBtnClick(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
    end;

  var
    ParametersForm2: TParametersForm2;

implementation

  {$R *.DFM}

  uses Main;

  procedure TParametersForm2.FormShow(Sender: TObject);
  begin
    case AktivVetulet of
    89: // Érdi-Krausz-féle
      begin
        FinLab.Caption := 'A két vetület közötti határoló szélesség:';
      end;
    102: // Winkel-féle
      begin
        FinLab.Caption := 'A hengervetület hossztartó paraleljeinek szélessége:';
      end;
    end;
  end;

  procedure TParametersForm2.OKBtnClick(Sender: TObject);
  begin
    fis := StrToFloat(FinCB.Items[FinCB.Itemindex]);
    ParametersForm2.Close;
  end;

end.
