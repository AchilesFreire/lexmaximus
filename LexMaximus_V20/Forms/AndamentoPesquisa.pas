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
    Animacao: TAnimate;
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    varCorFundo : TColor;
    varCorFonte : TColor;    
  public
    { Public declarations }
    ProcessoCancelado : Boolean;

    property CorFundo: TColor read varCorFundo write varCorFundo;
    property CorFonte: TColor read varCorFonte write varCorFonte;

    procedure ConfiguraBarraProgresso(Min : Integer; Max : Integer);
    procedure AjustaBarraProgresso (Pos : Integer);
    procedure AtualizaAndamento (texto : String);


    procedure AtualizaItensEncontrados (texto : String);

    procedure IniciaAnimacao();
    procedure FinalizaAnimacao();

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

procedure TFrmAndamento.IniciaAnimacao ();
begin
  Animacao.Active := False;
  if FileExists ( GetCurrentDir + '\Animacao.avi') then
    begin
      Animacao.FileName := GetCurrentDir + '\Animacao.avi';
      Animacao.Active := True;
    end;
    
  Application.ProcessMessages;

end;

procedure TFrmAndamento.FinalizaAnimacao ();
begin

  Animacao.Active := False;
  Application.ProcessMessages;

end;

end.
