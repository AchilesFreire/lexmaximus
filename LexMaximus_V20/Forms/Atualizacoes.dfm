object FrmAtualizacoes: TFrmAtualizacoes
  Left = 0
  Top = 0
  Caption = 'Atualiza'#231#245'es'
  ClientHeight = 511
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PnlCabecalho: TPanel
    Tag = 99
    Left = 0
    Top = 0
    Width = 833
    Height = 161
    Align = alTop
    BevelEdges = []
    BevelOuter = bvNone
    Color = 8406032
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label13: TLabel
      Left = 48
      Top = 24
      Width = 716
      Height = 18
      Caption = 
        '( as atualiza'#231#245'es principiam no primeiro n'#250'mero posterior '#224' vers' +
        #227'o instalada; o prazo para atualiza'#231#227'o gratuita'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 96
      Top = 41
      Width = 600
      Height = 18
      Caption = 
        'vai at'#233' tr'#234's meses ap'#243's a data de aquisi'#231#227'o da Enciclop'#233'dia pelo' +
        ' usu'#225'rio, sendo necess'#225'rio,'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 92
      Top = 57
      Width = 612
      Height = 18
      Caption = 
        'para atualiza'#231#245'es posteriores, contratar a assinatura; clique no' +
        ' bot'#227'o pr'#243'prio para isto abaixo)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object BtnProcurarAtualizacoes: TButton
      Left = 336
      Top = 92
      Width = 169
      Height = 33
      Caption = 'Procurar Atualiza'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnProcurarAtualizacoesClick
    end
  end
  object PnlListasAtualizacoes: TPanel
    Left = 0
    Top = 161
    Width = 833
    Height = 305
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 1
    object PnlAtualizacoesLegislacao: TPanel
      Tag = 99
      Left = 0
      Top = 0
      Width = 833
      Height = 305
      Align = alClient
      BevelEdges = []
      BevelOuter = bvNone
      Color = 8406032
      TabOrder = 0
      object Label16: TLabel
        Tag = 99
        Left = 0
        Top = 0
        Width = 833
        Height = 25
        Align = alTop
        AutoSize = False
        Caption = '  Atualiza'#231#245'es da legisla'#231#227'o:'
        Color = 8406032
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
      object lst_LM: TListView
        Left = 0
        Top = 25
        Width = 833
        Height = 280
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = 'Atualiza'#231#227'o'
            Width = 300
          end
          item
            Caption = 'Data'
            Width = 80
          end
          item
            Caption = 'Situa'#231#227'o'
            Width = 80
          end
          item
            Caption = 'Link Detalhes'
            Width = 350
          end
          item
            Caption = 'Descri'#231#227'o'
            MaxWidth = 1
            MinWidth = 1
            Width = 1
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnCustomDrawItem = lst_LMCustomDrawItem
        OnDblClick = lst_LMDblClick
        ExplicitTop = 28
      end
    end
  end
  object PnlBotoes: TPanel
    Tag = 99
    Left = 0
    Top = 466
    Width = 833
    Height = 45
    Align = alBottom
    Color = 8406032
    TabOrder = 2
    DesignSize = (
      833
      45)
    object BtnBaixarAtualizacoesSelecionadas: TButton
      Left = 278
      Top = 9
      Width = 245
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Baixar Atualiza'#231#245'es Selecionadas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnBaixarAtualizacoesSelecionadasClick
    end
    object BtnContratarAssinatura: TButton
      Left = 534
      Top = 9
      Width = 205
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Contratar Assinatura de Atualiza'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BtnContratarAssinaturaClick
    end
    object BtnFechar: TButton
      Left = 749
      Top = 9
      Width = 79
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BtnFecharClick
    end
  end
  object IndyHTTP: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 536
    Top = 136
  end
end
