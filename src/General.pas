unit General;

interface

  uses
    Dialogs;

  function arcus(ppp:Double):Double;
  function sgn(par: Double): Integer;
  procedure Ervmsg;

  const Fold=250929500;
        crZoomin=1;
        crZoomout=2;
        crCrop=3;
        crCeruza=4;
        crRadir=5;
        crMove=6;
        crMove2=7;
        fi1alap=30;
        fi2alap=60;
        finalap=45;
        finalap2=15;
        finalap3=20;
        fikalap1=90;
        fikalap2=80;
        fikalap3=120;
        fikalap4=0;
        fiaalap=0;
        fiaalap2=1;
        fiaalap3=2;
        fia2alap=1;
        fihalap=1;

implementation

  function arcus(ppp:Double):Double;
  begin
   arcus:=ppp*pi/180;
  end;

  function sgn(par: Double): Integer;
  begin
    if par>0 then sgn:=1;
    if par=0 then sgn:=0;
    if par<0 then sgn:=-1;
  end;

  procedure Ervmsg;
  begin
   MessageDlg('Érvénytelen méret.',mtInformation,[mbOK],0);
  end;

end.
