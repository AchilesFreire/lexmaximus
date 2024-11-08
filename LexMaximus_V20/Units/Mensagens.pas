unit Mensagens;

interface
uses
  Classes, SysUtils, StrUtils,
  Message,
  Configuracoes;

procedure Mensagem(  AOwner : TComponent; Mensagem : String ; Titulo : String ; Configuracoes : TConfiguracoes);

function Pergunta(  AOwner : TComponent; Mensagem : String ; Titulo : String  ; Configuracoes : TConfiguracoes ) : integer;

implementation

var
  frm : TFrmMessage;

procedure Mensagem( AOwner : TComponent; Mensagem : String ; Titulo : String ; Configuracoes : TConfiguracoes);

begin
  try

    if frm = nil then
        frm := TFrmMessage.Create( AOwner );

    frm.Configuracoes := Configuracoes;
    frm.MensagemInformacao( Mensagem, Titulo);

  finally
  end;
end;

function Pergunta(  AOwner : TComponent; Mensagem : String ; Titulo : String  ; Configuracoes : TConfiguracoes ) : integer;

begin
  try

    if frm = nil then
        frm := TFrmMessage.Create( AOwner );

    frm.Configuracoes := Configuracoes;
    frm.MensagemPergunta( Mensagem, Titulo);

    Pergunta := frm.Resultado;

  finally
  end;
end;

end.
