unit UnitPrincipal_fmx;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TfrmPrincipal = class(TForm)
    pTitulo: TPanel;
    lTitulo: TLabel;
    gbCliente: TGroupBox;
    gbProduto: TGroupBox;
    gbRodape: TGroupBox;
    gbItens: TGroupBox;
    eCliente: TEdit;
    eProduto: TEdit;
    lCliente: TLabel;
    lProduto: TLabel;
    eQuantidade: TEdit;
    ePreco: TEdit;
    bConfirmarProduto: TButton;
    gbPedido: TGroupBox;
    procedure eClienteChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.eClienteChange(Sender: TObject);
begin
  gbPedido.Visible := eCliente.Text.IsEmpty;
end;

end.
