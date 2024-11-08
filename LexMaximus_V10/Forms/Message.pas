unit Message;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Configuracoes;

  //Variants, 
type
  TFrmMessage = class(TForm)
    PnlMensagem: TPanel;
    BtnOk: TButton;
    LblMensagem: TLabel;
    PnlPergunta: TPanel;
    LblMensagemPergunta: TLabel;
    BtnSim: TButton;
    BtnNao: TButton;
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnNaoClick(Sender: TObject);
    procedure BtnSimClick(Sender: TObject);
  private
    { Private declarations }
    var varResultado                  : integer;
    varConfiguracoes                  : TConfiguracoes;
  public
    { Public declarations }
    procedure MensagemInformacao ( Mensagem : string; Titulo : string );
    procedure MensagemInformacao2 ( Mensagem : string; Titulo : string );

    procedure MensagemPergunta ( Mensagem : string; Titulo : string );

    property Resultado: integer read varResultado write varResultado;
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;

  end;

var
  FrmMessage: TFrmMessage;

implementation

{$R *.dfm}

procedure TFrmMessage.BtnNaoClick(Sender: TObject);
begin

  varResultado := IDNO;
  self.close;

end;

procedure TFrmMessage.BtnOkClick(Sender: TObject);
begin

  Self.Close;

end;

procedure TFrmMessage.BtnSimClick(Sender: TObject);
begin

  varResultado := IDYES;
  self.close;

end;

procedure TFrmMessage.MensagemInformacao ( Mensagem : string; Titulo : string );
begin
  try

    Self.Caption := Titulo;
      
    LblMensagem.Caption := mensagem;

    PnlMensagem.Visible := true;
    PnlPergunta.Visible := false;

    self.ShowModal

  finally

  end;
end;

procedure TFrmMessage.MensagemInformacao2 ( Mensagem : string; Titulo : string );
begin
  try

    Self.Caption := Titulo;

    LblMensagem.AutoSize := True;
    LblMensagem.WordWrap := True;
    LblMensagem.Caption := mensagem;
    

    PnlMensagem.Visible := true;
    PnlPergunta.Visible := false;

    self.ShowModal

  finally

  end;
end;

procedure TFrmMessage.MensagemPergunta ( Mensagem : string; Titulo : string ) ;
begin
  try

    Self.Caption := Titulo;

    LblMensagemPergunta.Caption := mensagem;

    PnlMensagem.Visible := false;
    PnlPergunta.Visible := true;


    self.ShowModal

  finally

  end;
end;


procedure TFrmMessage.FormShow(Sender: TObject);
begin

    PnlMensagem.Color := Configuracoes.CorFundo;
    PnlPergunta.Color := Configuracoes.CorFundo;

end;

end.
