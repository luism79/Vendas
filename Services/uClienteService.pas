unit uClienteService;

interface

uses
  uCustomService, uIClienteRepository, uCliente, uIConnectionTransaction;

type
  TClienteService = class(TCustomService)
  private
    FClienteRepository: IClienteRepository;
  public
    constructor Create(AConnectionTransaction: IConnectionTransaction;
      AClienteRepository: IClienteRepository); reintroduce;

    procedure InserirDadosBD(ACliente: TCliente);
  end;

implementation

uses
  System.SysUtils, uFormatarCPF;

{ TClienteService }

constructor TClienteService.Create(AConnectionTransaction: IConnectionTransaction;
  AClienteRepository: IClienteRepository);
begin
  inherited Create(AConnectionTransaction);
  FClienteRepository := AClienteRepository;
end;

procedure TClienteService.InserirDadosBD(ACliente: TCliente);
var
  sCPF: string;
begin
  if ACliente.Nome = EmptyStr then
    raise Exception.Create('O nome do cliente é obrigatório.');

  sCPF := TFormatarCPF.RemoverFormatacao(ACliente.CPF);

  if FClienteRepository.Exists(sCPF) then
    raise Exception.CreateFmt('Já existe o cliente com o CPF ''%s'' cadastrado.', [ACliente.CPF]);

  ConnectionTransaction.StartTransaction;
  try
    ACliente.CPF := sCPF;

    if ACliente.DataCadastro = 0 then
      ACliente.DataCadastro := Now;

    FClienteRepository.InserirDadosBD(ACliente);
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
