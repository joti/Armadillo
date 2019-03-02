unit Options;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, Spin;

  type
    TOptionsForm = class(TForm)
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
      SzazalekEd: TEdit;
      Szazaleklabel: TLabel;
      Legalabb: TLabel;
      LegalabbEd: TEdit;
      KerekitLabel: TLabel;
      KerekitesCB: TComboBox;
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
      procedure LegalabbEdKeyPress(Sender: TObject; var Key: Char);
      procedure LegalabbEdExit(Sender: TObject);
      procedure SzazalekEdKeyPress(Sender: TObject; var Key: Char);
      procedure SzazalekEdExit(Sender: TObject);
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

  function szamvizsgalo(szam : String) : Boolean;
  var i: Byte;
  begin
    result := True;
    for i := Length(szam) downto 1 do
      if not (szam[i] in ['0'..'9',',']) then
        szamhossz := i - 1;

    if szamhossz = 0 then
      result := False
    else if szamhossz = 1 then
      if szam[1] = ',' then
        result := False;

    if szamhossz > 1 then begin
      if szam[1] = ',' then
        result := False;
      if (szam[1] = '0') and (szam[2] <> ',') then
        result := False;
    end;
  end;

  procedure TOptionsForm.FormCreate(Sender: TObject);
  begin
    // koordinátafájlok
    parttxt.Text  := IniFile.ReadString('Adatbazis', 'Partok', 'part.txt');
    hatartxt.Text := IniFile.ReadString('Adatbazis', 'Hatarok', 'hatar.txt');
    totxt.Text    := IniFile.ReadString('Adatbazis', 'Tavak', 'to.txt');

    // méretezés, igazítás
    Abraigazit.Checked      := IniFile.ReadBool   ('Meretezes', 'Abraigazitas'   , True);
    Maigazit.Checked        := IniFile.ReadBool   ('Meretezes', 'Maigazitas'     , True);
    Autozoom.Checked        := IniFile.ReadBool   ('Meretezes', 'Autozoom'       , True);
    Kozepigazit.Checked     := IniFile.ReadBool   ('Meretezes', 'Kozepreigazitas', True);
    SzazalekEd.Text         := IniFile.ReadString ('Meretezes', 'Margo1'         , '10');
    LegalabbEd.Text         := IniFile.ReadString ('Meretezes', 'Margo2'         , '0 ' + SI[Egyseg]);
    KerekitesCB.Itemindex   := IniFile.ReadInteger('Meretezes', 'Kerekites'      , 1);

    // lap megjelenítése
    LapOn.Checked       := IniFile.ReadBool   ('Megjelenites', 'Lap'         ,True);
    Lapmilyen.Itemindex := IniFile.ReadInteger('Megjelenites', 'Laphogyan'   ,0);
    HosszuChk.Checked   := IniFile.ReadBool   ('Megjelenites', 'Hosszuvonal' ,True);

    // vonalvastagságok
    Vas1.Value := IniFile.ReadInteger('Megjelenites', 'Fokhalozat'      ,1);
    Vas2.Value := IniFile.ReadInteger('Megjelenites', 'Egyenlito'       ,2);
    Vas3.Value := IniFile.ReadInteger('Megjelenites', 'Kezdomeridian'   ,2);
    Vas4.Value := IniFile.ReadInteger('Megjelenites', 'Teritok'         ,1);
    Vas5.Value := IniFile.ReadInteger('Megjelenites', 'Segedfokhalozat' ,1);
    Vas6.Value := IniFile.ReadInteger('Megjelenites', 'Partok'          ,1);
    Vas7.Value := IniFile.ReadInteger('Megjelenites', 'Hatarok'         ,1);
    Vas8.Value := IniFile.ReadInteger('Megjelenites', 'Tavak'           ,1);
  end;

  procedure TOptionsForm.OKBtnClick(Sender: TObject);
  begin
    Close;
  end;

  procedure TOptionsForm.MaigazitClick(Sender: TObject);
  begin
   NeedSaveIni:=True;
   Vetvalt:=True;

   if not Elso and not Maigazit.Checked then
     MainForm.LaphozBtn.Enabled := True;
  end;

  procedure TOptionsForm.LegalabbEdKeyPress(Sender: TObject; var Key: Char);
  begin
    if not (Key in [',','0'..'9',#8]) then Key:=#0;
  end;

  procedure TOptionsForm.LegalabbEdExit(Sender: TObject);
  var i:Double;
  begin
    if Szamvizsgalo(LegalabbEd.Text) then begin
      Minmargomi := Convert(Egyseg, 3, StrToFloat(Copy(LegalabbEd.Text, 1, szamhossz)));
      if Lx < Ly then
        i := Lx
      else
        i := Ly;
      if Minmargomi >= i/2 then begin
        LegalabbEd.SetFocus;
        MessageDlg('Túl nagy méret',mtInformation,[mbOK],0);
      end;
    end else begin
      LegalabbEd.SetFocus;
      MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
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

  procedure TOptionsForm.AbraigazitClick(Sender: TObject);
  begin
    NeedSaveIni := True;
    Vetvalt := True;
    Sajt3 := True;
  end;

  procedure TOptionsForm.AutozoomClick(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.KozepigazitClick(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.LapOnClick(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.HosszuChkClick(Sender: TObject);
  begin
    NeedSaveIni := True
  end;

  procedure TOptionsForm.LapmilyenChange(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.Vas1Change(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.Vas2Change(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.Vas3Change(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.Vas4Change(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.Vas5Change(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.Vas6Change(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.Vas7Change(Sender: TObject);
  begin
    NeedSaveIni := True;
  end;

  procedure TOptionsForm.Vas8Change(Sender: TObject);
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
