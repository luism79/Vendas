unit uICarroRepository;

interface

uses
  uIRepository, uCarro;

type
  ICarroRepository = interface(IRepository)
    ['{94ECB4F5-2B67-4F45-81EC-AA19B361B10E}']
    function CarroByModelo(const AModelo: string): TCarro;
    function Exists(const AModelo: string): Boolean;
    procedure InserirDadosBD(ACarro: TCarro);
    function LocateById(const AId: Integer): Boolean;
  end;

implementation

end.
