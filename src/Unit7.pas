unit Options;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Spin;

type
  TForm7 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Maigazit: TCheckBox;
    Abraigazit: TCheckBox;
    OKBtn: TButton;
    Autozoom: TCheckBox;
    Kozepigazit: TCheckBox;
    Margolabel: TLabel;
    Lapszazalek: TLabel;
    SzazalekEdit: TEdit;
    Szazaleklabel: TLabel;
    Legalabb: TLabel;
    LegalabbEdit: TEdit;
    KerekitLabel: TLabel;
    KerekComboBox: TComboBox;
    TabSheet3: TTabSheet;
    LapOn: TCheckBox;
    Lapmilyen: TComboBox;
    VastagBox: TGroupBox;
    Halovas: TLabel;
    Egyenlitovas: TLabel;
    Teritovas: TLabel;
    Segedvas: TLabel;
    Partvas: TLabel;
    Orszagvas: TLabel;
    Tovas: TLabel;
    Pont1: TLabel;
    Vas1: TSpinEdit;
    Vas2: TSpinEdit;
    Vas3: TSpinEdit;
    Vas4: TSpinEdit;
    Vas5: TSpinEdit;
    Vas6: TSpinEdit;
    Vas7: TSpinEdit;
    Pont2: TLabel;
    Pont3: TLabel;
    Pont4: TLabel;
    Pont5: TLabel;
    Pont6: TLabel;
    Pont7: TLabel;
    Kezdovas: TLabel;
    Vas8: TSpinEdit;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    totxt: TEdit;
    hatartxt: TEdit;
    parttxt: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PartfileBtn: TButton;
    HatarfileBtn: TButton;
    TofileBtn: TButton;
    OpenDialog1: TOpenDialog;
    HosszuChk: TCheckBox;
    procedure OKBtnClick(Sender: TObject);
    procedure MaigazitClick(Sender: TObject);
    procedure LegalabbEditKeyPress(Sender: TObject; var Key: Char);
    procedure LegalabbEditExit(Sender: TObject);
    procedure SzazalekEditKeyPress(Sender: TObject; var Key: Char);
    procedure SzazalekEditExit(Sender: TObject);
    procedure PartfileBtnClick(Sender: TObject);
    procedure HatarfileBtnClick(Sender: TObject);
    procedure TofileBtnClick(Sender: TObject);
    procedure AbraigazitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AutozoomClick(Sender: TObject);
    procedure KozepigazitClick(Sender: TObject);
    procedure LapOnClick(Sender: TObject);
    procedure HosszuChkClick(Sender: TObject);
    procedure LapmilyenChange(Sender: TObject);
    procedure Vas1Change(Sender: TObject);
    procedure Vas2Change(Sender: TObject);
    procedure Vas3Change(Sender: TObject);
    procedure Vas4Change(Sender: TObject);
    procedure Vas5Change(Sender: TObject);
    procedure Vas6Change(Sender: TObject);
    procedure Vas7Change(Sender: TObject);
    procedure Vas8Change(Sender: TObject);
    procedure SzazalekEditChange(Sender: TObject);
    procedure LegalabbEditChange(Sender: TObject);
    procedure KerekComboBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptionsForm: TForm7;
  Minmargo: Double=0;
  Minmargomi: Double=0;
  Szazalek: Byte=10;
  Progpart: Byte=41;
  Proghatar: Byte=5;
  Progto: Byte=4;

implementation

{$R *.DFM}

uses Page, Main;

function szamvizsgalo(szam:String):Boolean;
var i: Byte;
begin
 result:=True;
 for i:=Length(szam) downto 1 do
   if not (szam[i] in ['0'..'9',',']) then szamhossz:=i-1;
 if szamhossz=0 then result:=False else
 if szamhossz=1 then if szam[1]=',' then result:=False;
 if szamhossz>1 then
  begin
    if szam[1]=',' then result:=False;
    if (szam[1]='0') and (szam[2]<>',') then result:=False;
  end;
end;

procedure TForm7.OKBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TForm7.MaigazitClick(Sender: TObject);
begin
 Valt:=True;
 Vetvalt:=True;
 if not Elso and not Maigazit.Checked then MainForm.SpeedButton7.Enabled:=True;
end;

procedure TForm7.LegalabbEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [',','0'..'9',#8]) then Key:=#0;
end;

procedure TForm7.LegalabbEditExit(Sender: TObject);
var i:Double;
begin
 if Szamvizsgalo(LegalabbEdit.Text) then
  begin
   Minmargomi:=Atszamit(Eta,3,StrToFloat(Copy(LegalabbEdit.Text,1,szamhossz)));
   if Lx<Ly then i:=Lx else i:=Ly;
   if Minmargomi>=i/2 then
           begin
             LegalabbEdit.Setfocus;
             MessageDlg('Túl nagy méret',mtInformation,[mbOK],0);
           end;
  end
 else
  begin
      LegalabbEdit.SetFocus;
      MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
  end
end;

procedure TForm7.SzazalekEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8]) then Key:=#0;
end;

