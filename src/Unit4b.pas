unit Settings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, Menus;

type
  SettingsForm = class(TForm)
    BPanel: TPanel;
    PageControl1: TPageControl;
    Vetuletbox: TTabSheet;
    csaladlabel: TLabel;
    Vetuletlabel: TLabel;
    csalad: TComboBox;
    vetulet: TComboBox;
    JellemBtn: TButton;
    Tartalombox: TTabSheet;
    Fokchk: TCheckBox;
    Segedchk: TCheckBox;
    Kontichk: TCheckBox;
    Orszagchk: TCheckBox;
    Szin2: TComboBox;
    Szin1: TComboBox;
    Szin4: TComboBox;
    Szin3: TComboBox;
    BeallitLabel: TLabel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Tochk: TCheckBox;
    Szin5: TComboBox;
    AlkalmazBtn: TButton;
    PopupMenu1: TPopupMenu;
    Sorrend: TMenuItem;
    GroupBox1: TGroupBox;
    VonalLabel1: TLabel;
    Fok4: TEdit;
    FokonLabel1: TLabel;
    VonalLabel2: TLabel;
    Fok5: TEdit;
    FokonLabel2: TLabel;
    Teritochk: TCheckBox;
    GroupBox2: TGroupBox;
    ReszletLabel1: TLabel;
    ReszletLabel2: TLabel;
    ReszletBox2: TComboBox;
    ReszletBox1: TComboBox;
    GroupBox3: TGroupBox;
    VonalLabel4: TLabel;
    VonalLabel3: TLabel;
    Fok6: TEdit;
    Fok7: TEdit;
    FokonLabel4: TLabel;
    FokonLabel3: TLabel;
    GroupBox4: TGroupBox;
    ReszletBox4: TComboBox;
    ReszletBox3: TComboBox;
    ReszletLabel3: TLabel;
    ReszletLabel4: TLabel;
    GroupBox5: TGroupBox;
    Normalbtn: TRadioButton;
    Ferdebtn: TRadioButton;
    Kozepmer: TLabel;
    Fok1: TEdit;
    Foklabel1: TLabel;
    Segedlabel: TLabel;
    Szeleslabel: TLabel;
    Hosszulabel: TLabel;
    Fok2: TEdit;
    Fok3: TEdit;
    Foklabel2: TLabel;
    Foklabel3: TLabel;
    KezdoLabel: TLabel;
    Polusbox: TComboBox;
    PolusLabel: TLabel;
    SorrendButton: TButton;
    procedure VetuletChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CsaladChange(Sender: TObject);
    procedure FerdebtnClick(Sender: TObject);
    procedure NormalbtnClick(Sender: TObject);
    procedure SegedClick(Sender: TObject);
    procedure FokClick(Sender: TObject);
    procedure KontiClick(Sender: TObject);
    procedure Orszagclick(Sender: TObject);
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
    procedure TochkClick(Sender: TObject);
    procedure AlkalmazBtnClick(Sender: TObject);
    procedure Fok1KeyPress(Sender: TObject; var Key: Char);
    procedure SorrendClick(Sender: TObject);
    procedure SorrendButtonClick(Sender: TObject);
  private
    { Private declarations }
    WhereMouse,Delta: TPoint;
    Inside: Boolean;
  public
    { Public declarations }
  end;

var
  Form4: SettingsForm;

implementation

{$R *.DFM}

uses Main, About, Parameters1, Layers, Parameters2, Parameters3, Parameters4;

procedure SettingsForm.VetuletChange(Sender: TObject);
begin
  Vetvalt:=True;
  Lupe:=False;
  Lapba:=False;
  Sajt:=False;
  Crop:=False;
  origomas:=False;
  if Vetulet.Itemindex>19 then aktiv:=80+20*Csalad.Itemindex+Vetulet.Itemindex
  else aktiv:=20*Csalad.Itemindex+Vetulet.Itemindex;
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

procedure SettingsForm.FormCreate(Sender: TObject);
var i: Byte;
begin
  ReszletBox1.ItemIndex:=4;
  ReszletBox2.ItemIndex:=4;
  ReszletBox3.ItemIndex:=4;
  ReszletBox4.ItemIndex:=4;
  Szin1.Itemindex:=0;
  Szin2.Itemindex:=0;
  Szin3.Itemindex:=0;
  Szin4.Itemindex:=0;
  Szin5.Itemindex:=0;
  Csalad.Itemindex:=0;
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
  for i:=0 to 4 do Vetulet.Items.Add(Vet[i]);
  Vetulet.Itemindex:=0;
  Polusbox.Itemindex:=0;
end;

