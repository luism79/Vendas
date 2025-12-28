program prjVendas;

uses
  Vcl.Forms,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Async,
  uMain in 'uMain.pas' {frmMain},
  uCliente in 'Models\uCliente.pas',
  uCarro in 'Models\uCarro.pas',
  uConexaoConfig in 'Connection\uConexaoConfig.pas',
  uConexaoFactory in 'Connection\uConexaoFactory.pas',
  uIConexaoConfigBuilder in 'Builders\uIConexaoConfigBuilder.pas',
  uConexaoConfigBuilder in 'Builders\uConexaoConfigBuilder.pas',
  uIClienteRepository in 'Repositories\uIClienteRepository.pas',
  uICarroRepository in 'Repositories\uICarroRepository.pas',
  uClienteRepository in 'Repositories\uClienteRepository.pas',
  uCustomRepository in 'Repositories\uCustomRepository.pas',
  uCarroRepository in 'Repositories\uCarroRepository.pas',
  uIConnectionTransaction in 'Connection\uIConnectionTransaction.pas',
  uConnectionTransaction in 'Connection\uConnectionTransaction.pas',
  uClienteService in 'Services\uClienteService.pas',
  uCarroService in 'Services\uCarroService.pas',
  uCustomService in 'Services\uCustomService.pas',
  uFormatarCPF in 'Utils\uFormatarCPF.pas',
  uVenda in 'Models\uVenda.pas',
  uIVendaRepository in 'Repositories\uIVendaRepository.pas',
  uVendaRepository in 'Repositories\uVendaRepository.pas',
  uVendaService in 'Services\uVendaService.pas',
  uIRepository in 'Repositories\uIRepository.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
