object FrmAlteracaoLei: TFrmAlteracaoLei
  Left = 0
  Top = 0
  Caption = 'Altera'#231#227'o de Lei.'
  ClientHeight = 430
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 731
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 97
      Height = 13
      Caption = 'Texto para procura:'
    end
    object TxtProcura: TEdit
      Left = 8
      Top = 24
      Width = 177
      Height = 21
      TabOrder = 0
    end
    object BtnProcurar: TButton
      Left = 191
      Top = 21
      Width = 89
      Height = 25
      Caption = 'Procurar'
      TabOrder = 1
      OnClick = BtnProcurarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 731
    Height = 327
    Align = alClient
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 729
      Height = 325
      ActivePage = TabCodigo
      Align = alClient
      TabOrder = 0
      TabPosition = tpBottom
      OnChange = PageControl1Change
      object TabCodigo: TTabSheet
        Caption = 'C'#243'digo'
        object MemHTML: TMemo
          Left = 0
          Top = 0
          Width = 721
          Height = 299
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object TabVisualizacao: TTabSheet
        Caption = 'Visualiza'#231#227'o'
        ImageIndex = 1
        object Browser: THTMLViewer
          Left = 0
          Top = 0
          Width = 721
          Height = 299
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
          OnKeyDown = BrowserKeyDown
          OnKeyUp = BrowserKeyUp
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 392
    Width = 731
    Height = 38
    Align = alBottom
    TabOrder = 2
    object BtnOk: TBitBtn
      Left = 568
      Top = 6
      Width = 73
      Height = 25
      Caption = 'Salvar'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = BtnOkClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BtnCancelar: TBitBtn
      Left = 647
      Top = 6
      Width = 73
      Height = 25
      Cancel = True
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
      OnClick = BtnCancelarClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object FindDialog1: TFindDialog
    OnFind = FindDialog1Find
    Left = 384
    Top = 8
  end
end
