unit PedidoController;

interface

uses
  System.Classes, FireDAC.Stan.Param, FireDAC.Comp.Client, UnitDM, Produto,
  Pedido;

type
  TPedidoController = class(TComponent)
  private
    Query: TFDQuery;
    FPedido: TPedido;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Save: Boolean;
    function Read: Boolean;
    function Delete: Boolean;
    function DeleteItem: Boolean;
    procedure Clean;
    property Pedido: TPedido read FPedido;
  end;

implementation

constructor TPedidoController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPedido := TPedido.Create;
  Query := tFDQuery.Create(Self);
  Query.Connection := dm.fdcWK;
end;

destructor TPedidoController.Destroy;
begin
  FPedido.Free;
  inherited Destroy;
end;

function TPedidoController.Save: Boolean;
begin
  dm.FDTransaction1.StartTransaction;
  try
    // Save Pedido
    Query.SQL.Clear;
    Query.SQL.add('INSERT INTO `wk`.`pedidos` (`cliente_id`, `valor_total`) ' +
                  'VALUES (:cliente_id, :valor_total);');
    Query.ParamByName('cliente_id').AsLargeInt := FPedido.Cliente.ID;
    Query.ParamByName('valor_total').AsFloat := FPedido.ValorTotal;
    Query.ExecSQL;
    FPedido.ID := DM.retornaIDInserido;
    //Save Item do pedido
    for var VProduto in FPedido.Produtos do
    begin
      Query.SQL.Clear;
      Query.SQL.add(
        'INSERT INTO `wk`.`pedidos_produtos` (`pedido_id`, `produto_id`, ' +
        '`quantidade`, `valor`, `valor_total`) ' +
        'VALUES (:pedido_id, :produto_id, :quantidade, :valor, :valor_total);');
      Query.ParamByName('pedido_id').AsLargeInt := FPedido.ID;
      Query.ParamByName('produto_id').AsLargeInt := VProduto.ID;
      Query.ParamByName('quantidade').AsLargeInt := VProduto.Quantidade;
      Query.ParamByName('valor').AsFloat := VProduto.Preco;
      Query.ParamByName('valor_total').AsFloat := VProduto.Total;
      Query.ExecSQL;
    end;
    Query.Close;
    Result := True;
    dm.FDTransaction1.Commit;
  except
    dm.FDTransaction1.Rollback;
    raise;
  end;
end;

function TPedidoController.Read: Boolean;
var
  Achou : Boolean;
begin
  dm.FDTransaction1.StartTransaction;
  try
    // Ler pedido
    Query.SQL.Clear;
    Query.SQL.add(
      'SELECT id, cliente_id, valor_total, data_emissao ' +
      'FROM wk.pedidos WHERE id = :id');
    Query.ParamByName('id').AsLongword := FPedido.ID;
    Query.Open;
    FPedido.ID := Query.FieldByName('id').AsLargeInt;
    FPedido.Cliente.ID := Query.FieldByName('cliente_id').AsLargeInt;
    Achou := Query.RecordCount > 0;
    // Ler iten do pedido
    FPedido.Produtos.Clear;
    Query.SQL.Clear;
    Query.SQL.add(
      'SELECT `pedpro`.`id`, `pedpro`.`pedido_id`, `pedpro`.`produto_id`, `pro`.`descricao`, ' +
      '`pedpro`.`quantidade`, `pedpro`.`valor`, `pedpro`.`valor_total` ' +
      'FROM `wk`.`pedidos_produtos` AS `pedpro` ' +
      'LEFT JOIN `wk`.`produtos` AS `pro` ON `pro`.`id` = `pedpro`.`produto_id` ' +
      'WHERE `pedpro`.`pedido_id` = :pedido_id');
    Query.ParamByName('pedido_id').AsLargeInt := FPedido.ID;
    Query.Open;
    while not Query.Eof do
    begin
      var VProduto := TProduto.Create;
      VProduto.ItemID := Query.FieldByName('id').AsLargeInt;
      VProduto.ID := Query.FieldByName('produto_id').AsLargeInt;
      VProduto.Descricao := Query.FieldByName('descricao').AsString;
      VProduto.Quantidade := Query.FieldByName('quantidade').AsInteger;
      VProduto.Preco := Query.FieldByName('valor').AsFloat;
      FPedido.Produtos.Add(VProduto);
      Query.Next;
    end;
    Query.Close;
    Result := Achou;
    dm.FDTransaction1.Commit;
  except
    dm.FDTransaction1.Rollback;
    raise;
  end;
end;

function TPedidoController.Delete: Boolean;
begin
  dm.FDTransaction1.StartTransaction;
  try
    Query.SQL.Clear;
    Query.SQL.add('DELETE FROM `wk`.`pedidos` WHERE (`id` = :id);');
    Query.ParamByName('id').AsLongword := FPedido.ID;
    Query.ExecSQL;
    Result := Query.RowsAffected > 0;
    dm.FDTransaction1.Commit;
    clean;
  except
    dm.FDTransaction1.Rollback;
    raise;
  end;
end;

function TPedidoController.DeleteItem: Boolean;
var
  id : String;
begin
  dm.FDTransaction1.StartTransaction;
  try
    Query.SQL.Clear;
    Query.SQL.add('SELECT `pedido_id` FROM `wk`.`pedidos_produtos` ' +
                  'WHERE `id` = :id');
    Query.ParamByName('id').AsLongword := FPedido.ID;
    Query.Open;
    id := query.fieldbyName('pedido_id').AsString;
    Query.SQL.Clear;
    Query.SQL.add('DELETE FROM `wk`.`pedidos_produtos` WHERE (`id` = :id);');
    Query.ParamByName('id').AsLongword := FPedido.ID;
    Query.ExecSQL;
    Result := Query.RowsAffected > 0;
    Query.SQL.Clear;
    Query.SQL.add('UPDATE `wk`.`pedidos` SET `valor_total` = (SELECT SUM(`valor_total`) ' +
                  'FROM `wk`.`pedidos_produtos` WHERE `pedido_id` = `pedidos`.`id`) ' +
                  'WHERE (`id` = :id);');
    Query.ParamByName('id').AsString := id;
    Query.ExecSQL;
    dm.FDTransaction1.Commit;
  except
    dm.FDTransaction1.Rollback;
    raise;
  end;
end;

procedure TPedidoController.Clean;
begin
  FPedido.ID := 0;
  FPedido.Produtos.Clear;
end;

end.
