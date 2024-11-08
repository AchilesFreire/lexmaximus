unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, WinSkinData, ImgList, StdCtrls, GIFImage,
  VirtualTrees, FlatScrollBar, Htmlview, StrUtils, commctrl, MSHTML, ShellAPI, ClipBrd,
  Urlmon, VTHeaderPopup, Readhtml, FramView, FramBrwz, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, AppEvnts, jpeg,
  DBXpress, DB, SqlExpr,
  Buttons, CompressaoDados, Menus,
  cls_Conexao,
  Configuracoes,
  Splash,
  ControleLicenca,
  Funcoes,
  Ativacao,
  AjusteExecucaoCD,
  Message,
  Administrador,
  AtualizacoesSistema, OleCtrls, SHDocVw,
  AndamentoPesquisa,
  Rul_TipoLei,
  Rul_NotaLei,
  Rul_Lei,
  Rul_TextoLei,
  Rul_PalavraLexMaximus,
  EdicaoNota,
  AlteracaoDocumento,
  LicencaUso,
  EditorConfiguracoes,
  FuncoesClipBoard,
  MensagemErroBancoDados,
  VerificacaoAtualizacoes,
  DownloadAtualizacoes,
  AssinaturaExpirou,
  Atualizacoes,
  ConfiguracoesLogin

  ;

type

{$REGION 'Tipos de Dados'}

  TWinVersion =
  (
    wvUnknown,
    wvWin95,
    wvWin98,
    wvWin98SE,
    wvWinNT,
    wvWinME,
    wvWin2000,
    wvWinXP,
    wvWinVista
  ) ;

  TipoVisualizacao =
  (
    TV_Browser = 2,
    TV_Ambos = 3
  ) ;

  TipoConteudo =
  (
    TC_Indice = 1,
    TC_Historico = 2,
    TC_Notas = 3
  );
  
  TipoPesquisa =
  (
    TP_Nenmhum = 0,
    TP_Numero = 1,
    TP_E = 2,
    TP_OU = 3,
    TP_Frase=4
  ) ;

  FormaPesquisa =
  (
    FP_Nenhuma = 0,
    FP_ListaLeis = 1,
    FP_TextoLei = 2
  ) ;
  TipoImagemVoltarIndice =
    (
      TI_Nenhum = 0,
      TI_Branco = 1,
      TI_Vermelho = 2
    );

  TipoOrigemBanner =
  (
    TO_Nenhuma = 0,
    TO_Internet = 1,
    TO_Local = 2
  );

  TipoNode =
  (
    TN_NodeVazio        = 0,
    TN_TipoLei          = 1,
    TN_Ano              = 2,
    TN_DocumentoHTML    = 3,
    TN_Pasta            = 4,
    TN_Documento        = 5
  ) ;
  PTreeData = ^TTreeData;

  TTreeData = record
    Texto  : String;
    Codigo     : Integer;
    Tipo     : TipoNode;

    Expandir    : Boolean;
    Hint        : String;
    Publicacao  : String;
    TipoLei     : Integer;

    SubItensCarregados : Boolean;
  end;
{$ENDREGION}

{$REGION 'Definição do Formulário'}

  TFrmPrincipal = class(TForm)
    Iml_ToolBar_Normal: TImageList;
    SkinData1: TSkinData;
    ImlChekImages: TImageList;
    PnlSuperior: TPanel;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    BtnHistorico: TToolButton;
    BtnNotas: TToolButton;
    BtnImprimir: TToolButton;
    BtnCopiar: TToolButton;
    PnlEsquerda: TPanel;
    Image7: TImage;
    Image9: TImage;
    PnlDireita: TPanel;
    ImgDireitaTopo: TImage;
    ImgEsquerdaTopo: TImage;
    ImgEsquerdaMeio: TImage;
    ImgEsquerdaLinhaFundo: TImage;
    ImgEsquerdaLinhaSuperior: TImage;
    Chk_Numero: TImage;
    Chk_Busca_E: TImage;
    Image2: TImage;
    Chk_Busca_OU: TImage;
    Chk_Busca_Frase: TImage;
    Chk_Selecionar_Tudo: TImage;
    TxtPesquisa: TEdit;
    LblNumero: TLabel;
    Lbl_E: TLabel;
    Lbl_OU: TLabel;
    Lbl_Frase: TLabel;
    Lbl_SelecionarTudo: TLabel;
    Img_CheckBox_Marcado: TImage;
    Img_CheckBox_Desmarcado: TImage;
    ImgBordaInferiorDireita: TImage;
    PopUpBrowser: TPopupMenu;
    Itm_Browser_SelecionarTudo: TMenuItem;
    Itm_Browser_Copiar: TMenuItem;
    Itm_Browser_Imprimir: TMenuItem;
    ScrIndice: TFlatScrollBar;
    BtnVoltarHistorico: TSpeedButton;
    BtnAvancarHistorico: TSpeedButton;
    PnlBordaLateralDireita: TPanel;
    ImgBordaLateralDireita: TImage;
    Image1: TImage;
    ScrBrowser: TFlatScrollBar;
    Image3: TImage;
    Lbl_IncluirAlterarNota: TLabel;
    Lbl_ExcluirNota: TLabel;
    ScrLista: TFlatScrollBar;
    Chk_Expandir_Tudo: TImage;
    Lbl_ExpandirTudo: TLabel;
    Lbl_NomeLei: TLabel;
    Label2: TLabel;
    trv: TVirtualStringTree;
    ImgEsquerdaFundo: TImage;
    PnlHint: TPanel;
    LblHint: TLabel;
    Trv2: TVirtualStringTree;
    BtnIndice: TToolButton;
    PopUpIndice: TPopupMenu;
    N1: TMenuItem;
    Itm_Indice_Visualizar: TMenuItem;
    Itm_Indice_Alterar: TMenuItem;
    Itm_Indice_RemoverAutomaticamente1: TMenuItem;
    AjustarMargemeformatar1: TMenuItem;
    LblPublicacao: TLabel;
    N2: TMenuItem;
    Itm_Browser_Alterar: TMenuItem;
    Itm_Browser_Formatar_Automaticamente: TMenuItem;
    PopUpLista: TPopupMenu;
    Itm_Lista_Visualizar: TMenuItem;
    MenuItem2: TMenuItem;
    Itm_Lista_Alterar: TMenuItem;
    Itm_Lista_Formatar: TMenuItem;
    Itm_Lista_Ajustar_Margem: TMenuItem;
    MainMenu1: TMainMenu;
    MnuLexMaximus: TMenuItem;
    ItmSobre: TMenuItem;
    ItmLicensaUso: TMenuItem;
    ItmPaginaInicial: TMenuItem;
    MnuConfiguracoes: TMenuItem;
    MnuEditar: TMenuItem;
    ItmSelecionarTudo: TMenuItem;
    ItmCopiar: TMenuItem;
    ItmImprimir: TMenuItem;
    N3: TMenuItem;
    ItmVoltarHistorico: TMenuItem;
    ItmAvancarHistorico: TMenuItem;
    MnuAjuda: TMenuItem;
    ItmIndice: TMenuItem;
    ItmEditarconfiguracoes: TMenuItem;
    BtnBuscar: TSpeedButton;
    N4: TMenuItem;
    ItmExibirIndice: TMenuItem;
    ItmExibirNotas: TMenuItem;
    BtnVoltarIndice: TSpeedButton;
    PnlBrowserListaPesquisa: TPanel;
    PnlDireitaSuperior: TPanel;
    Browser: THTMLViewer;
    BtnExtenderBrowser: TSpeedButton;
    PnlPesquisaBrowser: TPanel;
    ImgPesquisaBrowser: TImage;
    Lbl_Busca_Frase_Browser: TLabel;
    Chk_Busca_Frase_Browser: TImage;
    Lbl_Busca_OU_Browser: TLabel;
    Chk_Busca_OU_Browser: TImage;
    Lbl_Busca_E_Browser: TLabel;
    Chk_Busca_E_Browser: TImage;
    Lbl_Artigo_Browser: TLabel;
    Chk_Artigo_Browser: TImage;
    Lbl_Titulo_Busca_Documento: TLabel;
    Lbl_Palavra_Encontrada: TLabel;
    BtnAvancarPalavra: TSpeedButton;
    BtnRetrocederPalavra: TSpeedButton;
    Btn_ExtenderBrowser: TSpeedButton;
    Btn_DividirBrowser: TSpeedButton;
    LblPublicacaoBrowser: TLabel;
    BtnLayOut: TSpeedButton;
    BtnBuscarBrowser: TSpeedButton;
    TxtPesquisaBrowser: TEdit;
    SplDivisaoDireita: TSplitter;
    PnlDireitaInferior: TPanel;
    Img_FundoLinha: TImage;
    Img_FundoColuna: TImage;
    Lst: TListView;
    PnlDireitaMeio: TPanel;
    ImgDireitaMeio: TImage;
    LblTituloResultadosPesquisa: TLabel;
    Btn_DividirListaPesquisa: TSpeedButton;
    Btn_ExtenderListaPesquisa: TSpeedButton;
    Btn_FecharPesquisa: TSpeedButton;
    BtnLayOut2: TSpeedButton;
    LblQuantidadeOcorrencias: TLabel;
    TmrToolTip: TTimer;
    PnlDicaOcorrencia: TPanel;
    Iml_ToolBar_Desabilitado: TImageList;
    N5: TMenuItem;
    ItmSair: TMenuItem;
    Img_Layout_1: TImage;
    Img_Layout_2: TImage;
    PnlBanner: TPanel;
    TmrExibicaoBanner: TTimer;
    ImgBanner2: TImage;
    Image4: TImage;
    IdHTTP1: TIdHTTP;
    ImgBannerPrincipal: TImage;
    ApplicationEvents1: TApplicationEvents;
    Image5: TImage;
    Chk_ExibirDicaBotoes: TCheckBox;
    TimerAtualizacoes: TTimer;
    PnlConexaoBancoDados: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LblAssinaturaExpirou: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TimerAtualizacoesTimer(Sender: TObject);
    procedure Chk_ExibirDicaBotoesClick(Sender: TObject);
    procedure TmrVerificacaoTimer(Sender: TObject);
    procedure BtnVerificarArquivosClick(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure LstResize(Sender: TObject);
    procedure ImgBannerPrincipalClick(Sender: TObject);
    procedure ImgBanner2Click(Sender: TObject);
    procedure PnlBannerResize(Sender: TObject);
    procedure TmrExibicaoBannerTimer(Sender: TObject);
    procedure ItmSairClick(Sender: TObject);
    procedure TmrToolTipTimer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnVoltarIndiceClick(Sender: TObject);
    procedure ItmExibirIndiceClick(Sender: TObject);
    procedure ItmExibirNotasClick(Sender: TObject);
    procedure TxtPesquisaBrowserKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure ItmEditarconfiguracoesClick(Sender: TObject);
    procedure ItmIndiceClick(Sender: TObject);
    procedure ItmAvancarHistoricoClick(Sender: TObject);
    procedure ItmVoltarHistoricoClick(Sender: TObject);
    procedure ItmImprimirClick(Sender: TObject);
    procedure ItmCopiarClick(Sender: TObject);
    procedure ItmSelecionarTudoClick(Sender: TObject);
    procedure ItmPaginaInicialClick(Sender: TObject);
    procedure ItmLicensaUsoClick(Sender: TObject);
    procedure ItmSobreClick(Sender: TObject);
    procedure Itm_Lista_Ajustar_MargemClick(Sender: TObject);
    procedure Itm_Lista_VisualizarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Itm_Indice_RemoverAutomaticamente1Click(Sender: TObject);
    procedure trvKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure trvMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Trv2Click(Sender: TObject);
    procedure Trv2InitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure Trv2GetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure Trv2GetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure BtnIndiceClick(Sender: TObject);
    procedure BtnNotasClick(Sender: TObject);
    procedure BtnHistoricoClick(Sender: TObject);
    procedure BtnBuscarBrowserClick(Sender: TObject);
    procedure PnlSuperiorMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ImgDireitaMeioMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure LstMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ImgPesquisaBrowserMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure BrowserMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure trvMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure trvChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure BtnLayOutClick(Sender: TObject);
    procedure trvExpanding(Sender: TBaseVirtualTree; Node: PVirtualNode; var Allowed: Boolean);
    procedure BtnRetrocederPalavraClick(Sender: TObject);
    procedure BtnAvancarPalavraClick(Sender: TObject);
    procedure SplDivisaoDireitaMoved(Sender: TObject);
    procedure Btn_FecharPesquisaClick(Sender: TObject);
    procedure Btn_ExtenderListaPesquisaClick(Sender: TObject);
    procedure Btn_DividirListaPesquisaClick(Sender: TObject);
    procedure Btn_ExtenderBrowserClick(Sender: TObject);
    procedure Btn_DividirBrowserClick(Sender: TObject);
    procedure PnlDireitaInferiorResize(Sender: TObject);
    procedure PnlPesquisaBrowserResize(Sender: TObject);
    procedure Chk_Busca_Frase_BrowserClick(Sender: TObject);
    procedure Chk_Busca_OU_BrowserClick(Sender: TObject);
    procedure Chk_Busca_E_BrowserClick(Sender: TObject);
    procedure Chk_Artigo_BrowserClick(Sender: TObject);
    procedure BrowserKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BrowserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TxtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure ScrListaChange(Sender: TObject);
    procedure Lbl_ExcluirNotaClick(Sender: TObject);
    procedure Lbl_IncluirAlterarNotaClick(Sender: TObject);
    procedure LstCustomDraw(Sender: TCustomListView; const ARect: TRect; var DefaultDraw: Boolean);
    procedure lstDblClick(Sender: TObject);
    procedure BtnBuscarClick(Sender: TObject);
    procedure PnlDireitaSuperiorResize(Sender: TObject);
    procedure ScrBrowserChange(Sender: TObject);
    procedure PnlBordaLateralDireitaResize(Sender: TObject);
    procedure BtnAvancarHistoricoClick(Sender: TObject);
    procedure BtnVoltarHistoricoClick(Sender: TObject);
    procedure BtnCopiarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure TrvCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TrvExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FormActivate(Sender: TObject);
    procedure ScrIndiceChange(Sender: TObject);
    procedure TrvGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: WideString);
    procedure Itm_Browser_ImprimirClick(Sender: TObject);
    procedure Itm_Browser_CopiarClick(Sender: TObject);
    procedure Itm_Browser_SelecionarTudoClick(Sender: TObject);

    procedure Chk_Selecionar_TudoClick(Sender: TObject);
    procedure Chk_Expandir_TudoClick(Sender: TObject);
    procedure Chk_Busca_FraseClick(Sender: TObject);
    procedure Chk_Busca_OUClick(Sender: TObject);
    procedure Chk_Busca_EClick(Sender: TObject);
    procedure Chk_NumeroClick(Sender: TObject);

    procedure TrvClick(Sender: TObject);
    procedure TrvInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure TrvChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TrvGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure TrvGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);

    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    Procedure ExibeHint(Texto : String; Publicacao : String; Y : Integer; X : Integer);
    Procedure EscondeHint();

    Function RemoveTag( Texto: String; TextoInicio : String; TextoFim: String; TextoSubstituicao : String) : String;

    Function ConectaServidorRemoto() : Boolean;
    procedure thread_VerificacaoAtualizacoes_Terminate(Sender: TObject);
    procedure VerificaAtualizacoesAutomaticas();

  private
    { Private declarations }
    //LstPesquisa       : TMyListView;

    VisualizacaoAtual                 : TipoVisualizacao;
    ResolucaoMonitor                  : String;
    Configuracoes                     : TConfiguracoes;

    Chk_Numero_Checked                : Boolean;
    Chk_Busca_E_Checked               : Boolean;
    Chk_Busca_OU_Checked              : Boolean;
    Chk_Busca_Frase_Checked           : Boolean;
    Chk_Selecionar_Tudo_Checked       : Boolean;
    Chk_Expandir_Tudo_Checked         : Boolean;

    Chk_Artigo_Browser_Checked        : Boolean;
    Chk_Busca_E_Browser_Checked       : Boolean;
    Chk_Busca_OU_Browser_Checked      : Boolean;
    Chk_Busca_Frase_Browser_Checked   : Boolean;

    DiretorioSistema                  : String;
    DiretorioImagens                  : string;
    DiretorioBrowser                  : string;
    DiretorioDados                    : string;
    DiretorioDocumentos               : string;

    DiretorioImagensResolucao         : String;
    DiretorioImagensObjetos           : String;
    DiretorioHTML                     : String;
    zlib : TCompressaoDados;

    PesquisaSelecionada : TipoPesquisa;

    PesquisaSelecionadaBrowser    : TipoPesquisa;
    PesquisaAtivada               : Boolean;
    //PesquisaBrowserAtivada        : Boolean;

    AjustandoScroll               : Boolean;
    AjustandoScrollBrowser        : Boolean;

    FrmSplah                      : TFrmSplash;

    CodigoProduto                 : string;
    CodigoVersaoSistema           : string;
    CodigoVersaoBaseDados         : string;
    SerialCliente                 : string;

    AcessoImpedido                : boolean;
    ErroInstalacao                : boolean;

    ControleLicenca               : TControleLicenca;

    TotalItensTreeView            : Word;

    HistoricoNomeTipoLei          : TStringList;
    HistoricoTipoLei              : TStringList;
    HistoricoNomeLei              : TStringList;

    HistoricoLeis                 : TStringList;
    HistoricoVerbetes             : TStringList;
    HistoricoPublicacao           : TStringList;
    IndiceHistorico               : Integer;
    NotaItemSelecionado           : String;
    NotaExiste                    : Boolean;
    TipoLeiAtual                  : Integer;
    NomeLeiAtual                  : String;
    CodigoLeiAtual                : Integer;
  PublicacaoAtual               : String;
    TotalMarcacaoAtual            : Integer;
    IndiceMarcacaoAtual           : Integer;

    ListaPalavras                 : TStringList;
    ListaPalavrasSelecao          : TStringList;
    FraseSelecao                  : String;

    Pos_Anterior_ScrIndice        : Integer;

    CarregandoFormulario          : Boolean;

    TeclaControlBrowser           : Boolean;

    CarregandoDadosTreeView       : Boolean;

    ConteudoAtual                 : TipoConteudo;

    Left_Edicao                   : Integer;
    Top_Edicao                    : Integer;
    Width_Edicao                  : Integer;
    Heigth_Edicao                 : Integer;
    MAximizado_Edicao             : Boolean;

    Node_Com_Hint: PVirtualNode;

    FormaPesquisaAtual : FormaPesquisa; // identifica se a pesquisa atual é a pesquisa normal , ou pesquisa apenas dentro dalei;

    ListaPalavrasSelecaoBrowser     : TStringList;
    FraseSelecaoBrowser : String;

    ExpandindoArvore : Boolean;

    TeclaAltPressionada : Boolean;

    //Height_DireitaSuperior : integer;
    Height_DireitaInferior : integer;

    InternetDisponivel : Boolean;
    IndiceBanner : Integer;
    OrigemBanner : TipoOrigemBanner;
    //LinkBannerPrincipal : String;

    ListaCodigoLeisAtualizadas : TStringList;
    ListaArquivosAtualizados : TStringList;

    DataLimiteExcedido : Boolean;

    ConteudoArquivoHTMLAtual : String;

    ConexaoSrvAtu                 : TCls_Conexao;

    thread_VerificacaoAtualizacoes : ThreadVerificacaoAtualizacoes;

    FormAssinaturaExpirou : TFrmAssinaturaExpirou;
    FrmAtualizacoes : TFrmAtualizacoes;

    ControleAtualizacoes          : TDownloadAtualizacoes;
    ConfigLogin                   : TConfiguracoesLogin;
    VerificandoAtualizacoes : Boolean;

    procedure AjustaControlesTela ();
    procedure CarregaBitMapsEsquerda();
    procedure AjustaControlesEsquerda();
    procedure AjustaControlesDireita();
    Procedure CaregaPosicaoJanela();
    Procedure SalvaPosicaoJanela();
    Procedure AjustaScrollBrowser();
    Procedure AjustaScrollLista();
    Function RetornaUltimaExecucao(): String;
    Procedure SalvaDataUltimaExecucao();

    Function ObtemResolucaoSistema() : String;

    procedure CarregaDadosTreeView();
    procedure CarregaListaTipos();
    procedure CarregaAnoTipoLei(TipoLei : Integer ; Node      : PVirtualNode );
    procedure CarregaListaLeis(TipoLei : Integer ; Ano: String; Node      : PVirtualNode );
    procedure InsereNodeVazio(Node      : PVirtualNode);
    procedure TrataNode(Node : PVirtualNode);

    procedure VisualizaTextoLei(TipoLei: Integer; NomeLei: String; Lei : Integer; Publicacao : String ; IncluirHistorico : Boolean; MarcarPalavras : Boolean );
    procedure AtualizaPaginaAtual();
    function SubstituiOcorrenciasHTML(Texto : String ; Palavra : String ; HTMLSubstituicao : String): String;
    function RetornaTituloLei(TipoLei : Integer ; NomeLei : String) : String;
    procedure SelecionaPalavrasPesquisa_V2(var TextoHTML : String ; ListaPalavras : TStringList ; Frase : String ; MarcarFrase : Boolean );
    procedure IncluiNotas(Lei : Integer ; Arquivo : String);
    Procedure AtualizaBotaoNotas();

    Procedure VisualizaDefault();
    Procedure SalvaArquivosAssociadosPaginaExterna(http : TAtualizacoesSistema; CaminhoArquivo : string; PaginaBase : string ;  DiretorioBase : string);
    procedure VisualizaPaginaInicial();

    Procedure SelecionaOrigemBanner();
    Procedure VerificaBannersInternet();

    Procedure VerificaDisponibilidadeInternet();

    Procedure VisualizaBannerPrincipal();
    Procedure HabilitaSuspendeExibicaoBanner( Habilitar : Boolean);
    Procedure AlternaExibicaoBanner();

    procedure IncluiAlteraNota();
    procedure ExcluiNota();

    procedure CarregaImagensObjetos();

    Procedure SelecionaOpcaoPesquisa (Tipo : TipoPesquisa );
    procedure MarcaOpcao(Tipo : TipoPesquisa);
    procedure DesmarcaOpcao(Tipo : TipoPesquisa );

    Procedure SelecionaOpcaoPesquisaBrowser (Tipo : TipoPesquisa );
    procedure MarcaOpcaoBrowser(Tipo : TipoPesquisa);
    procedure DesmarcaOpcaoBrowser(Tipo : TipoPesquisa );

    Procedure ImprimeConteudoBrowser();
    Procedure CopiaConteudoBrowserClipboard();

    Procedure CarregaConfiguracoes();
    Procedure CarregaConfiguracoesAparencia();
    Procedure ConfiguraOpcoesPesquisa();
    Procedure ExibeJanelaAtivacao();
    Procedure MarcaDesmarcaTiposLei( NodePai : PVirtualNode ); overload;
    Procedure MarcaDesmarcaTiposLei( NodePai : PVirtualNode ;  Estado : TCheckState ); overload;
    Procedure ExpandeContraiArvore( NodePai : PVirtualNode );

    procedure Mensagem( Mensagem : String ; Titulo : String);
    function Pergunta( Mensagem : String ; Titulo : String) : integer;
    procedure ExibeMensagemAlertaAdministrador;

    function RetornaVersaoWindows: TWinVersion;

    function VerificaUsuarioAdministrador() : Boolean;
    function RetornaNomeVersaoWindows: String;
    function UsuarioLogadoAdministrador: Boolean;

    Procedure AjustaScrollBarTreeView();
    Procedure AjustaScrollBarBrowser();

    Procedure AtualizaNavegacao();
    Procedure VoltarHistorico();
    Procedure AvancarHistorico();

    procedure Pesquisa_Por_Numero(CodigoTipoLei : integer);
    procedure Pesquisa_Por_PalavraChave(TiposLeiSelecionados : String ;  CondicaoSubNodes : String ; CondicaoLeis : String);
    procedure Pesquisa_E(TiposLeiSelecionados : String ;  CondicaoSubNodes : String ; CondicaoLeis : String);
    procedure Pesquisa_OU(TiposLeiSelecionados : String ;  CondicaoSubNodes : String ; CondicaoLeis : String);

    procedure ExibeDicaOcorrencias();
    procedure EscondeDicaOcorrencias();

    procedure CriaColunasListaPesquisa();
    procedure CriaListaPesquisa();
    function VerificaSubNodesSelecionados(Node : PVirtualNode ; Var Condicao2 : String) : String;
    function VerificaLeisSelecionadas(Node : PVirtualNode) : String;

    Function VerificaExistenciaPalavras(var ListaCodigos : TStringList; Tipo : TipoPesquisa ) : String;
    Function VerificaPalavrasTextoLei(Link : String; ListaCodigos: TStringList ; Tipo : TipoPesquisa ) : Boolean;
    procedure AjustaScrollBarLista();
    procedure VisualizaPainelPesquisa();
    procedure EscondePainelPesquisa();
    Function RetornaTextoBrowser() : String;
    procedure Pesquisa_Browser_Por_Artigo();
    procedure Pesquisa_Browser_Frase();
    procedure VerificaPalavrasPesquisaBrowser();

    procedure VisualizaHistorico();
    procedure VisualizaNotas();
    procedure VisualizaIndice();

    Procedure ConfiguraPastaTrabalho();

    procedure CarregaConfiguracoesLogin();

  public
    { Public declarations }
  end;

{$ENDREGION}

{$REGION 'Constantes e Variáveis'}

var
  FrmPrincipal: TFrmPrincipal;

const

  CorTituloVerbeteComFoco   : TColor = $000080;
  CorTituloVerbeteSemFoco   : TColor = $808080;
  Change_Indice             : Integer = 1000;
  Change_Indice2            : Integer = 3000;

  Indice_CheckBoxMarcado      : integer = 0;
  Indice_CheckBoxDesmarcado   : integer = 1;

  CorFundoSelecaoPesquisaBrowser  : string = '#8080FF';

{$ENDREGION}

implementation

{$R *.dfm}

{$REGION 'Eventos do Formulario'}

procedure TFrmPrincipal.FormCreate(Sender: TObject);

Var
ErroVerificacao : Boolean;
Diferenca : int64;
//Diferenca2 : int64;
DataUltimaExecucao : String;