procedure SettingsForm.CsaladChange(Sender: TObject);
var h,i,k:byte;
begin
  Vetvalt:=True;
  Lupe:=False;
  origomas:=False;
  for i:=0 to 5 do
   begin
    l:=0;
    if Csalad.Itemindex=i then
     begin
     Vetulet.Clear;
     if Csalad.Itemindex=0 then h:=0 else h:=1;
     for k:=0 to h do
     begin
      j:=0;
      repeat
       if Vet[100*k+20*i+j]='' then j:=j+1
       else begin
             Vetulet.Items.Add(Vet[100*k+20*i+j]);
             l:=l+1;
             j:=j+1;
            end;
      until j=20;
     end;
     Vetulet.Itemindex:=0;
     VetuletChange(Csalad);
     end;
   end;
   fi1:=fi1alap;
   fi2:=fi2alap;
   fin:=finalap;
   fia:=fiaalap;
   if Csalad.Itemindex=2 then fin:=finalap2;
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

procedure SettingsForm.FerdebtnClick(Sender: TObject);
begin
  Foklabel2.Enabled:=True;
  Foklabel3.Enabled:=True;
  Segedlabel.Enabled:=True;
  Szeleslabel.Enabled:=True;
  Hosszulabel.Enabled:=True;
  Kezdolabel.Enabled:=True;
  Poluslabel.Enabled:=True;
  Kozepmer.Enabled:=False;
  Foklabel1.Enabled:=False;
  Ferdebtn.TabStop:=True;
  Normalbtn.TabStop:=False;
  Normalbtn.Checked:=False;
  Fok1.Enabled:=False;
  Fok1.Color:=clMenu;
  Fok2.Enabled:=True;
  Fok2.Color:=clWindow;
  Fok3.Color:=clWindow;
  Fok3.Enabled:=True;
  Polusbox.Color:=clWindow;
  Polusbox.Enabled:=True;
  Segedchk.Enabled:=True;
  if Segedchk.Checked=True then
   begin
    Szin2.Enabled:=True;
    Fok6.Enabled:=True;
    Fok7.Enabled:=True;
    Szin2.Color:=clWindow;
    Fok6.Color:=clWindow;
    Fok7.Color:=clWindow;
    VonalLabel3.Enabled:=True;
    VonalLabel4.Enabled:=True;
    FokonLabel3.Enabled:=True;
    FokonLabel4.Enabled:=True;
    Groupbox3.Enabled:=True;
    Groupbox4.Enabled:=True;
    ReszletLabel3.Enabled:=True;
    ReszletLabel4.Enabled:=True;
    Reszletbox3.Enabled:=True;
    Reszletbox4.Enabled:=True;
    Reszletbox3.Color:=clWindow;
    Reszletbox4.Color:=clWindow;
   end;
end;

procedure SettingsForm.NormalbtnClick(Sender: TObject);
begin
  Kozepmer.Enabled:=True;
  Foklabel1.Enabled:=True;
  Foklabel2.Enabled:=False;
  Foklabel3.Enabled:=False;
  Segedlabel.Enabled:=False;
  Szeleslabel.Enabled:=False;
  Hosszulabel.Enabled:=False;
  Kezdolabel.Enabled:=False;
  Poluslabel.Enabled:=False;
  Normalbtn.TabStop:=True;
  Ferdebtn.TabStop:=False;
  Ferdebtn.Checked:=False;
  Fok1.Enabled:=True;
  Fok1.Color:=clWindow;
  Fok2.Enabled:=False;
  Fok2.Color:=clMenu;
  Fok3.Color:=clMenu;
  Fok3.Enabled:=False;
  Polusbox.Color:=clMenu;
  Polusbox.Enabled:=False;
  Segedchk.Enabled:=False;
  VonalLabel3.Enabled:=False;
  VonalLabel4.Enabled:=False;
  FokonLabel3.Enabled:=False;
  FokonLabel4.Enabled:=False;
  Groupbox3.Enabled:=False;
  Groupbox4.Enabled:=False;
  ReszletLabel3.Enabled:=False;
  ReszletLabel4.Enabled:=False;
  Reszletbox3.Enabled:=False;
  Reszletbox4.Enabled:=False;
  Reszletbox3.Color:=clMenu;
  Reszletbox4.Color:=clMenu;
  Szin2.Enabled:=False;
  Fok6.Enabled:=False;
  Fok7.Enabled:=False;
  Szin2.Color:=clMenu;
  Fok6.Color:=clMenu;
  Fok7.Color:=clMenu;
end;

procedure SettingsForm.SegedClick(Sender: TObject);
begin
  if Segedchk.State=cbChecked then
   begin
    Szin2.Enabled:=True;
    Fok6.Enabled:=True;
    Fok7.Enabled:=True;
    Szin2.Color:=clWindow;
    Fok6.Color:=clWindow;
    Fok7.Color:=clWindow;
    VonalLabel3.Enabled:=True;
    VonalLabel4.Enabled:=True;
    FokonLabel3.Enabled:=True;
    FokonLabel4.Enabled:=True;
    Groupbox3.Enabled:=True;
    Groupbox4.Enabled:=True;
    ReszletLabel3.Enabled:=True;
    ReszletLabel4.Enabled:=True;
    Reszletbox3.Enabled:=True;
    Reszletbox4.Enabled:=True;
    Reszletbox3.Color:=clWindow;
    Reszletbox4.Color:=clWindow;
   end
  else
   begin
    Szin2.Enabled:=False;
    Fok6.Enabled:=False;
    Fok7.Enabled:=False;
    Szin2.Color:=clMenu;
    Fok6.Color:=clMenu;
    Fok7.Color:=clMenu;
    VonalLabel3.Enabled:=False;
    VonalLabel4.Enabled:=False;
    FokonLabel3.Enabled:=False;
    FokonLabel4.Enabled:=False;
    Groupbox3.Enabled:=False;
    Groupbox4.Enabled:=False;
    ReszletLabel3.Enabled:=False;
    ReszletLabel4.Enabled:=False;
    Reszletbox3.Enabled:=False;
    Reszletbox4.Enabled:=False;
    Reszletbox3.Color:=clMenu;
    Reszletbox4.Color:=clMenu;
   end;
