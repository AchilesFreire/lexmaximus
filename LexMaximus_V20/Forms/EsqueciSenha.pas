unit EsqueciSenha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, StrUtils,
  Mensagens,
  Configuracoes;

type
  TFrmEsqueciSenha = class(TForm)
    Panel1: TPanel;
    BtnOk: TButton;
    BtnCancelar: TButton;
    Label1: TLabel;
    TxtEmail: TEdit;
    IndyHTTP: TIdHTTP;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    varConfiguracoes                  : TConfiguracoes;

  public
    { Public declarations }
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;
  end;

var
  FrmEsqueciSenha: TFrmEsqueciSenha;

implementation

{$R *.dfm}

procedure TFrmEsqueciSenha.BtnCancelarClick(Sender: TObject);
begin
  self.Close();
end;

procedure TFrmEsqueciSenha.BtnOkClick(Sender: TObject);
var
  Resposta : String;
  Email : String;
  Link : String;
begin
  try
    Email := trim ( TxtEmail.Text);

    // para evitar injection
    Email := ReplaceStr(Email, '''','');
    Email := ReplaceStr(Email, '"','');

    if ( Email = '' ) then
      begin
        Mensagem( self, 'Informe o email utilizado no cadastro',self.caption, varConfiguracoes);
        exit;
      end;

    Link := 'http://www.elfez.com.br/AtualizacoesProdutos/AdministracaoAtualizacoes/EsqueciSenha.aspx?TxtEmail=' + Email;

    resposta := IndyHTTP.Get(Link);

    Mensagem( self, 'Aguarde alguns instantes enquanto a confirmação chega no seu email ',self.caption, varConfiguracoes);

    self.Close();

  Except
    on ex : Exception do
      begin
        Mensagem( self, 'Erro:' + ex.Message ,self.caption, varConfiguracoes);
      end;


  end;
end;

end.