begin

  CarregandoFormulario := True;

  CarregaConfiguracoesLogin();

  CarregaConfiguracoes();

  ErroInstalacao := False;

  PesquisaAtivada := False;

  FormaPesquisaAtual := FP_Nenhuma;

  ExpandindoArvore := False;

  ConteudoAtual := TC_Indice;

  DataLimiteExcedido := false;

  if Configuracoes.TipoLicenca = TL_Demo3Usos then
    begin
      CodigoProduto         := '0101';
      CodigoVersaoSistema   :=  ReplaceText ( Configuracoes.VersaoSistema , '.' , '');
      CodigoVersaoBaseDados :=  ReplaceText ( Configuracoes.VersaoBaseDados , '.' , '');
      SerialCliente         := '00000000000000000000';
      Application.ProcessMessages;

      ControleLicenca := TControleLicenca.Create(CodigoProduto, CodigoVersaoSistema, CodigoVersaoBaseDados, SerialCliente);
    end;

  if Configuracoes.TipoLicenca = TL_Demo3Usos then
    begin
      if ControleLicenca.TipoLicenca <> LicencaFull then
        begin
          (**********************************************
           **********************************************
           **********************************************
          if not VerificaUsuarioAdministrador() then
            begin
              ErroInstalacao := True;
              Self.Visible := false;
            end;
          **********************************************
          **********************************************                      
          **********************************************)
        end;
    end;

  CriaListaPesquisa();

  AtualizaNavegacao();

  PnlSuperior.DoubleBuffered := True;
  PnlEsquerda.DoubleBuffered := True;
  PnlDireita.DoubleBuffered := True;
  PnlDireitaInferior.DoubleBuffered := True;
  PnlDireitaSuperior.DoubleBuffered := True;
  PnlBordaLateralDireita.DoubleBuffered := True;
  PnlPesquisaBrowser.DoubleBuffered := True;
  PnlHint.DoubleBuffered := True;
  PnlBanner.DoubleBuffered := True;

  Trv.DoubleBuffered := True;

  if not ErroInstalacao then
    begin

      FrmSplah := TFrmSplash.Create(FrmPrincipal);
      FrmSplah.ExibicaoSobre := False;
      FrmSplah.DiretorioImagens := DiretorioImagens;
      FrmSplah.CarregaImagemSplash;
      FrmSplah.Show;
      Application.ProcessMessages;

      ErroVerificacao := false;

      if Configuracoes.TipoLicenca = TL_Demo3Usos then
          begin

            if ControleLicenca.TipoLicenca = LicencaDemo then
              ExibeJanelaAtivacao();

            if (ControleLicenca.TipoLicenca = LicencaDemo) and ( 3 - ControleLicenca.QuantidadeUtilizacoes <= 0 ) then
              begin
                mensagem ('O período de testes deste sistema ja acabou.', 'LexMaximus');
                AcessoImpedido := True;
              end;
            if ControleLicenca.TipoLicenca = LicencaErro then
                begin
                ErroVerificacao := True;
              end;
          end
      else
        begin
          if Configuracoes.TipoLicenca = TL_Indefinido then
            begin
              ErroVerificacao := True;
            end
          else
            begin
              //Licenca com limite de uso
              if Isdate(Configuracoes.DataLimiteUso) then
                begin
                  if Configuracoes.DataLimiteUso = '01/01/1900' then
                    ErroVerificacao := True
                  else
                    begin
                      Diferenca := DateTimeDiff( StrToDate(Configuracoes.DataLimiteUso), StrToDate( FormatDateTime('dd/mm/yyyy', now) )  );

                      if Diferenca > 0 then
                        begin
                          mensagem ('O período de utilização deste sistema ja acabou.', 'LexMaximus');
                          AcessoImpedido := True;
                          DataLimiteExcedido := True;
                        end;

                      if not AcessoImpedido then
                        begin
                          DataUltimaExecucao := RetornaUltimaExecucao();

                          if DataUltimaExecucao = 'ERRO' then
                            begin
                              mensagem ('O período de utilização deste sistema ja acabou.', 'LexMaximus');
                              AcessoImpedido := True;
                              DataLimiteExcedido := True;
                            end;

                          if DataUltimaExecucao <> '' then
                            begin
                              Diferenca := DateTimeDiff( StrToDate(DataUltimaExecucao), StrToDate( FormatDateTime('dd/mm/yyyy', now) )  );

                              if Diferenca < 0 then
                                begin
                                  mensagem ('O período de utilização deste sistema ja acabou.', 'LexMaximus');
                                  AcessoImpedido := True;
                                  DataLimiteExcedido := True;
                                end;
                            end;

                        end;

                    end;
                end
              else
                begin
                  ErroVerificacao := True;
                end;
            end;
        end;
      if ErroVerificacao then
        begin
          mensagem ('Houve um erro na verificação da licença do sistema.', 'LexMaximus');
          AcessoImpedido := True;
        end;
    end;

  if (not AcessoImpedido) and ( not ErroInstalacao) Then
    begin

      CaregaPosicaoJanela();

      EscondeHint();

      VisualizaIndice();

      AtualizaBotaoNotas();

      CarregaDadosTreeView();

      PnlEsquerda.DoubleBuffered := True;

      PnlDireita.DoubleBuffered := True;

      PnlSuperior.DoubleBuffered := True;

      VisualizacaoAtual := TV_Ambos;

      ConfiguraOpcoesPesquisa();

      VerificaDisponibilidadeInternet();

      //VerificaBannersInternet();

      SelecionaOrigemBanner();

      if OrigemBanner = TO_Nenhuma then
        begin
          PnlBanner.Visible := false;
        end;

      if OrigemBanner = TO_Internet then
        begin
          if Configuracoes.ListaBannerInternet.Count = 0 then
            PnlBanner.Visible := false;

          if Configuracoes.ListaBannerInternet.Count = 1 then
            if Configuracoes.ListaBannerInternet[0] = '' then
              PnlBanner.Visible := false;
        end;

      if OrigemBanner = TO_Local then
        begin
          if Configuracoes.ListaBannerLocal.Count = 0 then
            PnlBanner.Visible := false;

          if Configuracoes.ListaBannerLocal.Count = 1 then
            if Configuracoes.ListaBannerLocal[0] = '' then
              PnlBanner.Visible := false;

        end;

      if (Configuracoes.ConectarInternet) and (InternetDisponivel) then
        begin
          VisualizaPaginaInicial();

          VisualizaBannerPrincipal();
        end
      else
       (*****************************
        begin
          ImgBannerPrincipal.Visible := False;
        end;
       *****************************)
        
      FrmSplah.Hide;
      Application.ProcessMessages;
      FrmSplah.Close;
      FrmSplah.Destroy;

    end;


  CarregandoFormulario := false;

end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (not AcessoImpedido) and (not ErroInstalacao) Then
    begin

      if Configuracoes.TipoLicenca = TL_DemoAno then
        begin
          if not DataLimiteExcedido then
            SalvaDataUltimaExecucao();
        end;

      SalvaPosicaoJanela();

       Configuracoes.SalvaConfiguracoes();

      if ControleLicenca <> nil then
        begin
          //
          // so tenta gravar no registro se nao for licenca de 3 usos, Full
          // assim evita-se a necessidade de ter que entrar como administrador do sistema
          //
          if (ControleLicenca.TipoLicenca <> LicencaFull) AND (Configuracoes.TipoLicenca = TL_Demo3Usos) then
            begin
              ControleLicenca.Destroy;
            end;
        end;

      if configuracoes <> nil Then Configuracoes.Destroy;

    end;

end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin


  if (Key = 13) and (Browser.SelLength >0) then
    exit;

  if (  key in [13, 18, 33,34,35,36,37,38,39,40] ) then
    exit;

  if key = VK_CONTROL  then
    exit;

  if key = VK_SHIFT  then
    exit;

  if (TeclaAltPressionada) and (   chr(Key)    in [ 'E' ,'A', 'C', 'D', 'L', 'R', 'J' , 'e' ,'a', 'c', 'd', 'l', 'r', 'j'  ] ) Then
    exit;

  if ConteudoAtual <> TC_Indice then
    begin
      VisualizaIndice;
    end;

end;

procedure TFrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 18 then
    TeclaAltPressionada := False;
end;

procedure TFrmPrincipal.FormResize(Sender: TObject);
begin
  AjustaControlesTela();
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin

  TimerAtualizacoes.Enabled := True;
  
end;

procedure TFrmPrincipal.FormActivate(Sender: TObject);
begin
  try
    if (AcessoImpedido) or (ErroInstalacao) Then
      begin
        Application.ProcessMessages;
        Application.ProcessMessages;
        Application.ProcessMessages;

        Self.Close;
      end;

  finally

  end;
end;

{$ENDREGION}

{$REGION 'Eventos do PopUp do Browser'}

procedure TFrmPrincipal.Itm_Browser_CopiarClick(Sender: TObject);
begin
       CopiaConteudoBrowserClipBoard;
end;

procedure TFrmPrincipal.Itm_Browser_ImprimirClick(Sender: TObject);
begin
       ImprimeConteudoBrowser;
end;

procedure TFrmPrincipal.Itm_Browser_SelecionarTudoClick(Sender: TObject);
begin

    Browser.SelectAll;

end;

procedure TFrmPrincipal.ItmSobreClick(Sender: TObject);
begin

  //if FrmSplah = nil then
    FrmSplah := TFrmSplash.Create(FrmPrincipal);

  FrmSplash.AlphaBlendValue := 5;
  FrmSplah.DiretorioImagens := DiretorioImagens;
  FrmSplah.ExibicaoSobre := True;
  FrmSplah.CarregaImagemSplash;

  FrmSplah.ShowModal;
  Application.ProcessMessages;

  //FrmSplah.Hide;

end;

{$ENDREGION}

{$REGION 'Eventos do menu principal'}

///////////////////////////// Lexmaximus


procedure TFrmPrincipal.ItmLicensaUsoClick(Sender: TObject);
var
  FrmLicencaUso : TFrmLicencaUso;
begin
  FrmLicencaUso := TFrmLicencaUso.Create(self);

  FrmLicencaUso.DiretorioDocumentos := DiretorioDocumentos;

  if ControleLicenca = nil then
    FrmLicencaUso.ChaveUsuario := ''
  else
    FrmLicencaUso.ChaveUsuario := ControleLicenca.SerialCliente;

  FrmLicencaUso.Configuracoes := Configuracoes;
  FrmLicencaUso.ConfiguraJanela;
  FrmLicencaUso.ShowModal;

  FrmLicencaUso.Destroy;

end;

procedure TFrmPrincipal.ItmPaginaInicialClick(Sender: TObject);
begin

    VisualizaPaginaInicial();
    
end;

procedure TFrmPrincipal.ItmExibirIndiceClick(Sender: TObject);
begin

  VisualizaIndice();
end;

procedure TFrmPrincipal.ItmExibirNotasClick(Sender: TObject);
begin
  VisualizaNotas();
end;


procedure TFrmPrincipal.ItmSairClick(Sender: TObject);
begin
  self.Close();
  
end;


///////////////////////////// Configuracoes

procedure TFrmPrincipal.ItmEditarconfiguracoesClick(Sender: TObject);
var
  frm : TFrmConfiguracoes;

begin
  frm := TFrmConfiguracoes.Create(self);
  frm.Configuracoes := Configuracoes;
  frm.EditaConfiguracoes(SkinData1);
  frm.ShowModal;

  CarregaConfiguracoesAparencia();

end;

///////////////////////////// Editar

procedure TFrmPrincipal.ItmSelecionarTudoClick(Sender: TObject);
begin

  Browser.SelectAll;

end;

procedure TFrmPrincipal.ItmCopiarClick(Sender: TObject);
begin

  CopiaConteudoBrowserClipBoard;

end;

procedure TFrmPrincipal.ItmImprimirClick(Sender: TObject);
begin

  ImprimeConteudoBrowser;

end;

procedure TFrmPrincipal.ItmVoltarHistoricoClick(Sender: TObject);
begin

  VoltarHistorico;

end;

procedure TFrmPrincipal.ItmAvancarHistoricoClick(Sender: TObject);
begin

  AvancarHistorico;

end;

///////////////////////////// Ajuda

procedure TFrmPrincipal.ItmIndiceClick(Sender: TObject);

var
  DiretorioAjuda: String;
  ArquivoAjuda : String;
begin
  try
    DiretorioAjuda:= GetCurrentDir + '\Ajuda\';

    ArquivoAjuda := DiretorioAjuda + 'LexMaximus.chm';

    if FileExists(ArquivoAjuda) then
      ShellExecute (  Self.Handle, '', 'hh.exe',  PAnsiChar( ArquivoAjuda), PAnsiChar( DiretorioAjuda ), 1)
    else
      begin
        MessageBox(Self.Handle, 'Arquivo de ajuda não foi encontrado' , 'LexMaximus' , MB_OK or MB_ICONERROR);
      end;

  Except
    on ex : exception do
      begin

      end;
  end;

end;

{$ENDREGION}

{$REGION 'Eventos do PopUp do Indice'}

procedure TFrmPrincipal.Itm_Indice_RemoverAutomaticamente1Click( Sender: TObject);
begin
end;

{$ENDREGION}

{$REGION 'Eventos do PopUp da lista'}

procedure TFrmPrincipal.Itm_Lista_Ajustar_MargemClick(Sender: TObject);
begin
  try
  
  finally

  end;
end;

procedure TFrmPrincipal.Itm_Lista_VisualizarClick(Sender: TObject);
begin

  lstDblClick(lst);

end;

{$ENDREGION}

{$REGION 'Eventos da TreeView de Indice'}

procedure TFrmPrincipal.TrvChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data : PTreeData;

begin
  try

  if ExpandindoArvore then
    exit;

    Data      :=  Trv.GetNodeData(Node);

    if data = nil  then
      exit;

    if (Data^.Tipo = TN_TipoLei) OR (Data^.Tipo = TN_Ano) then
      begin
        MarcaDesmarcaTiposLei(Node, Node.CheckState);
      end;

  finally

  end;
end;

procedure TFrmPrincipal.TrvClick(Sender: TObject);
var
  Data                  : PTreeData;
  Node: PVirtualNode;

begin

  if ExpandindoArvore then
    exit;

  AjustandoScroll := True;

  Node := Trv.FocusedNode;

  Data      :=  Trv.GetNodeData(Node);

  if data = nil  then
    begin
      //MarcaDesmarcaTiposLei(Node, Node.CheckState);
      AjustandoScroll := False;
      exit;
    end;

  //if not data^.SubItensCarregados then
  TrataNode(Trv.FocusedNode);

  EscondeHint;

  AjustandoScroll := False;

end;

procedure TFrmPrincipal.TrvCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin

  if ExpandindoArvore then
    exit;

  TotalItensTreeView := TotalItensTreeView - Node.ChildCount;
  AjustaScrollBarTreeView();
  EscondeHint;

end;

procedure TFrmPrincipal.trvChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data                  : PTreeData;

begin

  if ExpandindoArvore then
    exit;

  if CarregandoDadosTreeView then
    exit;

  AjustandoScroll := True;

  Data      :=  Trv.GetNodeData(Node);

  if data = nil  then
    begin
      AjustandoScroll := False;
      exit;
    end;

  if Data.TipoLei = 10 then
    Data.TipoLei := 10;

  //if not data^.SubItensCarregados then
    TrataNode(Trv.FocusedNode);
    
    EscondeHint;

  AjustandoScroll := False;
  
end;

procedure TFrmPrincipal.TrvExpanded(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  if ExpandindoArvore then
    exit;

  TotalItensTreeView := TotalItensTreeView + Node.ChildCount;
  AjustaScrollBarTreeView();
end;

procedure TFrmPrincipal.trvExpanding(Sender: TBaseVirtualTree;   Node: PVirtualNode; var Allowed: Boolean);
var
  Data                  : PTreeData;
begin

  if ExpandindoArvore then
    begin
      Data      :=  Trv.GetNodeData(Node);
      if data^.Tipo = TN_Ano then
        begin
          if Node.TotalCount >2 then
            Allowed := True
          else
            Allowed := False;
        end
      else
        begin
          Allowed := True;
        end;
      exit;
    end;

  //if ExpandindoArvore then
  //  exit;

  TrataNode(Node);
  EscondeHint;
end;

procedure TFrmPrincipal.TrvGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;  Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;   var HintText: WideString);
var
  Data                  : PTreeData;

begin

  if ExpandindoArvore then
    exit;

  Data      :=  Trv.GetNodeData(Node);

  if Data^.Tipo = TN_DocumentoHTML then
    LineBreakStyle:=  hlbForceMultiLine;
    
  HintText := Data^.Hint;

end;

procedure TFrmPrincipal.trvGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data                  : PTreeData;
begin
  try
    Data      :=  Trv.GetNodeData(Node);

    if Data^.Tipo =TN_TipoLei then
      begin
        if Kind = ikSelected then
          ImageIndex := 0
        else
          ImageIndex := 1;

      end;

  finally

  end;

end;

procedure TFrmPrincipal.TrvGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
var
  Data: PTreeData;

begin

  Data      :=  Trv.GetNodeData(Node);

  CellText  :=  Data^.Texto;

end;

procedure TFrmPrincipal.TrvInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PTreeData;

begin

  Data:=  Trv.GetNodeData(Node);

  if Data = Nil then
    begin
      Node.CheckType := ctCheckBox;
      Node.CheckState := Node.Parent.CheckState;
    end
  else
    begin
      if (Data^.Tipo = TN_TipoLei) or (Data^.Tipo = TN_Ano) or (Data^.Tipo = TN_NodeVazio) then
        begin
          Node.CheckType := ctCheckBox;
          Node.CheckState := Node.Parent.CheckState;
        end
      else
        begin
          Node.CheckType := ctNone;
        end
    end;
    
end;

procedure TFrmPrincipal.trvKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_LEFT) or (Key = VK_RIGHT) then
    Browser.SetFocus;

end;

procedure TFrmPrincipal.trvMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: PVirtualNode;
begin

  if Button = mbRight then
    begin
      Node := trv.GetNodeAt(x,y);
      if node<>nil then
        begin
          trv.FocusedNode := node;
          PopUpIndice.Popup( PnlEsquerda.Left + trv.Left + x  , PnlEsquerda.Top + trv.top +  y);
        end;
    end;

end;

procedure TFrmPrincipal.trvMouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
var
  //hoverNode: TTreeNode;
  Data: PTreeData;
  Node: PVirtualNode;

begin
  Node := trv.GetNodeAt(x,y);


  if Node = nil then
    exit;

  if Node = Node_Com_Hint then
    exit;

  Data      :=  Trv.GetNodeData(Node);

  if Data = Nil then
    Exit;

  if Data = nil then
    EscondeHint()
  else
    begin
      if ( Data^.Tipo = TN_DocumentoHTML) then
        begin
          if Data^.Hint = '' then
            EscondeHint()
          else
            begin
              Node_Com_Hint := Node;
              ExibeHint( Data^.Hint ,  Data^.Publicacao ,  y + trv.Top + 100, x + 100 )
            end;
        end
      else
        EscondeHint();
    end;

end;

{$ENDREGION}

{$REGION 'Eventos da TreeView de Historico e Notas'}

procedure TFrmPrincipal.Trv2Click(Sender: TObject);
var
  Data                  : PTreeData;
  Node: PVirtualNode;

begin

  Node := Trv2.FocusedNode;

  Data      :=  Trv2.GetNodeData(Node);

  if data = nil  then
    begin
      exit;
    end;
    
  if Data^.Tipo = TN_DocumentoHTML then
    begin
      VisualizaTextoLei( Data^.TipoLei , Data^.Texto,  Data^.Codigo,  Data^.Publicacao , False, False );
    end;

end;

procedure TFrmPrincipal.Trv2GetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data                  : PTreeData;

  begin
  try
    Data      :=  Trv2.GetNodeData(Node);

    if Data^.Tipo =TN_TipoLei then
      begin
        if Kind = ikSelected then
          ImageIndex := 0
        else
          ImageIndex := 1;

      end;

  finally

  end;

end;

procedure TFrmPrincipal.Trv2GetText(Sender: TBaseVirtualTree;   Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;   var CellText: WideString);
var
  Data: PTreeData;

begin

  Data      :=  Trv2.GetNodeData(Node);
  CellText  :=  Data^.Texto;
  
end;

procedure TFrmPrincipal.Trv2InitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin

 // Node.CheckType := ctCheckBox;
 // Node.CheckState := Node.Parent.CheckState;

end;

{$ENDREGION}

{$REGION 'Eventos da ListView'}

procedure TFrmPrincipal.LstCustomDraw(Sender: TCustomListView; const ARect: TRect; var DefaultDraw: Boolean);

function GetHeaderHeight: Integer;
var
  Header: HWND;           // header window handle
  Pl: TWindowPlacement;   // header window placement
begin
  // Get header window
  Header := SendMessage(Lst.Handle, LVM_GETHEADER, 0, 0);
  // Get header window placement
  FillChar(Pl, SizeOf(Pl), 0);
  Pl.length := SizeOf(Pl);
  GetWindowPlacement(Header, @Pl);
  // Calculate header window height
  Result  := Pl.rcNormalPosition.Bottom - Pl.rcNormalPosition.Top;
end;

var
  BmpXPos, BmpYPos: Integer;  // X and Y position for bitmap
  Bmp: TBitmap;               // Reference to bitmap
  ItemRect: TRect;            // List item bounds rectangle
  TopOffset: Integer;         // Y pos where bmp drawing starts
begin
  // Get top offset where bitmap drawing starts
  if Lst.Items.Count > 0 then
    begin
      ListView_GetItemRect(Lst.Handle, 0, ItemRect, LVIR_BOUNDS);
      TopOffset := ListView_GetTopIndex(Lst.Handle) * (ItemRect.Bottom - ItemRect.Top);
    end
  else
    TopOffset := 0;

  //desennhado o bitmap da coluna
  ////////////Lst.Canvas.Draw(0, 0, Img_FundoColuna.Picture.Bitmap);

  BmpYPos := ARect.Top - TopOffset + GetHeaderHeight;
  // Draw the bitmap
  // get reference to bitmap
  Bmp := Img_FundoLinha.Picture.Bitmap;

  // loop until bmp is past bottom of list view
  while BmpYPos < ARect.Bottom do
    begin
      // draw bitmaps across width of display
      BmpXPos := ARect.Left;
      while BmpXPos < ARect.Right do
        begin
          Lst.Canvas.Draw(BmpXPos, BmpYPos, Bmp);
          Inc(BmpXPos, Bmp.Width);
        end;
      // move to next row
      Inc(BmpYPos, Bmp.Height);
    end;

  
  SetBkMode(Lst.Canvas.Handle, TRANSPARENT);
  ListView_SetTextBkColor(Lst.Handle, CLR_NONE);
  ListView_SetBKColor(Lst.Handle, CLR_NONE);


end;

procedure TFrmPrincipal.lstDblClick(Sender: TObject);

var
  Lei : String;
  NomeLei: String;
  TipoLei : Integer;
begin
  try
    if Lst.Selected = nil then
      exit;

    //if Lst.Selected.Caption <> '' then
    //  begin
        NomeLei := Lst.Selected.SubItems[0];
        Lei := Lst.Selected.SubItems[5];
        TipoLei := StrToInt(Lst.Selected.SubItems[6]);
        if Not PnlDireitaSuperior.Visible then
          begin
            //simula o click para dividir a tela
            Btn_ExtenderListaPesquisaClick(Btn_ExtenderListaPesquisa);
          end;

        FormaPesquisaAtual := FP_ListaLeis;
        BtnRetrocederPalavra.Visible := false;
        BtnAvancarPalavra.Visible := false;
        TxtPesquisaBrowser.Text := '';

        IndiceMarcacaoAtual:=1;
        Screen.Cursor := crHourGlass;
        VisualizaTextoLei(TipoLei, NomeLei, StrToInt(Lei), Lst.Selected.Caption, True, True);
        Screen.Cursor := crDefault;

        ExibeDicaOcorrencias();

        //Achiles: 04/01/2010
        // para avancar para o primeiro item da pesquisa
        BtnAvancarPalavraClick(BtnAvancarPalavra);
    //  end;


  except
    on ex : exception do
      begin
        MessageBox(Self.Handle, PAnsiChar(ex.Message) , 'LexMaximus', MB_OK or MB_ICONERROR);
      end;

  end;

end;

procedure TFrmPrincipal.LstMouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
begin
  EscondeHint();
end;

procedure TFrmPrincipal.LstResize(Sender: TObject);
begin

  ShowScrollBar( Lst.Handle, SB_VERT , false );
  ///ShowScrollBar( Lst.Handle, SB_HORZ , false );

end;

{$ENDREGION}

{$REGION 'Eventos das scrollbar'}

procedure TFrmPrincipal.ScrBrowserChange(Sender: TObject);
begin
  try
    if not AjustandoScrollBrowser then
      begin

        Browser.VScrollBar.Position := ScrBrowser.Position;

        Browser.ScrollTo(ScrBrowser.Position);

        ScrBrowser.Repaint;
      end;
  finally
  end;

end;

procedure TFrmPrincipal.ScrIndiceChange(Sender: TObject);

begin

  //SetScrollPos(Trv.Handle, SB_VERT, ScrIndice.Position, true);

 (****************************************************)
 if Pos_Anterior_ScrIndice = -1  then
   PostMessage( Trv.Handle, WM_VSCROLL, SB_LINEDOWN, 0)
 else
  begin
    //if ScrIndice.Position = ScrIndice.Min then
    if ScrIndice.Position <= 15 then
      PostMessage( Trv.Handle, WM_VSCROLL, SB_TOP, 0)
    else
      begin
        if ScrIndice.Position = ScrIndice.Max then
          PostMessage( Trv.Handle, WM_VSCROLL, SB_BOTTOM, 0)
        else
        begin
          if Pos_Anterior_ScrIndice > ScrIndice.Position then
            // esta subindo
            PostMessage( Trv.Handle, WM_VSCROLL, SB_LINEUP, 0)
          else
            // esta descendo
            PostMessage( Trv.Handle, WM_VSCROLL, SB_LINEDOWN, 0)
        end;
      end;

  end;
 Pos_Anterior_ScrIndice := ScrIndice.Position;

 (****************************************************)


  ScrIndice.Repaint;

end;

procedure TFrmPrincipal.ScrListaChange(Sender: TObject);

begin

  Lst.Items[ ScrLista.Position-1].MakeVisible(false);

  ScrLista.Repaint;

end;

{$ENDREGION}

{$REGION 'Eventos dos botoes'}

procedure TFrmPrincipal.BtnLayOutClick(Sender: TObject);
begin

  case VisualizacaoAtual of
       TV_Browser:
        begin
          VisualizacaoAtual := TV_Ambos;
          BtnLayOut.Glyph := Img_Layout_1.Picture.Bitmap;
          BtnLayOut2.Glyph := Img_Layout_1.Picture.Bitmap;
        end;
       TV_Ambos:
        begin
          VisualizacaoAtual := TV_Browser;
          BtnLayOut.Glyph := Img_Layout_2.Picture.Bitmap;
          BtnLayOut2.Glyph := Img_Layout_2.Picture.Bitmap;
        end;
     end;
  BtnLayOut.Refresh;
  CarregaBitMapsEsquerda();
  
  AjustaControlesTela();


end;

procedure TFrmPrincipal.BtnAvancarHistoricoClick(Sender: TObject);
begin
  AvancarHistorico;
end;

procedure TFrmPrincipal.BtnAvancarPalavraClick(Sender: TObject);
var
  Marcacao : String;
begin
  try

    Marcacao := 'MARCACAO-' + RightPad( IntToStr(IndiceMarcacaoAtual), '0' , 4 );

    inc(IndiceMarcacaoAtual , 1);

    if not Browser.PositionTo(Marcacao) then
      begin
        MessageBox( Self.Handle, 'Não há mais ocorrências', '' , MB_OK);
        IndiceMarcacaoAtual := TotalMarcacaoAtual;
        exit;
      end;

  finally

  end;
end;

procedure TFrmPrincipal.BtnRetrocederPalavraClick(Sender: TObject);
var
  Marcacao : String;
begin

    Marcacao := 'MARCACAO-' + RightPad( IntToStr(IndiceMarcacaoAtual), '0' , 4 );

    Dec ( IndiceMarcacaoAtual , 1);

    if not Browser.PositionTo(Marcacao) then
      begin
           MessageBox( Self.handle, 'Não existem ocorrências anteriores a ocorrência marcada', '' , MB_OK);
          IndiceMarcacaoAtual := 1;
          exit;
      end;

