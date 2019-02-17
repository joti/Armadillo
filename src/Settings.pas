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
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ToChk: TCheckBox;
    ToSzinCB: TComboBox;
    AlkalmazBtn: TButton;
    PopupMenu1: TPopupMenu;
    Sorrend: TMenuItem;
    GroupBox1: TGroupBox;
    ParSurusegLab: TLabel;
    ParSurusegFok: TEdit;
    ParSurusegFokLab: TLabel;
    MerSurusegLab: TLabel;
    MerSurusegFok: TEdit;
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
    SegParSurusegFok: TEdit;
    SegMerSurusegFok: TEdit;
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
    KozMerFok: TEdit;
    KozMerFokLab: TLabel;
    SegedPolusLab: TLabel;
    PolusSzelesLab: TLabel;
    PolusHosszuLab: TLabel;
    PolusSzelesFok: TEdit;
    PolusHosszuFok: TEdit;
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
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ToChkClick(Sender: TObject);
    procedure AlkalmazBtnClick(Sender: TObject);
    procedure KozMerFokKeyPress(Sender: TObject; var Key: Char);
    procedure SorrendClick(Sender: TObject);
    procedure SorrendBtnClick(Sender: TObject);
  private
    { Private declarations }
    WhereMouse,Delta: TPoint;
    Inside: Boolean;
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

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
  CsaladCB.Itemindex:=0;

  Vet[0]:='Postel-f�le';
  Vet[1]:='Lambert-f�le';
  Vet[2]:='Sztereografikus';
  Vet[3]:='Gnomonikus';
  Vet[4]:='Ortografikus';

  Vet[20]:='Ptolemaiosz-f�le';
  Vet[21]:='De l''Isle-f�le';
  Vet[22]:='Sz�gtart� �s egy paralelk�rben hossztart�';
  Vet[23]:='Lambert-Gauss-f�le';
  Vet[24]:='Albers-f�le';
  Vet[25]:='Ter�lettart� �s egy paralelk�rben hossztart�';
  Vet[26]:='Lambert-f�le';
  Vet[27]:='Perspekt�v';

  Vet[40]:='N�gyzetes';
  Vet[41]:='Meridi�nban �s k�t paralelk�rben hossztart�';
  Vet[42]:='Lambert-f�le';
  Vet[43]:='Ter�lettart� �s k�t paralelk�rben hossztart�';
  Vet[44]:='Mercator-f�le';
  Vet[45]:='Sz�gtart� �s k�t paralelk�rben hossztart�';
  Vet[46]:='Perspekt�v';

  Vet[60]:='Bonne-f�le';
  Vet[61]:='Werner-f�le';
  Vet[62]:='Egyszer�/amerikai polik�nikus';
  Vet[63]:='Ortogon�lis polik�nikus';
  Vet[64]:='Ter�lettart� polik�nikus';
  Vet[65]:='Sz�gtart� polik�nikus';
  Vet[66]:='Van der Grinten I.';
  Vet[67]:='Van der Grinten II.';
  Vet[68]:='Van der Grinten IV.';
  Vet[69]:='Lagrange-f�le';
  Vet[70]:='Fournier I.';

  Vet[80]:='Mercator-Sanson-f�le';
  Vet[81]:='Kavrajszkij I.';
  Vet[82]:='Eckert V.';
  Vet[83]:='Eckert VI.';
  Vet[84]:='Apianus II.';
  Vet[85]:='Mollweide-f�le';
  Vet[86]:='Eckert III.';
  Vet[87]:='Eckert IV.';
  Vet[88]:='Kavrajszkij II.';
  Vet[89]:='�rdi-Krausz-f�le';
  Vet[90]:='Goode-f�le';
  Vet[91]:='Baranyi II.';
  Vet[92]:='Baranyi IV.';
  Vet[93]:='Robinson-f�le';
  Vet[94]:='Apianus I.';
  Vet[95]:='Bacon-f�le';
  Vet[96]:='Ortelius-f�le';
  Vet[97]:='Donis-f�le';
  Vet[98]:='Collignon-f�le';
  Vet[99]:='Eckert I.';
  Vet[180]:='Eckert II.';
  Vet[181]:='Van der Grinten III.';
  Vet[182]:='Oldfield I.';
  Vet[183]:='Oldfield II.';

  Vet[100]:='Hammer-f�le';
  Vet[101]:='Aitoff-f�le';
  Vet[102]:='Winkel-f�le';
  Vet[103]:='Briesemeister-f�le';
  Vet[104]:='Wagner VII.';
  Vet[105]:='Eisenlohr-f�le';
  Vet[106]:='August-f�le';
  Vet[107]:='Armadillo';
  Vet[108]:='Oldfield III.';
  Vet[109]:='Egyszer� hull�mvet�let';
  Vet[110]:='Lambert-f�le hull�mvet�let';

  for i:= 0 to 4 do
    VetuletCB.Items.Add(Vet[i]);
  VetuletCB.Itemindex:=0;
  KezdoMerPolusCB.Itemindex:=0;
