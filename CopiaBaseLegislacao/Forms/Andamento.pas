unit Andamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  Principal;

type
  TFrmAndamento = class(TForm)
    Panel1: TPanel;
    LblInformacao: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAndamento: TFrmAndamento;

implementation

{$R *.dfm}

procedure TFrmAndamento.FormShow(Sender: TObject);
var
  Frm : TFrmPrincipal;

begin

  Frm := TFrmPrincipal.Create(self);
  Frm.Show();
  Frm.PreparaProcessamento();
  LblInformacao.Caption := 'Processamento concluido';
  Frm.Destroy();
  self.Close();

end;

end.
