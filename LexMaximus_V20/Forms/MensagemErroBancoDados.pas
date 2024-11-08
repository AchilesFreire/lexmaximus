unit MensagemErroBancoDados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFrmMensagemErroBancoDados = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    BtnFechar: TButton;
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMensagemErroBancoDados: TFrmMensagemErroBancoDados;

implementation

{$R *.dfm}

procedure TFrmMensagemErroBancoDados.BtnFecharClick(Sender: TObject);
begin
  Self.Close();
end;

end.
