unit uIRepository;

interface

uses
  FireDAC.Comp.Client;

type
  IRepository = interface
    ['{207C1CCE-B7A5-4060-8282-A8CE8F3AE395}']
    function ExecutarSQL(const ASQL: string; AParams: array of Variant): TFDQuery;
  end;
implementation

end.
