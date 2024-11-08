object FrmMensagemErroBancoDados: TFrmMensagemErroBancoDados
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Enciclop'#233'dia Soibelman'
  ClientHeight = 253
  ClientWidth = 428
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
    Tag = 99
    Left = 0
    Top = 0
    Width = 428
    Height = 253
    Align = alClient
    Color = 8406032
    TabOrder = 0
    object Label1: TLabel
      Left = 64
      Top = 36
      Width = 262
      Height = 16
      Caption = 'Tempo esgotado sem conseguir conex'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 88
      Width = 377
      Height = 81
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Para que esta verifica'#231#227'o n'#227'o seja mais realizada na abertura do' +
        ' programa v'#225' no Menu  configura'#231#245'es e desmarque a op'#231#227'o "conecta' +
        'r a internet para obter atualiza'#231#245'es e not'#237'cias'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object BtnFechar: TButton
      Left = 169
      Top = 185
      Width = 79
      Height = 29
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
end
