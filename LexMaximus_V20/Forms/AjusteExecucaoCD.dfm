object FrmAjusteExecucaoCD: TFrmAjusteExecucaoCD
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configura'#231#227'o do LexMaximus'
  ClientHeight = 214
  ClientWidth = 548
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
    Left = 0
    Top = 0
    Width = 548
    Height = 41
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Ajustando o LexMaximus para execu'#231#227'o a partir do CD/DVD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object LblMensagem: TLabel
    Left = 0
    Top = 113
    Width = 548
    Height = 41
    Alignment = taCenter
    AutoSize = False
    Caption = 'Configura'#231#245'es realizadas com sucesso !'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    Visible = False
  end
  object BtnFechar: TBitBtn
    Left = 220
    Top = 165
    Width = 105
    Height = 41
    Caption = 'Fechar'
    TabOrder = 0
    Visible = False
  end
  object Animate1: TAnimate
    Left = 136
    Top = 47
    Width = 272
    Height = 60
    CommonAVI = aviCopyFiles
    StopFrame = 1
  end
end