end;

procedure TFrmPrincipal.BtnBuscarBrowserClick(Sender: TObject);
begin
  try
    if trim(TxtPesquisaBrowser.Text) = '' then
      begin
        MessageBox(Self.Handle , 'Informe o texto da pesquisa', 'LexMaximus' , MB_OK or MB_ICONWARNING);
        exit;
      end;
      
    if PesquisaSelecionadaBrowser =  TP_Nenmhum then
      begin
        MessageBox(Self.Handle , 'Selecione um tipo de pesquisa', 'LexMaximus' , MB_OK or MB_ICONWARNING);
        exit;
      end;

    VerificaPalavrasPesquisaBrowser();

    FormaPesquisaAtual := FP_TextoLei;

    if PesquisaSelecionadaBrowser =  TP_Numero then
      begin
        if not isnumeric(trim(TxtPesquisaBrowser.Text)) then
          begin
            MessageBox(Self.Handle , 'Informe o número do artigo (apenas o número)', 'LexMaximus' , MB_OK or MB_ICONWARNING);
            exit;
          end;
        FormaPesquisaAtual := FP_TextoLei;
        Pesquisa_Browser_Por_Artigo();

      end
    else
      begin
        FraseSelecaoBrowser := trim(TxtPesquisaBrowser.Text);

        VisualizaTextoLei(TipoLeiAtual, NomeLeiAtual, CodigoLeiAtual, PublicacaoAtual , False, True);
        BtnAvancarPalavra.Visible := true;
        BtnRetrocederPalavra.Visible := true;
        ExibeDicaOcorrencias();

        //Achiles: 04/01/2010
        // para avancar para o primeiro item da pesquisa
        BtnAvancarPalavraClick(BtnAvancarPalavra);

      end;

  finally

  end;
end;

procedure TFrmPrincipal.BtnBuscarClick(Sender: TObject);
var
  I                         : Integer;
  Q                         : Integer;
  TotalSelecionados         : Integer;
  Node                      : PVirtualNode;
  Data                      : PTreeData;
  CodigoTipoLei             : Integer;
  TiposLeiSelecionados      : String;
  TextoPesquisa             : String;
  SubNodesSelecionados      : String;
  CondicaoSelecaoSubNode    : String;
  LeisSelecionadas          : String;
  CondicaoSelecaoLei        : String;
  Condicao2                 : String;

begin
  try
    if PesquisaSelecionada = TP_Nenmhum then
      begin
        MessageBox(Self.Handle, 'Selecione um critério de pesquisa (Número da Lei, Operador "E", Operador "OU" ou Frase)', 'LexMaximus', MB_OK OR MB_ICONWARNING );
        exit;
      end;

    // Pesquisa por numero requer que apenas um tipo de lei esteja selecionado
    TiposLeiSelecionados := '';
    CondicaoSelecaoSubNode := '';

    if PesquisaSelecionada = TP_Numero then
      begin
        TextoPesquisa := Trim(TxtPesquisa.Text);

        TextoPesquisa := ReplaceStr(TextoPesquisa, '.', '');
        TextoPesquisa := ReplaceStr(TextoPesquisa, ',', '');

        if not isnumeric(TextoPesquisa) then
          begin
            MessageBox(Self.Handle, 'Número inválido, deve ser informado apenas o número da lei', 'LexMaximus', MB_OK OR MB_ICONWARNING );
            exit;
          end;

        CodigoTipoLei := -1;
        TotalSelecionados := 0;
        Q := Trv.RootNodeCount-1;
        node := Trv.RootNode.FirstChild;

        for I := 0 to q do
          begin
            if node.CheckState = csCheckedNormal then
              begin
                inc ( TotalSelecionados,1);

                Data := Trv.GetNodeData(node);
                CodigoTipoLei := Data.Codigo;

              end;

            node := node.NextSibling;
          end;

        if TotalSelecionados =0 then
          begin
            MessageBox(Self.Handle, 'Você deve selecionar um tipo de lei para fazer a pequisa por número', 'LexMaximus', MB_OK OR MB_ICONWARNING );
            exit;
          end;
        if TotalSelecionados <> 1 then
          begin
            MessageBox(Self.Handle, 'Apenas um tipo de lei pode ser selecionado na pequisa por número', 'LexMaximus', MB_OK OR MB_ICONWARNING );
            exit;
          end;
        PesquisaSelecionadaBrowser := TP_Nenmhum;
        PesquisaAtivada := True;
        Application.ProcessMessages;
        Pesquisa_Por_Numero(CodigoTipoLei);
      end
    else
      begin

        Q := Trv.RootNodeCount-1;
        node := Trv.RootNode.FirstChild;

        for I := 0 to q do
          begin
            Data := Trv.GetNodeData(node);
            if node.CheckState = csCheckedNormal then
              begin
                TiposLeiSelecionados := TiposLeiSelecionados + IntToStr(Data.Codigo) + ', ';
              end
            else
              begin
                Condicao2 := '';
                SubNodesSelecionados := VerificaSubNodesSelecionados(Node, Condicao2);

                if SubNodesSelecionados = '' then
                  begin
                    if Condicao2 <> '' then
                      begin
                      
                        if CondicaoSelecaoLei <> '' then
                          CondicaoSelecaoLei := CondicaoSelecaoLei +  ', ';

                        CondicaoSelecaoLei := CondicaoSelecaoLei + Condicao2 ;

                      end
                    else
                      begin
                        LeisSelecionadas := VerificaLeisSelecionadas(Node);

                        if LeisSelecionadas <> '' then
                          begin
                            if CondicaoSelecaoLei <> '' then
                              CondicaoSelecaoLei := CondicaoSelecaoLei +  ', ';

                            CondicaoSelecaoLei := CondicaoSelecaoLei + LeisSelecionadas;
                          end;
                      end;

                  end
                else
                  begin
                    if CondicaoSelecaoSubNode <> '' then
                      CondicaoSelecaoSubNode := CondicaoSelecaoSubNode + 'OR ';
                      
                    CondicaoSelecaoSubNode := CondicaoSelecaoSubNode + ' ( TipoLei = ' + IntToStr(Data.Codigo) ;
                    CondicaoSelecaoSubNode := CondicaoSelecaoSubNode + ' And Ano in (' + SubNodesSelecionados +  ') ) ';
                  end;

              end;

            node := node.NextSibling;
          end;
        if (TiposLeiSelecionados = '') and (CondicaoSelecaoSubNode = '' ) and (CondicaoSelecaoLei = '' ) then
          begin
              MessageBox(Self.Handle, 'Você deve selecionar pelo menos um tipo de lei, ano ou lei', 'LexMaximus', MB_OK OR MB_ICONWARNING );
              exit;
          end;

        if TiposLeiSelecionados <> '' then
          TiposLeiSelecionados := Copy(TiposLeiSelecionados, 1, Length(TiposLeiSelecionados)-2);
      end;

     FormaPesquisaAtual := FP_ListaLeis;

    //Palavra chave
    if PesquisaSelecionada = TP_Frase then
      begin
        PesquisaSelecionadaBrowser := TP_Nenmhum;
        PesquisaAtivada := True;
        VisualizaDefault();
        Application.ProcessMessages;
        Pesquisa_Por_PalavraChave(TiposLeiSelecionados , CondicaoSelecaoSubNode , CondicaoSelecaoLei);
      end;

    if PesquisaSelecionada = TP_E then
      begin
        PesquisaSelecionadaBrowser := TP_Nenmhum;
        PesquisaAtivada := True;
        VisualizaDefault();
        Application.ProcessMessages;
        Pesquisa_E(TiposLeiSelecionados , CondicaoSelecaoSubNode , CondicaoSelecaoLei);
      end;

    if PesquisaSelecionada = TP_OU then
      begin
        PesquisaSelecionadaBrowser := TP_Nenmhum;
        PesquisaAtivada := True;
        VisualizaDefault();
        Application.ProcessMessages;
        Pesquisa_OU(TiposLeiSelecionados , CondicaoSelecaoSubNode , CondicaoSelecaoLei);
      end;

  finally

  end;
end;

procedure TFrmPrincipal.BtnCopiarClick(Sender: TObject);
begin
  try
       CopiaConteudoBrowserClipBoard;
  finally

  end;
end;

procedure TFrmPrincipal.BtnHistoricoClick(Sender: TObject);
begin

  VisualizaHistorico();

end;

procedure TFrmPrincipal.BtnNotasClick(Sender: TObject);
begin

  VisualizaNotas();

end;

procedure TFrmPrincipal.BtnIndiceClick(Sender: TObject);
begin
  VisualizaIndice();
end;

procedure TFrmPrincipal.BtnImprimirClick(Sender: TObject);
begin
  ImprimeConteudoBrowser;

end;

procedure TFrmPrincipal.BtnVerificarArquivosClick(Sender: TObject);
var
  lei : TRul_Lei;
  rcd : TSQLQuery;
  ArqHTML : TStringList;
  ArqIndice : TStringList;


  NomeArquivo : String;
  ArquivoHTML : String;
  ArquivoIndice : String;


begin

  ArqHTML := TStringList.Create();
  ArqIndice := TStringList.Create();

  lei := TRul_Lei.Create();

  rcd := lei.GetAll();

  while not rcd.Eof do
    begin

      NomeArquivo := rcd.FieldByName('Link').AsString;
      NomeArquivo := Copy( NomeArquivo, 1 , Length(NomeArquivo)-4);

      ArquivoHTML := DiretorioHTML + '\' + NomeArquivo + 'lmcf';
      ArquivoIndice := GetCurrentDir() + '\indices\' + NomeArquivo + 'dat';

      if not FileExists(ArquivoHTML)  then
          ArqHTML.Add(rcd.FieldByName('ano').AsString + chr(9) + NomeArquivo + 'lmcf' );

      if not FileExists(ArquivoIndice)  then
          ArqIndice.Add(rcd.FieldByName('ano').AsString + chr(9) + NomeArquivo + 'dat' );


      rcd.Next();

      Application.processmessages();
    end;

  ArqHTML.SaveToFile('HTML_Nao_Encontrado.txt');
  ArqIndice.SaveToFile('Indice_Nao_Encontrado.txt');

  MessageBox ( Self.Handle , 'Verificação concluida', '' , MB_OK);




end;

procedure TFrmPrincipal.BtnVoltarHistoricoClick(Sender: TObject);
begin
  VoltarHistorico;
end;

procedure TFrmPrincipal.BtnVoltarIndiceClick(Sender: TObject);
begin

  VisualizaIndice();
  
end;

procedure TFrmPrincipal.Btn_DividirBrowserClick(Sender: TObject);
begin
    Btn_DividirBrowser.Enabled := False;
    Btn_ExtenderBrowser.Enabled := True;

    PnlDireitaInferior.Height := Height_DireitaInferior;

end;

procedure TFrmPrincipal.Btn_ExtenderBrowserClick(Sender: TObject);
begin

    Btn_DividirBrowser.Enabled := True;
    Btn_ExtenderBrowser.Enabled := False;

    Height_DireitaInferior := PnlDireitaInferior.Height ;

    PnlDireitaInferior.Height := 1;

    ScrLista.Visible := False;

    AjustaScrollBrowser();

end;

procedure TFrmPrincipal.Btn_ExtenderListaPesquisaClick(Sender: TObject);
begin

    Height_DireitaInferior := PnlDireitaInferior.Height ;

    PnlDireitaInferior.Height := PnlBrowserListaPesquisa.Height;

    Btn_DividirListaPesquisa.Enabled := True;
    Btn_ExtenderListaPesquisa.Enabled := False;

end;

procedure TFrmPrincipal.Btn_DividirListaPesquisaClick(Sender: TObject);
begin

    PnlDireitaInferior.Height := Height_DireitaInferior;

    Btn_DividirListaPesquisa.Enabled := False;
    Btn_ExtenderListaPesquisa.Enabled := True;

    (**************************************************
    Btn_DividirListaPesquisa.Enabled := False;
    Btn_ExtenderListaPesquisa.Enabled := True;

    ImgBordaInferiorDireita.Align := alNone;
    PnlDireitaSuperior.Align := alNone;
    SplDivisaoDireita.Align := alNone;
    PnlDireitaInferior.Align := alNone;

    PnlDireitaSuperior.Height := 460;

    SplDivisaoDireita.Visible := True;
    SplDivisaoDireita.Enabled := true;

    PnlDireitaInferior.Height := 260;

    PnlDireitaSuperior.Align := AlTop;

    ImgBordaInferiorDireita.Align := alBottom;
    PnlDireitaInferior.Align := alBottom;
    SplDivisaoDireita.Align := alBottom;

    PnlDireitaSuperior.Align := alClient;

    PnlDireitaSuperior.Visible := True;

    Application.ProcessMessages;

    ScrLista.Visible := True;
    PnlDireitaInferior.Repaint;

    **************************************************)

    AjustaScrollBrowser();
    AjustaScrollLista();



end;

procedure TFrmPrincipal.Btn_FecharPesquisaClick(Sender: TObject);
begin
    PesquisaAtivada := False;

    if ListaPalavrasSelecao <> nil then
      ListaPalavrasSelecao.Clear;

    FraseSelecao := '';  

    if not PnlDireitaSuperior.Visible then
      begin

        Btn_DividirBrowser.Visible := false;
        Btn_ExtenderBrowser.Visible := false;

        PnlPesquisaBrowserResize(PnlPesquisaBrowser);
              
        PnlDireitaSuperior.Visible := True;
        Btn_ExtenderBrowserClick(Btn_ExtenderBrowser);

        VisualizaTextoLei(TipoLeiAtual, NomeLeiAtual, CodigoLeiAtual, PublicacaoAtual , False, False);
        
      end;
    

    Lst.Items.Clear;

    LblQuantidadeOcorrencias.Visible := false;
    LblTituloResultadosPesquisa.Visible := false;

    ListaPalavrasSelecao.Clear;
    PnlDireitaInferior.Visible := False;
    SplDivisaoDireita.Visible := False;

    AjustaControlesDireita();

end;

{$ENDREGION}

{$REGION 'Eventos dos outros componentes'}

procedure TFrmPrincipal.PnlBannerResize(Sender: TObject);
begin

  ImgBanner2.left := trunc((PnlBanner.Width - ImgBanner2.Width )/2);

end;

procedure TFrmPrincipal.PnlBordaLateralDireitaResize(Sender: TObject);
begin

  AjustaScrollBrowser();

end;

procedure TFrmPrincipal.PnlDireitaInferiorResize(Sender: TObject);
var
  Inicio    : integer;
  Fim       : Integer;
  W         : integer;

begin

  Inicio := Btn_FecharPesquisa.Left + Btn_FecharPesquisa.Width;
  Fim := BtnLayOut2.Left;

  //w := PnlDireitaInferior.Width - BtnLayOut2.Left;
  w := Fim - Inicio;

  LblTituloResultadosPesquisa.Left :=  Trunc((w - LblTituloResultadosPesquisa.Width )/2) + LblQuantidadeOcorrencias.Width;
  LblQuantidadeOcorrencias.Left := LblTituloResultadosPesquisa.Left - LblQuantidadeOcorrencias.Width - 10; 

end;

procedure TFrmPrincipal.PnlDireitaSuperiorResize(Sender: TObject);

var
  Inicio : integer;
  Fim : Integer;
  //w : integer;
begin
  BtnAvancarHistorico.Left := Browser.Width - BtnAvancarHistorico.Width - 10;
  BtnVoltarHistorico.Left := BtnAvancarHistorico.Left - BtnAvancarHistorico.Width - 10;

  Inicio := Lbl_ExcluirNota.Left + Lbl_ExcluirNota.Width;
  Fim := BtnVoltarHistorico.Left;

  //W := Fim - Inicio;

  Lbl_NomeLei.left := Inicio ;
  Lbl_NomeLei.Width :=  Fim - Inicio;

  AjustaScrollBarBrowser();
end;

procedure TFrmPrincipal.PnlPesquisaBrowserResize(Sender: TObject);
var
InicioOpcoes: Integer;

begin

    if not PnlPesquisaBrowser.Visible then
      exit;

    Lbl_Titulo_Busca_Documento.Left := Trunc((PnlPesquisaBrowser.Width  -Lbl_Titulo_Busca_Documento.Width)/2) ;
    TxtPesquisaBrowser.Left := Trunc((PnlPesquisaBrowser.Width  -TxtPesquisaBrowser.Width)/2) ;
    BtnBuscarBrowser.Left := TxtPesquisaBrowser.Left + TxtPesquisaBrowser.Width + 10;

    InicioOpcoes := TxtPesquisaBrowser.Left + 30;
    Chk_Artigo_Browser.Left := InicioOpcoes;
    Lbl_Artigo_Browser.Left := Chk_Artigo_Browser.Left + Chk_Artigo_Browser.Width  + 3;

    Chk_Busca_E_Browser.Left := Lbl_Artigo_Browser.Left + Lbl_Artigo_Browser.Width + 10;
    Lbl_Busca_E_Browser.Left := Chk_Busca_E_Browser.Left + Chk_Busca_E_Browser.Width + 3;

    Chk_Busca_OU_Browser.Left := Lbl_Busca_E_Browser.Left + Lbl_Busca_E_Browser.Width + 10;
    Lbl_Busca_OU_Browser.Left := Chk_Busca_OU_Browser.Left + Chk_Busca_OU_Browser.Width + 3;

    Chk_Busca_Frase_Browser.Left := Lbl_Busca_OU_Browser.Left + Lbl_Busca_OU_Browser.Width + 10;
    Lbl_Busca_Frase_Browser.Left := Chk_Busca_Frase_Browser.Left + Chk_Busca_Frase_Browser.Width + 3;

    // Posicionando os botoes de layout
    if (Btn_DividirBrowser.Visible = false) and (Btn_ExtenderBrowser.Visible = false) then
      begin
        BtnLayOut.Left := PnlPesquisaBrowser.Width - BtnLayOut.Width - 20;
      end
    else
      begin
        Btn_ExtenderBrowser.Left := PnlPesquisaBrowser.Width - Btn_ExtenderBrowser.Width - 5;
        Btn_DividirBrowser.Left := Btn_ExtenderBrowser.left - Btn_DividirBrowser.Width - 5;
        BtnLayOut.Left := Btn_DividirBrowser.left - BtnLayOut.Width - 5;

      end;

    // Botoes de navegacao
    Lbl_Palavra_Encontrada.Left := PnlPesquisaBrowser.Width - Lbl_Palavra_Encontrada.Width - 13;
    BtnAvancarPalavra.Left := PnlPesquisaBrowser.Width - BtnAvancarPalavra.Width - 22;
    BtnRetrocederPalavra.Left := BtnAvancarPalavra.Left - BtnRetrocederPalavra.Width - 5;

    

end;

procedure TFrmPrincipal.PnlSuperiorMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
EscondeHint();
end;

procedure TFrmPrincipal.TxtPesquisaBrowserKeyPress(Sender: TObject; var Key: Char);
begin

  if key = chr(13) then
    begin
      BtnBuscarBrowserClick(BtnBuscar);
    end;
    
end;

procedure TFrmPrincipal.TxtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin

  if key = chr(13) then
    begin
      BtnBuscarClick(BtnBuscar);
    end;
    
end;

procedure TFrmPrincipal.BitBtn1Click(Sender: TObject);
begin
 /// Browser2.Visible := not Browser2.Visible;

end;

procedure TFrmPrincipal.BrowserKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin

  if Key = VK_CONTROL then
    TeclaControlBrowser := True;

    
  if (TeclaControlBrowser) and (Key = VK_HOME) then
    begin
      Browser.ScrollTo(0);
    end;

  if TeclaControlBrowser and (Key = VK_END) then
    begin
      Browser.ScrollTo( Browser.VScrollBar.Max );

    end;

end;

procedure TFrmPrincipal.BrowserKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin

  if Key = VK_CONTROL then
    TeclaControlBrowser := False;
    
  if (Key = VK_LEFT) or (Key = VK_RIGHT) then
    Trv.SetFocus;

end;

procedure TFrmPrincipal.BrowserMouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
begin
  EscondeHint();
end;

procedure TFrmPrincipal.Lbl_ExcluirNotaClick(Sender: TObject);
begin
  ExcluiNota();
end;

procedure TFrmPrincipal.Lbl_IncluirAlterarNotaClick(Sender: TObject);
begin
  IncluiAlteraNota();
end;

procedure TFrmPrincipal.SplDivisaoDireitaMoved(Sender: TObject);
begin
  AjustaScrollBrowser();
  AjustaScrollLista();

end;

procedure TFrmPrincipal.ImgBanner2Click(Sender: TObject);
var
  link : String;

begin

  Link := '';

  if OrigemBanner = TO_Local then
    Link := Configuracoes.ListaLinkLocal[IndiceBanner]
  else
    if OrigemBanner = TO_Internet then
      Link := Configuracoes.ListaLinkInternet[IndiceBanner];

  if Link <> '' then
    begin
      ShellExecute(Self.Handle,'open', PAnsiChar(Link) , '', '', SW_SHOW );
      
    end;
end;

procedure TFrmPrincipal.ImgBannerPrincipalClick(Sender: TObject);
begin
  //ShellExecute(Self.Handle,'open', PAnsiChar('http://www.elfez.com.br') , '', '', SW_SHOW );
  ShellExecute(Self.Handle, 'open', 'http://www.elfez.com.br', nil, nil, SW_SHOWNORMAL);
end;

procedure TFrmPrincipal.ImgDireitaMeioMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
EscondeHint();
end;

procedure TFrmPrincipal.ImgPesquisaBrowserMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
  EscondeHint();
end;

procedure TFrmPrincipal.TimerAtualizacoesTimer(Sender: TObject);
begin
  if ErroInstalacao OR AcessoImpedido then
    begin
      TimerAtualizacoes.Enabled := False;
      exit;
    end;

  TimerAtualizacoes.Enabled := False;
  TimerAtualizacoes.Interval := 0 ;

  PnlConexaoBancoDados.Left := (Self.Width -PnlConexaoBancoDados.Width) div 2;
  PnlConexaoBancoDados.top  := ( self.Height - PnlConexaoBancoDados.Height) div 2;
  
  PnlConexaoBancoDados.Visible := True;
  Application.ProcessMessages;

  VerificaAtualizacoesAutomaticas();
  PnlConexaoBancoDados.Visible := False;
end;

procedure TFrmPrincipal.TmrExibicaoBannerTimer(Sender: TObject);
begin

  AlternaExibicaoBanner;

end;

procedure TFrmPrincipal.TmrToolTipTimer(Sender: TObject);
begin
  EscondeDicaOcorrencias();
end;

procedure TFrmPrincipal.TmrVerificacaoTimer(Sender: TObject);
begin

end;

{$ENDREGION}

{$REGION 'Eventos para simular os CheckBox de busca na legislação'}

procedure TFrmPrincipal.Chk_Busca_EClick(Sender: TObject);
begin

  SelecionaOpcaoPesquisa(TP_E);

end;

procedure TFrmPrincipal.Chk_Busca_FraseClick(Sender: TObject);
begin
  SelecionaOpcaoPesquisa(TP_Frase);
end;

procedure TFrmPrincipal.Chk_Busca_OUClick(Sender: TObject);
begin
  SelecionaOpcaoPesquisa(TP_OU);
end;

procedure TFrmPrincipal.Chk_NumeroClick(Sender: TObject);
begin

  SelecionaOpcaoPesquisa(TP_Numero);

end;

procedure TFrmPrincipal.Chk_Selecionar_TudoClick(Sender: TObject);
begin

  if Chk_Selecionar_Tudo_Checked then
    begin
      //
      Lbl_SelecionarTudo.Caption := 'Selecionar tudo';
    end
  else
    begin
      //Chk_Selecionar_Tudo.Picture := Img_CheckBox_Marcado.Picture;
      Lbl_SelecionarTudo.Caption := 'Desmarcar tudo';
    end;

  Chk_Selecionar_Tudo.Picture := Img_CheckBox_Desmarcado.Picture;
  Chk_Selecionar_Tudo_Checked := not Chk_Selecionar_Tudo_Checked;

  MarcaDesmarcaTiposLei( trv.RootNode );
  
end;

procedure TFrmPrincipal.Chk_ExibirDicaBotoesClick(Sender: TObject);
begin
  try
    Configuracoes.ExibirDicaBotoes :=  Chk_ExibirDicaBotoes.Checked;

    Configuracoes.SalvaConfiguracoes();

    EscondeDicaOcorrencias();

  except
  end;
end;

procedure TFrmPrincipal.Chk_Expandir_TudoClick(Sender: TObject);
begin

  if Chk_Expandir_Tudo_Checked then
    begin
      //Chk_Expandir_Tudo.Picture := Img_CheckBox_Desmarcado.Picture;
      Lbl_ExpandirTudo.Caption := 'Expandir tudo';
    end
  else
    begin
      //Chk_Expandir_Tudo.Picture := Img_CheckBox_Marcado.Picture;
       Lbl_ExpandirTudo.Caption := 'Contrair tudo';
    end;

  Chk_Expandir_Tudo.Picture := Img_CheckBox_Desmarcado.Picture;
  Chk_Expandir_Tudo_Checked := not Chk_Expandir_Tudo_Checked;
  
  ExpandindoArvore := True;
  ExpandeContraiArvore( trv.RootNode );
  ExpandindoArvore := false;

   AjustaScrollBarTreeView();

end;

{$ENDREGION}

{$REGION 'Eventos dos CheckBox de Busca no Browser'}

procedure TFrmPrincipal.Chk_Artigo_BrowserClick(Sender: TObject);
begin
  SelecionaOpcaoPesquisaBrowser(TP_Numero);
end;

procedure TFrmPrincipal.Chk_Busca_E_BrowserClick(Sender: TObject);
begin
  SelecionaOpcaoPesquisaBrowser(TP_E);
end;

procedure TFrmPrincipal.Chk_Busca_OU_BrowserClick(Sender: TObject);
begin
  SelecionaOpcaoPesquisaBrowser(TP_OU);
end;

procedure TFrmPrincipal.Chk_Busca_Frase_BrowserClick(Sender: TObject);
begin
  SelecionaOpcaoPesquisaBrowser(TP_Frase);
end;

{$ENDREGION}

{$REGION 'Metodos para ajuste da resolucao'}

procedure TFrmPrincipal.CarregaImagensObjetos();
//var
//Arquivo : String;
begin


  (****************************************************
  Arquivo := DiretorioImagensObjetos;
  Arquivo := Arquivo + '\checkbox\Marcado.gif';
  Img_CheckBox_Marcado.Picture.LoadFromFile(Arquivo);

  Arquivo := DiretorioImagensObjetos;
  Arquivo := Arquivo + '\checkbox\Desmarcado.gif';
  Img_CheckBox_Desmarcado.Picture.LoadFromFile(Arquivo);

  ****************************************************)

  VisualizacaoAtual := TV_Ambos;

  CarregaBitMapsEsquerda();

  (******************************************************************
  Arquivo := DiretorioImagensObjetos + '\BordaLateralBrowser.gif';
  ImgBordaLateralDireita.Picture.LoadFromFile(Arquivo);

  Arquivo := DiretorioImagensObjetos + '\PainelPesquisaBrowser.gif';
  ImgPainelPesquisaBrowser.Picture.LoadFromFile(Arquivo);

  ******************************************************************)

end;

{$ENDREGION}

