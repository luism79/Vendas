unit uVenda;

interface

type
  TVenda = class
  private
    FId: Integer;
    FDataVenda: TDateTime;
    FIdCliente: Integer;
    FIdCarro: Integer;
  public
    /// <summary>
    /// Identificador único da venda no banco de dados
    /// </summary>
    property Id: Integer read FId write FId;

    /// <summary>
    /// Data e Hora da realização da venda
    /// </summary>
    property DataVenda: TDateTime read FDataVenda write FDataVenda;

    /// <summary>
    /// Id do Cliente que realizou a compra
    /// </summary>
    property IdCliente: Integer read FIdCliente write FIdCliente;

    /// <summary>
    /// Id do Carro que foi comprado
    /// </summary>
    property IdCarro: Integer read FIdCarro write FIdCarro;
  end;

implementation

end.
