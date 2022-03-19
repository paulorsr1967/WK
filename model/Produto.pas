unit Produto;

interface

uses
  System.Generics.Collections;

type
  TProduto = class
  private
    CID: UInt64;
    CDescricao: string;
    CPreco: Double;
    CQuantidade: Integer;
    CItemID: Uint64;
    function GetTotal: Double;
  public
    property ID: UInt64 read CID write CID;
    property Descricao: string read CDescricao write CDescricao;
    property Preco: Double read CPreco write CPreco;
    property Quantidade: Integer read CQuantidade write CQuantidade;
    property ItemID: Uint64 read CItemID write CItemID;
    property Total: Double read GetTotal;
  end;

  TProdutos = class(TObjectList<TProduto>)
  private
    function GetTotal: Double;
  public
    property Total: Double read GetTotal;
  end;

implementation

{ TProduto }

function TProduto.GetTotal: Double;
begin
  Result := CQuantidade * CPreco;
end;

{ TProdutos }

function TProdutos.GetTotal: Double;
begin
  Result := 0;
  for var VProduto in Self do
    Result := Result + VProduto.Total;
end;

end.
