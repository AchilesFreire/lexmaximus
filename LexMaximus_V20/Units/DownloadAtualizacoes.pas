unit DownloadAtualizacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, ComCtrls,
  ControleLicenca,
  Funcoes,
  Configuracoes,
  //FuncoesValidacao,
  cls_conexao,
  Rul_cliente,
  Rul_Atualizacao,
  Rul_assinaturacliente,
  Browser,
  BrowserLocal,
  EsqueciSenha,
  InstalacaoAtualizacao,
  //ShellZipTool,
  Conexoes,
  ConfiguracoesLogin;

  Type
  PAdoDataSet = ^TAdoDataSet;
  PStringList = ^TStringList;

  TDownloadAtualizacoes = class
  private
    { Private declarations }
    varConexaoSrvAtu                  : TCls_Conexao;
    varConfiguracoes                  : TConfiguracoes;
    varConfiguracoesLogin             : TConfiguracoesLogin;
    varcliente                           : Trul_cliente;
    varMensagem     : string;

    rcd_ES : TAdoDataSet;
    rcd_LM : TAdoDataSet;
    varListaCodigos_LM                   : TStringList;
    varListaCodigos_ES                   : TStringList;

    varListaDescricoes_LM                : TStringList;
    varListaDescricoes_ES                : TStringList;

  public
    { Public declarations }
    constructor Create;

    property ConexaoSrvAtu: TCls_Conexao read varConexaoSrvAtu write varConexaoSrvAtu;
    property Cliente: Trul_cliente read varcliente write varcliente;
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;
    property ConfiguracoesLogin: TConfiguracoesLogin read varConfiguracoesLogin write varConfiguracoesLogin;

    property ListaCodigos_LM: TStringList read varListaCodigos_LM write varListaCodigos_LM;
    property ListaCodigos_ES: TStringList read varListaCodigos_ES write varListaCodigos_ES;

    property ListaDescricoes_LM: TStringList read varListaDescricoes_LM write varListaDescricoes_LM;
    property ListaDescricoes_ES: TStringList read varListaDescricoes_ES write varListaDescricoes_ES;

    Function VerificaAtualizacoes( VerificarAtualizacoesAnteriores : Boolean) : Integer;
    Function CarregaAtualizacoesProduto (  CodigoProduto : Integer ; VerificarAtualizacoesAnteriores : Boolean ) : Integer;
    procedure ListaAtualizacoesProduto ( CodigoProduto : Integer ;  Lista : TListView; VerificarAtualizacoesAnteriores : Boolean) ;

    property Mensagem     : string          read varMensagem     Write varMensagem;

    function VerificaAssinaturaCliente() : String;

    Procedure GeraTabelaAtualizacoesCliente(CodigoProduto : Integer ;var ListaAtualizacoes : TStringList);

  published
    { Public declarations }

  end;
implementation

constructor TDownloadAtualizacoes.Create();
begin

    ListaCodigos_LM    := TStringList.Create();
    ListaCodigos_ES    := TStringList.Create();

    ListaDescricoes_LM := TStringList.Create();
    ListaDescricoes_ES := TStringList.Create();

end;

Function TDownloadAtualizacoes.VerificaAtualizacoes( VerificarAtualizacoesAnteriores : Boolean) : Integer;
var
  TotalLM : Integer;
  //TotalES : Integer;

begin

  ListaCodigos_LM.Clear();
  ListaDescricoes_LM.Clear();
  TotalLM := CarregaAtualizacoesProduto(Configuracoes.CodigoProduto_LM , VerificarAtualizacoesAnteriores);


  (*
  ListaCodigos_ES.Clear();
  ListaDescricoes_ES.Clear();
  TotalES := CarregaAtualizacoesProduto(Configuracoes.CodigoProduto_ES , VerificarAtualizacoesAnteriores);
  *)
  
  result := TotalLM; //+ TotalES;

end;

Function TDownloadAtualizacoes.CarregaAtualizacoesProduto ( CodigoProduto : Integer ; VerificarAtualizacoesAnteriores : Boolean) : Integer;
var
  atualizacao : TRul_atualizacao;
  Atualizacoes : String;

