unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Cliente, Produto,
  ClienteController, ProdutoController, PedidoController, Vcl.Samples.Spin,
  Vcl.Mask, Vcl.Grids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmPrincipal = class(TForm)
    gbCliente: TGroupBox;
    gbProduto: TGroupBox;
    gbRodape: TGroupBox;
    gbItens: TGroupBox;
    eCliente: TEdit;
    lCliente: TLabel;
    lProduto: TLabel;
    gbPedido: TGroupBox;
    meValor: TMaskEdit;
    seQuantidade: TSpinEdit;
    lQuantidade: TLabel;
    lValorUnitario: TLabel;
    bIncluirProduto: TButton;
    fdmtItens: TFDMemTable;
    dbgItens: TDBGrid;
    dsItens: TDataSource;
    fdmtItensCodProduto: TIntegerField;
    fdmtItensDescricao: TStringField;
    fdmtItensQuantidade: TIntegerField;
    fdmtItensValor: TCurrencyField;
    fdmtItensValorTotal: TCurrencyField;
    ePedido: TEdit;
    bPesquisar: TButton;
    bCancelar: TButton;
    lValorTotalPedido: TLabel;
    bSalvarPedido: TButton;
    eProduto: TEdit;
    fdmtItensItemID: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eClienteExit(Sender: TObject);
    procedure eClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lerCliente;
    procedure lerProduto;
    procedure valorTotalPedido;
    procedure eClienteChange(Sender: TObject);
    procedure eProdutoChange(Sender: TObject);
    procedure eProdutoExit(Sender: TObject);
    procedure bIncluirProdutoClick(Sender: TObject);
    procedure bPesquisarClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure bSalvarPedidoClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    CPedidoController: TPedidoController;
    CClienteController: TClienteController;
    CProdutoController: TProdutoController;
    CProduto: TProduto;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.SysUtils;

{$R *.dfm}
procedure TfrmPrincipal.lerCliente;
begin
  if eCliente.Text <> '' then
  begin
    eCliente.SelectAll;
    CPedidoController.Pedido.Cliente.ID := StrToInt64(eCliente.Text);
    if CClienteController.Read(CPedidoController.Pedido.Cliente) then
      lCliente.Caption := CPedidoController.Pedido.Cliente.Nome
    else
      lCliente.Caption := 'Cliente não Encontrado !!!';
  end
  else
    lCliente.Caption := '';
end;

procedure TfrmPrincipal.lerProduto;
begin
  if eproduto.Text <> '' then
  begin
    eProduto.SelectAll;
    CProdutoController.Produto.ID := StrToInt64(eProduto.Text);
    if CProdutoController.Read(CProdutoController.Produto) then
      lProduto.Caption := CProdutoController.Produto.Descricao
    else
      lProduto.Caption := 'Produto não Encontrado !!!';
  end
  else
    lProduto.Caption := '';
end;

procedure TfrmPrincipal.valorTotalPedido;
begin
  lValorTotalPedido.Caption := 'Valor Total do Pedido : ' + CPedidoController.Pedido.ValorTotal.ToString(ffCurrency, 10, 2);
end;

procedure TfrmPrincipal.bIncluirProdutoClick(Sender: TObject);
begin
  var VProduto := CProduto;
  if not Assigned(VProduto) then
  begin
    VProduto := TProduto.Create;
    CPedidoController.Pedido.Produtos.Add(VProduto);
  end;
  VProduto.ID := StrToInt64(eProduto.Text);
  VProduto.Descricao := CProdutoController.Produto.Descricao;
  VProduto.Quantidade := seQuantidade.Value;
  VProduto.Preco := strToFloat(meValor.Text);
  fdmtItens.Append;
  fdmtItens.FieldByName('CodProduto').AsInteger := VProduto.ID;
  fdmtItens.FieldByName('Descricao').AsString := VProduto.Descricao;
  fdmtItens.FieldByName('Quantidade').AsInteger := VProduto.Quantidade;
  fdmtItens.FieldByName('Valor').AsCurrency := VProduto.Preco;
  fdmtItens.FieldByName('ValorTotal').AsCurrency := VProduto.Quantidade * VProduto.Preco;
  eProduto.Text := '';
  valorTotalPedido;
  ActiveControl := eProduto;
end;

procedure TfrmPrincipal.bCancelarClick(Sender: TObject);
begin
  if ePedido.text <> '' then
  begin
    CPedidoController.Pedido.ID := StrToInt64(ePedido.Text);
    if CPedidoController.Delete then
    begin
      ShowMessage('Pedido Cancelado !!!');
    end;
    ePedido.Text := '';
  end;
