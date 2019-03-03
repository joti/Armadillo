unit Parameters1;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, General;

  type
    TParametersForm1 = class(TForm)
      OKBtn: TButton;
      HossztartLab: TLabel;
      Fok1Ed: TEdit;
      Fok1Lab: TLabel;
      Fok2Lab: TLabel;
      Fok2Ed: TEdit;
      DefaultBtn: TButton;
      PMLab: TLabel;
      FoknEd: TEdit;
      FoknLab: TLabel;
      LegkulsoLab: TLabel;
      FokkEd: TEdit;
      FokkLab: TLabel;
      PMLab2: TLabel;
      CentrumLab: TLabel;
      FokaEd: TEdit;
      FokaLab: TLabel;
      VegtelenChk: TCheckBox;
      IranyCB: TComboBox;
      IranyLab: TLabel;
      procedure FormShow(Sender: TObject);
      procedure OKBtnClick(Sender: TObject);
      procedure DefaultBtnClick(Sender: TObject);
      procedure Fok1EdKeyPress(Sender: TObject; var Key: Char);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure VegtelenChkClick(Sender: TObject);
      procedure FokaEdKeyPress(Sender: TObject; var Key: Char);
    private
      { Private declarations }
    public
      { Public declarations }
    end;

  var
    ParametersForm1: TParametersForm1;

