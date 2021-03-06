program armadill;

uses
  Sysutils,
  Forms,
  Main in 'Main.pas' {MainForm},
  About in 'About.pas' {AboutForm},
  Parameters1 in 'Parameters1.pas' {ParametersForm1},
  Settings in 'Settings.pas' {SettingsForm},
  Page in 'Page.pas' {PageForm},
  Unit6 in 'Unit6.pas' {ProgressForm},
  Options in 'Options.pas' {OptionsForm},
  Layers in 'Layers.pas' {LayersForm},
  Parameters2 in 'Parameters2.pas' {ParametersForm2},
  Splash in 'Splash.pas' {SplashForm},
  Parameters3 in 'Parameters3.pas' {ParametersForm3},
  Parameters4 in 'Parameters4.pas' {ParametersForm4},
  General in 'General.pas';

{$R *.RES}

var Nyito: TSplashForm;

begin
  Application.Initialize;
  Application.Title := 'Armadillo 2.0';

  Nyito := TSplashForm.Create(Application);
  Nyito.Show;
  Nyito.Update;

  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TParametersForm1, ParametersForm1);
  Application.CreateForm(TPageForm, PageForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.CreateForm(TLayersForm, LayersForm);
  Application.CreateForm(TParametersForm2, ParametersForm2);
  Application.CreateForm(TSplashForm, SplashForm);
  Application.CreateForm(TParametersForm3, ParametersForm3);
  Application.CreateForm(TParametersForm4, ParametersForm4);

  with PageForm do begin
    PapirszelesEd.Text := Format('%-2.4g ', [PageSizes[PapirCB.Itemindex, Egyseg].X]) + UNITS[Egyseg].Code;
    PapirmagasEd.Text := Format('%-2.4g ', [PageSizes[PapirCB.Itemindex, Egyseg].Y]) + UNITS[Egyseg].Code;
  end;

  Nyito.Close;
  SettingsForm.Show;
  Nyito.Free;
  NeedSaveIni := False;
  Application.Run;
end.
