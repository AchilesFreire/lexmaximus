unit AssinaturaExpirou;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP,
  Configuracoes,
  DownloadAtualizacoes,
  Mensagens,
  Browser,
  BrowserLocal;

type
  TFrmAssinaturaExpirou = class(TForm)
    Panel1: TPanel;
    BtnContratarAssinatura: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    IndyHTTP: TIdHTTP;
    BtnVerificarAtualizacoesAnteriores: TButton;
    procedure BtnVerificarAtualizacoesAnterioresClick(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
    procedure Label6MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure BtnContratarAssinaturaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FormBrowser                       : TFrmBrowser;
    FormBrowserLocal                  : TFrmBrowserLocal;
    varConfiguracoes                  : TConfiguracoes;
    varDiretorioBrowser               : String;
    varControleAtualizacoes           : TDownloadAtualizacoes;
    varVerificarAtualizacoesAnteriores : Boolean;

  public
    { Public declarations }
    property DiretorioBrowser: string read varDiretorioBrowser write varDiretorioBrowser;
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;
    property ControleAtualizacoes: TDownloadAtualizacoes read varControleAtualizacoes write varControleAtualizacoes;
    property VerificarAtualizacoesAnteriores: Boolean read varVerificarAtualizacoesAnteriores write varVerificarAtualizacoesAnteriores;

    procedure ContrataAssinatura();
    procedure ExibeAtualizacoes();

  end;

var
  FrmAssinaturaExpirou: TFrmAssinaturaExpirou;

implementation

{$R *.dfm}

procedure TFrmAssinaturaExpirou.Button1Click(Sender: TObject);
begin
  varVerificarAtualizacoesAnteriores :=False;
  self.Close();
end;

procedure TFrmAssinaturaExpirou.BtnContratarAssinaturaClick(Sender: TObject);
begin

  ContrataAssinatura();
  
end;

procedure TFrmAssinaturaExpirou.Label3Click(Sender: TObject);
begin
  ContrataAssinatura();
end;

procedure TFrmAssinaturaExpirou.Label6Click(Sender: TObject);
begin
  ExibeAtualizacoes();
end;

procedure TFrmAssinaturaExpirou.Label3MouseEnter(Sender: TObject);
begin
  Label3.Font.Color := clYellow;
end;

procedure TFrmAssinaturaExpirou.Label3MouseLeave(Sender: TObject);
begin
  Label3.Font.Color := clSkyBlue;
end;

procedure TFrmAssinaturaExpirou.Label6MouseEnter(Sender: TObject);
begin
  Label6.Font.Color := clYellow;
end;

procedure TFrmAssinaturaExpirou.Label6MouseLeave(Sender: TObject);
begin
  Label6.Font.Color := clSkyBlue;
end;

procedure TFrmAssinaturaExpirou.ExibeAtualizacoes();
var
  Arquivo : String;
  Conteudo : TStringList;
  HTML : TStringList;
  I : Integer;
  Q : Integer;
begin
  if FormBrowserLocal = nil then
    FormBrowserLocal := TFrmBrowserLocal.Create(self);

  Conteudo := TStringList.Create;
  varControleAtualizacoes.GeraTabelaAtualizacoesCliente( -1, Conteudo);

  if (Conteudo.Count = 0 ) then
    begin
      Mensagem(Self, 'No momento não existem atualizações disponíveis' , 'Atualizações' , varConfiguracoes);
    end
  else
    begin
      HTML := TStringList.Create();
      HTML.Add('<html>');
      HTML.Add('<body background="verge.gif">');
      HTML.Add('<font color="#104480" face="Verdana, Tahoma, Arial" size=3px>');      HTML.Add('');      HTML.Add('Atualizações Novas:');      HTML.Add('<br>');      HTML.Add('<br><br>');      HTML.Add('<table  width = "100%" Style="border-collapse: collapse;">');      Q := Conteudo.count-1;
      For I:= 0 to Q do
        begin
          HTML.Add(conteudo[i] );
        end;
      HTML.Add('</table>');
      HTML.Add('<br><br>');
      HTML.Add('<hr>');
      HTML.Add('<br><br>');
      HTML.Add('</font>');
      HTML.Add('</body>');
      Arquivo := varDiretorioBrowser + '\ListaAtualizacoes.htm';
      HTML.SaveToFile(Arquivo);


      FormBrowserLocal.NavegaSite(Arquivo , 'Atualizações Disponíveis');
      FormBrowserLocal.ShowModal();
    end;

end;

procedure TFrmAssinaturaExpirou.ContrataAssinatura();
var
  I : Integer;
  Resposta : String;
begin

  try
    //Baixando o arquivo que contem o link
    For i := 0 to 3 do
      begin
        try
          Resposta := IndyHTTP.Get('http://www.elfez.com.br/AtualizacoesProdutos/Link_ES.txt');
        except
          Resposta := '';
        end;
        if Resposta <> '' then
          break;
      end;
    if Resposta = '' then
      begin
        mensagem(self, 'Não foi possível conectar ao servidor' , self.caption, varConfiguracoes);
      end
    else
      begin

        if FormBrowser = nil then
          FormBrowser := TFrmBrowser.Create(self);

        FormBrowser.NavegaSite(Resposta , 'Contratação de assinatura');

        FormBrowser.ShowModal();

        FreeAndNil( FormBrowser);

      end;

  except
    on ex : exception do
      begin
        mensagem(self, ex.Message , self.caption, varConfiguracoes);
      end;
  end;
end;

procedure TFrmAssinaturaExpirou.BtnVerificarAtualizacoesAnterioresClick(
  Sender: TObject);
begin
  varVerificarAtualizacoesAnteriores := True;
  self.Close();
end;

end.
