unit AtualizacoesSistema;

interface
uses Windows,
     Messages,
     SysUtils,
     Variants,
     Classes,
     Graphics,
     Controls,
     Forms,
     Dialogs,
     StdCtrls,
     shellapi,
     ExtCtrls,
     ComCtrls,
     ActiveX,
     Urlmon;

Type
  TAtualizacoesSistema = class(TObject)
  private
    varUrlAtualizacoes        : string;
    varURL                    : string;
    varListaAtualizacoes      : string;

  public
    Constructor Create(Owner : Tcomponent);
    Destructor Destroy;  override;
    Function ObtemListaAtualizacoes() : Boolean;
    Function SalvaArquivo(Pagina : string ;Caminho : string) : boolean;
    procedure initWinInetHTTP;
    property URL                : string read varURL                write varURL;
    property URlAtualizacoes    : string read varUrlAtualizacoes    write varUrlAtualizacoes;
    property ListaAtualizacoes  : string read varListaAtualizacoes  write varListaAtualizacoes;

    Function ObtemConteudoHTML( Pagina : string ; Arquivo : String) : string;

  end;

Const

  HTTP_Request = 'Accept: text/html, */*' + chr(13) + 'User-Agent: Mozilla/3.0 (compatible; TALWinInetHTTPClient)';
implementation


Destructor TAtualizacoesSistema.Destroy();
begin
end;

{*******************************************}
Constructor TAtualizacoesSistema.Create(Owner : Tcomponent);
begin

end;

Function TAtualizacoesSistema.ObtemListaAtualizacoes() : boolean;

begin
    try

      (*****************
      FWinInetHttpClient.Get( UrlAtualizacoes, AHTTPResponseStream, AHTTPResponseHeader );
      Listaatualizacoes := AHTTPResponseStream.DataString;
      *****************)

      Result := True;

    except
      Listaatualizacoes := '';
      Result := False;

      //Raise;
    end;

end;

Function TAtualizacoesSistema.SalvaArquivo(Pagina : string ;Caminho : string) : boolean;

begin

  try
    UrlDownloadToFile(nil, PChar(Pagina), PChar(Caminho), 0, nil);
    result := true;
  except
    result := false;
  end;


end;

Function TAtualizacoesSistema.ObtemConteudoHTML( Pagina : string ; Arquivo : String ) : string;

Var
  Conteudo : TStringList;

begin
  Conteudo := TStringList.Create;

  URLDownloadToFile(nil, PChar(Pagina), PChar(Arquivo) , 0, nil);


end;

procedure TAtualizacoesSistema.initWinInetHTTP;
Begin
  (*****************
  With FWinInetHTTPClient do begin
    UserName := '';
    Password := '';

    ConnectTimeout  := 0;
    SendTimeout     := 0;
    ReceiveTimeout  := 0;

    //ProtocolVersion := HTTPpv_1_0
    ProtocolVersion := HTTPpv_1_1;

    UploadBufferSize := 32768;

    ProxyParams.ProxyServer := '';
    ProxyParams.ProxyPort := 80;
    ProxyParams.ProxyUserName := '';
    ProxyParams.ProxyPassword := '';
    ProxyParams.ProxyBypass := '';

    AccessType := wHttpAt_Preconfig;

    InternetOptions := [];
    InternetOptions := InternetOptions + [wHttpIo_Keep_connection];

    RequestHeader.RawHeaderText := 'Accept: text/html, */*' + chr(13) + 'User-Agent: Mozilla/3.0 (compatible; TALWinInetHTTPClient)';
  end;
  *****************)
end;



end.
