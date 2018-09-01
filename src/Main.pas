unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus, Math, Settings, ComCtrls, ToolWin,
  Buttons, Printers, IniFiles, jpeg, General;

type
  TMainForm = class(TForm)
    Szeles: TEdit;
    Egyseglabel: TLabel;
    Magas: TEdit;
    SzelesImage: TImage;
    MagasImage: TImage;
    Egyseg: TComboBox;
    Malabel: TLabel;
    Meretarany: TEdit;
    Milliolabel: TLabel;
    Nagyit: TComboBox;
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
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Zoomshape: TShape;
    Segedshape: TShape;
    SpeedButton5: TSpeedButton;
    Egyeb: TMenuItem;
    SpeedButton6: TSpeedButton;
    StatusBar1: TStatusbar;
    SpeedButton7: TSpeedButton;
    StatusBar2: TStatusBar;
    Nyomtat: TMenuItem;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SpeedButton8: TSpeedButton;
    Edit1: TEdit;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
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
    procedure NagyitChange(Sender: TObject);
    procedure MentesClick(Sender: TObject);
    procedure NevjegyClick(Sender: TObject);
    procedure BeallitClick(Sender: TObject);
    procedure PapirmenuClick(Sender: TObject);
    procedure EgysegChange(Sender: TObject);
    procedure StatuszsoreClick(Sender: TObject);
    procedure NagyitKeyPress(Sender: TObject; var Key: Char);
    procedure MeretaranyKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EszkoztareClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure TeljesClick(Sender: TObject);
    procedure EgyebClick(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure MeretezoeClick(Sender: TObject);
    procedure KilepesClick(Sender: TObject);
    procedure NyomtatClick(Sender: TObject);
    procedure EgysegEnter(Sender: TObject);
    procedure MeretaranyEnter(Sender: TObject);
    procedure NagyitEnter(Sender: TObject);
    procedure EgysegKeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetMinMax (var MinMaxMessage: TWMGetMinMaxInfo);
     message wm_GetMinMaxInfo;
    procedure AppMessage (var Msg: TMsg;
     var Handled: Boolean);
  end;

var
  MainForm: TMainForm;
  Zarora: Boolean=False;
  Bitmap: TBitmap;
  jp: TJPegImage;
  Rajzol, Gyik, Lehet, Lupe: Boolean;
  Lupe2: Boolean=False;
  Sajt2: Boolean=False;
  north: Boolean=True;
  Ni, Balszel, Jobbszel, Felsoszel, Alsoszel: Integer;
  omovex, omovey, komovex, komovey: Integer;
  OrigoX, OrigoY, Felbontas: Integer;
  Baltop, Jobbtop, Fenntop, Lenntop, Etna, VEtna, Vezuv, Vezuv3: Integer;
  Aktiv: Byte=0;
  Szamhossz2: Byte;
  Vet: array[0..220] of string;
  j,l, Winni: Byte;
  UjForm: TSettingsForm;
  Alapdir: String;
  Ini, Filesv, txt: Textfile;
  Plt: Boolean=False;
  SI: array[0..4] of String;
  Lapx,Lapy: Array[0..6,0..6] of Double;
  Lx,Ly: Double;
  origomas: Boolean=False;
  Igazigaz: Boolean=False;
  Sajt: Boolean=False;
  Sajt3: Boolean=False;
  Nyom: Boolean=False;
  fel: Boolean=True;
  egyik, masik, zoom, veg: TPoint;
  Zoomol: Boolean=False;
  Crop: Boolean=False;
  Mer: Boolean=False;
  Etna2: Integer=20;
  Elso: Boolean=True;
  CropScrollHorz, CropScrollVert: Integer;
  fi1, fi2, fin: Byte;
  fik, fih: SmallInt;
  fis, fia, fia2: Double;
  Marvan: Boolean=False;
  Vetvalt: Boolean=True;
  Valt: Boolean=False;
  Lapba: Boolean=False;
  most1, most2: TPoint;
  SBHelyX, SBHelyY: SmallInt;
  Plusz: String;
  IniFile: TIniFile;
  Egyenes: Boolean=False;
  AHeight, AWidth: Integer;
  SBMozog1: Boolean=False;
  SBMozog2: Boolean=False;
  SBMozog3: Boolean=False;
  SBMozog4: Boolean=False;
  lapmovex, lapmovey: Integer;
  Scr: TPoint;
  DebugFile : TextFile;{Textfile for debugging}
  function Atszamit(me1,me2:Byte;ertek:Double): Double;
  function Nagyitvizsgal(szam:String):Boolean;

implementation

uses About, Parameters1, Page, Unit6, Options, Layers, Splash, Parameters2;

{$R *.DFM}

procedure TMainForm.GetMinMax(var MinMaxMessage: TWMGetMinMaxInfo);
begin
  with MinMaxMessage.MinMaxInfo^ do
  begin
    ptMinTrackSize.x:=672;
    ptMinTrackSize.y:=300;
  end;
end;

function valox(par: Integer): Integer;
begin
  result:=trunc((par-OrigoX)*100000/Felbontas/Etna);
end;

function valoy(par: Integer): Integer;
begin
  result:=trunc((OrigoY-par)*100000/Felbontas/Etna);
end;

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

function nagyitvizsgal(szam:String):Boolean;
var i: Byte;
begin
 if Length(szam)=0 then nagyitvizsgal:=False else
 if not (szam[1] in ['-','1'..'9']) then nagyitvizsgal:=False
 else begin
          for i:=Length(szam) downto 1 do
            if not (szam[i] in ['0'..'9']) then szamhossz2:=i-1;
          nagyitvizsgal:=True;
      end;
end;

procedure ifmarvan(Canvas: TCanvas);
begin
  if Marvan then
  begin
    Canvas.Moveto(veg.X-7,veg.Y-7);
    Canvas.Lineto(veg.X+7,veg.Y+7);
    Canvas.Moveto(veg.X+7,veg.Y-7);
    Canvas.Lineto(veg.X-7,veg.Y+7);
    Canvas.Moveto(Zoom.X-7,Zoom.Y-7);
    Canvas.Lineto(Zoom.X+7,Zoom.Y+7);
    Canvas.Moveto(Zoom.X+7,Zoom.Y-7);
    Canvas.Lineto(Zoom.X-7,Zoom.Y+7);
    Canvas.Moveto(Zoom.x,Zoom.y);
    Canvas.Lineto(veg.X,veg.Y);
  end;
  Marvan:=False;
end;

procedure TMainForm.AppMessage (var Msg: TMsg;
  var Handled: Boolean);
begin
  if (Msg.Message=wm_Char) and (Msg.wparam=27)
   then
    begin
     if OptionsForm.Active then OptionsForm.Close;
     if ParametersForm1.Active then ParametersForm1.Close;
     if PageForm.Active then
      begin
       PageForm.PapirCancelBtnClick(Application);
       PageForm.Close;
      end;
     if AboutForm.Active then AboutForm.Close;
     if LayersForm.Active then LayersForm.Close;
     if ParametersForm2.Active then ParametersForm2.Close;
     MainForm.FormActivate(Application);
    end;
  if (Msg.Message=wm_KeyDown) and (MainForm.Active)
   then
    case msg.lparam of
    21495809: SBMozog1:=True;
    22020097: SBMozog2:=True;
    21692417: SBMozog3:=True;
    21823489: SBMozog4:=True;
    end;
  if (Msg.Message=wm_KeyUp) and (MainForm.Active)
   then
    case msg.lparam of
    -1052246015: SBMozog1:=False;
    -1051721727: SBMozog2:=False;
    -1052049407: SBMozog3:=False;
    -1051918335: SBMozog4:=False;
    end;
end;

function hakisx(x:Integer):Integer;
begin
  if Bitmap.Width<Scr.x
   then result:=x-trunc((Scr.x-Bitmap.Width)/2)+2
   else result:=x;
end;

function hakisy(y:Integer):Integer;
begin
  if Bitmap.Height<Scr.y
   then result:=y-trunc((Scr.y-Bitmap.Height)/2)+2
   else result:=y;
end;

procedure TMainForm.AbraMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbLeft then begin
  case Abra.Cursor of
  crMove2:
   begin
     Abra.Cursor:=crDefault;
     masik.X:=valox(X);
     masik.Y:=valoy(Y);
     origomas:=True;
     omovex:=omovex-masik.x+egyik.x;
     omovey:=omovey-masik.y+egyik.y;
     Speedbutton10.Enabled:=True;
     Frissitclick(SpeedButton9);
   end;
  crMove:
   begin
    if Mer then
    begin
      Abra.Canvas.Pen.Mode:=pmNotXor;
      Abra.Canvas.Pen.Color:=clBlack;
      if Marvan then
      begin
        StatusBar3.Visible:=False;
        ifmarvan(Abra.Canvas);
      end;
      Zoom.x:=hakisx(X);
      Zoom.Y:=hakisy(Y);
      veg.x:=hakisx(X);
      veg.Y:=hakisy(Y);
      Abra.Canvas.Moveto(veg.X-7,veg.Y-7);
      Abra.Canvas.Lineto(veg.X+7,veg.Y+7);
      Abra.Canvas.Moveto(veg.X+7,veg.Y-7);
      Abra.Canvas.Lineto(veg.X-7,veg.Y+7);
    end
    else
    begin
     Abra.Cursor:=crMove2;
     egyik.x:=valox(X);
     egyik.y:=valoy(Y);
     Abra.Canvas.Moveto(hakisx(X)-5,hakisy(Y)-5);
     Abra.Canvas.Lineto(hakisx(X)+5,hakisy(Y)+5);
     Abra.Canvas.Moveto(hakisx(X)+5,hakisy(Y)-5);
     Abra.Canvas.Lineto(hakisx(X)-5,hakisy(Y)+5);
    end;
   end;
  crZoomout:
   begin
    Lupe:=True;
    Etna2:=Etna;
    Zoom.x:=X;
    Zoom.y:=Y;
    Etna:=Trunc(Etna/2);
    Abra.Cursor:=crDefault;
    Zoomol:=True;
    FrissitClick(SpeedButton3);
    Exit;
   end;
  crZoomin,crCrop:
   begin
    Rajzol:=True;
    Etna2:=Etna;
    Zoom.x:=X;
    Zoom.y:=Y;
    Zoomshape.Top:=Y-ScrollBox1.VertScrollBar.Position;
    Zoomshape.Left:=X-ScrollBox1.HorzScrollBar.Position;
    Zoomshape.Width:=1;
    Zoomshape.Height:=1;
   end
  else if not Elso then
   begin
    Abra.Canvas.Pen.Mode:=pmCopy;
    SetCursor(Screen.Cursors[crCeruza]);
    if ssCtrl in Shift then
     begin
      Zoom.x:=hakisx(X);
      Zoom.Y:=hakisy(Y);
      veg.x:=hakisx(X);
      veg.Y:=hakisy(Y);
      Egyenes:=True;
     end
    else if ssShift in Shift then SetCursor(Screen.Cursors[crRadir]);
    Abra.Canvas.Moveto(hakisx(x),hakisy(y));
    Rajzol:=True;
   end;
  end;
 end;
end;

procedure TMainForm.AbraMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var Curpos, Curpos2: TPoint;
    o,i: Byte;
    m: TPoint;
begin
 if ssLeft in Shift then begin
  if (Abra.Cursor=crZoomin) or (Abra.Cursor=crCrop) then
   begin
     if Rajzol then
      begin
       Zoomshape.Width:=abs(X-Zoom.x);
       Zoomshape.Height:=abs(Y-Zoom.y);
       Zoomshape.Visible:=True;
       if Y<Zoom.y then Zoomshape.Top:=Y-Scrollbox1.VertScrollBar.Position;
       if X<Zoom.x then Zoomshape.Left:=X-Scrollbox1.HorzScrollBar.Position;
       GetCursorPos(Curpos);
       Curpos:=Scrollbox1.Screentoclient(Curpos);
       if Curpos.y<1 then
        begin
         Curpos.y:=1;
         Curpos2:=Scrollbox1.Clienttoscreen(Curpos);
         SetCursorPos(Curpos2.x,Curpos2.y);
         Scrollbox1.VertScrollbar.Position:=Scrollbox1.VertScrollbar.Position-1;
        end else
       if Curpos.x<1 then
        begin
         Curpos.X:=1;
         Curpos2:=Scrollbox1.Clienttoscreen(Curpos);
         SetCursorPos(Curpos2.x,Curpos2.y);
         Scrollbox1.HorzScrollbar.Position:=Scrollbox1.HorzScrollbar.Position-1;
        end else
       if Curpos.x>Scrollbox1.Width-16 then
        begin
         Curpos.X:=Scrollbox1.Width-16;
         Curpos2:=Scrollbox1.Clienttoscreen(Curpos);
         SetCursorPos(Curpos2.x,Curpos2.y);
         Scrollbox1.HorzScrollbar.Position:=Scrollbox1.HorzScrollbar.Position+1;
        end else
       if Curpos.y>Scrollbox1.Height-16 then
        begin
         Curpos.y:=Scrollbox1.Height-16;
         Curpos2:=Scrollbox1.Clienttoscreen(Curpos);
         SetCursorPos(Curpos2.x,Curpos2.y);
         Scrollbox1.VertScrollbar.Position:=Scrollbox1.VertScrollbar.Position+1;
        end;
      end;
   end
  else
   begin
    if Abra.Cursor=crMove then
    begin
       Abra.Canvas.Pen.Mode:=pmNotXor;
       Abra.Canvas.Moveto(Zoom.x,Zoom.y);
       Abra.Canvas.Lineto(veg.x,veg.y);
       Abra.Canvas.Moveto(Zoom.x,Zoom.y);
       veg.x:=hakisx(X);
       veg.y:=hakisy(y);
       Abra.Canvas.Lineto(veg.x,veg.y);
    end
    else
     If Rajzol then
     begin
      if ssShift in Shift then
      begin
       m.x:=hakisx(X);
       m.y:=hakisy(Y);
       if Abra.Cursor<>crRadir then SetCursor(Screen.Cursors[crRadir]);
       Abra.Canvas.Moveto(m.x,m.y);
       for o:=0 to 14 do
       for i:=0 to 14 do
       if Abra.Canvas.Pixels[m.x+i-7,m.y+o-7]=clNavy
       then if OptionsForm.Lapmilyen.Itemindex=0
            then Abra.Canvas.Pixels[m.x+i-7,m.y+o-7]:=clWhite
            else
             if (valox(m.x+i-7)<Lx/2) and (valox(m.x+i-7)>-Lx/2)
              and (valoy(m.y+o-7)<Ly/2) and (valoy(m.y+o-7)>-Ly/2)
             then Abra.Canvas.Pixels[m.x+i-7,m.y+o-7]:=clLtGray
             else Abra.Canvas.Pixels[m.x+i-7,m.y+o-7]:=clWhite;
      end
      else
      begin
       if Abra.Cursor<>crCeruza then SetCursor(Screen.Cursors[crCeruza]);
       Abra.Canvas.Pen.Width:=1;
       Abra.Canvas.Pen.Color:=clNavy;
       if Egyenes then
        begin
         Abra.Canvas.Pen.Mode:=pmNotXor;
         Abra.Canvas.Moveto(Zoom.x,Zoom.y);
         Abra.Canvas.Lineto(veg.x,veg.y);
         Abra.Canvas.Moveto(Zoom.x,Zoom.y);
        end;
       veg.x:=hakisx(X);
       veg.y:=hakisy(Y);
       Abra.Canvas.Lineto(hakisx(x),hakisy(y));
      end;
     end;
   end;
 end;
  if Elso=False then
   begin
    StatusBar2.Panels[0].Text:='x: '+
     inttostr(trunc(Atszamit(3,Eta,-lapmovex+valox(hakisx(X)))))+' '+SI[Eta];
    StatusBar2.Panels[1].Text:='y: '+
     inttostr(trunc(Atszamit(3,Eta,-lapmovey+valoy(hakisy(Y)))))+' '+SI[Eta];
   end;
end;

procedure TMainForm.AbraMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Meminfo: TMemoryStatus;
    Maxbmp: Integer;
begin
 if Button=mbLeft then begin
  Rajzol := False;
  if Egyenes then
   begin
      Abra.Canvas.Moveto(Zoom.x,Zoom.y);
      Abra.Canvas.Lineto(veg.x,veg.y);
      Abra.Canvas.Pen.Mode:=pmCopy;
      Abra.Canvas.Moveto(Zoom.x,Zoom.y);
      Abra.Canvas.Lineto(X,Y);
   end;
  Egyenes:=False;
  if (Abra.Cursor=crZoomin) or (Abra.Cursor=crCrop) then
   begin
    Zoomshape.Visible:=False;
    SpeedButton2.Down:=False;
   if (Zoomshape.Width>50) or (Zoomshape.Height>50) or (Crop=True)
   then
   begin
    if Abra.Cursor=crZoomin then
    begin
     if Scrollbox1.Width/Zoomshape.Width<Scrollbox1.Height/Zoomshape.Height
      then Etna:=Trunc(Etna*Scrollbox1.Width/Zoomshape.Width)
      else Etna:=Trunc(Etna*Scrollbox1.Height/Zoomshape.Height);
     Meminfo.dwLength:=Sizeof(Meminfo);
     GlobalMemoryStatus(Meminfo);
     Maxbmp:=trunc(0.3*(Bitmap.Width*Bitmap.Height+
       2*(MemInfo.dwAvailPhys+MemInfo.dwAvailPageFile)));
     if sqr(Etna/Etna2)*Bitmap.Width*Bitmap.Height>Maxbmp then
     Etna:=trunc(Etna2*sqrt(Maxbmp/Bitmap.Width/Bitmap.Height));
     if Etna/Etna2*Bitmap.Width>5000 then Etna:=trunc(Etna2*5000/Bitmap.Width);
     Zoomol:=True;
     Lupe:=True;
    end;
    if Bitmap.Width>Scrollbox1.Width-5 then
     Zoom.x:=ScrollBox1.HorzScrollBar.Position+
      Zoomshape.Left+Trunc(Zoomshape.Width/2)
    else Zoom.x:=Zoomshape.Left+Trunc(Zoomshape.Width/2)-
      trunc((Scrollbox1.Width-Bitmap.Width)/2);
    if Bitmap.Height>Scrollbox1.Height-5 then
    Zoom.y:=ScrollBox1.VertScrollBar.Position+
      Zoomshape.Top+Trunc(Zoomshape.Height/2)
    else Zoom.y:=Zoomshape.Top+Trunc(Zoomshape.Height/2)-
      trunc((Scrollbox1.Height-Bitmap.Height)/2);
    if Abra.Cursor=CrCrop then
    begin
     Crop:=True;
     origomas:=False;
     Teljes.Enabled:=True;
     SpeedButton6.Enabled:=True;
     CropScrollHorz:=ScrollBox1.HorzScrollBar.Position;
     CropScrollVert:=ScrollBox1.VertScrollBar.Position;
     Baltop:=valox(Zoom.x-Zoomshape.Width div 2)+omovex;
     Jobbtop:=valox(Zoom.x+Zoomshape.Width div 2)+omovex;
     Lenntop:=valoy(Zoom.y+Zoomshape.Height div 2)+omovey;
     Fenntop:=valoy(Zoom.y-Zoomshape.Height div 2)+omovey;
    end;
    FrissitClick(Segedshape);
   end;
   Abra.Cursor:=crDefault;
   Zoomshape.Width:=1;
   Zoomshape.Height:=1;
   Zoomol:=False;
   Exit;
   end;
  if Abra.Cursor=crMove then
  begin
    Abra.Canvas.Moveto(Zoom.x,Zoom.y);
    Abra.Canvas.Lineto(veg.x,veg.y);
    Abra.Canvas.Moveto(Zoom.x,Zoom.y);
    Abra.Canvas.Lineto(hakisx(X),hakisy(Y));
    Abra.Canvas.Moveto(hakisx(X)-7,hakisy(Y)-7);
    Abra.Canvas.Lineto(hakisx(X)+7,hakisy(Y)+7);
    Abra.Canvas.Moveto(hakisx(X)+7,hakisy(Y)-7);
    Abra.Canvas.Lineto(hakisx(X)-7,hakisy(Y)+7);
    StatusBar3.Visible:=True;
    StatusBar3.BringToFront;
    StatusBar3.Panels[0].Text:='A kijelölt távolság: '+
     Format('%-8.6g',[Atszamit(3,Eta,sqrt(sqr(valox(Zoom.X)-valox(X))+sqr(valoy(Zoom.Y)-valoy(Y))))])
       +' '+SI[Eta];
    veg.x:=hakisx(X);
    veg.y:=hakisy(Y);
    Marvan:=True;
  end;
 if Abra.Cursor in [crCeruza,crRadir] then Abra.Cursor:=crDefault;
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var MemInfo: TMemoryStatus;
    Status: Integer;
begin
  Alapdir:=ExtractFilePath(ParamStr(0));
  Felbontas:=trunc(96*Screen.Height/768);
  IniFile:=TIniFile.Create(Alapdir+'armadill.ini');
  Status:=IniFile.ReadInteger('Ablak','Allapot',0);
  if Status<>0 then
  begin
    Top:=IniFile.ReadInteger('Ablak','Fent',Top);
    Left:=IniFile.ReadInteger('Ablak','Baloldal',Left);
    Width:=IniFile.ReadInteger('Ablak','Szelesseg',Width);
    Height:=IniFile.ReadInteger('Ablak','Magassag',Height);
    case Status of
    1: WindowState:=wsNormal;
    2: PostMessage(MainForm.Handle,wm_SysCommand,sc_Minimize,0);
    3: WindowState:=wsMaximized;
    end;
  end;
  Egyseg.Itemindex:=IniFile.ReadInteger('Egyseg','Egyseg',0);
  Eta:=Egyseg.Itemindex;
  if Felbontas<90 then WindowState:=wsMaximized;
  Screen.Cursors[crZoomin]:=LoadCursor(HInstance, 'Nagyito1');
  Screen.Cursors[crZoomout]:=LoadCursor(HInstance, 'Nagyito2');
  Screen.Cursors[crCrop]:=LoadCursor(HInstance, 'Crop');
  Screen.Cursors[crCeruza]:=LoadCursor(HInstance, 'Ceruza');
  Screen.Cursors[crRadir]:=LoadCursor(HInstance, 'Radir');
  Screen.Cursors[crMove]:=LoadCursor(HInstance, 'Move');
  Screen.Cursors[crMove2]:=LoadCursor(HInstance, 'Move2');
  Bitmap:=TBitmap.Create;
  Bitmap.PixelFormat:=pf4bit;
  Bitmap.Width:=Abra.Width;
  Bitmap.Height:=Abra.Height;
  Abra.Picture.Graphic:=Bitmap;
  OrigoX:=Trunc(Abra.Width/2);
  OrigoY:=Trunc(Abra.Height/2);
  Fenntop:=0;
  Lenntop:=0;
  Baltop:=0;
  Jobbtop:=0;
  Lupe:=False;
  Szeles.Text:='';
  Magas.Text:='';
  Lapszeles.Text:='';
  Lapmagas.Text:='';
  most1.x:=Left;
  most1.y:=Top;
  UjForm:=TSettingsForm.Create(Application);
  UjForm.Top:=Top+24+(ClientHeight-Scrollbox1.Height);
  UjForm.Left:=Left+5;

  Lapx[0,0]:=1189;Lapy[0,0]:=841;
  Lapx[1,0]:=841;Lapy[1,0]:=594;
  Lapx[2,0]:=594;Lapy[2,0]:=420;
  Lapx[3,0]:=420;Lapy[3,0]:=297;
  Lapx[4,0]:=297;Lapy[4,0]:=210;
  Lapx[5,0]:=210;Lapy[5,0]:=148.5;

  Lapx[0,1]:=118.9;Lapy[0,1]:=84.1;
  Lapx[1,1]:=84.1;Lapy[1,1]:=59.4;
  Lapx[2,1]:=59.4;Lapy[2,1]:=42;
  Lapx[3,1]:=42;Lapy[3,1]:=29.7;
  Lapx[4,1]:=29.7;Lapy[4,1]:=21;
  Lapx[5,1]:=21;Lapy[5,1]:=14.85;

  Lapx[0,2]:=46.811;Lapy[0,2]:=33.110;
  Lapx[1,2]:=33.110;Lapy[1,2]:=23.386;
  Lapx[2,2]:=23.386;Lapy[2,2]:=16.535;
  Lapx[3,2]:=16.535;Lapy[3,2]:=11.693;
  Lapx[4,2]:=11.693;Lapy[4,2]:=8.268;
  Lapx[5,2]:=8.268;Lapy[5,2]:=5.827;

  Lapx[0,3]:=46811;Lapy[0,3]:=33110;
  Lapx[1,3]:=33110;Lapy[1,3]:=23386;
  Lapx[2,3]:=23386;Lapy[2,3]:=16535;
  Lapx[3,3]:=16535;Lapy[3,3]:=11693;
  Lapx[4,3]:=11693;Lapy[4,3]:=8268;
  Lapx[5,3]:=8268;Lapy[5,3]:=5827;

  Lx:=Lapx[3,3];
  Ly:=Lapy[3,3];

  SI[0]:='mm';
  SI[1]:='cm';
  SI[2]:='in';
  SI[3]:='mi';
  SaveDialog1.InitialDir:=Alapdir;
  Application.OnMessage:=AppMessage;
end;

procedure TMainForm.FrissitClick(Sender: TObject);
var Tatu, KM, margox, margoy, szorzo, progpos: Double;
    Delta1, Delta2, Delta3, Delta4: Byte;
    family, prog: byte;
    rossz, Ex, segede, sfh: Boolean;
    mike, x2, y2, x1, y1: Integer;
    Vezuv2: Integer;
    q, i, j, loopint: Integer;
    fi, la, fc, lc, lca, lcb, fca, fcb, f0, l0 : Double;
    valos: record
      Width: Integer;
      Height: Integer;
      end;
    Kint: Boolean;
    Ujkep: Integer;
    Meminfo: TMemorystatus;
    FreeMem: Byte;
    Maxbmp: Integer;
    minfi: Integer;
    n, ce, betan, beta1, beta2, beta0: Double;
    fil1,fil2,fil3: file of Byte;

 procedure Elsotop;
 begin
   if q=0 then
             begin
              Jobbtop:=x2;
              Baltop:=x2;
              Fenntop:=y2;
              Lenntop:=y2;
             end;
   q:=q+1;
 end;

 function vi(a,b:double):Boolean;
 begin
   if abs(a-b)<0.1 then result:=True else result:=False;
 end;

 procedure topvizsgalo;
 begin
    if x2<Baltop then Baltop:=x2;
    if x2>Jobbtop then Jobbtop:=x2;
    if y2<Lenntop then Lenntop:=y2;
    if y2>Fenntop then Fenntop:=y2;
 end;

 procedure szinado(szinlista: TCombobox);
 var szin: TColor;
 begin
   szin:=clBlack;
   case szinlista.Itemindex of
   0: szin:=clBlack;
   1: szin:=clBlue;
   2: szin:=clRed;
   3: szin:=clGreen;
   4: szin:=clPurple;
   5: szin:=clYellow;
   6: szin:=clAqua;
   7: szin:=clMaroon;
   end;
   if nyom=True then Printer.Canvas.Pen.Color:=szin
   else if plt=False then Bitmap.Canvas.Pen.Color:=szin
   else writeln(Filesv,'sp',szinlista.Itemindex+1,';');
 end;

 procedure Vastagado(par: Byte);
 begin
   if nyom then Printer.Canvas.Pen.Width:=par
   else if not plt then Bitmap.Canvas.Pen.Width:=par;
 end;

 function printerrex(par: Integer): Integer;
 begin
   result:=trunc(par*Printer.PageWidth/Lx+Printer.PageWidth/2);
 end;

 function printerrey(par: Integer): Integer;
 begin
   result:=trunc(Printer.PageHeight/2-par*Printer.PageWidth/Lx);
 end;

 function keprex(par: Integer): Integer;
 begin
   result:=trunc(par*Felbontas*Etna/100000)+OrigoX;
 end;

 function keprey(par: Integer): Integer;
 begin
   result:=OrigoY-trunc(par*Felbontas*Etna/100000);
 end;

 procedure seged(ff,ll:Double;var fc2,lc2:Double);
 var w:Double;
 begin
  TRY
    fc2:=arcsin(sin(f0)*sin(ff)+cos(f0)*cos(ff)*cos(ll-l0));
    if abs(cos(f0))<1.0e-8 then
       if vi(f0,pi/2) then
        begin
         lc2:=ll-l0;
         fc2:=ff;
         if lc2<-pi then lc2:=lc2+2*pi*(trunc(-180/pi*lc2+180) div 360);
         if lc2>pi then lc2:=lc2-2*pi*(trunc(180/pi*lc2+180) div 360);
        end
       else
        begin
         lc2:=-ll+l0;
         fc2:=-ff;
         if lc2<-pi then lc2:=lc2+2*pi*(trunc(-180/pi*lc2+180) div 360);
         if lc2>pi then lc2:=lc2-2*pi*(trunc(180/pi*lc2+180) div 360);
        end
    else
       if abs(cos(fc2))<1.0e-8 then lc2:=l0
       else
        if abs(sin(ll-l0))<1.0e-8 then
         begin
          if ((ff<f0) and (ll=l0)) or ((ff<=-f0) and (abs(ll-l0)=pi)) then
            if north=true then lc2:=(ll+0.00001)/abs(ll+0.00001)*pi else lc2:=0
          else if north=true then lc2:=0 else lc2:=(ll+0.00001)/abs(ll+0.00001)*pi;
         end
        else
         begin
          w:=cos(f0)*cos(fc2);
          if abs((sin(ff)-sin(f0)*sin(fc2))/w)>1 then
           begin
            lc2:=pi/4;
           end
          else
           begin
            lc2:=arccos((sin(ff)-sin(f0)*sin(fc2))/w);
            lc2:=-(sin(ll-l0)/abs(sin(ll-l0)))*abs(lc2);
           end;
          if north=false then lc2:=-lc2/abs(lc2)*(pi-abs(lc2));
         end;
  EXCEPT
   ON EInvalidOp DO
    BEGIN
     lc2:=1;
     fc2:=1;
    END;
  END;
 end;

 procedure Tatuado(GB: Byte);
 begin
  case GB of
  0: Tatu:=1/12;
  1: Tatu:=1/6;
  2: Tatu:=1/3;
  3: Tatu:=1/2;
  4: Tatu:=1;
  5: Tatu:=2;
  6: Tatu:=3;
  7: Tatu:=5;
 end;
 end;

 procedure mozgat(x,y: Integer);
 begin
  if Nyom=True then Printer.Canvas.Moveto(printerrex(x-omovex),printerrey(y-omovey))
  else if plt=False then Bitmap.Canvas.Moveto(keprex(x-komovex),keprey(y-komovey))
  else writeln(Filesv,'pu ',x-omovex,' ',y-omovey,';');
 end;

 procedure ir(x,y:Integer);
 begin
  if Nyom=True then Printer.Canvas.Lineto(printerrex(x-omovex),printerrey(y-omovey))
  else if plt=False then Bitmap.Canvas.Lineto(keprex(x-komovex),keprey(y-komovey))
  else writeln(Filesv,'pd ',x-omovex,' ',y-omovey,';');
 end;

procedure psziszamito(var pszi:Double);
var xa,xb,b,d: Double;
 function fv(j:Double):Double;
 begin
  case aktiv of
  64: fv:=j-sin(j)*sqr(cos(fc))-lc*sin(fc)*sqr(sin(fc));
  83: fv:=0.777969059*(j+sin(j))-2*sin(fc);
  85,89,90: fv:=2*j+sin(2*j)-pi*sin(fc);
  87: fv:=4*sin(j)+sin(2*j)+2*j-(4+pi)*sin(fc);
  end;
 end;
begin
  xa:=1;xb:=0;
  repeat
    b:=10;d:=10;
    while fv(xa)=fv(xb) do
      begin
        d:=d/10;b:=b*10;n:=1;
        repeat
          xb:=xb+d;
          n:=n+1;
        until (fv(xb)<>fv(xb)) or (n>b);
      end;
    pszi:=(fv(xa)*xb-fv(xb)*xa)/(fv(xa)-fv(xb));
    xa:=xb;
    xb:=pszi;
  until (abs(xb-xa)<1.0e-9) or (fv(pszi)=0);
end;

 procedure inicializalo;
 begin
  case aktiv of
  20:begin
       betan:=arcus(fin);
       n:=cos(betan);
     end;
  21:begin
       beta1:=arcus(fi1);
       beta2:=arcus(fi2);
       beta0:=(beta1+beta2)/2;
       n:=cos(beta0)*sin(beta1-beta0)/(beta1-beta0);
     end;
  22:begin
       betan:=arcus(fin);
       n:=cos(betan);
       ce:=tan(betan)/exp(n*ln(tan(betan/2)));
     end;
  23:begin
       beta1:=arcus(fi1);
       beta2:=arcus(fi2);
       n:=(ln(sin(beta1))-ln(sin(beta2)))/(ln(tan(beta1/2))-ln(tan(beta2/2)));
       ce:=sin(beta1)/n/exp(n*ln(tan(beta1/2)));
     end;
  24:begin
       beta1:=arcus(fi1);
       beta2:=arcus(fi2);
       n:=(cos(beta1)+cos(beta2))/2;
       ce:=sqr(2/n*sin(beta1/2)*sin(beta2/2));
     end;
  25:begin
       betan:=arcus(fin);
       n:=cos(betan);
       ce:=sqr(2/n*sqr(sin(betan/2)));
     end;
  26:begin
       betan:=arcus(fin);
       n:=sqr(cos(betan/2));
       ce:=0;
     end;
  27:begin
       beta1:=arcus(fi1);
       beta2:=arcus(fi2);
       if fi1=0 then
        begin
         ce:=1;
         betan:=pi/2-beta2/2;
        end
       else
       if fi2=0 then
        begin
         ce:=1;
         betan:=pi/2-beta1/2;
        end
       else
       if fi1=fi2 then
        begin
         ce:=1/cos(beta1);
         betan:=pi/2-beta1;
        end
       else
        begin
         ce:=(sin(beta2)*cos(beta1)-sin(beta1)*cos(beta2))/(sin(beta2)-sin(beta1));
         betan:=arctan(sin(beta1)/(ce-cos(beta1)));
        end;
       n:=sin(betan);
     end;
  41,43,45,46: betan:=arcus(fin);
  60:ce:=arcus(fin)+cotan(arcus(fin));
  61:ce:=pi/2;
  69:begin
      ce:=fia;
      betan:=-arcus(fik);
     end;
  107: betan:=arcus(fin);
  end;
  if aktiv in [27,46] then
    if ParametersForm1.Iranybox.Itemindex=0 then beta0:=fia else beta0:=-fia;
 end;

 procedure vetites(var aX,aY:integer);
 var p, beta, bX, bY, pszi, aa, bb, cc, gg, pp, qq, ss, tt: Double;
 begin
  if segede=False then
   begin
     lc:=lc-KM;
     if lc<-pi then lc:=lc+2*pi*(trunc(-180/pi*lc+180) div 360);
     if lc>pi then lc:=lc-2*pi*(trunc(180/pi*lc+180) div 360);
   end;
  beta:=pi/2-fc;
  p:=beta;
  case family of
  0:begin
     case aktiv of
     0: p:=beta;
     1: p:=2*sin(beta/2);
     2: p:=2*tan(beta/2);
     3: p:=tan(beta);
     4: p:=sin(beta);
     end;
      aX:=trunc(p*sin(lc)*Fold/1000/Vezuv);
      aY:=-trunc(p*cos(lc)*Fold/1000/Vezuv);
    end;
  1:begin
     case aktiv of
     20: p:=tan(betan)+beta-betan;
     21: p:=tan(beta0)/tan(beta1-beta0)*(beta1-beta0)+beta-beta0;
     22,23: p:=ce*exp(n*ln(tan(beta/2)));
     24,25: p:=sqrt(4/n*sqr(sin(beta/2))+ce);
     26: p:=sin(beta/2)/sqrt(n);
     27:begin
         if ParametersForm1.VegtelenChk.Checked then p:=sin(beta)/sin(betan)
         else p:=(ce+beta0)*sin(beta)/(beta0*sin(betan)+sin(betan+beta));
        end;
     end;
     aX:=trunc(p*sin(n*lc)*Fold/1000/Vezuv);
     aY:=-trunc(p*cos(n*lc)*Fold/1000/Vezuv);
    end;
  2:begin
     case aktiv of
     40: begin
          bX:=lc;
          bY:=fc;
         end;
     41: begin
          bX:=lc*cos(betan);
          bY:=fc;
         end;
     42: begin
          bX:=lc;
          bY:=sin(fc);
         end;
     43: begin
          bX:=lc*cos(betan);
          bY:=sin(fc)/cos(betan);
         end;
     44: begin
          bX:=lc;
          bY:=ln(tan(fc/2+pi/4));
         end;
     45: begin
          bX:=lc*cos(betan);
          bY:=cos(betan)*ln(tan(fc/2+pi/4));
         end;
     46: begin
          bX:=lc*cos(betan);
          bY:=(beta0*cos(betan)*(1-cos(fc))+sin(fc)*cos(betan))/cos(fc);
         end;
     end;
     aX:=trunc(bX*Fold/1000/Vezuv);
     aY:=trunc(bY*Fold/1000/Vezuv);
    end;
  3:begin
     case aktiv of
     60:begin
         p:=ce-fc;
         n:=cos(fc)/p*lc;
         bX:=p*sin(n);
         bY:=ce-p*cos(n);
        end;
     61:begin
         p:=ce-fc;
         if p<0.001 then n:=0 else n:=cos(fc)/p*lc;
         bX:=p*sin(n);
         bY:=ce-p*cos(n);
        end;
     62:begin
         if fc=0 then
          begin
           bX:=lc;
           bY:=0
          end
         else
          begin
           p:=cotan(fc);
           n:=lc*sin(fc);
           bX:=sin(n)*cotan(fc);
           bY:=fia*fc+(1-cos(n))*cotan(fc);
          end;
        end;
     63:begin
         if fc=0 then
          begin
           bX:=lc;
           bY:=0;
          end
         else
          begin
           n:=2*arctan(lc/2*sin(fc));
           p:=cotan(fc);
           bX:=sin(n)*p;
           bY:=fia*fc+(1-cos(n))*p;
          end;
        end;
     64:begin
         qq:=fc;
         if abs(fc)<0.02 then fc:=0.001;
         psziszamito(n);
         p:=cotan(fc);
         bX:=sin(n)*p;
         bY:=fia*fc+(1-cos(n))*p;
         fc:=qq;
        end;
     65:begin
         if fc=0 then
          begin
           bX:=2*tan(lc/2);
           bY:=0;
          end
         else
          begin
           n:=2*arctan(tan(fc/2)*tan(lc/2));
           p:=cotan(fc);
           bX:=sin(n)*p;
           bY:=1/sin(fc)-p*cos(n);
          end;
        end;
     66:begin
         bb:=abs(2*fc/pi);
         cc:=sqrt(1-sqr(bb));
         if abs(fc)<0.001 then
          begin
           bX:=lc;
           bY:=0;
          end
         else
         if abs(lc)<0.001 then
          begin
           bX:=0;
           bY:=sgn(fc)*pi*bb/(1+cc);
          end
         else
         if pi/2-abs(fc)<0.001 then
          begin
           bX:=0;
           bY:=sgn(fc)*pi;
          end
         else
          begin
           aa:=abs(pi/lc-lc/pi)/2;
           gg:=cc/(bb+cc-1);
           pp:=gg*(2/bb-1);
           qq:=sqr(aa)+gg;
           ss:=sqr(pp)+sqr(aa);
           tt:=gg-sqr(pp);
           bX:=sgn(lc)*pi*(aa*tt+sqrt(sqr(aa*tt)-ss*(sqr(gg)-sqr(pp))))/ss;
           bY:=sgn(fc)*pi*(pp*qq-aa*sqrt(ss*(sqr(aa)+1)-sqr(qq)))/ss;
          end;
        end;
     67:begin
         bb:=abs(2*fc/pi);
         cc:=sqrt(1-sqr(bb));
         if abs(lc)<0.001 then
          begin
           bX:=0;
           bY:=sgn(fc)*pi*bb/(1+cc);
          end
         else
          begin
           aa:=abs(pi/lc-lc/pi)/2;
           gg:=(cc*sqrt(1+sqr(aa))-aa*sqr(cc))/(1+sqr(aa*bb));
           bX:=sgn(lc)*pi*gg;
           bY:=sgn(fc)*pi*sqrt(1-sqr(gg)-2*aa*gg);
          end;
        end;
     68:begin
           if abs(fc)<0.001 then
            begin
             bX:=lc;
             bY:=0;
            end
           else
           if (abs(lc)<0.001) or (pi/2-abs(fc)<0.001) then
            begin
             bX:=0;
             bY:=fc;
            end
           else
            begin
             bb:=abs(2*fc/pi);
             cc:=(8*bb-sqr(sqr(bb))-2*sqr(bb)-5)/(2*sqr(bb)*bb-2*sqr(bb));
             gg:=sgn(abs(lc)-pi/2)*sqrt(sqr(2*lc/pi+pi/2/lc)-4);
             pp:=sqr(bb+cc)*(sqr(bb)+sqr(cc*gg)-1)+(1-sqr(bb))*(sqr(bb)*
               (sqr(bb+3*cc)+4*sqr(cc))+12*bb*sqr(cc)*cc+4*sqr(sqr(cc)));
             qq:=(gg*(sqr(bb+cc)+sqr(cc)-1)+2*sqrt(pp))/(4*(sqr(bb+cc))+sqr(gg));
             bX:=sgn(lc)*pi*qq/2;
             bY:=sgn(fc)*pi/2*sqrt(1+gg*abs(qq)-sqr(qq));
            end;
        end;
     69:begin
         if pi/2-abs(fc)<0.001 then
          begin
           bX:=0;
           bY:=2*sgn(fc);
          end
         else
          begin
           aa:=exp((1/2/ce)*ln((1+sin(betan))/(1-sin(betan))));
           bb:=exp((1/2/ce)*ln((1+sin(fc))/(1-sin(fc))));
           gg:=aa*bb;
           cc:=(gg+1/gg)/2+cos(lc/ce);
           bX:=2*sin(lc/ce)/cc;
           bY:=(gg-1/gg)/cc;
          end;
        end;
     70:begin
           if abs(lc)<0.001 then
            begin
             bX:=0;
             bY:=fc;
            end
           else
           if abs(fc)<0.001 then
            begin
             bX:=lc;
             bY:=0;
            end
           else
           if abs(pi/2-abs(lc))<0.001 then
            begin
             bX:=lc*cos(fc);
             bY:=pi/2*sin(fc);
            end
           else
            begin
             cc:=2.4674011;
             pp:=abs(pi*sin(fc));
             ss:=(cc-sqr(fc))/(pp-2*abs(fc));
             aa:=sqr(lc)/cc-1;
             bY:=sgn(fc)*(sqrt(sqr(ss)-aa*(cc-pp*ss-sqr(lc)))-ss)/aa;
             bX:=sgn(lc)*abs(lc)*sqrt(1-sqr(bY)/cc);
            end;
        end;
     end;
     aX:=trunc(bX*Fold/1000/Vezuv);
     aY:=trunc(bY*Fold/1000/Vezuv);
    end;
  4:begin
     case aktiv of
     80: begin
          bX:=cos(fc)*lc;
          bY:=fc;
         end;
     81: begin
          bX:=0.877382675*lc*sqrt(1-0.75*sqr(sin(fc)));
          bY:=1.316074013*arcsin(0.866025404*sin(fc));
         end;
     82: begin
          bX:=0.882025543*lc*(cos(fc)+1)/2;
          bY:=0.882025543*fc;
         end;
     83: begin
          psziszamito(pszi);
          bX:=0.882025543*lc*(cos(pszi)+1)/2;
          bY:=0.882025543*pszi;
         end;
     84: begin
          bY:=fc;
          bX:=1-4*sqr(fc/pi);
          if bX<=0 then bX:=0 else bX:=lc*sqrt(bX);
         end;
     85: begin
          psziszamito(pszi);
          bX:=0.900316316*lc*cos(pszi);
          bY:=1.414213562*sin(pszi);
         end;
     86: begin
          bX:=1-4*sqr(fc/pi);
          if bX<=0 then bX:=lc/2 else bX:=0.4222382*lc*(1+sqrt(bX));
          bY:=0.844476401*fc;
         end;
     87: begin
          psziszamito(pszi);
          bY:=0.844476401*pi/2*sin(pszi);
          bX:=0.4222382*lc*(1+cos(pszi));
         end;
     88: begin
          bY:=fc;
          bX:=0.866025404*lc*sqrt(1-0.303963551*sqr(fc));
         end;
     89: begin
          if abs(fc)<arcus(fis) then
           begin
            bX:=0.960415*sqrt(1-0.64*sqr(sin(fc)))*lc;
            bY:=1.30152*arcsin(0.8*sin(fc));
           end
          else
           begin
            psziszamito(pszi);
            if fis<65 then
             begin
              bX:=1.070223*cos(pszi)*lc;
              bY:=1.681102*sin(pszi)-sgn(fc)*0.285475;
             end
            else
             begin
              bX:=1.249039*cos(pszi)*lc;
              bY:=1.961985*sin(pszi)-sgn(fc)*0.583828;
             end;
           end;
         end;
     90: begin
          if fc<=0 then
           begin
            if lc<=arcus(-100) then aa:=arcus(-160);
            if (lc>arcus(-100)) and (lc<=arcus(-20)) then aa:=arcus(-60);
            if (lc>arcus(-20)) and (lc<=arcus(80)) then aa:=arcus(30);
            if lc>arcus(80) then aa:=arcus(140);
           end
          else
           begin
            if lc<=arcus(-40) then aa:=arcus(-100)
            else aa:=arcus(30);
           end;
          if abs(fc)<=arcus(40.7333) then
           begin
            bX:=cos(fc)*(lc-aa)+aa;
            bY:=fc;
           end
          else
           begin
            psziszamito(pszi);
            bX:=0.900316316*(lc-aa)*cos(pszi)+aa;
            bY:=1.414213562*sin(pszi)-sgn(fc)*0.05280;
           end;
         end;
     91: begin
          bY:=sgn(fc)*(0.95*abs(fc)+0.9/pi*sqr(fc));
          if abs(fc)<1.221730476 then
           begin
             pszi:=arcsin(bY/1.84466);
             bX:=lc/pi*(pi-1.84466+1.84466*cos(pszi));
           end
          else
           begin
             pszi:=arccos((4.39461-(0.7*pi-abs(bY)))/4.39461);
             bX:=4.39461*sin(pszi)*lc/pi;
           end;
         end;
     92: begin
          bY:=0.0273759*sqr(sqr(fc))*fc-0.107505*sqr(fc)*abs(fc)*fc+
            0.112579*sqr(fc)*fc+fc;
          if abs(fc)<=1.362578547
          then bX:=(1.22172+sqrt(2.115393-sqr(bY)))*
            ln(0.11679*abs(lc)+1)/0.31255*sgn(lc)
          else bX:=sqrt(38.4308-sqr(4.58448+abs(bY)))*
            ln(0.11679*abs(lc)+1)/0.31255*sgn(lc);
         end;
     93: begin
          bX:=(2.6666-0.3670*sqr(fc)-0.15*sqr(sqr(fc))+
            0.0379*sqr(sqr(fc))*sqr(fc))*lc/pi;
          bY:=0.96047*fc-0.00857*exp(6.41*ln(abs(fc)))*sgn(fc);
         end;
     94: begin
          bY:=fc;
          if (lc=0) or ((abs(fc)>arcus(89.9)) and ((fel) or (abs(lc)<arcus(91)))) then bX:=0
          else
           begin
            p:=(sqr(pi/2)+sqr(lc))/2/abs(lc);
            bX:=(abs(lc)-p+sqrt(sqr(p)-sqr(fc)))*sgn(lc);
           end;
         end;
     95: begin
          bY:=pi/2*sin(fc);
          if (abs(lc)<0.001) or ((abs(fc)>arcus(89.9)) and ((fel) or (abs(lc)<arcus(91)))) then bX:=0
          else
           begin
            bb:=(sqr(pi/2)/abs(lc)+abs(lc))/2;
            if sqr(bb)>sqr(bY) then gg:=sqrt(sqr(bb)-sqr(bY)) else gg:=0;
            bX:=sgn(lc)*(abs(lc)-bb+gg);
           end;
         end;
     96: begin
          bY:=fc;
          if lc=0 then bX:=0
          else
           begin
            p:=(sqr(pi/2)+sqr(lc))/2/abs(lc);
            if abs(lc)<=pi/2 then bX:=(abs(lc)-p+sqrt(sqr(p)-sqr(fc)))*sgn(lc)
            else
             begin
              if abs(fc)>=pi/2-0.001 then bX:=(abs(lc)-pi/2)*sgn(lc)
              else bX:=(abs(lc)-pi/2+sqrt(sqr(pi/2)-sqr(fc)))*sgn(lc);
             end;
           end;
         end;
     97: begin
          bY:=fc;
          bX:=lc*(pi/2-abs(fc))/(pi/2);
         end;
     98: begin
          if (abs(lc)<0.001) or (abs(fc)>arcus(89.9)) then bX:=0
          else bX:=2*sqrt(2)*lc*sin((pi/2-abs(fc))/2)/sqrt(pi);
          bY:=sqrt(pi)*(1-1.41421356*sin((pi/2-abs(fc))/2))*sgn(fc);
         end;
     99: begin
          bX:=lc/pi*(pi-abs(fc));
          bY:=fc;
         end;
     180: begin
          bX:=0.460658866*lc*sqrt(4-3*sin(abs(fc)));
          bY:=1.447202509*sgn(fc)*(2-sqrt(4-3*sin(abs(fc))));
         end;
     181:begin
         bb:=abs(2*fc/pi);
         cc:=sqrt(1-sqr(bb));
         if pi/2-abs(fc)<0.001 then
          begin
           bX:=0;
           bY:=sgn(fc)*pi;
          end
         else
         if abs(fc)<0.0001 then
          begin
           bX:=lc;
           bY:=0;
          end
         else
         if abs(lc)<0.0001 then
          begin
           bX:=0;
           bY:=sgn(fc)*pi*bb/(1+cc);
          end
         else
          begin
           aa:=abs(pi/lc-lc/pi)/2;
           gg:=bb/(1+cc);
           bX:=sgn(lc)*pi*(sqrt(sqr(aa)+1-sqr(gg))-aa);
           bY:=sgn(fc)*pi*gg;
          end;
         end;
     182:begin
           bY:=fc;
           gg:=4.478461;
           if fc<-pi/4 then aa:=3*sin(2*fc+pi)
           else
           if fc<0 then aa:=gg*3/2*sin(2/3*fc+2*pi/3)-1.5*gg+3
           else
           if fc<pi/6 then aa:=gg*sin(fc+4*pi/3)+gg+1.5
           else
           if fc<pi/3 then aa:=sin(6*fc+pi/2)/4+1.75
           else aa:=2*sin(3*fc-pi/2);
           bX:=aa*lc/pi;
         end;
     183:begin
           bY:=fc;
           gg:=4.478461;
           if fc<-pi/4 then aa:=sqrt((sqr(pi)/16-sqr(-fc-pi/4))*9/sqr(pi)*16)
           else
           if fc<0 then aa:=gg*3/2*sin(2/3*fc+2*pi/3)-1.5*gg+3
           else
           if fc<pi/6 then aa:=gg*sin(fc+4*pi/3)+gg+1.5
           else
           if fc<pi/3 then aa:=sin(6*fc+pi/2)/4+1.75
           else aa:=sqrt((sqr(pi)/36-sqr(fc-pi/3))*4/sqr(pi)*36);
           bX:=aa*lc/pi/2;
         end;
     end;
     aX:=trunc(bX*Fold/1000/Vezuv);
     aY:=trunc(bY*Fold/1000/Vezuv);
    end;
  5:begin
     case aktiv of
     100: begin
           bX:=2.828427125*cos(fc)*sin(lc/2)/sqrt(1+cos(fc)*cos(lc/2));
           bY:=1.414213562*sin(fc)/sqrt(1+cos(fc)*cos(lc/2));
          end;
     101: begin
           bX:=2*arccos(cos(fc)*cos(lc/2))*cos(fc)*sin(lc/2)/
             sqrt(1-sqr(cos(fc)*cos(lc/2)));
           bY:=arccos(cos(fc)*cos(lc/2))*sin(fc)/
             sqrt(1-sqr(cos(fc)*cos(lc/2)));
          end;
     102: begin
           bX:=(cos(arcus(fis))*lc+2*arccos(cos(fc)*cos(lc/2))*cos(fc)*sin(lc/2)/
             sqrt(1-sqr(cos(fc)*cos(lc/2))))/2;
           bY:=(fc+arccos(cos(fc)*cos(lc/2))*sin(fc)/
             sqrt(1-sqr(cos(fc)*cos(lc/2))))/2;
          end;
     103: begin
           bX:=0.93541*sqrt(8)*cos(fc)*sin(lc/2)/sqrt(cos(fc)*cos(lc/2)+1);
           bY:=sqrt(2)/0.93541*sin(fc)/sqrt(cos(fc)*cos(lc/2)+1);
          end;
     104: begin
           ss:=0.90631*sin(fc);
           cc:=sqrt(1-sqr(ss));
           bb:=sqrt(2/(1+cc*cos(lc/3)));
           bX:=2.66723*cc*bb*sin(lc/3);
           bY:=1.24104*ss*bb;
          end;
     105: begin
           ss:=sin(lc/2);
           cc:=cos(lc/2);
           tt:=sin(fc/2)/(cos(fc/2)+cc*sqrt(2*cos(fc)));
           bb:=sqrt(2/(1+sqr(tt)));
           qq:=sqrt((cos(fc/2)+sqrt(cos(fc)/2)*(cc+ss))/
             (cos(fc/2)+sqrt(cos(fc)/2)*(cc-ss)));
           bX:=5.828427125*(-2*ln(qq)+bb*(qq-1/qq));
           bY:=5.828427125*(-2*arctan(tt)+bb*tt*(qq+1/qq))
          end;
     106: begin
             aa:=sqrt(1-sqr(tan(fc/2)));
             cc:=1+aa*cos(lc/2);
             pp:=sin(lc/2)*aa/cc;
             qq:=tan(fc/2)/cc;
             bX:=4/3*pp*(3+sqr(pp)-3*sqr(qq));
             bY:=4/3*qq*(3+3*sqr(pp)-sqr(qq));
          end;
     107: begin
           bX:=(1+cos(fc))*sin(lc/2);
           bY:=(1+sin(betan)-cos(betan))/2+sin(fc)*cos(betan)-
             (1+cos(fc))*sin(betan)*cos(lc/2);
           if fin<>0 then beta0:=-arctan(cos(lc/2)/tan(betan))
           else beta0:=-pi/2;
          end;
     108:begin
           bX:=lc;
           gg:=4.478461;
           bb:=lc/2*11/12;
           if bb<-pi/4 then aa:=sqrt((sqr(pi)/16-sqr(-bb-pi/4))*9/sqr(pi)*16)
           else
           if bb<0 then aa:=gg*3/2*sin(2/3*bb+2*pi/3)-1.5*gg+3
           else
           if bb<pi/6 then aa:=gg*sin(bb+4*pi/3)+gg+1.5
           else
           if bb<pi/3 then aa:=sin(6*bb+pi/2)/4+1.75
           else aa:=sqrt((sqr(pi)/36-sqr(bb-pi/3))*4/sqr(pi)*36);
           bY:=aa*fc/pi*2;
         end;
     109:begin
           bX:=lc;
           bY:=fia2*sin(lc*fih)/fih+fc;
         end;
     110:begin
           bX:=lc;
           bY:=fia2*sin(lc*fih)/fih+sin(fc);
         end;
     end;
     aX:=trunc(bX*Fold/1000/Vezuv);
     aY:=trunc(bY*Fold/1000/Vezuv);
    end;
  end;
 end;

 procedure Vizsgal;
 var x12,y12: Integer;
     fi12,la12: Double;
  procedure hatarszamito(var x12,y12:Integer);
   function hataron(a1,a2,b1,b2,top: Double): Double;
   begin
     result:=a1+(a2-a1)*(top-b1)/(b2-b1);
   end;
  begin
   if not (aktiv in [65,94,95,98]) and (fi12<arcus(minfi)) then
          begin
           x12:=trunc(hataron(x1,x2,fca,fc,arcus(minfi)));
           y12:=trunc(hataron(y1,y2,fca,fc,arcus(minfi)));
          end;
   if (aktiv in [44,45]) and (fi12>-arcus(minfi)) then
          begin
           x12:=trunc(hataron(x1,x2,fca,fc,-arcus(minfi)));
           y12:=trunc(hataron(y1,y2,fca,fc,-arcus(minfi)));
          end;
   if (aktiv=65) and (la12>arcus(minfi)) then
          begin
           x12:=trunc(hataron(x1,x2,lca,lc,arcus(minfi)));
           y12:=trunc(hataron(y1,y2,lca,lc,arcus(minfi)));
          end;
   if (aktiv=65) and (la12<-arcus(minfi)) then
          begin
           x12:=trunc(hataron(x1,x2,lca,lc,-arcus(minfi)));
           y12:=trunc(hataron(y1,y2,lca,lc,-arcus(minfi)));
          end;
   if (aktiv in [94,95,98]) and (fel) and (la12>arcus(90)) then
          begin
           x12:=trunc(hataron(x1,x2,lca,lc,arcus(90)));
           y12:=trunc(hataron(y1,y2,lca,lc,arcus(90)));
          end;
   if (aktiv in [94,95,98]) and (fel) and (la12<-arcus(90)) then
          begin
           x12:=trunc(hataron(x1,x2,lca,lc,-arcus(90)));
           y12:=trunc(hataron(y1,y2,lca,lc,-arcus(90)));
          end;
   if x12<Baltop then
          begin
           x12:=Baltop;
           y12:=trunc(hataron(y1,y2,x1,x2,Baltop));
          end;
   if x12>Jobbtop then
          begin
           x12:=Jobbtop;
           y12:=trunc(hataron(y1,y2,x1,x2,Jobbtop));
          end;
   if y12<Lenntop then
          begin
           y12:=Lenntop;
           x12:=trunc(hataron(x1,x2,y1,y2,Lenntop));
          end;
   if y12>Fenntop then
          begin
           y12:=Fenntop;
           x12:=trunc(hataron(x1,x2,y1,y2,Fenntop));
          end;
  end;

 function kintie: Boolean;
 begin
   if (x2<Baltop) or (x2>Jobbtop) or (y2<Lenntop) or (y2>Fenntop)
    or ((aktiv<>65) and
     ((fc<arcus(minfi)) or ((aktiv in [44,45]) and (fc>-arcus(minfi)))))
    or (aktiv=65) and
     (abs(lc)>arcus(minfi))
    or ((aktiv=107) and (fc<beta0))
    or ((aktiv in [94,95,98]) and (fel) and (abs(lc)>arcus(90)))
   then result:=True else result:=False;
 end;

 function Atszel: Boolean;
 begin
   result:=False;
   case family of
   0:if (lca*lc<0) and (abs(lca-lc)>pi/18)
     and (abs(lca-lc)<35*pi/18) then result:=True;
   1:if (abs(lca-lc)>pi/8) or ((fc>1.56)
     and (abs(lca-lc)>pi/36))
     and not ((aktiv in [23,26]) and (fc>pi/2-0.1) and (fca>pi/2-0.1))
     then result:=True;
   2:if (lca*lc<0) and (abs(lca-lc)>pi/2) then result:=True;
   3:if (lca*lc<0) and (abs(lca-lc)>pi/2) then result:=True;
   4:if (lca*lc<0) and (abs(lca-lc)>pi/4)
     and (abs(fc)<pi/2-0.01) and (abs(fca)<pi/2-0.01) then result:=True;
   5:if (lca*lc<0) and (abs(lca-lc)>pi/2) then result:=True;
   end;
   if (aktiv=90) and
    (((fc<0) and (((lc<arcus(-100)) and (lca>arcus(-100)))
             or ((lca<arcus(-100)) and (lc>arcus(-100)))
             or ((lc<arcus(-20)) and (lca>arcus(-20)))
             or ((lca<arcus(-20)) and (lc>arcus(-20)))
             or ((lc<arcus(80)) and (lca>arcus(80)))
             or ((lca<arcus(80)) and (lc>arcus(80)))))
                  or
    ((fc>0) and (((lc<arcus(-40)) and (lca>arcus(-40)))
             or ((lca<arcus(-40)) and (lc>arcus(-40))))))
     then result:=True;
   if not OptionsForm.HosszuChk.Checked and (sqr(x2-x1)+sqr(y2-y1)>1000000) then result:=True;
 end;

 begin
   if q=1 then
    begin
     Kint:=False;
     vetites(x2,y2);
     if Kintie then Kint:=True
     else mozgat(x2,y2);
    end
   else
    begin
     x1:=x2;
     y1:=y2;
     vetites(x2,y2);
     if Kint=False then
      if kintie then
        begin
         Kint:=True;
         x12:=x2;
         y12:=y2;
         fi12:=fc;
         la12:=lc;
         if Atszel then mozgat(x2,y2)
         else
          begin
           hatarszamito(x12,y12);
           ir(x12,y12);
          end;
        end
      else
        begin
         if Atszel then mozgat(x2,y2)
         else ir(x2,y2);
        end
     else
      if not kintie then
        begin
         Kint:=False;
         x12:=x1;
         y12:=y1;
         fi12:=fca;
         la12:=lca;
         if Atszel then mozgat(x2,y2)
         else
          begin
           hatarszamito(x12,y12);
           mozgat(x12,y12);
           ir(x2,y2);
          end;
        end;
   end;
 end;

 procedure paralelkor;
 begin
   q:=0;
   la:=179.999+Tatu;
   repeat
     q:=q+1;
     la:=la-Tatu;
     if vi(la,-180) then la:=-179.999;
     if segede then seged(arcus(fi),arcus(la),fc,lc)
                              else
                                  begin
                                     fc:=arcus(fi);
                                     lc:=arcus(la);
                                  end;
     Vizsgal;
     lca:=lc;fca:=fc;
   until vi(la,-180);
 end;

 procedure Tartalomrajzolo;
 var u: Integer;
 begin
  q:=0;
  u:=0;
  Reset(txt);
  repeat
   readln(txt,fi,la);
   if (fi=0) and (la=0) then q:=0
   else
     begin
       fi:=fi+0.001;
       la:=la+0.001;
       q:=q+1;
       u:=u+1;
       if segede then seged(arcus(fi),arcus(la),fc,lc)
                                  else
                                   begin
                                    fc:=arcus(fi);
                                    lc:=arcus(la);
                                   end;
       Vizsgal;
       lca:=lc;fca:=fc;
       if u mod 2100=0 then
        begin
         Progpos:=Progpos+100/Prog;
         ProgressForm.ProgressBar1.Position:=Trunc(Progpos);
         Application.ProcessMessages;
         if Megse=True then exit;
        end;
       end;
  until eof(txt);
  CloseFile(txt);
 end;

 procedure deltavizsgalo(fok: TEdit;maxi: Byte; var egydelta: Byte);
 begin
  if Nagyitvizsgal(fok.Text)=True
  then
    begin
      egydelta:=StrToInt(fok.Text);
      if egydelta>maxi then rossz:=True;
    end
  else rossz:=True;
  if rossz=True then
       begin
         UjForm.Visible:=True;
         UjForm.PageControl1.ActivePage:=UjForm.Tartalombox;
         fok.SetFocus;
         Ervmsg;
       end;
 end;

begin
TRY
  Marvan:=False;
  StatusBar3.Visible:=False;
  Abra.Cursor:=crDefault;
  AssignFile(fil1,OptionsForm.parttxt.Text);
  AssignFile(fil2,OptionsForm.hatartxt.Text);
  AssignFile(fil3,OptionsForm.totxt.Text);
  if FileExists(OptionsForm.parttxt.text) then
   begin
    Reset(fil1);
    Progpart:=Trunc(41*FileSize(fil1)/1400000);
    CloseFile(fil1);
   end;
  if FileExists(OptionsForm.hatartxt.text) then
   begin
    Reset(fil2);
    Proghatar:=Trunc(5*FileSize(fil2)/170000);
    CloseFile(fil2);
   end;
  if FileExists(OptionsForm.totxt.text) then
   begin
    Reset(fil3);
    Progto:=Trunc(4*FileSize(fil3)/130000);
    CloseFile(fil3);
   end;

  Kint:=False;
  rossz:=False;
  if not Elso and not Zoomol then Etna2:=Etna;
  if (Zoomol=False) and (Lupe=True) then
    if Nagyitvizsgal(Nagyit.Text)=True then
       begin
         Etna:=StrToInt(Copy(Nagyit.Text,1,szamhossz2));
       end
    else
       begin
         Nagyit.SetFocus;
         Ervmsg;
         Exit;
       end;
  if Nagyitvizsgal(Meretarany.Text)=True then
       begin
         Vezuv:=StrToInt(Meretarany.Text);
       end
  else
       begin
         Meretarany.SetFocus;
         Ervmsg;
         Exit;
       end;
  if (Nagyitvizsgal(UjForm.Fok1.Text)=True) or (UjForm.Fok1.Text='0')
  then
    begin
       KM:=StrToInt(UjForm.Fok1.Text);
       if abs(KM)>180 then rossz:=True else KM:=arcus(KM);
    end
  else rossz:=True;
  if rossz=True then
       begin
         UjForm.Visible:=True;
         UjForm.PageControl1.ActivePage:=UjForm.Vetuletbox;
         UjForm.Fok1.SetFocus;
         Ervmsg;
         Exit;
       end;

  Deltavizsgalo(UjForm.Fok5,180,Delta1);
  if rossz=True then Exit;
  Deltavizsgalo(UjForm.Fok4,90,Delta2);
  if rossz=True then Exit;

  if UjForm.Ferdebtn.Checked then
  begin
   Deltavizsgalo(UjForm.Fok7,180,Delta3);
   if rossz=True then Exit;
   Deltavizsgalo(UjForm.Fok6,90,Delta4);
   if rossz=True then Exit;

  if (Nagyitvizsgal(UjForm.Fok2.Text)=True) or (UjForm.Fok2.Text='0')
  then
    begin
     f0:=StrToFloat(UjForm.Fok2.Text);
     if abs(f0)>90 then rossz:=True else f0:=arcus(f0);
    end
  else rossz:=True;
  if rossz=True then
       begin
         UjForm.Visible:=True;
         UjForm.PageControl1.ActivePage:=UjForm.Vetuletbox;
         UjForm.Fok2.SetFocus;
         Ervmsg;
         Exit;
       end;
  if (Nagyitvizsgal(UjForm.Fok3.Text)=True) or (UjForm.Fok3.Text='0')
  then
    begin
     l0:=StrToFloat(UjForm.Fok3.Text);
     if abs(l0)>180 then rossz:=True else l0:=arcus(l0);
    end
  else rossz:=True;
  if rossz then
       begin
         UjForm.Visible:=True;
         UjForm.PageControl1.ActivePage:=UjForm.Vetuletbox;
         UjForm.Fok3.SetFocus;
         Ervmsg;
         Exit;
       end;
 end;
 if Elso then
     begin
       Etna:=100;
       Etna2:=Etna;
       Vezuv3:=Vezuv;
       Mentes.Enabled:=True;
       Nyomtat.Enabled:=True;
       SpeedButton8.Enabled:=True;
       SpeedButton1.Enabled:=True;
       SpeedButton2.Enabled:=True;
       SpeedButton3.Enabled:=True;
       SpeedButton4.Enabled:=True;
       SpeedButton9.Enabled:=True;
       SpeedButton11.Enabled:=True;
     end;
 if plt then
  begin
   ProgressForm.ProgressLabel.Visible:=False;
   ProgressForm.ProgressLabel2.Visible:=True;
   ProgressForm.ProgressLabel3.Visible:=False;
  end
 else
 if nyom=True then
  begin
   ProgressForm.ProgressLabel.Visible:=False;
   ProgressForm.ProgressLabel2.Visible:=False;
   ProgressForm.ProgressLabel3.Visible:=True;
  end
 else
  begin
   ProgressForm.ProgressLabel.Visible:=True;
   ProgressForm.ProgressLabel2.Visible:=False;
   ProgressForm.ProgressLabel3.Visible:=False;
  end;
 ProgressForm.Show;
 ProgressForm.ProgressBar1.Position:=0;
 Application.ProcessMessages;
 Progpos:=0;
 Prog:=0;
 if not origomas then
 begin
  Omovex:=0;
  Omovey:=0;
 end;
 Megse:=False;
 Sfh:=False;
 if UjForm.Fokchk.Checked then Prog:=Prog+25;
 if UjForm.Segedchk.Checked and UjForm.FerdeBtn.Checked then Prog:=Prog+25;
 if UjForm.Kontichk.Checked then Prog:=Prog+Progpart;
 if UjForm.Orszagchk.Checked then Prog:=Prog+Proghatar;
 if UjForm.Tochk.Checked=True then Prog:=Prog+Progto;
 segede:=Ujform.Ferdebtn.Checked;
 family:=UjForm.Csalad.Itemindex;

if not Sajt2 then
begin
 SBHelyX:=Scrollbox1.HorzScrollBar.Position;
 SBHelyY:=Scrollbox1.VertScrollbar.Position;
end;
if Sajt3 then
begin
 SBHelyX:=0;
 SBHelyY:=0;
end;

inicializalo;
case aktiv of
2,3,22,23,27: minfi:=90-fik;
4: minfi:=0;
44,45,46: minfi:=-fik;
65: minfi:=fik;
else minfi:=-90;
end;

segede:=True;
q:=0;
if Crop=False then
begin
 {határoló vonalak}
 Tatuado(UjForm.ReszletBox1.ItemIndex);
 case family of
 0:
  begin
    la:=181;
    fc:=arcus(minfi);
    repeat la:=la-1;
           lc:=arcus(la);
           vetites(x2,y2);
           if q=0 then Elsotop else topvizsgalo;
    until la<-179;
  end;

 1:
  begin
   {külsõ paralel}
    la:=179.999+Tatu;
    fc:=arcus(minfi+0.001);
    fca:=fc;
    repeat la:=la-Tatu;
           lc:=arcus(la);
           vetites(x2,y2);
           if q=0 then Elsotop else topvizsgalo;
           lca:=lc;
    until vi(la,-180);

   {határoló meridiánok}
   Tatuado(UjForm.ReszletBox2.ItemIndex);
   for i:=0 to 1 do
    begin
    lc:=-(pi-0.00001)+i*2*(pi-0.00001);
    lca:=lc;
    fi:=89.999+Tatu;
    repeat fi:=fi-Tatu;
           if vi(fi,-90) then fi:=-89.999;
           fc:=arcus(fi);
           vetites(x2,y2);
           topvizsgalo;
           fca:=fc;
    until vi(fi,minfi);
    end;
  end;

 2:
  begin
    fc:=arcus(minfi+0.001);lc:=arcus(179.999);
    vetites(x2,y2);
    Elsotop;
    fc:=arcus(minfi+0.001);lc:=arcus(-179.999);
    vetites(x2,y2);
    topvizsgalo;
    fc:=-arcus(minfi+0.001);lc:=arcus(179.999);
    vetites(x2,y2);
    topvizsgalo;
    fc:=-arcus(minfi+0.001);lc:=arcus(-179.999);
    vetites(x2,y2);
    topvizsgalo;
  end;

 3,4,5:
  begin
   Tatuado(UjForm.ReszletBox2.ItemIndex);
   if aktiv in [108,109,110] then
   begin
    q:=0;
    for i:=0 to 1 do
     begin
      fc:=(2*i-1)*arcus(90);
      la:=179.999+Tatu;
      fca:=fc;
      repeat la:=la-Tatu;
             if vi(la,-180) then la:=-179.999;
             lc:=arcus(la);
             vetites(x2,y2);
             if q=0 then Elsotop else topvizsgalo;
             lca:=lc;
      until vi(la,-180);
     end;
   end
   else
   if aktiv=65 then
   begin
    q:=0;
    for i:=0 to 1 do
     begin
      lc:=(2*i-1)*arcus(minfi);
      fi:=89.999+Tatu;
      lca:=lc;
      repeat fi:=fi-Tatu;
             if vi(fi,-90) then fi:=-89.999;
             fc:=arcus(fi);
             vetites(x2,y2);
             if q=0 then Elsotop else topvizsgalo;
             fca:=fc;
      until vi(fi,-90);
     end;
   end
   else
   begin
    q:=0;
    for i:=0 to 1 do
     begin
      if (aktiv in [94,95,98]) and (fel) then lc:=(2*i-1)*arcus(89.999)
      else lc:=(2*i-1)*arcus(179.999);
      fi:=-minfi-0.001+Tatu;
      lca:=lc;
      repeat fi:=fi-Tatu;
             if vi(fi,-90) then fi:=-89.999;
             fc:=arcus(fi);
             vetites(x2,y2);
             if q=0 then Elsotop else topvizsgalo;
             fca:=fc;
      until vi(fi,minfi);
     end;
   end;
  end;
end;
if (aktiv=107) and (fin<>0) then
 begin
  lc:=0;
  fc:=-arctan(cos(lc/2)/tan(betan));
  vetites(x2,y2);
  topvizsgalo;
 end;
end;

if ((OptionsForm.Maigazit.Checked) and (Sajt=False)) or (Igazigaz=True) then
 begin
      if (Lx*(Szazalek/100)<Minmargomi) or (Ly*(Szazalek/100)<Minmargomi)
      then
         begin
          margox:=Lx-2*Minmargomi;
          margoy:=Ly-2*Minmargomi;
         end
      else
         begin
          margox:=Lx*(100-2*Szazalek)/100;
          margoy:=Ly*(100-2*Szazalek)/100;
         end;
    Vezuv2:=Vezuv;
    case OptionsForm.KerekComboBox.Itemindex of
    0: q:=1;
    1: q:=5;
    2: q:=10;
    3: q:=25;
    4: q:=50;
    end;
    if margox/(Jobbtop-Baltop)*(Fenntop-Lenntop)>margoy
       then Vezuv:=q*(trunc(Vezuv*(Fenntop-Lenntop)/margoy) div q+1)
    else Vezuv:=q*(trunc(Vezuv*(Jobbtop-Baltop)/margox) div q+1);
    Meretarany.Text:=IntToStr(Vezuv);
    Jobbtop:=trunc(Vezuv2/Vezuv*Jobbtop);
    Baltop:=trunc(Vezuv2/Vezuv*Baltop);
    Fenntop:=trunc(Vezuv2/Vezuv*Fenntop);
    Lenntop:=trunc(Vezuv2/Vezuv*Lenntop);
 end;
if Crop and Sajt then
 begin
    Jobbtop:=trunc(Vezuv3/Vezuv*Jobbtop);
    Baltop:=trunc(Vezuv3/Vezuv*Baltop);
    Fenntop:=trunc(Vezuv3/Vezuv*Fenntop);
    Lenntop:=trunc(Vezuv3/Vezuv*Lenntop);
 end;

TRY
if not Elso then
 begin
     Meminfo.dwLength:=Sizeof(Meminfo);
     GlobalMemoryStatus(Meminfo);
     Maxbmp:=trunc(0.3*(Bitmap.Width*Bitmap.Height+
       2*(MemInfo.dwAvailPhys+MemInfo.dwAvailPageFile)));
     Ujkep:=trunc(sqr(Etna*Vezuv3/Etna2/Vezuv)*Bitmap.Width*Bitmap.Height);
     if sqr(Etna*Vezuv3/Etna2/Vezuv)*Bitmap.Width*Bitmap.Height>Maxbmp then
     Etna:=trunc(Etna2*Vezuv/Vezuv3*sqrt(Maxbmp/Bitmap.Width/Bitmap.Height));
     if Etna*Vezuv3/Etna2/Vezuv*Bitmap.Width>5000 then Etna:=trunc(Etna2*Vezuv/Vezuv3*5000/Bitmap.Width);
 end;
EXCEPT
 begin
   {}
 end;
END;

if not plt and not nyom then Bitmap.Free;
Vezuv3:=Vezuv;

if not origomas then
if OptionsForm.Kozepigazit.Checked then
 begin
   Omovex:=trunc((Baltop+Jobbtop)/2);
   Omovey:=trunc((Fenntop+Lenntop)/2);
 end
else
 begin
   Omovex:=0;
   Omovey:=0;
 end;

if not plt and not nyom then
Begin

if OptionsForm.Abraigazit.Checked then
 begin
  Valos.Height:=trunc(Ly/1000*Felbontas);
  Valos.Width:=trunc(Lx/1000*Felbontas);
  if (Fenntop-omovey>Ly/2) or (Lenntop-omovey<-Ly/2) then
    if Fenntop-omovey>-Lenntop+omovey
     then Valos.Height:=trunc(2*(Fenntop-omovey)/1000*Felbontas)
     else Valos.Height:=trunc(-2*(Lenntop-omovey)/1000*Felbontas);
  if (Jobbtop-omovex>Lx/2) or (Baltop-omovex<-Lx/2) then
    if Jobbtop-omovex>-Baltop+omovex
     then Valos.Width:=trunc(2*(Jobbtop-omovex)/1000*Felbontas)
     else Valos.Width:=trunc(-2*(Baltop-omovex)/1000*Felbontas);
  lapmovex:=0;
  lapmovey:=0;
  komovex:=omovex;
  komovey:=omovey;
 end
else
 begin
  Valos.Height:=trunc((Fenntop-Lenntop)*Felbontas/1000);
  Valos.Width:=trunc((Jobbtop-Baltop)*Felbontas/1000);
  komovex:=trunc((Baltop+Jobbtop)/2);
  komovey:=trunc((Fenntop+Lenntop)/2);
  lapmovex:=omovex-komovex;
  lapmovey:=omovey-komovey;
 end;

lc:=Scrollbox1.Width/Scrollbox1.Height;
if Valos.Width<Valos.Height*lc then Valos.Width:=trunc(Valos.Height*lc);
if Valos.Height<Valos.Width/lc then Valos.Height:=trunc(Valos.Width/lc);
Valos.Width:=Valos.Width+trunc(100*Valos.Width/1600);
Valos.Height:=Valos.Height+trunc(70*Valos.Height/1100);

if (OptionsForm.Autozoom.Checked) and (Lupe=False)
  then
   begin
    Etna:=trunc(100*(Scrollbox1.Width-4)/Valos.Width);
    AWidth:=Scrollbox1.Width-4;
    AHeight:=Scrollbox1.Height-4;
   end
else
  begin
    AWidth:=trunc(Etna/100*Valos.Width);
    AHeight:=trunc(Etna/100*Valos.Height);
  end;

repeat
TRY
 Ex:=False;
 Bitmap:=TBitmap.Create;
 Bitmap.PixelFormat := pf4bit;
 Bitmap.Width:=AWidth;
 Bitmap.Height:=AHeight;
 Meminfo.dwLength:=Sizeof(Meminfo);
 GlobalMemoryStatus(Meminfo);
 FreeMem:=MemInfo.dwAvailPageFile div (Meminfo.dwTotalPageFile div 100);
 if Freemem<30 then raise EOutOfResources.Create('Virtual Memory Full');
 if Bitmap.Width>5000 then raise EOutOfResources.Create('Too Large Bitmap');
EXCEPT
 ON EOutOfResources DO
    BEGIN
     VEtna:=Etna;
     if Etna>1000 then Etna:=Etna-200 else if Etna>500 then Etna:=Etna-100
      else if Etna>300 then Etna:=Etna-50 else if Etna>20 then Etna:=Etna-10
      else Etna:=Etna-1;
     Bitmap.Free;
     Ex:=True;
     AWidth:=trunc(Etna/VEtna*AWidth);
     if AWidth<=Scrollbox1.Width-4 then AWidth:=Scrollbox1.Width-4
                    else Scrollbox1.HorzScrollbar.Position:=
                    Trunc((Scrollbox1.HorzScrollbar.Range-Scrollbox1.Width)/2);
     AHeight:=trunc(Etna/VEtna*AHeight);
     if AHeight<=Scrollbox1.Height-4 then AHeight:=Scrollbox1.Height-4
                     else Scrollbox1.VertScrollbar.Position:=
                     Trunc((Scrollbox1.VertScrollbar.Range-Scrollbox1.Height)/2);
    END;
END;
until Ex=False;

 if AWidth<Scrollbox1.Width-4 then AWidth:=Scrollbox1.Width-4;
 if AHeight<Scrollbox1.Height-4 then AHeight:=Scrollbox1.Height-4;

 Nagyit.Text:=IntToStr(Etna)+'%';
 Application.ProcessMessages;
 if Megse=True then
  begin
   ProgressForm.Close;
   Exit;
  end;
 OrigoX:=Trunc(Bitmap.Width/2);
 OrigoY:=Trunc(Bitmap.Height/2);

End;

 if not Crop then
 begin
  Lenntop:=Lenntop-4;
  Fenntop:=Fenntop+4;
  Baltop:=Baltop-4;
  Jobbtop:=Jobbtop+4;
 end;

 if UjForm.Polusbox.Itemindex=0 then north:=True else north:=False;
 ProgressForm.ProgressBar1.Position:=3;

if (OptionsForm.LapOn.Checked) and (plt=False) and (nyom=False) then
 begin
   Bitmap.Canvas.Pen.Color:=clLtGray;
   if OptionsForm.Lapmilyen.Itemindex=1 then Bitmap.Canvas.Brush.Color:=clLtGray
   else Bitmap.Canvas.Brush.Color:=clWhite;
   Bitmap.Canvas.Rectangle(OrigoX+trunc((-Lx/2+lapmovex)*Felbontas*Etna/100000),
                           OrigoY-trunc((-Ly/2+lapmovey)*Felbontas*Etna/100000),
                           OrigoX+trunc((Lx/2+lapmovex)*Felbontas*Etna/100000),
                           OrigoY-trunc((Ly/2+lapmovey)*Felbontas*Etna/100000));
 end;
 segede:=Ujform.Ferdebtn.Checked;

for j:=4 downto 0 do
begin

if LayersForm.RetegBox.Items[j]='Segédfokhálózat' then
begin

{segédfokhálózat}
if UjForm.Segedchk.Checked and UjForm.Segedchk.Enabled then
begin
 Vastagado(OptionsForm.Vas5.Value);
 Segede:=False;
 Szinado(UjForm.Szin2);

 {segédhosszúsági körök}
 Tatuado(UjForm.ReszletBox4.ItemIndex);
 for i:=0 to 2*trunc(180/Delta3) do
   begin
    q:=0;
    fi:=89.999;
    if aktiv in [44,45] then fi:=-minfi-0.001;
    la:=(i-trunc(180/Delta3))*Delta3+0.001;
    repeat q:=q+1;
           if q>2 then fi:=fi-Tatu;
           if vi(fi,-90) then fi:=-89.999;
           fc:=arcus(fi);
           lc:=arcus(la);
           Vizsgal;
           lca:=lc;fca:=fc;
    until vi(fi,minfi);
    Progpos:=Progpos+100/Prog*18*Delta1/360;
    ProgressForm.ProgressBar1.Position:=Trunc(Progpos);
    Application.ProcessMessages;
    if Megse=True then
     begin
      ProgressForm.Close;
      Exit;
     end;
   end;

 {segédszélességi körök}
  Tatuado(UjForm.ReszletBox3.ItemIndex);
  for i:=0 to 180 div delta4 do
         if delta2*(89 div delta4)-i*delta4<minfi then
          begin
           mike:=i;
           Break;
          end;
  for i:=0 to mike do
   begin
    if i=0 then Continue;
    fi:=delta4*(89 div delta4)-(i-1)*Delta4+0.001;
    paralelkor;
    Progpos:=progpos+100/Prog*7/(mike+1);
    ProgressForm.ProgressBar1.Position:=Trunc(Progpos);
    Application.ProcessMessages;
    if Megse=True then
     begin
      ProgressForm.Close;
      Exit;
     end;
   end;

  Segede:=True;
end;

end;

if LayersForm.RetegBox.Items[j]='Fokhálózat' then
begin

AssignFile(DebugFile,'debug1.log');
Rewrite(DebugFile);
Szinado(Ujform.Szin1);
if UjForm.Fokchk.Checked=True then
begin
 {hosszúsági körök}
 Tatuado(UjForm.ReszletBox2.ItemIndex);
 loopint := 2*trunc(180/Delta1);
 i:=0;
 repeat
    Writeln(DebugFile,'Next step: ',i);

    q:=0;
    fi:=89.995;
    la:=(i-trunc(180/Delta1))*Delta1+0.01;

    Writeln(DebugFile,i,' ',la);

    if vi(la,0) then Vastagado(OptionsForm.Vas3.Value) else Vastagado(OptionsForm.Vas1.Value);
    repeat q:=q+1;
           if q>2 then fi:=fi-Tatu;
           if vi(fi,-90) then fi:=-89.995;
           if segede then seged(arcus(fi),arcus(la),fc,lc)
           else
              begin
               fc:=arcus(fi);
               lc:=arcus(la);
              end;
           Vizsgal;
           lca:=lc;fca:=fc;
    until vi(fi,-90);
    Progpos:=Progpos+100/Prog*18*Delta1/360;
    ProgressForm.ProgressBar1.Position:=Trunc(Progpos);
    Application.ProcessMessages;
    if Megse=True then
     begin
      Writeln(DebugFile,'Megse');
      ProgressForm.Close;
      Exit;
     end;
    i:=i+1;
    Writeln(DebugFile,'end of iteration step no. ',i );
 until i>loopint;

 {térítõk,sarkkörök}
 Tatuado(UjForm.ReszletBox1.ItemIndex);
 if UjForm.Teritochk.Checked=True then
 for i:=1 to 4 do
 begin
  Vastagado(OptionsForm.Vas4.Value);
  case i of
  1: fi:=66.5;
  2: fi:=23.5;
  3: fi:=-23.5;
  4: fi:=-66.5;
  end;
  paralelkor;
 end;
 CloseFile(DebugFile);

 {szélességi körök}
  for i:=0 to 180 div delta2 do
         if delta2*(89 div delta2)-i*delta2<-89 then
          begin
           mike:=i;
           Break;
          end;
  for i:=0 to mike do
   begin
    if i=0 then Continue;
    fi:=delta2*(89 div delta2)-(i-1)*Delta2+0.01;
    if vi(fi,0) then Vastagado(OptionsForm.Vas2.Value) else Vastagado(OptionsForm.Vas1.Value);
    paralelkor;
    Progpos:=progpos+100/Prog*7/(mike+1);
    ProgressForm.ProgressBar1.Position:=Trunc(Progpos);
    Application.ProcessMessages;
    if Megse=True then
     begin
      ProgressForm.Close;
      Exit;
     end;
   end;
 if Megse=True then
  begin
   ProgressForm.Close;
   Exit;
  end;
end;

{határoló vonalak}
 segede:=True;
 Vastagado(OptionsForm.Vas1.Value);
 Tatuado(UjForm.ReszletBox1.ItemIndex);
 case family of

 0:begin
    q:=0;
    la:=179.999+Tatu;
    fc:=arcus(minfi+0.001);
    fca:=fc;
    repeat la:=la-Tatu;
           if vi(la,-180) then la:=-179.999;
           lc:=arcus(la);
           q:=q+1;
           Vizsgal;
           lca:=lc;
    until vi(la,-180);
   end;

 1:begin
   {külsõ paralel}
    q:=0;
    la:=179.999+Tatu;
    fc:=arcus(minfi+0.001);
    fca:=fc;
    repeat la:=la-Tatu;
           if vi(la,-180) then la:=-179.999;
           lc:=arcus(la);
           q:=q+1;
           Vizsgal;
           lca:=lc;
    until vi(la,-180);
   {határoló meridiánok}
   Tatuado(UjForm.ReszletBox2.ItemIndex);
   for i:=0 to 1 do
    begin
    q:=0;
    lc:=-(pi-0.00001)+i*2*(pi-0.00001);
    lca:=lc;
    fi:=89.999+Tatu;
    repeat fi:=fi-Tatu;
           if vi(fi,-90) then fi:=-89.999;
           fc:=arcus(fi);
           q:=q+1;
           Vizsgal;
           fca:=fc;
    until vi(fi,-90);
    end;
   {pólusvonal}
   Tatuado(UjForm.ReszletBox1.ItemIndex);
   if aktiv in [20,21,24,25] then
   begin
    q:=0;
    fc:=arcus(89.999);
    la:=179.999+Tatu;
    fca:=fc;
    repeat la:=la-Tatu;
           if vi(la,-180) then la:=-179.999;
           lc:=arcus(la);
           q:=q+1;
           Vizsgal;
           lca:=lc;
    until vi(la,-180);
   end;
  end;

 2,3,4,5:begin
 if (family in [2,4,5]) or (aktiv=69) and not (aktiv in [94,95,98,181]) then begin
    {határoló szélességek}
    Tatuado(UjForm.ReszletBox1.ItemIndex);
    for i:=0 to 1 do
     begin
      q:=0;
      fc:=(2*i-1)*arcus(minfi+0.001);
      la:=179.999+Tatu;
      fca:=fc;
      repeat la:=la-Tatu;
             if vi(la,-180) then la:=-179.999;
             lc:=arcus(la);
             q:=q+1;
             Vizsgal;
             lca:=lc;
      until vi(la,-180);
     end;
 end;
    {határoló meridiánok}
    Tatuado(UjForm.ReszletBox2.ItemIndex);
    for i:=0 to 1 do
     begin
      q:=0;
      if aktiv=65 then lc:=(2*i-1)*arcus(minfi)
      else if (aktiv in [94,95,98]) and (fel) then lc:=(2*i-1)*arcus(89.999)
      else lc:=(2*i-1)*arcus(179.999);
      fi:=89.999+Tatu;
      lca:=lc;
      repeat fi:=fi-Tatu;
             if vi(fi,-90) then fi:=-89.999;
             fc:=arcus(fi);
             q:=q+1;
             Vizsgal;
             fca:=fc;
      until vi(fi,-90);
     end;
   end;

 end;

if (aktiv=107) and (fin<>0) then
 begin
  Tatuado(UjForm.ReszletBox1.ItemIndex);
  q:=0;
  la:=179.999+Tatu;
  repeat
    la:=la-Tatu;
    lc:=arcus(la);
    fc:=-arctan(cos(lc/2)/tan(betan));
    q:=q+1;
    Vizsgal;
    fca:=fc;
    lca:=lc;
  until vi(la,-180);
 end;

if aktiv=90 then
 for i:=1 to 8 do
 begin
  q:=0;
  case i of
  1: lc:=arcus(-40.001);
  2: lc:=arcus(-39.999);
  3: lc:=arcus(-100.001);
  4: lc:=arcus(-99.999);
  5: lc:=arcus(-20.001);
  6: lc:=arcus(-19.999);
  7: lc:=arcus(79.999);
  8: lc:=arcus(80.001);
  end;
  if i in [1,2] then fi:=89.999+Tatu else fi:=0;
  lca:=lc;
  repeat
     fi:=fi-Tatu;
     if vi(fi,0) then fi:=0;
     if vi(fi,-90) then fi:=-89.999;
     fc:=arcus(fi);
     q:=q+1;
     Vizsgal;
     fca:=fc;
     if (i in [1,2]) and (vi(fi,0)) then fi:=-90;
  until vi(fi,-90);
 end;

 segede:=Ujform.Ferdebtn.Checked;
 Application.ProcessMessages;
 if Megse=True then
  begin
   ProgressForm.Close;
   Exit;
  end;
  Szeles.Text:=FloatToStr(Atszamit(3,Egyseg.Itemindex,Jobbtop-Baltop));
  Magas.Text:=FloatToStr(Atszamit(3,Egyseg.Itemindex,Fenntop-Lenntop));

end;

SetCurrentDir(Alapdir);
if LayersForm.RetegBox.Items[j]='Partvonalak' then
begin

{kontinensek}
if UjForm.Kontichk.Checked then
 begin
 Vastagado(OptionsForm.Vas6.Value);
 Szinado(Ujform.Szin3);
 AssignFile(txt,OptionsForm.parttxt.Text);
 if FileExists(OptionsForm.parttxt.Text) then Tartalomrajzolo
 else MessageDlg(OptionsForm.parttxt.Text+' nem található',mtError, [mbOK], 0);
 if Megse=True then
  begin
   ProgressForm.Close;
   Exit;
  end;
end;

end;

if LayersForm.RetegBox.Items[j]='Országhatárok' then
begin

{országhatárok}
if UjForm.Orszagchk.Checked then
 begin
 Vastagado(OptionsForm.Vas7.Value);
 Szinado(Ujform.Szin4);
 AssignFile(txt,OptionsForm.hatartxt.Text);
 if FileExists(OptionsForm.hatartxt.Text) then Tartalomrajzolo
 else MessageDlg(OptionsForm.hatartxt.Text+' nem található',mtError, [mbOK], 0);
 if Megse=True then
  begin
   ProgressForm.Close;
   Exit;
  end;
end;

end;

if LayersForm.RetegBox.Items[j]='Tavak' then
begin

{tavak}
if UjForm.Tochk.Checked then
 begin
 Vastagado(OptionsForm.Vas8.Value);
 Szinado(Ujform.Szin5);
 AssignFile(txt,OptionsForm.totxt.Text);
 if FileExists(OptionsForm.totxt.Text) then Tartalomrajzolo
 else MessageDlg(OptionsForm.totxt.Text+' nem található',mtError, [mbOK], 0);
 if Megse=True then
  begin
   ProgressForm.Close;
   Exit;
  end;
end;

end;

end;

{Ábra megvaltoztatása}
Abra.Width:=AWidth;
Abra.Height:=AHeight;
Scr.x:=Scrollbox1.Width;
Scr.y:=Scrollbox1.Height;

 if Sajt2 then
  begin
   Scrollbox1.HorzScrollBar.Position:=Trunc(Abra.Width/SBHelyx*Zoom.x-Scrollbox1.Width/2);
   Scrollbox1.VertScrollBar.Position:=Trunc(Abra.Height/SBHelyy*Zoom.y-Scrollbox1.Height/2);
  end;
 if Zoomol or Lupe2 then
  begin
   Scrollbox1.HorzScrollBar.Position:=Trunc(Etna/Etna2*Zoom.x-Scrollbox1.Width/2);
   Scrollbox1.VertScrollBar.Position:=Trunc(Etna/Etna2*Zoom.y-Scrollbox1.Height/2);
  end;
 if (not Zoomol and not Lupe2 and not Sajt2 and not Vetvalt) or Sajt3 then
  begin
   if SBHelyX=0
    then Scrollbox1.HorzScrollBar.Position:=
     trunc((Scrollbox1.HorzScrollBar.Range-Scrollbox1.Width)/2)
    else Scrollbox1.HorzScrollBar.Position:=SBHelyX;
   if SBHelyY=0
    then Scrollbox1.VertScrollbar.Position:=
     trunc((Scrollbox1.VertScrollbar.Range-Scrollbox1.Height)/2)
    else Scrollbox1.VertScrollbar.Position:=SBHelyY;
  end;
if not Plt and not nyom then Abra.Picture.Graphic:=Bitmap;

if not OptionsForm.Kozepigazit.Checked then Speedbutton10.Enabled:=True;
if Elso then Elso:=False;
if Sajt then SpeedButton7.Enabled:=True;
Lupe2:=False;
Sajt2:=False;
Sajt3:=False;
Vetvalt:=False;
ProgressForm.ProgressBar1.Position:=100;
ProgressForm.Close;
Plusz:='vetület';
case aktiv of
0..4: Plusz:='valós síkvetület';
20..39: Plusz:='valós kúpvetület';
40..59: Plusz:='valós hengervetület';
60,61: Plusz:='képzetes kúpvetület';
66..67,70,81..84,86..88,91,92,94,99,180,104,181: Plusz:='vetülete';
end;
StatusBar1.Panels[2].Text:=Vet[aktiv]+' '+Plusz;
if segede then
  StatusBar1.Panels[3].Text:='Segédpólus: '+UjForm.Fok2.Text+' fok szélesség, '+
  UjForm.Fok3.Text+' fok hosszúság' else StatusBar1.Panels[3].Text:=' ';
EXCEPT
  ProgressForm.Close;
  MessageDlg('Az ábra megrajzolása nem sikerült.',mtError,[mbOK],0);
END;
end;

procedure TMainForm.NagyitChange(Sender: TObject);
begin
  Zoomol:=False;
  Lupe:=True;
  Lupe2:=True;
  zoom.x:=Scrollbox1.HorzScrollBar.Position+trunc(Scrollbox1.Width/2);
  zoom.y:=Scrollbox1.VertScrollBar.Position+trunc(Scrollbox1.Height/2);
  if Nagyit.Itemindex=7 then
                          begin
                           Lupe:=False;
                           Lupe2:=False;
                           Exit;
                          end;
end;

procedure TMainForm.MentesClick(Sender: TObject);
var
  i: byte;
begin
  if (SaveDialog1.FileName[Length(SaveDialog1.FileName)-3]='.')
  and (Length(SaveDialog1.FileName)>5)
  then SaveDialog1.FileName:=Copy(SaveDialog1.FileName,1,Length(SaveDialog1.FileName)-4);
  if SaveDialog1.Execute then
  begin
    SaveDialog1.InitialDir:=ExtractFilePath(SaveDialog1.FileName);
    if FileExists(SaveDialog1.FileName) then
      if MessageDlg(Format('%s már létezik. Felülírja?', [SaveDialog1.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;
    if SaveDialog1.FilterIndex=3 then
    begin
      jp:=TJPegImage.Create;
      TRY TRY
       jp.Assign(Abra.Picture.Graphic);
       if Abra.Picture.Graphic<>nil then jp.SaveToFile(SaveDialog1.FileName);
      EXCEPT
       MessageDlg('Az elmentés nem sikerült.',mtConfirmation,[mbOK],0);
      END;
      FINALLY
       jp.Free;
      END; 
    end
    else
    if SaveDialog1.FilterIndex=2 then
    begin
     if Abra.Picture.Graphic<>nil then
       Abra.Picture.SaveToFile(SaveDialog1.FileName);
    end
    else
    begin
     AssignFile(Filesv,SaveDialog1.FileName);
     Rewrite(Filesv);
     Plt:=True;
     Writeln(Filesv,'in;');
     Writeln(Filesv,'ip0 0 ',trunc(Lx),' ',trunc(Ly),';');
     Writeln(Filesv,'sc',-trunc(Lx/2),' ',trunc(Lx/2),' ',
       -trunc(Ly/2),' ',trunc(Ly/2),';');
     Writeln(Filesv,'sp1;');
     FrissitClick(Mentes);
     CloseFile(Filesv);
     Plt:=False;
    end;
  end;
end;

procedure TMainForm.NevjegyClick(Sender: TObject);
begin
  AboutForm.ShowModal;
end;

procedure TMainForm.BeallitClick(Sender: TObject);
begin
  UjForm.Visible:=True;
  UjForm.BitBtn3Click(Beallit);
  UjForm.FormActivate(Beallit);
end;

procedure TMainForm.PapirmenuClick(Sender: TObject);
begin
  PageForm.Showmodal;
end;

procedure TMainForm.EgysegChange(Sender: TObject);
var i: Byte;
begin
   i:=PageForm.PapirCombobox.Itemindex;
   Valt:=True;
   Eta:=Egyseg.Itemindex;
   Minmargo:=Atszamit(3,Eta,Minmargomi);
   OptionsForm.LegalabbEdit.Text:=Format('%-2.4g ',[Minmargo])+SI[Eta];
   PageForm.PapirszelesEdit.Text:=Format('%-2.7g ',
     [Lapx[i,Eta]])+SI[Eta];
   PageForm.PapirmagasEdit.Text:=Format('%-2.7g ',
     [Lapy[i,Eta]])+SI[Eta];
   Szeles.Text:=FloatToStr(Atszamit(3,Egyseg.Itemindex,Jobbtop-Baltop));
   Magas.Text:=FloatToStr(Atszamit(3,Egyseg.Itemindex,Fenntop-Lenntop));
   if PageForm.Allobtn.Checked then
       begin
          MainForm.Lapszeles.Text:=Format('%-2.6g ',[Lapy[i,Eta]]);
          MainForm.Lapmagas.Text:=Format('%-2.6g ',[Lapx[i,Eta]]);
       end
      else
       begin
          MainForm.Lapszeles.Text:=Format('%-2.6g ',[Lapx[i,Eta]]);
          MainForm.Lapmagas.Text:=Format('%-2.6g ',[Lapy[i,Eta]]);
       end;
end;

procedure TMainForm.EszkoztareClick(Sender: TObject);
begin
  Eszkoztare.Checked:=not Eszkoztare.Checked;
  Eszkoztar.Visible:=not Eszkoztar.Visible;
  if Eszkoztare.Checked=False then
   begin
     Meretezo.Top:=Meretezo.Top-28;
     Scrollbox1.Top:=Scrollbox1.Top-28;
     Scrollbox1.Height:=Scrollbox1.Height+28;
   end
  else
   begin
     Meretezo.Top:=Meretezo.Top+28;
     Scrollbox1.Height:=Scrollbox1.Height-28;
     Scrollbox1.Top:=Scrollbox1.Top+28;
   end;
end;

procedure TMainForm.NagyitKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then
  begin
   Edit1.TabStop:=True;
   Edit1.SetFocus;
  end
 else
  if not (Key in ['0'..'9',#8]) then Key:=#0;
end;

procedure TMainForm.MeretaranyKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then
  begin
   Edit1.TabStop:=True;
   Edit1.SetFocus;
  end
 else
  if not (Key in ['0'..'9',#8]) then Key:=#0
   else
    begin
     Sajt:=True;
     Sajt2:=True;
     zoom.x:=Scrollbox1.HorzScrollBar.Position+trunc(Scrollbox1.Width/2);
     zoom.y:=Scrollbox1.VertScrollBar.Position+trunc(Scrollbox1.Height/2);
     SBHelyx:=Abra.Width;
     SBHelyy:=Abra.Height;
    end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var Status: Integer;
begin
  Bitmap.FreeImage;
  if MessageDlg('Biztosan ki akar lépni?', mtConfirmation, [mbYes, mbNo],0)=idNo
    then CanClose:=False else
     begin
      SetCurrentDir(Alapdir);
      case WindowState of
      wsNormal:
       begin
        IniFile.WriteInteger('Ablak','Fent',Top);
        IniFile.WriteInteger('Ablak','Baloldal',Left);
        IniFile.WriteInteger('Ablak','Szelesseg',Width);
        IniFile.WriteInteger('Ablak','Magassag',Height);
        Status:=1;
       end;
      wsMinimized: Status:=2;
      wsMaximized: Status:=3;
      end;
      if not Active then Status:=2;
      IniFile.WriteInteger('Ablak','Allapot',Status);
      if Valt then
       if MessageDlg('Elmenti a beállításokat?', mtConfirmation,
        [mbYes, mbNo],0)=idYes then
        begin
         IniFile.WriteString('Adatbazis','Partok',OptionsForm.parttxt.Text);
         IniFile.WriteString('Adatbazis','Hatarok',OptionsForm.hatartxt.Text);
         IniFile.WriteString('Adatbazis','Tavak',OptionsForm.totxt.Text);
         IniFile.WriteBool('Meretezes','Abraigazitas',OptionsForm.Abraigazit.Checked);
         IniFile.WriteBool('Meretezes','Maigazitas',OptionsForm.Maigazit.Checked);
         IniFile.WriteBool('Meretezes','Autozoom',OptionsForm.Autozoom.Checked);
         IniFile.WriteBool('Meretezes','Kozepreigazitas',OptionsForm.Kozepigazit.Checked);
         IniFile.WriteBool('Megjelenites','Lap',OptionsForm.LapOn.Checked);
         IniFile.WriteInteger('Megjelenites','Laphogyan',OptionsForm.Lapmilyen.Itemindex);
         IniFile.WriteBool('Megjelenites','Hosszuvonal',OptionsForm.HosszuChk.Checked);
         IniFile.WriteInteger('Megjelenites','Fokhalozat',OptionsForm.Vas1.Value);
         IniFile.WriteInteger('Megjelenites','Egyenlito',OptionsForm.Vas2.Value);
         IniFile.WriteInteger('Megjelenites','Kezdomeridian',OptionsForm.Vas3.Value);
         IniFile.WriteInteger('Megjelenites','Teritok',OptionsForm.Vas4.Value);
         IniFile.WriteInteger('Megjelenites','Segedfokhalozat',OptionsForm.Vas5.Value);
         IniFile.WriteInteger('Megjelenites','Partok',OptionsForm.Vas6.Value);
         IniFile.WriteInteger('Megjelenites','Hatarok',OptionsForm.Vas7.Value);
         IniFile.WriteInteger('Megjelenites','Tavak',OptionsForm.Vas8.Value);
         if PageForm.PapirCombobox.Itemindex<6 then
         IniFile.WriteInteger('Papir','Meret',PageForm.PapirCombobox.Itemindex);
         IniFile.WriteBool('Papir','Tajolas',PageForm.AlloBtn.Checked);
         IniFile.WriteString('Meretezes','Margo1',OptionsForm.SzazalekEdit.Text);
         IniFile.WriteString('Meretezes','Margo2',OptionsForm.LegalabbEdit.Text);
         IniFile.WriteInteger('Meretezes','Kerekites',OptionsForm.KerekCombobox.Itemindex);
         IniFile.WriteInteger('Egyseg','Egyseg',Egyseg.Itemindex);
        end;
      IniFile.Destroy;
      CanClose:=True;
      Zarora:=True;
     end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
 if Zarora=False then
 begin
  Eszkoztar.Width:=Width-8;
  Meretezo.Width:=Width-8;
  Scrollbox1.Width:=Width-6;
  if Eszkoztare.Checked then Scrollbox1.Height:=ClientHeight-25
                        else Scrollbox1.Height:=ClientHeight;
  if Meretezoe.Checked then Scrollbox1.Height:=Scrollbox1.Height-25;
  if Statuszsore.Checked then Scrollbox1.Height:=Scrollbox1.Height-25;
  StatusBar2.Top:=StatusBar1.Top;
  StatusBar2.Height:=StatusBar1.Height;
  StatusBar3.Top:=StatusBar1.Top;
  StatusBar3.Height:=StatusBar1.Height;
  StatusBar1.Panels[2].Width:=Width-382;
 end;
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
  ifmarvan(Abra.Canvas);
  Abra.Cursor:=crZoomin;
  Mer:=False;
  StatusBar3.Visible:=False;
end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin
  ifmarvan(Abra.Canvas);
  Abra.Cursor:=crZoomout;
  Mer:=False;
  StatusBar3.Visible:=False;
end;

procedure TMainForm.SpeedButton4Click(Sender: TObject);
begin
  ifmarvan(Abra.Canvas);
  Abra.Cursor:=crCrop;
  Mer:=False;
  StatusBar3.Visible:=False;
end;

procedure TMainForm.TeljesClick(Sender: TObject);
begin
  Crop:=False;
  Teljes.Enabled:=False;
  SpeedButton6.Enabled:=False;
  FrissitClick(Teljes);
end;

procedure TMainForm.EgyebClick(Sender: TObject);
begin
  OptionsForm.Showmodal;
end;

procedure TMainForm.SpeedButton7Click(Sender: TObject);
begin
  Sajt:=False;
  Igazigaz:=True;
  FrissitClick(SpeedButton7);
  SpeedButton7.Enabled:=False;
  Igazigaz:=False;
end;

procedure TMainForm.StatuszsoreClick(Sender: TObject);
begin
  Statuszsore.Checked:=not Statuszsore.Checked;
  if Statuszsore.Checked=False
   then
    begin
     StatusBar2.Visible:=False;
     StatusBar1.Visible:=False;
     ScrollBox1.Height:=ScrollBox1.Height+25;
    end
   else
    begin
     StatusBar2.Visible:=True;
     StatusBar1.Visible:=True;
     ScrollBox1.Height:=ScrollBox1.Height-25;
    end;
end;

procedure TMainForm.MeretezoeClick(Sender: TObject);
begin
  Meretezoe.Checked:=not Meretezoe.Checked;
  Meretezo.Visible:=not Meretezo.Visible;
  if Meretezoe.Checked=False
  then
     begin
     Scrollbox1.Top:=Scrollbox1.Top-28;
     Scrollbox1.Height:=Scrollbox1.Height+28;
   end
  else
   begin
     Scrollbox1.Height:=Scrollbox1.Height-28;
     Scrollbox1.Top:=Scrollbox1.Top+28;
   end;
end;

procedure TMainForm.KilepesClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.NyomtatClick(Sender: TObject);
var u:Byte;
begin
  Nyom:=True;
  if PrintDialog1.Execute then
    for u:=1 to PrintDialog1.Copies do
     begin
       Printer.BeginDoc;
       TRY
         FrissitClick(Nyomtat);
         Printer.EndDoc;
       EXCEPT
         Printer.Abort;
         Raise;
       END
     end;
  Nyom:=False;
end;

procedure TMainForm.EgysegEnter(Sender: TObject);
begin
  Egyseg.TabStop:=True;
  Meretarany.TabStop:=True;
  Nagyit.TabStop:=True;
  Edit1.TabStop:=False;
end;

procedure TMainForm.MeretaranyEnter(Sender: TObject);
begin
  Egyseg.TabStop:=True;
  Meretarany.TabStop:=True;
  Nagyit.TabStop:=True;
  Edit1.TabStop:=False;
end;

procedure TMainForm.NagyitEnter(Sender: TObject);
begin
  Egyseg.TabStop:=True;
  Meretarany.TabStop:=True;
  Nagyit.TabStop:=True;
  Edit1.TabStop:=False;
end;

procedure TMainForm.EgysegKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#27 then
  begin
   Edit1.TabStop:=True;
   Edit1.SetFocus;
  end
 else Key:=#0;
end;

procedure TMainForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  Key:=#0;
  ifmarvan(Abra.Canvas);
end;

procedure TMainForm.SpeedButton9Click(Sender: TObject);
begin
  ifmarvan(Abra.Canvas);
  StatusBar3.Visible:=False;
  Abra.Cursor:=crMove;
  Mer:=False;
end;

procedure TMainForm.SpeedButton10Click(Sender: TObject);
begin
  origomas:=False;
  Speedbutton10.Enabled:=False;
  FrissitClick(Speedbutton10);
end;

procedure TMainForm.SpeedButton11Click(Sender: TObject);
begin
  Abra.Cursor:=crMove;
  Mer:=True;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  most2.x:=Left;
  most2.y:=Top;
  UjForm.Top:=UjForm.Top+most2.y-most1.y;
  UjForm.Left:=UjForm.Left+most2.x-most1.x;
  if UjForm.Top<2 then UjForm.Top:=2;
  if UjForm.Left<2 then UjForm.Left:=2;
  most1.x:=Left;
  most1.y:=Top;
  if ActiveControl=Edit1 then
  begin
    if SBMozog1 then Scrollbox1.VertScrollBar.Position:=Scrollbox1.VertScrollBar.Position-8;
    if SBMozog2 then Scrollbox1.VertScrollBar.Position:=Scrollbox1.VertScrollBar.Position+8;
    if SBMozog3 then Scrollbox1.HorzScrollBar.Position:=Scrollbox1.HorzScrollBar.Position-8;
    if SBMozog4 then Scrollbox1.HorzScrollBar.Position:=Scrollbox1.HorzScrollBar.Position+8;
  end;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  Edit1.TabStop:=True;
  Edit1.SetFocus;
  if Abra.Cursor in [crCrop,crZoomIn,crZoomOut,crMove]
  then
   begin
    Abra.Cursor:=crDefault;
    StatusBar3.SendToBack;
   end; 
end;

end.
