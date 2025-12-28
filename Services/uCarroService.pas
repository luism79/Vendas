unit uCarroService;

interface

uses
  uCustomService, uIConnectionTransaction, uICarroRepository, uCarro;

type
  TCarroService = class(TCustomService)
  private
    FCarroRepository: ICarroRepository;
  public
    constructor Create(AConnectionTransaction: IConnectionTransaction;
      ACarroRepository: ICarroRepository); reintroduce;

    procedure InserirDadosBD(ACarro: TCarro);
  end;

implementation

uses
  System.SysUtils;

{ TCarroService }

constructor TCarroService.Create(AConnectionTransaction: IConnectionTransaction;
  ACarroRepository: ICarroRepository);
begin
  inherited Create(AConnectionTransaction);
  FCarroRepository := ACarroRepository;
end;

procedure TCarroService.InserirDadosBD(ACarro: TCarro);
begin
  if ACarro.Modelo = EmptyStr then
    raise Exception.Create('O modelo do carro é obrigatório.');

  if FCarroRepository.Exists(ACarro.Modelo) then
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

end.
