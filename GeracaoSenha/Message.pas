unit Message;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmMessage = class(TForm)
    PnlMensagem: TPanel;
    BtnOk: TButton;
    LblMensagem: TLabel;
    PnlPergunta: TPanel;
    LblMensagemPergunta: TLabel;
    BtnSim: TButton;
    BtnNao: TButton;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnNaoClick(Sender: TObject);
    procedure BtnSimClick(Sender: TObject);
  private
    { Private declarations }
    var varResultado : integer;
  public
    { Public declarations }
    procedure MensagemInformacao ( Mensagem : string; Titulo : string );

    procedure MensagemPergunta ( Mensagem : string; Titulo : string );

    property Resultado: integer read varResultado write varResultado;

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



end.
