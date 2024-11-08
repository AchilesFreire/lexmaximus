object FrmBrowserLocal: TFrmBrowserLocal
  Left = 0
  Top = 0
  ClientHeight = 435
  ClientWidth = 544
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 544
    Height = 394
    Align = alClient
    Color = clBlack
    TabOrder = 0
    object Browser: THTMLViewer
      Left = 1
      Top = 1
      Width = 542
      Height = 392
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
    end
  end
  object Panel1: TPanel
    Tag = 99
    Left = 0
    Top = 394
    Width = 544
    Height = 41
    Align = alBottom
    Color = 8406032
    TabOrder = 1
    DesignSize = (
      544
      41)
    object Button1: TButton
      Left = 454
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
