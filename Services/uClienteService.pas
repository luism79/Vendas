unit uClienteService;

interface

uses
  FireDAC.Comp.Client, uCustomService, uIClienteRepository, uCliente, uIConnectionTransaction, uIClienteService;

type
  TClienteService = class(TCustomService, IClienteService)
  private
    FClienteRepository: IClienteRepository;

    procedure SetRepository(AClienteRepository: IClienteRepository);
  public
    constructor Create(AConnectionTransaction: IConnectionTransaction;
      AClienteRepository: IClienteRepository); reintroduce;

    function ClienteByCPF(const ACPF: string): TCliente;
    function ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
    function Exists(const ACPF: string): Boolean;
    procedure InserirDadosBD(ACliente: TCliente);
    function LocateById(const AId: Integer): Boolean;
  end;

implementation

uses
  System.SysUtils, uFormatarCPF;

{ TClienteService }

function TClienteService.ClienteByCPF(const ACPF: string): TCliente;
begin
  Result := FClienteRepository.ClienteByCPF(ACPF);
end;

constructor TClienteService.Create(AConnectionTransaction: IConnectionTransaction;
  AClienteRepository: IClienteRepository);
begin
  inherited Create(AConnectionTransaction);
  SetRepository(AClienteRepository);
end;

function TClienteService.ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
begin
  Result := FClienteRepository.ExecutarSQL(ASQL, AParams);
end;

function TClienteService.Exists(const ACPF: string): Boolean;
begin
  Result := FClienteRepository.Exists(ACPF);
end;

procedure TClienteService.InserirDadosBD(ACliente: TCliente);
var
  sCPF: string;
begin
  if ACliente.Nome = EmptyStr then
    raise Exception.Create('O nome do cliente é obrigatório.');

  sCPF := TFormatarCPF.RemoverFormatacao(ACliente.CPF);

  if Exists(sCPF) then
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

function TClienteService.LocateById(const AId: Integer): Boolean;
begin
  Result := FClienteRepository.LocateById(AId);
end;

procedure TClienteService.SetRepository(AClienteRepository: IClienteRepository);
begin
  if not Assigned(AClienteRepository) then
    raise EArgumentException.Create('O argumento do repositório ''IClienteRepository'' não foi informado.');

  FClienteRepository := AClienteRepository;
end;

end.
