object FrmSelecaoAtualizacaoCinza: TFrmSelecaoAtualizacaoCinza
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Enciclop'#233'dia Soibelman'
  ClientHeight = 197
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
    Height = 197
    Align = alClient
    Color = 8406032
    TabOrder = 0
    object Label2: TLabel
      Left = 25
      Top = 32
      Width = 377
      Height = 89
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Essas atualiza'#231#245'es em cor cinza s'#227'o posteriores ao per'#237'odo per'#237'o' +
        'do contratado e por isso n'#227'o ser'#227'o baixadas; selecione as de cor' +
        ' azul, se houver, pois, s'#227'o '#224'quelas '#224's quais voc'#234' tem direito, o' +
        'u clique em contratar assinatura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object BtnFechar: TButton
      Left = 179
      Top = 137
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
