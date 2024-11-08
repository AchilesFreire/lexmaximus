unit InstalacaoAtualizacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TFrmInstalacaoAtualizacao = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Lbl_NomePacote: TLabel;
    Label2: TLabel;
    LblAndamento: TLabel;
    Progresso: TProgressBar;
    LblAdvertencia: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInstalacaoAtualizacao: TFrmInstalacaoAtualizacao;

implementation

{$R *.dfm}

end.
