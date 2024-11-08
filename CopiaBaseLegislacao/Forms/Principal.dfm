object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Copiando a o banco de dados jur'#237'dico do LexMaximus'
  ClientHeight = 246
  ClientWidth = 604
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
    Width = 604
    Height = 41
    Align = alTop
    Color = clNavy
    TabOrder = 0
    object LblMensagem: TLabel
      Left = 1
      Top = 1
      Width = 602
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
    Width = 604
    Height = 205
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
      Width = 142
      Height = 13
      Caption = 'Copiando arquivos de normas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblEtapa3: TLabel
      Left = 40
      Top = 108
      Width = 82
      Height = 13
      Caption = 'Copiando Indices'
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
      Left = 70
      Top = 3
      Width = 465
      Height = 43
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Aten'#231#227'o: a instala'#231#227'o poder'#225' demorar um pouco, pois, ser'#227'o copia' +
        'dos cerca de 60.000 arquivos, ocupando mais de 450 MB no disco.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object Progresso: TProgressBar
      Left = 16
      Top = 170
      Width = 571
      Height = 24
      TabOrder = 0
    end
  end
end
