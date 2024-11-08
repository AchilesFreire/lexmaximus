unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, StrUtils,ADODB,
  cls_Conexao;

type
  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    LblEtapa1: TLabel;
    LblEtapa2: TLabel;
    LblEtapa3: TLabel;
    Label2: TLabel;
    LblArquivoAndamento: TLabel;
    Progresso: TProgressBar;
    LblMensagem: TLabel;
    Label3: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ProcessamentoIniciado : boolean;
    ProcessamentoCancelado : Boolean;

    DiretorioOrigem       : String;
    DiretorioDestino      : String;
    ParametroInstalacao   : String;
    conexao               : TCls_Conexao;
    Rcd                   : TADODataSet;
    LogInstalacao         : TStringList;

    procedure DetectaDiretoriosInstalacao();
    procedure PreparaProcessamento();
    procedure IniciaProcessamento();
    procedure CopiaConteudoPastaDados();
    procedure CopiaConteudoPastaHTML();
    procedure CopiaConteudoPastaIndices();

    function AbreConexao() : Boolean;
    procedure CriaEstruturaDiretorios (Diretorios : String; LocalCriacao : String);

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  canClose := (not ( ProcessamentoIniciado ) );
end;

procedure TFrmPrincipal.PreparaProcessamento();
begin
  if ParamCount = 1 then
    begin
      if (ParamStr(1) = 'Soibelman') OR (ParamStr(1) = 'LexMaximus')  then
        begin
          if ParamStr(1) = 'Soibelman' then
            ParametroInstalacao := 'Enciclopédia Soibelman';

          if ParamStr(1) = 'LexMaximus' then
            ParametroInstalacao := 'LexMaximus';

          LogInstalacao  := TStringList.Create;

          DetectaDiretoriosInstalacao();

          IniciaProcessamento();

          //////////////LogInstalacao.SaveToFile( DiretorioDestino + 'LogInstalacaoBase.txt' );
        end
      else
        LblMensagem.Caption := 'Parametro inválido: ' + ParamStr(1);
    end
  else
    LblMensagem.Caption := 'Número de parametros inválido';

end;

procedure TFrmPrincipal.IniciaProcessamento();
begin

  ProcessamentoIniciado := True;

  if ParametroInstalacao = 'Enciclopédia Soibelman' then
    LblMensagem.Caption := 'Instalando base de Legislação da Enciclopédia';

  if ParametroInstalacao = 'LexMaximus' then
    LblMensagem.Caption := 'Instalando base de Legislação do Lexmaximus';

  LblEtapa1.Font.Style := [fsbold];
  Application.ProcessMessages;
  CopiaConteudoPastaDados();

  if AbreConexao() then
    begin

      LblEtapa2.Font.Style := [fsbold];
      Application.ProcessMessages;
      CopiaConteudoPastaHTML();

      LblEtapa3.Font.Style := [fsbold];
      Application.ProcessMessages;
      CopiaConteudoPastaIndices();
      Application.ProcessMessages;

      ProcessamentoIniciado := False;

    end
  else
    begin
      MessageBox ( Self.Handle , 'Erro abrindo o banco de dados', '', MB_OK or MB_ICONERROR);
    end;

end;

procedure TFrmPrincipal.DetectaDiretoriosInstalacao();
var
  path32 : String;
  path64 : String;
begin

  DiretorioOrigem := ExtractFilePath( Application.ExeName);

  // se o sistema operacional suportar esta pasta, deve-se instalar nela
  path64 := GetEnvironmentVariable('ProgramFiles(x86)');

  path32 := GetEnvironmentVariable('ProgramFiles');

  if path64 = ''  then
    DiretorioDestino := path32
  else
    DiretorioDestino := path64;

  DiretorioDestino := DiretorioDestino + '\' + ParametroInstalacao + '\';

  LogInstalacao.Add('Diretorio de Origem:' + DiretorioOrigem);
  LogInstalacao.Add('Diretorio de Destino:' + DiretorioDestino);

end;

procedure TFrmPrincipal.CopiaConteudoPastaDados();
var
  ArquivoOrigem : String;
  ArquivoDestino : String;
  MySearch: TSearchRec;
  NomeArquivo : String;
  ListaArquivos : TStringList;
  I : Integer;
  Q : Integer;

