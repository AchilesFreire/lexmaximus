unit Atualizacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, ComCtrls,
  ControleLicenca,
  Funcoes,
  Configuracoes,
  Mensagens,
  FuncoesValidacao,
  cls_conexao,
  Rul_cliente,
  Rul_Atualizacao,
  Browser,
  BrowserLocal,
  EsqueciSenha,
  InstalacaoAtualizacao,
  //ShellZipTool,
  Conexoes,
  ConfiguracoesLogin,
  DownloadAtualizacoes,
  AtualizacoesSistema,
  rul_OcorrenciaAcepcao,
  rul_OcorrenciaLei,
  rul_textolei,
  rul_lei,
  SelecaoAtualizacaoCinza;

type
  TFrmAtualizacoes = class(TForm)
    PnlCabecalho: TPanel;
    PnlListasAtualizacoes: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    PnlAtualizacoesLegislacao: TPanel;
    PnlBotoes: TPanel;
    BtnBaixarAtualizacoesSelecionadas: TButton;
    BtnContratarAssinatura: TButton;
    BtnFechar: TButton;
    Label16: TLabel;
    lst_LM: TListView;
    BtnProcurarAtualizacoes: TButton;
    IndyHTTP: TIdHTTP;
    procedure BtnProcurarAtualizacoesClick(Sender: TObject);
    procedure lst_LMDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lst_LMCustomDrawItem(Sender: TCustomListView; Item: TListItem;      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure BtnContratarAssinaturaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnBaixarAtualizacoesSelecionadasClick(Sender: TObject);
  private
    { Private declarations }
    varControleLicenca                : TControleLicenca;
    varSerialCliente                  : string;
    varConfiguracoes                  : TConfiguracoes;
    varConfiguracoesLogin             : TConfiguracoesLogin;
    varControleAtualizacoes           : TDownloadAtualizacoes;
    varConexaoSrvAtu                  : TCls_Conexao;
    varDiretorioSistema               : String;
    varDiretorioBrowser               : String;
    varVerificarAtualizacoesAnteriores : Boolean;

    cliente                           : Trul_cliente;
    FormBrowser                       : TFrmBrowser;
    FormBrowserLocal                  : TFrmBrowserLocal;
    FormEsqueciSenha                  : TFrmEsqueciSenha;
    FormAndamento                     : TFrmInstalacaoAtualizacao;

    varAtualizarListaVerbetes         : Boolean;

    AtualizandoListas               : Boolean;


  public
    { Public declarations }
    property ControleLicenca: TControleLicenca read varControleLicenca write varControleLicenca;
    property SerialCliente: string read varSerialCliente write varSerialCliente;
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;
    property ConfiguracoesLogin: TConfiguracoesLogin read varConfiguracoesLogin write varConfiguracoesLogin;

    property ControleAtualizacoes: TDownloadAtualizacoes read varControleAtualizacoes write varControleAtualizacoes;

    property ConexaoSrvAtu: TCls_Conexao read varConexaoSrvAtu write varConexaoSrvAtu;

    property DiretorioSistema: string read varDiretorioSistema write varDiretorioSistema;
    property DiretorioBrowser: string read varDiretorioBrowser write varDiretorioBrowser;

    property AtualizarListaVerbetes: Boolean read varAtualizarListaVerbetes write varAtualizarListaVerbetes;

    property VerificarAtualizacoesAnteriores: Boolean read varVerificarAtualizacoesAnteriores write varVerificarAtualizacoesAnteriores;
    
    procedure ContrataAssinatura();
    procedure BaixaAtualizacoesSelecionadas();
    Function BaixaAtualizacoes(CodigoProduto : Integer; Lista : TListView; MensagemAdvertencia: String) : String;

    Function VerificaAtualizacoes() : Integer;
    Function CarregaListaAtualizacoes (Lista : TListView ; CodigoProduto : Integer ;  ListaCodigos : TStringList ;  ListaDescricoes : TStringList) : Integer;

    procedure EsqueciSenha ();

    Function ProcessaAtualizacao(atualizacao : integer) : Boolean;
    Function ImplantaAtualizacao(CodigoProduto : Integer ; Diretorio : String) : Boolean;
    Function ExecutaScript (CodigoProduto : Integer ; Arquivo : String) : Boolean;
    Function IncluiOcorrenciasVerbete (Diretorio: String ; Arquivo : String) : Boolean;
    Function IncluiOcorrenciasLei (Diretorio: String ; Arquivo : String) : Boolean;
    Function IncluiTextoLei (Diretorio: String ; Arquivo : String) : Boolean;

    Function ExcluiLei (Diretorio: String ; Arquivo : String) : Boolean;

    procedure ExibeDetalhesAtualizacao(Produto : Integer ; Atualizacao : Integer);

    procedure ListaAtualizacoesDisponiveis();


  end;

var
  FrmAtualizacoes: TFrmAtualizacoes;

implementation

{$R *.dfm}


{$REGION 'Eventos do formulario'}

procedure TFrmAtualizacoes.FormCreate(Sender: TObject);
begin
  varAtualizarListaVerbetes := false;

  AtualizandoListas := false;
end;

{$ENDREGION}

{$REGION 'Outros eventos'}

procedure TFrmAtualizacoes.BtnContratarAssinaturaClick(Sender: TObject);
begin
  ContrataAssinatura();
end;

procedure TFrmAtualizacoes.BtnBaixarAtualizacoesSelecionadasClick(Sender: TObject);
begin
  BaixaAtualizacoesSelecionadas();
end;

procedure TFrmAtualizacoes.BtnFecharClick(Sender: TObject);
begin
  self.Close();
end;

procedure TFrmAtualizacoes.lst_LMCustomDrawItem(Sender: TCustomListView;  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin

  if AtualizandoListas then
    exit;
    
  if (Item.Index mod 2) = 0 then
    lst_LM.Canvas.Brush.Color := $E0E0E0
  else
    lst_LM.Canvas.Brush.Color := clWhite;

  if item.SubItems.Count =0 then
    exit;

  if item.SubItems[1] = 'Disponível' then
    lst_LM.Canvas.Font.Color:= clBlue
  else
    begin
      if item.SubItems[1] = 'Instalado' then
        lst_LM.Canvas.Font.Color:= clGreen
      else
        lst_LM.Canvas.Font.Color:= clGrayText;
    end;

end;

procedure TFrmAtualizacoes.lst_LMDblClick(Sender: TObject);
begin
  try

    if lst_LM.Selected <> nil then
      begin
        if (lst_LM.Selected.SubItems[1] = 'Disponível') or (lst_LM.Selected.SubItems[1] = 'Instalado') then
          ExibeDetalhesAtualizacao( varConfiguracoes.CodigoProduto_LM , lst_LM.Selected.Index)
        else
          ContrataAssinatura();
      end;

  except

  end;
end;

procedure TFrmAtualizacoes.BtnProcurarAtualizacoesClick(Sender: TObject);
begin
   VerificaAtualizacoes();
end;

{$ENDREGION}

{$REGION 'Metodos para instalacao das atualizacoes'}

procedure TFrmAtualizacoes.ListaAtualizacoesDisponiveis();
begin

  AtualizandoListas := true;
  lst_LM.Items.Clear();
  varControleAtualizacoes.ListaAtualizacoesProduto( varConfiguracoes.CodigoProduto_LM , lst_LM  , VerificarAtualizacoesAnteriores );
  Application.ProcessMessages;

  AtualizandoListas := false;
  Application.ProcessMessages;
  lst_LM.Repaint;

end;

Function TFrmAtualizacoes.VerificaAtualizacoes() : Integer;
var
  TotalLM : Integer;
  //TotalES : Integer;
  MensagemLM : String;
  //MensagemES : String;
begin
  try

    Screen.cursor := crHourGlass;
    TotalLM := varControleAtualizacoes.CarregaAtualizacoesProduto(varConfiguracoes.CodigoProduto_LM, varVerificarAtualizacoesAnteriores );
    MensagemLM := varControleAtualizacoes.mensagem;
    Screen.cursor := crDefault;

    (*
    Screen.cursor := crHourGlass;
    TotalES := varControleAtualizacoes.CarregaAtualizacoesProduto(varConfiguracoes.CodigoProduto_ES, varVerificarAtualizacoesAnteriores );
    MensagemES := varControleAtualizacoes.mensagem;
    Screen.cursor := crDefault;
    *)
    result := TotalLM; // + TotalES;

    lst_LM.Items.Clear();

    if result <= 0 then
      begin
        Screen.cursor := crDefault;
        Mensagem (self, 'Não foram encontradas atualizações', 'Atualizações do LexMaximus', configuracoes);
      end
    else
      ListaAtualizacoesDisponiveis();

  except
    on ex : exception do
      begin
        Screen.cursor := crDefault;
        Mensagem (self, ex.Message, 'Atualizações do LexMaximus', configuracoes);
      end;

  end;

end;

Function TFrmAtualizacoes.CarregaListaAtualizacoes ( Lista : TListView ; CodigoProduto : Integer ;  ListaCodigos : TStringList ;  ListaDescricoes : TStringList) : Integer;
var
  atualizacao : TRul_atualizacao;
  rcd : TAdoDataSet;
  Li : TListItem;
  CodSituacao : String;
  Situacao : String;
  Detalhes : String;
  Atualizacoes : String;
  TotalDisponivel : Integer;

begin

  try

    TotalDisponivel := 0;
    //Carregando as atualizacoes do lexmaximus
    atualizacao := TRul_atualizacao.Create();
    atualizacao.Conexao := varConexaoSrvAtu;
    atualizacao.produto := CodigoProduto;

    Atualizacoes := trim(varConfiguracoes.AtualizacoesInstaladas);

    if EndsText(',' , Atualizacoes) then
      Atualizacoes := Copy(Atualizacoes, 1, Length(Atualizacoes)-1);

    if cliente = nil then
      cliente := TRul_cliente.Create(varConexaoSrvAtu, varConfiguracoesLogin.Login , varConfiguracoesLogin.Senha);

    ListaDescricoes.Clear();
    //
    // a consulta procura clientes da enciclopedia Soibelman ( primeiro parametro )
    // que tenham atualizacoes liberadas para os dois produtos: ( enciclopedia e legislacao )
    //
    Rcd := atualizacao.GetAll(Configuracoes.CodigoProduto_ES , cliente.cliente ,Atualizacoes );
    if ( rcd = nil ) then
      begin
        Mensagem (self, 'Não foram encontradas atualizações no banco de dados', 'Atualizações do LexMaximus', configuracoes);
      end
    else
      begin
        while not rcd.Eof do
          begin
            li := Lista.Items.Add();
            li.Caption := rcd.FieldByName('nome').AsString;       // Atualizacao
            

            li.SubItems.Add( rcd.FieldByName('data').AsString );  // Data

            CodSituacao := rcd.FieldByName('situacao').AsString;

            if CodSituacao = '' then
              begin
                Situacao := '';
                Detalhes := 'período de atualização expirada - clique aqui para contratar';
                li.Checked := False;
              end
            else
              begin
                Situacao := 'Disponível';
                Detalhes := 'Clique aqui para ver os detalhes desta atualização';
                li.Checked := True;
                Inc(TotalDisponivel);
              end;

            li.SubItems.Add( Situacao );  // Situacao
            li.SubItems.Add( Detalhes );  // Descricao

            ListaCodigos.Add( rcd.FieldByName('atualizacao').AsString );

            ListaDescricoes.Add(rcd.FieldByName('descricao').AsString);

            rcd.Next;

          end;
        rcd.Close;
      end;

    result := TotalDisponivel;

  except
    on ex : Exception do
      begin
        result := 0;
      end;
  end;

end;

procedure TFrmAtualizacoes.BaixaAtualizacoesSelecionadas();
var
  ListaAtualizacoes : String;
  i : Integer;
  q : integer;
  Li : TListItem;
  Total : Integer;
  TotalErros : Integer;

  MensagemAdvertencia : String;

  FormAtualizacaoCinza : TFrmSelecaoAtualizacaoCinza;

begin
  try
    TotalErros := 0;
    Total := 0;

    // Verificando se tem atualizacoes disponíveis, selecionadas

    Q := lst_LM.Items.Count-1;
    for i:= 0 to q do
      begin
        Li := lst_LM.items[i];
        if (li.Checked) then
          begin
            if li.SubItems[1] = 'Disponível' then
              Inc(Total)
            else
              Inc(TotalErros);
          end;
      end;

    (***************************
    if TotalErros <> 0 then
      begin
        Mensagem(self, 'O período de atualização expirou' , 'Atualizações', varConfiguracoes);
        exit;
      end;

    Total := 0;
    TotalErros := 0;
    ***************************)

    MensagemAdvertencia := '';
    if ( Total =0) then
      begin
        if TotalErros = 0 then
          begin
            Mensagem( self, 'Voce precisa selecionar as atualizações disponíveis que deseja instalar' , self.Caption, varConfiguracoes);
            exit;
          end
        else
          begin
            FormAtualizacaoCinza := TFrmSelecaoAtualizacaoCinza.Create(Self);
            FormAtualizacaoCinza.ShowModal();
            exit;
          end;
      end
    else
      begin
        if TotalErros = 0 then
          begin
            MensagemAdvertencia := 'Baixando atualizações disponíveis';
          end
        else
          begin
            MensagemAdvertencia := 'Baixando atualizações em azul; aquelas em cinza não serão baixadas por serem posteriores ao período período contratado, devendo, para poder baixá-las, clicar em "contratar assinatura'
          end;
      end;

    if FormAndamento = nil then
      FormAndamento := TFrmInstalacaoAtualizacao.Create(Self);

    FormAndamento.ParentWindow := self.Handle;
    FormAndamento.Show();

    ListaAtualizacoes :=  varConfiguracoes.AtualizacoesInstaladas;

    // Baixando as atualizacoes do lexmaximus
    ListaAtualizacoes := ListaAtualizacoes + BaixaAtualizacoes(varConfiguracoes.CodigoProduto_LM  , lst_LM, MensagemAdvertencia);

    ListaAtualizacoes := trim(ListaAtualizacoes);

    if ListaAtualizacoes <> '' then
      begin

        if EndsText(',' , ListaAtualizacoes) then
          ListaAtualizacoes := Copy(ListaAtualizacoes ,1 , length(ListaAtualizacoes)-1);


        ListaAtualizacoes := ReplaceStr(ListaAtualizacoes, ',,', ',');

        varConfiguracoes.AtualizacoesInstaladas := trim(ListaAtualizacoes);

        varConfiguracoes.SalvaConfiguracoes();
      end;

    FormAndamento.Close();

    Mensagem ( Self, 'Atualizações instaladas', self.Caption, varConfiguracoes);

    VerificaAtualizacoes();

  except
    on ex : exception do
      begin
        mensagem(self, ex.Message , self.caption, varConfiguracoes);
      end;
  end;

end;

Function TFrmAtualizacoes.BaixaAtualizacoes( CodigoProduto : Integer; Lista : TListView; MensagemAdvertencia: String) : String;
var
  i : Integer;
  q : integer;
  Li : TListItem;
  atualizacao : Integer;
  ListaAtualizacoes : String;

begin
  try

    ListaAtualizacoes := '';
    q := Lista.Items.Count-1;
    for i:= 0 to q do
      begin
        Li := Lista.items[i];
        if li.Checked then
          begin
            if li.SubItems[1] = 'Disponível' then
              begin

                if CodigoProduto = varConfiguracoes.CodigoProduto_LM then
                  atualizacao := StrToInt( varControleAtualizacoes.ListaCodigos_LM [i] )
                else
                  atualizacao := StrToInt( varControleAtualizacoes.ListaCodigos_ES [i] );

                FormAndamento.lblAdvertencia.Caption := MensagemAdvertencia;
                FormAndamento.Lbl_NomePacote.Caption := li.caption;

                if ProcessaAtualizacao(atualizacao) then
                  begin
                    ListaAtualizacoes := ListaAtualizacoes + ',' + IntToStr(atualizacao) + ',';

                    if CodigoProduto = varConfiguracoes.CodigoProduto_ES then
                      begin
                        varAtualizarListaVerbetes := True;
                      end;
                  end;

              end;
          end;
      end;
      Result := ListaAtualizacoes;

  except
    on ex : exception do
      begin
        mensagem(self, ex.Message , self.caption, varConfiguracoes);
        Result := '';
      end;
  end;
end;

Function TFrmAtualizacoes.ProcessaAtualizacao(atualizacao : integer) : Boolean;
var
  atu : TRul_atualizacao;
  Arquivo : String;
  DiretorioBaseAtu : String;
  DiretorioArquivoZip : String;
  CaminhoArquivo : String;
  DiretorioScripts : String;
  diretorioAtu : String;
  LinkAtu : String;
  stream : TFileStream;
  DownloadOK : Boolean;
  CodigoProduto : Integer;
  //http :  TAtualizacoesSistema;
  DiretorioOK : Boolean;
  IndDir : Integer;

begin
  try

    FormAndamento.LblAndamento.Caption := 'Buscando os detalhes da atualização';
    Application.ProcessMessages;

    atu := TRul_atualizacao.Create(varConexaoSrvAtu, atualizacao);

    if atu.Mensagem <> '' then
      begin
        mensagem(self, 'Não foi possivel obter detalhes da atualização' + chr(13) + chr(10) + atu.Mensagem , self.caption, varConfiguracoes);
        result := false;
        exit;
      end;

    CodigoProduto := atu.produto;
    LinkAtu := trim(atu.diretoriodownload);

    LinkAtu := ReplaceStr(LinkAtu , '\' , '/');

    FormAndamento.LblAndamento.Caption := 'Configurando diretórios';
    Application.ProcessMessages;

    Arquivo := trim(atu.diretoriodownload);

    Arquivo := trim(Copy( Arquivo , LastDelimiter('/', Arquivo)+1)) ;

    diretorioAtu  := trim(Copy( Arquivo ,1, LastDelimiter('.', Arquivo)-1)) ;

    DiretorioBaseAtu := GetEnvironmentVariable('temp') + '\ATU_ES';
    if not DirectoryExists(DiretorioBaseAtu ) then
      MkDir( DiretorioBaseAtu);

    DiretorioOK := False;
    IndDir := 0;

    While not DiretorioOK do
      begin
        DiretorioArquivoZip := DiretorioBaseAtu + '\' + diretorioAtu;
        if ( IndDir <> 0) then
          DiretorioArquivoZip := DiretorioArquivoZip + '_' + IntToStr(IndDir);

        if not DirectoryExists(DiretorioArquivoZip ) then
          begin
            MkDir( DiretorioArquivoZip);
            DiretorioOK := True;
          end;

        Inc(IndDir);

      end;

    DiretorioScripts := DiretorioArquivoZip + '\Unzip';
    if not DirectoryExists(DiretorioScripts ) then
      MkDir( DiretorioScripts);

    CaminhoArquivo := DiretorioArquivoZip + '\' + Arquivo;
    if FileExists(CaminhoArquivo) then
      DeleteFile(CaminhoArquivo);

    FormAndamento.LblAndamento.Caption := 'Fazendo download da atualização';
    Application.ProcessMessages;

    self.Cursor := crHourGlass;
    //http :=  TAtualizacoesSistema.Create(self);
    stream := TFileStream.Create(CaminhoArquivo , fmCreate);
    try

      IndyHTTP.Get(LinkAtu, stream);

      stream.Free();

      DownloadOK := True;

    except
      DownloadOK := False;
    end;
    self.Cursor := crDefault;

    if (not DownloadOK) or (not FileExists(CaminhoArquivo)) then
      begin
        mensagem(self, 'Não foi possivel fazer o download da atualização' , self.caption, varConfiguracoes);
        result := false;
        exit;
      end;

    FormAndamento.LblAndamento.Caption := 'Descomprimindo arquivos da atualização';
    Application.ProcessMessages;

    DescomprimePasta( Self.Handle , DiretorioScripts  , CaminhoArquivo);

    FormAndamento.LblAndamento.Caption := 'Atualizando o banco de dados';
    Application.ProcessMessages;

    result := ImplantaAtualizacao(CodigoProduto , DiretorioScripts);

    FormAndamento.LblAndamento.Caption := 'Concluido';
    Application.ProcessMessages;

  except
    on ex : exception do
      begin
        mensagem(self, ex.Message , self.caption, varConfiguracoes);
        result := false;
      end;
  end;

end;

Function TFrmAtualizacoes.ImplantaAtualizacao(CodigoProduto : Integer ; Diretorio : String) : Boolean;
var
  MySearch : TSearchRec;
  arquivo : String;
  extensao : String;
  Retorno : Boolean;
  //Origem : String;
  //Destino : String;

  //ListaTxt : TStringList;
  //ListaSQL : TStringList;

begin

  try
    FindFirst(Diretorio + '\*.*' , faAnyFile, MySearch);
    Retorno := True;
    repeat
      arquivo := uppercase(MySearch.Name);

      if (Arquivo <> '.') and ( arquivo <> '..') then
        begin
          extensao := ExtractFileExt(arquivo);

          if (extensao = '.SQL') then
            begin
              FormAndamento.LblAndamento.Caption := 'Executando script: ' + Arquivo;
              Application.ProcessMessages;

              if not ExecutaScript (CodigoProduto , Diretorio + '\' + arquivo) then
                Retorno := false;

            end
          else
            begin
              if arquivo = 'LISTATEXTOLEI.TXT' then
                begin
                  if not IncluiTextoLei ( Diretorio , arquivo) then
                    Retorno := false;
                end;

              if arquivo = 'LISTAOCORRENCIAS.TXT' then
                begin
                  FormAndamento.LblAndamento.Caption := 'Incluindo ocorrências';
                  Application.ProcessMessages;
                  if CodigoProduto = varConfiguracoes.CodigoProduto_ES then
                    begin
                      if not IncluiOcorrenciasVerbete ( Diretorio , arquivo) then
                        Retorno := false;
                    end
                  else
                    begin
                      if not IncluiOcorrenciasLei ( Diretorio , arquivo) then
                        Retorno := false;
                    end;
                end;
              if  AnsiEndsText ('LISTAEXCLUSAOLEI.TXT', arquivo ) then
                begin
                  if not ExcluiLei ( Diretorio , arquivo) then
                    Retorno := false;
                end;

            end;
        end;

    until FindNext(MySearch) <> 0;

    result := retorno;

  except
    result := false;
  end;

end;

Function TFrmAtualizacoes.ExecutaScript (CodigoProduto : Integer ; Arquivo : String) : Boolean;
var
  I : Integer;
  Q : Integer;
  Query : String;
  Conteudo : TStringList;
  ArquivoErros: String;
  ListaErros : TStringList;

begin
  try
    Conteudo := TStringList.Create();
    Conteudo.LoadFromFile(Arquivo);

    if (Conteudo.Count =0) then
      begin
        result := true;
        exit;
      end;

    Q := Conteudo.Count-1;

    FormAndamento.Progresso.Min := 0;
    FormAndamento.Progresso.Max := Q;
    FormAndamento.Progresso.Position := FormAndamento.Progresso.Min;
    Application.ProcessMessages;


    ArquivoErros := GetCurrentDir() + '\Erros-Prod-' + IntToStr(CodigoProduto) +  '-' + FormatDateTime('yyyy-mm-dd hh-mm-ss',now) +  '-'+  ExtractFileName(Arquivo);
    ListaErros := TStringList.Create();

    for I :=0  to Q do
      begin
        if Conteudo[I] = 'GO'  then
          begin
            //Executando o comando
            try
              if trim(Query) <> '' then
                DMConexoes.Conexao.ExecuteDirect( Query );

            except
              on ex : Exception do
                begin

                  //Mensagem(self, ex.Message, 'Instalando atualizações', varConfiguracoes);

                  //ListaErros.Add(ex.Message + ':');
                  //ListaErros.Add('        ' + Query)
                end;
            end;
            Query := '';
          end
        else
          begin
            Query := Query + Conteudo[i];
          end;
        FormAndamento.Progresso.Position := I;

        Application.ProcessMessages;

      end;

      if ListaErros.Count >0 then
        ListaErros.SaveToFile(ArquivoErros);

      FormAndamento.Progresso.Position := FormAndamento.Progresso.Max;
      Application.ProcessMessages;
      FreeAndNil(Conteudo);

      result := true;

  except
    result := false;
    
  end;
end;

Function TFrmAtualizacoes.IncluiOcorrenciasVerbete (Diretorio: String ; Arquivo : String) : Boolean;
var
  Lista : TStringList;
  Ocr : TStringList;
  I : Integer;
  Q : Integer;
  ocorrencia : Trul_OcorrenciaAcepcao;
  Linha : String;
  Temp : String;
  acepcao : Integer;
  ArqOcorrencias : String;

begin
  try

  Lista := TStringList.Create;
  Ocr := TStringList.Create;

  Lista.LoadFromFile(Diretorio + '\' + Arquivo);
  Q := Lista.count-1;
  ocorrencia := Trul_OcorrenciaAcepcao.Create();

  for i :=0 to Q do
    begin
      Linha := Lista[i];
      Temp := Copy(Linha,1, Pos(';',Linha)-1 );
      Acepcao := StrToInt ( temp ) ;

      Temp := Copy(Linha, Pos(';',Linha)+1  );
      ArqOcorrencias := Temp;

      ocorrencia.Acepcao := Acepcao;

      ocorrencia.ValidateDelete();

      Ocr.LoadFromFile( Diretorio + '\' + ArqOcorrencias);

      ocorrencia.Palavras := Ocr.Text;

      ocorrencia.ValidateInsert();

    end;
    Result := True;
  except
    on ex : Exception do
      begin
        MessageBox(self.Handle , PAnsichar('Ocorreu um erro no processamento das atualizações (IncluiOcorrenciasVerbete) :' + chr(13) +chr(10) + ex.message) , PAnsichar(Self.Caption) , MB_OK );
        Result := False;
      end;
  end;


end;

Function TFrmAtualizacoes.IncluiOcorrenciasLei (Diretorio: String ; Arquivo : String) : Boolean;
var
  Lista : TStringList;
  I : Integer;
  Q : Integer;
  ocorrencia : Trul_OcorrenciaLei;
  Linha : String;
  P : Integer;
  Temp : String;
  Lei : Integer;
  ArqEmenta : String;
  ArqTexto : String;

begin
  try

  Lista := TStringList.Create;
  Lista.LoadFromFile(Diretorio + '\' + Arquivo);
  
  Q := Lista.count-1;
  ocorrencia := Trul_OcorrenciaLei.Create();

  for i :=0 to Q do
    begin
      Linha := Lista[i];

      Temp := Linha;
      P := Pos(';',Temp);

      //Lei
      Lei := StrToInt ( Copy(Temp,1, P-1 ) ) ;

      // Ocorrencias Ementa
      Temp := Copy(Temp,P+1);
      P := Pos(';',Temp);
      ArqEmenta := Copy(Temp,1, P-1 );

      // Ocorrencias Texto
      Temp := Copy(Temp,P+1);
      //P := Pos(';',Temp);
      ArqTexto := Temp;

      ocorrencia.Lei := Lei;

      ocorrencia.ValidateDelete();

      ocorrencia.ValidateInsert( Diretorio + '\' + ArqEmenta , Diretorio + '\' + ArqTexto );


    end;
    Result := True;
  except
    on ex : Exception do
      begin
        MessageBox(self.Handle , PAnsichar('Ocorreu um erro no processamento das atualizações (IncluiOcorrenciasLei) :' + chr(13) +chr(10) + ex.message) , PAnsichar(Self.Caption) , MB_OK );
        Result := False;
      end;
  end;

end;

Function TFrmAtualizacoes.IncluiTextoLei (Diretorio: String ; Arquivo : String) : Boolean;
var
  Lista : TStringList;
  I : Integer;
  Q : Integer;
  textolei : TRul_TextoLei;
  Linha : String;
  Lei : Integer;
  Temp : String;
  //acepcao : Integer;
  ArqTextoLei : String;
  Mensagens : String;

begin



  try

  Lista := TStringList.Create;

  Lista.LoadFromFile(Diretorio + '\' + Arquivo);
  Q := Lista.count-1;
  textolei := TRul_TextoLei.Create();
  Mensagens:= '';

  for i :=0 to Q do
    begin
      Linha := Lista[i];
      Temp := Copy(Linha,1, Pos(';',Linha)-1 );
      Lei := StrToInt ( temp ) ;

      Temp := Copy(Linha, Pos(';',Linha)+1  );
      ArqTextoLei := Temp;

      if FileExists(Diretorio + '\' + ArqTextoLei) then
        begin
          textolei.Lei := lei;
          textolei.ArquivoComprimido := Diretorio + '\' + ArqTextoLei;

          textolei.ValidateDelete();

          textolei.ValidateInsert();
        end
      else
        begin
          Mensagens := Mensagens + 'Arquivo nao encontrado :' + ArqTextoLei;
        end;

    end;
    Result := True;
  except
    on ex : Exception do
      begin
        MessageBox(self.Handle , PAnsichar('Ocorreu um erro no processamento das atualizações (IncluiOcorrenciasLei) :' + chr(13) +chr(10) + ex.message) , PAnsichar(Self.Caption) , MB_OK );
        Result := False;
      end;
  end;

end;

Function TFrmAtualizacoes.ExcluiLei (Diretorio: String ; Arquivo : String) : Boolean;
var
  Lista : TStringList;
  I : Integer;
  Q : Integer;
  Lei : Trul_Lei;
  CodigoLei : Integer;

begin
  try

  Lista := TStringList.Create;
  Lista.LoadFromFile(Diretorio + '\' + Arquivo);

  Q := Lista.count-1;
  Lei := Trul_Lei.Create();

  for i :=0 to Q do
    begin

      CodigoLei := StrToInt ( Lista[i] ) ;

      Lei.Lei := CodigoLei;

      Lei.ValidateDelete();

    end;

    FreeAndNil(Lista);

    Result := True;

  except
    on ex : Exception do
      begin
        MessageBox(self.Handle , PAnsichar('Ocorreu um erro no processamento das atualizações (ExcluiLei) :' + chr(13) +chr(10) + ex.message) , PAnsichar(Self.Caption) , MB_OK );
        Result := False;
      end;
  end;
end;



procedure TFrmAtualizacoes.ExibeDetalhesAtualizacao(Produto : Integer ; Atualizacao : Integer);

var
  NomeArquivo : String;
  Descricao : String;
  ConteudoArquivo : TStringList;
begin

  try
    if FormBrowserLocal = nil then
      FormBrowserLocal := TFrmBrowserLocal.Create(self);

    ConteudoArquivo := TStringList.Create;
    ConteudoArquivo.Add('<html>');
    ConteudoArquivo.Add('<head>');
    ConteudoArquivo.Add('</head>');
    ConteudoArquivo.Add('<body style="background-image:url(''verge.gif'');background-repeat:repeat; margin-left:20px; margin-right:20px">    ');
    ConteudoArquivo.Add('<font face = ''Verdana'' size = ''2px'' color = ''#000000''>');

    if produto = varConfiguracoes.CodigoProduto_LM then
      begin
        Descricao := 'Atualizacação da Legislação';
        ConteudoArquivo.Add( varControleAtualizacoes.ListaDescricoes_LM[Atualizacao]  );
      end
    else
      begin
        Descricao := 'Atualizacação da Enciclopédia';
        ConteudoArquivo.Add( varControleAtualizacoes.ListaDescricoes_ES[Atualizacao] );
      end;
    ConteudoArquivo.Add('</font>');
    ConteudoArquivo.Add('</body');
    ConteudoArquivo.Add('</html>');

    NomeArquivo := varDiretorioBrowser + '\tempdesc.html';

    ConteudoArquivo.SaveToFile(NomeArquivo);


    FormBrowserLocal.NavegaSite( NomeArquivo, Descricao );

    FormBrowserLocal.ShowModal();

  except
    on ex : Exception do
      begin
        Mensagem(Self, ex.Message , self.Caption, varConfiguracoes); 
      end;
  end;

end;

{$ENDREGION}

{$REGION 'Metodos Diversos'}

procedure TFrmAtualizacoes.EsqueciSenha ();
begin

  try
  if FormEsqueciSenha = nil then
    FormEsqueciSenha := TFrmEsqueciSenha.Create(self);

  FormEsqueciSenha.Configuracoes := varConfiguracoes;
  FormEsqueciSenha.ShowModal();
  except
    on ex : Exception do
      begin
        Mensagem( self, 'Erro: ' + ex.Message , self.caption , varConfiguracoes);
      end;
  end;

end;

procedure TFrmAtualizacoes.ContrataAssinatura();
var
  I : Integer;
  Resposta : String;
begin

  try
    //Baixando o arquivo que contem o link
    For i := 0 to 3 do
      begin
        try
          Resposta := IndyHTTP.Get('http://www.elfez.com.br/AtualizacoesProdutos/Link_ES.txt');
        except
          Resposta := '';
        end;
        if Resposta <> '' then
          break;
      end;
    if Resposta = '' then
      begin
        mensagem(self, 'Não foi possível conectar ao servidor' , self.caption, varConfiguracoes);
      end
    else
      begin

        if FormBrowser = nil then
          FormBrowser := TFrmBrowser.Create(self);

        FormBrowser.NavegaSite(Resposta , 'Contratação de assinatura');

        FormBrowser.ShowModal();

      end;

  except
    on ex : exception do
      begin
        mensagem(self, ex.Message , self.caption, varConfiguracoes);
      end;
  end;
end;

{$ENDREGION}


end.

