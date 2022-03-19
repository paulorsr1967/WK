program teste_vcl;

uses
  Vcl.Forms,
  UnitPrincipal in 'view\UnitPrincipal.pas' {frmPrincipal},
  Cliente in 'model\Cliente.pas',
  Pedido in 'model\Pedido.pas',
  Produto in 'model\Produto.pas',
  ClienteController in 'controller\ClienteController.pas',
  ProdutoController in 'controller\ProdutoController.pas',
  PedidoController in 'controller\PedidoController.pas',
  UnitDM in 'model\UnitDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  ReportMemoryLeaksOnShutdown := True;
  Application.Run;
end.