begin

    ListaArquivos := TStringList.Create;

    if not DirectoryExists(DiretorioDestino + 'Dados') then
      begin
        mkdir (DiretorioDestino + 'Dados');
        LogInstalacao.Add('Criando a pasta ' + DiretorioDestino + 'Dados');
      end;

    FindFirst(DiretorioOrigem + 'Dados\*.*' , faAnyFile, MySearch);
    ArquivoOrigem := MySearch.Name;

    if ( ArquivoOrigem <> '') and (ArquivoOrigem <> '.') and ( ArquivoOrigem <> '..') then
      ListaArquivos.Add(ArquivoOrigem);

    while FindNext(MySearch)=0 do
      begin
        ArquivoOrigem := MySearch.Name;
        if ( ArquivoOrigem <> '') and (ArquivoOrigem <> '.') and ( ArquivoOrigem <> '..') then
          ListaArquivos.Add(ArquivoOrigem);
      end;
    FindClose(MySearch);

    Q := ListaArquivos.Count-1;
    Progresso.Min :=0;
    Progresso.Max := Q;
    for I := 0 to Q do
      begin

          NomeArquivo := ListaArquivos[i];

          LblArquivoAndamento.Caption := AnsiLowerCase(NomeArquivo);
          Application.ProcessMessages;

          ArquivoOrigem := DiretorioOrigem + 'Dados\' + NomeArquivo;
          ArquivoDestino := DiretorioDestino + 'Dados\' + NomeArquivo;

          if FileExists(ArquivoOrigem) then
            begin
              CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(ArquivoDestino) , False  );

              LogInstalacao.Add('Copiando arquivo ' + ArquivoOrigem + ' para ' + ArquivoDestino) ;

               if not SetFileAttributes(PChar(ArquivoDestino), FILE_ATTRIBUTE_NORMAL) then
                begin
                  MessageBox ( Self.Handle, PAnsiChar('Arquivo esta como ''somente leitura''' + ArquivoDestino), ' ', MB_OK or MB_ICONERROR);
                end;
            end
          else
            begin
              LogInstalacao.Add('Arquivo ' + ArquivoOrigem + ' não existe ') ;

            end;
          
          Progresso.Position := I;
          Application.ProcessMessages;
          
      end;
    Progresso.Position := Progresso.Min;
    Application.ProcessMessages;

end;

function TFrmPrincipal.AbreConexao() : Boolean;
var
  StringConexao : String;
  Diretorio : String;
begin

  if Conexao = nil then
    begin

      // tirando a barrinha final, para evitar problema de compatibilidade...
      Diretorio := Copy ( DiretorioDestino, 1 , Length(DiretorioDestino)-1);

      StringConexao := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=%PATH%\Dados\LexMaximus.mdb;Mode=Share Deny None;Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Encrypt Database=False;';
      StringConexao := ReplaceStr(StringConexao, '%PATH%', Diretorio);

      conexao := TCls_Conexao.Create();
      conexao.StringConexao := StringConexao;
      conexao.AbreConexao;
      if conexao.Mensagem <> '' then
        begin
          MessageBox(Self.Handle, PAnsiChar(Conexao.Mensagem), '' , MB_OK or MB_ICONERROR);
          Result := False
        end
      else
        begin
          Rcd := Conexao.AbreDataSet('Select tipolei, Link From Lei order by tipolei');
          if Rcd = nil then
            Result := False
          else
            Result := True
        end;

    end
  else
    Result := True;

end;

procedure TFrmPrincipal.CopiaConteudoPastaHTML();
var
  ArquivoOrigem         : String;
  ArquivoDestino        : String;
  NomeArquivo           : String;
  I                     : Integer;
  Link                  : String;
  Diretorios            : String;
  Diretorios_Anterior   : String;
  tipolei               : Integer;