{$REGION 'Metodos para simular os CheckBox de Busca no Browser'}

Procedure TFrmPrincipal.SelecionaOpcaoPesquisaBrowser (Tipo : TipoPesquisa );
begin
  try
    if Tipo <> TP_Numero  then  DesmarcaOpcaoBrowser(TP_Numero);
    if Tipo <> TP_E       then  DesmarcaOpcaoBrowser(TP_E);
    if Tipo <> TP_OU      then  DesmarcaOpcaoBrowser(TP_OU);
    if Tipo <> TP_Frase   then  DesmarcaOpcaoBrowser(TP_Frase);

    if Tipo = TP_Numero   then  MarcaOpcaoBrowser(TP_Numero);
    if Tipo = TP_E        then  MarcaOpcaoBrowser(TP_E);
    if Tipo = TP_OU       then  MarcaOpcaoBrowser(TP_OU);
    if Tipo = TP_Frase    then  MarcaOpcaoBrowser(TP_Frase);

    PesquisaSelecionadaBrowser := Tipo;

  finally

  end;
end;

procedure TFrmPrincipal.MarcaOpcaoBrowser(Tipo : TipoPesquisa );
begin
  try
     case Tipo of
       TP_Numero:
        Chk_Artigo_Browser.Picture := Img_CheckBox_Marcado.Picture;
       TP_E:
        Chk_Busca_E_Browser.Picture := Img_CheckBox_Marcado.Picture;
       TP_OU:
        Chk_Busca_OU_Browser.Picture := Img_CheckBox_Marcado.Picture;
       TP_Frase:
        Chk_Busca_Frase_Browser.Picture := Img_CheckBox_Marcado.Picture;
     end;

  finally

  end;
end;

procedure TFrmPrincipal.DesmarcaOpcaoBrowser(Tipo : TipoPesquisa );
begin
  try

     case Tipo of
       TP_Numero:
        Chk_Artigo_Browser.Picture := Img_CheckBox_Desmarcado.Picture;
       TP_E:
        Chk_Busca_E_Browser.Picture := Img_CheckBox_Desmarcado.Picture;
       TP_OU:
        Chk_Busca_OU_Browser.Picture := Img_CheckBox_Desmarcado.Picture;
       TP_Frase:
        Chk_Busca_Frase_Browser.Picture := Img_CheckBox_Desmarcado.Picture;
     end;

  finally

  end;
end;

{$ENDREGION}

{$REGION 'Metodos para simular os CheckBox'}

Procedure TFrmPrincipal.SelecionaOpcaoPesquisa (Tipo : TipoPesquisa );
begin
  try
    if Tipo <> TP_Numero  then  DesmarcaOpcao(TP_Numero);
    if Tipo <> TP_E       then  DesmarcaOpcao(TP_E);
    if Tipo <> TP_OU      then  DesmarcaOpcao(TP_OU);
    if Tipo <> TP_Frase   then  DesmarcaOpcao(TP_Frase);

    if Tipo = TP_Numero   then  MarcaOpcao(TP_Numero);
    if Tipo = TP_E        then  MarcaOpcao(TP_E);
    if Tipo = TP_OU       then  MarcaOpcao(TP_OU);
    if Tipo = TP_Frase    then  MarcaOpcao(TP_Frase);

    PesquisaSelecionada := Tipo;

  finally

  end;
end;

procedure TFrmPrincipal.MarcaOpcao(Tipo : TipoPesquisa );
begin
  try
     case Tipo of
       TP_Numero:
        Chk_Numero.Picture := Img_CheckBox_Marcado.Picture;
       TP_E:
        Chk_Busca_E.Picture := Img_CheckBox_Marcado.Picture;
       TP_OU:
        Chk_Busca_OU.Picture := Img_CheckBox_Marcado.Picture;
       TP_Frase:
        Chk_Busca_Frase.Picture := Img_CheckBox_Marcado.Picture;
     end;

  finally

  end;
end;

procedure TFrmPrincipal.DesmarcaOpcao(Tipo : TipoPesquisa );
begin
  try

     case Tipo of
       TP_Numero:
        Chk_Numero.Picture := Img_CheckBox_Desmarcado.Picture;
       TP_E:
        Chk_Busca_E.Picture := Img_CheckBox_Desmarcado.Picture;
       TP_OU:
        Chk_Busca_OU.Picture := Img_CheckBox_Desmarcado.Picture;
       TP_Frase:
        Chk_Busca_Frase.Picture := Img_CheckBox_Desmarcado.Picture;
     end;

  finally

  end;
end;

{$ENDREGION}

{$REGION 'Metodos para posicionamento de controles'}

Function TFrmPrincipal.ObtemResolucaoSistema() : String;

var
  Resolucao : string;

begin
  try
    if (screen.Width >= 1024) or (screen.Height >= 768) then
      begin
        Resolucao := 'sup';
      end
    else
      begin
        if ((screen.Width = 640) and (screen.Height = 480) or (screen.Width = 800) and (screen.Height = 600)  or (screen.Width = 1024) and (screen.Height = 768) ) then
          begin
            Resolucao := IntToStr(Screen.Width) + 'x' + IntToStr(Screen.Height);
          end
        else
          Resolucao := '800x600';
      end;

    ObtemResolucaoSistema := Resolucao;

  except
    Resolucao := '';

  end;
end;

procedure TFrmPrincipal.AjustaControlesTela ();
 begin
      try

        ImgBannerPrincipal.Left := Self.Width - ImgBannerPrincipal.Width - 100;
        ImgBanner2.Left := (PnlDireita.Width - ImgBanner2.Width) div 2;
        AjustaControlesEsquerda();

        AjustaControlesDireita();

      finally

      end;
 end;

procedure TFrmPrincipal.CarregaBitMapsEsquerda();
var
Arquivo : String;

begin

  try

  Arquivo := DiretorioImagensResolucao + '\E01.bmp';
  ImgEsquerdaTopo.Picture.LoadFromFile(Arquivo);

  Arquivo := DiretorioImagensResolucao + '\E02.bmp';
  ImgEsquerdaMeio.Picture.LoadFromFile(Arquivo);

  Arquivo := DiretorioImagensResolucao + '\E03.bmp';
  ImgEsquerdaFundo.Picture.LoadFromFile(Arquivo);

  Arquivo := DiretorioImagensResolucao + '\TV.bmp';
  trv.Background.LoadFromFile(Arquivo);

  trv2.Background.LoadFromFile(Arquivo);

  except
    on ex : exception do
      begin
        MessageBox( Self.Handle, PAnsiChar(Ex.Message), 'LexMaximus', MB_OK or MB_ICONERROR);
        
      end;

  end;

end;

procedure TFrmPrincipal.AjustaControlesEsquerda();

begin

  try
    case VisualizacaoAtual of
      (********************************
      TV_Lista:
        begin

          //PnlEsquerda.Width := Self.Width;
          PnlEsquerda.Width := ImgEsquerdaTopo.Picture.Width;

          trv.Width := PnlEsquerda.Width - 60;
          trv.Height := PnlEsquerda.Height - Trv.Top - 100;

          ScrIndice.Left := Trv.Left + Trv.Width + 10;
          ScrIndice.Top := Trv.Top;
          ScrIndice.Height := Trv.Height;
          ScrIndice.Left := Trv.Left + Trv.Width + 2;
          TxtPesquisa.Width := 200;
        end;
      ********************************)
      TV_Browser:
        begin
          PnlEsquerda.Width := 0;

        end;
      TV_Ambos:
        begin
          if ResolucaoMonitor = '800x600' then
            PnlEsquerda.Width := 265
          else
            PnlEsquerda.Width := 326;

          trv.Width := PnlEsquerda.Width - 50;
          trv.Height := PnlEsquerda.Height - Trv.Top - 100;

          trv2.Left     := Trv.Left;
          Trv2.Top      := Trv.Top;
          Trv2.Width    := Trv.Width;
          trv2.Height   := trv.Height;


          ScrIndice.Left := Trv.Left + Trv.Width + 10;
          ScrIndice.Top := Trv.Top;
          ScrIndice.Height := Trv.Height;
          ScrIndice.Left := Trv.Left + Trv.Width + 2;

          if ResolucaoMonitor = '800x600' then
            TxtPesquisa.Width := 190
          else
            TxtPesquisa.Width := 255;

        end;
    end;


  except

  end;


end;

procedure TFrmPrincipal.AjustaControlesDireita();
begin

    case VisualizacaoAtual of
    (********************************
      TV_Lista:
        begin
          PnlDireita.Width := 0;
          PnlDireita.Visible := False;
          PnlBordaLateralDireita.Visible := False;
        end;
    ********************************)
      TV_Browser:
        begin
          PnlDireita.Width := Self.Width - PnlBordaLateralDireita.Width - 8;
          PnlDireita.Visible := True;
          PnlBordaLateralDireita.Visible := True;

        end;

      TV_Ambos:
        begin

          PnlDireita.Visible := True;
          PnlBordaLateralDireita.Visible := True;
          
        end;

    end;

    PnlDireitaSuperiorResize(PnlDireitaSuperior);

    PnlDireitaInferiorResize(PnlDireitaInferior);

    AjustaScrollBrowser();

    AjustaScrollLista();

end;

Procedure TFrmPrincipal.CaregaPosicaoJanela();
begin

  if configuracoes.WindowState= 'Maximizado' then
    Self.WindowState := wsMaximized
  else
    begin
      if (Configuracoes.Left = -1) then
        Self.WindowState := wsMaximized
      else
        begin
          Self.WindowState := wsNormal;
          self.Left := Configuracoes.Left;
          self.Top := Configuracoes.Top;
          self.Width := Configuracoes.Width;
          if Configuracoes.Height < self.Constraints.MinHeight then
            self.Height := self.Constraints.MinHeight
          else
            self.Height := Configuracoes.Height;
        end;
    end;
end;

Function TFrmPrincipal.RetornaUltimaExecucao(): String;
var
  DiretorioBase : String;
  ArquivoComprimido : String;
  ArquivoDescomprimido : String;
  Conteudo : TStringList;
  Comp : TCompressaoDados;
  item : String;
begin

  try

    DiretorioBase := Configuracoes.RetornaDiretorioAplicacoes();

    ArquivoDescomprimido := DiretorioBase + '\2fk2n.tmp';
    ArquivoComprimido := DiretorioBase + '\ntsysinfo.ldx';

    if not FileExists(ArquivoComprimido) then
      begin
        result := '';
        exit;
      end;

    Comp := TCompressaoDados.Create;  
    Comp.ArquivoComprimido := ArquivoComprimido;
    Comp.ArquivoDescomprimido := ArquivoDescomprimido;
    
    if Comp.DescomprimeArquivo() then
      begin

        Conteudo := TStringList.Create;
        Conteudo.LoadFromFile(ArquivoDescomprimido);

        DeleteFile(ArquivoDescomprimido);

        if Conteudo.Count = 0 then
          begin
            result := 'ERRO';
            exit;
          end;

        item := Conteudo[0];
        FreeAndNil(Conteudo);

        if not isDate(item) then
          begin
            result := 'ERRO';
            exit;
          end;

        result := Item;
      end
    else
      begin
        result := 'ERRO';
        exit;
      end;


  except
    on ex : Exception do
      begin
        MessageBox( Self.Handle , PAnsiChar(ex.Message) , PAnsiChar(self.Caption), MB_OK);
        result := 'ERRO';
      end;

  end;

end;

Procedure TFrmPrincipal.SalvaDataUltimaExecucao();
var
  DiretorioBase : String;
  ArquivoComprimido : String;
  ArquivoDescomprimido : String;
  Conteudo : TStringList;
  Comp : TCompressaoDados;
begin

  try

    DiretorioBase := configuracoes.RetornaDiretorioAplicacoes();

    ArquivoDescomprimido := DiretorioBase + '\13423.234234';
    ArquivoComprimido := DiretorioBase + '\ntsysinfo.ldx';

    Conteudo := TStringList.Create;

    Conteudo.Add(FormatDateTime('dd/mm/yyyy', now));

    Conteudo.SaveToFile(ArquivoDescomprimido);
    FreeAndNil(Conteudo);

    Comp := TCompressaoDados.Create;

    Comp.ArquivoDescomprimido := ArquivoDescomprimido;
    Comp.ArquivoComprimido := ArquivoComprimido;

    Comp.ComprimeArquivo;

    DeleteFile(ArquivoDescomprimido);
  except
    on ex : Exception do
      begin
        MessageBox( Self.Handle , PAnsiChar(ex.Message) , PAnsiChar(self.Caption), MB_OK);
      end;

  end;

end;


Procedure TFrmPrincipal.SalvaPosicaoJanela();
begin

  Configuracoes.Left := Self.Left;
  Configuracoes.Top := Self.Top;
  Configuracoes.Width := Self.Width;
  Configuracoes.Height := Self.Height;
  if (Self.WindowState = wsMaximized) then
    Configuracoes.WindowState:= 'Maximizado'
  else
    Configuracoes.WindowState:= 'Normal';

end;

Procedure TFrmPrincipal.AjustaScrollBrowser();
begin

    ScrBrowser.Top := Browser.Top + ImgDireitaTopo.Height;
    ScrBrowser.Height := Browser.Height;
    ScrBrowser.Repaint;

end;

Procedure TFrmPrincipal.AjustaScrollLista();
begin

    ScrLista.Top := ScrBrowser.Top + ScrBrowser.Height  + PnlDireitaMeio.Height + 5;
    ScrLista.Height := Lst.Height;
    ScrLista.Repaint;

end;

{$ENDREGION}

{$REGION 'Metodos para realizacao das pesquisas'}

function TFrmPrincipal.VerificaSubNodesSelecionados(Node : PVirtualNode ; Var Condicao2 : String) : String;
var
  retorno : String;
  I       : Integer;
  Q       : Integer;
  Data    : PTreeData;
  N       : PVirtualNode;
  TipoLei : Integer;
  
begin
  retorno := '';

  Q := Node.ChildCount-1;
  N := Node.FirstChild;

  for I := 0 to q do
    begin
      if N.CheckState = csCheckedNormal then
        begin

          Data := Trv.GetNodeData(N);

          //Achiles: 04/01/2010
          // Tipo de lei < que 7 esta agrupado por ano
          // demais tipos não estao...

          TipoLei := Data^.TipoLei;

          if (TipoLei < 7) or (TipoLei < 10) then
            retorno := retorno + '''' + Data^.Texto + ''','
          else
            Condicao2 := Condicao2 + IntToStr(Data^.Codigo)  + ' ,'

        end;
      N := N.NextSibling;
    end;

  retorno := Copy(retorno, 1 , Length(retorno)-1);

  if condicao2 <> '' then
    condicao2 := Copy(condicao2, 1 , Length(condicao2)-1);

  result := retorno;

end;

function TFrmPrincipal.VerificaLeisSelecionadas(Node : PVirtualNode) : String;
var
  Retorno     : String;
  ListaLeis   : String;
  I           : Integer;
  Q           : Integer;
  //Data        : PTreeData;
  N           : PVirtualNode;

  I2          : Integer;
  Q2          : Integer;
  Data2       : PTreeData;
  N2          : PVirtualNode;


begin
  try

    retorno := '';

    Q := Node.ChildCount-1;
    N := Node.FirstChild;

    for I := 0 to q do
      begin
        ListaLeis := '';

        if N.FirstChild <> nil then
          begin

            N2 := N.FirstChild;
            Q2 := Node.ChildCount-1;

            for I2 := 0 to q2 do
              begin
                if N2.CheckState = csCheckedNormal then
                  begin

                    Data2 := Trv.GetNodeData(N2);

                    if Data2 <> nil then
                      ListaLeis := ListaLeis + IntToStr( Data2^.Codigo ) + ' ,';
                  end;
                if N2.NextSibling = nil then
                  break;
                N2 := N2.NextSibling;
              end;

            if ListaLeis <> '' then
              Retorno := Retorno + ListaLeis;

            if N.NextSibling = nil then
              continue;
          end;

        N := N.NextSibling;
      end;

    retorno := Copy(retorno, 1 , Length(retorno)-1);

    result := retorno;
  except
    on ex : Exception do
      begin
        messagebox ( Self.Handle , PAnsiChar(Ex.Message) , '' , MB_OK);
      end;

  end;

end;

procedure TFrmPrincipal.CriaColunasListaPesquisa();
var
  col : TListColumn;
begin
  try

    col := Lst.Columns.Add();
    col.Caption:= 'Codigo';
    col.Width := 1;
    col.MaxWidth :=1;
    col.MinWidth :=1;

    col := Lst.Columns.Add();
    col.Caption:= 'Ocorrência (lei ou decreto)';
    col.Width := 180;

    col := Lst.Columns.Add();
    col.Caption:= 'Ano';
    col.Width := 120;

    col := Lst.Columns.Add();
    col.Caption:= 'Publicação';
    col.Width := 200;

    col := Lst.Columns.Add();
    col.Caption:= 'Ementa';
    col.Width := 300;

    col := Lst.Columns.Add();
    col.Caption:= 'Número';
    col.Width := 100;

    col := Lst.Columns.Add();
    col.Caption:= 'Lei';
    col.Width := 0;
    col.MaxWidth :=1;
    col.MinWidth :=0;

    col := Lst.Columns.Add();
    col.Caption:= 'TipoLei';
    col.Width := 0;
    col.MaxWidth :=1;
    col.MinWidth :=0;

  except
    on ex : exception do
      begin

      end;

  end;

end;

Function TFrmPrincipal.VerificaExistenciaPalavras(var ListaCodigos : TStringList; Tipo : TipoPesquisa ) : String;
var
  I             : Integer;
  Q             : Integer;
  Indice        : Integer;
  Retorno       : String;
  TextoPesquisa :  String;
  ListaFrase    : String;
  CodigoHexa    : String;
  palavra      : String;
  registro : TRul_PalavraLexMaximus;

begin

   TextoPesquisa := trim(TxtPesquisa.Text);

  Retorno := '';

  ListaPalavrasSelecao.Clear;

  ListaFrase := '';

  if Tipo <> TP_Frase then
    begin

      TextoPesquisa := StringReplace(TextoPesquisa , ' de ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' das ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' dos ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' da ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' do ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' por ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' para ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' as ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' os ' , ' '  , [rfReplaceAll, rfIgnoreCase]);

      TextoPesquisa := StringReplace(TextoPesquisa , ' a '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' e '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' i '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' o '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' u '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' ou ' , ' '  , [rfReplaceAll, rfIgnoreCase]);

    end;

      TextoPesquisa := trim(AnsiLowerCase( TextoPesquisa) );

      while Pos('  ', TextoPesquisa) > 0 do
        TextoPesquisa := ReplaceStr( TextoPesquisa, '  ', '' );

      TextoPesquisa := trim(TextoPesquisa);

      if TextoPesquisa = '' then
        begin
          Result := 'xx';
          exit;
        end;

      Split(' ',  TextoPesquisa , ListaPalavrasSelecao);
      FraseSelecao := TextoPesquisa;

      Q := ListaPalavrasSelecao.Count-1;

      for I := 0 to Q do
        begin

          palavra := AnsiLowerCase(  ListaPalavrasSelecao[i]);
          registro := TRul_PalavraLexMaximus.Create (palavra);
          if registro.NovoRegistro then
            Indice := -1
          else
            Indice := registro.PalavraLexMaximus;
          registro.Destroy();
          
          if Indice >=0 then
            begin
              CodigoHexa := '{' + IntToHex(  Indice , 1 )  + '}';

              if Tipo = TP_Frase then
                ListaFrase := ListaFrase + CodigoHexa
              else
                ListaCodigos.Add( CodigoHexa );
                
            end
          else
            begin
              Retorno := Retorno + ListaPalavrasSelecao[i] + ' ';
            end;
          Application.ProcessMessages;
        end;

  if Tipo = TP_Frase then
    begin
        ListaCodigos.Clear();
        ListaCodigos.Add(ListaFrase);
    end;
  Result := Retorno;
  
end;

Function TFrmPrincipal.VerificaPalavrasTextoLei(Link : String; ListaCodigos: TStringList ; Tipo : TipoPesquisa ) : Boolean;
var
  Arquivo : String;
  Conteudo : TStringList;
  TextoConteudo : String;
  I : Integer;
  Q : Integer;
  Achou : Boolean;
  Palavras: String;
begin

  Arquivo := GetCurrentDir() + '\Indices\' + Link;
  Arquivo := Copy(Arquivo,1, Length(Arquivo)-4);
  Arquivo := Arquivo + 'dat';

  if not FileExists(Arquivo) then
    begin
      result := false;
      exit;
    end;

  Conteudo := TStringList.Create;

  Conteudo.LoadFromFile(Arquivo);
  TextoConteudo := Conteudo.Text;

  TextoConteudo := ReplaceStr(TextoConteudo, chr(10) , '');
  TextoConteudo := ReplaceStr(TextoConteudo, chr(13) , '');
  TextoConteudo := Trim(TextoConteudo);

  if TextoConteudo = '' then
    TextoConteudo := '   ';

  Result := False;
  
  if Tipo = TP_E then
    begin
      Q := ListaCodigos.Count-1;
      Achou := True;

      for I := 0 to Q do
        begin
          if Not AnsiContainsText(TextoConteudo, ListaCodigos[i]) then
            begin
              Achou := False;
              break;
            end;
          Application.ProcessMessages;
        end;
      Result := Achou;
      exit;
    end;

  if Tipo = TP_OU then
    begin
      Q := ListaCodigos.Count-1;
      Achou := False;

      for I := 0 to Q do
        begin
          if AnsiContainsText(TextoConteudo, ListaCodigos[i]) then
            begin
              Achou := True;
              break;
            end;
          Application.ProcessMessages;
        end;
      Result := Achou;
      exit;
    end;

  if Tipo = TP_Frase then
    begin
      Achou := False;

      Palavras := ListaCodigos[0]; //ListaPalavrasSelecao[0];
      
      if AnsiContainsText(TextoConteudo, Palavras) then
        Achou := True;

      Result := Achou;
      exit;
    end;

end;

procedure TFrmPrincipal.CriaListaPesquisa();
begin

  (*********************************)
  Lst.Align := alClient;

  Lst.GridLines   := true;
  Lst.ReadOnly    := true;
  Lst.RowSelect   := true;
  Lst.ViewStyle   := vsReport;

  Lst.Left        := 0;
  Lst.Top         :=0;
  Lst.Width       := PnlDireitaInferior.Width;
  Lst.Height      := PnlDireitaInferior.Height;
  Lst.Font.Color :=  $0000AE;// clred;
  (*********************************)

end;

procedure TFrmPrincipal.AjustaScrollBarLista();
begin

      ScrLista.Enabled := True;

      ScrLista.Min :=1;
      if Lst.Items.Count=0 then
        ScrLista.Min :=2
      else
        ScrLista.Max := Lst.Items.Count;

      ScrLista.Position := 1;
      ScrLista.Repaint;

end;

procedure TFrmPrincipal.VisualizaPainelPesquisa();
begin

  PnlDireitaInferior.Visible := true;
  SplDivisaoDireita.Visible := True;
  ScrLista.Visible := True;

  AjustaControlesDireita();
  Application.ProcessMessages;
  Lst.Width := PnlDireitaInferior.Width;
  Lst.Refresh;
  Lst.Repaint;
  Application.ProcessMessages;

end;

procedure TFrmPrincipal.EscondePainelPesquisa();
begin

  PnlDireitaInferior.Visible := False;
  ScrLista.Visible := False;

  AjustaControlesDireita();
  Application.ProcessMessages;

end;

procedure TFrmPrincipal.Pesquisa_Por_Numero(CodigoTipoLei: integer);

var
  Lei : TRul_Lei;
  TextoPesquisa : String;
  NumeroLei : integer;
  Rcd : TSQLQuery;
  Li : TListItem;

begin
  try
    Lei := TRul_Lei.create();

    Lst.Items.clear;
    LblQuantidadeOcorrencias.Visible := false;
    LblTituloResultadosPesquisa.Visible := false;

    CriaListaPesquisa();

    if Lst.Columns.Count=0 then
      CriaColunasListaPesquisa();

    TextoPesquisa := Trim(TxtPesquisa.Text);

    TextoPesquisa := ReplaceStr(TextoPesquisa, '.', '');
    TextoPesquisa := ReplaceStr(TextoPesquisa, ',', '');

    NumeroLei := StrToInt(TextoPesquisa);
    Rcd := Lei.RetornaLeiPeloNumero(NumeroLei, CodigoTipoLei);

    Lst.Items.Clear;

    if Rcd.Eof then
      begin
        Rcd.Close;
        FreeAndNil(Lei);
        MessageBox(Self.Handle, 'Não foi encontrada a lei com este número dentro do tipo de lei selecionado', 'LexMAxiumus' , MB_OK or MB_ICONWARNING );
        exit;
      end
    else
      begin
        VisualizaPainelPesquisa();

        while not rcd.Eof do
          begin
            Li := TListItem.Create(Lst.Items);

            Li.SubItems.Add(trim(rcd.FieldByName('Nome').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Ano').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Publicacao').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Ementa').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('NumeroLei').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Lei').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('TipoLei').AsString));

            Lst.Items.AddItem(LI);

            Application.ProcessMessages;
            rcd.Next;
          end;
        Rcd.Close;
        FreeAndNil(Lei);
        LblQuantidadeOcorrencias.Caption := ' ';
        LblTituloResultadosPesquisa.Caption := 'Clique na norma para exibir o texto acima';

        LblQuantidadeOcorrencias.Visible := true;
        LblTituloResultadosPesquisa.Visible := true;

        PnlDireitaInferiorResize(PnlDireitaInferior);
        Application.ProcessMessages;
        
        Lst.Invalidate ;
        AjustaScrollBarLista();
        Application.ProcessMessages;

      end;

  Except
    On ex : exception do
      begin
        MessageBox(self.Handle, PAnsiChar(ex.Message), 'LexMaximus', MB_OK or MB_ICONERROR);
      end;

  end;
end;

procedure TFrmPrincipal.Pesquisa_E(TiposLeiSelecionados : String ;  CondicaoSubNodes : String ; CondicaoLeis : String);
var
  Lei                       : TRul_Lei;
  Rcd                       : TSQLQuery;
  Li                        : TListItem;
  ListaCodigos              : TStringList;
  PalavrasNaoEncontradas    : String;
  Frm                       : TFrmAndamento;
  TotalEncontrados          : Integer;
  ItensEncontrados          : Integer;
  TituloLei                 : String;


