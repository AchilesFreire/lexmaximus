unit BrowserLocal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Htmlview;

type
  TFrmBrowserLocal = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Button1: TButton;
    Browser: THTMLViewer;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NavegaSite ( Arquivo : String; Titulo : String);
  end;

var
  FrmBrowserLocal: TFrmBrowserLocal;

implementation

{$R *.dfm}

procedure TFrmBrowserLocal.NavegaSite ( Arquivo : String; Titulo : String);
begin
  try
    Browser.LoadFromFile(Arquivo);
    Self.Caption := Titulo;
    Application.ProcessMessages;
  except
  end;
end;

procedure TFrmBrowserLocal.Button1Click(Sender: TObject);
begin
  self.close();
end;

end.
