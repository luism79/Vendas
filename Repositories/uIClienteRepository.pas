unit uIClienteRepository;

interface

uses
  uIRepository, uCliente;

type
  IClienteRepository = interface(IRepository)
    ['{48CA5AA0-36E7-4E4F-B92F-6646FF3E2C33}']
    function ClienteByCPF(const ACPF: string): TCliente;
    function Exists(const ACPF: string): Boolean;
    procedure InserirDadosBD(AClinte: TCliente);
    function LocateById(const AId: Integer): Boolean;
  end;

implementation

end.
