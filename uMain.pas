unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, uConnectionTransaction, Vcl.StdCtrls,
  Vcl.Buttons, uCliente, uCarro, uIClienteRepository, uClienteRepository, uICarroRepository,
  uCarroRepository, uVendaRepository, uIVendaRepository, uIConnectionTransaction;

type
  TfrmMain = class(TForm)
    btnAddClientes: TBitBtn;
    btnAddCarros: TBitBtn;
    btnAddVendas: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddClientesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddCarrosClick(Sender: TObject);
    procedure btnAddVendasClick(Sender: TObject);
  private
    { Private declarations }
    FConn: TFDCustomConnection;
    FConTransaction: IConnectionTransaction;
    FCarroRepository: ICarroRepository;
    FClienteRepository: IClienteRepository;
    FVendaRepository: IVendaRepository;

    procedure AddCarroBD(const AModelo: string);
    procedure AddClienteBD(const ANome, ACPF: string);
    procedure AddVenda(const ACPF, AModelo: string);
    procedure AddVendaBD(ACliente: TCliente; ACarro: TCarro);
    procedure CriarConexaoBD;
    procedure CriarRepositorios;
    function GetCarro(const AModelo: string): TCarro;
    function GetCliente(const ACPF: string): TCliente;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uConexaoFactory, uConexaoConfigBuilder, uClienteService, uCarroService, uVenda,
  uVendaService, uFormatarCPF;

{$R *.dfm}

{ TForm1 }

procedure TfrmMain.AddCarroBD(const AModelo: string);
var
  lCarro: TCarro;
  lService: TCarroService;
begin
  lCarro := TCarro.Create;
  lService := TCarroService.Create(FConTransaction, FCarroRepository);
  try
    lCarro.Modelo := AModelo;
    lCarro.DataCadastro := Now;

    lService.InserirDadosBD(lCarro);
  finally
    FreeAndNil(lService);
    FreeAndNil(lCarro);
  end;
end;

procedure TfrmMain.AddClienteBD(const ANome, ACPF: string);
var
  lCliente: TCliente;
  lService: TClienteService;
begin
  lCliente := TCliente.Create;
  lService := TClienteService.Create(FConTransaction, FClienteRepository);
  try
    lCliente.Nome := ANome;
    lCliente.CPF := ACPF;
    lCliente.DataCadastro := Now;

    lService.InserirDadosBD(lCliente);
  finally
    FreeAndNil(lService);
    FreeAndNil(lCliente);
  end;
end;

procedure TfrmMain.AddVenda(const ACPF, AModelo: string);
var
  lCliente: TCliente;
  lCarro: TCarro;
begin
  try
    lCliente := GetCliente(ACPF);

    if not Assigned(lCliente) then
      raise Exception.CreateFmt('Cliente ''%s'' não foi encontrado.', [ACPF]);
      
    lCarro := GetCarro(AModelo);

    if not Assigned(lCarro) then
      raise Exception.CreateFmt('O modelo do carro ''%s'' não foi encontrado.', [AModelo]);

    AddVendaBD(lCliente, lCarro);
  finally
    FreeAndNil(lCarro);
    FreeAndNil(lCliente);
  end;
end;

procedure TfrmMain.AddVendaBD(ACliente: TCliente; ACarro: TCarro);
var
  lVenda: TVenda;
  lServive: TVendaService;
begin
  lVenda := TVenda.Create;
  lServive := TVendaService.Create(FConTransaction,
    FVendaRepository, FClienteRepository, FCarroRepository);
  try
    lVenda.IdCliente := ACliente.Id;
    lVenda.IdCarro := ACarro.Id;
    
    lServive.InserirDadosBD(lVenda);
  finally
    FreeAndNil(lServive);
    FreeAndNil(lVenda);
  end;
end;

procedure TfrmMain.btnAddCarrosClick(Sender: TObject);
begin
  AddCarroBD('Honda HRV');
  AddCarroBD('Jeep Compass');
  AddCarroBD('Polo');
  AddCarroBD('Nivus');
  AddCarroBD('Kicks');  
end;

procedure TfrmMain.btnAddClientesClick(Sender: TObject);
begin
  AddClienteBD('João da Silva', '123.456.789-00');
  AddClienteBD('Maria dos Santos', '234.567.890-11');
  AddClienteBD('Jaqueline de Oliveira', '345.567.890-22');
  AddClienteBD('Ana Costa', '456.789.012-33');
  AddClienteBD('Weila Maria', '567.890.123-44');
end;

procedure TfrmMain.btnAddVendasClick(Sender: TObject);
const
  MsgError = 'Falha na operação de venda!'#13#10;
begin
  try
    AddVenda('123.456.789-00', 'Honda HRV');
    AddVenda('234.567.890-11', 'Jeep Compass');
    AddVenda('345.567.890-22', 'Polo');
    AddVenda('456.789.012-33', 'Nivus');
    AddVenda('567.890.123-44', 'Kicks');  
  except
    on E: Exception do
    begin
      Application.MessageBox(PWideChar(MsgError + e.Message),
        'Falha na Venda', MB_ICONERROR);
    end;
  end;
end;

procedure TfrmMain.CriarConexaoBD;
begin
  FConn := TConexao.ConexaoBD(TConexaoConfigBuilder
    .Novo
    .SetDriverName('PG')
    .SetDatabase('dbCursoUdemy')
    .SetHost('localhost')
    .SetPassword('micro2008')
    .SetUserName('postgres')
    .SetPort(7649)
    .Build);

  FConTransaction := TConnectionTransaction.Create(FConn);
end;

procedure TfrmMain.CriarRepositorios;
begin
  FCarroRepository := TCarroRepository.Create(FConn);
  FClienteRepository := TClienteRepository.Create(FConn);
  FVendaRepository := TVendaRepository.Create(FConn);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FConn);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  CriarConexaoBD;
  CriarRepositorios;
end;

function TfrmMain.GetCarro(const AModelo: string): TCarro;
begin
  Result := nil;
  if Assigned(FCarroRepository) then
    Result := FCarroRepository.CarroByModelo(AModelo);
end;

function TfrmMain.GetCliente(const ACPF: string): TCliente;
begin
  Result := nil;
  if Assigned(FClienteRepository) then
    Result := FClienteRepository.ClienteByCPF(TFormatarCPF.RemoverFormatacao(ACPF));
end;

end.
