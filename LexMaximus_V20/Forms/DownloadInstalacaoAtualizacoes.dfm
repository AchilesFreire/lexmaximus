object FrmDownloadInstalacaoAtualizacoes: TFrmDownloadInstalacaoAtualizacoes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Download e instala'#231#227'o das atuaiza'#231#245'es'
  ClientHeight = 292
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Tag = 99
    Left = 0
    Top = 0
    Width = 428
    Height = 292
    Align = alClient
    Color = 8406032
    TabOrder = 0
    DesignSize = (
      428
      292)
    object BtnFechar: TButton
      Left = 341
      Top = 249
      Width = 79
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
    end
    object BtnCancelar: TButton
      Left = 253
      Top = 249
      Width = 79
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      TabOrder = 1
    end
  end
end
