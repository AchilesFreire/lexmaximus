program EditorPropriedades;

uses
  Forms,
  Principal in 'Forms\Principal.pas' {FrmPrincipal},
  CompressaoDados in '..\Common\CompressaoDados.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
