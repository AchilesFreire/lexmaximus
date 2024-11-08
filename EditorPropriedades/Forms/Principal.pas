unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons,
  CompressaoDados, WinSkinData, ComCtrls;

type
  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    BtnFechar: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnRecarregar: TBitBtn;
    Label1: TLabel;
    TxtArquivoDados: TEdit;
    BtnSelecionarArquivo: TButton;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    MemConteudo: TMemo;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnRecarregarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnSelecionarArquivoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaConteudoArquivo();
    procedure SalvaConteudoArquivo();
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnFecharClick(Sender: TObject);
begin
  self.close;
end;

procedure TFrmPrincipal.BtnRecarregarClick(Sender: TObject);
begin

  CarregaConteudoArquivo();

end;

procedure TFrmPrincipal.BtnSalvarClick(Sender: TObject);
begin

  SalvaConteudoArquivo();

end;

procedure TFrmPrincipal.BtnSelecionarArquivoClick(Sender: TObject);
begin

  if trim(TxtArquivoDados.Text) = '' then
    begin
      OpenDialog1.InitialDir := GetCurrentDir();
    end
  else
    begin
      OpenDialog1.InitialDir := ExtractFilePath(TxtArquivoDados.Text);
    end;
  OpenDialog1.Execute(self.Handle);

  TxtArquivoDados.Text := OpenDialog1.FileName;

  CarregaConteudoArquivo();

end;

procedure TFrmPrincipal.CarregaConteudoArquivo();
var
  ArquivoComprimido : String;
  ArquivoDescomprimido : String;
  comp : TCompressaoDados;

begin

  MemConteudo.Clear;
  BtnSalvar.Enabled := False;
  BtnRecarregar.Enabled := False;

  if trim(TxtArquivoDados.Text) = '' then
      exit;

  if FileExists(TxtArquivoDados.Text) then
    begin
      BtnSalvar.Enabled := True;
      BtnRecarregar.Enabled := True;

      comp := TCompressaoDados.Create;

      comp.ArquivoComprimido := Txtarquivodados.Text;

      comp.ArquivoDescomprimido := comp.DiretorioDescompressao + 'df3efew.def';

      if comp.DescomprimeArquivo() then
        begin
          MemConteudo.Lines.LoadFromFile(comp.ArquivoDescomprimido);

          Application.ProcessMessages;

          DeleteFile( comp.ArquivoDescomprimido );
        end
      else
        begin
          MessageBox ( Self.Handle , 'Falha na descompressão do arquivo', '', MB_OK or MB_ICONERROR);
        end;
    end;
end;

procedure TFrmPrincipal.SalvaConteudoArquivo();
var
  ArquivoDescomprimido : String;
  comp : TCompressaoDados;

begin

  if trim(TxtArquivoDados.Text) = '' then
    begin
      MessageBox ( Self.Handle , 'Nome do arquivo não foi encontrado', '', MB_OK or MB_ICONERROR);
      exit;
    end;

  if MemConteudo.Lines.Count = 0 then
    begin
      MessageBox ( Self.Handle , 'Arquivo nao pode ter conteúdo vazio', '', MB_OK or MB_ICONERROR);
      exit;
    end;

  comp := TCompressaoDados.Create;

  ArquivoDescomprimido := comp.DiretorioDescompressao + 'vpodvispdov.qry';
  MemConteudo.Lines.SaveToFile(ArquivoDescomprimido);

  comp.ArquivoComprimido := Txtarquivodados.Text;
  comp.ArquivoDescomprimido := ArquivoDescomprimido;

  if comp.comprimeArquivo() then
    begin
      MessageBox ( Self.Handle , 'Propriedades salvas com sucesso', '', MB_OK or MB_ICONINFORMATION);

      DeleteFile( ArquivoDescomprimido );
    end
  else
    begin
      MessageBox ( Self.Handle , 'Falha na descompressão do arquivo', '', MB_OK or MB_ICONERROR);
    end;
    
end;


end.