begin

  try
    varMensagem := '';
    Result := 0;

    atualizacao := TRul_atualizacao.Create();
    atualizacao.Conexao := varConexaoSrvAtu;
    atualizacao.produto := CodigoProduto;

    Atualizacoes := trim(varConfiguracoes.AtualizacoesInstaladas);

    if EndsText(',' , Atualizacoes) then
      Atualizacoes := Copy(Atualizacoes, 1, Length(Atualizacoes)-1);
      
    if StartsText(',' , Atualizacoes) then
      Atualizacoes := Copy(Atualizacoes, 2, Length(Atualizacoes)-1);

    Atualizacoes := ReplaceStr(Atualizacoes, ',,', ',');

    if cliente = nil then
      cliente := TRul_cliente.Create(varConexaoSrvAtu, varConfiguracoesLogin.Login , varConfiguracoesLogin.Senha);

    if cliente = nil then
      begin
        varMensagem := 'Não foi possível carregar dados do cliente';
        exit;
      end;

    if ( cliente.NovoRegistro ) then
      begin
        varMensagem := 'Usuário ou senha inválidos';
        exit;
      end;

    if CodigoProduto = Configuracoes.CodigoProduto_LM then
      begin
        if VerificarAtualizacoesAnteriores then
          rcd_LM := atualizacao.GetAll3(Configuracoes.CodigoProduto_ES , cliente.cliente ,Atualizacoes )
        else
          rcd_LM := atualizacao.GetAll(Configuracoes.CodigoProduto_ES , cliente.cliente ,Atualizacoes );

        if ( rcd_LM = nil ) then
          varMensagem := 'Não foram encontradas atualizações no banco de dados'
        else
          Result := rcd_LM.RecordCount;
      end
    else
      begin
        if VerificarAtualizacoesAnteriores then
          rcd_ES := atualizacao.GetAll3(Configuracoes.CodigoProduto_ES , cliente.cliente ,Atualizacoes )
        else
          rcd_ES := atualizacao.GetAll(Configuracoes.CodigoProduto_ES , cliente.cliente ,Atualizacoes );
        if ( rcd_ES = nil ) then
          varMensagem := 'Não foram encontradas atualizações no banco de dados'
        else
          Result := rcd_ES.RecordCount;
      end;

  except
    on ex : Exception do
      begin
        result := 0;
      end;
  end;

end;

procedure TDownloadAtualizacoes.ListaAtualizacoesProduto ( CodigoProduto : Integer ;  Lista : TListView; VerificarAtualizacoesAnteriores : Boolean) ;
var
  Rcd : PAdoDataSet;
  ListaCodigos : PStringList;
  ListaDescricoes : PStringList;

  Li : TListItem;
  CodSituacao : String;
  Situacao : String;
  Detalhes : String;
  IncluirAtualizacao : Boolean;

begin
  try
    if CodigoProduto = Configuracoes.CodigoProduto_LM then
      begin
        Rcd := @rcd_LM;
        ListaCodigos_LM.Clear();
        ListaDescricoes_LM.Clear();
        ListaCodigos := @ListaCodigos_LM;
        ListaDescricoes := @ListaDescricoes_LM;
      end
    else
      begin
        Rcd := @rcd_ES;
        ListaCodigos_ES.Clear();
        ListaDescricoes_ES.Clear();
        ListaCodigos := @ListaCodigos_ES;
        ListaDescricoes := @ListaDescricoes_ES;
      end;
    Lista.Items.Clear();

    if ( rcd = nil ) then
      begin
        VarMensagem :=  'Não foram encontradas atualizações no banco de dados';

      end
    else
      begin
        while not rcd^.Eof do
          begin
            CodSituacao := rcd^.FieldByName('situacao').AsString;

            (*********************************
            if VerificarAtualizacoesAnteriores then
              begin
                if CodSituacao = '' then
                  IncluirAtualizacao := False
                else
                  IncluirAtualizacao := True;
              end
            else
              begin
                IncluirAtualizacao := True;
              end;
            *********************************)

            IncluirAtualizacao := True;

            if IncluirAtualizacao then
              begin
                li := Lista.Items.Add();
                li.Caption := rcd^.FieldByName('nome').AsString;       // Atualizacao
                li.SubItems.Add( rcd^.FieldByName('data').AsString );  // Data

                if CodSituacao = '' then
                  begin
                    Situacao := '';
                    Detalhes := 'período de atualização expirada - clique aqui para contratar';
                    li.Checked := False;
                  end
                else
                  begin
                    //if VerificarAtualizacoesAnteriores then
                    //  Situacao := 'Instalado'
                    //else
                      Situacao := 'Disponível';
                    Detalhes := 'Clique aqui para ver os detalhes desta atualização';
                    li.Checked := True;

                  end;

                li.SubItems.Add( Situacao );  // Situacao
                li.SubItems.Add( Detalhes );  // Descricao

                ListaCodigos.Add( rcd^.FieldByName('atualizacao').AsString );
                ListaDescricoes.Add(rcd^.FieldByName('descricao').AsString);
              end;

            rcd.Next;

          end;
        rcd.Close;
      end;

    except
      on ex : exception do
        begin
        end;
    end;


