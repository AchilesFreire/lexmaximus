program CompressorDocumentos;

uses
  Forms,
  Compressor in 'Compressor.pas' {FrmCompressor},
  CompressaoDados in '..\Common\CompressaoDados.pas',
  ZLIBEX in '..\Common\ZLIBEX.PAS';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmCompressor, FrmCompressor);
  Application.Run;
end.
