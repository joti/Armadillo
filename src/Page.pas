unit Page;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, Buttons, Spin;

type
  TPageForm = class(TForm)
    PapirCombobox: TComboBox;
    PapirmeretLabel: TLabel;
    PapirszelesLabel: TLabel;
    PapirmagasLabel: TLabel;
    PapirszelesEdit: TEdit;
    PapirmagasEdit: TEdit;
    PapirOKbtn: TButton;
    PapirCancelbtn: TButton;
    TajolGroupBox: TGroupBox;
    LapImage1: TImage;
    AlloBtn: TRadioButton;
    FekvoBtn: TRadioButton;
    LapImage2: TImage;
    SpinButton1: TSpinButton;
    SpinButton2: TSpinButton;
    procedure FekvoBtnClick(Sender: TObject);
    procedure AlloBtnClick(Sender: TObject);
    procedure PapirComboboxChange(Sender: TObject);
    procedure PapirszelesEditExit(Sender: TObject);
    procedure PapirmagasEditExit(Sender: TObject);
    procedure PapirszelesEditKeyPress(Sender: TObject; var Key: Char);
    procedure PapirmagasEditKeyPress(Sender: TObject; var Key: Char);
    procedure PapirOKbtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PapirCancelbtnClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PageForm: TPageForm;
  szamhossz: Byte=1;
  TartIndex:Byte;
  Eta: Byte=0;
  TartSzeles,TartMagas:String;
  TartAllo: Boolean;
  Max: Integer;
  Uzenet: String;
  function szamvizsgal(szam:String):Boolean;

implementation

uses Main;

{$R *.DFM}

function Atszamit(me1,me2:Byte;ertek:Double):Double;
begin
  result:=0;
  case me1 of
  0: result:=ertek/25.39;
  1: result:=ertek/2.539;
  2: result:=ertek;
  3: result:=ertek/1000;
  end;
  case me2 of
  0: result:=result*25.39;
  1: result:=result*2.539;
  3: result:=result*1000;
  end;
end;

function szamvizsgal(szam:String):Boolean;
var i: Byte;
begin
 if Length(szam)=0 then szamvizsgal:=False else
 if  not (szam[1] in ['0'..'9']) then szamvizsgal:=False
 else begin
        if (szam[1]='0') and (szam[2]<>',') then szamvizsgal:=False;
        for i:=Length(szam) downto 1 do
          if not (szam[i] in ['0'..'9',',']) then szamhossz:=i-1
        else
         begin
          szamvizsgal:=True;
         end;
      end;
end;

procedure TPageForm.FekvoBtnClick(Sender: TObject);
begin
  AlloBtn.Checked:=False;
  LapImage1.Visible:=False;
  LapImage2.Visible:=True;
  PapirszelesEdit.Top:=53;
  PapirmagasEdit.Top:=77;
  SpinButton1.Top:=53;
  SpinButton2.Top:=77;
end;

procedure TPageForm.AlloBtnClick(Sender: TObject);
begin
  Valt:=True;
  FekvoBtn.Checked:=False;
  LapImage2.Visible:=False;
  LapImage1.Visible:=True;
  PapirszelesEdit.Top:=77;
  PapirmagasEdit.Top:=53;
  SpinButton1.Top:=77;
  SpinButton2.Top:=53;
end;

procedure TPageForm.PapirComboboxChange(Sender: TObject);
begin
  Valt:=True;
  if PapirCombobox.Itemindex<>6 then
    begin
      Lx:=Lapx[PapirCombobox.Itemindex,3];
      Ly:=Lapy[PapirCombobox.Itemindex,3];
      PapirszelesEdit.Text:=Format('%-g ',[Lapx[PapirCombobox.Itemindex,Eta]])+SI[Eta];
      PapirmagasEdit.Text:=Format('%-g ',[Lapy[PapirCombobox.Itemindex,Eta]])+SI[Eta];
    end;
end;

procedure TPageForm.PapirszelesEditExit(Sender: TObject);
begin
if Szamvizsgal(PapirmagasEdit.Text) then
  Lapy[6,Eta]:=StrToFloat(Copy(PapirmagasEdit.Text,1,szamhossz));
