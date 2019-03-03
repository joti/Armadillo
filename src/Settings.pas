unit Settings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, Menus, General;

type
  TSettingsForm = class(TForm)
    BPanel: TPanel;
    PageControl1: TPageControl;
    Vetuletbox: TTabSheet;
    CsaladLab: TLabel;
    VetuletLab: TLabel;
    CsaladCB: TComboBox;
    VetuletCB: TComboBox;
    JellemBtn: TButton;
    Tartalombox: TTabSheet;
    FokChk: TCheckBox;
    SegedChk: TCheckBox;
    PartChk: TCheckBox;
    HatarChk: TCheckBox;
    SegSzinCB: TComboBox;
    FokSzinCB: TComboBox;
    HatarSzinCB: TComboBox;
    PartSzinCB: TComboBox;
    CimLab: TLabel;
    CimSorLab: TLabel;
    CloseBtn: TBitBtn;
    ExitBtn: TBitBtn;
    OpenBtn: TBitBtn;
    ToChk: TCheckBox;
    ToSzinCB: TComboBox;
    AlkalmazBtn: TButton;
    PopupMenu1: TPopupMenu;
    Sorrend: TMenuItem;
    GroupBox1: TGroupBox;
    ParSurusegLab: TLabel;
    ParSurusegFokEd: TEdit;
    ParSurusegFokLab: TLabel;
    MerSurusegLab: TLabel;
    MerSurusegFokEd: TEdit;
    MerSurusegFokLab: TLabel;
    TeritoChk: TCheckBox;
    GroupBox2: TGroupBox;
    ParReszletLab: TLabel;
    MerReszletLab: TLabel;
    MerReszletCB: TComboBox;
    ParReszletCB: TComboBox;
    GroupBox3: TGroupBox;
    SegMerSurusegLab: TLabel;
    SegParSurusegLab: TLabel;
    SegParSurusegFokEd: TEdit;
    SegMerSurusegFokEd: TEdit;
    SegMerSurusegFokLab: TLabel;
    SegParSurusegFokLab: TLabel;
    GroupBox4: TGroupBox;
    SegMerReszletCB: TComboBox;
    SegParReszletCB: TComboBox;
    SegParReszletLab: TLabel;
    SegMerReszletLab: TLabel;
    GroupBox5: TGroupBox;
    NormalBtn: TRadioButton;
    FerdeBtn: TRadioButton;
    KozMerLab: TLabel;
    KozMerFokEd: TEdit;
    KozMerFokLab: TLabel;
    SegedPolusLab: TLabel;
    PolusSzelesLab: TLabel;
    PolusHosszuLab: TLabel;
    PolusSzelesFokEd: TEdit;
    PolusHosszuFokEd: TEdit;
    PolusSzelesFokLab: TLabel;
    PolusHosszuFokLab: TLabel;
    KezdoMerLab: TLabel;
    KezdoMerPolusCB: TComboBox;
    KezdoMerPolusLab: TLabel;
    SorrendBtn: TButton;
    procedure VetuletCBChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CsaladCBChange(Sender: TObject);
    procedure FerdeBtnClick(Sender: TObject);
    procedure NormalBtnClick(Sender: TObject);
    procedure SegedClick(Sender: TObject);
    procedure FokClick(Sender: TObject);
    procedure PartChkClick(Sender: TObject);
    procedure HatarChkClick(Sender: TObject);
    procedure JellemBtnClick(Sender: TObject);
    procedure CimSorLabMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CimSorLabMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ExitBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ToChkClick(Sender: TObject);
    procedure AlkalmazBtnClick(Sender: TObject);
    procedure KozMerFokEdKeyPress(Sender: TObject; var Key: Char);
    procedure SorrendClick(Sender: TObject);
    procedure SorrendBtnClick(Sender: TObject);
  private
    { Private declarations }
    WhereMouse: TPoint;
    Inside: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses Main, About, Parameters1, Layers, Parameters2, Parameters3, Parameters4;