end;

procedure TfrmPrincipal.bPesquisarClick(Sender: TObject);
begin
  if ePedido.text <> '' then
  begin
    CPedidoController.Pedido.ID := StrToInt64(ePedido.Text);
    if not CPedidoController.Read then
    begin
      ShowMessage('Pedido não encontrado !!!');
      ePedido.Text := '';
      Exit;
    end;
    eCliente.Text := CPedidoController.Pedido.Cliente.ID.ToString;
    lerCliente;
    fdmtItens.Active := False;
    fdmtItens.Active := True;
    for var VProduto in CPedidoController.Pedido.Produtos do
    begin
      fdmtItens.Append;
      fdmtItens.FieldByName('ItemID').AsInteger := VProduto.ItemID;
      fdmtItens.FieldByName('CodProduto').AsInteger := VProduto.ID;
      fdmtItens.FieldByName('Descricao').AsString := VProduto.Descricao;
      fdmtItens.FieldByName('Quantidade').AsInteger := VProduto.Quantidade;
      fdmtItens.FieldByName('Valor').AsCurrency := VProduto.Preco;
      fdmtItens.FieldByName('ValorTotal').AsCurrency := VProduto.Quantidade * VProduto.Preco;
    end;
    ePedido.Text := '';
    valorTotalPedido;
  end;
end;

procedure TfrmPrincipal.bSalvarPedidoClick(Sender: TObject);
begin
  if eCliente.Text = '' Then
  begin
    ShowMessage('Selecine um Clienet !!!');
    ActiveControl := eCliente;
    Exit;
  end;
  if fdmtItens.IsEmpty then
  Begin
    ShowMessage('Adicione pelo menos um produto !!!');
    ActiveControl := eProduto;
    Exit;
  End;
  if not CPedidoController.Save then
    Exit;
  ShowMessage('Pedido Criado !!!');
  eCliente.Text := '';
  lCliente.Caption := '';
  ActiveControl := eCliente;
end;

procedure TfrmPrincipal.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  mensagem, pedido : String;
begin
    //Enter
    if Key = 13 then
    begin
      eproduto.Text := fdmtItens.FieldByName('CodProduto').AsString;
      lerProduto;
      seQuantidade.Value := fdmtItens.FieldByName('Quantidade').AsInteger;
      meValor.Text := fdmtItens.FieldByName('Valor').AsString;
    end;
    //DEL
    if key = 46 then
    begin
      mensagem := 'Deseja mesmo excluir o item : ' +
                  fdmtItens.FieldByname('descricao').AsString + ' ?';
      if Application.MessageBox (pWideChar(mensagem), 'Confirmação',
       MB_ICONQUESTION + MB_YESNO) = IDYES then
      begin
        if fdmtItens.FieldByName('ItemID').AsInteger >= 1 then
        begin
          pedido := cPedidoController.Pedido.ID.ToString;
          cPedidoController.Pedido.ID := fdmtItens.FieldByName('ItemID').AsInteger;
          cPedidoController.DeleteItem;
        end;
        fdmtItens.Active := False;
        fdmtItens.Active := True;
        ePedido.Text := pedido;
        bPesquisar.Click;
      end;
    end;
end;

procedure TfrmPrincipal.eClienteChange(Sender: TObject);
begin
  gbPedido.Visible := eCliente.Text = '';
  if eCliente.Text = '' then
  begin
    lCliente.Caption := '';
    fdmtItens.Active := False;
    fdmtItens.Active := True;
    CPedidoController.Clean;
    valorTotalPedido;
   end;
end;

procedure TfrmPrincipal.eClienteExit(Sender: TObject);
begin
  lerCliente;
end;

procedure TfrmPrincipal.eClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    lerCliente;
end;

procedure TfrmPrincipal.eProdutoChange(Sender: TObject);
begin
  if eProduto.Text = '' then
  begin
    lProduto.Caption := '';
    seQuantidade.Value := 0;
    meValor.Text := '0,00';
  end;
end;

procedure TfrmPrincipal.eProdutoExit(Sender: TObject);
begin
  lerProduto;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  CClienteController.Destroy;
  CProdutoController.Destroy;
  CPedidoController.Destroy;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  CClienteController := TClienteController.Create(Self);
  CProdutoController := TProdutoController.Create(Self);
  CPedidoController := TPedidoController.Create(Self);
  fdmtItens.Active := True;
  valorTotalPedido;
  ActiveControl := eCliente;
end;

end.
