object FrmAndamento: TFrmAndamento
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Andamento da Pesquisa'
  ClientHeight = 209
  ClientWidth = 365
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
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 59
    Height = 13
    Caption = 'Andamento:'
  end
  object LblAndamento: TLabel
    Left = 73
    Top = 10
    Width = 248
    Height = 13
    Caption = '                                              '
  end
  object LblItensEncontrados: TLabel
    Left = 8
    Top = 28
    Width = 313
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = '                                              '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Progresso: TProgressBar
    Left = 8
    Top = 49
    Width = 313
    Height = 17
    TabOrder = 0
  end
  object BtnCancelar: TButton
    Left = 131
    Top = 145
    Width = 89
    Height = 33
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = BtnCancelarClick
  end
  object Animacao: TAnimate
    Left = 154
    Top = 89
    Width = 50
    Height = 50
  end
end
