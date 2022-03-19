program Teste_fmx;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal_fmx in 'view\UnitPrincipal_fmx.pas' {frmPrincipal},
  Cliente in 'model\Cliente.pas',
  Produto in 'model\Produto.pas',
  Pedido in 'model\Pedido.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
