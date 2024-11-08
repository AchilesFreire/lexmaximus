unit Administrador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Configuracoes, PassoAPassoAdministrador ;

type
  TFrmAdministrador = class(TForm)
    PnlMensagem: TPanel;
    LblMensagem: TLabel;
    BtnOk: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Label1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);

    procedure CarregaJanelaPassoAPasso();
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
  FrmAdministrador: TFrmAdministrador;

implementation

{$R *.dfm}

procedure TFrmAdministrador.BtnOkClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmAdministrador.FormShow(Sender: TObject);
begin

  PnlMensagem.Color := Configuracoes.CorFundo;

end;

procedure TFrmAdministrador.Label1Click(Sender: TObject);
begin

  CarregaJanelaPassoAPasso;

end;

procedure TFrmAdministrador.CarregaJanelaPassoAPasso();

var
  frm  : TFrmPassoAPassoAdministrador;
begin

  frm  := TFrmPassoAPassoAdministrador.Create(self);
  frm.DiretorioDocumentos := varDiretorioDocumentos;
  frm.Configuracoes := varConfiguracoes;

  frm.ShowModal;

  frm.Destroy;

end;


end.
