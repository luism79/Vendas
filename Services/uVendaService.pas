unit uVendaService;

interface

uses
  uCustomService, uIConnectionTransaction, uIVendaRepository, uVenda,
  uIVendaService,  uIClienteService, uICarroService;

type
  TVendaService = class(TCustomService, IVendaService)
  private
    FVendaRepository: IVendaRepository;
    FClienteService: IClienteService;
    FCarroService: ICarroService;

    procedure SetVendaRepository(AVendaRepository: IVendaRepository);
    procedure SetCarroService(ACarroService: ICarroService);
    procedure SetClienteService(AClienteService: IClienteService);
  public
    constructor Create(AConnectionTransaction: IConnectionTransaction;
      AVendaRepository: IVendaRepository;
      AClienteService: IClienteService;
      ACarroService: ICarroService); reintroduce;

    procedure InserirDadosBD(AVenda: TVenda);
  end;

implementation

uses
   System.SysUtils, Data.DB;

{ TVendaService }

constructor TVendaService.Create(AConnectionTransaction: IConnectionTransaction;
  AVendaRepository: IVendaRepository; AClienteService: IClienteService;
  ACarroService: ICarroService);
begin
  inherited Create(AConnectionTransaction);

  SetVendaRepository(AVendaRepository);
  SetClienteService(AClienteService);
  SetCarroService(ACarroService);
end;

procedure TVendaService.InserirDadosBD(AVenda: TVenda);
begin
  if not FClienteService.LocateById(AVenda.IdCliente) then
    raise Exception.Create('Cliente não foi localizado.');

  if not FCarroService.LocateById(AVenda.IdCarro) then
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

procedure TVendaService.SetCarroService(ACarroService: ICarroService);
begin
  if not Assigned(ACarroService) then
    raise EArgumentException.Create('O argumento do serviço ''ICarroService'' não foi informado.');

  FCarroService := ACarroService;
end;

procedure TVendaService.SetClienteService(AClienteService: IClienteService);
begin
  if not Assigned(AClienteService) then
    raise EArgumentException.Create('O argumento do serviço ''IClienteService'' não foi informado.');

  FClienteService := AClienteService;
end;

procedure TVendaService.SetVendaRepository(AVendaRepository: IVendaRepository);
begin
  if not Assigned(AVendaRepository) then
    raise EArgumentException.Create('O argumento do repositório ''IVendaRepository'' não foi informado.');

  FVendaRepository := AVendaRepository;
end;

end.
