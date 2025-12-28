unit uCustomRepository;

interface

uses
  System.SysUtils, FireDAC.Comp.Client;

type
  TCustomRepository = class(TInterfacedObject)
  private
    FConnection: TFDCustomConnection;
  public
    constructor Create(AConnection: TFDCustomConnection);

    property Connection: TFDCustomConnection read FConnection;
  end;

implementation

{ TCustomRepository }

constructor TCustomRepository.Create(AConnection: TFDCustomConnection);
begin
  FConnection := AConnection;
end;

end.
