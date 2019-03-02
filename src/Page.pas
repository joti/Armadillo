unit Page;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, StdCtrls, ComCtrls, Buttons, Spin, General;

  type
    TPageForm = class(TForm)
      PapirCB: TComboBox;
      PapirmeretLabel: TLabel;
      PapirszelesLabel: TLabel;
      PapirmagasLabel: TLabel;
      PapirszelesEd: TEdit;
      PapirmagasEd: TEdit;
      PapirOKBtn: TButton;
      PapirCancelBtn: TButton;
      TajolGroupBox: TGroupBox;
      LapImage1: TImage;
      AlloBtn: TRadioButton;
      FekvoBtn: TRadioButton;
      LapImage2: TImage;
      PapirszelesSpin: TSpinButton;
      PapirMagasSpin: TSpinButton;
      procedure FekvoBtnClick(Sender: TObject);
      procedure AlloBtnClick(Sender: TObject);
      procedure PapirCBChange(Sender: TObject);
      procedure PapirszelesEdExit(Sender: TObject);
      procedure PapirmagasEdExit(Sender: TObject);
      procedure PapirszelesEdKeyPress(Sender: TObject; var Key: Char);
      procedure PapirmagasEdKeyPress(Sender: TObject; var Key: Char);
      procedure PapirOKBtnClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure PapirCancelBtnClick(Sender: TObject);
      procedure PapirszelesSpinUpClick(Sender: TObject);
      procedure PapirszelesSpinDownClick(Sender: TObject);
      procedure PapirMagasSpinUpClick(Sender: TObject);
      procedure PapirMagasSpinDownClick(Sender: TObject);
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
    Max: Integer;