begin
  try

    ListaCodigos := TStringList.Create;

    PalavrasNaoEncontradas := VerificaExistenciaPalavras(ListaCodigos , TP_E);

    if PalavrasNaoEncontradas= 'xx' then
      begin
        MessageBox ( Self.Handle, 'Informe uma expressão válida para pesquisa', 'LexMaximus', MB_OK or MB_ICONWARNING);
        exit;
      end;

    if PalavrasNaoEncontradas<>'' then
      begin
        MessageBox(Self.Handle, PAnsiChar('Palavra não encontrada =' + PalavrasNaoEncontradas) , 'LexMaximus', MB_OK or MB_ICONWARNING);
        exit;
      end;

    CriaListaPesquisa();

    if Lst.Columns.Count=0 then
      CriaColunasListaPesquisa();

     Lst.Items.Clear;

    Frm := TFrmAndamento.Create(self);
    Frm.Progresso.Visible := false;
    Frm.ProcessoCancelado := false;
    Frm.CorFundo := Configuracoes.CorFundo;
    Frm.CorFonte := clWhite;

    Frm.Show;
    Windows.SetParent(Frm.Handle , Self.Handle );

    Frm.AtualizaAndamento('Pesquisando no banco de dados de legislações'  );
    Frm.IniciaAnimacao();
    Application.ProcessMessages;

    Screen.Cursor := crHourGlass;
    Lei := TRul_Lei.create(-1);
    Rcd := Lei.RetornaLeiPeloTipoLei(TiposLeiSelecionados , CondicaoSubNodes , CondicaoLeis , ListaCodigos , 1 );

    if Rcd = nil then
      begin
        Mensagem('Erro na pesquisa:' + chr(13) + chr(10) + lei.Mensagem , 'Pesquisa'  );
        Frm.Close();
        exit;
      end;

    Screen.Cursor := crDefault;

    if Frm.ProcessoCancelado then
      begin
        Rcd.Close;
        FreeAndNil(Lei);
        MessageBox(Self.Handle, 'Pesquisa cancelada', 'LexMaxiumus' , MB_OK or MB_ICONWARNING );
        frm.Close;
        frm.Destroy;
        exit;
      end;

    if Rcd.Eof then
      begin
        Rcd.Close;
        FreeAndNil(Lei);
        MessageBox(Self.Handle, 'Não foram encontradas leis dentro do(s) tipo(s) de lei selecionado(s)', 'LexMaxiumus' , MB_OK or MB_ICONWARNING );
        frm.Close;
        frm.Destroy;
        exit;
      end
    else
      begin
        Frm.AtualizaAndamento('Exibindo o resultado da pesquisa'  );
        TotalEncontrados := 0;

        while not rcd.Eof do
          begin

            Inc(TotalEncontrados);
            Rcd.Next;

          end;
        rcd.First;


        VisualizaPainelPesquisa();

        Screen.Cursor := crHourGlass;

        ItensEncontrados := 0;
        Frm.Progresso.Visible := True;
        Frm.Progresso.Min := 0;
        Frm.Progresso.Max := TotalEncontrados;

        while not rcd.Eof do
          begin

            Li := TListItem.Create(Lst.Items);

            Li.SubItems.Add(trim(rcd.FieldByName('Nome').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Ano').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Publicacao').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Ementa').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('NumeroLei').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Lei').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('TipoLei').AsString));

            Li.Caption := trim(rcd.FieldByName('Nome').AsString);

            Lst.Items.AddItem(LI);

            ShowScrollBar( Lst.Handle, SB_VERT , false );
            ShowScrollBar( Lst.Handle, SB_HORZ , false );

            Inc( ItensEncontrados , 1 );
            Frm.Progresso.Position := ItensEncontrados;
            Frm.AtualizaAndamento('Adicionando o item ' + IntToStr(ItensEncontrados) + ' de ' + IntToStr(TotalEncontrados) );

            Application.ProcessMessages;

            if Frm.ProcessoCancelado then
              break;

            Application.ProcessMessages;
            rcd.Next;
          end;
        Screen.Cursor := crDefault;

        LblQuantidadeOcorrencias.Caption := IntToStr(ItensEncontrados) + ' Ocorrência(s)';
        LblTituloResultadosPesquisa.Caption := 'Clique nela(s) para exibir o texto acima';
        Application.ProcessMessages;

        Frm.FinalizaAnimacao();
        Frm.Close;
        Rcd.Close;
        Screen.Cursor := crDefault;

        Lst.Invalidate ;
        AjustaScrollBarLista();

        Application.ProcessMessages;

        LblQuantidadeOcorrencias.Visible := true;
        LblTituloResultadosPesquisa.Visible := true;

        PnlDireitaInferiorResize(PnlDireitaInferior);
        Application.ProcessMessages;

      end;

  Except
    On ex : exception do
      begin
        Screen.Cursor := crDefault;
        MessageBox(self.Handle, PAnsiChar(ex.Message), 'LexMaximus', MB_OK or MB_ICONERROR);
      end;

  end;

end;

procedure TFrmPrincipal.Pesquisa_OU(TiposLeiSelecionados : String ;  CondicaoSubNodes : String ; CondicaoLeis : String);
var
  Lei                       : TRul_Lei;
  //I                         : Integer;
  //Q                         : Integer;
  Rcd                       : TSQLQuery;
  Li                        : TListItem;
  ListaCodigos              : TStringList;
  PalavrasNaoEncontradas    : String;
  Frm                       : TFrmAndamento;
  TotalEncontrados          : Integer;
  ItensEncontrados          : Integer;
  //ItensNaoEncontrados       : String;
  TituloLei                 : String;

begin
  try

    //Verificando se as palavras existem na lista de palavras do programa..
    Lst.Items.clear;

    LblQuantidadeOcorrencias.Visible := false;
    LblTituloResultadosPesquisa.Visible := false;

    ListaCodigos := TStringList.Create;

    PalavrasNaoEncontradas := VerificaExistenciaPalavras(ListaCodigos , TP_OU);

    if PalavrasNaoEncontradas= 'xx' then
      begin
        MessageBox ( Self.Handle, 'Informe uma expressão válida para pesquisa', 'LexMaximus', MB_OK or MB_ICONWARNING);
        exit;
      end;

    if PalavrasNaoEncontradas<>'' then
      begin
        MessageBox(Self.Handle, PAnsiChar('Palavra não encontrada =' + PalavrasNaoEncontradas) , 'LexMaximus', MB_OK or MB_ICONWARNING);
        exit;
      end;

    CriaListaPesquisa();
    if Lst.Columns.Count=0 then
      CriaColunasListaPesquisa();
    Lst.Items.Clear;

    Frm := TFrmAndamento.Create(nil);
    Frm.Progresso.Visible := false;
    Frm.ProcessoCancelado := false;
    Frm.CorFundo := Configuracoes.CorFundo;
    Frm.CorFonte := clWhite;

    Frm.Show;
    Windows.SetParent(Frm.Handle , Self.Handle );

    Frm.AtualizaAndamento('Pesquisando no banco de dados de legislações'  );
    Frm.IniciaAnimacao();
    Application.ProcessMessages;

    Screen.Cursor := crHourGlass;
    Lei := TRul_Lei.create(-1);
    Rcd := Lei.RetornaLeiPeloTipoLei(TiposLeiSelecionados , CondicaoSubNodes , CondicaoLeis , ListaCodigos , 2);

    if Rcd = nil then
      begin
        Mensagem('Erro na pesquisa:' + chr(13) + chr(10) + lei.Mensagem , 'Pesquisa'  );
        Frm.Close();
        exit;
      end;

    Screen.Cursor := crDefault;

    if Frm.ProcessoCancelado then
      begin
        Rcd.Close;
        FreeAndNil(Lei);
        MessageBox(Self.Handle, 'Pesquisa cancelada', 'LexMaxiumus' , MB_OK or MB_ICONWARNING );
        frm.Close;
        frm.Destroy;
        exit;
      end;

    if Rcd.Eof then
      begin
        Rcd.Close;
        FreeAndNil(Lei);
        MessageBox(Self.Handle, 'Não foram encontradas leis dentro do(s) tipo(s) de lei selecionado(s)', 'LexMaxiumus' , MB_OK or MB_ICONWARNING );
        exit;
      end
    else
      begin
        Frm.AtualizaAndamento('Exibindo o resultado da pesquisa'  );
        TotalEncontrados := 0;

        while not rcd.Eof do
          begin

            Inc(TotalEncontrados);
            Rcd.Next;

          end;
        rcd.First;

        VisualizaPainelPesquisa();

        Screen.Cursor := crHourGlass;

        ItensEncontrados := 0;
        Frm.Progresso.Visible := True;
        Frm.Progresso.Min := 0;
        Frm.Progresso.Max := TotalEncontrados;

        while not rcd.Eof do
          begin
            Li := TListItem.Create(Lst.Items);

            Li.SubItems.Add(trim(rcd.FieldByName('Nome').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Ano').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Publicacao').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Ementa').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('NumeroLei').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Lei').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('TipoLei').AsString));

            Li.Caption := rcd.FieldByName('Nome').AsString;

            Lst.Items.AddItem(LI);

            ShowScrollBar( Lst.Handle, SB_VERT , false );
            ShowScrollBar( Lst.Handle, SB_HORZ , false );


            Inc( ItensEncontrados , 1 );
            Frm.Progresso.Position := ItensEncontrados;
            Frm.AtualizaAndamento('Adicionando o item ' + IntToStr(ItensEncontrados) + ' de ' + IntToStr(TotalEncontrados) );

            Application.ProcessMessages;

            if Frm.ProcessoCancelado then
              break;

            Application.ProcessMessages;
            rcd.Next;
          end;
        Screen.Cursor := crDefault;

        LblQuantidadeOcorrencias.Caption := IntToStr(ItensEncontrados) + ' Ocorrência(s)';
        LblTituloResultadosPesquisa.Caption := 'Clique nela(s) para exibir o texto acima';
        Application.ProcessMessages;

        Frm.FinalizaAnimacao();
        Frm.Close;
        Rcd.Close;
        FreeAndNil(Lei);
        Screen.Cursor := crDefault;

        Lst.Invalidate ;
        AjustaScrollBarLista();

        Application.ProcessMessages;

        LblQuantidadeOcorrencias.Visible := true;
        LblTituloResultadosPesquisa.Visible := true;

        PnlDireitaInferiorResize(PnlDireitaInferior);
        Application.ProcessMessages;

      end;

  Except
    On ex : exception do
      begin
        Screen.Cursor := crDefault;
        MessageBox(self.Handle, PAnsiChar(ex.Message), 'LexMaximus', MB_OK or MB_ICONERROR);
      end;

  end;
end;

procedure TFrmPrincipal.Pesquisa_Por_PalavraChave(TiposLeiSelecionados : String ;  CondicaoSubNodes : String ; CondicaoLeis : String);
var
  Lei                       : TRul_Lei;
  //I                         : Integer;
  //Q                         : Integer;
  Rcd                       : TSQLQuery;
  Li                        : TListItem;
  ListaCodigos              : TStringList;
  PalavrasNaoEncontradas    : String;
  Frm                       : TFrmAndamento;
  TotalEncontrados          : Integer;
  ItensEncontrados          : Integer;
  TituloLei                 : String;
begin
  try

    //Verificando se as palavras existem na lista de palavras do programa..

    Lst.Items.clear;
    LblQuantidadeOcorrencias.Visible := false;
    LblTituloResultadosPesquisa.Visible := false;

    ListaCodigos := TStringList.Create;

    ListaPalavrasSelecao.Add(Trim(TxtPesquisa.Text));

    PalavrasNaoEncontradas := VerificaExistenciaPalavras(ListaCodigos , TP_Frase);

    if PalavrasNaoEncontradas= 'xx' then
      begin
        MessageBox ( Self.Handle, 'Informe uma expressão válida para pesquisa', 'LexMaximus', MB_OK or MB_ICONWARNING);
        exit;
      end;

    if PalavrasNaoEncontradas<>'' then
      begin
        MessageBox(Self.Handle, PAnsiChar('Palavra não encontrada =' + PalavrasNaoEncontradas) , 'LexMaximus', MB_OK or MB_ICONWARNING);
        exit;
      end;

    CriaListaPesquisa();

    if Lst.Columns.Count=0 then
      CriaColunasListaPesquisa();

    Lst.Items.Clear;

    Frm := TFrmAndamento.Create(self);
    Frm.Progresso.Visible := false;
    Frm.ProcessoCancelado := false;
    Frm.CorFundo := Configuracoes.CorFundo;
    Frm.CorFonte := clWhite;

    Frm.Show;
    Windows.SetParent(Frm.Handle , Self.Handle );

    Frm.AtualizaAndamento('Pesquisando no banco de dados de legislações'  );
    Frm.IniciaAnimacao();
    Application.ProcessMessages;

    Screen.Cursor := crHourGlass;

    Lei := TRul_Lei.create(-1);

    Screen.Cursor := crHourGlass;
    Rcd := Lei.RetornaLeiPeloTipoLei(TiposLeiSelecionados , CondicaoSubNodes , CondicaoLeis  , ListaCodigos , 3);
    if Rcd = nil then
      begin
        Mensagem('Erro na pesquisa:' + chr(13) + chr(10) + lei.Mensagem , 'Pesquisa'  );
        Frm.Close();
        exit;
      end;

    Screen.Cursor := crDefault;

    if Frm.ProcessoCancelado then
      begin
        Rcd.Close;
        FreeAndNil(Lei);
        MessageBox(Self.Handle, 'Pesquisa cancelada', 'LexMaxiumus' , MB_OK or MB_ICONWARNING );
        frm.Close;
        frm.Destroy;
        exit;
      end;

    if Rcd.Eof then
      begin
        Rcd.Close;
        FreeAndNil(Lei);
        Frm.Close();
        MessageBox(Self.Handle, 'Não foram encontradas leis dentro do(s) tipo(s) de lei selecionado(s)', 'LexMaxiumus' , MB_OK or MB_ICONWARNING );
        exit;
      end
    else
      begin
        Frm.AtualizaAndamento('Exibindo o resultado da pesquisa'  );
        TotalEncontrados := 0;

        while not rcd.Eof do
          begin

            Inc(TotalEncontrados);
            Rcd.Next;

          end;
        rcd.First;

        VisualizaPainelPesquisa();

        Screen.Cursor := crHourGlass;
        ItensEncontrados := 0;

        ItensEncontrados := 0;
        Frm.Progresso.Visible := True;
        Frm.Progresso.Min := 0;
        Frm.Progresso.Max := TotalEncontrados;
                
        while not rcd.Eof do
          begin

            Li := TListItem.Create(Lst.Items);

            Li.SubItems.Add(trim(rcd.FieldByName('Nome').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Ano').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Publicacao').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Ementa').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('NumeroLei').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('Lei').AsString));
            Li.SubItems.Add(trim(rcd.FieldByName('TipoLei').AsString));

            Li.Caption := trim(rcd.FieldByName('Nome').AsString);

            Lst.Items.AddItem(LI);

            ShowScrollBar( Lst.Handle, SB_VERT , false );
            ShowScrollBar( Lst.Handle, SB_HORZ , false );

            Inc( ItensEncontrados , 1 );
            Frm.Progresso.Position := ItensEncontrados;
            Frm.AtualizaAndamento('Adicionando o item ' + IntToStr(ItensEncontrados) + ' de ' + IntToStr(TotalEncontrados) );

            Application.ProcessMessages;

            if Frm.ProcessoCancelado then
              break;

            Application.ProcessMessages;
            rcd.Next;
          end;
        Screen.Cursor := crDefault;

        LblQuantidadeOcorrencias.Caption := IntToStr(ItensEncontrados) + ' Ocorrência(s)';
        LblTituloResultadosPesquisa.Caption := 'Clique nela(s) para exibir o texto acima';

        Application.ProcessMessages;
        Frm.FinalizaAnimacao();
        Frm.Close;
        Rcd.Close;
        FreeAndNil(Lei);
        Screen.Cursor := crDefault;

        Lst.Invalidate ;
        AjustaScrollBarLista();

        Application.ProcessMessages;

        LblQuantidadeOcorrencias.Visible := true;
        LblTituloResultadosPesquisa.Visible := true;

        PnlDireitaInferiorResize(PnlDireitaInferior);
        Application.ProcessMessages;


      end;
  Except
    On ex : exception do
      begin
        MessageBox(self.Handle, PAnsiChar(ex.Message), 'LexMaximus', MB_OK or MB_ICONERROR);
      end;
  end;
end;

procedure TFrmPrincipal.ExibeDicaOcorrencias();
begin
  PnlDicaOcorrencia.Visible:= True;
  TmrToolTip.Enabled := True;
end;

procedure TFrmPrincipal.EscondeDicaOcorrencias();
begin
  PnlDicaOcorrencia.Visible:= False;
  TmrToolTip.Enabled := false;

end;

{$ENDREGION}

{$REGION 'Metodos para realizacao das pesquisas no texto do Browser'}

Function TFrmPrincipal.RetornaTextoBrowser() : String;
var
  Arquivo : String;
  Conteudo : TStringList;
begin

  Arquivo := browser.CurrentFile;

  Conteudo.LoadFromFile(Arquivo);

  Result := Conteudo.Text;
  Conteudo.Clear;
  Conteudo.Destroy;


end;

procedure TFrmPrincipal.Pesquisa_Browser_Por_Artigo();
var
  Texto               : String;
  Artigo              : String;
  HTMLSubstituicao    : String;
  Conteudo            : TStringList;
  Conteudo2           : TStringList;
  ArquivoHTML         : String;
  AchouArtigo         : Boolean;
  TextoPesquisa       : String;
  Marcacao            : String;

begin
  try

    ArquivoHTML := DiretorioBrowser + '\tempdata.htm';
    Conteudo2 := TStringList.Create();
    Conteudo2.LoadFromFile(ArquivoHTML);
    Texto := Conteudo2.Text;

    FreeandNil(Conteudo2);

    AchouArtigo := false;
    HTMLSubstituicao := '<b><font style=''background-color:'+CorFundoSelecaoPesquisaBrowser+';color:#ffffff;'' ><a name="#MARCACAO-9999">%%ARTIGO%%</a></font></b>';

     if not AchouArtigo then
      begin
        Artigo := 'Art.&nbsp;' + TxtPesquisaBrowser.Text + '<u><sup>o</sup></u>';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
     if not AchouArtigo then
      begin
        Artigo := 'Art.&nbsp;' + TxtPesquisaBrowser.Text + '<u><sup>o</sup></u>';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    
    if not AchouArtigo then
      begin
        Artigo := 'Art. ' + TxtPesquisaBrowser.Text + ' ';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if not AchouArtigo then
      begin
        Artigo := 'Art.&nbsp;' + TxtPesquisaBrowser.Text + '&nbsp;';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if not AchouArtigo then
      begin
        Artigo := 'Art. ' + TxtPesquisaBrowser.Text + 'º ';
        if AnsiContainsText(Texto, Artigo)  then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if not AchouArtigo then
      begin
        Artigo := 'Art.&nbsp;' + TxtPesquisaBrowser.Text + 'ºnbsp;';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if not AchouArtigo then
      begin
        Artigo := 'Art. ' + TxtPesquisaBrowser.Text + 'º. ';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if not AchouArtigo then
      begin
        Artigo := 'Art.&nbsp;' + TxtPesquisaBrowser.Text + 'º.&nbsp;';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if not AchouArtigo then
      begin
        Artigo := 'Art. ' + TxtPesquisaBrowser.Text + '. ';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if not AchouArtigo then
      begin
        Artigo := 'Art.&nbsp;' + TxtPesquisaBrowser.Text + '.&nbsp;';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if not AchouArtigo then
      begin
        Artigo := 'Art. ' + TxtPesquisaBrowser.Text + '.';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if not AchouArtigo then
      begin
        Artigo := 'Art.&nbsp;' + TxtPesquisaBrowser.Text + '.';
        if AnsiContainsText(Texto, Artigo) then
          begin
            TextoPesquisa := Artigo;
            AchouArtigo := True;
          end;
      end;
    if AchouArtigo then
      begin

        Marcacao := ReplaceStr( HTMLSubstituicao, '%%ARTIGO%%' , Artigo);
        Texto := ReplaceStr(Texto, Artigo, Marcacao);

        ArquivoHTML := GetcurrentDir() + '\Browser\tempdata.htm';

        Conteudo := TStringList.Create;
        Conteudo.Add(Texto);
        Conteudo.SaveToFile( ArquivoHTML );
        Conteudo.Clear;
        Conteudo.Destroy;

        Browser.LoadFromFile(ArquivoHTML);

        Application.ProcessMessages;

        //Browser.Find( TextoPesquisa, False);

        Browser.PositionTo('MARCACAO-9999');

      end;


  finally

  end;

end;

procedure TFrmPrincipal.Pesquisa_Browser_Frase();

var
  TextoHTML               : String;
  FraseOriginal       : String;
  Frase              : String;
  HTMLSubstituicao    : String;
  Conteudo            : TStringList;
  ArquivoHTML         : String;
  //AchouArtigo         : Boolean;
  TextoPesquisa       : String;

begin
  try
    TextoHTML := RetornaTextoBrowser();

    FraseOriginal := Trim(TxtPesquisaBrowser.Text) ;


    Frase := AnsiUpperCase( FraseOriginal );
    HTMLSubstituicao := '<b><font style=''background-color:'+CorFundoSelecaoPesquisaBrowser+';color:#ffffff;'' >' + Frase + '</font></b>';

    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ' ' , ' ' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + '.' , ' ' + HTMLSubstituicao+ '.'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ',' , ' ' + HTMLSubstituicao+ ','  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ';' , ' ' + HTMLSubstituicao+ ';'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + ' ' , HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + '.' , HTMLSubstituicao+ '.'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + ',' , HTMLSubstituicao+ ','  );
    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + ';' , HTMLSubstituicao+ ';'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , '"' + Frase + ' ' , '"' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + '"' , ' ' + HTMLSubstituicao+ '"'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , '(' + Frase + ' ' , '(' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ')' , ' ' + HTMLSubstituicao+ ')'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '(' + Frase + ')' , '(' + HTMLSubstituicao+ ')'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + '<' , ' ' + HTMLSubstituicao+ '<'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + ' ' , '>' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + '<' , '>' + HTMLSubstituicao+ '<'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + '.' , '>' + HTMLSubstituicao+ '.'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + ')' , '>' + HTMLSubstituicao+ ')'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ',' + Frase + ' ' , ',' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ',' , ' ' + HTMLSubstituicao+ ','  );

    ///////////////////////////////////////////////Toda em minusculo
    Frase := AnsiLowerCase( FraseOriginal );
    HTMLSubstituicao := '<b><font style=''background-color:'+CorFundoSelecaoPesquisaBrowser+';color:#ffffff;'' >' + Frase + '</font></b>';
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ' ' , ' ' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + '.' , ' ' + HTMLSubstituicao+ '.'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ',' , ' ' + HTMLSubstituicao+ ','  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ';' , ' ' + HTMLSubstituicao+ ';'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + ' ' , HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + '.' , HTMLSubstituicao+ '.'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + ',' , HTMLSubstituicao+ ','  );
    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + ';' , HTMLSubstituicao+ ';'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , '"' + Frase + ' ' , '"' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + '"' , ' ' + HTMLSubstituicao+ '"'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , '(' + Frase + ' ' , '(' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ')' , ' ' + HTMLSubstituicao+ ')'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '(' + Frase + ')' , '(' + HTMLSubstituicao+ ')'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + '<' , ' ' + HTMLSubstituicao+ '<'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + ' ' , '>' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + '<' , '>' + HTMLSubstituicao+ '<'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + '.' , '>' + HTMLSubstituicao+ '.'  );

    // >antecipação da tutela)
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + ')' , '>' + HTMLSubstituicao+ ')'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , ',' + Frase + ' ' , ',' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ',' , ' ' + HTMLSubstituicao+ ','  );

    ///////////////////////////////////////////////So com a inicial maiusculo
    Frase := AnsiUpperCase( Copy(FraseOriginal,1,1) ) +  AnsiLowerCase( Copy(FraseOriginal,2) );
    HTMLSubstituicao := '<b><font style=''background-color:'+CorFundoSelecaoPesquisaBrowser+';color:#ffffff;'' >' + Frase + '</font></b>';
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ' ' , ' ' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + '.' , ' ' + HTMLSubstituicao+ '.'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ',' , ' ' + HTMLSubstituicao+ ','  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ';' , ' ' + HTMLSubstituicao+ ';'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + ' ' , HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + '.' , HTMLSubstituicao+ '.'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + ',' , HTMLSubstituicao+ ','  );
    TextoHTML := AnsiReplaceStr(TextoHTML , Frase + ';' , HTMLSubstituicao+ ';'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , '"' + Frase + ' ' , '"' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + '"' , ' ' + HTMLSubstituicao+ '"'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , '(' + Frase + ' ' , '(' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ')' , ' ' + HTMLSubstituicao+ ')'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '(' + Frase + ')' , '(' + HTMLSubstituicao+ ')'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + '<' , ' ' + HTMLSubstituicao+ '<'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + ' ' , '>' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + '<' , '>' + HTMLSubstituicao+ '<'  );
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + '.' , '>' + HTMLSubstituicao+ '.'  );

    // >antecipação da tutela)
    TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Frase + ')' , '>' + HTMLSubstituicao+ ')'  );

    TextoHTML := AnsiReplaceStr(TextoHTML , ',' + Frase + ' ' , ',' + HTMLSubstituicao+ ' '  );
    TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Frase + ',' , ' ' + HTMLSubstituicao+ ','  );

    ArquivoHTML := GetcurrentDir() + '\Browser\tempdata.htm';

    Conteudo := TStringList.Create;
    Conteudo.Add(TextoHTML);
    Conteudo.SaveToFile( ArquivoHTML );
    Conteudo.Clear;
    Conteudo.Destroy;

    Browser.LoadFromFile(ArquivoHTML);

    Application.ProcessMessages;

    Browser.Find( TextoPesquisa, False);

  finally

  end;
end;

procedure TFrmPrincipal.VerificaPalavrasPesquisaBrowser();
var
  TextoPesquisa : String;
