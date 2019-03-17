unit Page;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, StdCtrls, ComCtrls, Buttons, Spin, General;

  type
    TPageForm = class(TForm)
      PapirCB: TComboBox;
      PapirMeretLabel: TLabel;
      PapirSzelesLabel: TLabel;
      PapirMagasLabel: TLabel;
      PapirSzelesEd: TEdit;
      PapirMagasEd: TEdit;
      PapirOKBtn: TButton;
      PapirCancelBtn: TButton;
      TajolGroupBox: TGroupBox;
      LapImage1: TImage;
      AlloBtn: TRadioButton;
      FekvoBtn: TRadioButton;
      LapImage2: TImage;
      PapirSzelesSpin: TSpinButton;
      PapirMagasSpin: TSpinButton;
      procedure FekvoBtnClick(Sender: TObject);
      procedure AlloBtnClick(Sender: TObject);
      procedure PapirCBChange(Sender: TObject);
      procedure PapirSzelesEdExit(Sender: TObject);
      procedure PapirMagasEdExit(Sender: TObject);
      procedure PapirSzelesEdKeyPress(Sender: TObject; var Key: Char);
      procedure PapirMagasEdKeyPress(Sender: TObject; var Key: Char);
      procedure PapirOKBtnClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure PapirCancelBtnClick(Sender: TObject);
      procedure PapirSzelesSpinUpClick(Sender: TObject);
      procedure PapirSzelesSpinDownClick(Sender: TObject);
      procedure PapirMagasSpinUpClick(Sender: TObject);
      procedure PapirMagasSpinDownClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
    private
      { Private declarations }
      procedure SetOrientation();
      procedure RefreshText();
    public
      { Public declarations }
    end;

  var
    PageForm: TPageForm;
    Max: Integer;

