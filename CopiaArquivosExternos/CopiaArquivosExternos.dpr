program CopiaArquivosExternos;

uses
  Forms,
  Principal in 'Forms\Principal.pas' {FrmPrincipal},
  Andamento in 'Forms\Andamento.pas' {FrmAndamento};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmAndamento, FrmAndamento);
  Application.Run;
end.
