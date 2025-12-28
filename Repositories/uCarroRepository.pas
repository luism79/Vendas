unit uCarroRepository;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, uCustomRepository, uICarroRepository, uCarro;

type
  TCarroRepository = class(TCustomRepository, ICarroRepository)
  private
  public

    function CarroByModelo(const AModelo: string): TCarro;
    function ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
    function Exists(const AModelo: string): Boolean;
    procedure InserirDadosBD(ACarro: TCarro);
    function LocateById(const AId: Integer): Boolean;
  end;

implementation

uses
  FireDAC.DApt, FireDAC.Stan.Param, Data.DB;

{ TCarroRepository }

function TCarroRepository.CarroByModelo(const AModelo: string): TCarro;
var
  lQuery: TFDQuery;
begin
  lQuery := ExecutarSQL('select c.id, c.modelo, c.data_cadastro'#13#10 +
                        'from carro c'#13#10 +
                        'where lower(c.modelo) = :modelo', [LowerCase(AModelo)]);
  try
    if lQuery.IsEmpty then
      Result := nil
    else
    begin
      Result := TCarro.Create;

      Result.Id := lQuery.Fields[0].AsInteger;
      Result.Modelo := lQuery.Fields[1].AsString;
      Result.DataCadastro := lQuery.Fields[2].AsDateTime;
    end;
  finally
    FreeAndNil(lQuery);
  end;
end;

function TCarroRepository.ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Connection;
  Result.Open(ASQL, AParams);
end;

function TCarroRepository.Exists(const AModelo: string): Boolean;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := Connection;
    lQuery.SQL.Text := 'select id'#13#10 +
                       'from carro'#13#10 +
                       'where lower(modelo) = :modelo'#13#10 +
                       'limit 1';
    lQuery.ParamByName('modelo').AsString := LowerCase(AModelo);
    lQuery.Open;

    Result := not lQuery.IsEmpty;
  finally
    FreeAndNil(lQuery);
  end;  // try
end;

procedure TCarroRepository.InserirDadosBD(ACarro: TCarro);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := Connection;
    lQuery.SQL.Text := 'insert into carro'#13#10 +
                       '  (modelo, data_cadastro)'#13#10 +
                       'values'#13#10 +
                       '  (:modelo, :data_cadastro)'#13#10 +
                       'returning id';
    lQuery.ParamByName('modelo').AsString := ACarro.Modelo;
    lQuery.ParamByName('data_cadastro').AsDateTime := ACarro.DataCadastro;
    lQuery.Open;

    ACarro.Id := lQuery.Fields[0].AsInteger;
  finally
    FreeAndNil(lQuery);
  end;  // try
end;

function TCarroRepository.LocateById(const AId: Integer): Boolean;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := Connection;
    lQuery.SQL.Text := 'select id'#13#10 +
                       'from carro'#13#10 +
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