begin

  if not DirectoryExists(DiretorioDestino + 'html') then
    begin
      mkdir (DiretorioDestino + 'html');
      LogInstalacao.Add('Criando a pasta ' + DiretorioDestino + 'html') ;
    end;

  Rcd.First;
  Progresso.Min := 1;
  Progresso.Max := Rcd.RecordCount;
  I :=1;

  Diretorios_Anterior := '';
  while not rcd.Eof do
    begin

      tipolei := Rcd.FieldByName('TipoLei').AsInteger;

      Link := trim(Rcd.FieldByName('Link').AsString);

      if link <> '' then
        begin

          NomeArquivo := Copy(Link, 1 , Length(Link)-4) + 'lmcf';

          Diretorios := Copy(Link, 1 , LastDelimiter('\' , Link) );

          LblArquivoAndamento.Caption := NomeArquivo;
          Application.ProcessMessages;

          if Diretorios_Anterior <> Diretorios then
            CriaEstruturaDiretorios (Diretorios , DiretorioDestino + 'HTML');

          Diretorios_Anterior := Diretorios ;

          ArquivoOrigem := DiretorioOrigem + 'html\' + NomeArquivo;
          ArquivoDestino := DiretorioDestino + 'html\' + NomeArquivo;



          if FileExists(ArquivoOrigem) then
            begin
              CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(ArquivoDestino) , False  );
              LogInstalacao.Add('Copiando arquivo ' + ArquivoOrigem + ' para ' + ArquivoDestino) ;
            end
          else
            begin
              LogInstalacao.Add('Arquivo ' + ArquivoOrigem + ' Não Existe ');

            end;
        end;

      Progresso.Position := I;
      Inc ( I , 1 );
      Application.ProcessMessages;

      rcd.Next;

    end;

  Progresso.Position := Progresso.Min;
  Application.ProcessMessages;

end;


procedure TFrmPrincipal.CopiaConteudoPastaIndices();
var
  ArquivoOrigem     : String;
  ArquivoDestino    : String;
  NomeArquivo       : String;
  I                 : Integer;
  Link              : String;
  Diretorios        : String;
  Diretorios_Anterior   : String;

begin

  if not DirectoryExists(DiretorioDestino + 'Indices') then
    begin
      mkdir (DiretorioDestino + 'Indices');
      LogInstalacao.Add('Criando a pasta ' + DiretorioDestino + 'Indices') ;
    end;

  Rcd.First;
  Progresso.Min := 1;
  Progresso.Max := Rcd.RecordCount;
  I :=1;

  Diretorios_Anterior := '';
  while not rcd.Eof do
    begin
      Link := Rcd.FieldByName('Link').AsString;
      NomeArquivo := Copy(Link, 1 , Length(Link)-4) + 'dat';

      Diretorios := Copy(Link, 1 , LastDelimiter('\' , Link) );

      LblArquivoAndamento.Caption := NomeArquivo;
      Application.ProcessMessages;

      if Diretorios_Anterior <> Diretorios then
        CriaEstruturaDiretorios (Diretorios , DiretorioDestino + 'Indices');

      Diretorios_Anterior := Diretorios ;
      
      ArquivoOrigem := DiretorioOrigem + 'Indices\' + NomeArquivo;
      ArquivoDestino := DiretorioDestino + 'Indices\' + NomeArquivo;

      if FileExists(ArquivoOrigem) then
        begin
          CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(ArquivoDestino) , False  );
          LogInstalacao.Add('Copiando arquivo ' + ArquivoOrigem + ' para ' + ArquivoDestino) ;
        end
      else
        begin
          LogInstalacao.Add('Arquivo ' + ArquivoOrigem + ' Não Existe ');
        end;

      Progresso.Position := I;
      Inc ( I , 1 );
      Application.ProcessMessages;

      rcd.Next;

    end;

  Progresso.Position := Progresso.Min;
  Application.ProcessMessages;

end;

procedure TFrmPrincipal.CriaEstruturaDiretorios (Diretorios : String; LocalCriacao : String);
var
  I : Integer;
  Q : Integer;
  dir : String;
begin

  Q := Length(diretorios);
  for I := 0 to Q do
    begin
      if diretorios[i] = '\' then
        begin
          dir := Copy(Diretorios,1,I-1);
          if not DirectoryExists(LocalCriacao + '\' + dir) then
            mkdir (LocalCriacao + '\' + dir );
        end;
    end;

  if not DirectoryExists( LocalCriacao ) then
    mkdir ( LocalCriacao );
    
end;

end.
