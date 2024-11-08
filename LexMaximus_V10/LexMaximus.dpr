program LexMaximus;

uses
  Forms,
  Principal in 'Forms\Principal.pas' {FrmPrincipal},
  Configuracoes in 'Units\Configuracoes.pas',
  Funcoes in 'Units\Funcoes.pas',
  cls_Lei in 'Units\BusinessClass\cls_Lei.pas',
  cls_TipoLei in 'Units\BusinessClass\cls_TipoLei.pas',
  Rul_Lei in 'Units\BusinessRule\Rul_Lei.pas',
  Rul_TipoLei in 'Units\BusinessRule\Rul_TipoLei.pas',
  cls_Conexao in 'Units\cls_Conexao.pas',
  CompressaoDados in '..\Common\CompressaoDados.pas',
  Ativacao in 'Forms\Ativacao.pas' {FrmAtivacao},
  Splash in 'Forms\Splash.pas' {FrmSplash},
  ControleLicenca in '..\Common\ControleLicenca.pas',
  Message in 'Forms\Message.pas' {FrmMessage},
  Administrador in 'Forms\Administrador.pas' {FrmAdministrador},
  PassoAPassoAdministrador in 'Forms\PassoAPassoAdministrador.pas' {FrmPassoAPassoAdministrador},
  AtualizacoesSistema in 'Units\AtualizacoesSistema.pas',
  AndamentoPesquisa in 'Forms\AndamentoPesquisa.pas' {FrmAndamento},
  cls_NotaLei in 'Units\BusinessClass\cls_NotaLei.pas',
  Rul_NotaLei in 'Units\BusinessRule\Rul_NotaLei.pas',
  EdicaoNota in 'Forms\EdicaoNota.pas' {FrmEdicaoNota},
  AlteracaoDocumento in 'Forms\AlteracaoDocumento.pas' {FrmAlteracaoLei},
  LicencaUso in 'Forms\LicencaUso.pas',
  EditorConfiguracoes in 'Forms\EditorConfiguracoes.pas',
  AjusteExecucaoCD in 'Forms\AjusteExecucaoCD.pas' {FrmAjusteExecucaoCD},
  HDFunc in '..\Common\HDFunc.pas',
  FuncoesClipBoard in 'Units\FuncoesClipBoard.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmAtivacao, FrmAtivacao);
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.CreateForm(TFrmMessage, FrmMessage);
  Application.CreateForm(TFrmAdministrador, FrmAdministrador);
  Application.CreateForm(TFrmPassoAPassoAdministrador, FrmPassoAPassoAdministrador);
  Application.CreateForm(TFrmAndamento, FrmAndamento);
  Application.CreateForm(TFrmEdicaoNota, FrmEdicaoNota);
  Application.CreateForm(TFrmAlteracaoLei, FrmAlteracaoLei);
  Application.CreateForm(TFrmAjusteExecucaoCD, FrmAjusteExecucaoCD);
  Application.Run;
end.
