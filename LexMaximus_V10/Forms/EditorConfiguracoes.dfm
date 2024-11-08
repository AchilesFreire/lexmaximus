object FrmConfiguracoes: TFrmConfiguracoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#245'es'
  ClientHeight = 288
  ClientWidth = 469
  Color = clBtnFace
  TransparentColorValue = clFuchsia
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Tag = 99
    Left = 0
    Top = 0
    Width = 469
    Height = 288
    Align = alClient
    Color = 8406032
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 129
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object GroupBox1: TGroupBox
      Tag = 99
      Left = 9
      Top = 13
      Width = 143
      Height = 129
      Caption = 'Fontes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblConfiguracoesFonteLista: TLabel
        Left = 16
        Top = 28
        Width = 82
        Height = 13
        Cursor = crHandPoint
        Caption = 'Fontes da lista'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        OnClick = lblConfiguracoesFonteListaVerbeteClick
        OnMouseEnter = LblLinkMouseEnter
        OnMouseLeave = LblLinkLeave
      end
      object lblConfiguracoesFonteVerbete: TLabel
        Left = 16
        Top = 60
        Width = 103
        Height = 13
        Cursor = crHandPoint
        Caption = 'Fontes do verbete'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
        OnClick = lblConfiguracoesFonteVerbeteClick
        OnMouseEnter = LblLinkMouseEnter
        OnMouseLeave = LblLinkLeave
      end
    end
    object BtnCancelar: TButton
      Left = 382
      Top = 245
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = BtnCancelarClick
    end
    object BtnSalvar: TButton
      Left = 298
      Top = 245
      Width = 75
      Height = 25
      Hint = 'Salva as configura'#231#245'es selecionadas'
      Caption = 'Salvar'
      TabOrder = 2
      OnClick = BtnSalvarClick
    end
    object BtnPadrao: TButton
      Left = 214
      Top = 245
      Width = 75
      Height = 25
      Hint = 'Restaura as configura'#231#245'es padr'#227'o'
      Caption = 'Padr'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BtnPadraoClick
    end
    object GroupBox2: TGroupBox
      Tag = 99
      Left = 163
      Top = 13
      Width = 298
      Height = 129
      Caption = 'Janelas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object LblCorFundo: TLabel
        Tag = 99
        Left = 9
        Top = 64
        Width = 140
        Height = 13
        Cursor = crHandPoint
        Caption = 'Cor de Fundo das janelas'
        Color = 2105376
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        OnClick = LblCorFundoClick
        OnMouseEnter = LblLinkMouseEnter
        OnMouseLeave = LblLinkLeave
      end
      object Label1: TLabel
        Left = 8
        Top = 20
        Width = 28
        Height = 13
        Caption = 'Skins:'
      end
      object Label2: TLabel
        Left = 8
        Top = 88
        Width = 281
        Height = 33
        AutoSize = False
        Caption = 
          '(antes de alterar a cor de fundo '#233' necess'#225'rio selecionar, acima,' +
          ' um Skin)'
        Transparent = True
        WordWrap = True
      end
      object CboSkin: TComboBox
        Left = 8
        Top = 36
        Width = 185
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnClick = CboSkinClick
      end
    end
    object GroupBox3: TGroupBox
      Tag = 99
      Left = 9
      Top = 149
      Width = 452
      Height = 76
      Caption = 'Outras configura'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object chkConectarInternet: TCheckBox
        Left = 11
        Top = 30
        Width = 289
        Height = 17
        Caption = 'Conectar a internet para obter atualiza'#231#245'es e not'#237'cias'
        TabOrder = 0
      end
    end
  end
  object DlgFonte: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 16
    Top = 236
  end
  object DlgCor: TColorDialog
    Left = 48
    Top = 236
  end
end
