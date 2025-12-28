unit uVendaRepository;

interface

uses
  System.SysUtils, uCustomRepository, uIVendaRepository, uVenda;

type
  TVendaRepository = class(TCustomRepository, IVendaRepository)
  public
    procedure InserirDadosBD(AVenda: TVenda);
  end;

implementation

uses
  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Param, Data.DB;

{ TVendaRepository }

procedure TVendaRepository.InserirDadosBD(AVenda: TVenda);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := Connection;
    lQuery.SQL.Text := 'insert into venda'#13#10 +
                       '  (data_venda, id_cliente, id_carro)'#13#10 +
                       'values'#13#10 +
                       '  (:data_venda, :id_cliente, :id_carro)'#13#10 +
                       'returning id';
    lQuery.ParamByName('data_venda').AsDateTime := AVenda.DataVenda;
    lQuery.ParamByName('id_cliente').AsInteger := AVenda.IdCliente;
    lQuery.ParamByName('id_carro').AsInteger := AVenda.IdCarro;
    lQuery.Open;

    AVenda.Id := lQuery.Fields[0].AsInteger;
  finally
    FreeAndNil(lQuery);
  end;  // try
end;

end.
