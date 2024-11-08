object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste Navegacao'
  ClientHeight = 360
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 607
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 426
    object Button4: TButton
      Left = 251
      Top = 10
      Width = 134
      Height = 25
      Caption = 'Exibir HTML Selecionado'
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 607
    Height = 278
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 426
    ExplicitHeight = 206
    object Browser: THTMLViewer
      Left = 1
      Top = 1
      Width = 605
      Height = 276
      TabOrder = 0
      Align = alClient
      BorderStyle = htFocused
      HistoryMaxCount = 0
      DefFontName = 'Times New Roman'
      DefPreFontName = 'Courier New'
      NoSelect = False
      CharSet = DEFAULT_CHARSET
      PrintMarginLeft = 2.000000000000000000
      PrintMarginRight = 2.000000000000000000
      PrintMarginTop = 2.000000000000000000
      PrintMarginBottom = 2.000000000000000000
      PrintScale = 1.000000000000000000
      ExplicitLeft = 296
      ExplicitTop = 112
      ExplicitWidth = 150
      ExplicitHeight = 150
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 319
    Width = 607
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 247
    ExplicitWidth = 426
  end
end
