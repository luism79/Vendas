unit uConexaoFactory;

interface

uses
  FireDAC.Comp.Client, uConexaoConfig;

type
  TConexao = class
  private
  public
    class function ConexaoBD(AParamConfig: TConexaoConfig): TFDCustomConnection;
  end;

implementation

uses
  System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.Stan.Option;

{ TConexao }

class function TConexao.ConexaoBD(AParamConfig: TConexaoConfig): TFDCustomConnection;
begin
  Result := TFDCustomConnection.Create(nil);
  Result.LoginPrompt := False;
  Result.ResourceOptions.SilentMode := True;
  Result.Params.Clear;
  Result.DriverName := AParamConfig.DriverName;
  Result.Params.Add('Server=' + AParamConfig.Host);
  Result.Params.Add('Port=' + AParamConfig.Port.ToString);
  Result.Params.Add('Database=' + AParamConfig.Database);
  Result.Params.Add('User_Name=' + AParamConfig.UserName);
  Result.Params.Add('Password=' + AParamConfig.Password);
end;

end.
