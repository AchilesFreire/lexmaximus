unit SelecaoAtualizacaoCinza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmSelecaoAtualizacaoCinza = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    BtnFechar: TButton;
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSelecaoAtualizacaoCinza: TFrmSelecaoAtualizacaoCinza;

implementation

{$R *.dfm}

procedure TFrmSelecaoAtualizacaoCinza.BtnFecharClick(Sender: TObject);
begin
  self.Close();
end;

end.
