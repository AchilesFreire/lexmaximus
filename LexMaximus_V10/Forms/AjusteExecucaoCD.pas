unit AjusteExecucaoCD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TFrmAjusteExecucaoCD = class(TForm)
    Label1: TLabel;
    BtnFechar: TBitBtn;
    Animate1: TAnimate;
    LblMensagem: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure IniciaCopia();
    Procedure FinalizaCopia();
  end;

var
  FrmAjusteExecucaoCD: TFrmAjusteExecucaoCD;

implementation

{$R *.dfm}

Procedure TFrmAjusteExecucaoCD.IniciaCopia();
begin

  Animate1.Active := True;
  BtnFechar.Visible := False;
  LblMensagem.Visible := False;

end;
Procedure TFrmAjusteExecucaoCD.FinalizaCopia();
begin

  Animate1.Active := False;
  BtnFechar.Visible := True;
  LblMensagem.Visible := False;

end;


end.
