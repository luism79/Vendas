unit uCarro;

interface

type
  TCarro = class
  private
    FModelo: string;
    FId: Integer;
    FDataCadastro: TDateTime;
  public
    /// <summary>
    /// Identificador único do cliente no banco de dados
    /// </summary>
    property Id: Integer read FId write FId;

    /// <summary>
    /// Modelo do carro
    /// </summary>
    property Modelo: string read FModelo write FModelo;

    /// <summary>
    /// Data e Hora do cadastro do modelo do carro
    /// </summary>
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
  end;

implementation

end.
