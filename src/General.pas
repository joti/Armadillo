unit General;

interface

  uses
    Forms, Dialogs, IniFiles, SysUtils, Graphics, Windows;

  function Arcus(Degree : Double) : Double;
  function Sgn(Num : Double) : Integer;
  function Almost(A, B : Double) : Boolean;

  function Convert(Unit1, Unit2 : Byte; Value : Double) : Double; Overload;
  function Convert(Unit1, Unit2 : String; Value : Double) : Double; Overload;

  function NumberChk(Value : String) : Boolean; Overload;
  function NumberChk(Value : String; var NumLength : Integer) : Boolean; Overload;

  procedure InitVariables;
  procedure InvalidValueMsg;

  type TCodeName = record
       Code : ShortString;
       Name : String;
       end;

  type TColorName = record
       Color : TColor;
       Name : String;
       end;

  type TPageSize = record
       Code : ShortString;
       UnitCode : ShortString;
       Width : Double;
       Height : Double;
       end;

  type TDoublePoint = record
       X : Double;
       Y : Double;
       end;

  const
    EARTHRADIUS = 250929500; // a földsugár inchben

  const // Egérkurzor azonosítók
    CR_ZOOMIN   = 1; // nagyítóban + jel
    CR_ZOOMOUT  = 2; // nagyítóban - jel
    CR_CROP     = 3; // + alakú kurzor
    CR_PENCIL   = 4; // ceruza alakú kurzor - ábrára rajzoláskor
    CR_ERASER   = 5; // szivacs alakú kurzor - ábrán törléskor
    CR_MOVEFROM = 6; // X alakú kurzor - mozgatás kezdõpontja
    CR_MOVETO   = 7; // X alakú kurzor egy körben - mozgatás végpontja
    CR_MEASURE  = 8; // X alakú kurzor - távolságmérésnél kezdõ és végpont kijelölése

  const // Vetületi paraméterek alapértelmezett értékei
    DEF_FI1  = 30;  // Valós kúpvetületek
    DEF_FI2  = 60;  // Valós kúpvetületek
    DEF_FIN  = 45;  // Kúpok ill. Bonne
    DEF_FIN2 = 15;  // Hengerek
    DEF_FIN3 = 20;  // Armadillo
    DEF_FIK1 = 90;  // Sztereografikus sík, szögtartó és perspektív henger
    DEF_FIK2 = 80;  // Gnomonikus
    DEF_FIK3 = 120; // Szögtartó polikónikus
    DEF_FIK4 = 0;   // Lagrange
    DEF_FIA  = 0;   // Perspektív henger és kúp
    DEF_FIA2 = 1;   // Polikónikusok
    DEF_FIA3 = 2;   // Lagrange
    DEF_FIAH = 1;   // Hullámvetületek
    DEF_FIH  = 1;   // Hullámvetületek

  // Mértékegységek
  const UNITS : array[0..3] of TCodeName = (
    (Code: 'mm'; Name: 'milliméter'),
    (Code: 'cm'; Name: 'centiméter'),
    (Code: 'in'; Name: 'inch'),
    (Code: 'mi'; Name: 'ezredinch') );

  // Alapértelmezett lapméretek
  const DEFPAGESIZES : array[0..5,0..3] of TDoublePoint = (
    ((X: 1189; Y: 841  ), (X: 118.9; Y: 84.1 ), (X: 46.811; Y: 33.110), (X: 46811; Y: 33110)), // A0
    ((X: 841;  Y: 594  ), (X: 84.1;  Y: 59.4 ), (X: 33.110; Y: 23.386), (X: 33110; Y: 23386)), // A1
    ((X: 594;  Y: 420  ), (X: 59.4;  Y: 42.0 ), (X: 23.386; Y: 16.535), (X: 23386; Y: 16535)), // A2
    ((X: 420;  Y: 297  ), (X: 42.0;  Y: 29.7 ), (X: 16.535; Y: 11.693), (X: 16535; Y: 11693)), // A3
    ((X: 297;  Y: 210  ), (X: 29.7;  Y: 21.0 ), (X: 11.693; Y: 8.268 ), (X: 11693; Y: 8268 )), // A4
    ((X: 210;  Y: 148.5), (X: 21.0;  Y: 14.85), (X: 8.268;  Y: 5.827 ), (X: 8268;  Y: 5827 ))  // A5
   );

  // Választható színek
  // A lap megjelenítés clLtGray színnel történik, ezért nem kínáljuk fel
  // A rajzolás pedig jelenleg clNavy színt használ, ezért ez sem választható
  // Egyéni szín megadása: $00BBGGRR
  const ALLCOLORS : array[0..19] of TColorName = (
    (Color: clBlack; Name: 'Fekete'),
    (Color: clAqua; Name: 'Cián'),
    (Color: clSkyBlue; Name: 'Világoskék'),
    (Color: clBlue; Name: 'Sötétkék'),
    (Color: clTeal; Name: 'Türkiz'),
    (Color: clGreen; Name: 'Sötétzöld'),
    (Color: TColor($0024AA00); Name: 'Zöld'),
    (Color: clMoneyGreen; Name: 'Világoszöld'),
    (Color: clOlive; Name: 'Olíva'),
    (Color: clYellow; Name: 'Sárga'),
    (Color: TColor($0000A5FF); Name: 'Narancssárga'),
    (Color: clRed; Name: 'Piros'),
    (Color: TColor($00C1B7EE); Name: 'Rózsaszín'),
    (Color: clFuchsia; Name: 'Magenta'),
    (Color: TColor($00D45B8B); Name: 'Levendula'),
    (Color: clPurple; Name: 'Lila'),
    (Color: TColor($003F1DBA); Name: 'Bordó'),
    (Color: clMaroon; Name: 'Barna'),
    (Color: clDkGray; Name: 'Sötétszürke'),
    (Color: clMedGray; Name: 'Világosszürke'));

  var
    NeedComma : Boolean; // Tizedestörtekben a pontok vesszõvé alakítandók
    DecSep : Char; // Tizedespont vagy -vesszõ
    IniFile : TIniFile; // Az alkalmazás ini fájlja
    NeedSaveIni : Boolean = False; // Beállítások módosultak, ini fájlba mentés szükséges lehet
    DebugFile : TextFile; // File debugoláshoz
    ApplDir : String; // Az alkalmazás könyvtára