procedure TSettingsForm.FormCreate(Sender: TObject);
var i: Byte;
begin
  ParReszletCB.ItemIndex := 4;
  MerReszletCB.ItemIndex := 4;
  SegParReszletCB.ItemIndex := 4;
  SegMerReszletCB.ItemIndex := 4;
  FokSzinCB.Itemindex := 0;
  SegSzinCB.Itemindex := 0;
  PartSzinCB.Itemindex := 0;
  HatarSzinCB.Itemindex := 0;
  ToSzinCB.Itemindex := 0;
  CsaladCB.Itemindex := 0;

  Vet[0]:='Postel-féle';
  Vet[1]:='Lambert-féle';
  Vet[2]:='Sztereografikus';
  Vet[3]:='Gnomonikus';
  Vet[4]:='Ortografikus';

  Vet[20]:='Ptolemaiosz-féle';
  Vet[21]:='De l''Isle-féle';
  Vet[22]:='Szögtartó és egy paralelkörben hossztartó';
  Vet[23]:='Lambert-Gauss-féle';
  Vet[24]:='Albers-féle';
  Vet[25]:='Területtartó és egy paralelkörben hossztartó';
  Vet[26]:='Lambert-féle';
  Vet[27]:='Perspektív';

  Vet[40]:='Négyzetes';
  Vet[41]:='Meridiánban és két paralelkörben hossztartó';
  Vet[42]:='Lambert-féle';
  Vet[43]:='Területtartó és két paralelkörben hossztartó';
  Vet[44]:='Mercator-féle';
  Vet[45]:='Szögtartó és két paralelkörben hossztartó';
  Vet[46]:='Perspektív';

  Vet[60]:='Bonne-féle';
  Vet[61]:='Werner-féle';
  Vet[62]:='Egyszerû/amerikai polikónikus';
  Vet[63]:='Ortogonális polikónikus';
  Vet[64]:='Területtartó polikónikus';
  Vet[65]:='Szögtartó polikónikus';
  Vet[66]:='Van der Grinten I.';
  Vet[67]:='Van der Grinten II.';
  Vet[68]:='Van der Grinten IV.';
  Vet[69]:='Lagrange-féle';
  Vet[70]:='Fournier I.';

  Vet[80]:='Mercator-Sanson-féle';
  Vet[81]:='Kavrajszkij I.';
  Vet[82]:='Eckert V.';
  Vet[83]:='Eckert VI.';
  Vet[84]:='Apianus II.';
  Vet[85]:='Mollweide-féle';
  Vet[86]:='Eckert III.';
  Vet[87]:='Eckert IV.';
  Vet[88]:='Kavrajszkij II.';
  Vet[89]:='Érdi-Krausz-féle';
  Vet[90]:='Goode-féle';
  Vet[91]:='Baranyi II.';
  Vet[92]:='Baranyi IV.';
  Vet[93]:='Robinson-féle';
  Vet[94]:='Apianus I.';
  Vet[95]:='Bacon-féle';
  Vet[96]:='Ortelius-féle';
  Vet[97]:='Donis-féle';
  Vet[98]:='Collignon-féle';
  Vet[99]:='Eckert I.';
  Vet[180]:='Eckert II.';
  Vet[181]:='Van der Grinten III.';
  Vet[182]:='Oldfield I.';
  Vet[183]:='Oldfield II.';

  Vet[100]:='Hammer-féle';
  Vet[101]:='Aitoff-féle';
  Vet[102]:='Winkel-féle';
  Vet[103]:='Briesemeister-féle';
  Vet[104]:='Wagner VII.';
  Vet[105]:='Eisenlohr-féle';
  Vet[106]:='August-féle';
  Vet[107]:='Armadillo';
  Vet[108]:='Oldfield III.';
  Vet[109]:='Egyszerû hullámvetület';
  Vet[110]:='Lambert-féle hullámvetület';

  for i:= 0 to 4 do
    VetuletCB.Items.Add(Vet[i]);
  VetuletCB.Itemindex:=0;
  KezdoMerPolusCB.Itemindex:=0;
