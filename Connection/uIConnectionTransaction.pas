unit uIConnectionTransaction;

interface

type
  IConnectionTransaction = interface
    ['{AA67216F-652E-4459-8203-CE10A8D19D27}']

    procedure Commit;
    procedure Rollback;
    procedure StartTransaction;
  end;

implementation

end.
