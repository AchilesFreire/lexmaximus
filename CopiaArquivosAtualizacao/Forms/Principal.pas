unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, StrUtils,ADODB,ShellApi,
  cls_Conexao;

type
  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    LblEtapa1: TLabel;
    LblEtapa2: TLabel;
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
    procedure CopiaConteudoRaiz();
    procedure CopiaConteudoDiretorios();

    function CopiaDiretorio(DirFonte,DirDest : String) : Boolean;
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

procedure TFrmPrincipal.PreparaProcessamento();
var
  Parametro : String;
begin

  Parametro := 'Soibelman'; // ParamStr(1);

  if Parametro <> '' then
    begin
      if (Parametro = 'Soibelman') OR (Parametro = 'LexMaximus')  then
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
        LblMensagem.Caption := 'Parametro inválido: ' + Parametro;
    end
  else
    LblMensagem.Caption := 'Número de parametros inválido';

end;

procedure TFrmPrincipal.IniciaProcessamento();
begin

  ProcessamentoIniciado := True;

  if ParametroInstalacao = 'Enciclopédia Soibelman' then
    LblMensagem.Caption := 'Atualizando base de Legislação da Enciclopédia';

  if ParametroInstalacao = 'LexMaximus' then
    LblMensagem.Caption := 'Atualizando base de Legislação do Lexmaximus';

  LblEtapa1.Font.Style := [fsbold];
  Application.ProcessMessages;
  CopiaConteudoRaiz();

  LblEtapa2.Font.Style := [fsbold];
  Application.ProcessMessages;
  CopiaConteudoDiretorios();

end;

procedure TFrmPrincipal.CopiaConteudoRaiz();
var 
  Search: TSearchRec; 
  Done: Boolean;


begin

  //Copiando todos os arauivos do diretorio Raiz do programa
  // para o diretorio raiz da enciclopedia/lexmaximus

  Done := FindFirst( DiretorioOrigem + '\Atualizacoes\*.*', faAnyFile, Search) <> 0;
  while not Done do
    begin
      if (Search.Attr and faDirectory) <> faDirectory then
        CopyFile(PAnsiChar(DiretorioOrigem + '\' + Search.Name), PAnsiChar(DiretorioDestino + '\' + Search.Name), True);
      Done := FindNext(Search) <> 0;
    end;

end;

procedure TFrmPrincipal.CopiaConteudoDiretorios();
begin

  CopiaDiretorio ( DiretorioOrigem + 'Atualizacoes\',DiretorioDestino );
  
end;

function TFrmPrincipal.CopiaDiretorio(DirFonte,DirDest : String) : Boolean;
var
  ShFileOpStruct : TShFileOpStruct;
begin
  Result := False;
  if DirFonte = '' then
    raise Exception.Create('Diretório fonte não pode ficar em branco');

  if DirDest = '' then
    raise Exception.Create('Diretório destino não pode ficar em branco');

  if not DirectoryExists(DirFonte) then
    raise Exception.Create('Diretório fonte inexistente');

  DirFonte := DirFonte+#0;
  DirDest := DirDest+#0;
  FillChar(ShFileOpStruct,Sizeof(TShFileOpStruct),0);
  with ShFileOpStruct do begin
    Wnd := Application.Handle;
    wFunc := FO_COPY;
    pFrom := PChar(DirFonte);
    pTo := PChar(DirDest);
    fFlags :=   FOF_SILENT or FOF_NOCONFIRMMKDIR or FOF_NOERRORUI or FOF_SIMPLEPROGRESS;
  end;
  ShFileOperation(ShFileOpStruct);
end;

end.
