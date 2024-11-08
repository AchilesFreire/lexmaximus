unit EdicaoNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, StrUtils,
  Conexoes, DBXpress, DB, SqlExpr, 
  Rul_Lei,
  Rul_TextoLei,
  Rul_NotaLei,
  CompressaoDados,
  Htmlview, ComCtrls, Buttons;

type
  TFrmEdicaoNota = class(TForm)
    PnlRodape: TPanel;
    PnlInferior: TPanel;
    MemNota_Rodape: TMemo;
    Label1: TLabel;
    BtnFechar: TButton;
    PnlSuperior: TPanel;
    PnlBrowser: TPanel;
    SplNotaParagrafo: TSplitter;
    Label2: TLabel;
    Browser: THTMLViewer;
    Lbl_Descricao: TLabel;
    PnlParagrafo: TPanel;
    Label3: TLabel;
    MemNota_Paragrafo: TMemo;
    SplNotaRodape: TSplitter;
    Panel4: TPanel;
    Panel3: TPanel;
    BtnSalvarNotaParagrafo: TButton;
    BtnExcluirNotaRodape: TButton;
    BtnSalvarNotaRodape: TButton;
    PnlAguardarFormatacao: TPanel;
    Animate1: TAnimate;
    Progresso: TProgressBar;
    LblAguarde: TLabel;
    BtnCancelarFormatacao: TBitBtn;
    LblExplicacao2: TLabel;
    LblExplicacao1: TLabel;
    LblExplicacao3: TLabel;
    LblExplicacao4: TLabel;
    BtnHabilitarNotasParagrafos: TBitBtn;
    procedure BtnHabilitarNotasParagrafosClick(Sender: TObject);
    procedure BtnCancelarFormatacaoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MemNota_RodapeChange(Sender: TObject);
    procedure MemNota_ParagrafoChange(Sender: TObject);
    procedure BtnSalvarNotaParagrafoClick(Sender: TObject);
    procedure BtnExcluirNotaRodapeClick(Sender: TObject);
    procedure BrowserHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnSalvarNotaRodapeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InclusaoRodape      : Boolean;
    Inclusao            : Boolean;
    EdicaoCancelada     : Boolean;
    Lei                 : Integer;
    NotaLei             : String;
    PosicaoSelecionada  : Integer;
    DiretorioHTML       : String;
    HTMLCarregado       : Boolean;
    CarregandoHTML      : Boolean;

    ExclusaoNota        : Boolean;

    CarregandoConteudo_Nota_Paragrafo : Boolean;
    CarregandoConteudo_Nota_Rodape : Boolean;

    Nota_Paragrafo_Alterada : Boolean;
    Nota_Rodape_Alterada : Boolean;

    ProcessamentoCancelado : boolean;

    procedure HabilitaNotaParagrafo();
    procedure CarregaDadosNotaSelecionada ();
    procedure CarregaNotaRodape();
    procedure CarregaTextoLeiEdicao();
    procedure SalvaNotaRodape();
    procedure SalvaNotaParagrafo();
    function ExcluiNota (Posicao : integer) : boolean;
    procedure InsereLinksParagrafos(Arquivo : String);
    procedure InsereLinksParagrafos2(Arquivo : String);

    procedure IdentificaParagrafosComNota(var Resultado : String; var ListaNotas : TStringList;  var ListaPosicaoNotas : TStringList);
  end;

var
  FrmEdicaoNota: TFrmEdicaoNota;

implementation

{$R *.dfm}

{$REGION 'Eventos'}

procedure TFrmEdicaoNota.FormActivate(Sender: TObject);
begin
  PosicaoSelecionada := -1;
  HTMLCarregado := False;


  //Carregando a nota de rodape
  CarregaNotaRodape();

end;

procedure TFrmEdicaoNota.FormResize(Sender: TObject);
begin

  LblExplicacao1.Left := trunc( (Self.Width - LblExplicacao1.Width)/2 );
  LblExplicacao2.Left := trunc( (Self.Width - LblExplicacao2.Width)/2 );
  LblExplicacao3.Left := trunc( (Self.Width - LblExplicacao3.Width)/2 );
  LblExplicacao4.Left := trunc( (Self.Width - LblExplicacao4.Width)/2 );

  BtnHabilitarNotasParagrafos.Left := trunc( (Self.Width - BtnHabilitarNotasParagrafos.Width)/2 );

  Animate1.Left := trunc( (Self.Width - Animate1.Width)/2 );

  PnlAguardarFormatacao.Width := self.Width ;
  PnlAguardarFormatacao.Height := Self.Height - (  PnlSuperior.Height +  PnlRodape.Height +  PnlInferior.Height ) - 35 ;

  LblAguarde.Left := trunc( (Self.Width - LblAguarde.Width)/2 );

  Progresso.Width := self.Width - 200;
  Progresso.Left := trunc( (Self.Width - Progresso.Width)/2 );

  BtnCancelarFormatacao.Left := trunc( (Self.Width - BtnCancelarFormatacao.Width)/2 );