if Szamvizsgal(PapirszelesEdit.Text)=True then
       begin
         Lapx[6,Eta]:=StrToFloat(Copy(PapirszelesEdit.Text,1,szamhossz));
         if Int(Lapx[6,Eta])<Max then
           begin
            PapirCombobox.Itemindex:=6;
            if Lapx[6,Eta]<Lapy[6,Eta] then begin
                            Allobtn.Checked:=True;
                            Fekvobtn.Checked:=False;
                            LapImage2.Visible:=False;
                            LapImage1.Visible:=True;
                          end
                     else begin
                            Allobtn.Checked:=False;
                            Fekvobtn.Checked:=True;
                            LapImage2.Visible:=True;
                            LapImage1.Visible:=False;
                          end;
           end
         else
           begin
             PapirszelesEdit.Setfocus;
             MessageDlg(Format('A méretnek %d %s alatt kell lennie',
              [Max,MainForm.Egyseg.Items[Eta]]),
              mtInformation,[mbOK],0);
           end;
       end
   else
       begin
         PapirszelesEdit.SetFocus;
         MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
       end
end;

procedure TPageForm.PapirmagasEditExit(Sender: TObject);
begin
if Szamvizsgal(PapirszelesEdit.Text) then
  Lapx[6,Eta]:=StrToFloat(Copy(PapirszelesEdit.Text,1,szamhossz));
if Szamvizsgal(PapirmagasEdit.Text)=True then
       begin
         Lapy[6,Eta]:=StrToFloat(Copy(PapirmagasEdit.Text,1,szamhossz));
         if Int(Lapy[6,Eta])<Max then
           begin
            PapirCombobox.Itemindex:=6;
            if Lapx[6,Eta]<Lapy[6,Eta] then begin
                            Allobtn.Checked:=True;
                            Fekvobtn.Checked:=False;
                            LapImage2.Visible:=False;
                            LapImage1.Visible:=True;
                          end
                     else begin
                            Allobtn.Checked:=False;
                            Fekvobtn.Checked:=True;
                            LapImage2.Visible:=True;
                            LapImage1.Visible:=False;
                          end;
           end
         else
           begin
             PapirmagasEdit.Setfocus;
             MessageDlg(Format('A méretnek %d %s alatt kell lennie',
              [Max,MainForm.Egyseg.Items[Eta]]),
              mtInformation,[mbOK],0);
           end;
       end
   else
       begin
         PapirmagasEdit.SetFocus;
         MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
       end;
end;

procedure TPageForm.PapirszelesEditKeyPress(Sender: TObject; var Key: Char);
begin
if Szamvizsgal(PapirmagasEdit.Text) then
  Lapy[6,Eta]:=StrToFloat(Copy(PapirmagasEdit.Text,1,szamhossz));
if Key=#13 then if Szamvizsgal(PapirszelesEdit.Text)=True then
       begin
         Lapx[6,Eta]:=StrToFloat(Copy(PapirszelesEdit.Text,1,szamhossz));
         if Int(Lapx[6,Eta])<Max then
           begin
            PapirCombobox.Itemindex:=6;
            if Lapx[6,Eta]<Lapy[6,Eta] then begin
                            Allobtn.Checked:=True;
                            Fekvobtn.Checked:=False;
                            LapImage2.Visible:=False;
                            LapImage1.Visible:=True;
                          end
                     else begin
                            Allobtn.Checked:=False;
                            Fekvobtn.Checked:=True;
                            LapImage2.Visible:=True;
                            LapImage1.Visible:=False;
                          end;
            Close;
           end
         else
           begin
             PapirszelesEdit.Setfocus;
             MessageDlg(Format('A méretnek %d %s alatt kell lennie',
              [Max,MainForm.Egyseg.Items[Eta]]),
              mtInformation,[mbOK],0);
           end;
       end
   else
       begin
         PapirszelesEdit.SetFocus;
         MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
       end
