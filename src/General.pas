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
    EARTHRADIUS = 250929500; // a f�ldsug�r inchben

  const // eg�rkurzor azonos�t�k
    CR_ZOOMIN   = 1; // nagy�t�ban + jel
    CR_ZOOMOUT  = 2; // nagy�t�ban - jel
    CR_CROP     = 3; // + alak� kurzor
    CR_PENCIL   = 4; // ceruza alak� kurzor - �br�ra rajzol�skor
    CR_ERASER   = 5; // szivacs alak� kurzor - �br�n t�rl�skor
    CR_MOVEFROM = 6; // X alak� kurzor - mozgat�s kezd�pontja
    CR_MOVETO   = 7; // X alak� kurzor egy k�rben - mozgat�s v�gpontja
    CR_MEASURE  = 8; // X alak� kurzor - t�vols�gm�r�sn�l kezd� �s v�gpont kijel�l�se

  const // param�terek alap�rtelmezett �rt�kei
    DEF_FI1  = 30;  // Val�s k�pvet�letek
    DEF_FI2  = 60;  // Val�s k�pvet�letek
    DEF_FIN  = 45;  // K�pok ill. Bonne
    DEF_FIN2 = 15;  // Hengerek
    DEF_FIN3 = 20;  // Armadillo
    DEF_FIK1 = 90;  // Sztereografikus s�k, sz�gtart� �s perspekt�v henger
    DEF_FIK2 = 80;  // Gnomonikus
    DEF_FIK3 = 120; // Sz�gtart� polik�nikus
    DEF_FIK4 = 0;   // Lagrange
    DEF_FIA  = 0;   // Perspekt�v henger �s k�p
    DEF_FIA2 = 1;   // Polik�nikusok
    DEF_FIA3 = 2;   // Lagrange
    DEF_FIAH = 1;   // Hull�mvet�letek
    DEF_FIH  = 1;   // Hull�mvet�letek

  // M�rt�kegys�gek
  const UNITS : array[0..3] of TCodeName = (
    (Code: 'mm'; Name: 'millim�ter'),
    (Code: 'cm'; Name: 'centim�ter'),
    (Code: 'in'; Name: 'inch'),
    (Code: 'mi'; Name: 'ezredinch') );

  var
    NeedComma : Boolean; // Tizedest�rtekben a pontok vessz�v� alak�tand�k
    DecSep : String; // Tizedespont vagy -vessz�
    IniFile : TIniFile; // Az alkalmaz�s ini f�jlja
    NeedSaveIni : Boolean = False; // Be�ll�t�sok m�dosultak, ini f�jlba ment�s sz�ks�ges lehet
    DebugFile : TextFile; // File debugol�shoz
    ApplDir : String; // Az alkalmaz�s k�nyvt�ra

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
    MessageDlg('�rv�nytelen m�ret.', mtInformation, [mbOK], 0);
  end;

end.
