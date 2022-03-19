unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client;

type
  TDM = class(TDataModule)
    fdcWK: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDTransaction1: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function retornaIDInserido: integer;

  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  // Conectar base com FireDAC MySQL
  with fdcWK.Params do
  begin
    Values['User_Name'] := 'wk';
    Values['Password'] := 'wk';
    Values['Server'] := '127.0.0.1';
    Values['Database'] := 'wk';
    Values['DriverID'] := 'MySQL';
  end;
  try
    fdcWK.LoginPrompt := False;
    fdcWK.Connected := True;
    fdcWK.Open;
  except
    begin
//      Application.MessageBox('Não foi possivel se conectar com a base de dados FireDAC MySQL. A Aplicação será fechada. ', 'Erro ', MB_ICONERROR + MB_OK);
//      Application.terminate;
    end;
  end;
end;

function TDM.retornaIDInserido: integer;
var
  seq : integer;
  Query : tFDQuery;
begin
  Query := tFDQuery.Create(Self);
  Query.Connection := dm.fdcWK;
  Query.SQL.Clear;
  Query.SQL.Add('select @@identity seq ');
  Query.Open;
  seq := Query.FieldByName('seq').AsLargeInt;
  Query.Close;
  Query.Free;
  retornaIDInserido := seq;
end;

end.
