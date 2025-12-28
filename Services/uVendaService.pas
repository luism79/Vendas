unit uVendaService;

interface

uses
  uCustomService, uIConnectionTransaction, uIVendaRepository, uVenda,
  uIClienteRepository, uICarroRepository;

type
  TVendaService = class(TCustomService)
  private
    FVendaRepository: IVendaRepository;
    FClienteRepository: IClienteRepository;
    FCarroRepository: ICarroRepository;

  public
    constructor Create(AConnectionTransaction: IConnectionTransaction;
      AVendaRepository: IVendaRepository;
      AClienteRepository: IClienteRepository;
      ACarroRepository: ICarroRepository); reintroduce;

    procedure InserirDadosBD(AVenda: TVenda);
  end;

implementation

uses
   System.SysUtils, Data.DB;

{ TVendaService }

constructor TVendaService.Create(AConnectionTransaction: IConnectionTransaction;
  AVendaRepository: IVendaRepository; AClienteRepository: IClienteRepository;
  ACarroRepository: ICarroRepository);
begin
  inherited Create(AConnectionTransaction);

  FVendaRepository := AVendaRepository;
  FClienteRepository := AClienteRepository;
  FCarroRepository := ACarroRepository;
end;

procedure TVendaService.InserirDadosBD(AVenda: TVenda);
begin
  if not FClienteRepository.LocateById(AVenda.IdCliente) then
    raise Exception.Create('Cliente não foi localizado.');

  if not FCarroRepository.LocateById(AVenda.IdCarro) then
    raise Exception.Create('Carro não foi localizado.');

  if AVenda.DataVenda = 0 then
    AVenda.DataVenda := Now;

  ConnectionTransaction.StartTransaction;
  try
    FVendaRepository.InserirDadosBD(AVenda);
    ConnectionTransaction.Commit;
  except
    on E: Exception do
    begin
      ConnectionTransaction.Rollback;
      raise;
    end;
  end;
end;

end.
