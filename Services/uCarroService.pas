unit uCarroService;

interface

uses
  FireDAC.Comp.Client, uCustomService, uIConnectionTransaction, uICarroRepository, uCarro, uICarroService;

type
  TCarroService = class(TCustomService, ICarroService)
  private
    FCarroRepository: ICarroRepository;

    procedure SetRepository(ACarroRepository: ICarroRepository);
  public
    constructor Create(AConnectionTransaction: IConnectionTransaction;
      ACarroRepository: ICarroRepository); reintroduce;

    function CarroByModelo(const AModelo: string): TCarro;
    function ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
    function Exists(const AModelo: string): Boolean;
    procedure InserirDadosBD(ACarro: TCarro);
    function LocateById(const AId: Integer): Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TCarroService }

function TCarroService.CarroByModelo(const AModelo: string): TCarro;
begin
  Result := FCarroRepository.CarroByModelo(AModelo);
end;

constructor TCarroService.Create(AConnectionTransaction: IConnectionTransaction;
  ACarroRepository: ICarroRepository);
begin
  inherited Create(AConnectionTransaction);
  SetRepository(ACarroRepository);
end;

function TCarroService.ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
begin
  Result := FCarroRepository.ExecutarSQL(ASQL, AParams);
end;

function TCarroService.Exists(const AModelo: string): Boolean;
begin
  Result := FCarroRepository.Exists(AModelo);
end;

procedure TCarroService.InserirDadosBD(ACarro: TCarro);
begin
  if ACarro.Modelo = EmptyStr then
    raise Exception.Create('O modelo do carro é obrigatório.');

  if Exists(ACarro.Modelo) then
    raise Exception.CreateFmt('Já existe o modelo ''%s'' cadastrado.', [ACarro.Modelo]);


  if ACarro.DataCadastro = 0 then
    ACarro.DataCadastro := Now;

  ConnectionTransaction.StartTransaction;
  try
    FCarroRepository.InserirDadosBD(ACarro);
    ConnectionTransaction.Commit;
  except
    on E: Exception do
    begin
      ConnectionTransaction.Rollback;
      raise;
    end;
  end;
end;

function TCarroService.LocateById(const AId: Integer): Boolean;
begin
  Result := FCarroRepository.LocateById(AId);
end;

procedure TCarroService.SetRepository(ACarroRepository: ICarroRepository);
begin
  if not Assigned(ACarroRepository) then
    raise EArgumentException.Create('O argumento do repositório ''ICarroRepository'' não foi informado.');

  FCarroRepository := ACarroRepository;
end;

end.
