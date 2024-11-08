object FrmAndamento: TFrmAndamento
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 210
  ClientWidth = 491
  Color = clBtnFace
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
    Left = 0
    Top = 0
    Width = 491
    Height = 210
    Align = alClient
    Color = clNavy
    TabOrder = 0
    ExplicitLeft = 48
    ExplicitTop = 8
    object LblInformacao: TLabel
      Left = 1
      Top = 1
      Width = 489
      Height = 208
      Align = alClient
      Alignment = taCenter
      Caption = 'Copiando os dados...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 150
      ExplicitHeight = 19
    end
  end
end
