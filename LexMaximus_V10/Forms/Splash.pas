unit Splash;

interface

uses
  GIFImage, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, CompressaoDados, Configuracoes;

  // Variants, Dialogs,


type
  TRGBArray = array[0..32767] of TRGBTriple;
  PRGBArray = ^TRGBArray;

type
  TFrmSplash = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
    varDiretorioImagens   : string;
    varConfiguracoes      : TConfiguracoes;
    FRegion               : THandle;
    varExibicaoSobre      : Boolean;
    varSobreAtivado      : Boolean;

  public
    { Public declarations }
    property DiretorioImagens: String read varDiretorioImagens write varDiretorioImagens;
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;

    property ExibicaoSobre: Boolean read varExibicaoSobre write varExibicaoSobre;

    procedure CarregaImagemSplash();

    function CreateRegion(Bmp: TBitmap): THandle;
    procedure CreateRegion2();

  end;

var
  FrmSplash: TFrmSplash;

implementation

{$R *.dfm}

procedure TFrmSplash.CarregaImagemSplash();

var
  zip : TCompressaoDados;

begin
  try

  Timer1.Enabled := ExibicaoSobre;


  zip := TCompressaoDados.Create;
  zip.ArquivoComprimido := DiretorioImagens + 'splashscreen.bitmapx';
  zip.ArquivoDescomprimido := zip.DiretorioDescompressao + 'splashscreen.bmp';

  zip.DescomprimeArquivo;

  Image1.Picture.LoadFromFile( zip.ArquivoDescomprimido);
  DeleteFile(zip.ArquivoDescomprimido);

  zip.Destroy ;

  (*******************************************
  Taxa := 50;

  if (screen.Width = 640) and (screen.Height = 480) then Taxa:= 30;

  if (screen.Width = 800) and (screen.Height = 600) then Taxa:= 40;

  if (screen.Width = 1024) and (screen.Height = 768) then Taxa:= 50;

  if (screen.Width > 1024) or (screen.Height > 768) then Taxa:= 60;

  w := (Taxa * screen.Width) div 100;

  h := (Taxa * screen.Height) div 100;
  *******************************************)

  Self.Width := Image1.Picture.Width;
  Self.Height := Image1.Picture.Height + 20;

  Left  := (Screen.Width - Width) div 2;
  Top  := (Screen.Height - Height) div 2;


  //CreateRegion2();
  (*************************************)
  FRegion := CreateRegion(Image1.Picture.Bitmap);
  SetWindowRGN(Handle, FRegion, True);
  (*************************************)

  Application.ProcessMessages;

  finally

  end;
end;

function TFrmSplash.CreateRegion(Bmp: TBitmap): THandle;
var
  X, Y, StartX: Integer;
  Excl: THandle;
  Row: PRGBArray;
  TransparentColor: TRGBTriple;
begin
  Bmp.PixelFormat := pf24Bit;

  Result := CreateRectRGN(0, 0, Bmp.Width, Bmp.Height);

  for Y := 0 to Bmp.Height - 1 do
  begin
    Row := Bmp.Scanline[Y];

    StartX := -1;

    if Y = 0 then
      TransparentColor := Row[0];

    for X := 0 to Bmp.Width - 1 do
    begin
      if (Row[X].rgbtRed = TransparentColor.rgbtRed) and
        (Row[X].rgbtGreen = TransparentColor.rgbtGreen) and
        (Row[X].rgbtBlue = TransparentColor.rgbtBlue) then
      begin
        if StartX = -1 then StartX := X;
      end
      else
      begin
        if StartX > -1 then
        begin
          Excl := CreateRectRGN(StartX, Y, X + 1, Y + 1);
          try
            CombineRGN(Result, Result, Excl, RGN_DIFF);
            StartX := -1;
          finally
            DeleteObject(Excl);
          end;
        end;
      end;
    end;

    if StartX > -1 then
    begin
      Excl := CreateRectRGN(StartX, Y, Bmp.Width, Y + 1);
      try
        CombineRGN(Result, Result, Excl, RGN_DIFF);
      finally
        DeleteObject(Excl);
      end;
    end;
  end;
end;

procedure TFrmSplash.CreateRegion2();
var
   FullRgn, ClientRgn, ButtonRgn: THandle;
   Margin, X, Y: Integer;

begin

  Margin := (Width - ClientWidth) div 2;
  FullRgn := CreateRectRgn(0, 0, Width, Height) ;
  X := Margin;
  Y := Height - ClientHeight - Margin;

  ClientRgn := CreateRectRgn (X, Y, X + ClientWidth, Y + ClientHeight) ;

  CombineRgn(FullRgn, FullRgn, ClientRgn, RGN_DIFF) ;

  X := X + Image1.Left;
  Y := Y + Image1.Top;

  ButtonRgn := CreateRectRgn (X, Y, X + Image1.Picture.Bitmap.Width, Y + Image1.Picture.Bitmap.Height) ;

  CombineRgn(FullRgn, FullRgn, ButtonRgn, RGN_OR) ;
  SetWindowRgn(Handle, FullRgn, True) ;
end;

procedure TFrmSplash.Image1Click(Sender: TObject);
begin
  if varExibicaoSobre then
    begin
      self.Close
    end;
end;

procedure TFrmSplash.Timer1Timer(Sender: TObject);
begin

  if ExibicaoSobre then
    begin
      if Self.AlphaBlendValue < 255 then
        Self.AlphaBlendValue := Self.AlphaBlendValue + 10
      else
        Timer1.Enabled := false;
    end
  else
    begin
      if Self.AlphaBlendValue > 5 then
        Self.AlphaBlendValue := Self.AlphaBlendValue - 10
      else
        begin
          Self.Close;
          varSobreAtivado := False;
          
        end;

    end;
end;

end.
