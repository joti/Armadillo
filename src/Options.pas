unit Options;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, Spin;

  type
    TOptionsForm = class(TForm)
      PageControl1: TPageControl;
      TabSheet1: TTabSheet;
      TabSheet2: TTabSheet;
    MaigazitChk: TCheckBox;
    AbraigazitChk: TCheckBox;
      OKBtn: TButton;
    AutozoomChk: TCheckBox;
    KozepigazitChk: TCheckBox;
    MargoLab: TLabel;
    LapszazalekLab: TLabel;
      SzazalekEd: TEdit;
    SzazalekLab: TLabel;
    LegalabbLab: TLabel;
      LegalabbEd: TEdit;
    KerekitLab: TLabel;
      KerekitesCB: TComboBox;
      TabSheet3: TTabSheet;
    LapOnChk: TCheckBox;
    LapRajzCB: TComboBox;
      VastagBox: TGroupBox;
    HaloVasLab: TLabel;
    EgyenlitoVasLab: TLabel;
    TeritoVasLab: TLabel;
    SegedVasLab: TLabel;
    PartVasLab: TLabel;
    HatarVasLab: TLabel;
    ToVasLab: TLabel;
    Pont1Lab: TLabel;
    HaloVasEd: TSpinEdit;
    EgyenlitoVasEd: TSpinEdit;
    KezdoVasEd: TSpinEdit;
    TeritoVasEd: TSpinEdit;
    SegedVasEd: TSpinEdit;
    PartVasEd: TSpinEdit;
    HatarVasEd: TSpinEdit;
    Pont2Lab: TLabel;
    Pont3Lab: TLabel;
    Pont4Lab: TLabel;
    Pont5Lab: TLabel;
    Pont6Lab: TLabel;
    Pont7Lab: TLabel;
    KezdoVasLab: TLabel;
    ToVasEd: TSpinEdit;
    Pont8Lab: TLabel;
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
      procedure MaigazitChkClick(Sender: TObject);
      procedure LegalabbEdKeyPress(Sender: TObject; var Key: Char);
      procedure LegalabbEdExit(Sender: TObject);
      procedure SzazalekEdKeyPress(Sender: TObject; var Key: Char);
      procedure SzazalekEdExit(Sender: TObject);
      procedure PartfileBtnClick(Sender: TObject);
      procedure HatarfileBtnClick(Sender: TObject);
      procedure TofileBtnClick(Sender: TObject);
      procedure AbraigazitChkClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure AutozoomChkClick(Sender: TObject);
      procedure KozepigazitChkClick(Sender: TObject);
      procedure LapOnChkClick(Sender: TObject);
      procedure HosszuChkClick(Sender: TObject);
      procedure LapRajzCBChange(Sender: TObject);
      procedure HaloVasEdChange(Sender: TObject);
      procedure EgyenlitoVasEdChange(Sender: TObject);
      procedure KezdoVasEdChange(Sender: TObject);
      procedure TeritoVasEdChange(Sender: TObject);
      procedure SegedVasEdChange(Sender: TObject);
      procedure PartVasEdChange(Sender: TObject);
      procedure HatarVasEdChange(Sender: TObject);
      procedure ToVasEdChange(Sender: TObject);
      procedure SzazalekEdChange(Sender: TObject);
      procedure LegalabbEdChange(Sender: TObject);
      procedure KerekitesCBChange(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
    end;

  var
    OptionsForm: TOptionsForm;
    Minmargo: Double=0;
    Minmargomi: Double=0;
    Szazalek: Byte=10;
    Progpart: Byte=41;
    Proghatar: Byte=5;
    Progto: Byte=4;

implementation

{$R *.DFM}

  uses Page, Main, General;

  procedure TOptionsForm.FormCreate(Sender: TObject);
  begin
    // koordinátafájlok
    parttxt.Text  := IniFile.ReadString('Adatbazis', 'Partok', 'part.txt');
    hatartxt.Text := IniFile.ReadString('Adatbazis', 'Hatarok', 'hatar.txt');
    totxt.Text    := IniFile.ReadString('Adatbazis', 'Tavak', 'to.txt');

    // méretezés, igazítás
    AbraigazitChk.Checked   := IniFile.ReadBool   ('Meretezes', 'Abraigazitas'   , True);
    MaigazitChk.Checked     := IniFile.ReadBool   ('Meretezes', 'Maigazitas'     , True);
    AutozoomChk.Checked     := IniFile.ReadBool   ('Meretezes', 'Autozoom'       , True);
    KozepigazitChk.Checked  := IniFile.ReadBool   ('Meretezes', 'Kozepreigazitas', True);
    SzazalekEd.Text         := IniFile.ReadString ('Meretezes', 'Margo1'         , '10');
    LegalabbEd.Text         := IniFile.ReadString ('Meretezes', 'Margo2'         , '0 ' + UNITS[Egyseg].Code);
    KerekitesCB.Itemindex   := IniFile.ReadInteger('Meretezes', 'Kerekites'      , 1);

    // lap megjelenítése
    LapOnChk.Checked       := IniFile.ReadBool   ('Megjelenites', 'Lap'         ,True);
    LapRajzCB.Itemindex    := IniFile.ReadInteger('Megjelenites', 'Laphogyan'   ,0);
    HosszuChk.Checked      := IniFile.ReadBool   ('Megjelenites', 'Hosszuvonal' ,True);

    // vonalvastagságok
    HaloVasEd.Value      := IniFile.ReadInteger('Megjelenites', 'Fokhalozat'      ,1);
    EgyenlitoVasEd.Value := IniFile.ReadInteger('Megjelenites', 'Egyenlito'       ,2);
    KezdoVasEd.Value     := IniFile.ReadInteger('Megjelenites', 'Kezdomeridian'   ,2);
    TeritoVasEd.Value    := IniFile.ReadInteger('Megjelenites', 'Teritok'         ,1);
    SegedVasEd.Value     := IniFile.ReadInteger('Megjelenites', 'Segedfokhalozat' ,1);
    PartVasEd.Value      := IniFile.ReadInteger('Megjelenites', 'Partok'          ,1);
    HatarVasEd.Value     := IniFile.ReadInteger('Megjelenites', 'Hatarok'         ,1);
    ToVasEd.Value        := IniFile.ReadInteger('Megjelenites', 'Tavak'           ,1);
  end;

  procedure TOptionsForm.OKBtnClick(Sender: TObject);
  begin
    Close;
  end;

  procedure TOptionsForm.MaigazitChkClick(Sender: TObject);
  begin
   NeedSaveIni:=True;
   Vetvalt:=True;

   if not Elso and not MaigazitChk.Checked then
     MainForm.LaphozBtn.Enabled := True;
  end;

  procedure TOptionsForm.LegalabbEdKeyPress(Sender: TObject; var Key: Char);
  begin
    if not (Key in [',','0'..'9',#8]) then Key:=#0;
  end;

  procedure TOptionsForm.LegalabbEdExit(Sender: TObject);
  var
    I : Double;
    NumLength : Integer;
  begin
    if NumberChk(LegalabbEd.Text, NumLength) then begin
      Minmargomi := Convert(Egyseg, 3, StrToFloat(Copy(LegalabbEd.Text, 1, NumLength)));
      if Lx < Ly then
        I := Lx
      else
        I := Ly;

      if Minmargomi >= I / 2 then begin
        LegalabbEd.SetFocus;
        MessageDlg('Túl nagy méret', mtInformation, [mbOK], 0);
      end;
    end else begin
      LegalabbEd.SetFocus;
      InvalidValueMsg;
    end
  end;

  procedure TOptionsForm.SzazalekEdKeyPress(Sender: TObject; var Key: Char);
  begin
    if not (Key in ['0'..'9',#8]) then Key:=#0;
  end;

  procedure TOptionsForm.SzazalekEdExit(Sender: TObject);
  begin
    if (NagyitasVizsgalo(SzazalekEd.Text)) or (SzazalekEd.Text = '0') then begin
      Szazalek := StrToInt(SzazalekEd.Text);
      if Szazalek >= 50 then begin
        SzazalekEd.SetFocus;
        MessageDlg('Túl nagy méret', mtInformation, [mbOK], 0);
      end;
    end else begin
      SzazalekEd.SetFocus;
      MessageDlg('Érvénytelen méret', mtInformation, [mbOK], 0);
    end
  end;

  procedure TOptionsForm.PartfileBtnClick(Sender: TObject);
  begin
    NeedSaveIni := True;
    OpenDialog1.InitialDir := ApplDir;
    if OpenDialog1.Execute then begin
      if ExtractFileDir(OpenDialog1.FileName) = ApplDir then
        Parttxt.Text := ExtractFileName(OpenDialog1.FileName)
      else
        Parttxt.Text := OpenDialog1.FileName;
    end;    
  end;

  procedure TOptionsForm.HatarfileBtnClick(Sender: TObject);
  begin
    NeedSaveIni := True;
    OpenDialog1.InitialDir := ApplDir;
    if OpenDialog1.Execute then
     if ExtractFileDir(OpenDialog1.FileName) = ApplDir
      then Hatartxt.Text:=ExtractFileName(OpenDialog1.FileName)
      else Hatartxt.Text:=OpenDialog1.FileName;
  end;

  procedure TOptionsForm.TofileBtnClick(Sender: TObject);
  begin
    NeedSaveIni := True;
    OpenDialog1.InitialDir := ApplDir;
    if OpenDialog1.Execute then begin
      if ExtractFileDir(OpenDialog1.FileName) = ApplDir then
        Totxt.Text := ExtractFileName(OpenDialog1.FileName)
      else
        Totxt.Text:=OpenDialog1.FileName;
    end;
  end;

  procedure TOptionsForm.AbraigazitChkClick(Sender: TObject);
  begin
    NeedSaveIni := True;
    Vetvalt := True;
    Sajt3 := True;
  end;

  procedure TOptionsForm.AutozoomChkClick(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.KozepigazitChkClick(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.LapOnChkClick(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.HosszuChkClick(Sender: TObject);
  begin
    NeedSaveIni := True
  end;

  procedure TOptionsForm.LapRajzCBChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.HaloVasEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.EgyenlitoVasEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.KezdoVasEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.TeritoVasEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.SegedVasEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.PartVasEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.HatarVasEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.ToVasEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.SzazalekEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.LegalabbEdChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.KerekitesCBChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

end.