end;

procedure TFrmEdicaoNota.BrowserHotSpotClick(Sender: TObject; const SRC: string;  var Handled: Boolean);
var
    temp : String;
begin

  temp := SRC;

  if Nota_Paragrafo_Alterada then
    begin
      if MessageBox(Self.Handle, 'Nota foi alterada, deseja salvar ? ', '' , MB_YESNO or MB_ICONQUESTION) = ID_YES then
        begin
          BtnSalvarNotaParagrafoClick(BtnSalvarNotaParagrafo);
        end;
      Nota_Paragrafo_Alterada := False;
    end;

  temp := Copy(temp, 2);
  PosicaoSelecionada := StrToInt(temp);

  if ExclusaoNota then
    begin
      if ExcluiNota(PosicaoSelecionada) then
        CarregaTextoLeiEdicao();

    end
  else
    begin



      CarregaDadosNotaSelecionada ();
      MemNota_Paragrafo.Enabled := True;
      BtnSalvarNotaParagrafo.Enabled := True;
      MemNota_Paragrafo.SetFocus;
    end;

end;

procedure TFrmEdicaoNota.BtnCancelarFormatacaoClick(Sender: TObject);
begin

  ProcessamentoCancelado:= True;
  Application.ProcessMessages;
  
end;

procedure TFrmEdicaoNota.BtnExcluirNotaRodapeClick(Sender: TObject);
begin
  if ExcluiNota(0) then
    begin
      InclusaoRodape := True;
      MemNota_Rodape.Lines.Clear;
      BtnExcluirNotaRodape.Enabled := False;

      if HTMLCarregado Then
        CarregaTextoLeiEdicao();
    end;

end;

procedure TFrmEdicaoNota.BtnFecharClick(Sender: TObject);
begin

  if Nota_Paragrafo_Alterada then
    begin
      if MessageBox(Self.Handle, 'Nota do parágrafo foi alterada, deseja salvar ? ', '' , MB_YESNO or MB_ICONQUESTION) = ID_YES then
        begin
          //BtnSalvarNotaParagrafoClick(BtnSalvarNotaParagrafo);
          SalvaNotaParagrafo();
        end;
      Nota_Paragrafo_Alterada := False;
    end;

  if Nota_Rodape_Alterada then
    begin
      if MessageBox(Self.Handle, 'Nota do rodapé foi alterada, deseja salvar ? ', '' , MB_YESNO or MB_ICONQUESTION) = ID_YES then
        begin
          //BtnSalvarNotaRodapeClick(BtnSalvarNotaRodape);
          SalvaNotaRodape();
        end;
      Nota_Rodape_Alterada := False;
    end;

  EdicaoCancelada := True;
  self.Close();
end;

procedure TFrmEdicaoNota.BtnSalvarNotaParagrafoClick(Sender: TObject);
begin
  SalvaNotaParagrafo();

  CarregaTextoLeiEdicao();
end;

procedure TFrmEdicaoNota.BtnSalvarNotaRodapeClick(Sender: TObject);
begin

  SalvaNotaRodape();

  if HTMLCarregado then
    CarregaTextoLeiEdicao();

end;

procedure TFrmEdicaoNota.BtnHabilitarNotasParagrafosClick(Sender: TObject);
begin

  LblExplicacao1.Visible := False;
  LblExplicacao2.Visible := False;
  LblExplicacao3.Visible := False;
  LblExplicacao4.Visible := False;

  BtnHabilitarNotasParagrafos.Visible := False;

  Application.ProcessMessages;


  LblAguarde.Visible := True;
  Progresso.Visible := True;
  BtnCancelarFormatacao.Visible := True;
  Animate1.Visible := True;
  Application.ProcessMessages;

  HabilitaNotaParagrafo();

  PnlParagrafo.Visible := True;
  SplNotaParagrafo.Visible := True;
  PnlBrowser.Visible := True;

end;


{$ENDREGION}

{$REGION 'Metodos'}

