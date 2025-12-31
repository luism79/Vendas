unit uIClienteService;

interface

uses
  FireDAC.Comp.Client, uCliente;

type
  IClienteService = interface
    ['{E15AFB4C-153A-4087-9BF1-3D241CF4A294}']
    function ClienteByCPF(const ACPF: string): TCliente;
    function ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
    function Exists(const ACPF: string): Boolean;
    procedure InserirDadosBD(ACliente: TCliente);
    function LocateById(const AId: Integer): Boolean;
  end;

implementation

end.
