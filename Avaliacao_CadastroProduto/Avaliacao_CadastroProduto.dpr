program Avaliacao_CadastroProduto;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  FMX.Forms,
  unLib in 'unLib.pas',
  unTelaCadastroPadrao in 'unTelaCadastroPadrao.pas' {frameTelaCadastroPadrao: TFrame},
  unTelaCadastroPadrao2 in 'unTelaCadastroPadrao2.pas' {frameTelaCadastroPadrao2: TFrame},
  unManutencaoGrupoProduto in 'unManutencaoGrupoProduto.pas' {frameManutencaoGrupoProduto: TFrame},
  unAjuda in 'unAjuda.pas' {frameAjuda: TFrame},
  unCadastroProduto in 'unCadastroProduto.pas' {frameCadastroProduto: TFrame},
  unManutencaoSistema in 'unManutencaoSistema.pas' {frameManutencaoSistema: TFrame},
  unLogin in 'unLogin.pas' {frameLogin: TFrame},
  unConfigurarServidor in 'unConfigurarServidor.pas' {frameConfigurarServidor: TFrame},
  unConsultaPadrao in 'unConsultaPadrao.pas' {frameConsultaPadrao: TFrame},
  unMain in 'unMain.pas' {frmMain},
  unCadastroContato in 'unCadastroContato.pas' {frameCadastroContato: TFrame},
  unManutencaoTipoContato in 'unManutencaoTipoContato.pas' {frameManutencaoTipoContato: TFrame},
  unCadastroFornecedor in 'unCadastroFornecedor.pas' {frameCadastroFornecedor: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
