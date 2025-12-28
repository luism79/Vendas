unit uConnectionTransaction;

interface

uses
  FireDAC.Comp.Client, uIConnectionTransaction;

type
  TConnectionTransaction = class(TInterfacedObject, IConnectionTransaction)
  private
    FConnection: TFDCustomConnection;
  public
    constructor Create(AConnection: TFDCustomConnection);

    procedure Commit;
    procedure Rollback;
    procedure StartTransaction;
  end;

implementation

{ TConnectionTransaction }

procedure TConnectionTransaction.Commit;
begin
  FConnection.Commit;
end;

constructor TConnectionTransaction.Create(AConnection: TFDCustomConnection);
begin
  FConnection := AConnection;
end;

procedure TConnectionTransaction.Rollback;
begin
  FConnection.Rollback;
end;

procedure TConnectionTransaction.StartTransaction;
begin
  FConnection.StartTransaction;
end;

end.