implementation

  uses Main;

  var
    TartSzeles, TartMagas : String;
    TartIndex : Byte;
    TartAllo : Boolean;

  {$R *.DFM}

  procedure TPageForm.FekvoBtnClick(Sender: TObject);
  begin
    AlloBtn.Checked := False;
    LapImage1.Visible := False;
    LapImage2.Visible := True;
    PapirszelesEd.Top := 53;
    PapirmagasEd.Top := 77;
    PapirszelesSpin.Top := 53;
    PapirmagasSpin.Top := 77;
  end;

  procedure TPageForm.AlloBtnClick(Sender: TObject);
  begin
    NeedSaveIni := True;
    FekvoBtn.Checked := False;
    LapImage2.Visible := False;
    LapImage1.Visible := True;
    PapirszelesEd.Top := 77;
    PapirmagasEd.Top := 53;
    PapirszelesSpin.Top := 77;
    PapirmagasSpin.Top := 53;
  end;

  procedure TPageForm.PapirCBChange(Sender: TObject);
  begin
    NeedSaveIni:=True;
    if PapirCB.ItemIndex <> 6 then begin
      Lx := Lapx[PapirCB.ItemIndex, 3];
      Ly := Lapy[PapirCB.ItemIndex, 3];
      PapirszelesEd.Text := Format('%-g ', [Lapx[PapirCB.ItemIndex, Egyseg]]) + UNITS[Egyseg].Code;
      PapirmagasEd.Text := Format('%-g ', [Lapy[PapirCB.ItemIndex, Egyseg]]) + UNITS[Egyseg].Code;
    end;
  end;

  procedure TPageForm.PapirszelesEdExit(Sender: TObject);
  var
    NumLength : Integer;
  begin
    if NumberChk(PapirmagasEd.Text, NumLength) then
      Lapy[6, Egyseg] := StrToFloat(Copy(PapirmagasEd.Text, 1, NumLength));
    if NumberChk(PapirszelesEd.Text, NumLength) then begin
      Lapx[6, Egyseg] := StrToFloat(Copy(PapirszelesEd.Text, 1, NumLength));
      if Int(Lapx[6, Egyseg]) < Max then begin
        PapirCB.ItemIndex := 6;
        if Lapx[6, Egyseg] < Lapy[6, Egyseg] then begin
          AlloBtn.Checked := True;
          FekvoBtn.Checked := False;
          LapImage2.Visible := False;
          LapImage1.Visible := True;
        end else begin
          AlloBtn.Checked := False;
          FekvoBtn.Checked := True;
          LapImage2.Visible := True;
          LapImage1.Visible := False;
        end;
      end else begin
        PapirszelesEd.SetFocus;
        MessageDlg(Format('A méretnek %d %s alatt kell lennie', [Max, MainForm.EgysegCB.Items[Egyseg]]), mtInformation,[mbOK],0);
      end;
    end else begin
      PapirszelesEd.SetFocus;
      InvalidValueMsg;
    end
  end;

  procedure TPageForm.PapirmagasEdExit(Sender: TObject);
  var
    NumLength : Integer;
  begin
    if NumberChk(PapirszelesEd.Text, NumLength) then
      Lapx[6, Egyseg] := StrToFloat(Copy(PapirszelesEd.Text, 1, NumLength));
    if NumberChk(PapirmagasEd.Text, NumLength) then begin
      Lapy[6,Egyseg] := StrToFloat(Copy(PapirmagasEd.Text, 1, NumLength));
      if Int(Lapy[6, Egyseg]) < Max then begin
        PapirCB.ItemIndex := 6;
        if Lapx[6, Egyseg] < Lapy[6, Egyseg] then begin
          AlloBtn.Checked := True;
          FekvoBtn.Checked := False;
          LapImage2.Visible := False;
          LapImage1.Visible := True;
        end else begin
          AlloBtn.Checked := False;
          FekvoBtn.Checked := True;
          LapImage2.Visible := True;
          LapImage1.Visible := False;
        end;
      end else begin
        PapirmagasEd.Setfocus;
        MessageDlg(Format('A méretnek %d %s alatt kell lennie', [Max, MainForm.EgysegCB.Items[Egyseg]]), mtInformation, [mbOK], 0);
      end;
    end else begin
      PapirmagasEd.SetFocus;
      InvalidValueMsg;
    end;
  end;

  procedure TPageForm.PapirszelesEdKeyPress(Sender: TObject; var Key: Char);
  var
    NumLength : Integer;
  begin
    if NumberChk(PapirmagasEd.Text, NumLength) then
      Lapy[6,Egyseg] := StrToFloat(Copy(PapirmagasEd.Text, 1, NumLength));

    if Key = #13 then begin // ENTER
      if NumberChk(PapirszelesEd.Text, NumLength) then begin
        Lapx[6,Egyseg] := StrToFloat(Copy(PapirszelesEd.Text, 1, NumLength));
        if Int(Lapx[6,Egyseg]) < Max then begin
          PapirCB.ItemIndex := 6;
          if Lapx[6,Egyseg] < Lapy[6,Egyseg] then begin
            AlloBtn.Checked := True;
            FekvoBtn.Checked := False;
            LapImage2.Visible := False;
            LapImage1.Visible := True;
          end else begin
            AlloBtn.Checked := False;
            FekvoBtn.Checked := True;
            LapImage2.Visible := True;
            LapImage1.Visible := False;
          end;
          Close;
        end else begin
          PapirszelesEd.SetFocus;
          MessageDlg(Format('A méretnek %d %s alatt kell lennie', [Max, MainForm.EgysegCB.Items[Egyseg]]), mtInformation, [mbOK], 0);
        end;
      end else begin
        PapirszelesEd.SetFocus;
        MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
      end
    end else if not (Key in ['0'..'9',',','.',#8]) then
      Key := #0;
  end;

  procedure TPageForm.PapirmagasEdKeyPress(Sender: TObject; var Key: Char);
  var
    NumLength : Integer;
  begin
    if NumberChk(PapirszelesEd.Text, NumLength) then
      Lapx[6, Egyseg] := StrToFloat(Copy(PapirszelesEd.Text, 1, NumLength));

    if Key = #13 then begin // ENTER leütése
      if NumberChk(PapirmagasEd.Text, NumLength) then begin
        Lapy[6, Egyseg] := StrToFloat(Copy(PapirmagasEd.Text, 1, NumLength));
        if Int(Lapy[6, Egyseg]) < Max then begin
          PapirCB.ItemIndex := 6;
          if Lapx[6, Egyseg] < Lapy[6, Egyseg] then begin
            AlloBtn.Checked := True;
            FekvoBtn.Checked := False;
            LapImage2.Visible := False;
            LapImage1.Visible := True;
          end else begin
            AlloBtn.Checked := False;
            FekvoBtn.Checked := True;
            LapImage2.Visible := True;
            LapImage1.Visible := False;
          end;
          Close;
        end else begin
          PapirmagasEd.SetFocus;
          MessageDlg(Format('A méretnek %d %s alatt kell lennie', [Max,MainForm.EgysegCB.Items[Egyseg]]), mtInformation, [mbOK], 0);
        end;
      end else begin
        PapirmagasEd.SetFocus;
        MessageDlg('Érvénytelen méret', mtInformation, [mbOK], 0);
      end
    end else if not (Key in ['0'..'9',',','.',#8]) then
      Key:=#0;
  end;

  procedure TPageForm.PapirOKBtnClick(Sender: TObject);
  begin
    Close;
  end;

  procedure TPageForm.FormShow(Sender: TObject);
  begin
    TartIndex := PapirCB.ItemIndex;
    TartAllo := AlloBtn.Checked;
    TartSzeles := PapirszelesEd.Text;
    TartMagas := PapirmagasEd.Text;
    case Egyseg of
      0 : Max := 1500;
      1 : Max := 150;
      2 : Max := 60;
      3 : Max := 60000;
    end;
  end;

  procedure TPageForm.PapirCancelBtnClick(Sender: TObject);
  begin
    PapirCB.ItemIndex := Tartindex;
    if TartAllo then begin
      AlloBtn.Checked := True;
      FekvoBtn.Checked := False;
      LapImage2.Visible := False;
      LapImage1.Visible := True;
    end else begin
      FekvoBtn.Checked := True;
      AlloBtn.Checked := False;
      LapImage1.Visible := False;
      LapImage2.Visible := True;
    end;
    PapirszelesEd.Text := TartSzeles;
    PapirmagasEd.Text := TartMagas;
  end;

  procedure TPageForm.PapirszelesSpinUpClick(Sender: TObject);
  var
    NumLength : Integer;
  begin
    if NumberChk(PapirmagasEd.Text, NumLength) then
      Lapy[6, Egyseg] := StrToFloat(Copy(PapirmagasEd.Text, 1, NumLength));
    if NumberChk(PapirszelesEd.Text, NumLength) then begin
      Lapx[6, Egyseg] := StrToFloat(Copy(PapirszelesEd.Text, 1, NumLength));
      if Lapx[6, Egyseg] + 1 < Max then begin
        Lapx[6, Egyseg] := Lapx[6, Egyseg] + 1;
        PapirCB.ItemIndex := 3;
        PapirszelesEd.Text := Format('%-2.4g ', [Lapx[6, Egyseg]]) + UNITS[Egyseg].Code;
      end;
    end;
  end;

  procedure TPageForm.PapirszelesSpinDownClick(Sender: TObject);
  var
    NumLength : Integer;
  begin
    if NumberChk(PapirmagasEd.Text, NumLength) then
      Lapy[6, Egyseg]:=StrToFloat(Copy(PapirmagasEd.Text, 1, NumLength));
    if NumberChk(PapirszelesEd.Text, NumLength) then begin
      Lapx[6, Egyseg]:=StrToFloat(Copy(PapirszelesEd.Text, 1, NumLength));
      if Lapx[6, Egyseg] - 1 > 0 then begin
        Lapx[6, Egyseg] := Lapx[6,Egyseg]-1;
        PapirCB.ItemIndex := 3;
        PapirszelesEd.Text := Format('%-2.4g ', [Lapx[6, Egyseg]]) + UNITS[Egyseg].Code;
      end;
    end;
  end;

  procedure TPageForm.PapirMagasSpinUpClick(Sender: TObject);
  var
    NumLength : Integer;
  begin
    if NumberChk(PapirszelesEd.Text, NumLength) then
      Lapx[6, Egyseg] := StrToFloat(Copy(PapirszelesEd.Text, 1, NumLength));
    if NumberChk(PapirmagasEd.Text, NumLength) then begin
      Lapy[6, Egyseg] := StrToFloat(Copy(PapirmagasEd.Text, 1, NumLength));
      if Lapy[6, Egyseg] + 1 < Max then begin
        Lapy[6, Egyseg] := Lapy[6, Egyseg] + 1;
        PapirCB.ItemIndex := 3;
        PapirmagasEd.Text := Format('%-2.4g ', [Lapy[6, Egyseg]]) + UNITS[Egyseg].Code;
      end;
    end;
  end;

  procedure TPageForm.PapirMagasSpinDownClick(Sender: TObject);
  var
    NumLength : Integer;
  begin
    if NumberChk(PapirszelesEd.Text, NumLength) then
      Lapx[6, Egyseg] := StrToFloat(Copy(PapirszelesEd.Text, 1, NumLength));
    if NumberChk(PapirmagasEd.Text, NumLength) then begin
      Lapy[6, Egyseg] := StrToFloat(Copy(PapirmagasEd.Text, 1, NumLength));
      if Lapy[6, Egyseg] - 1 > 0 then begin
        Lapy[6, Egyseg] := Lapy[6, Egyseg] - 1;
        PapirCB.ItemIndex := 3;
        PapirmagasEd.Text := Format('%-2.4g ', [Lapy[6, Egyseg]]) + UNITS[Egyseg].Code;
      end;
    end;
  end;

  procedure TPageForm.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
    if PapirCB.ItemIndex = 6 then begin // Egyéni méret
      Lapx[6,0] := Convert(Egyseg, 0, Lapx[6,Egyseg]);
      Lapx[6,1] := Convert(Egyseg, 1, Lapx[6,Egyseg]);
      Lapx[6,2] := Convert(Egyseg, 2, Lapx[6,Egyseg]);
      Lapx[6,3] := Convert(Egyseg, 3, Lapx[6,Egyseg]);

      Lapy[6,0] := Convert(Egyseg, 0, Lapy[6,Egyseg]);
      Lapy[6,1] := Convert(Egyseg, 1, Lapy[6,Egyseg]);
      Lapy[6,2] := Convert(Egyseg, 2, Lapy[6,Egyseg]);
      Lapy[6,3] := Convert(Egyseg, 3, Lapy[6,Egyseg]);
    end;

    if AlloBtn.Checked then begin
      MainForm.Lapszeles.Text := Format('%-2.6g ', [Lapy[PapirCB.ItemIndex, Egyseg]]);
      MainForm.Lapmagas.Text  := Format('%-2.6g ', [Lapx[PapirCB.ItemIndex, Egyseg]]);
      Lx := Lapy[PapirCB.ItemIndex, 3];
      Ly := Lapx[PapirCB.ItemIndex, 3];
    end else begin
      MainForm.Lapszeles.Text := Format('%-2.6g ', [Lapx[PapirCB.ItemIndex, Egyseg]]);
      MainForm.Lapmagas.Text  := Format('%-2.6g ', [Lapy[PapirCB.ItemIndex, Egyseg]]);
      Lx := Lapx[PapirCB.ItemIndex, 3];
      Ly := Lapy[PapirCB.ItemIndex, 3];
    end;
  end;

  procedure TPageForm.FormCreate(Sender: TObject);
  begin
    PapirCB.ItemIndex := Inifile.ReadInteger('Papir', 'Meret', 3);
    AlloBtn.Checked := IniFile.ReadBool('Papir', 'Tajolas', False);

    if AlloBtn.Checked then begin
      MainForm.Lapszeles.Text := Format('%-2.6g ',[Lapy[PapirCB.ItemIndex, Egyseg]]);
      MainForm.Lapmagas.Text := Format('%-2.6g ',[Lapx[PapirCB.ItemIndex, Egyseg]]);
      Lx := Lapy[PapirCB.ItemIndex, 3];
      Ly := Lapx[PapirCB.ItemIndex, 3];
    end else begin
      MainForm.Lapszeles.Text := Format('%-2.6g ', [Lapx[PapirCB.ItemIndex, Egyseg]]);
      MainForm.Lapmagas.Text := Format('%-2.6g ', [Lapy[PapirCB.ItemIndex, Egyseg]]);
      Lx := Lapx[PapirCB.ItemIndex, 3];
      Ly := Lapy[PapirCB.ItemIndex, 3];
    end;
  end;

end.
