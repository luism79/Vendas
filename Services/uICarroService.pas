unit uICarroService;

interface

uses
  FireDAC.Comp.Client, uCarro;

type
  ICarroService = interface
    ['{9FE3589F-FBAD-4F67-86C0-0AA3E3ED2BF6}']
    function CarroByModelo(const AModelo: string): TCarro;
    function ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
    function Exists(const AModelo: string): Boolean;
    procedure InserirDadosBD(ACarro: TCarro);
    function LocateById(const AId: Integer): Boolean;
  end;

implementation

end.