procedure TFrmEdicaoNota.HabilitaNotaParagrafo();
begin

  CarregandoHTML := True;

  //Carregando o texto da lei, para selecionar paragrafos
  CarregaTextoLeiEdicao();

  if ProcessamentoCancelado then
    begin
      BtnSalvarNotaRodape.Enabled := false;
      PnlBrowser.Enabled := false;
      PnlParagrafo.Enabled := false;
      PnlRodape.Enabled := false;
      Lbl_Descricao.Caption := 'Edição cancelada';
    end
  else
    begin
      Lbl_Descricao.Visible := True;
      if ExclusaoNota then
        Lbl_Descricao.Caption := 'Clique nos links abaixo, para excluir notas nos parágrafos'
      else
        Lbl_Descricao.Caption := 'Clique nos links abaixo, para incluir/alterar notas nos parágrafos';
    end;
  HTMLCarregado := True;

  CarregandoHTML := False;

end;

procedure TFrmEdicaoNota.SalvaNotaRodape();
var
  NotaLei : TRul_NotaLei;
begin

  if  (MemNota_Rodape.Lines.Count = 0) then
    begin
      MessageBox (Self.Handle, 'Informe a nota do rodapé.', '', MB_OK);
      MemNota_Rodape.SetFocus;
      exit;
    end;

  NotaLei := TRul_NotaLei.Create();

  NotaLei.Lei := Lei;
  NotaLei.posicao:= 0;
  NotaLei.TipoNotaLei := 'F';
  NotaLei.NotaLei := MemNota_Rodape.Lines.Text;

  if InclusaoRodape then
    begin
      NotaLei.ValidateInsert();
      InclusaoRodape := False;
      BtnExcluirNotaRodape.Enabled := True;
    end
  else
    NotaLei.ValidateUpdate();

  Nota_Rodape_Alterada := False;
end;

procedure TFrmEdicaoNota.SalvaNotaParagrafo();
var
  NotaLei : TRul_NotaLei;
begin

  if  (PosicaoSelecionada = -1) then
    begin
      MessageBox (Self.Handle, 'Selecione o paragrafo onde deseja incluir a nota', '', MB_OK);
      exit;
    end;

  if  (MemNota_Paragrafo.Lines.Count = 0) then
    begin
      MessageBox (Self.Handle, 'Informe a nota do parágrafo selecionado.', '', MB_OK);
      MemNota_Paragrafo.SetFocus;
      exit;
    end;

  NotaLei := TRul_NotaLei.Create();

  NotaLei.Lei := Lei;
  NotaLei.posicao:= PosicaoSelecionada;
  NotaLei.TipoNotaLei := 'P';
  NotaLei.NotaLei := MemNota_Paragrafo.Lines.Text;

  if Inclusao then
    begin
    NotaLei.ValidateInsert();
    Inclusao := False;
    end
  else
    NotaLei.ValidateUpdate();
    
  Nota_Paragrafo_Alterada := False;

end;

function TFrmEdicaoNota.ExcluiNota (Posicao : integer) : boolean;
var
  n : TRul_NotaLei;
begin

  if MessageBox( self.Handle, 'Confirma a exclusão da nota selecionada?' , '' , MB_YESNO or MB_ICONQUESTION ) = IDYES then
    begin
      n := TRul_NotaLei.Create(  Lei, Posicao);

      n.ValidateDelete;

      if Posicao <>0 then
        begin
          MemNota_Paragrafo.Enabled := False;
          BtnSalvarNotaParagrafo.Enabled := False;
        end;

      result := true;
    end
  else
    result := false;

end;

procedure TFrmEdicaoNota.CarregaNotaRodape();
var
  nota : tRul_NotaLei;

begin

  nota := tRul_NotaLei.Create(  Lei, 0); // notaq de rodape = 0

  MemNota_Rodape.Lines.Clear;

  if nota.NovoRegistro then
    begin
      BtnExcluirNotaRodape.Enabled := false;
      InclusaoRodape := True;
    end
  else
    begin
      BtnExcluirNotaRodape.Enabled := True;
      InclusaoRodape := False;
      Nota_Rodape_Alterada := False;
      CarregandoConteudo_Nota_Rodape := True;

      MemNota_Rodape.Lines.Add(nota.NotaLei);

      CarregandoConteudo_Nota_Rodape := False;
    end;
  nota.Destroy;


end;

procedure TFrmEdicaoNota.CarregaTextoLeiEdicao();
var
  L : TRul_Lei;
  T : TRul_TextoLei;
  ArquivoComprimido : String;
  ArquivoDescomprimido : String;
  zlib : TCompressaoDados;