implementation

  uses Main;

  var
    TartSzeles, TartMagas : String;
    TartIndex : Byte;
    TartAllo : Boolean;
    LastIndex : Byte;
    CustomSize : TDoublePoint; // Egyéni lapméret, X >= Y

  {$R *.DFM}

  procedure TPageForm.SetOrientation();
  var
    Portrait : Boolean;
    NeedSet : Boolean;
    D : Double;
  begin
    NeedSet := False;
    if PapirCB.ItemIndex = LastIndex then begin
      if (AlloBtn.Checked) and (CustomSize.X < CustomSize.Y) then begin
        // Ha X fölé nõtt Y, akkor fekvõ tájolásra állunk
        D := CustomSize.X;
        CustomSize.X := CustomSize.Y;
        CustomSize.Y := D;
        NeedSet := True;
        Portrait := False;
      end else if (FekvoBtn.Checked) and (CustomSize.X < CustomSize.Y) then begin
        // Ha X fölé nõtt Y, akkor álló tájolásra állunk
        D := CustomSize.X;
        CustomSize.X := CustomSize.Y;
        CustomSize.Y := D;
        NeedSet := True;
        Portrait := True;
      end;

      if NeedSet then begin
        if Portrait then begin
          FekvoBtn.TabStop := False;
          AlloBtn.Checked := True;
        end else begin
          AlloBtn.TabStop := False;
          FekvoBtn.Checked := True;
        end;
      end;

    end;
  end;

  procedure TPageForm.RefreshText();
  var PageSize : TDoublePoint;
  begin
    if AlloBtn.Checked then begin
      if PapirCB.ItemIndex = LastIndex then begin
        PageSize.X := CustomSize.Y;
        PageSize.Y := CustomSize.X;
      end else begin
        PageSize.X := PageSizes[PapirCB.ItemIndex, Egyseg].Y;
        PageSize.Y := PageSizes[PapirCB.ItemIndex, Egyseg].X;
      end;
    end else begin
      if PapirCB.ItemIndex = LastIndex then begin
        PageSize.X := CustomSize.X;
        PageSize.Y := CustomSize.Y;
      end else begin
        PageSize.X := PageSizes[PapirCB.ItemIndex, Egyseg].X;
        PageSize.Y := PageSizes[PapirCB.ItemIndex, Egyseg].Y;
      end;
    end;

    PapirSzelesEd.Text := Format('%-2.4g ', [PageSize.X]) + UNITS[Egyseg].Code;
    PapirMagasEd.Text := Format('%-2.4g ', [PageSize.Y]) + UNITS[Egyseg].Code;
  end;

  procedure TPageForm.FormCreate(Sender: TObject);
  begin
    PapirCB.ItemIndex := Inifile.ReadInteger('Papir', 'Meret', 3);
    AlloBtn.Checked := IniFile.ReadBool('Papir', 'Tajolas', False);
    LastIndex := PapirCB.Items.Count - 1;

    if AlloBtn.Checked then begin
      MainForm.Lapszeles.Text := Format('%-2.6g ',[PageSizes[PapirCB.ItemIndex, Egyseg].Y]);
      MainForm.Lapmagas.Text := Format('%-2.6g ',[PageSizes[PapirCB.ItemIndex, Egyseg].X]);
      Lx := PageSizes[PapirCB.ItemIndex, 3].Y;
      Ly := PageSizes[PapirCB.ItemIndex, 3].X;
    end else begin
      MainForm.Lapszeles.Text := Format('%-2.6g ', [PageSizes[PapirCB.ItemIndex, Egyseg].X]);
      MainForm.Lapmagas.Text := Format('%-2.6g ', [PageSizes[PapirCB.ItemIndex, Egyseg].Y]);
      Lx := PageSizes[PapirCB.ItemIndex, 3].X;
      Ly := PageSizes[PapirCB.ItemIndex, 3].Y;
    end;
  end;

  procedure TPageForm.FormShow(Sender: TObject);
  begin
    TartIndex := PapirCB.ItemIndex;
    TartAllo := AlloBtn.Checked;
    TartSzeles := PapirSzelesEd.Text;
    TartMagas := PapirMagasEd.Text;

    CustomSize := PageSizes[PapirCB.ItemIndex, Egyseg];

    case Egyseg of
      0 : Max := 1500;
      1 : Max := 150;
      2 : Max := 60;
      3 : Max := 60000;
    end;
  end;

  procedure TPageForm.PapirOKBtnClick(Sender: TObject);
  begin
    if PapirCB.ItemIndex = LastIndex then begin // Egyéni méret
      PageSizes[LastIndex, 0].X := Convert(Egyseg, 0, CustomSize.X);
      PageSizes[LastIndex, 0].Y := Convert(Egyseg, 0, CustomSize.Y);

      PageSizes[LastIndex, 1].X := Convert(Egyseg, 1, CustomSize.X);
      PageSizes[LastIndex, 1].Y := Convert(Egyseg, 1, CustomSize.Y);

      PageSizes[LastIndex, 2].X := Convert(Egyseg, 2, CustomSize.X);
      PageSizes[LastIndex, 2].Y := Convert(Egyseg, 2, CustomSize.Y);

      PageSizes[LastIndex, 3].X := Convert(Egyseg, 3, CustomSize.X);
      PageSizes[LastIndex, 3].Y := Convert(Egyseg, 3, CustomSize.Y);
    end;

    if AlloBtn.Checked then begin
      MainForm.Lapszeles.Text := Format('%-2.6g ', [PageSizes[PapirCB.ItemIndex, Egyseg].Y]);
      MainForm.Lapmagas.Text  := Format('%-2.6g ', [PageSizes[PapirCB.ItemIndex, Egyseg].X]);
      Lx := PageSizes[PapirCB.ItemIndex, 3].Y;
      Ly := PageSizes[PapirCB.ItemIndex, 3].X;
    end else begin
      MainForm.Lapszeles.Text := Format('%-2.6g ', [PageSizes[PapirCB.ItemIndex, Egyseg].X]);
      MainForm.Lapmagas.Text  := Format('%-2.6g ', [PageSizes[PapirCB.ItemIndex, Egyseg].Y]);
      Lx := PageSizes[PapirCB.ItemIndex, 3].X;
      Ly := PageSizes[PapirCB.ItemIndex, 3].Y;
    end;

    Close;
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
    PapirSzelesEd.Text := TartSzeles;
    PapirMagasEd.Text := TartMagas;
  end;

  procedure TPageForm.AlloBtnClick(Sender: TObject);
  begin
    NeedSaveIni := True;
    if AlloBtn.Checked then begin
      AlloBtn.TabStop := True;
      FekvoBtn.TabStop := False;
      LapImage2.Visible := False;
      LapImage1.Visible := True;
      RefreshText();
    end;
  end;

  procedure TPageForm.FekvoBtnClick(Sender: TObject);
  begin
    NeedSaveIni := True;
    if FekvoBtn.Checked then begin
      AlloBtn.TabStop := False;
      FekvoBtn.TabStop := True;
      LapImage1.Visible := False;
      LapImage2.Visible := True;
      RefreshText();
    end;
  end;

  procedure TPageForm.PapirCBChange(Sender: TObject);
  begin
    NeedSaveIni := True;
    if PapirCB.ItemIndex <> LastIndex then
      CustomSize := PageSizes[PapirCB.ItemIndex, Egyseg];
    RefreshText();
  end;

  procedure TPageForm.PapirSzelesEdExit(Sender: TObject);
  var
    NumLength : Integer;
    D : Double;
  begin
    if NumberChk(PapirMagasEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirMagasEd.Text, 1, NumLength));
      if AlloBtn.Checked then
        CustomSize.X := D
      else
        CustomSize.Y := D;
    end;

    if NumberChk(PapirSzelesEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirSzelesEd.Text, 1, NumLength));
      if D < Max then begin
        if AlloBtn.Checked then
          CustomSize.Y := D
        else
          CustomSize.X := D;

        if (PapirCB.ItemIndex <> LastIndex)
        and ((CustomSize.X <> PageSizes[PapirCB.ItemIndex, Egyseg].X) or (CustomSize.Y <> PageSizes[PapirCB.ItemIndex, Egyseg].Y)) then
          PapirCB.ItemIndex := LastIndex;

        SetOrientation();
        RefreshText();
      end else begin
        PapirSzelesEd.SetFocus;
        MessageDlg(Format('A méretnek %d %s alatt kell lennie', [Max, UNITS[Egyseg].Code]), mtInformation,[mbOK],0);
      end;
    end else begin
      PapirSzelesEd.SetFocus;
      InvalidValueMsg;
    end
  end;

  procedure TPageForm.PapirMagasEdExit(Sender: TObject);
  var
    NumLength : Integer;
    D : Double;
  begin
    if NumberChk(PapirSzelesEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirSzelesEd.Text, 1, NumLength));
      if AlloBtn.Checked then
        CustomSize.Y := D
      else
        CustomSize.X := D;
    end;

    if NumberChk(PapirMagasEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirMagasEd.Text, 1, NumLength));
      if Int(D) < Max then begin
        if AlloBtn.Checked then
          CustomSize.X := D
        else
          CustomSize.Y := D;

        if (PapirCB.ItemIndex <> LastIndex)
        and ((CustomSize.X <> PageSizes[PapirCB.ItemIndex, Egyseg].X) or (CustomSize.Y <> PageSizes[PapirCB.ItemIndex, Egyseg].Y)) then
          PapirCB.ItemIndex := LastIndex;

        SetOrientation();
        RefreshText();
      end else begin
        PapirMagasEd.SetFocus;
        MessageDlg(Format('A méretnek %d %s alatt kell lennie', [Max, UNITS[Egyseg].Code]), mtInformation, [mbOK], 0);
      end;
    end else begin
      PapirMagasEd.SetFocus;
      InvalidValueMsg;
    end;
  end;

  procedure TPageForm.PapirSzelesEdKeyPress(Sender: TObject; var Key: Char);
  var
    NumLength : Integer;
    D : Double;
  begin
    if NumberChk(PapirMagasEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirMagasEd.Text, 1, NumLength));
      if AlloBtn.Checked then
        CustomSize.X := D
      else
        CustomSize.Y := D;
    end;

    if Key = #13 then begin // ENTER
      if NumberChk(PapirSzelesEd.Text, NumLength) then begin
        D := StrToFloat(Copy(PapirSzelesEd.Text, 1, NumLength));
        if D < Max then begin
          if AlloBtn.Checked then
            CustomSize.Y := D
          else
            CustomSize.X := D;

          if (PapirCB.ItemIndex <> LastIndex)
          and ((CustomSize.X <> PageSizes[PapirCB.ItemIndex, Egyseg].X) or (CustomSize.Y <> PageSizes[PapirCB.ItemIndex, Egyseg].Y)) then
            PapirCB.ItemIndex := LastIndex;

          SetOrientation();
          Close;
        end else begin
          PapirSzelesEd.SetFocus;
          MessageDlg(Format('A méretnek %d %s alatt kell lennie', [Max, UNITS[Egyseg].Code]), mtInformation, [mbOK], 0);
        end;
      end else begin
        PapirSzelesEd.SetFocus;
        MessageDlg('Érvénytelen méret',mtInformation,[mbOK],0);
      end
    end else if not (Key in ['0'..'9',#8]) and (Key <> DecSep) then
      Key := #0;
  end;

  procedure TPageForm.PapirMagasEdKeyPress(Sender: TObject; var Key: Char);
  var
    NumLength : Integer;
    D : Double;
  begin
    if NumberChk(PapirSzelesEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirSzelesEd.Text, 1, NumLength));
      if AlloBtn.Checked then
        CustomSize.Y := D
      else
        CustomSize.X := D;
    end;

    if Key = #13 then begin // ENTER leütése
      if NumberChk(PapirMagasEd.Text, NumLength) then begin
        D := StrToFloat(Copy(PapirMagasEd.Text, 1, NumLength));
        if Int(D) < Max then begin
          if AlloBtn.Checked then
            CustomSize.X := D
          else
            CustomSize.Y := D;

          if (PapirCB.ItemIndex <> LastIndex)
          and ((CustomSize.X <> PageSizes[PapirCB.ItemIndex, Egyseg].X) or (CustomSize.Y <> PageSizes[PapirCB.ItemIndex, Egyseg].Y)) then
            PapirCB.ItemIndex := LastIndex;

          SetOrientation();
          Close();
        end else begin
          PapirMagasEd.SetFocus;
          MessageDlg(Format('A méretnek %d %s alatt kell lennie', [Max, UNITS[Egyseg].Code]), mtInformation, [mbOK], 0);
        end;
      end else begin
        PapirMagasEd.SetFocus;
        MessageDlg('Érvénytelen méret', mtInformation, [mbOK], 0);
      end
    end else if not (Key in ['0'..'9',#8]) and (Key <> DecSep) then
      Key:=#0;
  end;

  procedure TPageForm.PapirSzelesSpinUpClick(Sender: TObject);
  var
    NumLength : Integer;
    D : Double;
  begin
    if NumberChk(PapirMagasEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirMagasEd.Text, 1, NumLength));
      if AlloBtn.Checked then
        CustomSize.X := D
      else
        CustomSize.Y := D;
    end;

    if NumberChk(PapirSzelesEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirSzelesEd.Text, 1, NumLength));
      if D + 1 < Max then begin
        D := D + 1;
        if AlloBtn.Checked then
          CustomSize.Y := D
        else
          CustomSize.X := D;

        PapirCB.ItemIndex := LastIndex;
        SetOrientation();
        RefreshText();
      end;
    end;
  end;

  procedure TPageForm.PapirSzelesSpinDownClick(Sender: TObject);
  var
    NumLength : Integer;
    D : Double;
  begin
    if NumberChk(PapirMagasEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirMagasEd.Text, 1, NumLength));
      if AlloBtn.Checked then
        CustomSize.X := D
      else
        CustomSize.Y := D;
    end;

    if NumberChk(PapirSzelesEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirSzelesEd.Text, 1, NumLength));
      if D - 1 > 0 then begin
        D := D - 1;
        if AlloBtn.Checked then
          CustomSize.Y := D
        else
          CustomSize.X := D;

        PapirCB.ItemIndex := LastIndex;
        SetOrientation();
        RefreshText();
      end;
    end;
  end;

  procedure TPageForm.PapirMagasSpinUpClick(Sender: TObject);
  var
    NumLength : Integer;
    D : Double;
  begin
    if NumberChk(PapirSzelesEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirSzelesEd.Text, 1, NumLength));
      if AlloBtn.Checked then
        CustomSize.Y := D
      else
        CustomSize.X := D;
    end;

    if NumberChk(PapirMagasEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirMagasEd.Text, 1, NumLength));
      if D + 1 < Max then begin
        D := D + 1;
        if AlloBtn.Checked then
          CustomSize.X := D
        else
          CustomSize.Y := D;

        PapirCB.ItemIndex := LastIndex;
        SetOrientation();
        RefreshText();
      end;
    end;
  end;

  procedure TPageForm.PapirMagasSpinDownClick(Sender: TObject);
  var
    NumLength : Integer;
    D : Double;
  begin
    if NumberChk(PapirSzelesEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirSzelesEd.Text, 1, NumLength));
      if AlloBtn.Checked then
        CustomSize.Y := D
      else
        CustomSize.X := D;
    end;

    if NumberChk(PapirMagasEd.Text, NumLength) then begin
      D := StrToFloat(Copy(PapirMagasEd.Text, 1, NumLength));
      if D - 1 > 0 then begin
        D := D - 1;
        if AlloBtn.Checked then
          CustomSize.X := D
        else
          CustomSize.Y := D;

        PapirCB.ItemIndex := LastIndex;
        SetOrientation();
        RefreshText();
      end;
    end;
  end;

end.
