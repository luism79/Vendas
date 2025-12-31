unit uCustomService;

interface

uses
  uIConnectionTransaction;

type
  TCustomService = class(TInterfacedObject)
  private
    FConnectionTransaction: IConnectionTransaction;
  public
    constructor Create(AConnectionTransaction: IConnectionTransaction);

    property ConnectionTransaction: IConnectionTransaction read FConnectionTransaction;
  end;

implementation

{ TCustomService }

constructor TCustomService.Create(AConnectionTransaction: IConnectionTransaction);
begin
  FConnectionTransaction := AConnectionTransaction;
end;

end.
