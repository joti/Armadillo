unit General;

interface

  uses
    Forms, Dialogs, IniFiles, SysUtils;

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

  const
    EARTHRADIUS = 250929500; // a földsugár inchben

  const // egérkurzor azonosítók
    CR_ZOOMIN   = 1; // nagyítóban + jel
    CR_ZOOMOUT  = 2; // nagyítóban - jel
    CR_CROP     = 3; // + alakú kurzor
    CR_PENCIL   = 4; // ceruza alakú kurzor - ábrára rajzoláskor
    CR_ERASER   = 5; // szivacs alakú kurzor - ábrán törléskor
    CR_MOVEFROM = 6; // X alakú kurzor - mozgatás kezdõpontja
    CR_MOVETO   = 7; // X alakú kurzor egy körben - mozgatás végpontja
    CR_MEASURE  = 8; // X alakú kurzor - távolságmérésnél kezdõ és végpont kijelölése

  const // paraméterek alapértelmezett értékei
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

  var
    NeedComma : Boolean; // Tizedestörtekben a pontok vesszõvé alakítandók
    DecSep : String; // Tizedespont vagy -vesszõ
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
