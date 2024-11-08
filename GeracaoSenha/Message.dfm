object FrmMessage: TFrmMessage
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 167
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PnlPergunta: TPanel
    Left = 0
    Top = 0
    Width = 324
    Height = 166
    Color = 3750201
    ParentBackground = False
    TabOrder = 1
    object LblMensagemPergunta: TLabel
      Left = 7
      Top = 42
      Width = 309
      Height = 41
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnSim: TButton
      Left = 81
      Top = 108
      Width = 75
      Height = 25
      Caption = 'Sim'
      TabOrder = 0
      OnClick = BtnSimClick
    end
    object BtnNao: TButton
      Left = 167
      Top = 108
      Width = 75
      Height = 25
      Caption = 'N'#227'o'
      TabOrder = 1
      OnClick = BtnNaoClick
    end
  end
  object PnlMensagem: TPanel
    Tag = 99
    Left = 0
    Top = 0
    Width = 324
    Height = 166
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object LblMensagem: TLabel
      Left = 17
      Top = 40
      Width = 293
      Height = 57
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnOk: TButton
      Left = 125
      Top = 108
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      OnClick = BtnOkClick
    end
  end
end