end;

procedure TSettingsForm.CsaladCBChange(Sender: TObject);
var h,i,k: byte;
begin
  Vetvalt := True;
  Lupe := False;
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

   fi1:=fi1alap;
   fi2:=fi2alap;
   fin:=finalap;
   fia:=fiaalap;
   if CsaladCB.Itemindex = 2 then
     fin:=finalap2;

   ParametersForm1.Fok1.Text:=IntToStr(fi1);
   ParametersForm1.Fok2.Text:=IntToStr(fi2);
   ParametersForm1.Fokn.Text:=IntToStr(fin);
   ParametersForm1.Foka.Text:=FloatToStr(fia);
   ParametersForm1.Iranybox.Itemindex:=0;
   if not ParametersForm1.Foka.Enabled then
    begin
      ParametersForm1.VegtelenChk.Checked:=False;
      ParametersForm1.Foka.Enabled:=True;
      ParametersForm1.Foklabela.Enabled:=True;
      ParametersForm1.Iranybox.Enabled:=True;
      ParametersForm1.Iranybox.Itemindex:=0;
      ParametersForm1.Iranylabel.Enabled:=True;
    end;
end;

procedure TSettingsForm.VetuletCBChange(Sender: TObject);
begin
  Vetvalt:=True;
  Lupe:=False;
  Lapba:=False;
  Sajt:=False;
  Crop:=False;
  origomas:=False;

  if VetuletCB.Itemindex > 19 then
    aktiv := 80 + 20 * CsaladCB.Itemindex + VetuletCB.Itemindex
  else
    aktiv := 20 * CsaladCB.Itemindex + VetuletCB.Itemindex;
  if aktiv in [2,3,20..27,41,43,44,45,46,60,62,63,64,65,69,89,102,107,94,95,98,109,110]
   then JellemBtn.Enabled:=True
   else JellemBtn.Enabled:=False;
  case aktiv of
  46: begin
       ParametersForm1.VegtelenChk.Checked:=False;
       ParametersForm1.Foklabela.Enabled:=True;
       ParametersForm1.Foka.Enabled:=True;
      end;
  69: fik:=fikalap4;
  89: begin
       fis:=60;
       ParametersForm2.Finbox.Clear;
       ParametersForm2.Finbox.Items.Add('60');
       ParametersForm2.Finbox.Items.Add('70');
       ParametersForm2.Finbox.Itemindex:=0;
      end;
  102:begin
       fis:=40;
       ParametersForm2.Finbox.Clear;
       ParametersForm2.Finbox.Items.Add('40');
       ParametersForm2.Finbox.Items.Add('50,467');
       ParametersForm2.Finbox.Itemindex:=0;
      end;
  end;
  case aktiv of
  2,22,23,27: fik:=fikalap1;
  3,44,45,46: fik:=fikalap2;
  62,63,64: fia:=fiaalap2;
  65: fik:=fikalap3;
  69: fia:=fiaalap3;
  107: fin:=finalap3;
  109,110:
   begin
     fia2:=fia2alap;
     fih:=fihalap;
   end;
  end;
end;

