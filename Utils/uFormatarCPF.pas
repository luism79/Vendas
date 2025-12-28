unit uFormatarCPF;

interface

type
  TFormatarCPF = class
  private
  public
    /// <summary>
    /// Formatar CPF no formato XXX.XXX.XXX-XX
    /// </summary>
    class function Formatar(const ACPF: string): string;

    /// <summary>
    /// Remover formatação CPF deixando apenas números
    /// </summary>
    class function RemoverFormatacao(const ACPF: string): string;
  end;

implementation

uses
  System.SysUtils, System.MaskUtils;

{ TFormatarCPF }

class function TFormatarCPF.Formatar(const ACPF: string): string;
begin
  Result := FormatMaskText('000.000.000-00;0', ACPF);
end;

class function TFormatarCPF.RemoverFormatacao(const ACPF: string): string;
begin
  Result := StringReplace(ACPF, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
end;

end.
