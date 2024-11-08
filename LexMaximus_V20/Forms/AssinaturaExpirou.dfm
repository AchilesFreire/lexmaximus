object FrmAssinaturaExpirou: TFrmAssinaturaExpirou
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Assinatura da Enciclop'#233'dia Soibelman'
  ClientHeight = 227
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 559
    Height = 227
    Align = alClient
    Color = 8406032
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 20
      Width = 231
      Height = 16
      Caption = 'Seu per'#237'odo de atualiza'#231#227'o expirou.'
      Transparent = True
    end
    object Label2: TLabel
      Left = 17
      Top = 44
      Width = 215
      Height = 16
      Caption = 'Para poder continuar a atualizar,'
      Transparent = True
    end
    object Label3: TLabel
      Left = 237
      Top = 42
      Width = 81
      Height = 18
      Cursor = crHandPoint
      Caption = 'clique aqui'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSkyBlue
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = Label3Click
      OnMouseEnter = Label3MouseEnter
      OnMouseLeave = Label3MouseLeave
    end
    object Label4: TLabel
      Left = 324
      Top = 44
      Width = 218
      Height = 16
      Caption = 'ou no bot'#227'o contratar assinatura'
      Transparent = True
    end
    object Label5: TLabel
      Left = 104
      Top = 72
      Width = 288
      Height = 16
      Caption = 'para ver o conte'#250'do das atualiza'#231#245'es novas'
    end
    object Label6: TLabel
      Left = 17
      Top = 70
      Width = 81
      Height = 18
      Cursor = crHandPoint
      Caption = 'clique aqui'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSkyBlue
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = Label6Click
      OnMouseEnter = Label6MouseEnter
      OnMouseLeave = Label6MouseLeave
    end
    object BtnContratarAssinatura: TButton
      Left = 254
      Top = 161
      Width = 205
      Height = 29
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
    object Button1: TButton
      Left = 467
      Top = 160
      Width = 75
      Height = 29
      Caption = 'Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button1Click
    end
    object BtnVerificarAtualizacoesAnteriores: TButton
      Left = 38
      Top = 161
      Width = 205
      Height = 29
      Caption = 'Verificar atualiza'#231#245'es anteriores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 129
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnVerificarAtualizacoesAnterioresClick
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
    Left = 16
    Top = 104
  end
end
