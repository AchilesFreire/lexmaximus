///////////////////////////////////////////////////////////
//                                                       //
// Projeto              :                                //
// Versao do projeto    :                                //
// Unit                 :                                //
// Autor                :                                //
// Criacao              :                                //
// Atribuicoes          :                                //
//                                                       //
//                                                       //
//                                                       //
///////////////////////////////////////////////////////////


unit ConfiguracoesLogin;

interface

uses
  Windows, Graphics, SysUtils, inifiles, CompressaoDados, StrUtils, Forms;

  Type TConfiguracoesLogin = class
  private
    { Private declarations }
    varNomeArquivo                    : string;
    varNome                           : string;
    varLogin                          : String;
    varSenha                          : String;

    zip                               : TCompressaoDados;
    IniFile                           : TIniFile;

  public
    { Public declarations }
    constructor Create;

    Destructor Destroy; override;

    procedure CarregaConfiguracoes();

    procedure AbreArquivo();

    procedure FechaArquivo();

    property NomeArquivo            : string  read varNomeArquivo              write varNomeArquivo ;
    property Nome                   : string  read varNome              write varNome ;
    property Login                  : string  read varLogin             write varLogin;
    property Senha                  : string  read varSenha             write varSenha;
    
  published
    { Public declarations }

  end;

implementation

constructor TConfiguracoesLogin.Create();
begin

  varNomeArquivo     := '';
  varNome   := '';
  varLogin := '';
  varSenha := '';
end;

Destructor TConfiguracoesLogin.Destroy();
begin

  varNomeArquivo     := '';
  varNome   := '';
  varLogin := '';
  varSenha := '';

  inherited Destroy;

end;

procedure TConfiguracoesLogin.AbreArquivo();

//var
  //Diretorio       : String;
  //DiretorioTemp   : String;

begin

    zip      := TCompressaoDados.Create;

    zip.ArquivoComprimido  := varNomeArquivo;

    zip.ArquivoDescomprimido := zip.diretorioDescompressao() + 'aut.ini';

    zip.DescomprimeArquivo;

    IniFile := TIniFile.Create( zip.ArquivoDescomprimido );

end;

procedure TConfiguracoesLogin.FechaArquivo();
begin

    IniFile.Destroy;

    Zip.ComprimeArquivo;

    DeleteFile (Zip.ArquivoDescomprimido);

    zip.Destroy;

end;

procedure TConfiguracoesLogin.CarregaConfiguracoes();
//var
  //temp      : String;

begin

  try

    AbreArquivo;

    varNome := IniFile.ReadString  ( 'DadosCliente' , 'Nome' , ''  );
    varLogin := IniFile.ReadString  ( 'DadosCliente' , 'Login' , ''  );
    varSenha := IniFile.ReadString  ( 'DadosCliente' , 'Senha' , ''  );

    FechaArquivo;

  finally

  end;

end;

end.
