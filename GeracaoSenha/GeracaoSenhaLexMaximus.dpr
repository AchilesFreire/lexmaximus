program GeracaoSenhaLexMaximus;

uses
  Forms,
  GeracaoSenha in 'GeracaoSenha.pas' {FrmGeracaoSenha},
  Message in 'Message.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmGeracaoSenha, FrmGeracaoSenha);
  Application.Run;
end.