implementation

  procedure InitVariables;
  var K : Double;
  begin
    ApplDir := ExtractFilePath(ParamStr(0));
    IniFile := TIniFile.Create(ApplDir + 'armadill.ini');

    NeedComma := False;
    DecSep := '.';
    TRY
      K := StrToFloat('13.13');
    EXCEPT
      NeedComma := True;
      DecSep := ',';
    END;
  end;

  function Arcus(Degree : Double) : Double;
  begin
    Result := Degree * Pi / 180;
  end;

  function Sgn(Num : Double) : Integer;
  begin
    if Num > 0 then
      Result := 1
    else if Num < 0 then
      Result := -1
    else
      Result := 0;
  end;

  function Convert(Unit1, Unit2 : Byte; Value : Double) : Double; Overload;
  begin
    Result := 0;

    case Unit1 of
    0: Result := Value / 25.39;
    1: Result := Value / 2.539;
    2: Result := Value;
    3: Result := Value / 1000;
    end;

    case Unit2 of
    0: Result := Result * 25.39;
    1: Result := Result * 2.539;
    3: Result := Result * 1000;
    end;
  end;

  function Convert(Unit1, Unit2 : String; Value : Double) : Double; Overload;
  var
    i : Byte;
    Id1, Id2 : Byte;
  begin
    Result := 0;

    for i := Low(UNITS) to High(UNITS) do begin
      if UNITS[i].Code = Unit1 then
        Id1 := i;
      if UNITS[i].Code = Unit2 then
        Id2 := i;
    end;

    Result := Convert(Id1, Id2, Value);
  end;

  function NumberChk(Value : String) : Boolean; Overload;
  var
    NumLength : Integer;
  begin
    Result := NumberChk(Value, NumLength);
  end;

  function NumberChk(Value : String; var NumLength : Integer) : Boolean; Overload;
  var
    I : Byte;
    FirstPos : Byte;
    SepPos : Byte;
  begin
    NumLength := 0;
    SepPos := 0;

    if (Length(Value) = 0) or (Value = '-') then
      Result := False
    else if not (Value[1] in ['0'..'9','-']) then
      Result := False
    else if (Value[1] = '-') and not (Value[2] in ['0'..'9']) then
      Result := False
    else begin
      if Value[1] = '-' then
        FirstPos := 2
      else
        FirstPos := 1;

      if (Value[FirstPos] = '0') and (Value[FirstPos + 1] <> DecSep) then begin
        Result := False;
        Exit;
      end;

      Result := True;
      for I := FirstPos to Length(Value) do begin
        if not ((Value[I] in ['0'..'9']) or (Value[I] = DecSep)) then
          Break
        else begin
          if Value[I] = DecSep then begin
            if SepPos > 0 then begin
              if SepPos = I - 1 then // 10,,4 -> 10 de 10,5,4 -> 10,5
                NumLength := SepPos - 1;
              Break;
            end else
              SepPos := I;
          end;
          NumLength := I;
        end;
      end;
    end;
  end;

  function Almost(A, B : Double) : Boolean;
  begin
    Result := (Abs(A - B) < 0.1);
  end;

  procedure InvalidValueMsg;
  begin
    MessageDlg('Érvénytelen méret.', mtInformation, [mbOK], 0);
  end;

end.
