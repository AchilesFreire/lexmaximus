unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Htmlview,
  Global, FramBrwz, Readhtml, FramView;

type
  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Button4: TButton;
    Browser: THTMLViewer;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ArquivoHTMLAtual : String;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  IndiceAtual : Integer;

implementation

{$R *.dfm}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin

  ArquivoHTMLAtual := GetCurrentDir() + '\html\teste.html';

  Browser.LoadFromFile(ArquivoHTMLAtual);

  IndiceAtual := 1;

end;

end.
