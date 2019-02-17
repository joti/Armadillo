unit General;

interface

  uses
    Dialogs;

  function Arcus(degree : Double) : Double;
  function Sgn(num : Double) : Integer;
  function Almost(a, b : Double) : Boolean;

  procedure Ervmsg;

  type TCodeName = record
       Code : ShortString;
       Name : String;
       end;

  const Fold = 250929500; // a f�ldsug�r inchben
        crZoomin = 1;
        crZoomout = 2;
        crCrop = 3;
        crCeruza = 4;
        crRadir = 5;
        crMove = 6;
        crMove2 = 7;
        fi1alap = 30;
        fi2alap = 60;


        finalap=45; {K�pok ill. Bonne}
        finalap2=15; {Hengerek}
        finalap3=20; {Armadillo}
        fikalap1=90; {Sztereografikus s�k, sz�gtart� �s  perspekt�v henger}
        fikalap2=80; {Gnomonikus}
        fikalap3=120; {Sz�gtart� polik�nikus}
        fikalap4=0; {Lagrange}
        fiaalap=0; {Perspekt�v henger �s k�p}
        fiaalap2 = 1; {Polik�nikusok}
        fiaalap3 = 2; {Lagrange}
        fia2alap = 1;
        fihalap = 1;

implementation

  function Arcus(degree : Double) : Double;
  begin
    result := degree * pi / 180;
  end;

  function Sgn(num : Double) : Integer;
  begin
    if num > 0 then
      result := 1
    else if num < 0 then
      result := -1
    else
      result := 0;
  end;

  function Almost(a, b : Double) : Boolean;
  begin
    result := (abs(a - b) < 0.1);
  end;

  procedure Ervmsg;
  begin
    MessageDlg('�rv�nytelen m�ret.', mtInformation, [mbOK], 0);
  end;

end.