end;

procedure TSettingsForm.CsaladCBChange(Sender: TObject);
var h,i,k: byte;
begin
  Vetvalt := True;
  ManZoom := False;
  origomas := False;

  for i := 0 to 5 do begin
    l := 0;
    if CsaladCB.Itemindex = i then begin
      VetuletCB.Clear;
      if CsaladCB.Itemindex = 0 then
        h := 0
      else
        h := 1;

      for k := 0 to h do begin
        j := 0;
        repeat
          if Vet[100*k + 20*i + j] = '' then
            j := j + 1
          else begin
            VetuletCB.Items.Add(Vet[100*k + 20*i + j]);
            l := l + 1;
            j := j + 1;
          end;
        until j = 20;
      end;
      VetuletCB.Itemindex := 0;
      VetuletCBChange(CsaladCB);
    end;
  end;

   fi1 := DEF_FI1;
   fi2 := DEF_FI2;
   fin := DEF_FIN;
   fia := DEF_FIA;
   if CsaladCB.Itemindex = 2 then
     fin := DEF_FIN2;

   ParametersForm1.Fok1Ed.Text := IntToStr(fi1);
   ParametersForm1.Fok2Ed.Text := IntToStr(fi2);
   ParametersForm1.FoknEd.Text := IntToStr(fin);
   ParametersForm1.FokaEd.Text := FloatToStr(fia);
   ParametersForm1.IranyCB.Itemindex := 0;
   if not ParametersForm1.FokaEd.Enabled then begin
     ParametersForm1.VegtelenChk.Checked := False;
     ParametersForm1.FokaEd.Enabled := True;
     ParametersForm1.FokaLab.Enabled := True;
     ParametersForm1.IranyCB.Enabled := True;
     ParametersForm1.IranyCB.Itemindex := 0;
     ParametersForm1.IranyLab.Enabled := True;
   end;
end;

procedure TSettingsForm.VetuletCBChange(Sender: TObject);
begin
  Vetvalt := True;
  ManZoom := False;
  ManScale := False;
  Lapba := False;
  Crop := False;
  origomas := False;

  if VetuletCB.Itemindex > 19 then
    AktivVetulet := 80 + 20 * CsaladCB.Itemindex + VetuletCB.Itemindex
  else
    AktivVetulet := 20 * CsaladCB.Itemindex + VetuletCB.Itemindex;

  JellemBtn.Enabled := (AktivVetulet in [2,3,20..27,41,43,44,45,46,60,62,63,64,65,69,89,102,107,94,95,98,109,110]);

  case AktivVetulet of
  46:
    begin
      ParametersForm1.VegtelenChk.Checked := False;
      ParametersForm1.FokaLab.Enabled := True;
      ParametersForm1.FokaEd.Enabled := True;
    end;
  69:
    fik := DEF_FIK4;
  89:
    begin
      fis := 60;
      ParametersForm2.FinCB.Clear;
      ParametersForm2.FinCB.Items.Add('60');
      ParametersForm2.FinCB.Items.Add('70');
      ParametersForm2.FinCB.Itemindex := 0;
    end;
  102:
    begin
      fis := 40;
      ParametersForm2.FinCB.Clear;
      ParametersForm2.FinCB.Items.Add('40');
      ParametersForm2.FinCB.Items.Add('50,467');
      ParametersForm2.FinCB.Itemindex := 0;
    end;
  end;

  case AktivVetulet of
  2,22,23,27:
    fik := DEF_FIK1;
  3,44,45,46:
    fik := DEF_FIK2;
  62,63,64:
    fia := DEF_FIA2;
  65:
    fik := DEF_FIK3;
  69:
    fia := DEF_FIA3;
  107:
    fin := DEF_FIN3;
  109,110:
    begin
      fiah := DEF_FIAH;
      fih := DEF_FIH;
    end;
  end;