end;

function TDownloadAtualizacoes.VerificaAssinaturaCliente() : String;
var
  assinatura : TRul_assinaturacliente;
  Rcd: TADODataSet;
  dtini : string;
  dtfim : string;
  DataInicio: tDate;
  DataFim: tDate;

begin

  try
  
    if cliente = nil then
      cliente := TRul_cliente.Create(varConexaoSrvAtu, varConfiguracoesLogin.Login , varConfiguracoesLogin.Senha);

    if cliente.NovoRegistro then
      begin
        result := 'Cliente não encontrado';
        exit;
      end;

    assinatura := TRul_assinaturacliente.Create();
    assinatura.Conexao := varConexaoSrvAtu;
    assinatura.cliente := cliente.cliente;
    assinatura.produto := varConfiguracoes.CodigoProduto_ES;

    rcd := assinatura.GetAll();
    if rcd = nil then
      begin
        result := 'Erro na verificação dos dados do cliente';
        exit;
      end;

    if rcd.Eof then
      begin
        result := 'Não foram encontrados dados de assinatura do cliente';
        exit;
      end;

    dtini := rcd.FieldByName('datainicio').AsString;
    if  Pos ( ' ' , dtini) >0 then
      dtini := trim(copy( Dtini, 1, Pos ( ' ' , dtini)));

    dtfim := rcd.FieldByName('datafim').AsString;
    if  Pos ( ' ' , dtfim) >0 then
      dtfim := trim(copy( dtfim, 1, Pos ( ' ' , dtfim)));


    DataInicio := StrToDate ( dtini );
    DataFim := StrToDate ( dtfim );

    if (Now  < DataInicio ) OR ( Now > DataFim) then
      begin
        Result := 'Período de assinatura já expirou';
      end
    else
      begin
        result := ''
      end;
    rcd.close();


  except
    on ex: Exception do
      begin
        result := ex.Message;
      end;
  end;





end;

Procedure TDownloadAtualizacoes.GeraTabelaAtualizacoesCliente(CodigoProduto : Integer ; var ListaAtualizacoes : TStringList);
var
  Atualizacoes : String;
  atualizacao : TRul_atualizacao;
  rcd : TAdoDataSet;
  NomeProduto : String;
  NomeAtualizacao : String;
  Linha : String;
begin
  try
    atualizacao := TRul_atualizacao.Create();
    atualizacao.Conexao := varConexaoSrvAtu;
    atualizacao.produto := CodigoProduto;

    Atualizacoes := trim(varConfiguracoes.AtualizacoesInstaladas);
    if EndsText(',' , Atualizacoes) then
      Atualizacoes := Copy(Atualizacoes, 1, Length(Atualizacoes)-1);

    if cliente = nil then
      cliente := TRul_cliente.Create(varConexaoSrvAtu, varConfiguracoesLogin.Login , varConfiguracoesLogin.Senha);

    if cliente = nil then
      begin
        varMensagem := 'Não foi possível carregar dados do cliente';
        exit;
      end;

    if ( cliente.NovoRegistro ) then
      begin
        varMensagem := 'Usuário ou senha inválidos';
        exit;
      end;

    rcd := atualizacao.GetAll2(Configuracoes.CodigoProduto_ES , cliente.cliente ,Atualizacoes );
    if ( rcd = nil ) then
      begin
        varMensagem := 'Não foram encontradas atualizações no banco de dados';
        exit;
      end;

     while not rcd.Eof do
      begin
        NomeProduto := trim(rcd.fieldbyname('NomeProduto').asString);
        NomeAtualizacao := trim(rcd.fieldbyname('NomeAtualizacao').asString);
        Linha := '<tr><td Style="border:1px solid #104480;">&nbsp;' + NomeProduto + '&nbsp;</td>';
        Linha := Linha + '<td Style="border:1px solid #104480;">&nbsp;' + NomeAtualizacao + '&nbsp;</td></tr>';

        ListaAtualizacoes.Add(Linha);
        rcd.Next;
      end;
     rcd.Close;
  except
    
  end;


end;

end.
