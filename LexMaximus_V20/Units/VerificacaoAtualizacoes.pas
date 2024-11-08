unit VerificacaoAtualizacoes;

interface

uses
  Classes,
  DB, ADODB,
  cls_conexao,
  Sysutils,
  DownloadAtualizacoes;

type
  //ThreadVerificacaoAtualizacoes = class(TThread)
  ThreadVerificacaoAtualizacoes = class(TObject)
  private
    { Private declarations }
    varControleAtualizacoes           : TDownloadAtualizacoes;
    varVerificacaoRealizada           : Boolean;
    varMensagem                       : String;
    varAssinaturaExpirou              : Boolean;
    varMensagemAssinatura             : String;
    varTotalAtualizacoes              : Integer;

    varErroServidor                   : Boolean;
  protected
    //procedure Execute; override;
    procedure Execute;


  public

    property ControleAtualizacoes: TDownloadAtualizacoes read varControleAtualizacoes write varControleAtualizacoes;
    Property VerificacaoRealizada       : Boolean         read varVerificacaoRealizada      write varVerificacaoRealizada;
    Property Mensagem       : String         read varMensagem      write varMensagem;
    Property MensagemAssinatura       : String         read varMensagemAssinatura      write varMensagemAssinatura;

    Property AssinaturaExpirou       : Boolean         read varAssinaturaExpirou      write varAssinaturaExpirou;
    Property TotalAtualizacoes       : Integer         read varTotalAtualizacoes      write varTotalAtualizacoes;

    Property ErroServidor       : Boolean         read varErroServidor      write varErroServidor;

    constructor Create(PControleAtualizacoes : TDownloadAtualizacoes); overload;

    procedure VerificaAtualizacoes();

    Function VerificaAssinaturaCliente() : string;

  end;

implementation

constructor ThreadVerificacaoAtualizacoes.Create(PControleAtualizacoes : TDownloadAtualizacoes);
begin

  varControleAtualizacoes := PControleAtualizacoes;
  varVerificacaoRealizada := False;
  //Create(False);
  //FreeOnTerminate := false;

  create();

end;

procedure ThreadVerificacaoAtualizacoes.Execute;
begin
    VerificaAtualizacoes() ;
    //Self.Terminate;
end;

Function ThreadVerificacaoAtualizacoes.VerificaAssinaturaCliente() : string;
begin

  result := '';
  
end;

procedure ThreadVerificacaoAtualizacoes.VerificaAtualizacoes();
begin

  try
    varErroServidor := false;
    if not varControleAtualizacoes.ConexaoSrvAtu.AbreConexao() then
      begin
        varErroServidor := True;
        varMensagem :=      varControleAtualizacoes.ConexaoSrvAtu.mensagem;
        exit;
      end;
    varMensagem := '';
    varTotalAtualizacoes := 0;

    varMensagemAssinatura := ControleAtualizacoes.VerificaAssinaturaCliente();

    if varControleAtualizacoes.Mensagem = '' then
      begin
        if varMensagemAssinatura = '' then
          begin
            varAssinaturaExpirou := False;
            varTotalAtualizacoes := ControleAtualizacoes.VerificaAtualizacoes(false);
          end
        else
          begin
            varAssinaturaExpirou := True;
          end;
        varMensagem := 'OK';
        varVerificacaoRealizada := True;
      end
    else
      begin
        varMensagem := varControleAtualizacoes.Mensagem;
        varVerificacaoRealizada := false;
      end;

  except
    on ex : exception do
      begin
        varMensagem := ex.Message;
      end;
  end;
  
end;


end.