procedure TForm7.SzazalekEditExit(Sender: TObject);
begin
 if (Nagyitvizsgal(SzazalekEdit.Text)) or (SzazalekEdit.Text='0') then
  begin
   Szazalek:=StrToInt(SzazalekEdit.Text);
   if Szazalek>=50 then
           begin
             SzazalekEdit.Setfocus;
             MessageDlg('Túl nagy méret',mtInformation,[mbOK],0);
           end;
  end
 else
  begin
    SzazalekEdit.SetFocus;
    MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
  end
end;

procedure TForm7.PartfileBtnClick(Sender: TObject);
begin
  Valt:=True;
  OpenDialog1.InitialDir:=AlapDir;
  if OpenDialog1.Execute then
   if ExtractFileDir(OpenDialog1.FileName)=AlapDir
    then Parttxt.Text:=ExtractFileName(OpenDialog1.FileName)
    else Parttxt.Text:=OpenDialog1.FileName;
end;

procedure TForm7.HatarfileBtnClick(Sender: TObject);
begin
  Valt:=True;
  OpenDialog1.InitialDir:=AlapDir;
  if OpenDialog1.Execute then
   if ExtractFileDir(OpenDialog1.FileName)=AlapDir
    then Hatartxt.Text:=ExtractFileName(OpenDialog1.FileName)
    else Hatartxt.Text:=OpenDialog1.FileName;
end;

procedure TForm7.TofileBtnClick(Sender: TObject);
begin
  Valt:=True;
  OpenDialog1.InitialDir:=AlapDir;
  if OpenDialog1.Execute then
   if ExtractFileDir(OpenDialog1.FileName)=AlapDir
    then Totxt.Text:=ExtractFileName(OpenDialog1.FileName)
    else Totxt.Text:=OpenDialog1.FileName;
end;

procedure TForm7.AbraigazitClick(Sender: TObject);
begin
  Valt:=True;
  Vetvalt:=True;
  Sajt3:=True;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
    parttxt.Text:=IniFile.ReadString('Adatbazis','Partok','part.txt');
    hatartxt.Text:=IniFile.ReadString('Adatbazis','Hatarok','hatar.txt');
    totxt.Text:=IniFile.ReadString('Adatbazis','Tavak','to.txt');
    Abraigazit.Checked:=IniFile.ReadBool('Meretezes','Abraigazitas',True);
    Maigazit.Checked:=IniFile.ReadBool('Meretezes','Maigazitas',True);
    Autozoom.Checked:=IniFile.ReadBool('Meretezes','Autozoom',True);
    Kozepigazit.Checked:=IniFile.ReadBool('Meretezes','Kozepreigazitas',True);
    SzazalekEdit.Text:=IniFile.ReadString('Meretezes','Margo1','10');
    LegalabbEdit.Text:=IniFile.ReadString('Meretezes','Margo2','0 '+SI[Eta]);
    KerekCombobox.Itemindex:=IniFile.ReadInteger('Meretezes','Kerekites',1);
    LapOn.Checked:=IniFile.ReadBool('Megjelenites','Lap',True);
    Lapmilyen.Itemindex:=IniFile.ReadInteger('Megjelenites','Laphogyan',0);
    HosszuChk.Checked:=IniFile.ReadBool('Megjelenites','Hosszuvonal',True);
    Vas1.Value:=IniFile.ReadInteger('Megjelenites','Fokhalozat',1);
    Vas2.Value:=IniFile.ReadInteger('Megjelenites','Egyenlito',2);
    Vas3.Value:=IniFile.ReadInteger('Megjelenites','Kezdomeridian',2);
    Vas4.Value:=IniFile.ReadInteger('Megjelenites','Teritok',1);
    Vas5.Value:=IniFile.ReadInteger('Megjelenites','Segedfokhalozat',1);
    Vas6.Value:=IniFile.ReadInteger('Megjelenites','Partok',1);
    Vas7.Value:=IniFile.ReadInteger('Megjelenites','Hatarok',1);
    Vas8.Value:=IniFile.ReadInteger('Megjelenites','Tavak',1);
end;

procedure TForm7.AutozoomClick(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.KozepigazitClick(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.LapOnClick(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.HosszuChkClick(Sender: TObject);
begin
  Valt:=True
end;

procedure TForm7.LapmilyenChange(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.Vas1Change(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.Vas2Change(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.Vas3Change(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.Vas4Change(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.Vas5Change(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.Vas6Change(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.Vas7Change(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.Vas8Change(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.SzazalekEditChange(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.LegalabbEditChange(Sender: TObject);
begin
  Valt:=True;
end;

procedure TForm7.KerekComboBoxChange(Sender: TObject);
begin
  Valt:=True;
end;

end.
