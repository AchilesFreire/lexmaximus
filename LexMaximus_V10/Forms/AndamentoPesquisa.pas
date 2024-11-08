unit AndamentoPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFrmAndamento = class(TForm)
    Progresso: TProgressBar;
    Label1: TLabel;
    LblAndamento: TLabel;
    BtnCancelar: TButton;
    LblItensEncontrados: TLabel;
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ProcessoCancelado : Boolean;

    procedure ConfiguraBarraProgresso(Min : Integer; Max : Integer);
    procedure AjustaBarraProgresso (Pos : Integer);
    procedure AtualizaAndamento (texto : String);


    procedure AtualizaItensEncontrados (texto : String);

  end;

var
  FrmAndamento: TFrmAndamento;

implementation

{$R *.dfm}
procedure TFrmAndamento.ConfiguraBarraProgresso(Min : Integer; Max : Integer);
begin
  try
    Progresso.Min := min;
    Progresso.Max := Max;

  finally

  end;
end;
procedure TFrmAndamento.AjustaBarraProgresso (Pos : Integer);
begin
  try
    Progresso.Position := Pos;
    Application.ProcessMessages;

  finally

  end;
end;
procedure TFrmAndamento.AtualizaAndamento (texto : String);
begin

    LblAndamento.Caption := texto;
    Application.ProcessMessages;

end;

procedure TFrmAndamento.BtnCancelarClick(Sender: TObject);
begin
  ProcessoCancelado := True;
end;

procedure TFrmAndamento.AtualizaItensEncontrados (texto : String);
begin

    LblItensEncontrados.Caption := texto;
    Application.ProcessMessages;

end;
end.
