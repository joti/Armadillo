unit General;

interface

  uses
    Dialogs;

  function Arcus(Degree : Double) : Double;
  function Sgn(Num : Double) : Integer;
  function Almost(A, B : Double) : Boolean;

  procedure InvalidValueMsg;

  type TCodeName = record
       Code : ShortString;
       Name : String;
       end;

  const Fold = 250929500; // a földsugár inchben
        crZoomin = 1;
        crZoomout = 2;
        crCrop = 3;
        crCeruza = 4;
        crRadir = 5;
        crMove = 6;
        crMove2 = 7;
        fi1alap = 30;
        fi2alap = 60;

        finalap=45; {Kúpok ill. Bonne}
        finalap2=15; {Hengerek}
        finalap3=20; {Armadillo}
        fikalap1=90; {Sztereografikus sík, szögtartó és  perspektív henger}
        fikalap2=80; {Gnomonikus}
        fikalap3=120; {Szögtartó polikónikus}
        fikalap4=0; {Lagrange}
        fiaalap=0; {Perspektív henger és kúp}
        fiaalap2 = 1; {Polikónikusok}
        fiaalap3 = 2; {Lagrange}
        fia2alap = 1;
        fihalap = 1;

implementation

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

  function Almost(A, B : Double) : Boolean;
  begin
    Result := (Abs(A - B) < 0.1);
  end;

  procedure InvalidValueMsg;
  begin
    MessageDlg('Érvénytelen méret.', mtInformation, [mbOK], 0);
  end;

end.