end;

procedure TSettingsForm.FerdeBtnClick(Sender: TObject);
begin
  // Ferdetengelyû elhelyezés komponenseinek engedélyezése
  FerdeBtn.TabStop := True;
  SegedPolusLab.Enabled := True;

  PolusSzelesLab.Enabled := True;
  PolusSzelesFokLab.Enabled := True;
  PolusSzelesFokEd.Enabled:=True;
  PolusSzelesFokEd.Color:=clWindow;

  PolusHosszuLab.Enabled := True;
  PolusHosszuFokEd.Color:=clWindow;
  PolusHosszuFokEd.Enabled:=True;
  PolusHosszuFokLab.Enabled := True;

  KezdoMerLab.Enabled := True;
  KezdoMerPolusCB.Color := clWindow;
  KezdoMerPolusCB.Enabled := True;
  KezdoMerPolusLab.Enabled := True;

  // Normális elhelyezés komponenseinek tiltása
  NormalBtn.TabStop := False;
  NormalBtn.Checked := False;
  KozMerLab.Enabled := False;
  KozMerFokEd.Enabled := False;
  KozMerFokEd.Color := clMenu;
  KozMerFokLab.Enabled := False;

  // Segédfokhálózat engedélyezése
  SegedChk.Enabled := True;
  if SegedChk.Checked then begin
    SegSzinCB.Enabled := True;
    SegSzinCB.Color := clWindow;

    Groupbox3.Enabled := True;
    SegParSurusegLab.Enabled := True;
    SegMerSurusegLab.Enabled := True;
    SegParSurusegFokEd.Enabled := True;
    SegParSurusegFokEd.Color := clWindow;
    SegMerSurusegFokEd.Enabled := True;
    SegMerSurusegFokEd.Color := clWindow;
    SegParSurusegFokLab.Enabled := True;
    SegMerSurusegFokLab.Enabled := True;

    Groupbox4.Enabled := True;
    SegParReszletLab.Enabled := True;
    SegMerReszletLab.Enabled := True;
    SegParReszletCB.Enabled := True;
    SegParReszletCB.Color := clWindow;
    SegMerReszletCB.Enabled := True;
    SegMerReszletCB.Color := clWindow;
   end;
end;

procedure TSettingsForm.NormalBtnClick(Sender: TObject);
begin
  // Normális elhelyezés komponenseinek engedélyezése
  NormalBtn.TabStop := True;
  KozMerLab.Enabled := True;
  KozMerFokEd.Enabled := True;
  KozMerFokEd.Color := clWindow;
  KozMerFokLab.Enabled := True;

  // Ferdetengelyû elhelyezés komponenseinek tiltása
  FerdeBtn.TabStop := False;
  FerdeBtn.Checked := False;

  SegedPolusLab.Enabled := False;
  PolusSzelesLab.Enabled := False;
  PolusSzelesFokEd.Enabled := False;
  PolusSzelesFokEd.Color := clMenu;
  PolusSzelesFokLab.Enabled := False;
  PolusHosszuLab.Enabled := False;
  PolusHosszuFokEd.Color := clMenu;
  PolusHosszuFokEd.Enabled := False;
  PolusHosszuFokLab.Enabled := False;

  KezdoMerLab.Enabled := False;
  KezdoMerPolusCB.Color := clMenu;
  KezdoMerPolusCB.Enabled := False;
  KezdoMerPolusLab.Enabled := False;

  SegedChk.Enabled := False;
  SegSzinCB.Enabled := False;
  SegSzinCB.Color := clMenu;

  Groupbox3.Enabled := False;
  SegParSurusegLab.Enabled := False;
  SegParSurusegFokEd.Enabled := False;
  SegParSurusegFokEd.Color := clMenu;
  SegParSurusegFokLab.Enabled := False;
  SegMerSurusegLab.Enabled := False;
  SegMerSurusegFokEd.Enabled := False;
  SegMerSurusegFokEd.Color := clMenu;
  SegMerSurusegFokLab.Enabled := False;

  Groupbox4.Enabled := False;
  SegParReszletLab.Enabled := False;
  SegParReszletCB.Enabled := False;
  SegParReszletCB.Color := clMenu;
  SegMerReszletLab.Enabled := False;
  SegMerReszletCB.Enabled := False;
  SegMerReszletCB.Color := clMenu;