begin
  try

    L := TRul_Lei.Create( lei);

    ArquivoComprimido := GetcurrentDir() + '\Browser\tempedicao.lmcf';

    ArquivoDescomprimido := GetcurrentDir() + '\Browser\tempedicao.htm';

    T := TRul_TextoLei.Create(lei, ArquivoComprimido);

    if Not FileExists(ArquivoComprimido) then
      begin
        MEssageBox(Self.Handle, 'Arquivo não encontrado', '', MB_OK);
        exit;
      end;

    zlib := TCompressaoDados.Create;
    zlib.ArquivoComprimido := ArquivoComprimido ;
    zlib.ArquivoDescomprimido := ArquivoDescomprimido;
    zlib.DescomprimeArquivo();

    zlib.Destroy;

    PnlAguardarFormatacao.Visible := True;
    Application.ProcessMessages;
    Animate1.Active := true;

    ProcessamentoCancelado := False;

    InsereLinksParagrafos(ArquivoDescomprimido);

    if not ProcessamentoCancelado then
      Browser.LoadFromFile(ArquivoDescomprimido);

    DeleteFile(ArquivoComprimido);
      
    Animate1.Active := False;
    Application.ProcessMessages;
    PnlAguardarFormatacao.Visible := False;

    HTMLCarregado := True;

  except

  end;
end;

procedure TFrmEdicaoNota.CarregaDadosNotaSelecionada();

var
  nota : tRul_NotaLei;

begin

  nota := tRul_NotaLei.Create(  Lei, PosicaoSelecionada);

  MemNota_Paragrafo.Lines.Clear;

  if nota.NovoRegistro then
    Inclusao := True
  else
    begin
      Inclusao := False;
      Nota_Paragrafo_Alterada := False;
      CarregandoConteudo_Nota_Paragrafo := True;
      MemNota_Paragrafo.Lines.Add(nota.NotaLei);
      CarregandoConteudo_Nota_Paragrafo := False;
    end;
  nota.Destroy;

end;

procedure TFrmEdicaoNota.InsereLinksParagrafos(Arquivo : String);
var
  I                       : Integer;
  Q                       : Integer;
  Tam                     : Integer;
  Conteudo                : TStringList;
  Texto                   : String;
  Parte                   : String;
  Retorno                 : String;
  ListaParagrafosComNota  : String;
  ListaNotas              : TStringList;
  ListaPosicaoNotas       : TStringList;
  Posicao                 : Integer;
  FimArquivo              : Boolean;

  Link                    : String;
  Item                    : Integer;
  ExisteNota              : Boolean;
  TextoNota               : String;
  IndiceNota              : Integer;

begin

  ListaParagrafosComNota := '';
  ListaNotas             := TStringList.Create;
  ListaPosicaoNotas      := TStringList.Create;

  IdentificaParagrafosComNota (ListaParagrafosComNota , ListaNotas , ListaPosicaoNotas);

  Conteudo := TStringList.Create;
  Conteudo.LoadFromFile(Arquivo);
  Texto := Conteudo.Text;

  Q := Length(Texto);
  Progresso.Min   :=  1;
  Progresso.Max   :=  Q;
  Tam             :=  0;

  Item := 1;

  FimArquivo := False;
  While not FimArquivo do
    begin
      Posicao := Pos('</p>' , Texto );

      If Posicao = 0 then
        begin
          FimArquivo := True;
        end
      else
        begin
          Parte := Copy(Texto, 1, Posicao + 4);
          Tam := Tam + Length(Parte);

          Progresso.Position := Tam;
          Application.ProcessMessages;

          Link:= '<font face = ''Verdana'' size = ''2px'' color = ''#ff8080''><b><a href= #' + IntToStr(Item) + '>';

          ExisteNota := ( Pos('{' + IntToStr(Item) + '}'  , ListaParagrafosComNota ) >0);

          Application.ProcessMessages;

          if ExclusaoNota then
            begin
              if ExisteNota then
                begin
                  IndiceNota := ListaPosicaoNotas.IndexOf( IntToStr(Item) );
                  TextoNota :=  ListaNotas[IndiceNota];
                  Link:= Link + ReplaceText(TextoNota, chr(13) + chr(10) , '<br>') ;
                end;
            end
          else
            begin

              if ExisteNota then
                Link:= Link + 'Altere a nota aqui'
              else
                Link:= Link + 'Insira uma nota aqui';
            end;

          Link:= Link + '</a></b></font>';
          Application.ProcessMessages;
          Inc(Item , 1);

          Parte := Parte + Link;
          Retorno := Retorno + Parte;

          Texto := Copy( Texto,Posicao + 5);
        end;
    end;

  Progresso.Position := Progresso.Max;
  Application.ProcessMessages;


  if ProcessamentoCancelado then
    begin
      Application.ProcessMessages;
      exit;
    end;

  Conteudo.Clear;
  Conteudo.Add(Retorno);
  conteudo.SaveToFile(Arquivo);

