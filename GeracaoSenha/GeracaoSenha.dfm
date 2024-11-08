object FrmGeracaoSenha: TFrmGeracaoSenha
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Gera'#231#227'o de senha - LexMaximus'
  ClientHeight = 451
  ClientWidth = 485
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Tag = 99
    Left = 0
    Top = 0
    Width = 489
    Height = 453
    Color = clNavy
    TabOrder = 0
    object PgTipoSenha: TPageControl
      Tag = 99
      Left = 18
      Top = 12
      Width = 453
      Height = 381
      ActivePage = TabSenhaInstalacao
      TabOrder = 0
      object TabSenhaInstalacao: TTabSheet
        Caption = 'Senha de Instala'#231#227'o'
        object Panel1: TPanel
          Tag = 99
          Left = 0
          Top = 0
          Width = 445
          Height = 353
          Align = alClient
          BevelEdges = []
          BevelOuter = bvNone
          Color = clNavy
          TabOrder = 0
          object Label1: TLabel
            Left = 16
            Top = 22
            Width = 175
            Height = 13
            AutoSize = False
            Caption = 'Vers'#227'o do sistema:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label2: TLabel
            Left = 16
            Top = 86
            Width = 169
            Height = 13
            AutoSize = False
            Caption = 'Informe a chave do cliente:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label3: TLabel
            Left = 16
            Top = 226
            Width = 201
            Height = 13
            AutoSize = False
            Caption = 'A senha gerada para o cliente foi:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object txtSerial1: TEdit
            Left = 16
            Top = 104
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 0
            OnChange = txtSerial1Change
          end
          object txtSerial2: TEdit
            Left = 76
            Top = 104
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 1
            OnChange = txtSerial2Change
          end
          object txtSerial3: TEdit
            Left = 136
            Top = 104
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 2
            OnChange = txtSerial3Change
          end
          object txtSerial4: TEdit
            Left = 196
            Top = 104
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 3
            OnChange = txtSerial4Change
          end
          object BtnGerarSenha: TButton
            Left = 80
            Top = 164
            Width = 91
            Height = 33
            Caption = 'Gerar Senha'
            TabOrder = 4
            OnClick = BtnGerarSenhaClick
          end
          object txtSenha1: TEdit
            Left = 16
            Top = 244
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 5
            OnChange = txtSenha1Change
          end
          object txtSenha2: TEdit
            Left = 76
            Top = 244
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 6
            OnChange = txtSenha2Change
          end
          object txtSenha3: TEdit
            Left = 136
            Top = 244
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 7
            OnChange = txtSenha3Change
          end
          object txtSenha4: TEdit
            Left = 196
            Top = 244
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 8
            OnChange = txtSenha4Change
          end
          object txtSenha5: TEdit
            Left = 256
            Top = 244
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 9
          end
          object txtSerial5: TEdit
            Left = 256
            Top = 104
            Width = 57
            Height = 21
            MaxLength = 4
            TabOrder = 10
          end
          object BtnCopiarChave: TButton
            Left = 316
            Top = 245
            Width = 49
            Height = 20
            Hint = 'Envia a Chave para o Clipboard'
            Caption = 'Copiar'
            TabOrder = 11
            OnClick = BtnCopiarSenhaClick
          end
          object BtnColarSenha: TButton
            Left = 316
            Top = 105
            Width = 49
            Height = 20
            Hint = 'Cola a Senha do Clipboard'
            Caption = 'Colar'
            TabOrder = 12
            OnClick = BtnColarChaveClick
          end
          object CboVersao: TComboBox
            Left = 16
            Top = 40
            Width = 113
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 13
            ItemIndex = 0
            ParentFont = False
            TabOrder = 13
            Text = '01.00'
            Items.Strings = (
              '01.00')
          end
        end
      end
      object TabSenhaAtualizacao: TTabSheet
        Caption = 'Senha de atualiza'#231#227'o'
        Enabled = False
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label4: TLabel
          Left = 16
          Top = 86
          Width = 169
          Height = 13
          AutoSize = False
          Caption = 'Informe a chave do cliente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label5: TLabel
          Left = 16
          Top = 22
          Width = 175
          Height = 13
          AutoSize = False
          Caption = 'C'#243'digo da atualiza'#231#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label6: TLabel
          Left = 16
          Top = 226
          Width = 169
          Height = 13
          AutoSize = False
          Caption = 'Senha da atualiza'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object TxtChaveClienteAtualizacao: TEdit
          Left = 16
          Top = 104
          Width = 257
          Height = 21
          MaxLength = 40
          TabOrder = 0
          Visible = False
        end
        object TxtcodigoAtualizacao: TEdit
          Left = 16
          Top = 40
          Width = 137
          Height = 21
          TabOrder = 1
          Visible = False
        end
        object TxtSenhaClienteAtualizacao: TEdit
          Left = 16
          Top = 242
          Width = 257
          Height = 21
          MaxLength = 40
          TabOrder = 2
          Visible = False
        end
        object BtnColarChaveClienteAtualizacao: TButton
          Left = 276
          Top = 105
          Width = 49
          Height = 20
          Hint = 'Cola a Senha do Clipboard'
          Caption = 'Colar'
          TabOrder = 3
          Visible = False
          OnClick = BtnColarChaveClienteAtualizacaoClick
        end
        object BtnCopiarSenhaAtualizacaoInstalacao: TButton
          Left = 276
          Top = 243
          Width = 49
          Height = 20
          Hint = 'Envia a Chave para o Clipboard'
          Caption = 'Copiar'
          TabOrder = 4
          Visible = False
          OnClick = BtnCopiarSenhaAtualizacaoInstalacaoClick
        end
        object BtnGerarSenhaInstalacao: TButton
          Left = 80
          Top = 164
          Width = 91
          Height = 33
          Caption = 'Gerar Senha'
          TabOrder = 5
          Visible = False
          OnClick = BtnGerarSenhaInstalacaoClick
        end
      end
    end
    object BtnFechar: TButton
      Left = 378
      Top = 400
      Width = 91
      Height = 33
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = BtnFecharClick
    end
  end
  object SkinData1: TSkinData
    Active = True
    DisableTag = 99
    SkinControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcCheckBox, xcRadioButton, xcProgress, xcScrollbar, xcEdit, xcButton, xcBitBtn, xcSpeedButton, xcPanel, xcGroupBox, xcStatusBar, xcTab, xcSystemMenu]
    Skin3rd.Strings = (
      'TComboboxex=combobox'
      'TRxSpeedButton=speedbutton'
      'TControlBar=Panel'
      'TTBDock=Panel'
      'TTBToolbar=Panel'
      'TAdvPageControl=nil'
      'TImageEnMView=scrollbar'
      'TImageEnView=scrollbar'
      'TAdvMemo=scrollbar'
      'TDBAdvMemo=scrollbar'
      'TRzButton=button'
      'TRzBitbtn=bitbtn'
      'TRzMenuButton=bitbtn'
      'TRzCheckGroup=CheckGroup'
      'TRzRadioGroup=Radiogroup'
      'TRzRadioButton=Radiobutton'
      'TRzCheckBox=Checkbox'
      'TRzButtonEdit=Edit'
      'TRzDBRadioGroup=Radiogroup'
      'TRzDBRadioButton=Radiobutton'
      'TRzDateTimeEdit=combobox'
      'TRzColorEdit=combobox'
      'TRzDateTimePicker=combobox'
      'TRzDBDateTimeEdit=combobox'
      'TRzDbColorEdit=combobox'
      'TRzDBDateTimePicker=combobox'
      'TLMDGroupBox=Groupbox'
      'TDBCheckboxEh=Checkbox'
      'TDBCheckboxEh=Checkbox'
      'TLMDCHECKBOX=Checkbox'
      'TLMDDBCHECKBOX=Checkbox'
      'TLMDRadiobutton=Radiobutton'
      'TLMDCalculator=panel'
      'TLMDGROUPBOX=Panel'
      'TLMDSIMPLEPANEL=Panel'
      'TLMDDBCalendar=Panel'
      'TLMDButtonPanel=Panel'
      'TLMDLMDCalculator=Panel'
      'TLMDHeaderPanel=Panel'
      'TLMDTechnicalLine=Panel'
      'TLMDLMDClock=Panel'
      'TLMDTrackbar=panel'
      'TLMDListCombobox=combobox'
      'TLMDCheckListCombobox=combobox'
      'TLMDHeaderListCombobox=combobox'
      'TLMDImageCombobox=combobox'
      'TLMDColorCombobox=combobox'
      'TLMDFontCombobox=combobox'
      'TLMDFontSizeCombobox=combobox'
      'TLMDFontSizeCombobox=combobox'
      'TLMDPrinterCombobox=combobox'
      'TLMDDriveCombobox=combobox'
      'TLMDCalculatorComboBox=combobox'
      'TLMDTrackBarComboBox=combobox'
      'TLMDCalendarComboBox=combobox'
      'TLMDTreeComboBox=combobox'
      'TLMDRADIOGROUP=radiogroup'
      'TLMDCheckGroup=CheckGroup'
      'TLMDDBRADIOGROUP=radiogroup'
      'TLMDDBCheckGroup=CheckGroup'
      'TLMDCalculatorEdit=edit'
      'TLMDEDIT=Edit'
      'TLMDMASKEDIT=Edit'
      'TLMDBROWSEEDIT=Edit'
      'TLMDEXTSPINEDIT=Edit'
      'TLMDCALENDAREDIT=Edit'
      'TLMDFILEOPENEDIT=Edit'
      'TLMDFILESAVEEDIT=Edit'
      'TLMDCOLOREDIT=Edit'
      'TLMDDBEDIT=Edit'
      'TLMDDBMASKEDIT=Edit'
      'TLMDDBEXTSPINEDIT=Edit'
      'TLMDDBSPINEDIT=Edit'
      'TLMDDBEDITDBLookup=Edit'
      'TLMDEDITDBLookup=Edit'
      'TDBLookupCombobox=Combobox'
      'TWWDBCombobox=Combobox'
      'TWWDBLookupCombo=Combobox'
      'TWWDBCombobox=Combobox'
      'TWWKeyCombo=Combobox'
      'TWWTempKeyCombo=combobox'
      'TWWDBDateTimePicker=Combobox'
      'TWWRADIOGROUP=radiogroup'
      'TWWDBEDIT=Edit'
      'TcxButton=bitbtn'
      'TcxDBCheckBox=checkbox'
      'TcxDBRadioGroup=radiogroup'
      'TcxRadioGroup=radiogroup'
      'TcxCheckBox=checkbox'
      'TOVCPICTUREFIELD=Edit'
      'TOVCDBPICTUREFIELD=Edit'
      'TOVCSLIDEREDIT=Edit'
      'TOVCDBSLIDEREDIT=Edit'
      'TOVCSIMPLEFIELD=Edit'
      'TOVCDBSIMPLEFIELD=Edit'
      'TO32DBFLEXEDIT=Edit'
      'TOVCNUMERICFIELD=Edit'
      'TOVCDBNUMERICFIELD=Edit')
    SkinFile = '.\skins\LexMaximus.skn'
    SkinStore = '(none)'
    SkinFormtype = sfMainform
    Version = '2.74.12.06'
    MenuUpdate = True
    MenuMerge = False
    Left = 312
    Top = 408
    SkinStream = {00000000}
  end
end