begin

  TextoPesquisa := trim ( TxtPesquisaBrowser.Text );
  if PesquisaSelecionadaBrowser <> TP_Frase then
    begin

      TextoPesquisa := StringReplace(TextoPesquisa , ' de ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' das ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' dos ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' da ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' do ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' por ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' para ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' as ' , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' os ' , ' '  , [rfReplaceAll, rfIgnoreCase]);

      TextoPesquisa := StringReplace(TextoPesquisa , ' a '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' e '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' i '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' o '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' u '  , ' '  , [rfReplaceAll, rfIgnoreCase]);
      TextoPesquisa := StringReplace(TextoPesquisa , ' ou ' , ' '  , [rfReplaceAll, rfIgnoreCase]);

    end;
      TextoPesquisa := trim(AnsiLowerCase( TextoPesquisa) );

  while Pos('  ', TextoPesquisa) > 0 do
    TextoPesquisa := ReplaceStr( TextoPesquisa, '  ', '' );

  TextoPesquisa := trim(TextoPesquisa);

  if ListaPalavrasSelecaoBrowser = nil then
    ListaPalavrasSelecaoBrowser := TStringList.Create();

  ListaPalavrasSelecaoBrowser.Clear;

  Split(' ',  TextoPesquisa , ListaPalavrasSelecaoBrowser);
  
  FraseSelecao := TextoPesquisa;

end;

{$ENDREGION}

{$REGION 'Metodos para visualizacao das leis'}

procedure TFrmPrincipal.VisualizaTextoLei(TipoLei: Integer; NomeLei: String; Lei: Integer; Publicacao : String; IncluirHistorico : Boolean; MarcarPalavras : Boolean);
var
  Arquivo                         : String;
  ArquivoDescomprimido            : String;
  ConteudoArquivoDescomprimido    : TStringList;
  TituloLei                       : String;
  TextoHTML                       : String;
  textolei                        : TRul_TextoLei;

begin

  if (Lei = CodigoLeiAtual) and (not MarcarPalavras) then //Achiles:04/11/2009 para atualizar quando quiser apenas marcar as palavras
    exit;

  Arquivo := DiretorioBrowser +  '\TL-' + IntToStr(Lei) + '.lmcf';
  ArquivoDescomprimido := DiretorioBrowser + '\tempdata.htm';

  textolei := TRul_TextoLei.Create(Lei, Arquivo);

  TxtPesquisaBrowser.Text := '';

  TituloLei := RetornaTituloLei (TipoLei, NomeLei);

  Lbl_NomeLei.Caption := TituloLei;
  LblPublicacaoBrowser.Caption := Publicacao;
  
  if FileExists(Arquivo) then
    begin

      zlib.ArquivoComprimido := Arquivo ;
      zlib.ArquivoDescomprimido := ArquivoDescomprimido;

      zlib.DescomprimeArquivo();

      if IncluirHistorico then
        begin

          HistoricoNomeTipoLei.Add( IntToStr(TipoLei) );

          HistoricoTipoLei.Add( IntToStr(TipoLei) );

          HistoricoNomeLei.Add(NomeLei);

          HistoricoLeis.Add( IntToStr(Lei) );

          HistoricoVerbetes.Add(Link);

          HistoricoPublicacao.Add(Publicacao);

          IndiceHistorico := HistoricoVerbetes.Count-1;

          if HistoricoVerbetes.Count <> 1 then
            begin
              BtnVoltarHistorico.Enabled := True;
              ItmVoltarHistorico.Enabled := True;

            end;

          BtnHistorico.Enabled := True;

        end;

      TipoLeiAtual := TipoLei;
      NomeLeiAtual := NomeLei;
      CodigoLeiAtual := Lei;
      PublicacaoAtual := Publicacao;

      Application.ProcessMessages;

      //Achiles: 04/11/2009
      //
      //if (MarcarPalavras) And (ListaPalavrasSelecao.Count > 0) then

      if (MarcarPalavras) then
        begin

          ConteudoArquivoDescomprimido := TStringList.Create;

          ConteudoArquivoDescomprimido.LoadFromFile(ArquivoDescomprimido);
          TextoHTML := ConteudoArquivoDescomprimido.Text;

          (*****************************************************
          ConteudoSalvar := TStringList.Create();
          ConteudoSalvar.Add( TextoHTML );
          ConteudoSalvar.SaveToFile( GetCurrentDir() + '\ConteudoSalvar.txt' );
          *****************************************************)

          if FormaPesquisaAtual = FP_ListaLeis then
            begin

              if ListaPalavrasSelecao.Count >0 then
                begin
                  if PesquisaSelecionada = TP_Frase then
                    SelecionaPalavrasPesquisa_V2(TextoHTML , ListaPalavrasSelecao , FraseSelecao , True)
                  else
                    SelecionaPalavrasPesquisa_V2(TextoHTML , ListaPalavrasSelecao , '' , False)
                end;
            end
          else
            begin
              if ListaPalavrasSelecaoBrowser.Count >0 then
                begin
                  if PesquisaSelecionadaBrowser = TP_Frase then
                    SelecionaPalavrasPesquisa_V2(TextoHTML , ListaPalavrasSelecaoBrowser, FraseSelecaoBrowser , True)
                  else
                    SelecionaPalavrasPesquisa_V2(TextoHTML , ListaPalavrasSelecaoBrowser , '' , False);
                end;
            end;
            
          IndiceMarcacaoAtual := 1;

          ConteudoArquivoDescomprimido.Clear;
          ConteudoArquivoDescomprimido.Add(TextoHTML);
          ConteudoArquivoDescomprimido.SaveToFile(ArquivoDescomprimido);
          
          ConteudoArquivoDescomprimido.Destroy;

        end;

      IncluiNotas(Lei , ArquivoDescomprimido);

      //Salvando o conteudo HTML para usar na copia
      ConteudoArquivoDescomprimido := TStringList.Create();
      ConteudoArquivoDescomprimido.LoadFromFile(ArquivoDescomprimido);
      ConteudoArquivoHTMLAtual := ConteudoArquivoDescomprimido.Text;

      ConteudoArquivoHTMLAtual := ReplaceStr(ConteudoArquivoHTMLAtual,'#000080', '#AA2B00');
      ConteudoArquivoHTMLAtual := ReplaceStr(ConteudoArquivoHTMLAtual,'#800000', '#000084');

      ConteudoArquivoDescomprimido.Clear;
      ConteudoArquivoDescomprimido.Add(ConteudoArquivoHTMLAtual);
      ConteudoArquivoDescomprimido.SaveToFile(ArquivoDescomprimido);

      ConteudoArquivoDescomprimido.Destroy;

      Browser.LoadFromFile( ArquivoDescomprimido );
      Browser.Enabled := true;
      Browser.PopupMenu := PopUpBrowser;

      ItmSelecionarTudo.Enabled := True;
      ItmCopiar.Enabled := True;
      ItmImprimir.Enabled := True;
      BtnImprimir.Enabled := True;
      BtnCopiar.Enabled := True;

      Btn_DividirBrowser.Visible        := PesquisaAtivada;
      Btn_ExtenderBrowser.Visible       := PesquisaAtivada;
      Lbl_Palavra_Encontrada.Visible    := PesquisaAtivada;
      BtnRetrocederPalavra.Visible      := PesquisaAtivada;
      BtnAvancarPalavra.Visible         := PesquisaAtivada;

      PnlPesquisaBrowser.Visible := True;
      PnlPesquisaBrowser.Repaint;
      AjustaScrollBrowser();

      //PnlPesquisaBrowser.Repaint;
      PnlPesquisaBrowserResize( PnlPesquisaBrowser );

    end
  else
    begin
      NotaItemSelecionado := '';
      CodigoLeiAtual := -1;
      NotaExiste := True;

      VisualizaDefault();

    end;

  AjustaScrollBarBrowser;

  // para o inicio
  Browser.ScrollTo(0);

  (**********************************
  if PermitirEdicaoHTML then
    begin
      Browser2.ScrollTo(Browser2.VScrollBar.Max);
    end;
  **********************************)


end;

procedure TFrmPrincipal.SelecionaPalavrasPesquisa_V2(var TextoHTML : String ; ListaPalavras : TStringList ; Frase : String ; MarcarFrase : Boolean);
var
  I                   : Integer;
  Q                   : Integer;
  Letra               : char;
  Palavra             : String;
  HTMLSubstituicao    : String;
  Delimitadores       : String;
  LetrasPalavras      : String;
  Retorno             : String;
  IndiceLink          : Integer;
  TextoMarcado        : String;
  //Posicao             : Integer;
  FraseEncontrada     : String;

begin

    (***************************************************
    Achiles: 04/11/2009

    retirado. para melhorar a performance...

    TextoHTML := ReplaceText(TextoHTML, chr(13) + chr(10) , ' ');

    while Pos('  ', TextoHTML) >0 do
      TextoHTML := ReplaceText(TextoHTML, '  ' , ' ');
    ***************************************************)


    LetrasPalavras := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZáéíóúàèìòùâêîôûäëïüöÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÄËÏÖÜãõÃÕçÇ1234567890';
    Delimitadores := ' .,;:"()<>' + chr(13) + chr(10);

    Q := Length(TextoHTML);
    I := 1;
    HTMLSubstituicao := '<b><font style=''background-color:#800080;color:#ffffff;'' ><a name="#<%Sequencial%>"><%Palavra%></a></font></b>';
    Retorno := '';
    IndiceLink := 1;

    while (I<=Q) do
      begin

        Letra := TextoHtml[i];

        if ( Letra = chr(10) ) or ( Letra = chr(13) ) then
          begin
            Letra := ' ';
          end;

        if  AnsiPos(Letra, Delimitadores) <> 0 then
          begin

            // verificando a palavra formada
            if Palavra <> '' then
              begin
                if (ListaPalavras.IndexOf(Palavra)<> -1) and ( not MarcarFrase) then
                  begin
                    // se a palavra esta dentro da lista, tera que ser marcada
                    TextoMarcado := HTMLSubstituicao;
                    TextoMarcado := ReplaceText(HTMLSubstituicao, '<%Palavra%>', Palavra);
                    TextoMarcado := ReplaceText(TextoMarcado, '<%Sequencial%>', 'MARCACAO-' + RightPad(IntToStr(IndiceLink), '0', 4 ) );

                    Inc( IndiceLink , 1);

                    Retorno:= Retorno + TextoMarcado;
                  end
                else
                  begin

                    Retorno:= Retorno + Palavra;

                    if MarcarFrase then
                      begin
                        // selecionar apenas o que esta na variavel FraseSelecao
                        if AnsiEndsText(Frase, Retorno) then
                          begin
                            FraseEncontrada := Copy(Retorno,  Length(Retorno)- Length(Frase)+1);
                            Retorno := Copy(Retorno, 1, Length(Retorno)- Length(Frase));

                            TextoMarcado := HTMLSubstituicao;
                            TextoMarcado := ReplaceText(HTMLSubstituicao, '<%Palavra%>', FraseEncontrada);
                            TextoMarcado := ReplaceText(TextoMarcado, '<%Sequencial%>', 'MARCACAO-' + RightPad(IntToStr(IndiceLink), '0', 4 ) );

                            Inc( IndiceLink , 1);

                            Retorno:= Retorno + TextoMarcado;

                          end;

                      end;
                  end;

                Palavra := '';
              end;

            // adicionando o delimitador
            Retorno := Retorno + Letra;

          end
        else
          Palavra := Palavra + Letra;

        Inc(I,1);

      end;
    TotalMarcacaoAtual := IndiceLink-1;
    TextoHTML := Retorno;

end;

procedure TFrmPrincipal.IncluiNotas(Lei : Integer ; Arquivo : String);

var
  n : TRul_NotaLei;
  Rcd : TSQLQuery;
  Posicao : Integer;

  TextoRodape : String;

  Conteudo : TStringList;
  NotaLei : String;
  Texto : String;
  I : Integer;
  Q : Integer;
  //Link : String;
  Item : Integer;
  Retorno : String;
  Letra : char;
  Palavra : String;
  HTMLNota : String;

begin

  TextoRodape := '';
  
  Conteudo := TStringList.Create;
  Conteudo.LoadFromFile(Arquivo);

  Texto := Conteudo.Text;
  
  n := TRul_NotaLei.Create();
  n.Lei := Lei;

  rcd := n.GetAll;

  if rcd.Eof then
    begin
      Conteudo.Clear;
      Conteudo.Destroy;

      n.Destroy;
      rcd.Destroy;

      Lbl_IncluirAlterarNota.Enabled := True;
      Lbl_ExcluirNota.Enabled := False;

      exit;
    end
  else
    begin
      Lbl_IncluirAlterarNota.Enabled := True;
      Lbl_ExcluirNota.Enabled := True;
    end;

  Retorno := Texto ;  
  while not Rcd.Eof do
    begin
      Posicao := Rcd.FieldByName('Posicao').AsInteger;

      if Posicao = 0  then
        TextoRodape := trim(Rcd.FieldByName('NotaLei').AsString)
      else
        begin
          NotaLei := trim(Rcd.FieldByName('NotaLei').AsString);

          //Procurando o paragrafo pela posicao dele...
          Q := Length(Texto);
          Retorno := '';
          Item := 0;

          for I := 1 to Q do
            begin
              Letra := Texto[i];

              if (Letra = ' ') or (Letra = chr(10)) or (Letra = chr(13)) then
                begin
                  if AnsiEndsText ( '</p>', Palavra )  then
                    begin
                      Inc(Item,1);

                      if Item = Posicao then
                        begin

                          HTMLNota := '<font face=''Arial'' size=''2px'' color=''#0000FF''>';
                          HTMLNota := HTMLNota + '<p align=''justify''>';
                          HTMLNota := HTMLNota + NotaLei;
                          HTMLNota := HTMLNota + '</p>';
                          HTMLNota := HTMLNota + '</font>';

                          HTMLNota := ReplaceText(HTMLNota, chr(13) + chr(10) , '<br>' );

                          Retorno := Retorno + Palavra + '<br>' + HTMLNota;

                        end
                      else
                        begin
                          Retorno := Retorno + Palavra + Letra;
                        end;
                    end
                  else
                    Retorno := Retorno + Palavra + Letra;

                  Palavra := '';
                end
              else
                begin
                  Palavra := Palavra + Letra;
              end;
            end;
          Texto := Retorno;
        end;


      rcd.Next;

    end;

  if TextoRodape <> '' then
    begin
      TextoRodape := ReplaceText(TextoRodape, chr(13) + chr(10) , '<br>' );

      HTMLNota := '<font face=''Arial'' size=''2px'' color=''#0000FF''>';

      HTMLNota := HTMLNota + '<hr width=''96%''>';
      HTMLNota := HTMLNota + '<b>Notas do usuário</b><br>';
      HTMLNota := HTMLNota + '<p align=''justify''>';
      HTMLNota := HTMLNota + TextoRodape;
      HTMLNota := HTMLNota + '</p>';
      HTMLNota := HTMLNota + '</font>';
      HTMLNota := HTMLNota + '<hr width=''96%''>';

      Retorno := Retorno + HTMLNota;
    end;
  Conteudo.Clear;
  Conteudo.Add(Retorno);
  conteudo.SaveToFile(Arquivo);

end;

Procedure TFrmPrincipal.AtualizaBotaoNotas();

var
  nota : TRul_NotaLei;
  quant : integer;
begin

  nota := TRul_NotaLei.Create;

  quant := nota.GetCount();

  if quant =0 then
    begin
      BtnNotas.Enabled := false;
      ItmExibirNotas.Enabled := false;
    end
  else
    begin
      BtnNotas.Enabled := True;
      ItmExibirNotas.Enabled := True;
    end;
  

end;

procedure TFrmPrincipal.TrataNode(Node : PVirtualNode);
var
  Data                  : PTreeData;
  
begin

  Data      :=  Trv.GetNodeData(Node);

  case Data^.Tipo of
    TN_TipoLei:
      begin
        if not Data^.SubItensCarregados then
          begin

            CarregandoDadosTreeView := True;

            //Achiles: 27/09/2010

            //if (( (Data^.Codigo  >= 7) and (Data^.Codigo  < 10) ) or (Data^.Codigo = 4) or  (Data^.Codigo = 5)) then
            //    CarregaListaLeis(Data^.Codigo, '' , Node)
            //else
              if ( (Data^.Codigo  = 7) or (Data^.Codigo  =8) ) then
                CarregaListaLeis(Data^.Codigo, '' , Node)
              else
                CarregaAnoTipoLei(Data^.Codigo , Node);

            CarregandoDadosTreeView := false;

            Data^.SubItensCarregados := True;
          end;
      end;
    TN_Ano:
      begin
        if not Data^.SubItensCarregados then
          begin

            Trv.DeleteNode(Node.FirstChild, False);

            CarregandoDadosTreeView := True;
            CarregaListaLeis(Data^.Codigo, Data^.Texto , Node);
            CarregandoDadosTreeView := false;

            Data^.SubItensCarregados := True;
          end;
      end;
    TN_DocumentoHTML:
      begin

        VisualizaTextoLei( Data^.TipoLei , Data^.Texto,  Data^.Codigo, Data^.Publicacao , True, False );

      end;
    TN_Pasta:
      begin

      end;
    TN_Documento:
      begin

      end;
    TN_NodeVazio:
      begin

      end;

  end;

end;

procedure TFrmPrincipal.IncluiAlteraNota();
var
  frm : TFrmEdicaoNota;
begin

  if CodigoLeiAtual = -1 then
    begin
      MessageBox( Self.Handle, 'Selecione uma lei , antes de incluir/alterar a nota', 'LexMaximus', MB_OK or MB_ICONWARNING);
      exit;
    end;

  frm := TFrmEdicaoNota.Create(self);

  Frm.DiretorioHTML := DiretorioHTML;
  frm.EdicaoCancelada := false;
  Frm.NotaLei := NotaItemSelecionado;
  Frm.Lei := CodigoLeiAtual;
  Frm.ExclusaoNota := False;
  //Frm.Inclusao := Not NotaExiste;

  Frm.ShowModal;

  AtualizaBotaoNotas();

  if ConteudoAtual = TC_Notas then
    VisualizaNotas();

  AtualizaPaginaAtual();
  
end;

procedure TFrmPrincipal.ExcluiNota();
var
  frm : TFrmEdicaoNota;
begin

  if CodigoLeiAtual = -1 then
    begin
      MessageBox( Self.Handle, 'Selecione uma lei , antes de excluir a nota', 'LexMaximus', MB_OK or MB_ICONWARNING);
      exit;
    end;

  frm := TFrmEdicaoNota.Create(self);

  Frm.DiretorioHTML := DiretorioHTML;
  frm.EdicaoCancelada := false;
  Frm.NotaLei := NotaItemSelecionado;
  Frm.Lei := CodigoLeiAtual;
  Frm.ExclusaoNota := True;
  //Frm.Inclusao := Not NotaExiste;

  Frm.ShowModal;

  AtualizaBotaoNotas();

  if (ConteudoAtual = TC_Notas) then
    VisualizaNotas()
  else
    AtualizaPaginaAtual();
end;

procedure TFrmPrincipal.CarregaDadosTreeView();
begin
  try

    Trv.NodeDataSize:=SizeOf(TTreeData);
    Trv.BeginUpdate;
    CarregandoDadosTreeView := True;

     CarregaListaTipos();

    CarregandoDadosTreeView := false;

    Trv.EndUpdate;

    Application.ProcessMessages;


  finally

  end;
end;

procedure TFrmPrincipal.CarregaListaTipos();
var

  Node      : PVirtualNode;
  Data      : PTreeData;
  TipoLei   : TRul_TipoLei;
  RCD       : TSQLQuery;

begin
  try

    Trv.NodeDataSize:=SizeOf(TTreeData);
    Trv.BeginUpdate;


    TipoLei   := TRul_TipoLei.Create();
    
    RCD := TipoLei.GetAll();

    if TipoLei.Mensagem <> '' then
      begin
        MessageBox ( Self.Handle,  PChar ('Ocorreu um erro ao acessar o banco de dados (' + TipoLei.Mensagem+ ')') , 'Erro do LexMaximus' , MB_OK);
        exit;
      end;

    if RCD = nil then
      begin
        MessageBox ( Self.Handle,  PChar ('Ocorreu um erro ao acessar o banco de dados ') , 'Erro do LexMaximus' , MB_OK);
        exit;
      end;

    TotalItensTreeView := 0;
    while not RCD.Eof do
      begin

        Node:=Trv.AddChild(nil);

        Node.CheckState := csUncheckedNormal;

        Data := Trv.GetNodeData(Node);

        Trv.ValidateNode(Node,False);

        Data^.Texto := Trim(Rcd.FieldByName('Nome').AsString);
        Data^.Codigo := Rcd.FieldByName('TipoLei').AsInteger;

        Data^.Tipo := TN_TipoLei;
        Data^.Expandir := false;
        Data^.SubItensCarregados := false;

        Rcd.Next;

        Inc (TotalItensTreeView);
        
      end;

    Trv.EndUpdate;

    AjustaScrollBarTreeView();
    
    Application.ProcessMessages;


  except
    on ex : exception do
      begin
        MessageBox( Self.Handle,PAnsiChar(ex.Message), 'LexMaximus' , MB_OK);
      end;

  end;
end;

procedure TFrmPrincipal.InsereNodeVazio(Node : PVirtualNode);
var

  NodeVazio   : PVirtualNode;
  DataNodeVazio   : PTreeData;
begin

  NodeVazio := Trv.AddChild(Node);


  DataNodeVazio := Trv.GetNodeData(NodeVazio);

  Trv.ValidateNode(NodeVazio,False);

  DataNodeVazio^.Texto := '';
  DataNodeVazio^.Codigo := -1;

  DataNodeVazio^.Tipo := TN_NodeVazio;
  DataNodeVazio^.Expandir := false;
  DataNodeVazio^.Hint := '';
  DataNodeVazio^.TipoLei := -1;

  DataNodeVazio^.SubItensCarregados := true;

end;

procedure TFrmPrincipal.CarregaAnoTipoLei(TipoLei : Integer ; Node      : PVirtualNode );
var

  NodeLei   : PVirtualNode;
  TL       : TRul_TipoLei;
  RCDAno    : TSQLQuery;
  DataLei   : PTreeData;



begin
    if TipoLei = 10 then
      TipoLei := 10;

    Screen.Cursor := crHourGlass;

    TL       := TRul_TipoLei.Create();
    TL.TipoLei := TipoLei;

    RCDAno := TL.RetornaAnos();

    Trv.NodeDataSize:=SizeOf(TTreeData);
    Trv.BeginUpdate;

    while not RCDAno.Eof do
      begin

        NodeLei := Trv.AddChild(Node);
        NodeLei.Parent := Node;
        //NodeLei.CheckState := csUncheckedNormal;
        NodeLei.CheckState := Node.CheckState;

        DataLei := Trv.GetNodeData(NodeLei);

        Trv.ValidateNode(NodeLei,False);

        DataLei^.Texto := Trim(RCDAno.FieldByName('Ano').AsString);
        DataLei^.Codigo := TipoLei;

        DataLei^.Tipo := TN_Ano;
        DataLei^.Expandir := false;
        DataLei^.Hint := Trim(RCDAno.FieldByName('Ano').AsString);
        DataLei^.TipoLei := TipoLei;

        DataLei^.SubItensCarregados := false;

        InsereNodeVazio(NodeLei);

        RCDAno.Next;

      end;
    RCDAno.Close;
    RCDAno.Destroy;


    Trv.EndUpdate;

    Screen.Cursor := crDefault;

end;

procedure TFrmPrincipal.CarregaListaLeis(TipoLei : Integer ; Ano: String; Node      : PVirtualNode );
var

  NodeLei   : PVirtualNode;
  Lei       : TRul_Lei;
  RCDLei    : TSQLQuery;
  DataLei   : PTreeData;
begin
  try

    Lei := TRul_Lei.Create();
    Lei.TipoLei := TipoLei;
    Lei.Ano := Ano;

    Screen.Cursor := crHourGlass;

    RCDLei := Lei.GetAll();

    Trv.NodeDataSize:=SizeOf(TTreeData);
    Trv.BeginUpdate;

    while not RCDLei.Eof do
      begin

        NodeLei := Trv.AddChild(Node);
        NodeLei.Parent := Node;

        //NodeLei.CheckState := csUncheckedNormal;
        NodeLei.CheckState := Node.CheckState;

        DataLei := Trv.GetNodeData(NodeLei);

        Trv.ValidateNode(NodeLei,False);

        DataLei^.Texto := Trim(RCDLei.FieldByName('Nome').AsString);
        DataLei^.Codigo := RCDLei.FieldByName('Lei').AsInteger;

        DataLei^.Tipo := TN_DocumentoHTML;
        DataLei^.Expandir := false;
        DataLei^.TipoLei := TipoLei;

        if RCDLei.FieldByName('Ementa').Value  <> null then
          DataLei^.Hint := Trim('' + RCDLei.FieldByName('Ementa').AsString);

        if RCDLei.FieldByName('Publicacao').Value  <> null then
          DataLei^.Publicacao := Trim( RCDLei.FieldByName('Publicacao').Value);

        DataLei^.SubItensCarregados := false;

        RCDLei.Next;


      end;
    RCDLei.Close;
    RCDLei.Destroy;

    Lei.Destroy;

    Trv.EndUpdate;

    Screen.Cursor := crDefault;

  Except

    Screen.Cursor := crDefault;


  end;
end;

function TFrmPrincipal.RetornaTituloLei(TipoLei : Integer ; NomeLei : String) : String;
var
  TituloLei : String;
begin
  TituloLei := '';
  case TipoLei of
    1:
      begin
        TituloLei := 'Decreto Nº ' + NomeLei;
      end;
    2:
      begin
        TituloLei := 'Decreto-Lei Nº ' + NomeLei;
      end;
    3:
      begin
        TituloLei := NomeLei;    // Decreto não numerado
      end;
    4:
      begin
        TituloLei := 'Lei Complementar Nº ' + NomeLei;
      end;
    5:
      begin
        TituloLei := ' Lei Delegada Nº ' + NomeLei;
      end;
    6:
      begin
        TituloLei := 'Lei Nº ' + NomeLei;
      end;
    7:
      begin
        if AnsiStartsText('EMENDA',NomeLei) then
          TituloLei := NomeLei
        else
          TituloLei := 'Constituição Federal de ' + NomeLei;
      end;
    8:
      begin
        TituloLei := NomeLei;
      end;
    9:
      begin
        TituloLei := 'Lei Imperial ' + NomeLei;
      end;
    10:
      begin
        TituloLei := 'Documento ' + NomeLei;
      end;
    11:
      begin
      end;
  end;

  result := TituloLei;
end;

function TFrmPrincipal.SubstituiOcorrenciasHTML(Texto : String ; Palavra : String ; HTMLSubstituicao : String): String;
var
 TextoHTML : String;
begin
  TextoHTML := Texto;
  TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Palavra + ' ' , ' ' + HTMLSubstituicao+ ' '  );
  TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Palavra + '.' , ' ' + HTMLSubstituicao+ '.'  );
  TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Palavra + ',' , ' ' + HTMLSubstituicao+ ','  );
  TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Palavra + ';' , ' ' + HTMLSubstituicao+ ';'  );

  TextoHTML := AnsiReplaceStr(TextoHTML , Palavra + ' ' , HTMLSubstituicao+ ' '  );
  TextoHTML := AnsiReplaceStr(TextoHTML , Palavra + '.' , HTMLSubstituicao+ '.'  );
  TextoHTML := AnsiReplaceStr(TextoHTML , Palavra + ',' , HTMLSubstituicao+ ','  );
  TextoHTML := AnsiReplaceStr(TextoHTML , Palavra + ';' , HTMLSubstituicao+ ';'  );

  TextoHTML := AnsiReplaceStr(TextoHTML , '"' + Palavra + ' ' , '"' + HTMLSubstituicao+ ' '  );
  TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Palavra + '"' , ' ' + HTMLSubstituicao+ '"'  );

  TextoHTML := AnsiReplaceStr(TextoHTML , '(' + Palavra + ' ' , '(' + HTMLSubstituicao+ ' '  );
  TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Palavra + ')' , ' ' + HTMLSubstituicao+ ')'  );
  TextoHTML := AnsiReplaceStr(TextoHTML , '(' + Palavra + ')' , '(' + HTMLSubstituicao+ ')'  );

  TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Palavra + '<' , ' ' + HTMLSubstituicao+ '<'  );
  TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Palavra + ' ' , '>' + HTMLSubstituicao+ ' '  );
  TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Palavra + '<' , '>' + HTMLSubstituicao+ '<'  );
  TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Palavra + '.' , '>' + HTMLSubstituicao+ '.'  );

  TextoHTML := AnsiReplaceStr(TextoHTML , '>' + Palavra + ')' , '>' + HTMLSubstituicao+ ')'  );

  TextoHTML := AnsiReplaceStr(TextoHTML , ',' + Palavra + ' ' , ',' + HTMLSubstituicao+ ' '  );
  TextoHTML := AnsiReplaceStr(TextoHTML , ' ' + Palavra + ',' , ' ' + HTMLSubstituicao+ ','  );

  Result := TextoHTML;

end;

procedure TFrmPrincipal.AtualizaPaginaAtual();
var
codigo : integer;

begin

  codigo := CodigoLeiAtual;

  CodigoLeiAtual :=-1; // para forcar a atualizacao
  VisualizaTextoLei(TipoLeiAtual, NomeLeiAtual, codigo, PublicacaoAtual , False, True);

end;