implementation

  uses Main, Page;

  {$R *.DFM}

  function FokVizsgalo(Szam : String) : Boolean;
  var i: Byte;
      szam2: Integer;
  begin
    Result := NumberChk(Szam);

    if Result then begin
      if StrToInt(Szam) > 179 then
        Result := False
      else begin
        Szam2 := StrToInt(Szam);
        case AktivVetulet of
        // Valós síkvetületek
        2: // Sztereografikus
          if Szam2 > 179 then
            Result := False;
        3: // Gnomonikus
          if Szam2 > 89 then
            Result := False;
        // Valós kúpvetületek
        21,23,24:
          if Szam2 > 179 then
            Result := False;
        20,22,25,26,27:
          if Szam2 > 179 then
            Result := False;
        // Valós hengervetületek
        41,43,44,45,46:
          if Szam2 > 89 then
            Result := False;
        // Képzetes kúpvetületek
        60: // Bonne-féle
          if Szam2 > 89 then
            Result := False;
        65: // Szögtartó polikónikus
          if Szam2 > 179 then
            Result := False;
        69: // Lagrange-féle
          if Abs(Szam2) > 89 then
            Result:=False;
        end;
      end;
    end;

    // Perspektív kúpvetületnél a 0 is értelmezett
    if (AktivVetulet = 27) and (szam = '0') then
      Result:=True;
  end;

  procedure TParametersForm1.FormShow(Sender: TObject);

    procedure Alapmeret;
    begin
      Height := 128;
      DefaultBtn.Top := 69;
      OKBtn.Top := 68;
      LegkulsoLab.Top := 10;
      FokkLab.Top := 36;
      FokkEd.Top := 34;
      PMLab2.Top := 36;
    end;

    procedure Nagymeret;
    begin
      Height := 184;
      DefaultBtn.Top := 124;
      OKBtn.Top := 124;
      LegkulsoLab.Top := 66;
      FokkLab.Top := 92;
      FokkEd.Top := 90;
      PMLab2.Top := 92;
    end;

    procedure Oriasmeret;
    begin
      Height := 271;
      DefaultBtn.Top := 211;
      OKBtn.Top := 211;
      LegkulsoLab.Top := 153;
      FokkLab.Top := 179;
      FokkEd.Top := 177;
      PMLab2.Top := 179;
    end;

    procedure Orias2meret;
    begin
      Height := 245;
      DefaultBtn.Top := 185;
      OKBtn.Top := 185;
      LegkulsoLab.Top := 128;
      FokkLab.Top := 153;
      FokkEd.Top := 151;
      PMLab2.Top := 153;
    end;

  begin
    case AktivVetulet of
    // Valós síkvetületek
    2,3:
      begin
        Alapmeret;
        LegkulsoLab.Visible := True;
        LegkulsoLab.Caption := 'Legkülsõ kirajzolt paralelkör pólustávolsága:';
        LegkulsoLab.Left := 7;
        FokkEd.Visible := True;
        FokkLab.Visible := True;
        FokkEd.Text := IntToStr(fik);
      end;
    // Valós kúpvetületek
    20,25,26:
      begin
        Alapmeret;
        HossztartLab.Visible := True;
        HossztartLab.Caption := 'Hossztartó paralelkör pólustávolsága:';
        HossztartLab.Left := 25;
        FoknEd.Visible := True;
        FoknLab.Visible := True;
        FoknEd.Text := IntToStr(fin);
      end;
    21,24:
      begin
        Alapmeret;
        HossztartLab.Visible := True;
        HossztartLab.Caption := 'Hossztartó paralelkörök pólustávolsága:';
        HossztartLab.Left := 20;
        Fok1Ed.Visible := True;
        Fok2Ed.Visible := True;
        Fok1Lab.Visible := True;
        Fok2Lab.Visible := True;
        Fok1Ed.Text := IntToStr(fi1);
        Fok2Ed.Text := IntToStr(fi2);
      end;
    22:
      begin
        Nagymeret;
        LegkulsoLab.Visible := True;
        HossztartLab.Visible := True;
        HossztartLab.Caption := 'Hossztartó paralelkör pólustávolsága:';
        LegkulsoLab.Caption := 'Legkülsõ kirajzolt paralelkör pólustávolsága:';
        HossztartLab.Left := 25;
        LegkulsoLab.Left := 7;
        FoknEd.Visible := True;
        FokkEd.Visible := True;
        FoknLab.Visible := True;
        FokkLab.Visible := True;
        FoknEd.Text := IntToStr(fin);
        FokkEd.Text := IntToStr(fik);
      end;
    23:
      begin
        Nagymeret;
        LegkulsoLab.Visible := True;
        HossztartLab.Visible := True;
        HossztartLab.Caption := 'Hossztartó paralelkörök pólustávolsága:';
        LegkulsoLab.Caption := 'Legkülsõ kirajzolt paralelkör pólustávolsága:';
        HossztartLab.Left := 20;
        LegkulsoLab.Left := 7;
        Fok1Ed.Visible := True;
        Fok2Ed.Visible := True;
        FokkEd.Visible := True;
        Fok1Lab.Visible := True;
        Fok2Lab.Visible := True;
        FokkLab.Visible := True;
        Fok1Ed.Text := IntToStr(fi1);
        Fok2Ed.Text := IntToStr(fi2);
        FokkEd.Text := IntToStr(fik);
      end;
    27:
      begin
        Oriasmeret;
        LegkulsoLab.Visible := True;
        HossztartLab.Visible := True;
        CentrumLab.Visible := True;
        IranyCB.Visible := True;
        IranyLab.Visible := True;
        HossztartLab.Caption := 'Hossztartó paralelkörök pólustávolsága:';
        LegkulsoLab.Caption := 'Legkülsõ kirajzolt paralelkör pólustávolsága:';
        HossztartLab.Left := 20;
        LegkulsoLab.Left := 7;
        Fok1Ed.Visible := True;
        Fok2Ed.Visible := True;
        FokkEd.Visible := True;
        FokaEd.Left := 30;
        FokaEd.Top := 92;
        FokaEd.Visible := True;
        Fok1Lab.Visible := True;
        Fok2Lab.Visible := True;
        FokkLab.Visible := True;
        FokaLab.Visible := True;
        VegtelenChk.Visible := True;
        FoknEd.Text := IntToStr(fin);
        FokaEd.Text := FloatToStr(fia);
        FokkEd.Text := IntToStr(fik);
      end;
    // Valós hengervetületek
    41,43:
      begin
        Alapmeret;
        HossztartLab.Visible := True;
        HossztartLab.Caption := 'Hossztartó paralelkörök szélessége:';
        HossztartLab.Left := 33;
        FoknEd.Visible := True;
        FoknLab.Visible := True;
        PMLab.Visible := True;
        FoknEd.Text := IntToStr(fin);
      end;
    44:
      begin
        Alapmeret;
        LegkulsoLab.Visible := True;
        LegkulsoLab.Caption := 'Legkülsõ kirajzolt paralelkörök szélessége:';
        LegkulsoLab.Left := 13;
        FokkEd.Visible := True;
        FokkLab.Visible := True;
        PMLab2.Visible := True;
        FokkEd.Text := IntToStr(fik);
      end;
    45:
      begin
        Nagymeret;
        LegkulsoLab.Visible := True;
        HossztartLab.Visible := True;
        HossztartLab.Caption := 'Hossztartó paralelkörök szélessége:';
        LegkulsoLab.Caption := 'Legkülsõ kirajzolt paralelkörök szélessége:';
        HossztartLab.Left := 33;
        LegkulsoLab.Left := 13;
        FoknEd.Visible := True;
        FokkEd.Visible := True;
        FoknLab.Visible := True;
        FokkLab.Visible := True;
        PMLab.Visible := True;
        PMLab2.Visible := True;
        FoknEd.Text := IntToStr(fin);
        FokkEd.Text := IntToStr(fik);
      end;
    46:
      begin
        Orias2meret;
        LegkulsoLab.Visible := True;
        HossztartLab.Visible := True;
        CentrumLab.Visible := True;
        IranyCB.Visible := True;
        IranyLab.Visible := True;
        HossztartLab.Caption := 'Hossztartó paralelkörök szélessége:';
        LegkulsoLab.Caption := 'Legkülsõ kirajzolt paralelkörök szélessége:';
        HossztartLab.Left := 33;
        LegkulsoLab.Left := 13;
        FoknEd.Visible := True;
        FokkEd.Visible := True;
        FokaEd.Left := 30;
        FokaEd.Top := 92;
        FokaEd.Visible := True;
        FoknLab.Visible := True;
        FokkLab.Visible := True;
        FokaLab.Visible := True;
        PMLab.Visible := True;
        PMLab2.Visible := True;
        FoknEd.Text := IntToStr(fin);
        FokaEd.Text := FloatToStr(fia);
        FokkEd.Text := IntToStr(fik);
      end;
    // Képzetes kúpvetületek
    60:
      begin
        Alapmeret;
        HossztartLab.Visible := True;
        HossztartLab.Caption := 'Normálparalelkör szélessége:';
        HossztartLab.Left := 55;
        FoknEd.Visible := True;
        FoknLab.Visible := True;
        FoknEd.Text := IntToStr(fin);
      end;
    62,63,64:
      begin
        Alapmeret;
        HossztartLab.Visible := True;
        HossztartLab.Caption := 'A fokhálózat szétnyílását jellemzõ konstans:';
        HossztartLab.Left := 10;
        FokaEd.Left := 112;
        FokaEd.Top := 34;
        FokaEd.Visible := True;
        FokaEd.Text := FloatToStr(fia);
      end;
    65:
      begin
        Alapmeret;
        LegkulsoLab.Visible := True;
        LegkulsoLab.Caption := 'Legkülsõ kirajzolt meridiánok hosszúsága:';
        LegkulsoLab.Left := 17;
        FokkEd.Visible := True;
        FokkLab.Visible := True;
        PMLab2.Visible := True;
        FokkEd.Text := IntToStr(fik);
      end;
    69:
      begin
        Nagymeret;
        LegkulsoLab.Visible := True;
        HossztartLab.Visible := True;
        HossztartLab.Caption := 'A fokhálózat szétnyílását jellemzõ konstans:';
        LegkulsoLab.Caption := 'Egyenesként jelentkezõ paralel szélessége:';
        HossztartLab.Left := 10;
        LegkulsoLab.Left := 10;
        FokaEd.Left := 112;
        FokaEd.Top := 34;
        FokaEd.Visible := True;
        FokaEd.Text := FloatToStr(fia);
        FokkEd.Visible := True;
        FokkLab.Visible := True;
        FokkEd.Text := IntToStr(fik);
      end;
    // Egyéb képzetes vetületek
    107: // Armadillo
     begin
      Alapmeret;
      HossztartLab.Visible := True;
      HossztartLab.Caption := 'A tóruszra való rátekintés szöge:';
      HossztartLab.Left := 53;
      FoknEd.Visible := True;
      FoknLab.Visible := True;
      FoknEd.Text := IntToStr(fin);
     end;
    end;
  end;

  procedure TParametersForm1.OKBtnClick(Sender: TObject);
  begin
    case AktivVetulet of
    21,23,24,27:
      begin
        if FokVizsgalo(Fok1Ed.Text) then
          fi1 := StrToInt(Fok1Ed.Text)
        else begin
          Fok1Ed.Setfocus;
          InvalidValueMsg;
          Exit;
        end;
        if FokVizsgalo(Fok2Ed.Text) then
          fi2 := StrToInt(Fok2Ed.Text)
        else begin
          Fok2Ed.Setfocus;
          InvalidValueMsg;
          Exit;
        end;
      end;
    20,22,25,26,41,43,45,46,60,107:
      begin
        if FokVizsgalo(FoknEd.Text) or ((AktivVetulet in [46,107]) and (FoknEd.Text='0')) then
          fin := StrToInt(FoknEd.Text)
        else begin
          FoknEd.Setfocus;
          InvalidValueMsg;
          Exit;
        end;
      end;
    end;

    case AktivVetulet of
    2,3,22,23,27,44,45,46,65,69:
      begin
        if FokVizsgalo(FokkEd.Text) or ((AktivVetulet = 69) and (FokkEd.Text = '0')) then
          fik := StrToInt(FokkEd.Text)
        else begin
          FokkEd.Setfocus;
          InvalidValueMsg;
          Exit;
        end;
      end;
    end;

    if (AktivVetulet = 27) then begin // Perspektív kúpvetület
      if (((fi1 + fi2) / 2 >= 90) or (((fi1 = 90) or (fi1 = 0)) and (fi1 = fi2))) then begin
        Fok2Ed.Setfocus;
        InvalidValueMsg;
        Exit;
      end;
      if (fik > (fi1 + fi2) / 2 + 90) then begin
        FokkEd.Setfocus;
        InvalidValueMsg;
        Exit;
      end;
    end;

    if SettingsForm.CsaladCB.Itemindex = 1 then begin // Valós kúpvetületek
      if (fin > 89) then begin
        FoknEd.Setfocus;
        InvalidValueMsg;
        Exit;
      end else if ((fi1 + fi2) / 2 > 89) then begin
        Fok2Ed.Setfocus;
        InvalidValueMsg;
        Exit;
      end;
    end;

    case AktivVetulet of
    27,46,62,63,64,69:
      begin
        if not FokVizsgalo(FokaEd.Text) then begin
          if not FokaEd.Enabled then begin
            VegtelenChk.Checked := False;
            FokaEd.Enabled := True;
            FokaLab.Enabled := True;
          end;
          FokaEd.Setfocus;
          InvalidValueMsg;
          Exit;
        end else begin
          fia := StrToFloat(FokaEd.Text);
          if (AktivVetulet = 69) and (fia <= 1) then begin
            FokaEd.Setfocus;
            InvalidValueMsg;
            Exit;
          end;
        end;
      end;
    end;

    ParametersForm1.Close;
  end;

  procedure TParametersForm1.DefaultBtnClick(Sender: TObject);
  begin
    fi1 := DEF_FI1;
    fi2 := DEF_FI2;
    fin := DEF_FIN;
    fia := DEF_FIA;

    if SettingsForm.CsaladCB.Itemindex = 2 then
      fik := DEF_FIK2;

    case AktivVetulet of
    65:
      fik := DEF_FIK3;
    2,22,23,27:
      fik := DEF_FIK1;
    40..49:
      fin := DEF_FIN2;
    107:
      fin := DEF_FIN3;
    3:
      fik := DEF_FIK2;
    62,63,64:
      fia := DEF_FIA2;
    69:
      begin
        fik := DEF_FIK4;
        fia := DEF_FIA3;
      end;
    end;

    DefaultBtn.Enabled:=False;
    if not FokaEd.Enabled then begin
      VegtelenChk.Checked := False;
      FokaEd.Enabled := True;
      FokaLab.Enabled := True;
      IranyCB.Enabled := True;
      IranyCB.Itemindex := 0;
      IranyLab.Enabled := True;
    end;

    FormShow(DefaultBtn);
  end;

  procedure TParametersForm1.Fok1EdKeyPress(Sender: TObject; var Key: Char);
  begin
    if AktivVetulet = 69 then begin // Lagrange-féle
      if not (Key in ['0'..'9','-',#8]) then
        Key := #0
      else
        DefaultBtn.Enabled := True;
    end else if not (Key in ['0'..'9',#8]) then
      Key := #0
    else
      DefaultBtn.Enabled := True;
  end;

  procedure TParametersForm1.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
    LegkulsoLab.Visible:=False;
    HossztartLab.Visible:=False;
    CentrumLab.Visible:=False;
    IranyCB.Visible:=False;
    IranyLab.Visible:=False;
    Fok1Ed.Visible:=False;
    Fok2Ed.Visible:=False;
    FoknEd.Visible:=False;
    FokkEd.Visible:=False;
    FokaEd.Visible:=False;
    Fok1Lab.Visible:=False;
    Fok2Lab.Visible:=False;
    FoknLab.Visible:=False;
    FokkLab.Visible:=False;
    FokaLab.Visible:=False;
    PMLab.Visible:=False;
    PMLab2.Visible:=False;
    VegtelenChk.Visible:=False;
  end;

  procedure TParametersForm1.VegtelenChkClick(Sender: TObject);
  begin
    IranyLab.Enabled := not IranyLab.Enabled;
    IranyCB.Enabled := not IranyCB.Enabled;
    FokaEd.Enabled := not FokaEd.Enabled;
    FokaLab.Enabled := not FokaLab.Enabled;

    if VegtelenChk.Checked then begin
      FokaEd.Color := clMenu;
      IranyCB.Color := clMenu;
    end else begin
      FokaEd.Color := clWindow;
      IranyCB.Color := clWindow;
    end;
  end;

  procedure TParametersForm1.FokaEdKeyPress(Sender: TObject; var Key: Char);
  begin
    if not (Key in ['0'..'9',',',#8]) then
      Key := #0
    else
      DefaultBtn.Enabled := True;
  end;

end.