end;

procedure SettingsForm.FokClick(Sender: TObject);
begin
  if Fokchk.State=cbChecked then
   begin
    Szin1.Enabled:=True;
    Fok4.Enabled:=True;
    Fok5.Enabled:=True;
    Teritochk.Enabled:=True;
    Szin1.Color:=clWindow;
    Fok4.Color:=clWindow;
    Fok5.Color:=clWindow;
    VonalLabel1.Enabled:=True;
    VonalLabel2.Enabled:=True;
    FokonLabel1.Enabled:=True;
    FokonLabel2.Enabled:=True;
   end
  else
   begin
    Szin1.Enabled:=False;
    Fok4.Enabled:=False;
    Fok5.Enabled:=False;
    Szin1.Color:=clMenu;
    Fok4.Color:=clMenu;
    Fok5.Color:=clMenu;
    Teritochk.Enabled:=False;
    VonalLabel1.Enabled:=False;
    VonalLabel2.Enabled:=False;
    FokonLabel1.Enabled:=False;
    FokonLabel2.Enabled:=False;
   end;
end;

procedure SettingsForm.KontiClick(Sender: TObject);
begin
   if Kontichk.State=cbChecked then
   begin
    Szin3.Enabled:=True;
    Szin3.Color:=clWindow;
   end
  else
   begin
    Szin3.Enabled:=False;
    Szin3.Color:=clMenu;
   end;
end;

procedure SettingsForm.Orszagclick(Sender: TObject);
begin
 if Orszagchk.State=cbChecked then
   begin
    Szin4.Enabled:=True;
    Szin4.Color:=clWindow;
   end
  else
   begin
    Szin4.Enabled:=False;
    Szin4.Color:=clMenu;
   end;
end;

procedure SettingsForm.JellemBtnClick(Sender: TObject);
begin
  if aktiv in [89,102] then ParametersForm2.ShowModal else
  if aktiv in [94,95,98] then Form11.Showmodal else
  if aktiv in [109,110] then Form12.Showmodal else
  ParametersForm1.ShowModal;
end;

procedure SettingsForm.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbLeft then
  begin
   Inside:=(X>2) and (X<326) and (Y>2) and (Y<21);
   if Inside then
    begin
     WhereMouse.x:=X;
     WhereMouse.y:=Y;
    end;
  end;
end;

procedure SettingsForm.Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (ssLeft in Shift) and Inside then
   begin
   Delta.x:=X-WhereMouse.x;
   Delta.y:=Y-WhereMouse.y;
   Left:=Left+Delta.X;
   Top:=Top+Delta.Y;
   end;
end;


procedure SettingsForm.BitBtn2Click(Sender: TObject);
begin
  PageControl1.SetFocus;
  Visible:=False;
end;

procedure SettingsForm.BitBtn1Click(Sender: TObject);
begin
  Height:=24;
  Width:=150;
  Label1.Width:=144;
  Bitbtn3.Visible:=True;
  Bitbtn2.Left:=129;
end;

procedure SettingsForm.BitBtn3Click(Sender: TObject);
begin
  Width:=346;
  Height:=404;
  Label1.Width:=339;
  Bitbtn2.Left:=324;
  Bitbtn3.Visible:=False;
end;

procedure SettingsForm.FormDeactivate(Sender: TObject);
begin
  Label1.Color:=clAppWorkSpace;
  BeallitLabel.Font.Color:=clSilver;
end;

procedure SettingsForm.FormActivate(Sender: TObject);
begin
  Label1.Color:=clHighlight;
  BeallitLabel.Font.Color:=clWhite;
  PageControl1.SetFocus;
end;

procedure SettingsForm.TochkClick(Sender: TObject);
begin
   if Tochk.State=cbChecked then
   begin
    Szin5.Enabled:=True;
    Szin5.Color:=clWindow;
   end
  else
   begin
    Szin5.Enabled:=False;
    Szin5.Color:=clMenu;
   end;
end;

procedure SettingsForm.AlkalmazBtnClick(Sender: TObject);
begin
  MainForm.FrissitClick(AlkalmazBtn);
end;

procedure SettingsForm.Fok1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['-','0'..'9',#8]) then Key:=#0;
end;

procedure SettingsForm.SorrendClick(Sender: TObject);
begin
  LayersForm.Show;
end;

procedure SettingsForm.SorrendButtonClick(Sender: TObject);
begin
  LayersForm.Show;
end;

end.
