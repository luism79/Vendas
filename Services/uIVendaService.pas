unit uIVendaService;

interface

uses
  uVenda;

type
  IVendaService = interface
    ['{57D89DB7-C8DB-42D8-A229-01A6E3B36901}']
    procedure InserirDadosBD(AVenda: TVenda);
  end;

implementation

end.
