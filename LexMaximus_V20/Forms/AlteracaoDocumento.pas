unit AlteracaoDocumento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Htmlview, StrUtils,

  cls_Conexao,
  Funcoes,
  Rul_TipoLei,
  Rul_Lei,
  CompressaoDados;

type
  TFrmAlteracaoLei = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BtnOk: TBitBtn;
    BtnCancelar: TBitBtn;
    PageControl1: TPageControl;
    TabCodigo: TTabSheet;
    TabVisualizacao: TTabSheet;
    MemHTML: TMemo;
    Browser: THTMLViewer;
    Label1: TLabel;
    TxtProcura: TEdit;
    BtnProcurar: TButton;
    FindDialog1: TFindDialog;
    procedure FindDialog1Find(Sender: TObject);
    procedure BrowserKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BrowserKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnProcurarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    varLei : Integer;
    varLeiAlterada : boolean;
    VarConexao : TCls_Conexao;

    ArquivoComprimido : String;
    ArquivoDescomprimido : String;
    zip : TCompressaoDados;

    TeclaControlBrowser : boolean;
    FSelPos: integer;

  public
    { Public declarations }
    Property Lei            : integer         read varLei           write varLei;
    Property LeiAlterada    : boolean         read varLeiAlterada   write varLeiAlterada;
    Property Conexao        : TCls_Conexao    read VarConexao       write VarConexao;

    procedure alteraLeiEdicao();
    procedure SalvaDocumentoAlterado();

  end;

var
  FrmAlteracaoLei: TFrmAlteracaoLei;

implementation

{$R *.dfm}

procedure TFrmAlteracaoLei.BrowserKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_CONTROL then
    TeclaControlBrowser := True;

    
  if (TeclaControlBrowser) and (Key = VK_HOME) then
    begin
      Browser.ScrollTo(0);
    end;

  if TeclaControlBrowser and (Key = VK_END) then
    begin
      Browser.ScrollTo( Browser.VScrollBar.Max );

    end;
end;

procedure TFrmAlteracaoLei.BrowserKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin

  if Key = VK_CONTROL then
    TeclaControlBrowser := False;


end;

procedure TFrmAlteracaoLei.BtnCancelarClick(Sender: TObject);
begin
  varLeiAlterada := False;
end;

procedure TFrmAlteracaoLei.BtnOkClick(Sender: TObject);
begin

  SalvaDocumentoAlterado();

  varLeiAlterada := True;
end;

procedure TFrmAlteracaoLei.BtnProcurarClick(Sender: TObject);


begin

  FSelPos := 0;
  FindDialog1.FindText := TxtProcura.Text;
  FindDialog1.Execute;



end;

procedure TFrmAlteracaoLei.FindDialog1Find(Sender: TObject);
var
  S : string;
  startpos : integer;
  Texto2 : String;
  Palavra2 : String;
begin
  with TFindDialog(Sender) do
  begin
    if FSelPos = 0 then
      Options := Options - [frFindNext];

    //[frFindNext,frMatchCase]
    if frfindNext in Options then
      begin
        StartPos := FSelPos + Length(Findtext);
        S := Copy(MemHTML.Lines.Text, StartPos, MaxInt);
      end
    else
      begin
        S := MemHTML.Lines.Text;
        StartPos := 1;
      end;
    if frMatchCase in Options then
      FSelPos := AnsiPos(FindText, S)
    else
      begin
        Texto2 := AnsiLowerCase(S);
        Palavra2 := AnsiLowerCase(FindText);
        FSelPos := AnsiPos(Palavra2, Texto2);
      end;

    if FSelPos > 0 then
      begin
        FSelPos := FSelPos + StartPos - 1;
        MemHTML.SelStart := FSelPos - 1;
        MemHTML.SelLength := Length(FindText);
        MemHTML.SetFocus;
      end
    else
      begin
        if frfindNext in Options then
          S := Concat('Não há nehuma ocorrência para "', FindText, '" no HTML..')
        else
          S := Concat('Não foi possível achar: ',findtext);
          
        MessageDlg(S, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TFrmAlteracaoLei.FormActivate(Sender: TObject);
begin

  alteraLeiEdicao();
  PageControl1.ActivePage :=   TabCodigo

end;

procedure TFrmAlteracaoLei.PageControl1Change(Sender: TObject);
var
  ArquivoTemp : String;

begin

  if PageControl1.ActivePage = TabVisualizacao then
    begin
      ArquivoTemp := GetcurrentDir() + '\browser\temp.html';

      MemHTML.Lines.SaveToFile(ArquivoTemp);

      Browser.LoadFromFile(ArquivoTemp);

      Browser.SetFocus;
      
    end;
end;

procedure TFrmAlteracaoLei.alteraLeiEdicao();
var
  L : TRul_Lei;

begin

  L := TRul_Lei.Create(varLei);

  ArquivoDescomprimido := GetCurrentDir + '\HTML\leiedicao.html';
  ArquivoComprimido := GetCurrentDir + '\HTML\leiedicao.lmcf';

  zip := TCompressaoDados.Create();

  Zip.ArquivoComprimido := ArquivoComprimido;
  Zip.ArquivoDescomprimido := ArquivoDescomprimido;
  Zip.DescomprimeArquivo();


  if FileExists(ArquivoDescomprimido) then
    begin
      MemHTML.Lines.LoadFromFile(ArquivoDescomprimido);
      BtnOk.Enabled := True;
    end
  else
    begin
      MemHTML.Lines.Clear;
      BtnOk.Enabled := False;
    end;



end;

procedure TFrmAlteracaoLei.SalvaDocumentoAlterado();

var Temp : String;
begin

  Temp:= GetcurrentDir() + '\browser\temp.html';

  MemHTML.Lines.SaveToFile(Temp);

  Zip.ArquivoDescomprimido := Temp;
  Zip.ArquivoComprimido := ArquivoComprimido;
  Zip.ComprimeArquivo();
 
end;

end.
