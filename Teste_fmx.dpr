program Teste_fmx;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal_fmx in 'view\UnitPrincipal_fmx.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
