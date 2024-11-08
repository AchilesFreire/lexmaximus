object FrmBrowser: TFrmBrowser
  Left = 0
  Top = 0
  ClientHeight = 502
  ClientWidth = 684
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
    Width = 684
    Height = 461
    Align = alClient
    Color = clBlack
    TabOrder = 0
    object WebBrowser1: TWebBrowser
      Left = 1
      Top = 1
      Width = 682
      Height = 459
      Align = alClient
      TabOrder = 0
      ControlData = {
        4C0000007D460000702F00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object Panel2: TPanel
    Tag = 99
    Left = 0
    Top = 461
    Width = 684
    Height = 41
    Align = alBottom
    Color = 8406032
    TabOrder = 1
    DesignSize = (
      684
      41)
    object BtnFechar: TButton
      Left = 594
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
    end
  end
end