procedure TFrmPrincipal.VisualizaPaginaInicial();
var
  http                :  TAtualizacoesSistema;
  PaginaOK            : boolean;
  //NomeArquivo         : String;
  //Arquivo             : textfile;
  CaminhoArquivo      : String;
  //retorno : integer;
  Texto : String;
  Conteudo : TStringList;

begin

    PnlPesquisaBrowser.Visible := False;

    Lbl_IncluirAlterarNota.Enabled := false;
    Lbl_ExcluirNota.Enabled := false;

    http :=  TAtualizacoesSistema.Create(Browser);

    CaminhoArquivo := GetCurrentDir + '\Browser\PaginaInicial.htm';

    try
      Texto := IdHTTP1.Get(configuracoes.PaginaInicial);
      PaginaOK := true;
    except
      Texto := '';
      PaginaOK := false
    end;

    if PaginaOK then
      begin

        Conteudo := TStringList.Create;
        Conteudo.Add(TExto);
        Conteudo.SaveToFile(CaminhoArquivo);

        SalvaArquivosAssociadosPaginaExterna (http, CaminhoArquivo, 'http://www.elfez.com.br/lexmaximus/' ,  GetCurrentDir + '\Browser\');

        Browser.Refresh;
        Browser.LoadFromFile( CaminhoArquivo );
        Browser.PopupMenu := nil;
        ItmSelecionarTudo.Enabled := False;
        ItmCopiar.Enabled := False;
        ItmImprimir.Enabled := False;

      end
    else
      begin
        VisualizaDefault;
      end;

end;

Procedure TFrmPrincipal.VisualizaDefault();
Begin
  try

    PnlPesquisaBrowser.Visible := False;

    Lbl_IncluirAlterarNota.Enabled := false;
    Lbl_ExcluirNota.Enabled := false;

    Browser.Refresh;
    Browser.LoadFromFile( GetCurrentDir + '\Browser\Default.htm');
    Browser.PopupMenu := nil;

    ItmSelecionarTudo.Enabled := False;
    ItmCopiar.Enabled := False;
    ItmImprimir.Enabled := False;
    Browser.Enabled := true;
    BtnImprimir.Enabled := False;
    BtnCopiar.Enabled := False;

  finally

  end;
End;

Procedure TFrmPrincipal.SalvaArquivosAssociadosPaginaExterna(http : TAtualizacoesSistema; CaminhoArquivo : string; PaginaBase : string ;  DiretorioBase : string);
var
  Conteudo  : TStringList;

  Posicao1  : Integer;
  Posicao2  : Integer;
  Posicao3  : Integer;
  Posicao4  : Integer;

  //Arquivo   : TextFile;
  Temp      : string;
  TagIMG    : String;
  //Conteudo  : String;

begin

  try

    Conteudo  := TStringList.Create;
    Conteudo.LoadFromFile(CaminhoArquivo);

    temp := Conteudo.Text;
    
    Posicao1 := Ansipos( '<img' , temp);

    While Posicao1 <> 0 do
      begin

        Temp := Copy(temp , Posicao1, Length(temp)) ;

        Posicao2 := Ansipos( '>' , Temp);

        TagIMG := Copy(Temp, 1, Posicao2);
        
        //Consumindo o simbolo IMG
        Temp := Copy(Temp, Posicao2 , Length(Temp));

        //<img border="0" src="chaves.gif" width="325" height="129">
        Posicao3 := AnsiPos ( 'src' , TAGIMG);
        if Posicao3 <> 0 Then
          begin
            TAGIMG := Copy( TAGIMG, Posicao3, Length(TAGIMG));

            Posicao4 := AnsiPos ( ' ' , TAGIMG);

            TAGIMG := Copy( TAGIMG, 1, Posicao4);

            TAGIMG := AnsiReplaceText( TAGIMG, 'src', '');
            TAGIMG := AnsiReplaceText( TAGIMG, '=', '');
            TAGIMG := AnsiReplaceText( TAGIMG, '''', '');
            TAGIMG := AnsiReplaceText( TAGIMG, '"', '');

            if FileExists( DiretorioBase + '\' + TAGIMG ) Then DeleteFile( DiretorioBase + '\' + TAGIMG );

            http.SalvaArquivo( PaginaBase +  TAGIMG , DiretorioBase + '\' + TAGIMG );

          end;

        Posicao1 := Ansipos( '<img' , temp);
      end;
      
  finally

  end;

end;

Procedure TFrmPrincipal.AtualizaNavegacao();
begin
  try

     if HistoricoTipoLei = nil then
      begin
        HistoricoTipoLei := TStringList.Create;
      end;
     if HistoricoNomeTipoLei = nil then
      begin
        HistoricoNomeTipoLei := TStringList.Create;
      end;

     if HistoricoNomeLei = nil then
      begin
        HistoricoNomeLei := TStringList.Create;
      end;

     if HistoricoLeis = nil then
      begin
        HistoricoLeis := TStringList.Create;
      end;

     if HistoricoPublicacao = nil then
      begin
        HistoricoPublicacao := TStringList.Create;
      end;
      
     if HistoricoVerbetes = nil then
      begin
        HistoricoVerbetes := TStringList.Create;
        IndiceHistorico := -1;
      end;

      if (IndiceHistorico = -1) or (IndiceHistorico = 0) then
        begin
          BtnVoltarHistorico.Enabled := false;
          ItmVoltarHistorico.Enabled := false;
        end
      else
        begin

          BtnVoltarHistorico.Enabled := true;
          ItmVoltarHistorico.Enabled := true;
        end;

      if (IndiceHistorico = -1) or (IndiceHistorico = HistoricoVerbetes.Count-1) then
        begin
          BtnAvancarHistorico.Enabled := false;
          ItmAvancarHistorico.Enabled := false;
        end
      else
        begin
          BtnAvancarHistorico.Enabled := true;
          ItmAvancarHistorico.Enabled := true;
        end;

  finally

  end;
end;

Procedure TFrmPrincipal.VoltarHistorico();
begin
  try
    if IndiceHistorico > 0 then
      begin
      
        Dec( IndiceHistorico , 1);

        VisualizaTextoLei ( StrToInt( HistoricoTipoLei[IndiceHistorico] ), HistoricoNomeLei[IndiceHistorico] ,  StrToInt(HistoricoLeis[IndiceHistorico]) ,  HistoricoPublicacao[IndiceHistorico], False, True);

        AtualizaNavegacao();

      end;

  finally

  end;

end;

Procedure TFrmPrincipal.AvancarHistorico();
begin
  try
    if IndiceHistorico < HistoricoVerbetes.Count then
      begin


        Inc( IndiceHistorico , 1);

        VisualizaTextoLei ( StrToInt( HistoricoTipoLei[IndiceHistorico] ), HistoricoNomeLei[IndiceHistorico] ,  StrToInt(HistoricoLeis[IndiceHistorico]) , HistoricoPublicacao[IndiceHistorico], False, True);

        AtualizaNavegacao();

      end;

  finally

  end;
end;

{$ENDREGION}

{$REGION 'Metodos para visualizacao dos banners'}

Procedure TFrmPrincipal.VerificaDisponibilidadeInternet();

var
  Texto : String;
begin

  //CaminhoArquivo := RetornaDiretorioTemporario() + '\qwe09rq6e.htm';

  try
    Texto := IdHTTP1.Get(configuracoes.PaginaInicial);
    InternetDisponivel := True
  except
    InternetDisponivel := False;
  end;


    
end;

Procedure TFrmPrincipal.SelecionaOrigemBanner();
begin

  (**************************************
    Diretivas definidas em 05/11/2009 as 09:34

    01) se tiver tanto banner local, quando banner da internet
      -o programa vai exibir os banners da internet.

    02) se so existir banner local
      -o programa vai exibir banner local

    03) se so existir banner da internet
      -o programa vai exibir banner da internet

    04) se nao houver conexao com a internet
      - o programa vai usar os banners locais disponíveis
  ***************************************)
  
  OrigemBanner := TO_Nenhuma;
  IndiceBanner := 0;

  // caso 01 : tem banner local E banner de internet
  if (Configuracoes.ListaBannerLocal.Count >0) and ( Configuracoes.ListaBannerInternet.Count > 0 ) then
    begin
      OrigemBanner := TO_Internet;
      HabilitaSuspendeExibicaoBanner ( True);
      exit;
    end;

  // caso 02 : so tem bannner local
  if (Configuracoes.ListaBannerLocal.Count >0) and ( Configuracoes.ListaBannerInternet.Count = 0 ) then
    begin
      OrigemBanner := TO_Local;
      HabilitaSuspendeExibicaoBanner ( True);
      exit;
    end;

  // caso 03 : so tem bannner de internet
  if (Configuracoes.ListaBannerLocal.Count = 0) and ( Configuracoes.ListaBannerInternet.Count > 0 ) then
    begin
      OrigemBanner := TO_Internet;
      HabilitaSuspendeExibicaoBanner ( True);
      exit;
    end;

  // caso 04 : internet nao esta disponivel
  if (not InternetDisponivel) and ( Configuracoes.ListaBannerInternet.Count > 0 ) then
    begin
      OrigemBanner := TO_Local;
      HabilitaSuspendeExibicaoBanner ( True);
      exit;
    end;

  if (Configuracoes.ListaBannerLocal.Count = 0) and ( Configuracoes.ListaBannerInternet.Count = 0 ) then
    begin
      OrigemBanner := TO_Nenhuma;
      PnlBanner.Visible := false;
      exit;
    end;
end;

Procedure TFrmPrincipal.VerificaBannersInternet();
var
  I                         : Integer;
  Q                         : Integer;
  Link                      : String;
  nome                      : String;
  Arquivo                   : String;
  Posicao                   : integer;
  Diretorio                 : String;
  Retorno                   : Boolean;
  ListaAtualizada           : TStringList;
  ListaLinksAtualizada      : TStringList;
  LinkDirecionamento        : String;
  ArquivoDirecionamento     : String;
  ConteudoDirecionamento    : TStringList;

begin

  try
    if not InternetDisponivel then
      begin
        Configuracoes.ListaBannerInternet.Clear;
        exit;
      end;

    Diretorio := Configuracoes.RetornaDiretorioTrabalho + 'inf';

    if not DirectoryExists(Diretorio) then
      mkdir(Diretorio);

    Q := Configuracoes.ListaBannerInternet.Count-1;

    ListaAtualizada := TStringList.Create;
    ListaLinksAtualizada := TStringList.Create;
    ConteudoDirecionamento := TStringList.Create;

    for I := 0 to Q do
      begin
        Link := Configuracoes.ListaBannerInternet[i];
        LinkDirecionamento := Configuracoes.ListaLinkInternet[i];

        if (trim(link) <>'') and (trim(LinkDirecionamento) <>'') then
          begin

            Posicao := LastDelimiter('/', Link);

            if Posicao <= 0 then
              Posicao := LastDelimiter('\', Link);

            Nome := Copy(Link, Posicao+1);

            Arquivo := Diretorio + '\' + Nome;
            if FileExists(Arquivo) then
              DeleteFile(Arquivo);

            Retorno := DownloadArquivo(  Link , Arquivo);
            if Retorno  then
              begin
                ListaAtualizada.Add(Link);
              end
            else
              begin
                ListaAtualizada.Add('');
              end;

            ArquivoDirecionamento := Copy( Arquivo , 1, Length(Arquivo)-3) + 'txt' ;

            if FileExists(ArquivoDirecionamento) then
              DeleteFile (ArquivoDirecionamento);

           Retorno := DownloadArquivo(  LinkDirecionamento , ArquivoDirecionamento);
            if Retorno then
              begin

                ConteudoDirecionamento.LoadFromFile(ArquivoDirecionamento);

                if ConteudoDirecionamento.count >0 then
                  begin
                    if ContainsText(  ConteudoDirecionamento.Text , '<html>') then
                      begin
                        // remove a ultima imagem
                        //ListaAtualizada[i] := '';
                        //ListaAtualizada.Delete(i);
                        DeleteFile(Arquivo);


                        ListaLinksAtualizada.add('');
                      end
                    else
                      ListaLinksAtualizada.add(ConteudoDirecionamento[0])
                  end
                else
                  ListaLinksAtualizada.add('');

                ConteudoDirecionamento.Clear();

              end
            else
              ListaLinksAtualizada.add('');
          end;
      end;

    Configuracoes.ListaBannerInternet.Clear;
    Configuracoes.ListaLinkInternet.Clear;

    Q := ListaAtualizada.Count-1;
    for I := 0 to Q do
      begin
        Configuracoes.ListaBannerInternet.Add( ListaAtualizada[i] );
        Configuracoes.ListaLinkInternet.Add( ListaLinksAtualizada[i] );

      end;
  except
    on ex: exception do
      begin
      
      end;

  end;

end;

Procedure TFrmPrincipal.HabilitaSuspendeExibicaoBanner( Habilitar : Boolean);
begin

  TmrExibicaoBanner.Enabled := Habilitar;

  if HAbilitar then
    AlternaExibicaoBanner();


end;

Procedure TFrmPrincipal.AlternaExibicaoBanner();
var
  Diretorio : String;
  Arquivo : String;
  Nome : String;
  ArquivoInternet : String;
  //Retorno : Integer;
  Posicao : Integer;

  Quantidade : longint;


begin

  Arquivo := '';

  if OrigemBanner = TO_Internet then
    begin

      // sorteando qual banner sera exibido...
      Quantidade := Configuracoes.ListaBannerInternet.count-1;
      randomize;
      IndiceBanner := random(Quantidade);

      ArquivoInternet := Configuracoes.ListaBannerInternet[IndiceBanner];

      Posicao := LastDelimiter('/', ArquivoInternet);

      if Posicao <= 0 then
        Posicao := LastDelimiter('\', ArquivoInternet);

      Nome := Copy(ArquivoInternet, Posicao+1);

      Arquivo := Configuracoes.RetornaDiretorioTrabalho() + 'inf\' + Nome ;

      //inc(IndiceBanner, 1);
      //IndiceBanner := IndiceBanner Mod Configuracoes.ListaBannerInternet.Count;
    end;

  if OrigemBanner = TO_Local then
    begin
      // sorteando qual banner sera exibido...
      Quantidade := Configuracoes.ListaBannerLocal.count-1;
      randomize;
      IndiceBanner := random(Quantidade);

      Diretorio := GetCurrentDir() + '\inf\';
      Arquivo := Diretorio ;
      Arquivo := Arquivo +  Configuracoes.ListaBannerLocal[IndiceBanner];
      
      //inc(IndiceBanner, 1);
      //IndiceBanner := IndiceBanner Mod Configuracoes.ListaBannerLocal.Count;
    end;

  if not FileExists(Arquivo) then
    exit;

  if Arquivo <> ''  then
    begin
      ImgBanner2.Picture.LoadFromFile(Arquivo);
    end;

end;

procedure TFrmPrincipal.ApplicationEvents1Message(var Msg: tagMSG;  var Handled: Boolean);
var
   i: SmallInt;
begin
   if Msg.message = WM_MOUSEWHEEL then
   begin
     Msg.message := WM_KEYDOWN;
     Msg.lParam := 0;
     i := HiWord(Msg.wParam) ;
     if i > 0 then
       Msg.wParam := VK_UP
     else
       Msg.wParam := VK_DOWN;

     Handled := False;
   end;

end;

Procedure TFrmPrincipal.VisualizaBannerPrincipal();
//var
  //Arquivo                   : string;
  //Retorno                   : Integer;
  //ArquivoDirecionamento     : String;
  //LinkDirecionamento        : String;
  //ConteudoDirecionamento    : TStringList;
begin

  (**************************
  banner agora esta fixo
  if Configuracoes.Banner = '' then
    begin
      ImgBannerPrincipal.Visible := false;

    end
  else
    begin

      Arquivo := Configuracoes.RetornaDiretorioTrabalho + 'cima.gif';
      ArquivoDirecionamento := Configuracoes.RetornaDiretorioTrabalho + 'cima.txt';

      LinkDirecionamento := Copy( Configuracoes.Banner , 1 , Length(Configuracoes.Banner)-3) + 'txt';

      Retorno := UrlDownloadToFile( nil , PChar(configuracoes.Banner) , PChar(Arquivo) , 0 , nil);

      if Retorno >=0  then
        begin
          ImgBannerPrincipal.Visible := True;

          if FileExists(Arquivo) then
            ImgBannerPrincipal.Picture.LoadFromFile(Arquivo);
        end
      else
        begin
          ImgBannerPrincipal.Visible := False;
        end
    end;

    if FileExists(ArquivoDirecionamento) then
      DeleteFile(ArquivoDirecionamento);

    UrlDownloadToFile( nil , PChar(LinkDirecionamento) , PChar(ArquivoDirecionamento) , 0 , nil);

    if FileExists(ArquivoDirecionamento) then
      begin
        ConteudoDirecionamento := TStringList.Create();
        ConteudoDirecionamento.LoadFromFile(ArquivoDirecionamento);
        if ConteudoDirecionamento.Count >0 then
          LinkBannerPrincipal := ConteudoDirecionamento[0]
        else
          LinkBannerPrincipal := '';


      end
    else
      LinkBannerPrincipal := '';

  **************************)
end;


{$ENDREGION}

{$REGION 'Metodos para controle das scrollbars'}

Procedure TFrmPrincipal.AjustaScrollBarTreeView();
///var
  ///h: integer;
  //Maximo : Integer;
  //Minimo : Integer;
  ///Posicao : Integer;
begin

  (****************************

  Minimo := -1;
  Maximo := -1;

  trv.BeginUpdate;

  trv.ScrollBarOptions.ScrollBars := ssVertical;
  trv.UpdateVerticalScrollBar(false);
  GetScrollRange(TRv.Handle, SB_VERT, Minimo, Maximo);

  trv.ScrollBarOptions.ScrollBars := ssNone;

  trv.EndUpdate;

  ScrIndice.Min := Minimo;
  ScrIndice.Max := Maximo;
  ****************************)
  ScrIndice.Min := 1;
  ScrIndice.Max := trv.TotalCount * 4;


  (**********************************************

  h := 16;

  ScrIndice.Min         := 0;
  if Trv.RootNodeCount = 0 then
    ScrIndice.Max         := 1
  else
    ScrIndice.Max         :=  TotalItensTreeView * h;

  **********************************************)

  ScrIndice.SmallChange := trv.ScrollBarOptions.VerticalIncrement;
  ScrIndice.LargeChange := trv.ScrollBarOptions.VerticalIncrement;
  ScrIndice.ScrollInterval := 1;

  AjustandoScroll       := True;
  ScrIndice.Position    := 0;
  AjustandoScroll       := False;
  
end;

Procedure TFrmPrincipal.AjustaScrollBarBrowser();
var
  LargeChange : integer;

begin
  try

    AjustandoScrollBrowser := True;
    ScrBrowser.Min := Browser.VScrollBar.Min;

    if Browser.VScrollBar.Max = 0 then
      ScrBrowser.Max := 2
    else
      ScrBrowser.Max := Browser.VScrollBar.Max;

    LargeChange := ScrBrowser.Max div 10;

    if LargeChange = 0 then
      LargeChange := ScrBrowser.Max div 2;

    if LargeChange = 0 then
      LargeChange := 200;

    ScrBrowser.Position := 0 ; //Browser.VScrollBar.Position;
    ScrBrowser.SmallChange := LargeChange;
    ScrBrowser.LargeChange := LargeChange;
    ScrBrowser.ScrollInterval := 1;

    AjustandoScrollBrowser := False;


    ScrBrowser.Repaint;

  finally
  end;

end;

{$ENDREGION}

{$REGION 'Metodos para Controlar o Hint'}

Procedure TFrmPrincipal.ExibeHint(Texto : String; Publicacao : String; Y : Integer; X : Integer);
begin
  try

    LblHint.Width := PnlHint.Width - 20;
    
    LblHint.Caption := Texto + '   ';
    Application.ProcessMessages;
    PnlHint.Left := x;
    PnlHint.Top := y;
    PnlHint.Width := LblHint.Width + 50;
    PnlHint.Height := LblHint.Height + 10;

    if Publicacao <> '' then
      begin
       LblPublicacao.caption := Publicacao;
       LblPublicacao.Width := PnlHint.Width;
       LblPublicacao.Left := 5;
       LblPublicacao.Top := LblHint.Top + LblHint.Height + 2 ;

       PnlHint.Height := PnlHint.Height + LblPublicacao.Height;
      end;

    PnlHint.Visible := True;

  finally

  end;
end;

Procedure TFrmPrincipal.EscondeHint();
begin
  try

    LblHint.Caption := '';
    PnlHint.Visible := False;
    Node_Com_Hint := nil;

  finally

  end;
end;

{$ENDREGION}

{$REGION 'Metodos para alteracao de conteudo das listas'}

procedure TFrmPrincipal.VisualizaHistorico();
var
  I       : Integer;
  Q       : Integer;
  Node    : PVirtualNode;
  Data    : PTreeData;
begin

  try

    ConteudoAtual := TC_Historico;

    //Preenchendo a arvore com o histórico

    Trv2.NodeDataSize:=SizeOf(TTreeData);
    Trv.Visible := False;
    ScrIndice.Visible := False;

    Trv2.Visible := True;

    Trv2.BeginUpdate;
    Trv2.Clear;

    Q := HistoricoVerbetes.Count-1;
    for I := 0 to Q do
      begin
        Node := Trv2.AddChild( nil );
        Data := Trv2.GetNodeData(Node);
        Trv2.ValidateNode(Node,False);

        Data^.Texto := HistoricoNomeLei[i];
        Data^.Codigo := StrToInt( HistoricoLeis[i] );

        Data^.Tipo := TN_DocumentoHTML;
        Data^.Expandir := false;
        Data^.Hint := '';
        Data^.TipoLei := StrToInt(HistoricoTipoLei[i]);

        Data^.SubItensCarregados := true;
        
      end;

    Trv2.EndUpdate;

    VisualizaDefault();

    CodigoLeiAtual := -1;

    BtnBuscar.Visible := false;
    BtnVoltarIndice.Visible := True;
    BtnIndice.Enabled := true;
    
  Except
    on ex : Exception do
      begin
        MessageBox(Self.Handle, PAnsiChar(Ex.Message), 'LexMaximus', MB_OK OR MB_ICONERROR  );
      end;
  end;

end;

procedure TFrmPrincipal.VisualizaNotas();
var
  Node    : PVirtualNode;
  Data    : PTreeData;
  Notas   : TRul_NotaLei;
  Rcd     : TSQLQuery;
begin

  try

    ConteudoAtual := TC_Notas;

    //Preenchendo a arvore com o histórico

    Trv2.NodeDataSize:=SizeOf(TTreeData);
    Trv.Visible := False;
    ScrIndice.Visible := False;

    Trv2.Visible := True;

    Trv2.BeginUpdate;
    Trv2.Clear;

    Notas   := TRul_NotaLei.Create();
    Rcd := Notas.GetAll2();

    while not Rcd.Eof do
      begin

        Node := Trv2.AddChild( nil );
        Data := Trv2.GetNodeData(Node);
        Trv2.ValidateNode(Node,False);

        Data^.Texto                 := Trim(Rcd.FieldByName('Nome').AsString);
        Data^.Codigo                := Rcd.FieldByName('Lei').AsInteger ;
        Data^.Tipo                  := TN_DocumentoHTML;
        Data^.Expandir              := false;
        Data^.Hint                  := Trim(Rcd.FieldByName('Ementa').AsString);
        Data^.TipoLei               := Rcd.FieldByName('TipoLei').AsInteger;
        Data^.SubItensCarregados    := true;

        Rcd.Next;
      end;

    Trv2.EndUpdate;

    Rcd.close;
    Rcd.Destroy;
    Notas.Destroy;

    VisualizaDefault();

    CodigoLeiAtual := -1;

    BtnBuscar.Visible := false;
    BtnVoltarIndice.Visible := True;
    BtnIndice.Enabled := true;

  Except
    on ex : Exception do
      begin
        MessageBox(Self.Handle, PAnsiChar(Ex.Message), 'LexMaximus', MB_OK OR MB_ICONERROR  );
      end;
  end;

end;

procedure TFrmPrincipal.VisualizaIndice();
begin

  ConteudoAtual := TC_Indice;

  //Os indices ja são carregados automaticamente, na criacao do formulario

  Trv2.Visible := False;
  Trv2.Clear;

  Trv.Visible := True;
  ScrIndice.Visible := True;

  VisualizaDefault();

  CodigoLeiAtual := -1;

  BtnBuscar.Visible := True;
  BtnVoltarIndice.Visible := False;
  BtnIndice.Enabled := False;

end;

{$ENDREGION}

{$REGION 'Metodos de edicao do conteudo'}

Function TFrmPrincipal.RemoveTag( Texto: String; TextoInicio : String; TextoFim: String; TextoSubstituicao : String) : String;
var
  Inicio      : Integer;
  Fim         : Integer;
  I           : Integer;
  Temp2       : String;

begin

  try

  Inicio := Pos(TextoInicio, Texto);

    while Inicio > 0 do
      begin

        Application.ProcessMessages;

        //Procurando o final do ' <a '
        if Length(TextoFim) = 1 then
          begin
            Fim := 0;
            I := Inicio;
            while Fim = 0 do
              begin

                if Texto[i] = TextoFim then
                  Fim := I
                else
                  inc(I,1);
              end;
            Temp2 := Copy(Texto,Inicio, Fim-Inicio+1);
          end
        else
          begin
            Fim := Pos(TextoFim, Texto);
            Temp2 := Copy(Texto,Inicio, Fim-Inicio+ Length(TextoFim));
          end;

        Texto := ReplaceStr(Texto, Temp2, TextoSubstituicao);

        if TextoSubstituicao <> '' then
          Inicio := -1
        else
          Inicio := Pos(TextoInicio, Texto);

        Application.ProcessMessages;

      end;

    Result := Texto;
  Except
    on ex : Exception do
      begin

      end;

  end;
end;


{$ENDREGION}

{$REGION 'Metodos para configuracao de uso a partir do CD'}

Procedure TFrmPrincipal.ConfiguraPastaTrabalho();
var
  DiretorioOrigem : String;
  DiretorioDestino : String;
  ArquivoOrigem : String;
  //ArquivoDestino : String;
  Frm : TFrmAjusteExecucaoCD;

  Arquivo_Verge_Destino : String;
  Arquivo_CSS_Destino : String;
  Arquivo_MDB_Destino : String;
  Arquivo_DAT_Destino : String;

  Atributos : Integer;

begin

  try
    DiretorioOrigem := GetCurrentDir();
    DiretorioDestino := Configuracoes.RetornaDiretorioTrabalho();

    Arquivo_Verge_Destino := DiretorioDestino + 'Browser\verge.gif';
    Arquivo_CSS_Destino := DiretorioDestino + 'Browser\StyleSheet.css';

    //Copiando pasta Browser
    //MessageBox(Self.Handle , 'Copiando pasta Browser', 'Execução pelo CD', MB_OK);
    try
    if not DirectoryExists(DiretorioDestino + 'Browser') then
      mkdir(DiretorioDestino + 'Browser');
    finally

    end;

    // Arquivo do Verge
    //MessageBox(Self.Handle , 'Arquivo do Verge', 'Execução pelo CD', MB_OK);
    ArquivoOrigem := DiretorioOrigem + '\Browser\verge.gif';
    if not FileExists(Arquivo_Verge_Destino) then
      CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(Arquivo_Verge_Destino) , False );

    // Arquivo CSS
    //MessageBox(Self.Handle , 'Arquivo CSS', 'Execução pelo CD', MB_OK);
    ArquivoOrigem := DiretorioOrigem + '\Browser\StyleSheet.css';
    if not FileExists(Arquivo_CSS_Destino) then
      CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(Arquivo_CSS_Destino) , False );

    if Configuracoes.ExecutarCD then
      begin
        ///ConfiguracaoOK := False;

        Arquivo_MDB_Destino := DiretorioDestino + 'Dados\LexMaximus.mdb';
        Arquivo_DAT_Destino := DiretorioDestino + 'LexMaximus.dat';

        if (FileExists(Arquivo_MDB_Destino)) AND (FileExists(Arquivo_DAT_Destino)) then
          begin
            //MessageBox(Self.Handle , 'Banco de Dados ja existe', 'Execução pelo CD', MB_OK);
            exit;
          end;

        Frm := TFrmAjusteExecucaoCD.Create(self);

        Frm.ParentWindow := Self.Handle;
        Frm.Show();
        Frm.IniciaCopia();
        Application.ProcessMessages;

        //Copiando pasta Dados
        if not DirectoryExists(DiretorioDestino + 'Dados') then
          mkdir(DiretorioDestino + 'Dados');
        Application.ProcessMessages;

        //Copiando ENCICLOPEDIA.GDB
        ArquivoOrigem := DiretorioOrigem + '\Dados\ENCICLOPEDIA.GDB';
        if not FileExists(Arquivo_MDB_Destino) then
          CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(Arquivo_MDB_Destino) , False );
        Application.ProcessMessages;

        Atributos := FileGetAttr(Arquivo_MDB_Destino);
        Atributos := ((Atributos) and (not SysUtils.FaReadOnly));
        if FileSetAttr(Arquivo_MDB_Destino ,Atributos)<>0 then
          MessageBox( Self.Handle, 'Não foi possivel alterar um atributo do banco de dados','Erro do LexMaximus', MB_OK);

        Application.ProcessMessages;

        //Copiando arquivo DAT
        //MessageBox(Self.Handle , 'Copiando arquivo DAT', 'Execução pelo CD', MB_OK);
        ArquivoOrigem := DiretorioOrigem + '\LexMaximus.dat';
        if not FileExists(Arquivo_DAT_Destino) then
          CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(Arquivo_DAT_Destino) , False );
        Application.ProcessMessages;

        Atributos := FileGetAttr(Arquivo_DAT_Destino);
        Atributos:=Atributos and not SysUtils.faReadOnly;
        if FileSetAttr(Arquivo_DAT_Destino ,Atributos)<>0 then
          MessageBox( Self.Handle, 'Não foi possivel alterar um atributo do arquivo de configurações','Erro do LexMaximus', MB_OK);
        Application.ProcessMessages;

        Frm.FinalizaCopia();
        Application.ProcessMessages;
        Frm.Hide();
        Frm.Close();

        Application.ProcessMessages;

      end;
  except
    on ex : Exception do
      begin
        MessageBox( Self.Handle, PChar('Erro na criação da pasta de trabalho: ' + Ex.Message), 'Erro do LexMaximus', MB_OK);
      end;
  end;
end;

{$ENDREGION}

{$REGION 'Metodos de uso geral'}

Procedure TFrmPrincipal.ImprimeConteudoBrowser();
begin
  try

    Browser.Print( 1, Browser.NumPrinterPages );

  finally

  end;
end;

Procedure TFrmPrincipal.CopiaConteudoBrowserClipboard();
var
  HTML : String;
  HTML2 : String;
  Inicio: Integer;
  Fim : Integer;
  StSrc : Integer;
  EnSrc : Integer;
  PTag : Integer;
  Texto : String;
  TextoHTML : String;
  I : Integer;
  Q : Integer;
  Letra : Char;
  TagRemocao : String;
  GlifoRemocao : String;

begin
    try

    //Browser.CopyToClipboard();

    I:=1;
    Texto := '';
    TextoHTML := '';

    HTML := Browser.DocumentSource;

    if Browser.SelLength <> 0 then
      begin
        StSrc := Browser.FindSourcePos(Browser.SectionList.SelB)+1;
        EnSrc := Browser.FindSourcePos(Browser.SectionList.SelE);

        if EnSrc < 0 then    {check to see if end selection is at end of document}
          begin
          EnSrc := Length(HTML);
          if HTML[EnSrc] = '>' then
            begin
            HTML := HTML + ' ';
            Inc(EnSrc);
            end;
          end
        else EnSrc := EnSrc + 1;

        //Tentando pegar a ultima tag antes do inicio, para evitar ma formatacao
        HTML2 := Copy(HTML,1 , StSrc-1);
        PTag := LastDelimiter('<' , HTML2);
        HTML2 := Copy(HTML2, PTag);

        HTML := HTML2 + Copy(HTML, StSrc, EnSrc-StSrc);

        //Removendo o cabecalho...
        if Pos('<body', HTML) >0 then
          HTML := Copy(HTML,Pos('<body', HTML));
      end;

    Q := Length(HTML);

    while (I <=Q) do
      begin
        Letra := HTML[i];
        if Letra = '<' then
          begin

            TagRemocao := '';

            while Letra<> '>' do
              begin
                TagRemocao := TagRemocao + Letra;
                inc(I);
                Letra := HTML[i];
              end;

            TagRemocao := ansiLowerCase( TagRemocao + Letra);

            if (TagRemocao='<br>') OR (TagRemocao='</p>') OR (TagRemocao='</table>') then
              begin
                Texto := Texto + chr(13) + chr(10);
                TextoHTML := TextoHTML + '<br>';
              end;

            if (TagRemocao = '<strike>') or (TagRemocao = '</strike>') then
              begin
                //Texto := Texto + TagRemocao;
                TextoHTML := TextoHTML + TagRemocao;
              end;
          end
        else
          begin
            if Letra = '&' then
              begin
                GlifoRemocao := '';
                while Letra<> ';' do
                  begin
                    GlifoRemocao := GlifoRemocao + Letra;
                    inc(I);
                    Letra := HTML[i];
                  end;

                GlifoRemocao := ansiLowerCase( GlifoRemocao + Letra);

                if GlifoRemocao = '&nbsp;' then
                  begin
                    Texto := Texto + ' ';
                    TextoHTML := TextoHTML + ' ';
                  end;
              end
            else
              begin
                if (Letra <> chr(9)) and (Letra <> chr(10)) and (Letra <> chr(13)) then
                  begin
                    Texto := Texto + Letra;
                    TextoHTML := TextoHTML + Letra ;
                  end;
                if (Letra = chr(10))  then
                  begin
                    Texto := Texto + ' ' ;
                    TextoHTML := TextoHTML + ' ' ;
                  end;
              end;
          end;
        inc(I);

      end;

    TextoHTML := AnsiToUtf8(TextoHTML);
    CopyHTMLToClipBoard(Texto, TextoHTML);

  finally

  end;

end;

Procedure TFrmPrincipal.ExpandeContraiArvore( NodePai : PVirtualNode );
var
  i       : integer;
  q       : integer;
  Node    : PVirtualNode;
  Data    : PTreeData;

begin
  try

  q := NodePai.ChildCount-1;

  if q <=0 then
    exit;

  node := NodePai.FirstChild;

  trv.BeginUpdate;

  for I := 0 to q do
    begin

      Data      :=  Trv.GetNodeData(Node);

      if Chk_Expandir_Tudo_Checked then
        begin

          if not Data^.SubItensCarregados then
            begin
              //Achiles: 27/09/2010
              //if (( (Data^.Codigo  >= 7) and (Data^.Codigo  < 10) ) or (Data^.Codigo = 4) or  (Data^.Codigo = 5)) then
              //  begin
              //    CarregaListaLeis(Data^.Codigo, '' , Node);
              //  end
              //else

              if ( (Data^.Codigo  = 7) or (Data^.Codigo  =8) ) then
                CarregaListaLeis(Data^.Codigo, '' , Node)
              else
                CarregaAnoTipoLei(Data^.Codigo , Node);

              Data^.SubItensCarregados := True;
            end;


        if not CarregandoFormulario then
            trv.FullExpand(Node)
        end
      else
        begin
          trv.FullCollapse(Node);
        end;

      node := Node.NextSibling;
      
    end;

  trv.EndUpdate;
  
  finally

  end;

end;

Procedure TFrmPrincipal.MarcaDesmarcaTiposLei( NodePai : PVirtualNode );
var
  i : integer;
  q : integer;
  Node: PVirtualNode;
begin
  try

  q := NodePai.ChildCount-1;

  if q <=0 then
    exit;

  node := NodePai.FirstChild;

  trv.BeginUpdate;

  for I := 0 to q do
    begin


      if Chk_Selecionar_Tudo_Checked then
        node.CheckState := csCheckedNormal
      else
        node.CheckState := csUncheckedNormal;

      MarcaDesmarcaTiposLei(node);

      node := Node.NextSibling;

    end;

  trv.EndUpdate;

  finally

  end;
end;

Procedure TFrmPrincipal.MarcaDesmarcaTiposLei( NodePai : PVirtualNode ; Estado : TCheckState );
var
  i : integer;
  q : integer;
  Node: PVirtualNode;
begin
  try

  q := NodePai.ChildCount-1;

  if q <=0 then
    exit;

  node := NodePai.FirstChild;

  trv.BeginUpdate;

  for I := 0 to q do
    begin

      node.CheckState := Estado;

      MarcaDesmarcaTiposLei(node, Estado);

      node := Node.NextSibling;

    end;

  trv.EndUpdate;

  finally

  end;
end;

Procedure TFrmPrincipal.CarregaConfiguracoes();
//var
//  Diretorio : String;
begin

  ResolucaoMonitor := ObtemResolucaoSistema;

  Configuracoes := TConfiguracoes.Create();

  DiretorioSistema              := GetCurrentDir;
  DiretorioImagens              := GetCurrentDir + '\Imagens\';
  DiretorioBrowser              := GetCurrentDir + '\Browser\';
  DiretorioDados                := GetCurrentDir + '\Dados\';
  DiretorioDocumentos           := GetCurrentDir + '\Doc\';

  DiretorioImagensResolucao     := GetCurrentDir + '\Imagens\' + ResolucaoMonitor;
  DiretorioImagensObjetos       := GetCurrentDir + '\Imagens\Objetos';
  DiretorioHTML                 := GetCurrentDir + '\HTML';

  ConexaoSrvAtu := TCls_Conexao.Create();
  ConexaoSrvAtu.StringConexao := Configuracoes.StringConexaoSrvAtu;


  ControleAtualizacoes := TDownloadAtualizacoes.Create();
  ControleAtualizacoes.ConexaoSrvAtu := ConexaoSrvAtu;
  ControleAtualizacoes.Configuracoes := Configuracoes;
  ControleAtualizacoes.ConfiguracoesLogin := ConfigLogin;

  ConfiguraPastaTrabalho();

  DiretorioDados                := configuracoes.RetornaDiretorioTrabalho() + '\Dados\';

  zlib := TCompressaoDados.Create();

  CarregaImagensObjetos();

  //MessageBox(Self.Handle , 'Configuração concluida com sucesso', '', MB_OK);

  CarregaConfiguracoesAparencia();

  //MessageBox(Self.Handle , 'Configuração de APARENCIA concluida com sucesso', '', MB_OK);

  ListaPalavrasSelecao := TStringList.Create();
  
  ListaPalavrasSelecaoBrowser := TStringList.Create();

  VerificandoAtualizacoes := false;

end;

Procedure TFrmPrincipal.CarregaConfiguracoesAparencia();
begin

  trv.Font := Configuracoes.FonteLista;
  trv2.Font := Configuracoes.FonteLista;

  PnlSuperior.Color := Configuracoes.CorFundo;
  PnlHint.Color := Configuracoes.CorFundo;
  ToolBar1.Color := Configuracoes.CorFundo;

  SkinData1.SkinFile := '.\Skins\' + Configuracoes.ArquivoSkin;


end;

Procedure TFrmPrincipal.ConfiguraOpcoesPesquisa();
begin

  Chk_Numero_Checked          := false;
  Chk_Busca_E_Checked         := false;
  Chk_Busca_OU_Checked        := false;
  Chk_Busca_Frase_Checked     := false;

  Chk_Artigo_Browser_Checked          := false;
  Chk_Busca_E_Browser_Checked         := false;
  Chk_Busca_OU_Browser_Checked        := false;
  Chk_Busca_Frase_Browser_Checked     := false;

  Chk_Selecionar_Tudo_Checked := true;
  Chk_Expandir_Tudo_Checked   := true;

  PesquisaSelecionada := TP_Nenmhum;

  DesmarcaOpcao(TP_Numero);
  DesmarcaOpcao(TP_E);
  DesmarcaOpcao(TP_OU);
  DesmarcaOpcao(TP_Frase);

  DesmarcaOpcaoBrowser(TP_Numero);
  DesmarcaOpcaoBrowser(TP_E);
  DesmarcaOpcaoBrowser(TP_OU);
  DesmarcaOpcaoBrowser(TP_Frase);

  Chk_Selecionar_Tudo_Checked := True;
  Chk_Selecionar_TudoClick(Chk_Selecionar_Tudo);

  Chk_Expandir_Tudo_Checked := true;
  Chk_Expandir_TudoClick (Chk_Expandir_Tudo);


end;

Procedure TFrmPrincipal.ExibeJanelaAtivacao();

var
  frm       : TFrmAtivacao;


begin

  frm := TFrmAtivacao.Create(self);
  frm.DiretorioDocumentos := DiretorioDocumentos;
  frm.ControleLicenca := ControleLicenca;
  frm.Configuracoes := Configuracoes;

  //frm.ConfiguraJanela();

  frm.ShowModal;

  if frm.SistemaValidado then
    begin

      ControleLicenca.SerialCliente := frm.SerialCliente;

      ControleLicenca.TipoLicenca := LicencaFull;

      if not ControleLicenca.SalvaDadosCodigos() then
        ExibeMensagemAlertaAdministrador;

    end
  else
    begin

    end;

end;

procedure TFrmPrincipal.Mensagem( Mensagem : String ; Titulo : String);

var frm : TFrmMessage;

begin
  try

    frm := TFrmMessage.Create( self );
    frm.Configuracoes := Self.Configuracoes;
    frm.MensagemInformacao( Mensagem, Titulo);

    frm.Free;

  finally
  end;
end;

function TFrmPrincipal.Pergunta( Mensagem : String ; Titulo : String) : integer;

var
  frm : TFrmMessage;

begin
  try

    frm := TFrmMessage.Create( self );
    frm.Configuracoes := Self.Configuracoes;
    frm.MensagemPergunta( Mensagem, Titulo);

    Pergunta := frm.Resultado;

    frm.Free;

  finally
  end;
end;

function TFrmPrincipal.RetornaVersaoWindows: TWinVersion;
var
   osVerInfo: TOSVersionInfo;
   majorVersion, minorVersion: Integer;
begin

   Result := wvUnknown;
   osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo) ;
   if GetVersionEx(osVerInfo) then
   begin
     minorVersion := osVerInfo.dwMinorVersion;
     majorVersion := osVerInfo.dwMajorVersion;
     case osVerInfo.dwPlatformId of
       VER_PLATFORM_WIN32_NT:
       begin
         if majorVersion <= 4 then
           Result := wvWinNT
         else if (majorVersion = 5) and (minorVersion = 0) then
           Result := wvWin2000
         else if (majorVersion = 5) and (minorVersion = 1) then
           Result := wvWinXP
         else if (majorVersion = 6) then
           Result := wvWinVista;
       end;
       VER_PLATFORM_WIN32_WINDOWS:
       begin
         if (majorVersion = 4) and (minorVersion = 0) then
           Result := wvWin95
         else if (majorVersion = 4) and (minorVersion = 10) then
         begin
           if osVerInfo.szCSDVersion[1] = 'A' then
             Result := wvWin98SE
           else
             Result := wvWin98;
         end
         else if (majorVersion = 4) and (minorVersion = 90) then
           Result := wvWinME
         else
           Result := wvUnknown;
       end;
     end;
   end;
end;

function TFrmPrincipal.VerificaUsuarioAdministrador() : Boolean;
begin

  if  UsuarioLogadoAdministrador() then
    Result := True
  else
    begin
      Result := False;

      ExibeMensagemAlertaAdministrador;
    end;
  
end;

procedure TFrmPrincipal.ExibeMensagemAlertaAdministrador;

var
  frm : TFrmAdministrador;

begin
  try

    frm := TFrmAdministrador.Create( self );
    frm.Configuracoes := Configuracoes;
    frm.DiretorioDocumentos := DiretorioDocumentos;
    frm.ShowModal;

    frm.Free;

  finally
  end;


end;

function TFrmPrincipal.RetornaNomeVersaoWindows: String;

var
  Versao : TWinVersion;
begin

  Versao := RetornaVersaoWindows;

  case Versao of
    wvUnknown:
      Result := 'Versão desconhecida';
    wvWin95:
      Result := 'Windows 95';
    wvWin98:
      Result := 'Windows 98';
    wvWin98SE:
      Result := 'Windows 98SE';
    wvWinNT:
      Result := 'Windows NT';
    wvWinME:
      Result := 'Windows ME';
    wvWin2000:
      Result := 'Windows 2000';
    wvWinXP:
      Result := 'Windows XP';
    wvWinVista:
      Result := 'Windows Vista';
  end;

end;

function TFrmPrincipal.UsuarioLogadoAdministrador: Boolean;
const
  DOMAIN_ALIAS_RID_ADMINS = $00000220;

function IsMemberOfGroup(const DomainAliasRid: DWORD): Boolean;
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  SE_GROUP_ENABLED           = $00000004;
  SE_GROUP_USE_FOR_DENY_ONLY = $00000010;
  
var
  Sid: PSID;
  CheckTokenMembership: function(TokenHandle: THandle; SidToCheck: PSID;
    var IsMember: BOOL): BOOL; stdcall;
  IsMember: BOOL;
  Token: THandle;
  GroupInfoSize: DWORD;
  GroupInfo: PTokenGroups;
  I: Integer;
begin
  if Win32Platform <> VER_PLATFORM_WIN32_NT then begin
    Result := True;
    Exit;
  end;

  Result := False;

  if not AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
     SECURITY_BUILTIN_DOMAIN_RID, DomainAliasRid,
     0, 0, 0, 0, 0, 0, Sid) then
    Exit;
  try
    { Use CheckTokenMembership if available. MSDN states:
      "The CheckTokenMembership function should be used with Windows 2000 and
      later to determine whether a specified SID is present and enabled in an
      access token. This function eliminates potential misinterpretations of
      the active group membership if changes to access tokens are made in
      future releases." }
    CheckTokenMembership := nil;
    if Lo(GetVersion) >= 5 then
      CheckTokenMembership := GetProcAddress(GetModuleHandle(advapi32),
        'CheckTokenMembership');
    if Assigned(CheckTokenMembership) then begin
      if CheckTokenMembership(0, Sid, IsMember) then
        Result := IsMember;
    end
    else begin
      GroupInfo := nil;
      if not OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True,Token) then begin
        if GetLastError <> ERROR_NO_TOKEN then
          Exit;
        if not OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, Token) then
          Exit;
      end;
      try
        GroupInfoSize := 0;
        if not GetTokenInformation(Token, TokenGroups, nil, 0, GroupInfoSize) and
           (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
          Exit;

        GetMem(GroupInfo, GroupInfoSize);
        if not GetTokenInformation(Token, TokenGroups, GroupInfo,
           GroupInfoSize, GroupInfoSize) then
          Exit;

        for I := 0 to GroupInfo.GroupCount-1 do begin
          if EqualSid(Sid, GroupInfo.Groups[I].Sid) and
             (GroupInfo.Groups[I].Attributes and (SE_GROUP_ENABLED or
              SE_GROUP_USE_FOR_DENY_ONLY) = SE_GROUP_ENABLED) then begin
            Result := True;
            Break;
          end;
        end;
      finally
        FreeMem(GroupInfo);
        CloseHandle(Token);
      end;
    end;
  finally
    FreeSid(Sid);
  end;
end;

begin
  Result := IsMemberOfGroup(DOMAIN_ALIAS_RID_ADMINS);
end;


{$REGION 'Atualizacoes Automaticas'}

Function TFrmPrincipal.ConectaServidorRemoto() : Boolean;

begin
  try
    if ConexaoSrvAtu.StringConexao = '' then
      begin
        Result := False;
        exit;
      end
    else
      begin
        Result := ConexaoSrvAtu.AbreConexao()  ;
      end;

  except
    Result := False;
  end;
end;

procedure TFrmPrincipal.thread_VerificacaoAtualizacoes_Terminate(Sender: TObject);
var
  TotalAtualizacoes : Integer;
  MensagemAtualizacoes : String;
  FormMensagemErroBancoDados : TFrmMensagemErroBancoDados;

begin
  try

    TotalAtualizacoes := 0;

    ConexaoSrvAtu.FechaConexao();

    if thread_VerificacaoAtualizacoes.ErroServidor then
      begin
        FormMensagemErroBancoDados := TFrmMensagemErroBancoDados.Create(self);
        FormMensagemErroBancoDados.ShowModal();
        exit;
      end;

    if not thread_VerificacaoAtualizacoes.VerificacaoRealizada then
      exit;
    
    if thread_VerificacaoAtualizacoes.AssinaturaExpirou then
      begin
        LblAssinaturaExpirou.Visible := True;
        Application.ProcessMessages;
        
        if FormAssinaturaExpirou = nil then
          FormAssinaturaExpirou := TFrmAssinaturaExpirou.Create(self);

        FormAssinaturaExpirou.Configuracoes := Configuracoes;
        FormAssinaturaExpirou.DiretorioBrowser := DiretorioBrowser;
        FormAssinaturaExpirou.ControleAtualizacoes := ControleAtualizacoes;
        FormAssinaturaExpirou.VerificarAtualizacoesAnteriores := false;
        FormAssinaturaExpirou.ShowModal();

        Windows.SetParent(FormAssinaturaExpirou.Handle , Self.Handle );

        if FormAssinaturaExpirou.VerificarAtualizacoesAnteriores then
          begin

            if frmatualizacoes = nil then
              FrmAtualizacoes := TFrmAtualizacoes.Create(self);

            FrmAtualizacoes.ConfiguracoesLogin := ConfigLogin;
            FrmAtualizacoes.Configuracoes := Configuracoes;
            FrmAtualizacoes.ConexaoSrvAtu := ConexaoSrvAtu;
            FrmAtualizacoes.DiretorioSistema := DiretorioSistema;
            FrmAtualizacoes.DiretorioBrowser := DiretorioBrowser;
            FrmAtualizacoes.ControleAtualizacoes := ControleAtualizacoes;

            FrmAtualizacoes.lst_LM.Items.Clear();

            FrmAtualizacoes.VerificarAtualizacoesAnteriores := True;

            FrmAtualizacoes.VerificaAtualizacoes();

            FrmAtualizacoes.ShowModal();

            if FrmAtualizacoes.AtualizarListaVerbetes then
              begin
                Application.ProcessMessages;

                Application.ProcessMessages;
              end;
             FreeAndNil(FrmAtualizacoes);
          end;

      end
    else
      begin

        if thread_VerificacaoAtualizacoes.TotalAtualizacoes=0 then
          begin
            Screen.cursor := crDefault;
            Mensagem ( 'Não foram encontradas atualizações', 'Atualizações do LexMaximus');
          end
        else
          begin
            if TotalAtualizacoes = 1 then
              MensagemAtualizacoes := 'Existe 1 atualizaçção disponível.' + chr(13) + ' Deseja atualizar o sistema?'
            else
              MensagemAtualizacoes := 'Existem ' + IntToStr(thread_VerificacaoAtualizacoes.TotalAtualizacoes) + ' atualizações disponíveis .' + chr(13) + ' Deseja atualizar o sistema?';

            if pergunta(MensagemAtualizacoes, 'Atualizações Automáticas' ) = IDYES then
              begin

                if frmatualizacoes = nil then
                  FrmAtualizacoes := TFrmAtualizacoes.Create(self);

                FrmAtualizacoes.ConfiguracoesLogin := ConfigLogin;
                FrmAtualizacoes.Configuracoes := Configuracoes;
                FrmAtualizacoes.ConexaoSrvAtu := ConexaoSrvAtu;
                FrmAtualizacoes.DiretorioSistema := DiretorioSistema;
                FrmAtualizacoes.DiretorioBrowser := DiretorioBrowser;
                FrmAtualizacoes.ControleAtualizacoes := ControleAtualizacoes;

                FrmAtualizacoes.lst_LM.Items.Clear();

                FrmAtualizacoes.VerificarAtualizacoesAnteriores := False;
                //FrmAtualizacoes.BtnBaixarAtualizacoesSelecionadas.Visible := True;
                //FrmAtualizacoes.BtnProcurarAtualizacoes.Visible := True;

                FrmAtualizacoes.VerificaAtualizacoes();
                FrmAtualizacoes.ShowModal();

                if FrmAtualizacoes.AtualizarListaVerbetes then
                  begin
                    //DetectaVerbetesBase();
                    Application.ProcessMessages;

                    //CarregaVerbetes();
                    Application.ProcessMessages;
                  end;
                FreeAndNil(FrmAtualizacoes);
              end;
          end;
      end;
    //thread_VerificacaoAtualizacoes.Suspended := True;
    //thread_VerificacaoAtualizacoes.Terminate;
    //thread_VerificacaoAtualizacoes.Destroy();

  except
    on Ex : Exception do
      begin
        VerificandoAtualizacoes := false;
      end;

  end;
end;

procedure TFrmPrincipal.VerificaAtualizacoesAutomaticas();
begin

  try

  if ErroInstalacao then exit;

  if Not Configuracoes.ConectarInternet then
    exit;

  if VerificandoAtualizacoes then
    exit;

  VerificandoAtualizacoes := True;

  thread_VerificacaoAtualizacoes := ThreadVerificacaoAtualizacoes.Create(ControleAtualizacoes);

  thread_VerificacaoAtualizacoes.VerificaAtualizacoes();

  thread_VerificacaoAtualizacoes_Terminate(nil);

  VerificandoAtualizacoes := False;
  
  Application.ProcessMessages;

  except
    on ex : exception do
      begin
        VerificandoAtualizacoes := False;
        MessageBox( Self.Handle, PAnsiChar( ex.Message ), '', MB_OK);
      end;
  end;
end;

procedure TFrmPrincipal.CarregaConfiguracoesLogin();
var
  lista : TSearchRec;
  Arquivo : String;
begin

  try

    FindFirst(GetcurrentDir + '\*.bin', faAnyFile, lista);
    Arquivo := '';

    repeat
      if ( Lista.Name <> '.') and (Lista.Name <> '..') and ( Lista.Name <> '') then
        begin
          Arquivo := Lista.Name;
        end;

    until (FindNext(lista) <> 0) and (Arquivo <> '') ;


    ConfigLogin := TConfiguracoesLogin.Create();
    if Arquivo = '' then
      begin
        Mensagem('Arquivo de configurações de atualização não foi encontrado' , 'Atualizações'); 
      end
    else
      begin
        ConfigLogin.NomeArquivo :=GetcurrentDir + '\' + Arquivo;
        ConfigLogin.CarregaConfiguracoes;
      end;

  except
  end;
    


end;

{$ENDREGION}

{$ENDREGION}

 end.
