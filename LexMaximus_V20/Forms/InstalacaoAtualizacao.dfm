object FrmInstalacaoAtualizacao: TFrmInstalacaoAtualizacao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Instalando a atualiza'#231#227'o'
  ClientHeight = 162
  ClientWidth = 470
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
    Width = 470
    Height = 162
    Align = alClient
    Color = 8406032
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 72
      Width = 86
      Height = 16
      Caption = 'Instalando:   '
    end
    object Lbl_NomePacote: TLabel
      Left = 104
      Top = 72
      Width = 352
      Height = 16
      AutoSize = False
      Caption = 
        '                                                                ' +
        '     '
    end
    object Label2: TLabel
      Left = 16
      Top = 96
      Width = 80
      Height = 16
      Caption = 'Andamento:'
    end
    object LblAndamento: TLabel
      Left = 104
      Top = 96
      Width = 352
      Height = 16
      AutoSize = False
      Caption = 
        '                                                                ' +
        '    '
    end
    object LblAdvertencia: TLabel
      Left = 16
      Top = 8
      Width = 433
      Height = 63
      Alignment = taCenter
      AutoSize = False
      WordWrap = True
    end
    object Progresso: TProgressBar
      Left = 16
      Top = 124
      Width = 440
      Height = 17
      TabOrder = 0
    end
  end
end
