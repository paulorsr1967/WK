unit Cliente;

interface

type
  TCliente = class
  private
    CID: UInt64;
    CNome: string;
    CCidade: string;
    CUF: string;
  public
    property ID: UInt64 read CID write CID;
    property Nome: string read CNome write CNome;
    property Cidade: string read CCidade write CCidade;
    property UF: string read CUF write CUF;
  end;

implementation

end.