end;

procedure TSettingsForm.FokClick(Sender: TObject);
begin
  if FokChk.State = cbChecked then begin
    FokSzinCB.Enabled := True;
    FokSzinCB.Color := clWindow;

    Groupbox1.Enabled := True;
    ParSurusegFokEd.Enabled := True;
    ParSurusegFokEd.Color := clWindow;
    MerSurusegFokEd.Enabled := True;
    MerSurusegFokEd.Color := clWindow;
    TeritoChk.Enabled := True;

    ParSurusegLab.Enabled := True;
    MerSurusegLab.Enabled := True;
    ParSurusegFokLab.Enabled := True;
    MerSurusegFokLab.Enabled := True;

    Groupbox2.Enabled := True;
    ParReszletLab.Enabled := True;
    ParReszletCB.Enabled := True;
    ParReszletCB.Color := clWindow;
    MerReszletLab.Enabled := True;
    MerReszletCB.Enabled := True;
    MerReszletCB.Color := clWindow;
  end else begin
    FokSzinCB.Enabled := False;
    FokSzinCB.Color := clMenu;

    Groupbox1.Enabled := False;
    ParSurusegFokEd.Enabled := False;
    ParSurusegFokEd.Color := clMenu;
    MerSurusegFokEd.Enabled := False;
    MerSurusegFokEd.Color := clMenu;
    TeritoChk.Enabled := False;

    ParSurusegLab.Enabled := False;
    MerSurusegLab.Enabled := False;
    ParSurusegFokLab.Enabled := False;
    MerSurusegFokLab.Enabled := False;

    Groupbox2.Enabled := False;
    ParReszletLab.Enabled := False;
    ParReszletCB.Enabled := False;
    ParReszletCB.Color := clMenu;
    MerReszletLab.Enabled := False;
    MerReszletCB.Enabled := False;
    MerReszletCB.Color := clMenu;
  end;
end;

procedure TSettingsForm.SegedClick(Sender: TObject);
begin
  if SegedChk.State = cbChecked then begin
    SegSzinCB.Enabled := True;
    SegSzinCB.Color := clWindow;

    Groupbox3.Enabled := True;
    SegParSurusegLab.Enabled := True;
    SegParSurusegFokEd.Enabled := True;
    SegParSurusegFokEd.Color := clWindow;
    SegParSurusegFokLab.Enabled := True;
    SegMerSurusegLab.Enabled := True;
    SegMerSurusegFokEd.Enabled := True;
    SegMerSurusegFokEd.Color := clWindow;
    SegMerSurusegFokLab.Enabled := True;

    Groupbox4.Enabled := True;
    SegParReszletLab.Enabled := True;
    SegParReszletCB.Enabled := True;
    SegParReszletCB.Color := clWindow;
    SegMerReszletLab.Enabled := True;
    SegMerReszletCB.Enabled := True;
    SegMerReszletCB.Color := clWindow;
  end else begin
    SegSzinCB.Enabled := False;
    SegSzinCB.Color := clMenu;

    Groupbox3.Enabled := False;
    SegParSurusegLab.Enabled := False;
    SegParSurusegFokEd.Enabled := False;
    SegParSurusegFokEd.Color := clMenu;
    SegParSurusegFokLab.Enabled := False;
    SegMerSurusegLab.Enabled := False;
    SegMerSurusegFokEd.Enabled := False;
    SegMerSurusegFokEd.Color := clMenu;
    SegMerSurusegFokLab.Enabled := False;

    Groupbox4.Enabled := False;
    SegParReszletLab.Enabled := False;
    SegParReszletCB.Enabled := False;
    SegParReszletCB.Color := clMenu;
    SegMerReszletLab.Enabled := False;
    SegMerReszletCB.Enabled := False;
    SegMerReszletCB.Color := clMenu;
  end;
