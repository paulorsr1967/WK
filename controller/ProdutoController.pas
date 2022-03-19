unit ProdutoController;

interface

uses
  System.Classes, FireDAC.Stan.Param, FireDAC.Comp.Client, UnitDM, Produto;

type
  TProdutoController = class(TComponent)
  private
    Query: TFDQuery;
    MeuProduto: TProduto;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Read(PProduto: TProduto): Boolean;
    property Produto: TProduto read MeuProduto;
  end;

implementation

constructor TProdutoController.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MeuProduto := TProduto.Create;
  Query := tFDQuery.Create(Self);
  Query.Connection := dm.fdcWK;
end;

destructor TProdutoController.Destroy;
begin
  MeuProduto.Free;
  inherited Destroy;
end;

function TProdutoController.Read(PProduto: TProduto): Boolean;
begin
  dm.FDTransaction1.StartTransaction;
  try
    Query.SQL.Clear;
    Query.SQL.add('SELECT * FROM wk.produtos WHERE id = :id');
    Query.ParamByName('id').AsLargeInt := PProduto.ID;
    Query.Open;
    PProduto.Descricao := Query.FieldByName('descricao').AsString;
    PProduto.Preco := Query.FieldByName('preco').AsFloat;
    Result := Query.RecordCount > 0;
    dm.FDTransaction1.Commit;
  except
    dm.FDTransaction1.Rollback;
    raise;
  end;
end;

end.
