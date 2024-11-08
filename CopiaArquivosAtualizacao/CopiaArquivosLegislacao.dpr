program CopiaArquivosLegislacao;

uses
  Forms,
  Principal in 'Forms\Principal.pas' {FrmPrincipal},
  cls_Conexao in 'Units\cls_Conexao.pas',
  Andamento in 'Forms\Andamento.pas' {FrmAndamento};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmAndamento, FrmAndamento);
  Application.Run;
end.
