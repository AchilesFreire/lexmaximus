unit LicencaUso;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Htmlview, StdCtrls, ExtCtrls, CompressaoDados, Configuracoes, ClipBrd;

  //Variants, Dialogs,

type
  TFrmLicencaUso = class(TForm)
    Panel1: TPanel;
    BtnOK: TButton;
    Browser: THTMLViewer;
    BtnCopiarChave: TButton;
    TxtChave: TEdit;
    LblTituloLicenca: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BtnCopiarChaveClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);

  private
    { Private declarations }
     varDiretorioDocumentos           : string;
     varChaveUsuario                  : string;
     varConfiguracoes                 : TConfiguracoes;

  public
    { Public declarations }
    property DiretorioDocumentos: string read varDiretorioDocumentos write varDiretorioDocumentos;
    property ChaveUsuario: string read varChaveUsuario write varChaveUsuario;
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;
    procedure ConfiguraJanela;
  end;

var
  FrmLicencaUso: TFrmLicencaUso;

implementation

{$R *.dfm}

procedure TFrmLicencaUso.BtnOKClick(Sender: TObject);
begin

  self.Close
end;

procedure TFrmLicencaUso.ConfiguraJanela;
var
  zip :  TCompressaoDados;
  Diretorio : String;

begin

  try

    zip :=  TCompressaoDados.Create;

    Diretorio := Configuracoes.RetornaDiretorioTrabalho;

    zip.ArquivoComprimido    := varDiretorioDocumentos + 'eula.htx';
    zip.ArquivoDescomprimido := Diretorio + 'Browser\eula.htm';

    zip.DescomprimeArquivo;

    Browser.LoadFromFile( zip.ArquivoDescomprimido );

    DeleteFile (  zip.ArquivoDescomprimido ) ;

    if Configuracoes.TipoLicenca = TL_DemoAno then
      begin
        LblTituloLicenca.caption := 'Data limite de uso:';
        TxtChave.Left := 128;
        TxtChave.Width := 137;

        BtnCopiarChave.Visible := False;
        TxtChave.Text := Configuracoes.DataLimiteUso;
      end
    else
      begin
        LblTituloLicenca.caption := 'Chave:';
        TxtChave.Left := 56;
        TxtChave.Width := 337;

        TxtChave.Text := varChaveUsuario;
      end;

  finally

  end;
end;

procedure TFrmLicencaUso.BtnCopiarChaveClick(Sender: TObject);
begin

  Clipboard.AsText := TxtChave.Text;
  
end;

procedure TFrmLicencaUso.FormShow(Sender: TObject);
begin

    Panel1.Color := Configuracoes.CorFundo;

end;

end.
