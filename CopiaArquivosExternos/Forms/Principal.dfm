object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Copiando a o banco de dados jur'#237'dico do LexMaximus'
  ClientHeight = 306
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 405
    Height = 41
    Align = alTop
    Color = clNavy
    TabOrder = 0
    object LblMensagem: TLabel
      Left = 1
      Top = 1
      Width = 403
      Height = 39
      Align = alClient
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 5
      ExplicitHeight = 19
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 405
    Height = 265
    Align = alClient
    Color = clNavy
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 51
      Width = 98
      Height = 13
      Caption = 'Etapa da instala'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblEtapa1: TLabel
      Left = 40
      Top = 70
      Width = 119
      Height = 13
      Caption = 'Copiando Base de Dados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblEtapa2: TLabel
      Left = 40
      Top = 89
      Width = 123
      Height = 13
      Caption = 'Copiando outros arquivos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 131
      Width = 125
      Height = 13
      Caption = 'Progresso da etapa atual:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblArquivoAndamento: TLabel
      Left = 16
      Top = 150
      Width = 162
      Height = 13
      Caption = '                                                      '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 5
      Width = 347
      Height = 43
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Aten'#231#227'o: a instala'#231#227'o poder'#225' demorar um pouco, pois, ser'#227'o copia' +
        'dos cerca de  450 MB.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object LblEtapa3: TLabel
      Left = 40
      Top = 108
      Width = 165
      Height = 13
      Caption = 'Copiando arquivos da p'#225'gina incial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Animate1: TAnimate
      Left = 50
      Top = 169
      Width = 313
      Height = 80
    end
  end
end
