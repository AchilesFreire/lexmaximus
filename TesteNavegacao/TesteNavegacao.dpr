program TesteNavegacao;

uses
  Forms,
  Principal in 'Principal.pas' {FrmPrincipal},
  Global in 'Global.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
