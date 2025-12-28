unit uIConexaoConfigBuilder;

interface

uses
  uConexaoConfig;

type
  IConexaoConfigBuilder = interface
    ['{8DDA94BF-D4CA-4867-A96D-AB1CA44DB813}']
    function SetDatabase(const Value: string): IConexaoConfigBuilder;
    function SetDriverName(const Value: string): IConexaoConfigBuilder;
    function SetHost(const Value: string): IConexaoConfigBuilder;
    function SetPassword(const Value: string): IConexaoConfigBuilder;
    function SetPort(const Value: Integer): IConexaoConfigBuilder;
    function SetUserName(const Value: string): IConexaoConfigBuilder;
    function Build: TConexaoConfig;
  end;

implementation

end.
