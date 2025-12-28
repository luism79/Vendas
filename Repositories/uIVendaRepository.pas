unit uIVendaRepository;

interface

uses
  uVenda;

type
  IVendaRepository = interface
    ['{070A79C7-E0A5-4476-8805-FC48516C41C8}']
    procedure InserirDadosBD(AVenda: TVenda);
  end;


implementation

end.
