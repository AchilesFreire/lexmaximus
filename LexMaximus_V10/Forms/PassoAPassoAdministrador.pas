unit PassoAPassoAdministrador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Htmlview, StdCtrls, ExtCtrls, CompressaoDados, Configuracoes ;

type
  TFrmPassoAPassoAdministrador = class(TForm)
    Panel1: TPanel;
    BtnOK: TButton;
    Browser: THTMLViewer;
    procedure FormShow(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);

    procedure ExibePassoAPasso();
  private
    { Private declarations }
     varDiretorioDocumentos           : string;
     varConfiguracoes                 : TConfiguracoes;

  public
    { Public declarations }
    property DiretorioDocumentos: string read varDiretorioDocumentos write varDiretorioDocumentos;
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;

  end;

var
  FrmPassoAPassoAdministrador: TFrmPassoAPassoAdministrador;

implementation

{$R *.dfm}

procedure TFrmPassoAPassoAdministrador.BtnOKClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmPassoAPassoAdministrador.FormShow(Sender: TObject);
begin

  Panel1.Color := Configuracoes.CorFundo;

  ExibePassoAPasso;


end;

procedure TFrmPassoAPassoAdministrador.ExibePassoAPasso();

var
  Zip : TCompressaoDados;

begin

  try
      Zip := TCompressaoDados.Create;


      Zip.ArquivoComprimido := varDiretorioDocumentos + 'PassoAPasso\vitinst.imgx';
      Zip.ArquivoDescomprimido := zip.DiretorioDescompressao + 'vitinst.gif';
      zip.DescomprimeArquivo;

      Zip.ArquivoComprimido := varDiretorioDocumentos + 'PassoAPasso\instvista.htx';
      Zip.ArquivoDescomprimido := zip.DiretorioDescompressao + 'instvista.htm';

      zip.DescomprimeArquivo;

      Browser.LoadFromFile( zip.ArquivoDescomprimido );

      DeleteFile ( Zip.ArquivoDescomprimido );

      DeleteFile ( zip.DiretorioDescompressao + 'vitinst.gif' );

      zip.Destroy;

  finally

  end;

end;

end.
