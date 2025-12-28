unit uClienteRepository;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, uCustomRepository, uCliente, uIClienteRepository;

type
  TClienteRepository = class(TCustomRepository, IClienteRepository)
  private
  public

    function ClienteByCPF(const ACPF: string): TCliente;
    function ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
    function Exists(const ACPF: string): Boolean;
    procedure InserirDadosBD(ACliente: TCliente);
    function LocateById(const AId: Integer): Boolean;
  end;

implementation

uses
  FireDAC.DApt, FireDAC.Stan.Param, Data.DB;

{ TClienteRepository }

function TClienteRepository.ClienteByCPF(const ACPF: string): TCliente;
var
  lQuery: TFDQuery;
begin
  lQuery := ExecutarSQL('select c.id, c.nome, c.cpf, c.data_cadastro'#13#10 +
                        'from cliente c'#13#10 +
                        'where c.cpf = :cpf', [ACPF]);
  try
    if lQuery.IsEmpty then
      Result := nil
    else
    begin
      Result := TCliente.Create;

      Result.Id := lQuery.Fields[0].AsInteger;
      Result.Nome := lQuery.Fields[1].AsString;
      Result.CPF := lQuery.Fields[2].AsString;
      Result.DataCadastro := lQuery.Fields[3].AsDateTime;
    end;
  finally
    FreeAndNil(lQuery);
  end;
end;

function TClienteRepository.ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Connection;
  Result.Open(ASQL, AParams);
end;

function TClienteRepository.Exists(const ACPF: string): Boolean;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := Connection;
    lQuery.SQL.Text := 'select cpf'#13#10 +
                       'from cliente'#13#10 +
                       'where cpf = :cpf'#13#10 +
                       'limit 1';
    lQuery.ParamByName('cpf').AsString := ACPF;
    lQuery.Open;

    Result := not lQuery.IsEmpty;
  finally
    FreeAndNil(lQuery);
  end;  // try
end;

procedure TClienteRepository.InserirDadosBD(ACliente: TCliente);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := Connection;
    lQuery.SQL.Text := 'insert into cliente'#13#10 +
                       '  (nome, cpf, data_cadastro)'#13#10 +
                       'values'#13#10 +
                       '  (:nome, :cpf, :data_cadastro)'#13#10 +
                       'returning id';
    lQuery.ParamByName('nome').AsString := ACliente.Nome;
    lQuery.ParamByName('cpf').AsString := ACliente.CPF;
    lQuery.ParamByName('data_cadastro').AsDateTime := ACliente.DataCadastro;
    lQuery.Open;

    ACliente.Id := lQuery.Fields[0].AsInteger;
  finally
    FreeAndNil(lQuery);
  end;  // try
end;

function TClienteRepository.LocateById(const AId: Integer): Boolean;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := Connection;
    lQuery.SQL.Text := 'select id'#13#10 +
                       'from cliente'#13#10 +
                       'where id = :id'#13#10 +
                       'limit 1';
    lQuery.ParamByName('id').AsInteger := AId;
    lQuery.Open;

    Result := not lQuery.IsEmpty;
  finally
    FreeAndNil(lQuery);
  end;  // try
end;

end.
