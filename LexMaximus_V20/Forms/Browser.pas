unit Browser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, OleCtrls, SHDocVw;

type
  TFrmBrowser = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnFechar: TButton;
    WebBrowser1: TWebBrowser;
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NavegaSite ( Url : String; Titulo : String);
  end;

var
  FrmBrowser: TFrmBrowser;

implementation

{$R *.dfm}

procedure TFrmBrowser.BtnFecharClick(Sender: TObject);
begin
  self.Close();
end;

procedure TFrmBrowser.NavegaSite ( Url : String; Titulo : String);
begin
  try
    WebBrowser1.Navigate(Url);
    Self.Caption := Titulo;
    Application.ProcessMessages;
  except
  end;
end;

end.
