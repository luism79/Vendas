unit uConexaoConfigBuilder;

interface

uses
  System.SysUtils, uIConexaoConfigBuilder, uConexaoConfig;

type
  TConexaoConfigBuilder = class(TInterfacedObject, IConexaoConfigBuilder)
  private
    FConfig: TConexaoConfig;
  public
    constructor Create;
    destructor Destroy; override;

    function SetDatabase(const Value: string): IConexaoConfigBuilder;
    function SetDriverName(const Value: string): IConexaoConfigBuilder;
    function SetHost(const Value: string): IConexaoConfigBuilder;
    function SetPassword(const Value: string): IConexaoConfigBuilder;
    function SetPort(const Value: Integer): IConexaoConfigBuilder;
    function SetUserName(const Value: string): IConexaoConfigBuilder;
    function Build: TConexaoConfig;

    class function Novo: IConexaoConfigBuilder;
  end;

implementation

{ TConexaoConfigBuilder }

function TConexaoConfigBuilder.Build: TConexaoConfig;
begin
  Result := FConfig;
end;

constructor TConexaoConfigBuilder.Create;
begin
  FConfig := TConexaoConfig.Create;
end;

destructor TConexaoConfigBuilder.Destroy;
begin
  FreeAndNil(FConfig);
  inherited Destroy;
end;

class function TConexaoConfigBuilder.Novo: IConexaoConfigBuilder;
begin
  Result := Create;
end;

function TConexaoConfigBuilder.SetDatabase(const Value: string): IConexaoConfigBuilder;
begin
  FConfig.Database := Value;
  Result := Self;
end;

function TConexaoConfigBuilder.SetDriverName(const Value: string): IConexaoConfigBuilder;
begin
  FConfig.DriverName := Value;
  Result := Self;
end;

function TConexaoConfigBuilder.SetHost(const Value: string): IConexaoConfigBuilder;
begin
  FConfig.Host := Value;
  Result := Self;
end;

function TConexaoConfigBuilder.SetPassword(const Value: string): IConexaoConfigBuilder;
begin
  FConfig.Password := Value;
  Result := Self;
end;

function TConexaoConfigBuilder.SetPort(const Value: Integer): IConexaoConfigBuilder;
begin
  FConfig.Port := Value;
  Result := Self;
end;

function TConexaoConfigBuilder.SetUserName(const Value: string): IConexaoConfigBuilder;
begin
  FConfig.UserName := Value;
  Result := Self;
end;

end.
