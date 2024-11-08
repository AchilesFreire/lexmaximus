object FrmEdicaoNota: TFrmEdicaoNota
  Left = 0
  Top = 0
  Caption = 'Notas'
  ClientHeight = 568
  ClientWidth = 763
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object SplNotaParagrafo: TSplitter
    Left = 0
    Top = 193
    Width = 763
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    Color = clSkyBlue
    ParentColor = False
    Visible = False
    ExplicitTop = 266
    ExplicitWidth = 746
  end
  object SplNotaRodape: TSplitter
    Left = 0
    Top = 366
    Width = 763
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    Color = clSkyBlue
    ParentColor = False
    ExplicitTop = 439
    ExplicitWidth = 746
  end
  object PnlRodape: TPanel
    Left = 0
    Top = 371
    Width = 763
    Height = 155
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 761
      Height = 13
      Align = alTop
      Caption = '   Nota do rodap'#233':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitWidth = 88
    end
    object MemNota_Rodape: TMemo
      Left = 1
      Top = 14
      Width = 761
      Height = 98
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = MemNota_RodapeChange
    end
    object Panel3: TPanel
      Left = 1
      Top = 112
      Width = 761
      Height = 42
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        761
        42)
      object BtnExcluirNotaRodape: TButton
        Left = 468
        Top = 7
        Width = 138
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'Excluir nota do rodap'#233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 129
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = BtnExcluirNotaRodapeClick
      end
      object BtnSalvarNotaRodape: TButton
        Left = 614
        Top = 7
        Width = 138
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'Salvar nota do rodap'#233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 129
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = BtnSalvarNotaRodapeClick
      end
    end
  end
  object PnlInferior: TPanel
    Left = 0
    Top = 526
    Width = 763
    Height = 42
    Align = alBottom
    BevelEdges = [beTop]
    TabOrder = 4
    DesignSize = (
      763
      42)
    object BtnFechar: TButton
      Left = 645
      Top = 6
      Width = 89
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnFecharClick
    end
  end
  object PnlSuperior: TPanel
    Left = 0
    Top = 0
    Width = 763
    Height = 49
    Align = alTop
    TabOrder = 0
    object Lbl_Descricao: TLabel
      Left = 1
      Top = 1
      Width = 761
      Height = 47
      Align = alClient
      Alignment = taCenter
      Caption = 
        'Clique nos links abaixo, para incluir, alterar ou remover notas ' +
        'nos par'#225'grafos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      Visible = False
      ExplicitWidth = 629
      ExplicitHeight = 19
    end
  end
  object PnlBrowser: TPanel
    Left = 0
    Top = 49
    Width = 763
    Height = 144
    Align = alClient
    TabOrder = 1
    Visible = False
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 761
      Height = 13
      Align = alTop
      Caption = '   Texto da lei:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitWidth = 69
    end
    object Browser: THTMLViewer
      Left = 1
      Top = 14
      Width = 761
      Height = 129
      OnHotSpotClick = BrowserHotSpotClick
      TabOrder = 0
      Align = alClient
      BorderStyle = htFocused
      HistoryMaxCount = 0
      DefFontName = 'Times New Roman'
      DefPreFontName = 'Courier New'
      DefHotSpotColor = clRed
      DefOverLinkColor = clRed
      NoSelect = False
      CharSet = DEFAULT_CHARSET
      PrintMarginLeft = 2.000000000000000000
      PrintMarginRight = 2.000000000000000000
      PrintMarginTop = 2.000000000000000000
      PrintMarginBottom = 2.000000000000000000
      PrintScale = 1.000000000000000000
      htOptions = [htOverLinksActive, htPrintTableBackground, htPrintMonochromeBlack]
    end
  end
  object PnlParagrafo: TPanel
    Left = 0
    Top = 198
    Width = 763
    Height = 168
    Align = alBottom
    TabOrder = 2
    Visible = False
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 761
      Height = 13
      Align = alTop
      Caption = 
        '   Nota do par'#225'grafo: (esta janela s'#243' fica ativa ap'#243's o clique n' +
        'o link da nota)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 365
    end
    object MemNota_Paragrafo: TMemo
      Left = 1
      Top = 14
      Width = 761
      Height = 115
      Align = alClient
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = MemNota_ParagrafoChange
    end
    object Panel4: TPanel
      Left = 1
      Top = 129
      Width = 761
      Height = 38
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        761
        38)
      object BtnSalvarNotaParagrafo: TButton
        Left = 596
        Top = 5
        Width = 155
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'Salvar nota do par'#225'grafo'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 129
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = BtnSalvarNotaParagrafoClick
      end
    end
  end
  object PnlAguardarFormatacao: TPanel
    Left = 0
    Top = 48
    Width = 743
    Height = 481
    BevelEdges = []
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object LblAguarde: TLabel
      Left = 22
      Top = 118
      Width = 700
      Height = 91
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'alguns documentos, pelo tamanho, podem demorar um pouco mais par' +
        'a abrir neste modo, devido '#224' marca'#231#227'o dos pontos de inser'#231#227'o de ' +
        'notas; clique em cancelar para finalizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      Visible = False
      WordWrap = True
    end
    object LblExplicacao2: TLabel
      Left = 22
      Top = 45
      Width = 700
      Height = 27
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'O programa permite que o usu'#225'rio coloque seus coment'#225'rios e nota' +
        's dentro do texto da lei.'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object LblExplicacao1: TLabel
      Left = 22
      Top = 10
      Width = 700
      Height = 27
      Alignment = taCenter
      AutoSize = False
      Caption = 'Inser'#231#227'o de notas no meio do texto da lei. '
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object LblExplicacao3: TLabel
      Left = 22
      Top = 75
      Width = 700
      Height = 65
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Para isto basta clicar no bot'#227'o "ok" abaixo e ser'#225' realizada uma' +
        ' marca'#231#227'o no texto gerando um link com os dizeres "insira uma no' +
        'ta aqui" abaixo de cada par'#225'grafo, bastando clicar nele para ati' +
        'var a janela onde ser'#225' escrito o texto que o usu'#225'rio quer inseri' +
        'r. '
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object LblExplicacao4: TLabel
      Left = 22
      Top = 140
      Width = 700
      Height = 55
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Esta marca'#231#227'o em normas com texto grande pode demorar alguns seg' +
        'undos. Caso simplesmente queira inserir a nota ao final do texto' +
        ', use a janela abaixo de notas de rodap'#233'.'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Animate1: TAnimate
      Left = 226
      Top = 74
      Width = 272
      Height = 60
      Active = True
      CommonAVI = aviFindFile
      StopFrame = 1
      Visible = False
    end
    object Progresso: TProgressBar
      Left = 28
      Top = 222
      Width = 684
      Height = 17
      TabOrder = 1
      Visible = False
    end
    object BtnCancelarFormatacao: TBitBtn
      Left = 297
      Top = 245
      Width = 129
      Height = 30
      Cancel = True
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnClick = BtnCancelarFormatacaoClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BtnHabilitarNotasParagrafos: TBitBtn
      Left = 297
      Top = 221
      Width = 129
      Height = 30
      Caption = 'Ok'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BtnHabilitarNotasParagrafosClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
end
