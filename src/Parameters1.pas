unit Parameters1;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, General;

  type
    TParametersForm1 = class(TForm)
      OKBtn: TButton;
      Hossztart1: TLabel;
      Fok1: TEdit;
      Foklabel1: TLabel;
      Foklabel2: TLabel;
      Fok2: TEdit;
      DefaultBtn: TButton;
      pmlabel: TLabel;
      Fokn: TEdit;
      Foklabeln: TLabel;
      LegkulsoLabel: TLabel;
      Fokk: TEdit;
      Foklabelk: TLabel;
      pmlabel2: TLabel;
      CentrumLabel: TLabel;
      Foka: TEdit;
      Foklabela: TLabel;
      VegtelenChk: TCheckBox;
      Iranybox: TComboBox;
      IranyLabel: TLabel;
      procedure FormShow(Sender: TObject);
      procedure OKBtnClick(Sender: TObject);
      procedure DefaultBtnClick(Sender: TObject);
      procedure Fok1KeyPress(Sender: TObject; var Key: Char);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure VegtelenChkClick(Sender: TObject);
      procedure FokaKeyPress(Sender: TObject; var Key: Char);
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
      LegkulsoLabel.Top := 10;
      Foklabelk.Top := 36;
      Fokk.Top := 34;
      pmlabel2.Top := 36;
    end;

    procedure Nagymeret;
    begin
      Height := 184;
      DefaultBtn.Top := 124;
      OKBtn.Top := 124;
      LegkulsoLabel.Top := 66;
      Foklabelk.Top := 92;
      Fokk.Top := 90;
      pmlabel2.Top := 92;
    end;

    procedure Oriasmeret;
    begin
      Height := 271;
      DefaultBtn.Top := 211;
      OKBtn.Top := 211;
      LegkulsoLabel.Top := 153;
      Foklabelk.Top := 179;
      Fokk.Top := 177;
      pmlabel2.Top := 179;
    end;

    procedure Orias2meret;
    begin
      Height := 245;
      DefaultBtn.Top := 185;
      OKBtn.Top := 185;
      LegkulsoLabel.Top := 128;
      Foklabelk.Top := 153;
      Fokk.Top := 151;
      pmlabel2.Top := 153;
    end;

  begin
    case AktivVetulet of
    // Valós síkvetületek
    2,3:
      begin
        Alapmeret;
        LegkulsoLabel.Visible := True;
        LegkulsoLabel.Caption := 'Legkülsõ kirajzolt paralelkör pólustávolsága:';
        LegkulsoLabel.Left := 7;
        Fokk.Visible := True;
        Foklabelk.Visible := True;
        Fokk.Text := IntToStr(fik);
      end;
    // Valós kúpvetületek
    20,25,26:
      begin
        Alapmeret;
        Hossztart1.Visible := True;
        Hossztart1.Caption := 'Hossztartó paralelkör pólustávolsága:';
        Hossztart1.Left := 25;
        Fokn.Visible := True;
        Foklabeln.Visible := True;
        Fokn.Text := IntToStr(fin);
      end;
    21,24:
      begin
        Alapmeret;
        Hossztart1.Visible := True;
        Hossztart1.Caption := 'Hossztartó paralelkörök pólustávolsága:';
        Hossztart1.Left := 20;
        Fok1.Visible := True;
        Fok2.Visible := True;
        Foklabel1.Visible := True;
        Foklabel2.Visible := True;
        Fok1.Text := IntToStr(fi1);
        Fok2.Text := IntToStr(fi2);
      end;
    22:
      begin
        Nagymeret;
        LegkulsoLabel.Visible := True;
        Hossztart1.Visible := True;
        Hossztart1.Caption := 'Hossztartó paralelkör pólustávolsága:';
        LegkulsoLabel.Caption := 'Legkülsõ kirajzolt paralelkör pólustávolsága:';
        Hossztart1.Left := 25;
        LegkulsoLabel.Left := 7;
        Fokn.Visible := True;
        Fokk.Visible := True;
        Foklabeln.Visible := True;
        Foklabelk.Visible := True;
        Fokn.Text := IntToStr(fin);
        Fokk.Text := IntToStr(fik);
      end;
    23:
      begin
        Nagymeret;
        LegkulsoLabel.Visible := True;
        Hossztart1.Visible := True;
        Hossztart1.Caption := 'Hossztartó paralelkörök pólustávolsága:';
        LegkulsoLabel.Caption := 'Legkülsõ kirajzolt paralelkör pólustávolsága:';
        Hossztart1.Left := 20;
        LegkulsoLabel.Left := 7;
        Fok1.Visible := True;
        Fok2.Visible := True;
        Fokk.Visible := True;
        Foklabel1.Visible := True;
        Foklabel2.Visible := True;
        Foklabelk.Visible := True;
        Fok1.Text := IntToStr(fi1);
        Fok2.Text := IntToStr(fi2);
        Fokk.Text := IntToStr(fik);
      end;
    27:
      begin
        Oriasmeret;
        LegkulsoLabel.Visible := True;
        Hossztart1.Visible := True;
        CentrumLabel.Visible := True;
        Iranybox.Visible := True;
        Iranylabel.Visible := True;
        Hossztart1.Caption := 'Hossztartó paralelkörök pólustávolsága:';
        LegkulsoLabel.Caption := 'Legkülsõ kirajzolt paralelkör pólustávolsága:';
        Hossztart1.Left := 20;
        LegkulsoLabel.Left := 7;
        Fok1.Visible := True;
        Fok2.Visible := True;
        Fokk.Visible := True;
        Foka.Left := 30;
        Foka.Top := 92;
        Foka.Visible := True;
        Foklabel1.Visible := True;
        Foklabel2.Visible := True;
        Foklabelk.Visible := True;
        Foklabela.Visible := True;
        VegtelenChk.Visible := True;
        Fokn.Text := IntToStr(fin);
        Foka.Text := FloatToStr(fia);
        Fokk.Text := IntToStr(fik);
      end;
    // Valós hengervetületek
    41,43:
      begin
        Alapmeret;
        Hossztart1.Visible := True;
        Hossztart1.Caption := 'Hossztartó paralelkörök szélessége:';
        Hossztart1.Left := 33;
        Fokn.Visible := True;
        Foklabeln.Visible := True;
        pmlabel.Visible := True;
        Fokn.Text := IntToStr(fin);
      end;
    44:
      begin
        Alapmeret;
        LegkulsoLabel.Visible := True;
        LegkulsoLabel.Caption := 'Legkülsõ kirajzolt paralelkörök szélessége:';
        LegkulsoLabel.Left := 13;
        Fokk.Visible := True;
        Foklabelk.Visible := True;
        pmlabel2.Visible := True;
        Fokk.Text := IntToStr(fik);
      end;
    45:
      begin
        Nagymeret;
        LegkulsoLabel.Visible := True;
        Hossztart1.Visible := True;
        Hossztart1.Caption := 'Hossztartó paralelkörök szélessége:';
        LegkulsoLabel.Caption := 'Legkülsõ kirajzolt paralelkörök szélessége:';
        Hossztart1.Left := 33;
        LegkulsoLabel.Left := 13;
        Fokn.Visible := True;
        Fokk.Visible := True;
        Foklabeln.Visible := True;
        Foklabelk.Visible := True;
        pmlabel.Visible := True;
        pmlabel2.Visible := True;
        Fokn.Text := IntToStr(fin);
        Fokk.Text := IntToStr(fik);
      end;
    46:
      begin
        Orias2meret;
        LegkulsoLabel.Visible := True;
        Hossztart1.Visible := True;
        CentrumLabel.Visible := True;
        Iranybox.Visible := True;
        Iranylabel.Visible := True;
        Hossztart1.Caption := 'Hossztartó paralelkörök szélessége:';
        LegkulsoLabel.Caption := 'Legkülsõ kirajzolt paralelkörök szélessége:';
        Hossztart1.Left := 33;
        LegkulsoLabel.Left := 13;
        Fokn.Visible := True;
        Fokk.Visible := True;
        Foka.Left := 30;
        Foka.Top := 92;
        Foka.Visible := True;
        Foklabeln.Visible := True;
        Foklabelk.Visible := True;
        Foklabela.Visible := True;
        pmlabel.Visible := True;
        pmlabel2.Visible := True;
        Fokn.Text := IntToStr(fin);
        Foka.Text := FloatToStr(fia);
        Fokk.Text := IntToStr(fik);
      end;
    // Képzetes kúpvetületek
    60:
      begin
        Alapmeret;
        Hossztart1.Visible := True;
        Hossztart1.Caption := 'Normálparalelkör szélessége:';
        Hossztart1.Left := 55;
        Fokn.Visible := True;
        Foklabeln.Visible := True;
        Fokn.Text := IntToStr(fin);
      end;
    62,63,64:
      begin
        Alapmeret;
        Hossztart1.Visible := True;
        Hossztart1.Caption := 'A fokhálózat szétnyílását jellemzõ konstans:';
        Hossztart1.Left := 10;
        Foka.Left := 112;
        Foka.Top := 34;
        Foka.Visible := True;
        Foka.Text := FloatToStr(fia);
      end;
    65:
      begin
        Alapmeret;
        LegkulsoLabel.Visible := True;
        LegkulsoLabel.Caption := 'Legkülsõ kirajzolt meridiánok hosszúsága:';
        LegkulsoLabel.Left := 17;
        Fokk.Visible := True;
        Foklabelk.Visible := True;
        pmlabel2.Visible := True;
        Fokk.Text := IntToStr(fik);
      end;
    69:
      begin
        Nagymeret;
        LegkulsoLabel.Visible := True;
        Hossztart1.Visible := True;
        Hossztart1.Caption := 'A fokhálózat szétnyílását jellemzõ konstans:';
        LegkulsoLabel.Caption := 'Egyenesként jelentkezõ paralel szélessége:';
        Hossztart1.Left := 10;
        LegkulsoLabel.Left := 10;
        Foka.Left := 112;
        Foka.Top := 34;
        Foka.Visible := True;
        Foka.Text := FloatToStr(fia);
        Fokk.Visible := True;
        Foklabelk.Visible := True;
        Fokk.Text := IntToStr(fik);
      end;
    // Egyéb képzetes vetületek
    107: // Armadillo
     begin
      Alapmeret;
      Hossztart1.Visible := True;
      Hossztart1.Caption := 'A tóruszra való rátekintés szöge:';
      Hossztart1.Left := 53;
      Fokn.Visible := True;
      Foklabeln.Visible := True;
      Fokn.Text := IntToStr(fin);
     end;
    end;
  end;

  procedure TParametersForm1.OKBtnClick(Sender: TObject);
  begin
    case AktivVetulet of
    21,23,24,27:
      begin
        if FokVizsgalo(Fok1.Text) then
          fi1 := StrToInt(Fok1.Text)
        else begin
          Fok1.Setfocus;
          InvalidValueMsg;
          Exit;
        end;
        if FokVizsgalo(Fok2.Text) then
          fi2 := StrToInt(Fok2.Text)
        else begin
          Fok2.Setfocus;
          InvalidValueMsg;
          Exit;
        end;
      end;
    20,22,25,26,41,43,45,46,60,107:
      begin
        if FokVizsgalo(Fokn.Text) or ((AktivVetulet in [46,107]) and (Fokn.Text='0')) then
          fin := StrToInt(Fokn.Text)
        else begin
          Fokn.Setfocus;
          InvalidValueMsg;
          Exit;
        end;
      end;
    end;

    case AktivVetulet of
    2,3,22,23,27,44,45,46,65,69:
      begin
        if FokVizsgalo(Fokk.Text) or ((AktivVetulet = 69) and (Fokk.Text = '0')) then
          fik := StrToInt(Fokk.Text)
        else begin
          Fokk.Setfocus;
          InvalidValueMsg;
          Exit;
        end;
      end;
    end;

    if (AktivVetulet = 27) then begin // Perspektív kúpvetület
      if (((fi1 + fi2) / 2 >= 90) or (((fi1 = 90) or (fi1 = 0)) and (fi1 = fi2))) then begin
        Fok2.Setfocus;
        InvalidValueMsg;
        Exit;
      end;
      if (fik > (fi1 + fi2) / 2 + 90) then begin
        Fokk.Setfocus;
        InvalidValueMsg;
        Exit;
      end;
    end;

    if UjForm.CsaladCB.Itemindex = 1 then begin // Valós kúpvetületek
      if (fin > 89) then begin
        Fokn.Setfocus;
        InvalidValueMsg;
        Exit;
      end else if ((fi1 + fi2) / 2 > 89) then begin
        Fok2.Setfocus;
        InvalidValueMsg;
        Exit;
      end;
    end;

    case AktivVetulet of
    27,46,62,63,64,69:
      begin
        if not FokVizsgalo(Foka.Text) then begin
          if not Foka.Enabled then begin
            VegtelenChk.Checked := False;
            Foka.Enabled := True;
            Foklabela.Enabled := True;
          end;
          Foka.Setfocus;
          InvalidValueMsg;
          Exit;
        end else begin
          fia := StrToFloat(Foka.Text);
          if (AktivVetulet = 69) and (fia <= 1) then begin
            Foka.Setfocus;
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

    if UjForm.CsaladCB.Itemindex = 2 then
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
    if not Foka.Enabled then begin
      VegtelenChk.Checked := False;
      Foka.Enabled := True;
      Foklabela.Enabled := True;
      Iranybox.Enabled := True;
      Iranybox.Itemindex := 0;
      Iranylabel.Enabled := True;
    end;

    FormShow(DefaultBtn);
  end;

  procedure TParametersForm1.Fok1KeyPress(Sender: TObject; var Key: Char);
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
    LegkulsoLabel.Visible:=False;
    Hossztart1.Visible:=False;
    CentrumLabel.Visible:=False;
    Iranybox.Visible:=False;
    Iranylabel.Visible:=False;
    Fok1.Visible:=False;
    Fok2.Visible:=False;
    Fokn.Visible:=False;
    Fokk.Visible:=False;
    Foka.Visible:=False;
    Foklabel1.Visible:=False;
    Foklabel2.Visible:=False;
    Foklabeln.Visible:=False;
    Foklabelk.Visible:=False;
    Foklabela.Visible:=False;
    pmlabel.Visible:=False;
    pmlabel2.Visible:=False;
    VegtelenChk.Visible:=False;
  end;

  procedure TParametersForm1.VegtelenChkClick(Sender: TObject);
  begin
    Iranylabel.Enabled := not Iranylabel.Enabled;
    Iranybox.Enabled := not Iranybox.Enabled;
    Foka.Enabled := not Foka.Enabled;
    Foklabela.Enabled := not Foklabela.Enabled;

    if VegtelenChk.Checked then begin
      Foka.Color := clMenu;
      Iranybox.Color := clMenu;
    end else begin
      Foka.Color := clWindow;
      Iranybox.Color := clWindow;
    end;
  end;

  procedure TParametersForm1.FokaKeyPress(Sender: TObject; var Key: Char);
  begin
    if not (Key in ['0'..'9',',',#8]) then
      Key := #0
    else
      DefaultBtn.Enabled := True;
  end;

end.
