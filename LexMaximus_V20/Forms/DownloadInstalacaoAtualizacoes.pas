unit DownloadInstalacaoAtualizacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB,
  cls_conexao,
  Configuracoes,
  Rul_Atualizacao, ExtCtrls, StdCtrls;

type
  TFrmDownloadInstalacaoAtualizacoes = class(TForm)
    Panel1: TPanel;
    BtnFechar: TButton;
    BtnCancelar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ListaArquivos : TStringList;
    ListaDescricoes : TStringList;
    DiretorioAtualizacoes : String;
    procedure DownloadArquivos();
    procedure DownloadArquivo( Arquivo : String);
    Function DescomprimeArquivo(Arquivo : String) : String;
    Function ExecutaComandosArquivo(Diretorio : String) : String;
    
  end;

var
  FrmDownloadInstalacaoAtualizacoes: TFrmDownloadInstalacaoAtualizacoes;

implementation

{$R *.dfm}

procedure TFrmDownloadInstalacaoAtualizacoes.FormCreate(Sender: TObject);
begin
    ListaArquivos := TStringList.Create;
    ListaDescricoes := TStringList.Create;
end;

procedure TFrmDownloadInstalacaoAtualizacoes.BtnFecharClick(Sender: TObject);
begin

  Self.Close();

end;

procedure TFrmDownloadInstalacaoAtualizacoes.DownloadArquivos();
var
  I : Integer;
  Q : Integer;
  Arquivo : String;
  Diretorio : String;
  Mensagens : String;
begin
  try
    Q := ListaArquivos.Count-1;
    for i:=0 to q do
      begin
        Arquivo := DiretorioAtualizacoes + '\' + ListaArquivos[i];

        DownloadArquivo(Arquivo);
        Application.ProcessMessages;

        Diretorio := DescomprimeArquivo(Arquivo);
        Application.ProcessMessages;

        Mensagens := ExecutaComandosArquivo (Diretorio);
        Application.ProcessMessages;
        
      end;

  except
    on ex : exception do
      begin
      end;
  end;
end;

procedure TFrmDownloadInstalacaoAtualizacoes.DownloadArquivo( Arquivo : String);
begin
  try
  except
    on ex : exception do
      begin
      end;
  end;
end;

Function TFrmDownloadInstalacaoAtualizacoes.DescomprimeArquivo(Arquivo : String) : String;
begin
  try
  except
    on ex : exception do
      begin
      end;
  end;
end;

Function TFrmDownloadInstalacaoAtualizacoes.ExecutaComandosArquivo(Diretorio : String) : String;
begin
  try
  except
    on ex : exception do
      begin
      end;
  end;
end;






end.
