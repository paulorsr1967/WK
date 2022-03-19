unit ClienteController;

interface

uses
  System.Classes, FireDAC.Stan.Param, FireDAC.Comp.Client, FireDac.DApt,
  UnitDM, Cliente;

type
  TClienteController = class(TComponent)
  private
    Query: TFDQuery;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Read(PCliente: TCliente): Boolean;
  end;

implementation

constructor TClienteController.Create(AOwner: TComponent);
begin
  inherited;
  Query := tFDQuery.Create(Self);
  Query.Connection := dm.fdcWK;
 end;

destructor TClienteController.Destroy;
begin
  inherited;
  Query.Free;
end;

function TClienteController.Read(PCliente: TCliente): Boolean;
begin
  dm.FDTransaction1.StartTransaction;
  try
    Query.SQL.Clear;
    Query.SQL.add('SELECT * FROM wk.clientes WHERE id = :id');
    Query.ParamByName('id').AsLargeInt := PCliente.ID;
    Query.Open;
    PCliente.Nome := Query.FieldByName('nome').AsString;
    PCliente.Cidade := Query.FieldByName('cidade').AsString;
    PCliente.UF := Query.FieldByName('uf').AsString;
    Result := Query.RecordCount > 0;
    dm.FDTransaction1.Commit;
  except
    dm.FDTransaction1.Rollback;
    raise;
  end;
end;

end.