end;

procedure TSettingsForm.PartChkClick(Sender: TObject);
begin
  if PartChk.State = cbChecked then begin
    PartSzinCB.Enabled := True;
    PartSzinCB.Color := clWindow;
  end else begin
    PartSzinCB.Enabled := False;
    PartSzinCB.Color := clMenu;
  end;
end;

procedure TSettingsForm.HatarChkClick(Sender: TObject);
begin
  if HatarChk.State = cbChecked then begin
    HatarSzinCB.Enabled := True;
    HatarSzinCB.Color := clWindow;
  end else begin
    HatarSzinCB.Enabled := False;
    HatarSzinCB.Color := clMenu;
  end;
end;

procedure TSettingsForm.ToChkClick(Sender: TObject);
begin
  if Tochk.State = cbChecked then begin
    ToSzinCB.Enabled := True;
    ToSzinCB.Color := clWindow;
  end else begin
    ToSzinCB.Enabled := False;
    ToSzinCB.Color := clMenu;
  end;
end;

procedure TSettingsForm.JellemBtnClick(Sender: TObject);
begin
  if AktivVetulet in [89,102] then // Érdi-Krausz-féle, Winkel-féle
    ParametersForm2.ShowModal
  else if AktivVetulet in [94,95,98] then // Apianus I., Bacon-féle, Collignon-féle
    ParametersForm3.Showmodal
  else if AktivVetulet in [109,110] then // Hullámvetületek
    ParametersForm4.Showmodal
  else // Minden egyéb
    ParametersForm1.ShowModal;
end;

procedure TSettingsForm.CimSorLabMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    Inside := (X > 2) and (X < 326) and (Y > 2) and (Y < 21);
    if Inside then begin
      WhereMouse.x := X;
      WhereMouse.y := Y;
    end;
  end;
end;

procedure TSettingsForm.CimSorLabMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Delta: TPoint;
begin
  if (ssLeft in Shift) and Inside then begin
    Delta.x := X - WhereMouse.x;
    Delta.y := Y - WhereMouse.y;
    Left := Left + Delta.X;
    Top := Top + Delta.Y;
  end;
end;

procedure TSettingsForm.ExitBtnClick(Sender: TObject);
begin
  PageControl1.SetFocus;
  Visible := False;
end;

procedure TSettingsForm.CloseBtnClick(Sender: TObject);
begin
  Height := 24;
  Width := 150;

  CimSorLab.Width := 144;
  OpenBtn.Visible := True;
  ExitBtn.Left := 129;
end;

procedure TSettingsForm.OpenBtnClick(Sender: TObject);
begin
  Width := 346;
  Height := 404;

  CimSorLab.Width := 339;
  ExitBtn.Left := 324;
  OpenBtn.Visible := False;
end;

procedure TSettingsForm.FormDeactivate(Sender: TObject);
begin
  CimSorLab.Color := clAppWorkSpace;
  CimLab.Font.Color := clSilver;
end;

procedure TSettingsForm.FormActivate(Sender: TObject);
begin
  CimSorLab.Color := clHighlight;
  CimLab.Font.Color := clWhite;
  PageControl1.SetFocus;
end;

procedure TSettingsForm.AlkalmazBtnClick(Sender: TObject);
begin
  MainForm.FrissitClick(AlkalmazBtn);
end;

procedure TSettingsForm.KozMerFokEdKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['-','0'..'9',#8]) then Key:=#0;
end;

procedure TSettingsForm.SorrendClick(Sender: TObject);
begin
  LayersForm.Show;
end;

procedure TSettingsForm.SorrendBtnClick(Sender: TObject);
begin
  LayersForm.Show;
end;

end.