end;

procedure TFrmEdicaoNota.InsereLinksParagrafos2(Arquivo : String);
var
  Conteudo                : TStringList;
  Texto                   : String;
  I                       : Integer;
  Q                       : Integer;
  Link                    : String;
  Item                    : Integer;
  Retorno                 : String;
  Letra                   : char;
  Palavra                 : String;
  ListaParagrafosComNota  : String;
  ListaNotas              : TStringList;
  ListaPosicaoNotas       : TStringList;
  ExisteNota              : Boolean;
  TextoNota               : String;
  IndiceNota              : Integer;

begin

  ListaParagrafosComNota := '';
  ListaNotas             := TStringList.Create;
  ListaPosicaoNotas      := TStringList.Create;

  IdentificaParagrafosComNota (ListaParagrafosComNota , ListaNotas , ListaPosicaoNotas);

  Conteudo := TStringList.Create;
  Conteudo.LoadFromFile(Arquivo);
  Texto := Conteudo.Text;

  Q := Length(Texto);
  Item := 1;

  Progresso.Min :=0;
  Progresso.Max := Q;

  for I := 1 to Q do
    begin
      Progresso.Position := I;

      Application.ProcessMessages;
      
      if ProcessamentoCancelado then
        begin
          Application.ProcessMessages;
          break;
        end;

      Letra := Texto[i];

      if (Letra = ' ') or (Letra = chr(10)) or (Letra = chr(13)) then
        begin
          if AnsiEndsText ( '</p>', Palavra )  then
            begin

              Link:= '<font face = ''Verdana'' size = ''2px'' color = ''#ff8080''><b><a href= #' + IntToStr(Item) + '>';

              ExisteNota := ( Pos('{' + IntToStr(Item) + '}'  , ListaParagrafosComNota ) >0);

              Application.ProcessMessages;

              if ExclusaoNota then
                begin
                  if not ExisteNota then
                    begin
                      IndiceNota := ListaPosicaoNotas.IndexOf( IntToStr(Item) );
                      TextoNota :=  ListaNotas[IndiceNota];
                      Link:= Link + ReplaceText(TextoNota, chr(13) + chr(10) , '<br>') ;
                    end;
                end
              else
                begin

                  if ExisteNota then
                    Link:= Link + 'Altere a nota aqui'
                  else
                    Link:= Link + 'Insira uma nota aqui';

                end;

              Link:= Link + '</a></b></font>';
              Retorno := Retorno + Palavra + Link;
              Application.ProcessMessages;
              Inc(Item , 1);
            end
          else
            Retorno := Retorno + Palavra + Letra;

          Palavra := '';
        end

      else
        begin
          Palavra := Palavra + Letra;
        end;
      Application.ProcessMessages;
      if ProcessamentoCancelado then
        begin
          Application.ProcessMessages;
          break;
        end;

    end;
  if ProcessamentoCancelado then
    begin
      Application.ProcessMessages;
      exit;
    end;

  Conteudo.Clear;
  Conteudo.Add(Retorno);
  conteudo.SaveToFile(Arquivo);

end;

procedure TFrmEdicaoNota.IdentificaParagrafosComNota(var Resultado : String; var ListaNotas : TStringList;  var ListaPosicaoNotas : TStringList);
var
  NotaLei : TRul_NotaLei;
  Rcd : TSQLQuery;
begin

  NotaLei := TRul_NotaLei.Create( Lei , -1);

  Rcd := NotaLei.GetAll();
  Resultado := '';

  While not Rcd.eof do
    begin
      Resultado := Resultado + '{' + Rcd.FieldByName('Posicao').AsString + '}';
      ListaNotas.Add(  Rcd.FieldByName('NotaLei').AsString );
      ListaPosicaoNotas.Add(  Rcd.FieldByName('Posicao').AsString );

      rcd.next;
    end;

  notalei.Destroy;
  rcd.Close;
  rcd.Destroy;

end;

procedure TFrmEdicaoNota.MemNota_ParagrafoChange(Sender: TObject);
begin

  if not CarregandoConteudo_Nota_Paragrafo then
    Nota_Paragrafo_Alterada := True;

end;

procedure TFrmEdicaoNota.MemNota_RodapeChange(Sender: TObject);
begin

  if not CarregandoConteudo_Nota_Rodape then
    Nota_Rodape_Alterada := True;

end;



{$ENDREGION}

end.