else if not (Key in ['0'..'9',',',#8]) then Key:=#0;
end;

procedure TPageForm.PapirmagasEditKeyPress(Sender: TObject; var Key: Char);
begin
if Szamvizsgal(PapirszelesEdit.Text) then
  Lapx[6,Eta]:=StrToFloat(Copy(PapirszelesEdit.Text,1,szamhossz));
if Key=#13 then if Szamvizsgal(PapirmagasEdit.Text)=True then
         begin
          Lapy[6,Eta]:=StrToFloat(Copy(PapirmagasEdit.Text,1,szamhossz));
          if Int(Lapy[6,Eta])<Max then
           begin
             PapirCombobox.Itemindex:=6;
             if Lapx[6,Eta]<Lapy[6,Eta] then begin
                            Allobtn.Checked:=True;
                            Fekvobtn.Checked:=False;
                            LapImage2.Visible:=False;
                            LapImage1.Visible:=True;
                           end
                      else begin
                            Allobtn.Checked:=False;
                            Fekvobtn.Checked:=True;
                            LapImage2.Visible:=True;
                            LapImage1.Visible:=False;
                           end;
             Close;
           end
          else
           begin
             PapirmagasEdit.Setfocus;
             MessageDlg(Format('A méretnek %d %s alatt kell lennie',
              [Max,MainForm.Egyseg.Items[Eta]]),
              mtInformation,[mbOK],0);
           end;
         end
    else
      begin
        PapirmagasEdit.SetFocus;
        MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
      end
else if not (Key in ['0'..'9',',',#8]) then Key:=#0;
end;

procedure TPageForm.PapirOKbtnClick(Sender: TObject);
begin
  Close;
end;

procedure TPageForm.FormShow(Sender: TObject);
begin
  TartIndex:=PapirCombobox.Itemindex;
  TartAllo:=Allobtn.Checked;
  TartSzeles:=PapirszelesEdit.Text;
  TartMagas:=PapirmagasEdit.Text;
  case Eta of
    0:Max:=1500;
    1:Max:=150;
    2:Max:=60;
    3:Max:=60000;
  end;
end;

procedure TPageForm.PapirCancelbtnClick(Sender: TObject);
begin
  PapirCombobox.Itemindex:=Tartindex;
  if TartAllo=True then
    begin
     Allobtn.Checked:=True;
     Fekvobtn.Checked:=False;
     LapImage2.Visible:=False;
     LapImage1.Visible:=True;
    end
  else
    begin
     Fekvobtn.Checked:=True;
     AlloBtn.Checked:=False;
     LapImage1.Visible:=False;
     LapImage2.Visible:=True;
    end;
  PapirszelesEdit.Text:=TartSzeles;
  PapirmagasEdit.Text:=TartMagas;
end;

procedure TPageForm.SpinButton1UpClick(Sender: TObject);
begin
  if Szamvizsgal(PapirmagasEdit.Text) then
    Lapy[6,Eta]:=StrToFloat(Copy(PapirmagasEdit.Text,1,szamhossz));
  if Szamvizsgal(PapirszelesEdit.Text)=True then
         begin
          Lapx[6,Eta]:=StrToFloat(Copy(PapirszelesEdit.Text,1,szamhossz));
          if Lapx[6,Eta]+1<Max then
            begin
             Lapx[6,Eta]:=Lapx[6,Eta]+1;
             PapirCombobox.Itemindex:=3;
             PapirszelesEdit.Text:=Format('%-2.4g ',[Lapx[6,Eta]])+SI[Eta];
            end;
         end;
end;

procedure TPageForm.SpinButton1DownClick(Sender: TObject);
begin
  if Szamvizsgal(PapirmagasEdit.Text) then
    Lapy[6,Eta]:=StrToFloat(Copy(PapirmagasEdit.Text,1,szamhossz));
  if Szamvizsgal(PapirszelesEdit.Text)=True then
         begin
          Lapx[6,Eta]:=StrToFloat(Copy(PapirszelesEdit.Text,1,szamhossz));
          if Lapx[6,Eta]-1>0 then
            begin
             Lapx[6,Eta]:=Lapx[6,Eta]-1;
             PapirCombobox.Itemindex:=3;
             PapirszelesEdit.Text:=Format('%-2.4g ',[Lapx[6,Eta]])+SI[Eta];
            end;
         end;
end;

procedure TPageForm.SpinButton2UpClick(Sender: TObject);
begin
  if Szamvizsgal(PapirszelesEdit.Text) then
    Lapx[6,Eta]:=StrToFloat(Copy(PapirszelesEdit.Text,1,szamhossz));
  if Szamvizsgal(PapirmagasEdit.Text)=True then
         begin
          Lapy[6,Eta]:=StrToFloat(Copy(PapirmagasEdit.Text,1,szamhossz));
          if Lapy[6,Eta]+1<Max then
            begin
             Lapy[6,Eta]:=Lapy[6,Eta]+1;
             PapirCombobox.Itemindex:=3;
             PapirmagasEdit.Text:=Format('%-2.4g ',[Lapy[6,Eta]])+SI[Eta];
            end;
         end;
end;

procedure TPageForm.SpinButton2DownClick(Sender: TObject);
begin
  if Szamvizsgal(PapirszelesEdit.Text) then
    Lapx[6,Eta]:=StrToFloat(Copy(PapirszelesEdit.Text,1,szamhossz));
  if Szamvizsgal(PapirmagasEdit.Text)=True then
         begin
          Lapy[6,Eta]:=StrToFloat(Copy(PapirmagasEdit.Text,1,szamhossz));
          if Lapy[6,Eta]-1>0 then
            begin
             Lapy[6,Eta]:=Lapy[6,Eta]-1;
             PapirCombobox.Itemindex:=3;
             PapirmagasEdit.Text:=Format('%-2.4g ',[Lapy[6,Eta]])+SI[Eta];
            end;
         end;
end;

procedure TPageForm.FormClose(Sender: TObject; var Action: TCloseAction);
var i:Byte;
begin
  i:=PapirCombobox.Itemindex;
  if i=6 then
    begin
      Lapx[6,0]:=Atszamit(Eta,0,Lapx[6,Eta]);
      Lapx[6,1]:=Atszamit(Eta,1,Lapx[6,Eta]);
      Lapx[6,2]:=Atszamit(Eta,2,Lapx[6,Eta]);
      Lapx[6,3]:=Atszamit(Eta,3,Lapx[6,Eta]);
      Lapy[6,0]:=Atszamit(Eta,0,Lapy[6,Eta]);
      Lapy[6,1]:=Atszamit(Eta,1,Lapy[6,Eta]);
      Lapy[6,2]:=Atszamit(Eta,2,Lapy[6,Eta]);
      Lapy[6,3]:=Atszamit(Eta,3,Lapy[6,Eta]);
    end;
  if Allobtn.Checked then
     begin
          MainForm.Lapszeles.Text:=Format('%-2.6g ',[Lapy[i,Eta]]);
          MainForm.Lapmagas.Text:=Format('%-2.6g ',[Lapx[i,Eta]]);
          Lx:=Lapy[i,3];
          Ly:=Lapx[i,3];
     end
  else
     begin
          MainForm.Lapszeles.Text:=Format('%-2.6g ',[Lapx[i,Eta]]);
          MainForm.Lapmagas.Text:=Format('%-2.6g ',[Lapy[i,Eta]]);
          Lx:=Lapx[i,3];
          Ly:=Lapy[i,3];
     end;
end;

procedure TPageForm.FormCreate(Sender: TObject);
var i: Byte;
begin
  PapirComboBox.Itemindex:=Inifile.ReadInteger('Papir','Meret',3);
  i:=PapirCombobox.Itemindex;
  AlloBtn.Checked:=IniFile.ReadBool('Papir','Tajolas',False);
  if Allobtn.Checked then
     begin
          MainForm.Lapszeles.Text:=Format('%-2.6g ',[Lapy[i,Eta]]);
          MainForm.Lapmagas.Text:=Format('%-2.6g ',[Lapx[i,Eta]]);
          Lx:=Lapy[i,3];
          Ly:=Lapx[i,3];
     end
  else
     begin
          MainForm.Lapszeles.Text:=Format('%-2.6g ',[Lapx[i,Eta]]);
          MainForm.Lapmagas.Text:=Format('%-2.6g ',[Lapy[i,Eta]]);
          Lx:=Lapx[i,3];
          Ly:=Lapy[i,3];
     end;
end;

end.
