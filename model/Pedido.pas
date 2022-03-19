unit Pedido;

interface

uses
  Cliente, Produto;

type
  TPedido = class
  private
    CCliente: TCliente;
    CProdutos: TProdutos;
    CID: UInt64;
    function GetTotal: Double;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: UInt64 read CID write CID;
    property Cliente: TCliente read CCliente;
    property Produtos: TProdutos read CProdutos;
    property ValorTotal: Double read GetTotal;
  end;

implementation

constructor TPedido.Create;
begin
  inherited Create;
  CCliente := TCliente.Create;
  CProdutos := TProdutos.Create;
end;

destructor TPedido.Destroy;
begin
  CProdutos.Free;
  CCliente.Free;
  inherited;
end;

function TPedido.GetTotal: Double;
begin
  Result := CProdutos.Total;
end;

end.
