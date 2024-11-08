unit Compressor;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtDlgs, ComCtrls, ExtCtrls, FileCtrl,
  StrUtils, WinSkinStore, WinSkinData, ImgList, CompressaoDados ;

type
  TFrmCompressor = class(TForm)
    Panel1: TPanel;
    SkinData1: TSkinData;
    BtnFechar: TButton;
    BtnComprimir: TButton;
    BtnDescomprimir: TButton;
    Label1: TLabel;
    txtDiretorioOrigem: TEdit;
    BtnSelecionarDiretorio: TButton;
    imltrv: TImageList;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    rdbArquivosComprimidos: TRadioButton;
    rdbArquivosDescomprimidos: TRadioButton;
    lst: TListView;
    procedure BtnDescomprimirClick(Sender: TObject);
    procedure BtnComprimirClick(Sender: TObject);
    procedure rdbArquivosDescomprimidosClick(Sender: TObject);
    procedure rdbArquivosComprimidosClick(Sender: TObject);
    procedure txtDiretorioOrigemChange(Sender: TObject);
    procedure BtnSelecionarDiretorioClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);

    Procedure ListaArquivosDiretorio;
    Procedure ListaArquivos( Extensao : string);
    Procedure ComprimeArquivos;
    Procedure DescomprimeArquivos;
    Function RetornaNome (nomeoriginal : string) : string;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCompressor: TFrmCompressor;

implementation

{$R *.dfm}

procedure TFrmCompressor.BtnFecharClick(Sender: TObject);
begin
  self.close;

end;

procedure TFrmCompressor.BtnSelecionarDiretorioClick(Sender: TObject);

    var
      Diretorio : string;
begin

  if txtDiretorioOrigem.Text = '' then
    Diretorio := GetCurrentDir
  else
    Diretorio := txtDiretorioOrigem.Text;

  if SelectDirectory('Selecione o diretório de Origem','' , Diretorio) then
    begin
      txtDiretorioOrigem.Text :=  Diretorio ;

    end

  else
    ShowMessage('Seleção de diretorio abortada');

end;

procedure TFrmCompressor.txtDiretorioOrigemChange(Sender: TObject);
begin

  ListaArquivosDiretorio;

end;

procedure TFrmCompressor.rdbArquivosComprimidosClick(Sender: TObject);
begin

  ListaArquivosDiretorio;


end;

procedure TFrmCompressor.rdbArquivosDescomprimidosClick(Sender: TObject);
begin

  ListaArquivosDiretorio;

end;

procedure TFrmCompressor.BtnComprimirClick(Sender: TObject);
begin
    ComprimeArquivos;
end;

procedure TFrmCompressor.BtnDescomprimirClick(Sender: TObject);
begin
  DescomprimeArquivos;
end;

procedure TFrmCompressor.ListaArquivosDiretorio;
begin

  LSt.Items.Clear;

  if rdbArquivosComprimidos.Checked then
    begin
      ListaArquivos('dat');
      ListaArquivos('imgx');
      ListaArquivos('htx');
      ListaArquivos('bitmapx');
    end;

  if rdbArquivosDescomprimidos.Checked then
    begin
      ListaArquivos('ini');
      ListaArquivos('gif');
      ListaArquivos('htm');
      ListaArquivos('bmp');
    end;
end;

procedure TFrmCompressor.ListaArquivos( Extensao : string);
  var
    Origem: string;
    MySearch: TSearchRec;
    Item:     TListItem;
    Arquivo:  string;


  begin
  try

    Origem := txtDiretorioOrigem.text;

    FindFirst(Origem + '\*.' + Extensao, faAnyFile, MySearch);

    arquivo := MySearch.Name;

    arquivo := uppercase(arquivo);

    if (Arquivo <> '') And  (Arquivo <> '.') and ( arquivo <> '..') then
      begin
          item := TListItem.Create( Lst.Items );
          item.Caption := LowerCase( arquivo);
          item.SubItems.Add( arquivo );
          item.SubItems.Add( ExtractFileExt(arquivo) );
          item.Checked := True;

          Lst.Items.AddItem( Item );

      end;

    while FindNext(MySearch)=0 do
    begin
        arquivo := uppercase(MySearch.Name);

        if (Arquivo <> '') And  (Arquivo <> '.') and ( arquivo <> '..') then
        begin
          item := TListItem.Create( Lst.Items );
          item.Caption := LowerCase( arquivo);
          item.SubItems.Add( arquivo );
          item.SubItems.Add( ExtractFileExt(arquivo) );
          item.Checked := True;

          Lst.Items.AddItem( Item );

      end;

    end;

    FindClose(MySearch);


  finally

  end;
end;

procedure TFrmCompressor.ComprimeArquivos;

var
  zip : TCompressaoDados;
  I : integer;
  Q : integer;
begin
  try
    zip := TCompressaoDados.create;
    Q := Lst.Items.Count-1;

    for i:=  0 To Q Do
      begin
        if Lst.Items[i].Checked then
          begin
            zip.ArquivoDescomprimido := txtDiretorioOrigem.Text + '\' + Lst.Items[i].Caption;
            zip.ArquivoComprimido := txtDiretorioOrigem.Text + '\' + RetornaNome( Lst.Items[i].Caption);

            zip.ComprimeArquivo;
          end;

      end;
    zip.Destroy;

  finally

    
  end;
end;

procedure TFrmCompressor.DescomprimeArquivos;
var
  zip : TCompressaoDados;
  I : integer;
  Q : integer;
begin
  try
    zip := TCompressaoDados.create;
    Q := Lst.Items.Count-1;

    for i:=  0 To Q Do
      begin
        if lst.Items[I].Checked then
          begin
            zip.ArquivoComprimido := txtDiretorioOrigem.Text + '\' + Lst.Items[i].Caption;
            zip.ArquivoDescomprimido := txtDiretorioOrigem.Text + '\' + RetornaNome( Lst.Items[i].Caption);

            zip.DescomprimeArquivo;
          end;

      end;
    zip.Destroy;
  finally

    
  end;

end;

Function TFrmCompressor.RetornaNome (nomeoriginal : string) : string;

var
  NomeArquivo : string;
  Extensao1 : string;
  Extensao2 : string;

begin
  try
    NomeArquivo := ExtractFileName(NomeOriginal);

    Extensao1 := ExtractFileName(NomeOriginal);

    Extensao1 := UpperCase( ExtractFileExt(NomeOriginal) );
    Extensao2 := '';

    If Extensao1 = '.INI' then Extensao2 := '.dat';
    If Extensao1 = '.GIF' then Extensao2 := '.imgx';
    If Extensao1 = '.BMP' then Extensao2 := '.bitmapx';
    If Extensao1 = '.HTML' then Extensao2 := '.lcmf';

    If Extensao1 = '.DAT' then Extensao2 := '.ini';
    If Extensao1 = '.IMGX' then Extensao2 := '.gif';
    If Extensao1 = '.BITMAPX' then Extensao2 := '.bmp';
    If Extensao1 = '.LCMF' then Extensao2 := '';

    NomeArquivo := ReplaceText(NomeArquivo, Extensao1, Extensao2 );

    RetornaNome := NomeArquivo;

  finally
  end;
end;

end.