procedure TSettingsForm.FerdeBtnClick(Sender: TObject);
begin
  // Ferdetengely� elhelyez�s komponenseinek enged�lyez�se
  FerdeBtn.TabStop := True;
  SegedPolusLab.Enabled := True;

  PolusSzelesLab.Enabled := True;
  PolusSzelesFokLab.Enabled := True;
  PolusSzelesFok.Enabled:=True;
  PolusSzelesFok.Color:=clWindow;

  PolusHosszuLab.Enabled := True;
  PolusHosszuFok.Color:=clWindow;
  PolusHosszuFok.Enabled:=True;
  PolusHosszuFokLab.Enabled := True;

  KezdoMerLab.Enabled := True;
  KezdoMerPolusCB.Color := clWindow;
  KezdoMerPolusCB.Enabled := True;
  KezdoMerPolusLab.Enabled := True;

  // Norm�lis elhelyez�s komponenseinek tilt�sa
  NormalBtn.TabStop := False;
  NormalBtn.Checked := False;
  KozMerLab.Enabled := False;
  KozMerFok.Enabled := False;
  KozMerFok.Color := clMenu;
  KozMerFokLab.Enabled := False;

  // Seg�dfokh�l�zat enged�lyez�se
  SegedChk.Enabled := True;
  if SegedChk.Checked then begin
    SegSzinCB.Enabled := True;
    SegSzinCB.Color := clWindow;

    Groupbox3.Enabled := True;
    SegParSurusegLab.Enabled := True;
    SegMerSurusegLab.Enabled := True;
    SegParSurusegFok.Enabled := True;
    SegParSurusegFok.Color := clWindow;
    SegMerSurusegFok.Enabled := True;
    SegMerSurusegFok.Color := clWindow;
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
  // Norm�lis elhelyez�s komponenseinek enged�lyez�se
  NormalBtn.TabStop := True;
  KozMerLab.Enabled := True;
  KozMerFok.Enabled := True;
  KozMerFok.Color := clWindow;
  KozMerFokLab.Enabled := True;


  // Ferdetengely� elhelyez�s komponenseinek tilt�sa
  Ferdebtn.TabStop := False;
  Ferdebtn.Checked := False;

  SegedPolusLab.Enabled := False;
  PolusSzelesLab.Enabled := False;
  PolusSzelesFok.Enabled := False;
  PolusSzelesFok.Color := clMenu;
  PolusSzelesFokLab.Enabled := False;
  PolusHosszuLab.Enabled := False;
  PolusHosszuFok.Color := clMenu;
  PolusHosszuFok.Enabled := False;
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
  SegParSurusegFok.Enabled := False;
  SegParSurusegFok.Color := clMenu;
  SegParSurusegFokLab.Enabled := False;
  SegMerSurusegLab.Enabled := False;
  SegMerSurusegFok.Enabled := False;
  SegMerSurusegFok.Color := clMenu;
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
    ParSurusegFok.Enabled := True;
    ParSurusegFok.Color := clWindow;
    MerSurusegFok.Enabled := True;
    MerSurusegFok.Color := clWindow;
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
    ParSurusegFok.Enabled := False;
    ParSurusegFok.Color := clMenu;
    MerSurusegFok.Enabled := False;
    MerSurusegFok.Color := clMenu;
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
    SegParSurusegFok.Enabled := True;
    SegParSurusegFok.Color := clWindow;
    SegParSurusegFokLab.Enabled := True;
    SegMerSurusegLab.Enabled := True;
    SegMerSurusegFok.Enabled := True;
    SegMerSurusegFok.Color := clWindow;
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
    SegParSurusegFok.Enabled := False;
    SegParSurusegFok.Color := clMenu;
    SegParSurusegFokLab.Enabled := False;
    SegMerSurusegLab.Enabled := False;
    SegMerSurusegFok.Enabled := False;
    SegMerSurusegFok.Color := clMenu;
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
  if aktiv in [89,102] then
    ParametersForm2.ShowModal
  else if aktiv in [94,95,98] then
    ParametersForm3.Showmodal
  else if aktiv in [109,110] then
    ParametersForm4.Showmodal
  else
    ParametersForm1.ShowModal;
end;

procedure TSettingsForm.Label1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    Inside := (X > 2) and (X < 326) and (Y > 2) and (Y < 21);
    if Inside then begin
      WhereMouse.x := X;
      WhereMouse.y := Y;
    end;
  end;
end;

procedure TSettingsForm.Label1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) and Inside then begin
    Delta.x := X - WhereMouse.x;
    Delta.y := Y - WhereMouse.y;
    Left := Left + Delta.X;
    Top := Top + Delta.Y;
  end;
end;

procedure TSettingsForm.BitBtn2Click(Sender: TObject);
begin
  PageControl1.SetFocus;
  Visible := False;
end;

procedure TSettingsForm.BitBtn1Click(Sender: TObject);
begin
  Height := 24;
  Width := 150;

  Label1.Width := 144;
  BitBtn3.Visible := True;
  BitBtn2.Left := 129;
end;

procedure TSettingsForm.BitBtn3Click(Sender: TObject);
begin
  Width := 346;
  Height := 404;

  Label1.Width := 339;
  BitBtn2.Left := 324;
  BitBtn3.Visible := False;
end;

procedure TSettingsForm.FormDeactivate(Sender: TObject);
begin
  Label1.Color := clAppWorkSpace;
  CimLab.Font.Color := clSilver;
end;

procedure TSettingsForm.FormActivate(Sender: TObject);
begin
  Label1.Color := clHighlight;
  CimLab.Font.Color := clWhite;
  PageControl1.SetFocus;
end;

procedure TSettingsForm.AlkalmazBtnClick(Sender: TObject);
begin
  MainForm.FrissitClick(AlkalmazBtn);
end;

procedure TSettingsForm.KozMerFokKeyPress(Sender: TObject; var Key: Char);
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
