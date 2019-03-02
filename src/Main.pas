unit Main;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, StdCtrls, Menus, Math, Settings, ComCtrls, ToolWin,
    Buttons, Printers, jpeg, General;

  type
    TMainForm = class(TForm)
      SzelesEd: TEdit;
      EgysegLab: TLabel;
      MagasEd: TEdit;
      SzelesImage: TImage;
      MagasImage: TImage;
      EgysegCB: TComboBox;
      MeretaranyLab: TLabel;
      MeretaranyEd: TEdit;
      MillioLab: TLabel;
      NagyitasCB: TComboBox;
      Nagyitlabel: TLabel;
      ScrollBox1: TScrollBox;
      Abra: TImage;
      MainMenu1: TMainMenu;
      FileMenu: TMenuItem;
      Kilepes: TMenuItem;
      Mentes: TMenuItem;
      N1: TMenuItem;
      Szerkesztes: TMenuItem;
      Frissit: TMenuItem;
      Teljes: TMenuItem;
      Segit: TMenuItem;
      Nevjegy: TMenuItem;
      Beallit: TMenuItem;
      N4: TMenuItem;
      SaveDialog1: TSaveDialog;
      Papirmenu: TMenuItem;
      LapszelesImage: TImage;
      Lapszeles: TEdit;
      Lapmagas: TEdit;
      LapmagasImage: TImage;
      Nezet: TMenuItem;
      Statuszsore: TMenuItem;
      Eszkoztare: TMenuItem;
      Meretezoe: TMenuItem;
      Eszkoztar: TPanel;
      Meretezo: TPanel;
      MentBtn: TSpeedButton;
      NagyitBtn: TSpeedButton;
      KicsinyitBtn: TSpeedButton;
      VagBtn: TSpeedButton;
      ZoomShape: TShape;
      Segedshape: TShape;
      FrissitBtn: TSpeedButton;
      Egyeb: TMenuItem;
      TeljesBtn: TSpeedButton;
      StatusBar1: TStatusbar;
      LaphozBtn: TSpeedButton;
      StatusBar2: TStatusBar;
      Nyomtat: TMenuItem;
      PrintDialog1: TPrintDialog;
      PrinterSetupDialog1: TPrinterSetupDialog;
      NyomtatBtn: TSpeedButton;
      Edit1: TEdit;
      MozgatBtn: TSpeedButton;
      KozepreBtn: TSpeedButton;
      TavolsagBtn: TSpeedButton;
      StatusBar3: TStatusBar;
      Timer1: TTimer;
      procedure AbraMouseDown(Sender: TObject; Button: TMouseButton;
        Shift: TShiftState; X, Y: Integer);
      procedure AbraMouseMove(Sender: TObject; Shift: TShiftState; X,
        Y: Integer);
      procedure AbraMouseUp(Sender: TObject; Button: TMouseButton;
        Shift: TShiftState; X, Y: Integer);
      procedure FormCreate(Sender: TObject);
      procedure FrissitClick(Sender: TObject);
      procedure NagyitasCBChange(Sender: TObject);
      procedure MentesClick(Sender: TObject);
      procedure NevjegyClick(Sender: TObject);
      procedure BeallitClick(Sender: TObject);
      procedure PapirmenuClick(Sender: TObject);
      procedure EgysegCBChange(Sender: TObject);
      procedure StatuszsoreClick(Sender: TObject);
      procedure NagyitasCBKeyPress(Sender: TObject; var Key: Char);
      procedure MeretaranyEdKeyPress(Sender: TObject; var Key: Char);
      procedure FormResize(Sender: TObject);
      procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
      procedure EszkoztareClick(Sender: TObject);
      procedure NagyitBtnClick(Sender: TObject);
      procedure KicsinyitBtnClick(Sender: TObject);
      procedure VagBtnClick(Sender: TObject);
      procedure TeljesClick(Sender: TObject);
      procedure EgyebClick(Sender: TObject);
      procedure LaphozBtnClick(Sender: TObject);
      procedure MeretezoeClick(Sender: TObject);
      procedure KilepesClick(Sender: TObject);
      procedure NyomtatClick(Sender: TObject);
      procedure EgysegCBEnter(Sender: TObject);
      procedure MeretaranyEdEnter(Sender: TObject);
      procedure NagyitasCBEnter(Sender: TObject);
      procedure EgysegCBKeyPress(Sender: TObject; var Key: Char);
      procedure Edit1KeyPress(Sender: TObject; var Key: Char);
      procedure MozgatBtnClick(Sender: TObject);
      procedure KozepreBtnClick(Sender: TObject);
      procedure TavolsagBtnClick(Sender: TObject);
      procedure Timer1Timer(Sender: TObject);
      procedure FormActivate(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
      procedure Frissites (Mode : Byte); // 1 - ábra frissítése, 2 - nyomtatás, 3 - plotter fájlba mentés
      procedure GetMinMax (var MinMaxMessage: TWMGetMinMaxInfo); message wm_GetMinMaxInfo;
      procedure AppMessage (var Msg: TMsg; var Handled: Boolean);
    end;

  var
    MainForm: TMainForm;
    Bitmap: TBitmap;
    Rajzol, Gyik, Lehet, Lupe: Boolean;
    Lupe2: Boolean=False;
    Sajt2: Boolean=False;
    Ni, Balszel, Jobbszel, Felsoszel, Alsoszel: Integer;
    OrigoX, OrigoY: Integer;
    Baltop, Jobbtop, Fenntop, Lenntop: Integer;
    AktivVetulet: Byte=0;
    Szamhossz2: Byte;
    Vet: array[0..220] of string;
    j,l, Winni: Byte;
    UjForm: TSettingsForm;
    Ini, Filesv, txt: Textfile;
    SI: array[0..4] of String;
    Lapx,Lapy: Array[0..6,0..6] of Double;
    Lx,Ly: Double;
    origomas: Boolean=False;
    Igazigaz: Boolean=False;
    Sajt: Boolean=False;
    Sajt3: Boolean=False;
    fel: Boolean=True;
    egyik, masik, StartPoint, EndPoint: TPoint;
    Zoomol: Boolean=False;
    Crop: Boolean=False;
    Elso: Boolean=True;
    CropScrollHorz, CropScrollVert: Integer;
    fi1, fi2, fin: Byte;
    fik, fih: SmallInt;
    fis, fia, fiah: Double;
    Vetvalt: Boolean=True;
    NeedSaveIni: Boolean=False;
    Lapba: Boolean=False;
    Plusz: String;
    Egyenes: Boolean = False;
    AHeight, AWidth : Integer;
    Egyseg : Byte = 0; // Kiválasztott mértékegység

    function NagyitasVizsgalo(szam : String) : Boolean;

implementation

  uses About, Parameters1, Page, Unit6, Options, Layers, Splash, Parameters2;

  var
    PPI : Double; {A képernyõ felbontása}
    FormPos1, FormPos2 : TPoint;
    SBMeret : TPoint;
    SBHelyX, SBHelyY : SmallInt;
    OMoveX, OMoveY, KoMoveX, KoMoveY : Integer;
    lapmovex, lapmovey : Integer;

    Zoom : Integer; // Nagyítás mértéke (%)
    PrevZoom : Integer = 20; // Be- vagy kizoomolás során az elõzõ nagyítás mértéke
    Scale : Integer; // Térkép méretarányának nevezõje
    PrevScale : Integer; // Méretarány változásakor az elõzõ méretarány

    VanMeres : Boolean = False;
    AfterClose : Boolean = False;

    // Görgetõsáv mozgatását vezérlõ attribútumok
    SBFel    : Boolean = False;
    SBLe     : Boolean = False;
    SBBalra  : Boolean = False;
    SBJobbra : Boolean = False;

  const
    DRAWMODE = 1;
    PRINTMODE = 2;
    PLTMODE = 3;
    INCHUNIT = 3;

  {$R *.DFM}

  procedure TMainForm.GetMinMax(var MinMaxMessage: TWMGetMinMaxInfo);
  begin
    // Form legkisebb lehetséges mérete
    with MinMaxMessage.MinMaxInfo^ do
    begin
      ptMinTrackSize.x := 672;
      ptMinTrackSize.y := 300;
    end;
  end;

  function ValosX(X: Integer) : Integer;
  begin
    // X pixelérték átszámítása ezredinchbe
    Result := Trunc((X - OrigoX) * 100000 / PPI / Zoom);
  end;

  function ValosY(Y: Integer) : Integer;
  begin
    // Y pixelérték átszámítása ezredinchbe
    Result := Trunc((OrigoY - Y) * 100000 / PPI / Zoom);
  end;

  function NagyitasVizsgalo(Szam : String) : Boolean;
  var i : Byte;
  begin
   if Length(Szam) = 0 then
     Result := False
   else if not (Szam[1] in ['-','1'..'9']) then
     Result := False
   else begin
     for i := Length(Szam) downto 1 do
       if not (Szam[i] in ['0'..'9']) then
         Szamhossz2 := i-1;
       Result := True;
     end;
  end;

  procedure MeresTorles(Canvas: TCanvas);
  begin
    if VanMeres then begin
      Canvas.Moveto(EndPoint.X - 7, EndPoint.Y - 7);
      Canvas.Lineto(EndPoint.X + 7, EndPoint.Y + 7);
      Canvas.Moveto(EndPoint.X + 7, EndPoint.Y - 7);
      Canvas.Lineto(EndPoint.X - 7, EndPoint.Y + 7);

      Canvas.Moveto(StartPoint.X - 7, StartPoint.Y - 7);
      Canvas.Lineto(StartPoint.X + 7, StartPoint.Y + 7);
      Canvas.Moveto(StartPoint.X + 7, StartPoint.Y - 7);
      Canvas.Lineto(StartPoint.X - 7, StartPoint.Y + 7);

      Canvas.Moveto(StartPoint.X,StartPoint.y);
      Canvas.Lineto(EndPoint.X,EndPoint.Y);
    end;
    VanMeres := False;
  end;

  procedure TMainForm.AppMessage (var Msg: TMsg; var Handled: Boolean);
  begin
    if (Msg.Message = wm_Char) and (Msg.wparam = 27) then begin // ESC leütése
      if OptionsForm.Active then
        OptionsForm.Close;

      if ParametersForm1.Active then
        ParametersForm1.Close;

      if PageForm.Active then begin
        PageForm.PapirCancelBtnClick(Application);
        PageForm.Close;
      end;

      if AboutForm.Active then
        AboutForm.Close;

      if LayersForm.Active then
        LayersForm.Close;

      if ParametersForm2.Active then
        ParametersForm2.Close;

      MainForm.FormActivate(Application);
    end else if (Msg.Message = wm_KeyDown) and (MainForm.Active) then begin
      case msg.lparam of
      21495809: SBFel := True;
      22020097: SBLe := True;
      21692417: SBBalra := True;
      21823489: SBJobbra := True;
      end;
    end else if (Msg.Message = wm_KeyUp) and (MainForm.Active) then begin
      case msg.lparam of
      -1052246015: SBFel := False;
      -1051721727: SBLe := False;
      -1052049407: SBBalra := False;
      -1051918335: SBJobbra := False;
      end;
    end;
  end;

  function KisXKorr(X : Integer) : Integer;
  begin
    if Bitmap.Width < SBMeret.X then
      Result := X - Trunc((SBMeret.X - Bitmap.Width) / 2) + 2
    else
      Result := X;
  end;

  function KisYKorr(Y : Integer) : Integer;
  begin
    if Bitmap.Height < SBMeret.Y then
      Result := Y - Trunc((SBMeret.Y - Bitmap.Height) / 2) + 2
    else
      Result := Y;
  end;

  procedure TMainForm.FormCreate(Sender: TObject);
  var
    MemInfo : TMemoryStatus;
    Status : Integer;
    VRes : Integer; // képernyõ függõleges mérete pixelben (pl. 1080)
    VSize : Integer; // fizikai méret mm-ben (pl. 334)
    Str : String;
    I : Byte;
  begin
    InitVariables;

    Status := IniFile.ReadInteger('Ablak', 'Allapot', 0);
    if Status <> 0 then begin
      Top    := IniFile.ReadInteger('Ablak', 'Fent',      Top);
      Left   := IniFile.ReadInteger('Ablak', 'Baloldal',  Left);
      Width  := IniFile.ReadInteger('Ablak', 'Szelesseg', Width);
      Height := IniFile.ReadInteger('Ablak', 'Magassag',  Height);
      case Status of
      1: WindowState := wsNormal;
      2: PostMessage(MainForm.Handle, wm_SysCommand, sc_Minimize, 0);
      3: WindowState := wsMaximized;
      end;
    end;

    // Screen.PixelsPerinch = 96
    // Screen.DesktopHeight = 1080
    // GetSystemMetrics( SM_CXSCREEN ) = 2560
    VRes := GetDeviceCaps(self.Canvas.Handle, VERTRES);
    VSize := GetDeviceCaps(self.Canvas.Handle, VERTSIZE);

    TRY
      PPI := Convert('mm', 'in', VSize);
      PPI := VRes / PPI;
    EXCEPT
      PPI := 96;
    END;

    EgysegCB.ItemIndex := IniFile.ReadInteger('Egyseg', 'Egyseg', 0);
    Egyseg := EgysegCB.ItemIndex;

    PPI := Trunc(96 * Screen.Height / 768);
    if PPI < 90 then
      WindowState := wsMaximized;

    AssignFile(DebugFile, 'debug1.log');
    Rewrite(DebugFile);
    Writeln(DebugFile, 'PPI: ', Format('%g', [PPI]));
    CloseFile(DebugFile);

    Screen.Cursors[CR_ZOOMIN]   := LoadCursor(HInstance, 'ZOOMIN');
    Screen.Cursors[CR_ZOOMOUT]  := LoadCursor(HInstance, 'ZOOMOUT');
    Screen.Cursors[CR_CROP]     := LoadCursor(HInstance, 'CROP'); // + alakú kurzor
    Screen.Cursors[CR_PENCIL]   := LoadCursor(HInstance, 'PENCIL');
    Screen.Cursors[CR_ERASER]   := LoadCursor(HInstance, 'ESASER');
    Screen.Cursors[CR_MOVEFROM] := LoadCursor(HInstance, 'MOVEFROM'); // X alakú kurzor - mozgatás kezdõpontja / távolságmérésnél kezdõ és végpont kijelölése
    Screen.Cursors[CR_MOVETO]   := LoadCursor(HInstance, 'MOVETO');
    Screen.Cursors[CR_MEASURE]  := LoadCursor(HInstance, 'MEASURE');

    Bitmap := TBitmap.Create;
    Bitmap.PixelFormat := pf4bit;
    Bitmap.Width := Abra.Width;
    Bitmap.Height := Abra.Height;

    for I := 0 to High(UNITS) do begin
      EgysegCB.Items.Add(UNITS[I].Name);
    end;
    EgysegCB.ItemIndex := 0;

    Abra.Picture.Graphic := Bitmap;
    OrigoX := Trunc(Abra.Width / 2);
    OrigoY := Trunc(Abra.Height / 2);
    Fenntop := 0;
    Lenntop := 0;
    Baltop := 0;
    Jobbtop := 0;
    Lupe := False;
    SzelesEd.Text := '';
    MagasEd.Text := '';
    Lapszeles.Text := '';
    Lapmagas.Text := '';
    FormPos1.x := Left;
    FormPos1.y := Top;
    UjForm := TSettingsForm.Create(Application);
    UjForm.Top := Top+24+(ClientHeight-ScrollBox1.Height);
    UjForm.Left := Left+5;

    Lapx[0,0] := 1189;Lapy[0,0] := 841;
    Lapx[1,0] := 841;Lapy[1,0] := 594;
    Lapx[2,0] := 594;Lapy[2,0] := 420;
    Lapx[3,0] := 420;Lapy[3,0] := 297;
    Lapx[4,0] := 297;Lapy[4,0] := 210;
    Lapx[5,0] := 210;Lapy[5,0] := 148.5;

    Lapx[0,1] := 118.9;Lapy[0,1] := 84.1;
    Lapx[1,1] := 84.1;Lapy[1,1] := 59.4;
    Lapx[2,1] := 59.4;Lapy[2,1] := 42;
    Lapx[3,1] := 42;Lapy[3,1] := 29.7;
    Lapx[4,1] := 29.7;Lapy[4,1] := 21;
    Lapx[5,1] := 21;Lapy[5,1] := 14.85;

    Lapx[0,2] := 46.811;Lapy[0,2] := 33.110;
    Lapx[1,2] := 33.110;Lapy[1,2] := 23.386;
    Lapx[2,2] := 23.386;Lapy[2,2] := 16.535;
    Lapx[3,2] := 16.535;Lapy[3,2] := 11.693;
    Lapx[4,2] := 11.693;Lapy[4,2] := 8.268;
    Lapx[5,2] := 8.268;Lapy[5,2] := 5.827;

    Lapx[0,3] := 46811;Lapy[0,3] := 33110;
    Lapx[1,3] := 33110;Lapy[1,3] := 23386;
    Lapx[2,3] := 23386;Lapy[2,3] := 16535;
    Lapx[3,3] := 16535;Lapy[3,3] := 11693;
    Lapx[4,3] := 11693;Lapy[4,3] := 8268;
    Lapx[5,3] := 8268;Lapy[5,3] := 5827;

    Lx := Lapx[3,3];
    Ly := Lapy[3,3];

    SaveDialog1.InitialDir := ApplDir;
    Application.OnMessage := AppMessage;
  end;

  procedure TMainForm.AbraMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    if Button = mbLeft then begin
      case Abra.Cursor of
      CR_MOVETO:
        begin
          Abra.Cursor := crDefault;
          masik.X := ValosX(X);
          masik.Y := ValosY(Y);
          origomas := True;
          OMoveX := OMoveX - masik.x + egyik.x;
          OMoveY := OMoveY - masik.y + egyik.y;
          KozepreBtn.Enabled := True;
          FrissitClick(MozgatBtn);
        end;
      CR_MEASURE:
        begin
          Abra.Canvas.Pen.Mode := pmNotXor;
          Abra.Canvas.Pen.Color := clBlack;

          if VanMeres then begin
            StatusBar3.Visible := False;
            MeresTorles(Abra.Canvas);
          end;
          StartPoint.X := KisXKorr(X);
          StartPoint.Y := KisYKorr(Y);
          EndPoint.X := KisXKorr(X);
          EndPoint.Y := KisYKorr(Y);

          Abra.Canvas.Moveto(EndPoint.X - 7,EndPoint.Y - 7);
          Abra.Canvas.Lineto(EndPoint.X + 7,EndPoint.Y + 7);
          Abra.Canvas.Moveto(EndPoint.X + 7,EndPoint.Y - 7);
          Abra.Canvas.Lineto(EndPoint.X - 7,EndPoint.Y + 7);
        end;
      CR_MOVEFROM:
        begin
          egyik.x := ValosX(X);
          egyik.y := ValosY(Y);

          Abra.Cursor := CR_MOVETO;
          Abra.Canvas.Moveto(KisXKorr(X) - 5,KisYKorr(Y) - 5);
          Abra.Canvas.Lineto(KisXKorr(X) + 5,KisYKorr(Y) + 5);
          Abra.Canvas.Moveto(KisXKorr(X) + 5,KisYKorr(Y) - 5);
          Abra.Canvas.Lineto(KisXKorr(X) - 5,KisYKorr(Y) + 5);
        end;
      CR_ZOOMOUT:
        begin
          Lupe := True;
          PrevZoom := Zoom;
          StartPoint.X := X;
          StartPoint.y := Y;
          Zoom := Trunc(Zoom/2);
          Abra.Cursor := crDefault;
          Zoomol := True;
          FrissitClick(KicsinyitBtn);
          Exit;
        end;
      CR_ZOOMIN, CR_CROP:
        begin
          Rajzol := True;
          PrevZoom := Zoom;
          StartPoint.X := X;
          StartPoint.y := Y;
          ZoomShape.Top := Y - ScrollBox1.VertScrollBar.Position;
          ZoomShape.Left := X - ScrollBox1.HorzScrollBar.Position;
          ZoomShape.Width := 1;
          ZoomShape.Height := 1;
        end
      else
        if not Elso then begin
          Abra.Canvas.Pen.Mode := pmCopy;
          SetCursor(Screen.Cursors[CR_PENCIL]);

          if ssCtrl in Shift then begin
            StartPoint.X := KisXKorr(X);
            StartPoint.Y := KisYKorr(Y);
            EndPoint.x := KisXKorr(X);
            EndPoint.Y := KisYKorr(Y);
            Egyenes := True;
          end else if ssShift in Shift then
            SetCursor(Screen.Cursors[CR_ERASER]);

          Abra.Canvas.Moveto(KisXKorr(x),KisYKorr(y));
          Rajzol := True;
        end;
      end;
    end;
  end;

  procedure TMainForm.AbraMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  var Curpos, Curpos2: TPoint;
      o,i: Byte;
      m: TPoint;
  begin
    if ssLeft in Shift then begin
      if (Abra.Cursor = CR_ZOOMIN) or (Abra.Cursor = CR_CROP) then begin
        if Rajzol then begin
          ZoomShape.Width := Abs(X - StartPoint.X);
          ZoomShape.Height := Abs(Y - StartPoint.y);
          ZoomShape.Visible := True;

          if Y < StartPoint.y then
            ZoomShape.Top := Y - ScrollBox1.VertScrollBar.Position;
          if X < StartPoint.X then
            ZoomShape.Left := X - ScrollBox1.HorzScrollBar.Position;

          GetCursorPos(Curpos);
          Curpos := ScrollBox1.ScreenToClient(Curpos);

          if Curpos.y < 1 then begin
            Curpos.y := 1;
            Curpos2 := ScrollBox1.ClientToScreen(Curpos);
            SetCursorPos(Curpos2.x, Curpos2.y);
            ScrollBox1.VertScrollbar.Position := ScrollBox1.VertScrollbar.Position - 1;
          end else if Curpos.x < 1 then begin
            Curpos.X := 1;
            Curpos2 := ScrollBox1.ClientToScreen(Curpos);
            SetCursorPos(Curpos2.x, Curpos2.y);
            ScrollBox1.HorzScrollbar.Position := ScrollBox1.HorzScrollbar.Position - 1;
          end else if Curpos.x > ScrollBox1.Width - 16 then begin
            Curpos.X := ScrollBox1.Width - 16;
            Curpos2 := ScrollBox1.ClientToScreen(Curpos);
            SetCursorPos(Curpos2.x, Curpos2.y);
            ScrollBox1.HorzScrollbar.Position := ScrollBox1.HorzScrollbar.Position + 1;
          end else if Curpos.y>ScrollBox1.Height-16 then begin
            Curpos.y := ScrollBox1.Height - 16;
            Curpos2 := ScrollBox1.ClientToScreen(Curpos);
            SetCursorPos(Curpos2.x, Curpos2.y);
            ScrollBox1.VertScrollbar.Position := ScrollBox1.VertScrollbar.Position + 1;
          end;
        end;
      end else begin
        if Abra.Cursor = CR_MEASURE then begin
          Abra.Canvas.Pen.Mode := pmNotXor;

          Abra.Canvas.Moveto(StartPoint.X,StartPoint.y);
          Abra.Canvas.Lineto(EndPoint.x,EndPoint.y);

          EndPoint.x := KisXKorr(X);
          EndPoint.y := KisYKorr(y);

          Abra.Canvas.Moveto(StartPoint.X,StartPoint.y);
          Abra.Canvas.Lineto(EndPoint.x, EndPoint.y);
        end else if Rajzol then begin
          if ssShift in Shift then begin
            // Radírozás
            m.x := KisXKorr(X);
            m.y := KisYKorr(Y);

            if Abra.Cursor <> CR_ERASER then
              SetCursor(Screen.Cursors[CR_ERASER]);

            Abra.Canvas.Moveto(m.x, m.y);
            for o := 0 to 14 do begin
              for i := 0 to 14 do begin
                if Abra.Canvas.Pixels[m.x + i - 7, m.y + o - 7] = clNavy then
                  if OptionsForm.Lapmilyen.ItemIndex = 0 then
                    Abra.Canvas.Pixels[m.x + i - 7, m.y + o - 7] := clWhite
                  else if (ValosX(m.x + i - 7) < Lx / 2) and (ValosX(m.x + i - 7) > -Lx / 2)
                  and (ValosY(m.y + o - 7) < Ly / 2) and (ValosY(m.y + o - 7) > -Ly / 2) then
                    Abra.Canvas.Pixels[m.x+i-7,m.y+o-7] := clLtGray
                  else
                    Abra.Canvas.Pixels[m.x+i-7,m.y+o-7] := clWhite;
              end
            end
          end else begin
            // Rajzolás a canvasra
            if Abra.Cursor <> CR_PENCIL then
              SetCursor(Screen.Cursors[CR_PENCIL]);

            Abra.Canvas.Pen.Width := 1;
            Abra.Canvas.Pen.Color := clNavy;
            if Egyenes then begin
              Abra.Canvas.Pen.Mode := pmNotXor;

              Abra.Canvas.Moveto(StartPoint.X,StartPoint.y);
              Abra.Canvas.Lineto(EndPoint.x,EndPoint.y);

              Abra.Canvas.Moveto(StartPoint.X,StartPoint.y);
            end;
            EndPoint.x := KisXKorr(X);
            EndPoint.y := KisYKorr(Y);
            Abra.Canvas.Lineto(KisXKorr(x),KisYKorr(y));
          end;
        end;
      end;
    end;

    if not Elso then begin
      StatusBar2.Panels[0].Text := 'x: '+ IntToStr(Trunc(Convert(INCHUNIT, Egyseg, -lapmovex + ValosX(KisXKorr(X))))) + ' ' + UNITS[Egyseg].Code;
      StatusBar2.Panels[1].Text := 'y: '+ IntToStr(Trunc(Convert(INCHUNIT, Egyseg, -lapmovey + ValosY(KisYKorr(Y))))) + ' ' + UNITS[Egyseg].Code;
    end;
  end;

  procedure TMainForm.AbraMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var Meminfo: TMemoryStatus;
      Maxbmp: Integer;
  begin
    if Button = mbLeft then begin
      Rajzol := False;
      if Egyenes then begin
        Abra.Canvas.Moveto(StartPoint.X, StartPoint.y);
        Abra.Canvas.Lineto(EndPoint.x, EndPoint.y);

        Abra.Canvas.Pen.Mode := pmCopy;
        Abra.Canvas.Moveto(StartPoint.X, StartPoint.y);
        Abra.Canvas.Lineto(X, Y);
      end;
      Egyenes := False;

      if (Abra.Cursor = CR_ZOOMIN) or (Abra.Cursor = CR_CROP) then begin
        ZoomShape.Visible := False;
        NagyitBtn.Down := False;

        if (ZoomShape.Width > 50) or (ZoomShape.Height > 50) or (Crop) then begin
          if Abra.Cursor = CR_ZOOMIN then begin
            if ScrollBox1.Width / ZoomShape.Width < ScrollBox1.Height / ZoomShape.Height then
              Zoom := Trunc(Zoom * ScrollBox1.Width / ZoomShape.Width)
            else
              Zoom := Trunc(Zoom * ScrollBox1.Height / ZoomShape.Height);

            Meminfo.dwLength := Sizeof(Meminfo);
            GlobalMemoryStatus(Meminfo);
            Maxbmp := Trunc(0.3 * (Bitmap.Width * Bitmap.Height + 2 * (MemInfo.dwAvailPhys + MemInfo.dwAvailPageFile)));

            if sqr(Zoom / PrevZoom) * Bitmap.Width * Bitmap.Height > Maxbmp then
              Zoom := Trunc(PrevZoom * sqrt(Maxbmp / Bitmap.Width / Bitmap.Height));
            if Zoom / PrevZoom * Bitmap.Width > 5000 then
              Zoom := Trunc(PrevZoom * 5000 / Bitmap.Width);

            Zoomol := True;
            Lupe := True;
          end;

          if Bitmap.Width > ScrollBox1.Width - 5 then
            StartPoint.X := ScrollBox1.HorzScrollBar.Position + ZoomShape.Left + Trunc(ZoomShape.Width / 2)
          else
            StartPoint.X := ZoomShape.Left + Trunc(ZoomShape.Width / 2) - Trunc((ScrollBox1.Width - Bitmap.Width) / 2);

          if Bitmap.Height > ScrollBox1.Height - 5 then
            StartPoint.y := ScrollBox1.VertScrollBar.Position + ZoomShape.Top + Trunc(ZoomShape.Height / 2)
          else
            StartPoint.y := ZoomShape.Top + Trunc(ZoomShape.Height / 2) - Trunc((ScrollBox1.Height - Bitmap.Height) / 2);

          if Abra.Cursor = CR_CROP then begin
            Crop := True;
            origomas := False;
            Teljes.Enabled := True;
            TeljesBtn.Enabled := True;
            CropScrollHorz := ScrollBox1.HorzScrollBar.Position;
            CropScrollVert := ScrollBox1.VertScrollBar.Position;
            Baltop  := ValosX(StartPoint.X - ZoomShape.Width div 2) + OMoveX;
            Jobbtop := ValosX(StartPoint.X + ZoomShape.Width div 2) + OMoveX;
            Lenntop := ValosY(StartPoint.y + ZoomShape.Height div 2) + OMoveY;
            Fenntop := ValosY(StartPoint.y - ZoomShape.Height div 2) + OMoveY;
          end;

          FrissitClick(Segedshape);
        end;

        Abra.Cursor := crDefault;
        ZoomShape.Width := 1;
        ZoomShape.Height := 1;
        Zoomol := False;
        Exit;
      end else if Abra.Cursor = CR_MOVEFROM then begin
        Abra.Canvas.Moveto(StartPoint.X, StartPoint.y);
        Abra.Canvas.Lineto(EndPoint.x, EndPoint.y);

        Abra.Canvas.Moveto(StartPoint.X, StartPoint.y);
        Abra.Canvas.Lineto(KisXKorr(X), KisYKorr(Y));

        Abra.Canvas.Moveto(KisXKorr(X) - 7, KisYKorr(Y) - 7);
        Abra.Canvas.Lineto(KisXKorr(X) + 7, KisYKorr(Y) + 7);

        Abra.Canvas.Moveto(KisXKorr(X) + 7, KisYKorr(Y) - 7);
        Abra.Canvas.Lineto(KisXKorr(X) - 7, KisYKorr(Y) + 7);

        StatusBar3.Visible := True;
        StatusBar3.BringToFront;
        StatusBar3.Panels[0].Text := 'A kijelölt távolság: ' +
          Format('%-8.6g', [Convert(INCHUNIT, Egyseg, sqrt(sqr(ValosX(StartPoint.X) - ValosX(X)) + sqr(ValosY(StartPoint.Y) - ValosY(Y))))]) + ' ' + UNITS[Egyseg].Code;

        EndPoint.x := KisXKorr(X);
        EndPoint.y := KisYKorr(Y);
        VanMeres := True;
      end else if Abra.Cursor in [CR_PENCIL,CR_ERASER] then begin
        Abra.Cursor := crDefault;
      end;
    end;
  end; // AbraMouseUp

  procedure TMainForm.FrissitClick(Sender: TObject);
  begin
    Frissites(DRAWMODE);
  end;

  procedure TMainForm.Frissites(Mode : Byte); // 1 - ábra frissítése, 2 - nyomtatás, 3 - plotter fájlba mentés
  var Tatu, margox, margoy, szorzo, progpos: Double;
      MerSurusegFok, ParSurusegFok, SegMerSurusegFok, SegParSurusegFok: Byte;
      Csalad, prog: byte;
      InvalidValue, Ex, sfh: Boolean;

      Ferde : Boolean; // Ferdetengelyû elhelyezés
      KMEszaki : Boolean; // Ferdetengelyû elhelyezésnél a kezdõmeridián az északi póluson megy át

      mike, x2, y2, x1, y1: Integer;
      Vezuv2: Integer;
      q, i, j, loopint: Integer;
      Fi, La, Fc, Lc, Fca, Lca, Fcb, Lcb : Double;

      F0, L0 : Double; // Segédpólus radián
      L0N : Double; // Középmeridián radián

      valos: record
        Width: Integer;
        Height: Integer;
        end;
      Kint: Boolean;
      Meminfo: TMemorystatus;
      FreeMem: Byte;

      MaxBmp: Integer;
      NewBmpSize: Integer;

      minfi: Integer;
      n, ce, betan, beta1, beta2, beta0: Double;
      fil1, fil2, fil3: file of Byte;

    procedure Elsotop;
    begin
      if q = 0 then begin
        Jobbtop := x2;
        Baltop := x2;
        Fenntop := y2;
        Lenntop := y2;
      end;
      q := q + 1;
    end;

    procedure Topvizsgalo;
    begin
      if x2 < Baltop  then Baltop  := x2;
      if x2 > Jobbtop then Jobbtop := x2;
      if y2 < Lenntop then Lenntop := y2;
      if y2 > Fenntop then Fenntop := y2;
    end;

    procedure Szinado(SzinCB: TCombobox);
    var Szin: TColor;
    begin
      Szin := clBlack;
      case SzinCB.ItemIndex of
      0: Szin := clBlack;
      1: Szin := clBlue;
      2: Szin := clRed;
      3: Szin := clGreen;
      4: Szin := clPurple;
      5: Szin := clYellow;
      6: Szin := clAqua;
      7: Szin := clMaroon;
      8: Szin := clGray;
      end;

      case Mode of
      PRINTMODE:
        Printer.Canvas.Pen.Color := Szin;
      PLTMODE:
        writeln(Filesv, 'sp', SzinCB.ItemIndex + 1, ';');
      else
        Bitmap.Canvas.Pen.Color := Szin
      end;
    end;

    procedure Vastagado(Vastagsag : Byte);
    begin
      if Mode = PRINTMODE then
        Printer.Canvas.Pen.Width := Vastagsag
      else if Mode <> PLTMODE then
        Bitmap.Canvas.Pen.Width := Vastagsag;
    end;

    procedure Tatuado(GB: Byte);
    begin
      case GB of
      0: Tatu := 1/12;
      1: Tatu := 1/6;
      2: Tatu := 1/3;
      3: Tatu := 1/2;
      4: Tatu := 1;
      5: Tatu := 2;
      6: Tatu := 3;
      7: Tatu := 5;
      end;
    end;

    function printerrex(par: Integer): Integer;
    begin
      result := Trunc(par * Printer.PageWidth / Lx + Printer.PageWidth / 2);
    end;

    function printerrey(par: Integer): Integer;
    begin
      result := Trunc(Printer.PageHeight / 2 - par * Printer.PageWidth / Lx);
    end;

    function keprex(par: Integer): Integer;
    begin
      result := Trunc(par * PPI * Zoom / 100000) + OrigoX;
    end;

    function keprey(par: Integer): Integer;
    begin
      result := OrigoY - Trunc(par * PPI * Zoom / 100000);
    end;

    procedure seged(ff, ll : Double; var fc2, lc2 : Double);
    var w : Double;
    begin
      TRY
        fc2 := arcsin(sin(F0) * sin(ff) + cos(F0) * cos(ff) * cos(ll - L0));
        if abs(cos(F0)) < 1.0e-8 then begin
          if Almost(F0, Pi / 2) then begin
            lc2 := ll - L0;
            fc2 := ff;
            if lc2 < -Pi then
              lc2 := lc2 + 2 * Pi * (Trunc(-180 / Pi * lc2 + 180) div 360);
            if lc2 > Pi then
              lc2 := lc2 - 2 * Pi * (Trunc(180/ Pi * lc2 + 180) div 360);
          end else begin
            lc2 := -ll + L0;
            fc2 := -ff;
            if lc2 < -Pi then lc2 := lc2 + 2 * Pi * (Trunc(-180 / Pi * lc2 + 180) div 360);
            if lc2 > Pi then lc2 := lc2 - 2 * Pi * (Trunc(180 / Pi * lc2 + 180) div 360);
          end
        end else begin
          if abs(cos(fc2)) < 1.0e-8 then
            lc2 := L0
          else if abs(sin(ll - L0)) < 1.0e-8 then begin
            if ((ff < F0) and (ll = L0)) or ((ff <= -F0) and (abs(ll - L0) = Pi)) then begin
              if KMEszaki then
                lc2 := (ll + 0.00001) / abs(ll + 0.00001) * Pi
              else
                lc2 := 0
            end else if KMEszaki then
              lc2 := 0
            else lc2 := (ll + 0.00001) / abs(ll + 0.00001) * Pi;
          end else begin
            w := cos(F0) * cos(fc2);
            if abs((sin(ff) - sin(F0) * sin(fc2)) / w) > 1 then begin
              lc2 := Pi / 4;
            end else begin
              lc2 := arccos((sin(ff) - sin(F0) * sin(fc2)) / w);
              lc2 := -(sin(ll - L0) / abs(sin(ll - L0))) * abs(lc2);
            end;
            if not KMEszaki then
              lc2 := -lc2 / abs(lc2) * (Pi - abs(lc2));
          end;
        end;
      EXCEPT
        ON EInvalidOp DO BEGIN
          lc2 := 1;
          fc2 := 1;
        END;
      END;
    end; // procedure seged

    procedure mozgat(x, y: Integer);
    begin
      case Mode of
      PRINTMODE :
        Printer.Canvas.Moveto(printerrex(x - OMoveX), printerrey(y - OMoveY));
      PLTMODE :
        writeln(Filesv, 'pu ', x - OMoveX, ' ', y - OMoveY, ';');
      else
        Bitmap.Canvas.Moveto(keprex(x - KoMoveX),keprey(y - KoMoveY))
      end;
    end;

    procedure ir(x, y : Integer);
    begin
      case Mode of
      PRINTMODE :
        Printer.Canvas.Lineto(printerrex(x - OMoveX), printerrey(y - OMoveY));
      PLTMODE :
        writeln(Filesv, 'pd ', x - OMoveX, ' ', y - OMoveY, ';');
      else
        Bitmap.Canvas.Lineto(keprex(x - KoMoveX), keprey(y - KoMoveY));
      end;
    end;

    procedure psziszamito(var Pszi : Double);
    var Xa, Xb, B, D: Double;

      function Fv(J : Double) : Double;
      begin
        case AktivVetulet of
        64 : // Területtartó polikónikus
          Fv := J - Sin(j) * Sqr(Cos(Fc)) - Lc * Sin(Fc) * Sqr(Sin(Fc));
        83 : // Eckert VI.
          Fv := 0.777969059 * (J + Sin(j)) - 2 * Sin(Fc);
        85, 89, 90 : // Mollweide-féle, Érdi-Krausz-féle, Goode-féle vetület
          Fv := 2 * J + Sin(2 * J) - Pi * Sin(Fc);
        87 : // Eckert IV.
          Fv := 4 * Sin(J) + Sin(2 * J) + 2 * J - (4 + Pi) * Sin(Fc);
        end;
      end;

    begin // psziszamito
      Xa := 1;
      Xb := 0;

      repeat
        B := 10;
        D := 10;

        while Fv(Xa) = Fv(Xb) do begin
          D := D / 10;
          B := B * 10;
          N := 1;

          repeat
            Xb := Xb + D;
            N := N + 1;
          until (Fv(Xb) <> Fv(Xb)) or (N > B);
        end;

        Pszi := (Fv(Xa) * Xb - Fv(Xb) * Xa) / (Fv(Xa) - Fv(Xb));
        Xa := Xb;
        Xb := Pszi;
      until (Abs(Xb - Xa) < 1.0e-9) or (Fv(Pszi) = 0);
    end; // procedure psziszamito

    procedure inicializalo;
    begin
      case AktivVetulet of
      20 : // Ptolemaiosz-féle
        begin
          betan := Arcus(fin);
          n := cos(betan);
        end;
      21 : // De l'Isle-féle
        begin
          beta1 := Arcus(fi1);
          beta2 := Arcus(fi2);
          beta0 := (beta1 + beta2) / 2;
          n := cos(beta0) * sin(beta1 - beta0) / (beta1 - beta0);
        end;
      22 : // Szögtartó és egy paralelkörben hossztartó
        begin
          betan := Arcus(fin);
          n := cos(betan);
          ce := tan(betan) / exp(n * ln(tan(betan / 2)));
        end;
      23 : // Lambert-Gauss-féle
        begin
          beta1 := Arcus(fi1);
          beta2 := Arcus(fi2);
          n := (ln(sin(beta1)) - ln(sin(beta2))) / (ln(tan(beta1 / 2)) - ln(tan(beta2 / 2)));
          ce := sin(beta1) / n / exp(n * ln(tan(beta1 / 2)));
        end;
      24 : // Albers-féle
        begin
          beta1 := Arcus(fi1);
          beta2 := Arcus(fi2);
          n := (cos(beta1) + cos(beta2)) / 2;
          ce := sqr(2 / n * sin(beta1 / 2) * sin(beta2 / 2));
        end;
      25 : // Területtartó és egy paralelkörben hossztartó
        begin
          betan := Arcus(fin);
          n := cos(betan);
          ce := sqr(2 / n * sqr(sin(betan / 2)));
        end;
      26 : // Lambert-féle
        begin
          betan := Arcus(fin);
          n := sqr(cos(betan / 2));
          ce := 0;
        end;
      27 : // Perspektív
        begin
          beta1 := Arcus(fi1);
          beta2 := Arcus(fi2);
          if fi1 = 0 then begin
            ce := 1;
            betan := Pi / 2 - beta2 / 2;
          end else if fi2 = 0 then begin
            ce := 1;
            betan := Pi / 2 - beta1 / 2;
          end else if fi1 = fi2 then begin
            ce := 1 / cos(beta1);
            betan := Pi / 2 - beta1;
          end else begin
            ce := (sin(beta2) * cos(beta1) - sin(beta1) * cos(beta2)) / (sin(beta2) - sin(beta1));
            betan := arctan(sin(beta1) / (ce - cos(beta1)));
          end;
          n := sin(betan);
        end;

    41,43,45,46: betan := arcus(fin);
    60:ce := arcus(fin)+cotan(arcus(fin));
    61:ce := Pi/2;
    69:begin
        ce := fia;
        betan := -arcus(fik);
       end;
    107: betan := arcus(fin);
    end;
    if AktivVetulet in [27,46] then
      if ParametersForm1.Iranybox.ItemIndex=0 then beta0 := fia else beta0 := -fia;
   end;

   procedure vetites(var aX,aY:integer);
   var p, beta, bX, bY, pszi, aa, bb, cc, gg, pp, qq, ss, tt: Double;
   begin
    if not Ferde then begin
      Lc := Lc - L0N;
      if Lc < -Pi then
        Lc := Lc + 2 * Pi * (Trunc(-180 / Pi * Lc + 180) div 360);
      if Lc > Pi then
        Lc := Lc - 2 * Pi * (Trunc(180 / Pi * Lc + 180) div 360);
    end;

    beta := Pi / 2 - Fc;
    p := beta;
    case Csalad of
    0 : begin
       case AktivVetulet of
       0: p := beta;
       1: p := 2*sin(beta/2);
       2: p := 2*tan(beta/2);
       3: p := tan(beta);
       4: p := sin(beta);
       end;
        aX := Trunc(p*sin(Lc)*EARTHRADIUS/1000/Scale);
        aY := -Trunc(p*cos(Lc)*EARTHRADIUS/1000/Scale);
      end;
    1:begin
       case AktivVetulet of
       20: p := tan(betan)+beta-betan;
       21: p := tan(beta0)/tan(beta1-beta0)*(beta1-beta0)+beta-beta0;
       22,23: p := ce*exp(n*ln(tan(beta/2)));
       24,25: p := sqrt(4/n*sqr(sin(beta/2))+ce);
       26: p := sin(beta/2)/sqrt(n);
       27:begin
           if ParametersForm1.VegtelenChk.Checked then p := sin(beta)/sin(betan)
           else p := (ce+beta0)*sin(beta)/(beta0*sin(betan)+sin(betan+beta));
          end;
       end;
       aX := Trunc(p*sin(n*Lc)*EARTHRADIUS/1000/Scale);
       aY := -Trunc(p*cos(n*Lc)*EARTHRADIUS/1000/Scale);
      end;
    2:begin
       case AktivVetulet of
       40: begin
            bX := Lc;
            bY := Fc;
           end;
       41: begin
            bX := Lc*cos(betan);
            bY := Fc;
           end;
       42: begin
            bX := Lc;
            bY := sin(Fc);
           end;
       43: begin
            bX := Lc*cos(betan);
            bY := sin(Fc)/cos(betan);
           end;
       44: begin
            bX := Lc;
            bY := ln(tan(Fc/2+Pi/4));
           end;
       45: begin
            bX := Lc*cos(betan);
            bY := cos(betan)*ln(tan(Fc/2+Pi/4));
           end;
       46: begin
            bX := Lc*cos(betan);
            bY := (beta0*cos(betan)*(1-cos(Fc))+sin(Fc)*cos(betan))/cos(Fc);
           end;
       end;
       aX := Trunc(bX*EARTHRADIUS/1000/Scale);
       aY := Trunc(bY*EARTHRADIUS/1000/Scale);
      end;
    3:begin
       case AktivVetulet of
       60:begin
           p := ce-Fc;
           n := cos(Fc)/p*Lc;
           bX := p*sin(n);
           bY := ce-p*cos(n);
          end;
       61:begin
           p := ce-Fc;
           if p<0.001 then n := 0 else n := cos(Fc)/p*Lc;
           bX := p*sin(n);
           bY := ce-p*cos(n);
          end;
       62:begin
           if Fc=0 then
            begin
             bX := Lc;
             bY := 0
            end
           else
            begin
             p := cotan(Fc);
             n := Lc*sin(Fc);
             bX := sin(n)*cotan(Fc);
             bY := fia*Fc+(1-cos(n))*cotan(Fc);
            end;
          end;
       63:begin
           if Fc=0 then
            begin
             bX := Lc;
             bY := 0;
            end
           else
            begin
             n := 2*arctan(Lc/2*sin(Fc));
             p := cotan(Fc);
             bX := sin(n)*p;
             bY := fia*Fc+(1-cos(n))*p;
            end;
          end;
       64:begin
           qq := Fc;
           if abs(Fc)<0.02 then Fc := 0.001;
           psziszamito(n);
           p := cotan(Fc);
           bX := sin(n)*p;
           bY := fia*Fc+(1-cos(n))*p;
           Fc := qq;
          end;
       65:begin
           if Fc=0 then
            begin
             bX := 2*tan(Lc/2);
             bY := 0;
            end
           else
            begin
             n := 2*arctan(tan(Fc/2)*tan(Lc/2));
             p := cotan(Fc);
             bX := sin(n)*p;
             bY := 1/sin(Fc)-p*cos(n);
            end;
          end;
       66:begin
           bb := abs(2*Fc/Pi);
           cc := sqrt(1-sqr(bb));
           if abs(Fc)<0.001 then
            begin
             bX := Lc;
             bY := 0;
            end
           else
           if abs(Lc)<0.001 then
            begin
             bX := 0;
             bY := sgn(Fc)*Pi*bb/(1+cc);
            end
           else
           if Pi/2-abs(Fc)<0.001 then
            begin
             bX := 0;
             bY := sgn(Fc)*Pi;
            end
           else
            begin
             aa := abs(Pi/Lc-Lc/Pi)/2;
             gg := cc/(bb+cc-1);
             pp := gg*(2/bb-1);
             qq := sqr(aa)+gg;
             ss := sqr(pp)+sqr(aa);
             tt := gg-sqr(pp);
             bX := sgn(Lc)*Pi*(aa*tt+sqrt(sqr(aa*tt)-ss*(sqr(gg)-sqr(pp))))/ss;
             bY := sgn(Fc)*Pi*(pp*qq-aa*sqrt(ss*(sqr(aa)+1)-sqr(qq)))/ss;
            end;
          end;
       67:begin
           bb := abs(2*Fc/Pi);
           cc := sqrt(1-sqr(bb));
           if abs(Lc)<0.001 then
            begin
             bX := 0;
             bY := sgn(Fc)*Pi*bb/(1+cc);
            end
           else
            begin
             aa := abs(Pi/Lc-Lc/Pi)/2;
             gg := (cc*sqrt(1+sqr(aa))-aa*sqr(cc))/(1+sqr(aa*bb));
             bX := sgn(Lc)*Pi*gg;
             bY := sgn(Fc)*Pi*sqrt(1-sqr(gg)-2*aa*gg);
            end;
          end;
       68:begin
             if abs(Fc)<0.001 then
              begin
               bX := Lc;
               bY := 0;
              end
             else
             if (abs(Lc)<0.001) or (Pi/2-abs(Fc)<0.001) then
              begin
               bX := 0;
               bY := Fc;
              end
             else
              begin
               bb := abs(2*Fc/Pi);
               cc := (8*bb-sqr(sqr(bb))-2*sqr(bb)-5)/(2*sqr(bb)*bb-2*sqr(bb));
               gg := sgn(abs(Lc)-Pi/2)*sqrt(sqr(2*Lc/Pi+Pi/2/Lc)-4);
               pp := sqr(bb+cc)*(sqr(bb)+sqr(cc*gg)-1)+(1-sqr(bb))*(sqr(bb)*
                 (sqr(bb+3*cc)+4*sqr(cc))+12*bb*sqr(cc)*cc+4*sqr(sqr(cc)));
               qq := (gg*(sqr(bb+cc)+sqr(cc)-1)+2*sqrt(pp))/(4*(sqr(bb+cc))+sqr(gg));
               bX := sgn(Lc)*Pi*qq/2;
               bY := sgn(Fc)*Pi/2*sqrt(1+gg*abs(qq)-sqr(qq));
              end;
          end;
       69:begin
           if Pi/2-abs(Fc)<0.001 then
            begin
             bX := 0;
             bY := 2*sgn(Fc);
            end
           else
            begin
             aa := exp((1/2/ce)*ln((1+sin(betan))/(1-sin(betan))));
             bb := exp((1/2/ce)*ln((1+sin(Fc))/(1-sin(Fc))));
             gg := aa*bb;
             cc := (gg+1/gg)/2+cos(Lc/ce);
             bX := 2*sin(Lc/ce)/cc;
             bY := (gg-1/gg)/cc;
            end;
          end;
       70:begin
             if abs(Lc)<0.001 then
              begin
               bX := 0;
               bY := Fc;
              end
             else
             if abs(Fc)<0.001 then
              begin
               bX := Lc;
               bY := 0;
              end
             else
             if abs(Pi/2-abs(Lc))<0.001 then
              begin
               bX := Lc*cos(Fc);
               bY := Pi/2*sin(Fc);
              end
             else
              begin
               cc := 2.4674011;
               pp := abs(Pi*sin(Fc));
               ss := (cc-sqr(Fc))/(pp-2*abs(Fc));
               aa := sqr(Lc)/cc-1;
               bY := sgn(Fc)*(sqrt(sqr(ss)-aa*(cc-pp*ss-sqr(Lc)))-ss)/aa;
               bX := sgn(Lc)*abs(Lc)*sqrt(1-sqr(bY)/cc);
              end;
          end;
       end;
       aX := Trunc(bX*EARTHRADIUS/1000/Scale);
       aY := Trunc(bY*EARTHRADIUS/1000/Scale);
      end;
    4:begin
       case AktivVetulet of
       80: begin
            bX := cos(Fc)*Lc;
            bY := Fc;
           end;
       81: begin
            bX := 0.877382675*Lc*sqrt(1-0.75*sqr(sin(Fc)));
            bY := 1.316074013*arcsin(0.866025404*sin(Fc));
           end;
       82: begin
            bX := 0.882025543*Lc*(cos(Fc)+1)/2;
            bY := 0.882025543*Fc;
           end;
       83: begin
            psziszamito(pszi);
            bX := 0.882025543*Lc*(cos(pszi)+1)/2;
            bY := 0.882025543*pszi;
           end;
       84: begin
            bY := Fc;
            bX := 1-4*sqr(Fc/Pi);
            if bX<=0 then bX := 0 else bX := Lc*sqrt(bX);
           end;
       85: begin
            psziszamito(pszi);
            bX := 0.900316316*Lc*cos(pszi);
            bY := 1.414213562*sin(pszi);
           end;
       86: begin
            bX := 1-4*sqr(Fc/Pi);
            if bX<=0 then bX := Lc/2 else bX := 0.4222382*Lc*(1+sqrt(bX));
            bY := 0.844476401*Fc;
           end;
       87: begin
            psziszamito(pszi);
            bY := 0.844476401*Pi/2*sin(pszi);
            bX := 0.4222382*Lc*(1+cos(pszi));
           end;
       88: begin
            bY := Fc;
            bX := 0.866025404*Lc*sqrt(1-0.303963551*sqr(Fc));
           end;
       89: begin
            if abs(Fc)<arcus(fis) then
             begin
              bX := 0.960415*sqrt(1-0.64*sqr(sin(Fc)))*Lc;
              bY := 1.30152*arcsin(0.8*sin(Fc));
             end
            else
             begin
              psziszamito(pszi);
              if fis<65 then
               begin
                bX := 1.070223*cos(pszi)*Lc;
                bY := 1.681102*sin(pszi)-sgn(Fc)*0.285475;
               end
              else
               begin
                bX := 1.249039*cos(pszi)*Lc;
                bY := 1.961985*sin(pszi)-sgn(Fc)*0.583828;
               end;
             end;
           end;
       90: begin
            if Fc<=0 then
             begin
              if Lc<=arcus(-100) then aa := arcus(-160);
              if (Lc>arcus(-100)) and (Lc<=arcus(-20)) then aa := arcus(-60);
              if (Lc>arcus(-20)) and (Lc<=arcus(80)) then aa := arcus(30);
              if Lc>arcus(80) then aa := arcus(140);
             end
            else
             begin
              if Lc<=arcus(-40) then aa := arcus(-100)
              else aa := arcus(30);
             end;
            if abs(Fc)<=arcus(40.7333) then
             begin
              bX := cos(Fc)*(Lc-aa)+aa;
              bY := Fc;
             end
            else
             begin
              psziszamito(pszi);
              bX := 0.900316316*(Lc-aa)*cos(pszi)+aa;
              bY := 1.414213562*sin(pszi)-sgn(Fc)*0.05280;
             end;
           end;
       91: begin
            bY := sgn(Fc)*(0.95*abs(Fc)+0.9/Pi*sqr(Fc));
            if abs(Fc)<1.221730476 then
             begin
               pszi := arcsin(bY/1.84466);
               bX := Lc/Pi*(Pi-1.84466+1.84466*cos(pszi));
             end
            else
             begin
               pszi := arccos((4.39461-(0.7*Pi-abs(bY)))/4.39461);
               bX := 4.39461*sin(pszi)*Lc/Pi;
             end;
           end;
       92: begin
            bY := 0.0273759*sqr(sqr(Fc))*Fc-0.107505*sqr(Fc)*abs(Fc)*Fc+
              0.112579*sqr(Fc)*Fc+Fc;
            if abs(Fc)<=1.362578547
            then bX := (1.22172+sqrt(2.115393-sqr(bY)))*
              ln(0.11679*abs(Lc)+1)/0.31255*sgn(Lc)
            else bX := sqrt(38.4308-sqr(4.58448+abs(bY)))*
              ln(0.11679*abs(Lc)+1)/0.31255*sgn(Lc);
           end;
       93: begin
            bX := (2.6666-0.3670*sqr(Fc)-0.15*sqr(sqr(Fc))+
              0.0379*sqr(sqr(Fc))*sqr(Fc))*Lc/Pi;
            bY := 0.96047*Fc-0.00857*exp(6.41*ln(abs(Fc)))*sgn(Fc);
           end;
       94: begin
            bY := Fc;
            if (Lc=0) or ((abs(Fc)>arcus(89.9)) and ((fel) or (abs(Lc)<arcus(91)))) then bX := 0
            else
             begin
              p := (sqr(Pi/2)+sqr(Lc))/2/abs(Lc);
              bX := (abs(Lc)-p+sqrt(sqr(p)-sqr(Fc)))*sgn(Lc);
             end;
           end;
       95: begin
            bY := Pi/2*sin(Fc);
            if (abs(Lc)<0.001) or ((abs(Fc)>arcus(89.9)) and ((fel) or (abs(Lc)<arcus(91)))) then bX := 0
            else
             begin
              bb := (sqr(Pi/2)/abs(Lc)+abs(Lc))/2;
              if sqr(bb)>sqr(bY) then gg := sqrt(sqr(bb)-sqr(bY)) else gg := 0;
              bX := sgn(Lc)*(abs(Lc)-bb+gg);
             end;
           end;
       96: begin
            bY := Fc;
            if Lc=0 then bX := 0
            else
             begin
              p := (sqr(Pi/2)+sqr(Lc))/2/abs(Lc);
              if abs(Lc)<=Pi/2 then bX := (abs(Lc)-p+sqrt(sqr(p)-sqr(Fc)))*sgn(Lc)
              else
               begin
                if abs(Fc)>=Pi/2-0.001 then bX := (abs(Lc)-Pi/2)*sgn(Lc)
                else bX := (abs(Lc)-Pi/2+sqrt(sqr(Pi/2)-sqr(Fc)))*sgn(Lc);
               end;
             end;
           end;
       97: begin
            bY := Fc;
            bX := Lc*(Pi/2-abs(Fc))/(Pi/2);
           end;
       98: begin
            if (abs(Lc)<0.001) or (abs(Fc)>arcus(89.9)) then bX := 0
            else bX := 2*sqrt(2)*Lc*sin((Pi/2-abs(Fc))/2)/sqrt(Pi);
            bY := sqrt(Pi)*(1-1.41421356*sin((Pi/2-abs(Fc))/2))*sgn(Fc);
           end;
       99: begin
            bX := Lc/Pi*(Pi-abs(Fc));
            bY := Fc;
           end;
       180: begin
            bX := 0.460658866*Lc*sqrt(4-3*sin(abs(Fc)));
            bY := 1.447202509*sgn(Fc)*(2-sqrt(4-3*sin(abs(Fc))));
           end;
       181:begin
           bb := abs(2*Fc/Pi);
           cc := sqrt(1-sqr(bb));
           if Pi/2-abs(Fc)<0.001 then
            begin
             bX := 0;
             bY := sgn(Fc)*Pi;
            end
           else
           if abs(Fc)<0.0001 then
            begin
             bX := Lc;
             bY := 0;
            end
           else
           if abs(Lc)<0.0001 then
            begin
             bX := 0;
             bY := sgn(Fc)*Pi*bb/(1+cc);
            end
           else
            begin
             aa := abs(Pi/Lc-Lc/Pi)/2;
             gg := bb/(1+cc);
             bX := sgn(Lc)*Pi*(sqrt(sqr(aa)+1-sqr(gg))-aa);
             bY := sgn(Fc)*Pi*gg;
            end;
           end;
       182:begin
             bY := Fc;
             gg := 4.478461;
             if Fc<-Pi/4 then aa := 3*sin(2*Fc+Pi)
             else
             if Fc<0 then aa := gg*3/2*sin(2/3*Fc+2*Pi/3)-1.5*gg+3
             else
             if Fc<Pi/6 then aa := gg*sin(Fc+4*Pi/3)+gg+1.5
             else
             if Fc<Pi/3 then aa := sin(6*Fc+Pi/2)/4+1.75
             else aa := 2*sin(3*Fc-Pi/2);
             bX := aa*Lc/Pi;
           end;
       183:begin
             bY := Fc;
             gg := 4.478461;
             if Fc<-Pi/4 then aa := sqrt((sqr(Pi)/16-sqr(-Fc-Pi/4))*9/sqr(Pi)*16)
             else
             if Fc<0 then aa := gg*3/2*sin(2/3*Fc+2*Pi/3)-1.5*gg+3
             else
             if Fc<Pi/6 then aa := gg*sin(Fc+4*Pi/3)+gg+1.5
             else
             if Fc<Pi/3 then aa := sin(6*Fc+Pi/2)/4+1.75
             else aa := sqrt((sqr(Pi)/36-sqr(Fc-Pi/3))*4/sqr(Pi)*36);
             bX := aa*Lc/Pi/2;
           end;
       end;
       aX := Trunc(bX*EARTHRADIUS/1000/Scale);
       aY := Trunc(bY*EARTHRADIUS/1000/Scale);
      end;
    5:begin
       case AktivVetulet of
       100: begin
             bX := 2.828427125*cos(Fc)*sin(Lc/2)/sqrt(1+cos(Fc)*cos(Lc/2));
             bY := 1.414213562*sin(Fc)/sqrt(1+cos(Fc)*cos(Lc/2));
            end;
       101: begin
             bX := 2*arccos(cos(Fc)*cos(Lc/2))*cos(Fc)*sin(Lc/2)/
               sqrt(1-sqr(cos(Fc)*cos(Lc/2)));
             bY := arccos(cos(Fc)*cos(Lc/2))*sin(Fc)/
               sqrt(1-sqr(cos(Fc)*cos(Lc/2)));
            end;
       102: begin
             bX := (cos(arcus(fis))*Lc+2*arccos(cos(Fc)*cos(Lc/2))*cos(Fc)*sin(Lc/2)/
               sqrt(1-sqr(cos(Fc)*cos(Lc/2))))/2;
             bY := (Fc+arccos(cos(Fc)*cos(Lc/2))*sin(Fc)/
               sqrt(1-sqr(cos(Fc)*cos(Lc/2))))/2;
            end;
       103: begin
             bX := 0.93541*sqrt(8)*cos(Fc)*sin(Lc/2)/sqrt(cos(Fc)*cos(Lc/2)+1);
             bY := sqrt(2)/0.93541*sin(Fc)/sqrt(cos(Fc)*cos(Lc/2)+1);
            end;
       104: begin
             ss := 0.90631*sin(Fc);
             cc := sqrt(1-sqr(ss));
             bb := sqrt(2/(1+cc*cos(Lc/3)));
             bX := 2.66723*cc*bb*sin(Lc/3);
             bY := 1.24104*ss*bb;
            end;
       105: begin
             ss := sin(Lc/2);
             cc := cos(Lc/2);
             tt := sin(Fc/2)/(cos(Fc/2)+cc*sqrt(2*cos(Fc)));
             bb := sqrt(2/(1+sqr(tt)));
             qq := sqrt((cos(Fc/2)+sqrt(cos(Fc)/2)*(cc+ss))/
               (cos(Fc/2)+sqrt(cos(Fc)/2)*(cc-ss)));
             bX := 5.828427125*(-2*ln(qq)+bb*(qq-1/qq));
             bY := 5.828427125*(-2*arctan(tt)+bb*tt*(qq+1/qq))
            end;
       106: begin
               aa := sqrt(1-sqr(tan(Fc/2)));
               cc := 1+aa*cos(Lc/2);
               pp := sin(Lc/2)*aa/cc;
               qq := tan(Fc/2)/cc;
               bX := 4/3*pp*(3+sqr(pp)-3*sqr(qq));
               bY := 4/3*qq*(3+3*sqr(pp)-sqr(qq));
            end;
       107: begin
             bX := (1+cos(Fc))*sin(Lc/2);
             bY := (1+sin(betan)-cos(betan))/2+sin(Fc)*cos(betan)-
               (1+cos(Fc))*sin(betan)*cos(Lc/2);
             if fin<>0 then beta0 := -arctan(cos(Lc/2)/tan(betan))
             else beta0 := -Pi/2;
            end;
       108:begin
             bX := Lc;
             gg := 4.478461;
             bb := Lc/2*11/12;
             if bb<-Pi/4 then aa := sqrt((sqr(Pi)/16-sqr(-bb-Pi/4))*9/sqr(Pi)*16)
             else
             if bb<0 then aa := gg*3/2*sin(2/3*bb+2*Pi/3)-1.5*gg+3
             else
             if bb<Pi/6 then aa := gg*sin(bb+4*Pi/3)+gg+1.5
             else
             if bb<Pi/3 then aa := sin(6*bb+Pi/2)/4+1.75
             else aa := sqrt((sqr(Pi)/36-sqr(bb-Pi/3))*4/sqr(Pi)*36);
             bY := aa*Fc/Pi*2;
           end;
       109:begin
             bX := Lc;
             bY := fiah*sin(Lc*fih)/fih+Fc;
           end;
       110:begin
             bX := Lc;
             bY := fiah*sin(Lc*fih)/fih+sin(Fc);
           end;

          end;
          aX := Trunc(bX*EARTHRADIUS/1000/Scale);
          aY := Trunc(bY*EARTHRADIUS/1000/Scale);
        end;
      end;
    end;

    procedure Vizsgal;
      var x12,y12: Integer;
          fi12,la12: Double;

      procedure hatarszamito(var x12, y12 : Integer);
        function hataron(a1, a2, b1, b2, top : Double): Double;
        begin
          result := a1 + (a2 - a1) * (top - b1) / (b2 - b1);
        end;
      begin
        if not (AktivVetulet in [65,94,95,98]) and (fi12 < Arcus(minfi)) then begin
          x12 := Trunc(hataron(x1, x2, Fca, Fc, Arcus(minfi)));
          y12 := Trunc(hataron(y1, y2, Fca, Fc, Arcus(minfi)));
        end;

        // Mercator-féle v. szögtartó és két paralelkörben hossztartó vetület
        if (AktivVetulet in [44,45]) and (fi12 > -Arcus(minfi)) then begin
          x12 := Trunc(hataron(x1, x2, Fca, Fc, -Arcus(minfi)));
          y12 := Trunc(hataron(y1, y2, Fca, Fc, -Arcus(minfi)));
        end;

        // Szögtartó polikónikus vetület
        if (AktivVetulet = 65) then begin
          if (la12 > Arcus(minfi)) then begin
            x12 := Trunc(hataron(x1, x2, Lca, Lc, Arcus(minfi)));
            y12 := Trunc(hataron(y1, y2, Lca, Lc, Arcus(minfi)));
          end;
          if (la12 < -Arcus(minfi)) then begin
            x12 := Trunc(hataron(x1, x2, Lca, Lc, -Arcus(minfi)));
            y12 := Trunc(hataron(y1, y2, Lca, Lc, -Arcus(minfi)));
          end;
        end;

        // Apianus I., Bacon-féle, Collignon-féle vetület
        if (AktivVetulet in [94,95,98]) then begin
          if (fel) and (la12>arcus(90)) then begin
            x12 := Trunc(hataron(x1, x2, Lca, Lc, Arcus(90)));
            y12 := Trunc(hataron(y1, y2, Lca, Lc, Arcus(90)));
          end;
          if (fel) and (la12 < -Arcus(90)) then begin
            x12 := Trunc(hataron(x1, x2, Lca, Lc, -Arcus(90)));
            y12 := Trunc(hataron(y1, y2, Lca, Lc, -Arcus(90)));
          end;
        end;

        if x12 < Baltop then begin
          x12 := Baltop;
          y12 := Trunc(hataron(y1, y2, x1, x2, Baltop));
        end;
        if x12 > Jobbtop then begin
          x12 := Jobbtop;
          y12 := Trunc(hataron(y1, y2, x1, x2, Jobbtop));
        end;
        if y12 < Lenntop then begin
          y12 := Lenntop;
          x12 := Trunc(hataron(x1, x2, y1, y2, Lenntop));
        end;
        if y12>Fenntop then begin
          y12 := Fenntop;
          x12 := Trunc(hataron(x1, x2, y1, y2, Fenntop));
        end;
      end; // procedure hatarszamito

      function kintie : Boolean;
      begin
        if (x2 < Baltop) or (x2 > Jobbtop) or (y2 < Lenntop) or (y2 > Fenntop)
        or ((AktivVetulet <> 65) and ((Fc < Arcus(minfi)) or ((AktivVetulet in [44,45]) and (Fc > -Arcus(minfi)))))
        or ( AktivVetulet =  65) and (abs(Lc) > Arcus(minfi))
        or ((AktivVetulet = 107) and (Fc < beta0))
        or ((AktivVetulet in [94,95,98]) and (fel) and (abs(Lc) > Arcus(90))) then
          result := True
        else
          result := False;
      end;

      function Atszel : Boolean;
      begin
        result := False;
        case Csalad of
        0 :
          if (Lca * Lc < 0) and (abs(Lca - Lc) > Pi / 18) and (abs(Lca - Lc) < 35 * Pi / 18) then
            result := True;
        1 :
          if (abs(Lca - Lc) > Pi / 8) or ((Fc > 1.56) and (abs(Lca - Lc) > Pi / 36))
          and not ((AktivVetulet in [23,26]) and (Fc > Pi / 2 - 0.1) and (Fca > Pi / 2 - 0.1))
          then result := True;
        2 :
          if (Lca * Lc < 0) and (abs(Lca - Lc) > Pi / 2) then
            result := True;
        3 :
          if (Lca * Lc < 0) and (abs(Lca - Lc) > Pi / 2) then
            result := True;
        4 :
          if (Lca * Lc < 0) and (abs(Lca - Lc) > Pi / 4) and (abs(Fc) < Pi / 2 - 0.01) and (abs(Fca) < Pi / 2 - 0.01) then
            result := True;
        5 :
          if (Lca * Lc < 0) and (abs(Lca - Lc) > Pi / 2) then
            result := True;
        end;

        // Goode-féle vetület
        if (AktivVetulet = 90)
        and (((Fc < 0) and (((Lc  < Arcus(-100)) and (Lca > Arcus(-100)))
                         or ((Lca < Arcus(-100)) and (Lc  > Arcus(-100)))
                         or ((Lc  < Arcus(-20 )) and (Lca > Arcus(-20 )))
                         or ((Lca < Arcus(-20 )) and (Lc  > Arcus(-20 )))
                         or ((Lc  < Arcus( 80 )) and (Lca > Arcus( 80 )))
                         or ((Lca < Arcus( 80 )) and (Lc  > Arcus( 80 )))))
          or ((Fc > 0) and (((Lc  < Arcus(-40 )) and (Lca > Arcus(-40 )))
                         or ((Lca < Arcus(-40 )) and (Lc  > Arcus(-40))))))
        then result := True;

        if not OptionsForm.HosszuChk.Checked and (sqr(x2 - x1) + sqr(y2 - y1) > 1000000) then
          result := True;
      end; // function Atszel

    // procedure Vizsgal
    begin
      if q = 1 then begin
        Kint := False;
        vetites(x2, y2);
        if Kintie then
          Kint := True
        else
          mozgat(x2,y2);
      end else begin
        x1 := x2;
        y1 := y2;
        vetites(x2, y2);

        if not Kint then begin
          if kintie then begin
            Kint := True;
            x12 := x2;
            y12 := y2;
            fi12 := Fc;
            la12 := Lc;

            if Atszel then
              mozgat(x2, y2)
            else begin
              hatarszamito(x12,y12);
              ir(x12,y12);
            end;
          end else begin
            if Atszel then
              mozgat(x2,y2)
            else
              ir(x2,y2);
          end
        end else begin
          if not kintie then begin
            Kint := False;
            x12 := x1;
            y12 := y1;
            fi12 := Fca;
            la12 := Lca;

            if Atszel then
              mozgat(x2,y2)
            else begin
              hatarszamito(x12,y12);
              mozgat(x12,y12);
              ir(x2,y2);
            end;
          end;
        end;
      end;
    end; // procedure Vizsgal

    procedure paralelkor;
    begin
      q := 0;
      La := 179.999 + Tatu;
      repeat
        q := q + 1;
        La := La - Tatu;
        if Almost(La, -180) then
          La := -179.999;
        if Ferde then
          seged(Arcus(Fi), Arcus(La), Fc, Lc)
        else begin
          Fc := Arcus(Fi);
          Lc := Arcus(La);
        end;

        Vizsgal;

        Lca := Lc;
        Fca := Fc;
      until Almost(La, -180);
    end;

    procedure Tartalomrajzolo;
    var u: Integer;
    begin
      q := 0;
      u := 0;
      Reset(txt);

      repeat
        readln(txt, Fi, La);
        if (Fi = 0) and (La = 0) then
          q := 0
        else begin
          Fi := Fi + 0.001;
          La := La + 0.001;
          q := q + 1;
          u := u + 1;
          if Ferde then
            seged(Arcus(Fi), Arcus(La), Fc, Lc)
          else begin
            Fc := Arcus(Fi);
            Lc := Arcus(La);
          end;

          Vizsgal;

          Lca := Lc;
          Fca := Fc;

          if u mod 2100 = 0 then begin
            Progpos := Progpos + 100 / Prog;
            ProgressForm.ProgressBar1.Position := Trunc(Progpos);
            Application.ProcessMessages;
            if Megse then
              exit;
          end;
        end;
      until eof(txt);

      CloseFile(txt);
    end;

    function SurusegFokVizsgalo(FokEd: TEdit; MaxFok: Byte; var Suruseg: Byte) : Boolean;
    begin
      Result := True;
      if NagyitasVizsgalo(FokEd.Text) then begin
        Suruseg := StrToInt(FokEd.Text);
        if Suruseg > MaxFok then
          Result := False;
      end else begin
        Result := False;
      end;

      if not Result then begin
        UjForm.Visible := True;
        UjForm.PageControl1.ActivePage := UjForm.Tartalombox;
        FokEd.SetFocus;
        InvalidValueMsg;
      end;
    end;

  begin // FrissitClick
    TRY
      VanMeres := False;
      StatusBar3.Visible := False;
      Abra.Cursor := crDefault;

      AssignFile(fil1,OptionsForm.parttxt.Text);
      AssignFile(fil2,OptionsForm.hatartxt.Text);
      AssignFile(fil3,OptionsForm.totxt.Text);

      if FileExists(OptionsForm.parttxt.text) then begin
        Reset(fil1);
        Progpart := Trunc(41 * FileSize(fil1) / 1400000);
        CloseFile(fil1);
      end;
      if FileExists(OptionsForm.hatartxt.text) then begin
        Reset(fil2);
        Proghatar := Trunc(5 * FileSize(fil2) / 170000);
        CloseFile(fil2);
      end;
      if FileExists(OptionsForm.totxt.text) then begin
        Reset(fil3);
        Progto := Trunc(4 * FileSize(fil3) / 130000);
        CloseFile(fil3);
      end;

      Kint := False;
      InvalidValue := False;

      if not Elso and not Zoomol then
        PrevZoom := Zoom;

      if not Zoomol and Lupe then begin
        if NagyitasVizsgalo(NagyitasCB.Text) = True then begin
          Zoom := StrToInt(Copy(NagyitasCB.Text, 1, szamhossz2));
        end else begin
          NagyitasCB.SetFocus;
          InvalidValueMsg;
          Exit;
        end;
      end;

      if NagyitasVizsgalo(MeretaranyEd.Text) = True then begin
        Scale := StrToInt(MeretaranyEd.Text);
      end else begin
        MeretaranyEd.SetFocus;
        InvalidValueMsg;
        Exit;
      end;

      if (NagyitasVizsgalo(UjForm.KozMerFokEd.Text) = True) or (UjForm.KozMerFokEd.Text = '0') then begin
        L0N := StrToInt(UjForm.KozMerFokEd.Text);
        if abs(L0N) > 180 then
          InvalidValue := True
        else
          L0N := arcus(L0N);
      end else begin
        InvalidValue := True;
      end;

      if InvalidValue then begin
        UjForm.Visible := True;
        UjForm.PageControl1.ActivePage := UjForm.Vetuletbox;
        UjForm.KozMerFokEd.SetFocus;

        InvalidValueMsg;
        Exit;
      end;

      if not SurusegFokVizsgalo(UjForm.MerSurusegFokEd, 180, MerSurusegFok) then
        Exit;
      if not SurusegFokVizsgalo(UjForm.ParSurusegFokEd, 90, ParSurusegFok) then
        Exit;

      if UjForm.FerdeBtn.Checked then begin
        if not SurusegFokVizsgalo(UjForm.SegMerSurusegFokEd, 180, SegMerSurusegFok) then
          Exit;
        if not SurusegFokVizsgalo(UjForm.SegParSurusegFokEd, 90, SegParSurusegFok) then
          Exit;

        if (NagyitasVizsgalo(UjForm.PolusSzelesFokEd.Text) = True) or (UjForm.PolusSzelesFokEd.Text='0') then begin
          F0 := StrToFloat(UjForm.PolusSzelesFokEd.Text);
          if abs(F0) > 90 then
            InvalidValue := True
          else
            F0 := arcus(F0);
        end else begin
          InvalidValue := True;
        end;

        if InvalidValue then begin
          UjForm.Visible := True;
          UjForm.PageControl1.ActivePage := UjForm.Vetuletbox;
          UjForm.PolusSzelesFokEd.SetFocus;

          InvalidValueMsg;
          Exit;
        end;

        if (NagyitasVizsgalo(UjForm.PolusHosszuFokEd.Text) = True) or (UjForm.PolusHosszuFokEd.Text = '0') then begin
          L0 := StrToFloat(UjForm.PolusHosszuFokEd.Text);
          if abs(L0) > 180 then
            InvalidValue := True
          else
            L0 := arcus(L0);
        end else begin
          InvalidValue := True;
        end;

        if InvalidValue then begin
          UjForm.Visible := True;
          UjForm.PageControl1.ActivePage := UjForm.Vetuletbox;
          UjForm.PolusHosszuFokEd.SetFocus;

          InvalidValueMsg;
          Exit;
        end;
      end;

      if Elso then begin
        Zoom := 100;
        PrevZoom := Zoom;
        PrevScale := Scale;
        Mentes.Enabled := True;
        Nyomtat.Enabled := True;
        NyomtatBtn.Enabled := True;
        MentBtn.Enabled := True;
        NagyitBtn.Enabled := True;
        KicsinyitBtn.Enabled := True;
        VagBtn.Enabled := True;
        MozgatBtn.Enabled := True;
        TavolsagBtn.Enabled := True;
      end;

      case Mode of
      PLTMODE :
        begin
          // Ábra mentése folyamatban
          ProgressForm.ProgressLabel.Visible  := False;
          ProgressForm.ProgressLabel2.Visible := True;
          ProgressForm.ProgressLabel3.Visible := False;
        end;
      PRINTMODE :
        begin
          // Ábra nyomtatása folyamatban
          ProgressForm.ProgressLabel.Visible  := False;
          ProgressForm.ProgressLabel2.Visible := False;
          ProgressForm.ProgressLabel3.Visible := True;
        end;
      else
        begin
          // Ábra frissítése folyamatban
          ProgressForm.ProgressLabel.Visible  := True;
          ProgressForm.ProgressLabel2.Visible := False;
          ProgressForm.ProgressLabel3.Visible := False;
        end;
      end;

      ProgressForm.Show;
      ProgressForm.ProgressBar1.Position := 0;
      Application.ProcessMessages;

      if not origomas then begin
        OMoveX := 0;
        OMoveY := 0;
      end;

      Megse := False;
      Sfh := False;

      Progpos := 0;
      Prog := 0;
      if UjForm.FokChk.Checked then
        Prog := Prog + 25;
      if UjForm.SegedChk.Checked and UjForm.FerdeBtn.Checked then
        Prog := Prog + 25;
      if UjForm.PartChk.Checked then
        Prog := Prog + Progpart;
      if UjForm.HatarChk.Checked then
        Prog := Prog + Proghatar;
      if UjForm.ToChk.Checked then
        Prog := Prog + Progto;

      Ferde := Ujform.FerdeBtn.Checked;
      Csalad := UjForm.CsaladCB.ItemIndex;

      if not Sajt2 then begin
        SBHelyX := ScrollBox1.HorzScrollBar.Position;
        SBHelyY := ScrollBox1.VertScrollbar.Position;
      end;

      if Sajt3 then begin
        SBHelyX := 0;
        SBHelyY := 0;
      end;

      inicializalo;

      case AktivVetulet of
      2,3,22,23,27: // Sztereografikus / gnomonikus síkvetület
                    // Szögtartó és egy paralelkörben hossztartó / Lambert-Gauss-féle / perspektív kúpvetület
        minfi := 90 - fik;
      4: // Ortografikus síkvetület
        minfi := 0;
      44,45,46: // Mercator-féle / szögtartó és két paralelkörben hossztartó / perspektív hengervetület
        minfi := -fik;
      65: // Szögtartó polikónikus
        minfi := fik;
      else
        minfi := -90;
      end;

      Ferde := True;
      q := 0;

      if not Crop then begin
        {határoló vonalak}
        Tatuado(UjForm.ParReszletCB.ItemIndex);

        case Csalad of
        0:
          begin
            La := 181;
            Fc := Arcus(minfi);

            repeat
              La := La - 1;
              Lc := Arcus(La);

              Vetites(x2, y2);

              if q = 0 then
                Elsotop
              else
                Topvizsgalo;
            until La<-179;
          end;

        1:
          begin
            {külsõ paralel}
            La := 179.999 + Tatu;
            Fc := Arcus(minfi + 0.001);
            Fca := Fc;

            repeat
              La := La-Tatu;
              Lc := arcus(La);

              vetites(x2,y2);

              if q = 0 then
                Elsotop
              else
                Topvizsgalo;
              Lca := Lc;
            until Almost(La, -180);

            {határoló meridiánok}
            Tatuado(UjForm.MerReszletCB.ItemIndex);

            for i := 0 to 1 do begin
              Lc := -(Pi - 0.00001) + i * 2 * (Pi - 0.00001);
              Lca := Lc;
              Fi := 89.999 + Tatu;

              repeat
                Fi := Fi-Tatu;
                if Almost(Fi,-90) then
                  Fi := -89.999;
                Fc := arcus(Fi);

                vetites(x2,y2);
                topvizsgalo;

                Fca := Fc;
              until Almost(Fi, minfi);
            end;
          end;

        2 :
          begin
            Fc := Arcus(minfi + 0.001);
            Lc := Arcus(179.999);

            vetites(x2,y2);
            Elsotop;

            Fc := Arcus(minfi + 0.001);
            Lc := Arcus(-179.999);

            vetites(x2,y2);
            topvizsgalo;

            Fc := -Arcus(minfi + 0.001);
            Lc := Arcus(179.999);

            vetites(x2,y2);
            topvizsgalo;

            Fc := -Arcus(minfi + 0.001);
            Lc := Arcus(-179.999);

            vetites(x2,y2);
            topvizsgalo;
          end;

        3,4,5 :
          begin
            Tatuado(UjForm.MerReszletCB.ItemIndex);

            // Oldfield III., Egyszerû hullámvetület, Lambert-féle hullámvetület
            if AktivVetulet in [108,109,110] then begin
              q := 0;

              for i := 0 to 1 do begin
                Fc := (2 * i - 1) * Arcus(90);
                La := 179.999 + Tatu;
                Fca := Fc;

                repeat
                  La := La-Tatu;
                  if Almost(La, -180) then
                    La := -179.999;
                  Lc := arcus(La);

                  vetites(x2,y2);

                  if q = 0 then
                    Elsotop
                  else
                    topvizsgalo;
                  Lca := Lc;
                until Almost(La, -180);
              end;
            end else if AktivVetulet=65 then begin
              q := 0;

              for i := 0 to 1 do begin
                Lc := (2 * i - 1) * Arcus(minfi);
                Fi := 89.999 + Tatu;
                Lca := Lc;

                repeat
                  Fi := Fi - Tatu;
                  if Almost(Fi, -90) then
                    Fi := -89.999;
                  Fc := Arcus(Fi);

                  vetites(x2,y2);

                  if q = 0 then
                    Elsotop
                  else
                    topvizsgalo;
                  Fca := Fc;
                until Almost(Fi, -90);
              end;

            end else begin
              q := 0;

              for i := 0 to 1 do begin
                if (AktivVetulet in [94,95,98]) and (fel) then
                  Lc := (2 * i - 1) * arcus(89.999)
                else
                  Lc := (2 * i - 1) * arcus(179.999);
                Fi := -minfi - 0.001 + Tatu;
                Lca := Lc;

                repeat
                  Fi := Fi-Tatu;
                  if Almost(Fi, -90) then
                    Fi := -89.999;
                  Fc := arcus(Fi);

                  vetites(x2,y2);

                  if q = 0 then
                    Elsotop
                  else
                    topvizsgalo;
                  Fca := Fc;
                until Almost(Fi, minfi);
              end;
            end;
          end;
        end;

        // Armadillo
        if (AktivVetulet = 107) and (fin <> 0) then begin
          Lc := 0;
          Fc := -arctan(cos(Lc / 2) / tan(betan));
          vetites(x2, y2);
          topvizsgalo;
        end;
      end;

      if (OptionsForm.Maigazit.Checked and not Sajt) or Igazigaz then begin
        if (Lx * (Szazalek / 100) < Minmargomi) or (Ly * (Szazalek / 100) < Minmargomi) then begin
          margox := Lx - 2 * Minmargomi;
          margoy := Ly - 2 * Minmargomi;
        end else begin
          margox := Lx * (100 - 2 * Szazalek) / 100;
          margoy := Ly * (100 - 2 * Szazalek) / 100;
        end;
        Vezuv2 := Scale;

        case OptionsForm.KerekitesCB.ItemIndex of
        0 : q := 1;
        1 : q := 5;
        2 : q := 10;
        3 : q := 25;
        4 : q := 50;
        end;

        if margox / (Jobbtop - Baltop) * (Fenntop - Lenntop) > margoy then
          Scale := q * (Trunc(Scale * (Fenntop - Lenntop) / margoy) div q + 1)
        else
          Scale := q*(Trunc(Scale * (Jobbtop - Baltop) / margox) div q + 1);
        MeretaranyEd.Text := IntToStr(Scale);

        Jobbtop := Trunc(Vezuv2 / Scale * Jobbtop);
        Baltop := Trunc(Vezuv2 / Scale * Baltop);
        Fenntop := Trunc(Vezuv2 / Scale * Fenntop);
        Lenntop := Trunc(Vezuv2 / Scale * Lenntop);
      end;

      if Crop and Sajt then begin
        Jobbtop := Trunc(PrevScale / Scale * Jobbtop);
        Baltop := Trunc(PrevScale / Scale * Baltop);
        Fenntop := Trunc(PrevScale / Scale * Fenntop);
        Lenntop := Trunc(PrevScale / Scale * Lenntop);
      end;

      TRY
        if not Elso then begin
          Meminfo.dwLength := Sizeof(Meminfo);
          GlobalMemoryStatus(Meminfo);
          MaxBmp := Trunc(0.3 * (Bitmap.Width * Bitmap.Height + 2 * (MemInfo.dwAvailPhys + MemInfo.dwAvailPageFile)));
          NewBmpSize := Trunc(sqr(Zoom * PrevScale / PrevZoom / Scale) * Bitmap.Width * Bitmap.Height);
          if NewBmpSize > MaxBmp then
            Zoom := Trunc(PrevZoom * Scale / PrevScale * sqrt(MaxBmp / Bitmap.Width /Bitmap.Height));
          if Zoom * PrevScale / PrevZoom / Scale * Bitmap.Width > 5000 then
            Zoom := Trunc(PrevZoom * Scale / PrevScale * 5000 / Bitmap.Width);
        end;
      EXCEPT
        begin
          {}
        end;
      END;

      if (Mode = DRAWMODE) then
        Bitmap.Free;

      PrevScale := Scale;

      if not origomas then begin
        if OptionsForm.Kozepigazit.Checked then begin
          OMoveX := Trunc((Baltop + Jobbtop) / 2);
          OMoveY := Trunc((Fenntop + Lenntop) / 2);
        end else begin
          OMoveX := 0;
          OMoveY := 0;
        end;
      end;

      if (Mode = DRAWMODE) then begin

        if OptionsForm.Abraigazit.Checked then begin
          Valos.Height := Trunc(Ly / 1000 * PPI);
          Valos.Width := Trunc(Lx / 1000 * PPI);

          if (Fenntop - OMoveY > Ly / 2) or (Lenntop - OMoveY < -Ly / 2) then
            if Fenntop - OMoveY> -Lenntop + OMoveY then
              Valos.Height := Trunc(2*(Fenntop - OMoveY) / 1000 * PPI)
            else
              Valos.Height := Trunc(-2 * (Lenntop - OMoveY) / 1000 * PPI);

          if (Jobbtop - OMoveX > Lx / 2) or (Baltop - OMoveX < -Lx / 2) then
            if Jobbtop - OMoveX > -Baltop + OMoveX then
              Valos.Width := Trunc(2 * (Jobbtop - OMoveX) / 1000 * PPI)
            else
              Valos.Width := Trunc(-2 * (Baltop - OMoveX) / 1000 * PPI);

          lapmovex := 0;
          lapmovey := 0;
          KoMoveX := OMoveX;
          KoMoveY := OMoveY;
        end else begin
          Valos.Height := Trunc((Fenntop - Lenntop) * PPI / 1000);
          Valos.Width := Trunc((Jobbtop - Baltop) * PPI / 1000);
          KoMoveX := Trunc((Baltop + Jobbtop) / 2);
          KoMoveY := Trunc((Fenntop + Lenntop) / 2);
          lapmovex := OMoveX - KoMoveX;
          lapmovey := OMoveY - KoMoveY;
        end;

        Lc := ScrollBox1.Width / ScrollBox1.Height;

        if Valos.Width < Valos.Height * Lc then
          Valos.Width := Trunc(Valos.Height * Lc);
        if Valos.Height < Valos.Width / Lc then
          Valos.Height := Trunc(Valos.Width / Lc);

        Valos.Width := Valos.Width + Trunc(100 * Valos.Width / 1600);
        Valos.Height := Valos.Height + Trunc(70 * Valos.Height / 1100);

        if OptionsForm.Autozoom.Checked and not Lupe then begin
          Zoom := Trunc(100 * (ScrollBox1.Width - 4) / Valos.Width);
          AWidth := ScrollBox1.Width - 4;
          AHeight := ScrollBox1.Height - 4;
        end else begin
          AWidth := Trunc(Zoom / 100 * Valos.Width);
          AHeight := Trunc(Zoom / 100 * Valos.Height);
        end;

        repeat
          TRY
            Ex := False;
            Bitmap := TBitmap.Create;
            Bitmap.PixelFormat := pf4bit;
            Bitmap.Width := AWidth;
            Bitmap.Height := AHeight;
            Meminfo.dwLength := Sizeof(Meminfo);
            GlobalMemoryStatus(Meminfo);
            FreeMem := MemInfo.dwAvailPageFile div (Meminfo.dwTotalPageFile div 100);
            if Freemem < 30 then
              raise EOutOfResources.Create('Virtual Memory Full');
            if Bitmap.Width > 5000 then
              raise EOutOfResources.Create('Too Large Bitmap');
          EXCEPT
            ON EOutOfResources DO BEGIN
              PrevZoom := Zoom;
              if Zoom > 1000 then
                Zoom := Zoom - 200
              else if Zoom > 500 then
                Zoom := Zoom - 100
              else if Zoom > 300 then
                Zoom := Zoom - 50
              else if Zoom > 20 then
                Zoom := Zoom - 10
              else
                Zoom := Zoom - 1;
              Bitmap.Free;
              Ex := True;

              AWidth := Trunc(Zoom / PrevZoom * AWidth);
              if AWidth <= ScrollBox1.Width - 4 then
                AWidth := ScrollBox1.Width - 4
              else
                ScrollBox1.HorzScrollbar.Position := Trunc((ScrollBox1.HorzScrollbar.Range - ScrollBox1.Width) / 2);

              AHeight := Trunc(Zoom / PrevZoom * AHeight);
              if AHeight <= ScrollBox1.Height - 4 then
                AHeight := ScrollBox1.Height - 4
              else
                ScrollBox1.VertScrollbar.Position := Trunc((ScrollBox1.VertScrollbar.Range - ScrollBox1.Height) / 2);
            END;
          END;
        until Ex = False;

        if AWidth < ScrollBox1.Width - 4 then
          AWidth := ScrollBox1.Width - 4;
        if AHeight < ScrollBox1.Height - 4 then
          AHeight := ScrollBox1.Height - 4;

        NagyitasCB.Text := IntToStr(Zoom) + '%';
        Application.ProcessMessages;

        if Megse then begin
          ProgressForm.Close;
          Exit;
        end;

        OrigoX := Trunc(Bitmap.Width / 2);
        OrigoY := Trunc(Bitmap.Height / 2);
      end;

      if not Crop then begin
        Lenntop := Lenntop - 4;
        Fenntop := Fenntop + 4;
        Baltop := Baltop - 4;
        Jobbtop := Jobbtop + 4;
      end;

      KMEszaki := (UjForm.KezdoMerPolusCB.ItemIndex = 0);
      ProgressForm.ProgressBar1.Position := 3;

      // lap kirajzolása
      if (OptionsForm.LapOn.Checked) and (Mode = DRAWMODE) then begin
        Bitmap.Canvas.Pen.Color := clLtGray;
        if OptionsForm.Lapmilyen.ItemIndex = 1 then
          Bitmap.Canvas.Brush.Color := clLtGray
        else
          Bitmap.Canvas.Brush.Color := clWhite;
        Bitmap.Canvas.Rectangle(OrigoX + Trunc((-Lx / 2 + lapmovex) * PPI * Zoom / 100000),
                                OrigoY - Trunc((-Ly / 2 + lapmovey) * PPI * Zoom / 100000),
                                OrigoX + Trunc(( Lx / 2 + lapmovex) * PPI * Zoom / 100000),
                                OrigoY - Trunc(( Ly / 2 + lapmovey) * PPI * Zoom / 100000));
      end;
      Ferde := Ujform.FerdeBtn.Checked;

      // tartalom kirajzolása
      for j := 4 downto 0 do begin

        if LayersForm.RetegBox.Items[j] = GetLayerName('SEGED') then begin

          {segédfokhálózat}
          if UjForm.Segedchk.Checked and UjForm.Segedchk.Enabled then begin
            Vastagado(OptionsForm.Vas5.Value);
            Ferde := False;
            Szinado(UjForm.SegSzinCB);

            {segédhosszúsági körök}
            Tatuado(UjForm.SegMerReszletCB.ItemIndex);
            for i := 0 to 2 * Trunc(180 / SegMerSurusegFok) do begin
              q := 0;
              Fi := 89.999;
              if AktivVetulet in [44,45] then Fi := -minfi - 0.001;
              La := (i - Trunc(180 / SegMerSurusegFok)) * SegMerSurusegFok + 0.001;

              repeat
                q := q+1;
                if q > 2 then
                  Fi := Fi-Tatu;
                if Almost(Fi, -90) then
                  Fi := -89.999;
                Fc := arcus(Fi);
                Lc := arcus(La);

                Vizsgal;

                Lca := Lc;
                Fca := Fc;
              until Almost(Fi, minfi);

              Progpos := Progpos + 100 / Prog * 18 * MerSurusegFok / 360;
              ProgressForm.ProgressBar1.Position := Trunc(Progpos);
              Application.ProcessMessages;

              if Megse = True then begin
                ProgressForm.Close;
                Exit;
              end;
            end;

            {segédszélességi körök}
            Tatuado(UjForm.SegParReszletCB.ItemIndex);
            for i := 0 to 180 div SegParSurusegFok do begin
              if ParSurusegFok * (89 div SegParSurusegFok) - i * SegParSurusegFok < minfi then begin
                mike := i;
                Break;
              end;
            end;

            for i := 0 to mike do begin
              if i=0 then
                Continue;

              Fi := SegParSurusegFok * (89 div SegParSurusegFok) - (i - 1) * SegParSurusegFok + 0.001;
              paralelkor;

              Progpos := progpos + 100 / Prog * 7 / (mike + 1);
              ProgressForm.ProgressBar1.Position := Trunc(Progpos);
              Application.ProcessMessages;

              if Megse = True then begin
                ProgressForm.Close;
                Exit;
              end;
            end;

            Ferde := True;
          end;
        end;

        if LayersForm.RetegBox.Items[j] = GetLayerName('FOK') then begin

          AssignFile(DebugFile, 'debug1.log');
          Rewrite(DebugFile);
          Writeln(DebugFile, 'MerSurusegFok', MerSurusegFok);
          Writeln(DebugFile, 'ParSurusegFok', ParSurusegFok);
          Szinado(Ujform.FokSzinCB);

          if UjForm.FokChk.Checked then begin
            {hosszúsági körök}
            Tatuado(UjForm.MerReszletCB.ItemIndex);
            loopint := 2 * Trunc(180 / MerSurusegFok);
            i := 0;

            repeat
              Writeln(DebugFile, 'Next step: ', i);

              q := 0;
              Fi := 89.995;
              La := (i - Trunc(180 / MerSurusegFok)) * MerSurusegFok + 0.01;
              Writeln(DebugFile, i, ' ', La);

              if Almost(La, 0) then
                Vastagado(OptionsForm.Vas3.Value)
              else
                Vastagado(OptionsForm.Vas1.Value);

              repeat
                q := q + 1;
                if q > 2 then
                  Fi := Fi - Tatu;
                if Almost(Fi, -90) then
                  Fi := -89.995;

                if Ferde then
                  seged(Arcus(Fi), Arcus(La), Fc, Lc)
                else begin
                  Fc := Arcus(Fi);
                  Lc := Arcus(La);
                end;

                Writeln(DebugFile, 'Vizsgal1: ', Fi, ' , ', La);
                Writeln(DebugFile, 'Vizsgal2: ', Fc, ' , ', Lc);
                Vizsgal;
                Lca := Lc;
                Fca := Fc;
              until Almost(Fi,-90);

              Progpos := Progpos + 100 / Prog * 18 * MerSurusegFok / 360;
              ProgressForm.ProgressBar1.Position := Trunc(Progpos);
              Application.ProcessMessages;

              if Megse then begin
                ProgressForm.Close;
                Exit;
              end;

              i := i+1;
              Writeln(DebugFile,'end of iteration step no. ', i);
            until i > loopint;

            {térítõk,sarkkörök}
            Tatuado(UjForm.ParReszletCB.ItemIndex);
            if UjForm.TeritoChk.Checked then begin
              for i := 1 to 4 do begin
                Vastagado(OptionsForm.Vas4.Value);
                case i of
                1: Fi := 66.5;
                2: Fi := 23.5;
                3: Fi := -23.5;
                4: Fi := -66.5;
                end;
                paralelkor;
              end;
            end;
            CloseFile(DebugFile);

            {szélességi körök}
            for i := 0 to 180 div ParSurusegFok do begin
              if ParSurusegFok * (89 div ParSurusegFok) - i * ParSurusegFok <- 89 then begin
                mike := i;
                break;
              end;
            end;

            for i := 0 to mike do begin
              if i = 0 then Continue;

              Fi := ParSurusegFok * (89 div ParSurusegFok) - (i - 1) * ParSurusegFok + 0.01;
              if Almost(Fi, 0) then
                Vastagado(OptionsForm.Vas2.Value)
              else
                Vastagado(OptionsForm.Vas1.Value);

              paralelkor;
              Progpos := progpos + 100 / Prog * 7 / (mike + 1);
              ProgressForm.ProgressBar1.Position := Trunc(Progpos);
              Application.ProcessMessages;
              if Megse then begin
                ProgressForm.Close;
                Exit;
              end;
            end;

            if Megse then begin
              ProgressForm.Close;
              Exit;
            end;
          end; // FokChk.Checked

          // határoló vonalak - ezeket a fokhálózat megjelenítésétõl függetlenül kirajzoljuk
          Ferde := True;
          Vastagado(OptionsForm.Vas1.Value);
          Tatuado(UjForm.ParReszletCB.ItemIndex);

          case Csalad of
          0 : begin
            q := 0;
            La := 179.999+Tatu;
            Fc := Arcus(minfi+0.001);
            Fca := Fc;
            repeat La := La-Tatu;
                   if Almost(La, -180) then La := -179.999;
                   Lc := Arcus(La);
                   q := q+1;
                   Vizsgal;
                   Lca := Lc;
            until Almost(La, -180);
          end;

          1 : begin
            {külsõ paralel}
            q := 0;
            La := 179.999 + Tatu;
            Fc := Arcus(minfi + 0.001);
            Fca := Fc;
            repeat
              La := La - Tatu;
              if Almost(La, -180) then
                La := -179.999;

              Lc := Arcus(La);
              q := q+1;
              Vizsgal;
              Lca := Lc;
            until Almost(La, -180);

            {határoló meridiánok}
            Tatuado(UjForm.MerReszletCB.ItemIndex);
            for i := 0 to 1 do begin
              q := 0;
              Lc := -(Pi - 0.00001) + i * 2 * (Pi - 0.00001);
              Lca := Lc;
              Fi := 89.999 + Tatu;
              repeat
                Fi := Fi - Tatu;
                if Almost(Fi, -90) then
                  Fi := -89.999;
                Fc := Arcus(Fi);
                q := q + 1;
                Vizsgal;
                Fca := Fc;
              until Almost(Fi, -90);
            end;

            {pólusvonal}
            Tatuado(UjForm.ParReszletCB.ItemIndex);
            if AktivVetulet in [20,21,24,25] then begin
              q := 0;
              Fc := Arcus(89.999);
              La := 179.999 + Tatu;
              Fca := Fc;
              repeat
                La := La - Tatu;
                if Almost(La, -180) then
                  La := -179.999;

                Lc := arcus(La);
                q := q+1;
                Vizsgal;
                Lca := Lc;
              until Almost(La, -180);
            end;
          end;

          2,3,4,5 :
            begin
              if (Csalad in [2,4,5]) or (AktivVetulet=69) and not (AktivVetulet in [94,95,98,181]) then begin
                {határoló szélességek}
                Tatuado(UjForm.ParReszletCB.ItemIndex);
                for i := 0 to 1 do begin
                  q := 0;
                  Fc := ( 2 * i - 1) * Arcus(minfi + 0.001);
                  La := 179.999 + Tatu;
                  Fca := Fc;
                  repeat
                    La := La - Tatu;
                    if Almost(La, -180) then
                      La := -179.999;

                    Lc := Arcus(La);
                    q := q + 1;
                    Vizsgal;
                    Lca := Lc;
                  until Almost(La, -180);
                end;
              end;

              {határoló meridiánok}
              Tatuado(UjForm.MerReszletCB.ItemIndex);
              for i := 0 to 1 do begin
                q := 0;

                if AktivVetulet = 65 then
                  Lc := (2 * i - 1) * Arcus(minfi)
                else if (AktivVetulet in [94,95,98]) and (fel) then
                  Lc := (2 * i - 1) * Arcus(89.999)
                else
                  Lc := (2 * i - 1) * Arcus(179.999);
                Fi := 89.999 + Tatu;
                Lca := Lc;

                repeat
                  Fi := Fi - Tatu;
                  if Almost(Fi, -90) then
                    Fi := -89.999;
                  Fc := Arcus(Fi);
                  q := q+1;
                  Vizsgal;
                  Fca := Fc;
                until Almost(Fi, -90);
              end;
            end;
          end; // case

          // Armadillo
          if ((AktivVetulet = 107) and (fin <> 0)) then begin
            Tatuado(UjForm.ParReszletCB.ItemIndex);
            q := 0;
            La := 179.999 + Tatu;

            repeat
              La := La - Tatu;
              Lc := Arcus(La);
              Fc := -arctan(cos(Lc / 2) / tan(betan));
              q := q + 1;

              Vizsgal;

              Fca := Fc;
              Lca := Lc;
            until Almost(La, -180);
          end;

          // Goode-féle
          if AktivVetulet = 90 then begin
            for i := 1 to 8 do begin
              q := 0;

              case i of
              1: Lc := Arcus( -40.001);
              2: Lc := Arcus( -39.999);
              3: Lc := Arcus(-100.001);
              4: Lc := Arcus( -99.999);
              5: Lc := Arcus( -20.001);
              6: Lc := Arcus( -19.999);
              7: Lc := Arcus(  79.999);
              8: Lc := Arcus(  80.001);
              end;

              if i in [1,2] then
                Fi := 89.999 + Tatu
              else
                Fi := 0;

              Lca := Lc;

              repeat
                Fi := Fi - Tatu;
                if Almost(Fi, 0) then
                  Fi := 0;
                if Almost(Fi, -90) then
                  Fi := -89.999;

                Fc := Arcus(Fi);
                q := q + 1;
                Vizsgal;
                Fca := Fc;

                if (i in [1,2]) and (Almost(Fi, 0)) then
                  Fi := -90;
              until Almost(Fi,-90);
            end;

            Ferde := Ujform.FerdeBtn.Checked;
            Application.ProcessMessages;

            if Megse then begin
              ProgressForm.Close;
              Exit;
            end;
          end;

          SzelesEd.Text := FloatToStr(Convert(3, EgysegCB.ItemIndex, Jobbtop - Baltop));
          MagasEd.Text  := FloatToStr(Convert(3, EgysegCB.ItemIndex, Fenntop - Lenntop));
        end;

        SetCurrentDir(ApplDir);

        {tengerpartok kirajzolása}
        if LayersForm.RetegBox.Items[j] = GetLayerName('PART') then begin
          if UjForm.PartChk.Checked then begin
            Vastagado(OptionsForm.Vas6.Value);
            Szinado(Ujform.PartSzinCB);

            AssignFile(txt,OptionsForm.parttxt.Text);
            if FileExists(OptionsForm.parttxt.Text) then
              Tartalomrajzolo
            else
              MessageDlg(OptionsForm.parttxt.Text+' nem található', mtError, [mbOK], 0);

            if Megse then begin
              ProgressForm.Close;
              Exit;
            end;
          end;
        end;

        {országhatárok kirajzolása}
        if LayersForm.RetegBox.Items[j] = GetLayerName('HATAR') then begin
          if UjForm.HatarChk.Checked then begin
            Vastagado(OptionsForm.Vas7.Value);
            Szinado(Ujform.HatarSzinCB);

            AssignFile(txt,OptionsForm.hatartxt.Text);
            if FileExists(OptionsForm.hatartxt.Text) then
              Tartalomrajzolo
            else
              MessageDlg(OptionsForm.hatartxt.Text+' nem található', mtError, [mbOK], 0);

            if Megse then begin
              ProgressForm.Close;
              Exit;
            end;
          end;
        end;

        {tavak kirajzolása}
        if LayersForm.RetegBox.Items[j] = GetLayerName('TO') then begin
          if UjForm.Tochk.Checked then begin
            Vastagado(OptionsForm.Vas8.Value);
            Szinado(Ujform.ToSzinCB);

            AssignFile(txt,OptionsForm.totxt.Text);
            if FileExists(OptionsForm.totxt.Text) then
              Tartalomrajzolo
            else
              MessageDlg(OptionsForm.totxt.Text+' nem található', mtError, [mbOK], 0);

            if Megse then begin
              ProgressForm.Close;
              Exit;
            end;
          end;
        end;

      end; // for

      { Ábra megvaltoztatása }
      Abra.Width := AWidth;
      Abra.Height := AHeight;

      SBMeret.X := ScrollBox1.Width;
      SBMeret.Y := ScrollBox1.Height;

      if Sajt2 then begin
        ScrollBox1.HorzScrollBar.Position := Trunc(Abra.Width / SBHelyx * StartPoint.X - ScrollBox1.Width / 2);
        ScrollBox1.VertScrollBar.Position := Trunc(Abra.Height / SBHelyy * StartPoint.y - ScrollBox1.Height / 2);
      end;

      if Zoomol or Lupe2 then begin
        ScrollBox1.HorzScrollBar.Position := Trunc(Zoom / PrevZoom * StartPoint.X - ScrollBox1.Width / 2);
        ScrollBox1.VertScrollBar.Position := Trunc(Zoom / PrevZoom * StartPoint.y - ScrollBox1.Height / 2);
      end;

      if (not Zoomol and not Lupe2 and not Sajt2 and not Vetvalt) or Sajt3 then begin
        if SBHelyX = 0 then
          ScrollBox1.HorzScrollBar.Position := Trunc((ScrollBox1.HorzScrollBar.Range - ScrollBox1.Width) / 2)
        else
          ScrollBox1.HorzScrollBar.Position := SBHelyX;

        if SBHelyY = 0 then
          ScrollBox1.VertScrollbar.Position := Trunc((ScrollBox1.VertScrollbar.Range - ScrollBox1.Height) / 2)
        else
          ScrollBox1.VertScrollbar.Position := SBHelyY;
      end;

      if Mode = DRAWMODE then
        Abra.Picture.Graphic := Bitmap;

      if not OptionsForm.Kozepigazit.Checked then
        KozepreBtn.Enabled := True;

      if Elso then
        Elso := False;

      if Sajt then
        LaphozBtn.Enabled := True;

      Lupe2 := False;
      Sajt2 := False;
      Sajt3 := False;
      Vetvalt := False;

      ProgressForm.ProgressBar1.Position := 100;
      ProgressForm.Close;

      Plusz := 'vetület';
      case AktivVetulet of
      0..4 : Plusz := 'valós síkvetület';
      20..39 : Plusz := 'valós kúpvetület';
      40..59 : Plusz := 'valós hengervetület';
      60,61 : Plusz := 'képzetes kúpvetület';
      66..67,70,81..84,86..88,91,92,94,99,180,104,181 : Plusz := 'vetülete';
      end;

      StatusBar1.Panels[2].Text := Vet[AktivVetulet] + ' ' + Plusz;
      if Ferde then
        StatusBar1.Panels[3].Text := 'Segédpólus: ' + UjForm.PolusSzelesFokEd.Text + ' fok szélesség, ' +
                                     UjForm.PolusHosszuFokEd.Text + ' fok hosszúság'
      else
        StatusBar1.Panels[3].Text := ' ';
    EXCEPT
      ProgressForm.Close;
      MessageDlg('Az ábra megrajzolása nem sikerült.', mtError, [mbOK], 0);
    END;
  end; // procedure Frissites

  procedure TMainForm.NagyitasCBChange(Sender: TObject);
  begin
    Zoomol := False;
    Lupe := True;
    Lupe2 := True;
    StartPoint.X := ScrollBox1.HorzScrollBar.Position+Trunc(ScrollBox1.Width/2);
    StartPoint.y := ScrollBox1.VertScrollBar.Position+Trunc(ScrollBox1.Height/2);
    if NagyitasCB.ItemIndex=7 then
                            begin
                             Lupe := False;
                             Lupe2 := False;
                             Exit;
                            end;
  end;

  procedure TMainForm.MentesClick(Sender: TObject);
  var
    JpgImg : TJPegImage;
  begin
    if (SaveDialog1.FileName[Length(SaveDialog1.FileName) - 3] = '.') and (Length(SaveDialog1.FileName) > 5) then
      SaveDialog1.FileName := Copy(SaveDialog1.FileName, 1, Length(SaveDialog1.FileName) - 4);

    if SaveDialog1.Execute then begin
      SaveDialog1.InitialDir := ExtractFilePath(SaveDialog1.FileName);
      if FileExists(SaveDialog1.FileName) then begin
        if MessageDlg(Format('%s már létezik. Felülírja?', [SaveDialog1.FileName]), mtConfirmation, mbYesNoCancel, 0) <> idYes then
          Exit;
      end;

      if SaveDialog1.FilterIndex = 3 then begin
        JpgImg := TJPegImage.Create;
        TRY TRY
          JpgImg.Assign(Abra.Picture.Graphic);
          if Abra.Picture.Graphic <> nil then
            JpgImg.SaveToFile(SaveDialog1.FileName);
        EXCEPT
          MessageDlg('Az elmentés nem sikerült.',mtConfirmation,[mbOK],0);
        END;
        FINALLY
          JpgImg.Free;
        END;
      end else if SaveDialog1.FilterIndex = 2 then begin
        if Abra.Picture.Graphic <> nil then
          Abra.Picture.SaveToFile(SaveDialog1.FileName);
      end else begin
        AssignFile(Filesv, SaveDialog1.FileName);
        Rewrite(Filesv);
        Writeln(Filesv, 'in;');
        Writeln(Filesv, 'ip0 0 ', Trunc(Lx), ' ', Trunc(Ly), ';');
        Writeln(Filesv, 'sc', -Trunc(Lx/2), ' ', Trunc(Lx/2), ' ', -Trunc(Ly/2), ' ', Trunc(Ly/2), ';');
        Writeln(Filesv, 'sp1;');

        Frissites(PLTMODE);

        CloseFile(Filesv);
      end;
    end;
  end;

  procedure TMainForm.NevjegyClick(Sender: TObject);
  begin
    AboutForm.ShowModal;
  end;

  procedure TMainForm.BeallitClick(Sender: TObject);
  begin
    UjForm.Visible := True;
    UjForm.OpenBtnClick(Beallit);
    UjForm.FormActivate(Beallit);
  end;

  procedure TMainForm.PapirmenuClick(Sender: TObject);
  begin
    PageForm.Showmodal;
  end;

  procedure TMainForm.EgysegCBChange(Sender: TObject);
  var PapirMeret : Byte;
  begin
    NeedSaveIni := True;
    PapirMeret := PageForm.PapirCB.ItemIndex;
    Egyseg := EgysegCB.ItemIndex;
    Minmargo := Convert(3, Egyseg, Minmargomi);
    OptionsForm.LegalabbEd.Text := Format('%-2.4g ', [Minmargo]) + UNITS[Egyseg].Code;
    PageForm.PapirszelesEd.Text := Format('%-2.7g ', [Lapx[PapirMeret, Egyseg]]) + UNITS[Egyseg].Code;
    PageForm.PapirmagasEd.Text := Format('%-2.7g ', [Lapy[PapirMeret, Egyseg]]) + UNITS[Egyseg].Code;
    SzelesEd.Text := FloatToStr(Convert(3, EgysegCB.ItemIndex, Jobbtop - Baltop));
    MagasEd.Text := FloatToStr(Convert(3, EgysegCB.ItemIndex, Fenntop - Lenntop));
    if PageForm.AlloBtn.Checked then begin
      MainForm.Lapszeles.Text := Format('%-2.6g ', [Lapy[PapirMeret, Egyseg]]);
      MainForm.Lapmagas.Text := Format('%-2.6g ', [Lapx[PapirMeret, Egyseg]]);
    end else begin
      MainForm.Lapszeles.Text := Format('%-2.6g ', [Lapx[PapirMeret, Egyseg]]);
      MainForm.Lapmagas.Text := Format('%-2.6g ', [Lapy[PapirMeret, Egyseg]]);
    end;
  end;

  procedure TMainForm.EszkoztareClick(Sender: TObject);
  begin
    Eszkoztare.Checked := not Eszkoztare.Checked;
    Eszkoztar.Visible := not Eszkoztar.Visible;
    if not Eszkoztare.Checked then begin
      Meretezo.Top := Meretezo.Top - 28;
      ScrollBox1.Top := ScrollBox1.Top - 28;
      ScrollBox1.Height := ScrollBox1.Height + 28;
    end else begin
      Meretezo.Top := Meretezo.Top + 28;
      ScrollBox1.Height := ScrollBox1.Height - 28;
      ScrollBox1.Top := ScrollBox1.Top + 28;
    end;
  end;

  procedure TMainForm.NagyitasCBKeyPress(Sender: TObject; var Key: Char);
  begin
   if Key = #27 then begin // ESC
     Edit1.TabStop := True;
     Edit1.SetFocus;
   end else
     if not (Key in ['0'..'9',#8]) then
       Key := #0;
  end;

  procedure TMainForm.MeretaranyEdKeyPress(Sender: TObject; var Key: Char);
  begin
   if Key=#27 then begin // ESC
     Edit1.TabStop := True;
     Edit1.SetFocus;
   end else if not (Key in ['0'..'9',#8]) then
     Key := #0
   else begin
     Sajt := True;
     Sajt2 := True;
     StartPoint.X := ScrollBox1.HorzScrollBar.Position + Trunc(ScrollBox1.Width/2);
     StartPoint.y := ScrollBox1.VertScrollBar.Position + Trunc(ScrollBox1.Height/2);
     SBHelyx := Abra.Width;
     SBHelyy := Abra.Height;
    end;
  end;

  procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  var Status: Integer;
  begin
    Bitmap.FreeImage;
    if MessageDlg('Biztosan ki akar lépni?', mtConfirmation, [mbYes, mbNo], 0) = idNo then
      CanClose := False
    else begin
      SetCurrentDir(ApplDir);

      case WindowState of
      wsNormal:
        begin
          IniFile.WriteInteger('Ablak', 'Fent', Top);
          IniFile.WriteInteger('Ablak', 'Baloldal', Left);
          IniFile.WriteInteger('Ablak', 'Szelesseg', Width);
          IniFile.WriteInteger('Ablak', 'Magassag', Height);
          Status := 1;
        end;
      wsMinimized :
        Status := 2;
      wsMaximized :
        Status := 3;
      end;
      if not Active then
        Status := 2;
      IniFile.WriteInteger('Ablak', 'Allapot', Status);

      if NeedSaveIni then begin
        if MessageDlg('Elmenti a beállításokat?', mtConfirmation,[mbYes, mbNo], 0) = idYes then begin
          IniFile.WriteString ('Adatbazis', 'Partok', OptionsForm.parttxt.Text);
          IniFile.WriteString ('Adatbazis', 'Hatarok', OptionsForm.hatartxt.Text);
          IniFile.WriteString ('Adatbazis', 'Tavak', OptionsForm.totxt.Text);
          IniFile.WriteBool   ('Meretezes', 'Abraigazitas', OptionsForm.Abraigazit.Checked);
          IniFile.WriteBool   ('Meretezes', 'Maigazitas', OptionsForm.Maigazit.Checked);
          IniFile.WriteBool   ('Meretezes', 'Autozoom', OptionsForm.Autozoom.Checked);
          IniFile.WriteBool   ('Meretezes', 'Kozepreigazitas', OptionsForm.Kozepigazit.Checked);
          IniFile.WriteBool   ('Megjelenites', 'Lap', OptionsForm.LapOn.Checked);
          IniFile.WriteInteger('Megjelenites', 'Laphogyan', OptionsForm.Lapmilyen.ItemIndex);
          IniFile.WriteBool   ('Megjelenites', 'Hosszuvonal', OptionsForm.HosszuChk.Checked);
          IniFile.WriteInteger('Megjelenites', 'Fokhalozat', OptionsForm.Vas1.Value);
          IniFile.WriteInteger('Megjelenites', 'Egyenlito', OptionsForm.Vas2.Value);
          IniFile.WriteInteger('Megjelenites', 'Kezdomeridian', OptionsForm.Vas3.Value);
          IniFile.WriteInteger('Megjelenites', 'Teritok', OptionsForm.Vas4.Value);
          IniFile.WriteInteger('Megjelenites', 'Segedfokhalozat', OptionsForm.Vas5.Value);
          IniFile.WriteInteger('Megjelenites', 'Partok', OptionsForm.Vas6.Value);
          IniFile.WriteInteger('Megjelenites', 'Hatarok', OptionsForm.Vas7.Value);
          IniFile.WriteInteger('Megjelenites', 'Tavak', OptionsForm.Vas8.Value);
          if PageForm.PapirCB.ItemIndex < 6 then
            IniFile.WriteInteger('Papir', 'Meret', PageForm.PapirCB.ItemIndex);
          IniFile.WriteBool   ('Papir', 'Tajolas', PageForm.AlloBtn.Checked);
          IniFile.WriteString ('Meretezes', 'Margo1', OptionsForm.SzazalekEd.Text);
          IniFile.WriteString ('Meretezes', 'Margo2', OptionsForm.LegalabbEd.Text);
          IniFile.WriteInteger('Meretezes', 'Kerekites', OptionsForm.KerekitesCB.ItemIndex);
          IniFile.WriteInteger('Egyseg', 'Egyseg', EgysegCB.ItemIndex);
        end;
        IniFile.Destroy;
        CanClose := True;
        AfterClose := True;
      end;
    end;
  end;

  procedure TMainForm.FormResize(Sender: TObject);
  begin
   if not AfterClose then begin
     Eszkoztar.Width := Width - 8;
     Meretezo.Width := Width - 8;
     ScrollBox1.Width := Width - 6;

     if Eszkoztare.Checked then
       ScrollBox1.Height := ClientHeight - 25
     else
       ScrollBox1.Height := ClientHeight;

     if Meretezoe.Checked then
       ScrollBox1.Height := ScrollBox1.Height - 25;

     if Statuszsore.Checked then
       ScrollBox1.Height := ScrollBox1.Height - 25;

     StatusBar2.Top := StatusBar1.Top;
     StatusBar2.Height := StatusBar1.Height;
     StatusBar3.Top := StatusBar1.Top;
     StatusBar3.Height := StatusBar1.Height;
     StatusBar1.Panels[2].Width := Width - 382;
   end;
  end;

  procedure TMainForm.NagyitBtnClick(Sender: TObject);
  begin
    MeresTorles(Abra.Canvas);
    Abra.Cursor := CR_ZOOMIN;
    StatusBar3.Visible := False;
  end;

  procedure TMainForm.KicsinyitBtnClick(Sender: TObject);
  begin
    MeresTorles(Abra.Canvas);
    Abra.Cursor := CR_ZOOMOUT;
    StatusBar3.Visible := False;
  end;

  procedure TMainForm.VagBtnClick(Sender: TObject);
  begin
    MeresTorles(Abra.Canvas);
    Abra.Cursor := CR_CROP;
    StatusBar3.Visible := False;
  end;

  procedure TMainForm.TeljesClick(Sender: TObject);
  begin
    Crop := False;
    Teljes.Enabled := False;
    TeljesBtn.Enabled := False;
    FrissitClick(Teljes);
  end;

  procedure TMainForm.EgyebClick(Sender: TObject);
  begin
    OptionsForm.Showmodal;
  end;

  procedure TMainForm.LaphozBtnClick(Sender: TObject);
  begin
    Sajt := False;
    Igazigaz := True;
    FrissitClick(LaphozBtn);
    LaphozBtn.Enabled := False;
    Igazigaz := False;
  end;

  procedure TMainForm.StatuszsoreClick(Sender: TObject);
  begin
    Statuszsore.Checked := not Statuszsore.Checked;
    if Statuszsore.Checked=False
     then
      begin
       StatusBar2.Visible := False;
       StatusBar1.Visible := False;
       ScrollBox1.Height := ScrollBox1.Height+25;
      end
     else
      begin
       StatusBar2.Visible := True;
       StatusBar1.Visible := True;
       ScrollBox1.Height := ScrollBox1.Height-25;
      end;
  end;

  procedure TMainForm.MeretezoeClick(Sender: TObject);
  begin
    Meretezoe.Checked := not Meretezoe.Checked;
    Meretezo.Visible := not Meretezo.Visible;
    if Meretezoe.Checked=False
    then
       begin
       ScrollBox1.Top := ScrollBox1.Top-28;
       ScrollBox1.Height := ScrollBox1.Height+28;
     end
    else
     begin
       ScrollBox1.Height := ScrollBox1.Height-28;
       ScrollBox1.Top := ScrollBox1.Top+28;
     end;
  end;

  procedure TMainForm.KilepesClick(Sender: TObject);
  begin
   Close;
  end;

  procedure TMainForm.NyomtatClick(Sender: TObject);
  var U : Byte;
  begin
    if PrintDialog1.Execute then begin
      for U := 1 to PrintDialog1.Copies do begin
        Printer.BeginDoc;
        TRY
          Frissites(PRINTMODE);
          Printer.EndDoc;
        EXCEPT
          Printer.Abort;
          Raise;
        END
      end;
    end;
  end;

  procedure TMainForm.EgysegCBEnter(Sender: TObject);
  begin
    EgysegCB.TabStop := True;
    MeretaranyEd.TabStop := True;
    NagyitasCB.TabStop := True;
    Edit1.TabStop := False;
  end;

  procedure TMainForm.MeretaranyEdEnter(Sender: TObject);
  begin
    EgysegCB.TabStop := True;
    MeretaranyEd.TabStop := True;
    NagyitasCB.TabStop := True;
    Edit1.TabStop := False;
  end;

  procedure TMainForm.NagyitasCBEnter(Sender: TObject);
  begin
    EgysegCB.TabStop := True;
    MeretaranyEd.TabStop := True;
    NagyitasCB.TabStop := True;
    Edit1.TabStop := False;
  end;

  procedure TMainForm.EgysegCBKeyPress(Sender: TObject; var Key: Char);
  begin
   if Key=#27 then
    begin
     Edit1.TabStop := True;
     Edit1.SetFocus;
    end
   else Key := #0;
  end;

  procedure TMainForm.Edit1KeyPress(Sender: TObject; var Key: Char);
  begin
    Key := #0;
    MeresTorles(Abra.Canvas);
  end;

  procedure TMainForm.MozgatBtnClick(Sender: TObject);
  begin
    MeresTorles(Abra.Canvas);
    StatusBar3.Visible := False;
    Abra.Cursor := CR_MOVEFROM;
  end;

  procedure TMainForm.KozepreBtnClick(Sender: TObject);
  begin
    origomas := False;
    KozepreBtn.Enabled := False;
    FrissitClick(KozepreBtn);
  end;

  procedure TMainForm.TavolsagBtnClick(Sender: TObject);
  begin
    Abra.Cursor := CR_MEASURE;
  end;

  procedure TMainForm.Timer1Timer(Sender: TObject);
  begin
    // A Beállítások form kövesse a fõképernyõt
    FormPos2.x := Left;
    FormPos2.y := Top;

    UjForm.Top := UjForm.Top + FormPos2.y - FormPos1.y;
    UjForm.Left := UjForm.Left + FormPos2.x - FormPos1.x;

    if UjForm.Top < 2 then
      UjForm.Top := 2;
    if UjForm.Left < 2 then
      UjForm.Left := 2;

    FormPos1.x := Left;
    FormPos1.y := Top;

    // Scrollbar mozgatása
    if ActiveControl = Edit1 then begin
      if SBFel then
        ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position - 8;
      if SBLe then
        ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position + 8;
      if SBBalra then
        ScrollBox1.HorzScrollBar.Position := ScrollBox1.HorzScrollBar.Position - 8;
      if SBJobbra then
        ScrollBox1.HorzScrollBar.Position := ScrollBox1.HorzScrollBar.Position + 8;
    end;
  end;

  procedure TMainForm.FormActivate(Sender: TObject);
  begin
    Edit1.TabStop := True;
    Edit1.SetFocus;
    if Abra.Cursor in [CR_CROP,CR_ZOOMIN,CR_ZOOMOUT,CR_MOVEFROM]
    then
     begin
      Abra.Cursor := crDefault;
      StatusBar3.SendToBack;
     end;
  end;

end.
