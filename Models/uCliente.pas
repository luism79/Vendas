unit uCliente;

interface

type
  TCliente = class
  private
    FId: Integer;
    FNome: string;
    FCPF: String;
    FDataCadastro: TDateTime;
  public
    /// <summary>
    /// Identificador único do cliente no banco de dados
    /// </summary>
    property Id: Integer read FId write FId;

    /// <summary>
    /// Nome Completo do cliente
    /// </summary>
    property Nome: string read FNome write FNome;

    /// <summary>
    /// CPF do cliente sem formatação XXXXXXXXXXX
    /// </summary>
    property CPF: String read FCPF write FCPF;

    /// <summary>
    /// Data e Hora do cadastro do cliente
    /// </summary>
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
  end;

implementation

end.
