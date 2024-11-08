unit EditorConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, WinSkinStore, WinSkinData,
  inifiles, CompressaoDados, Configuracoes;

type
  TFrmConfiguracoes = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    DlgFonte: TFontDialog;
    BtnCancelar: TButton;
    BtnSalvar: TButton;
    lblConfiguracoesFonteVerbete: TLabel;
    BtnPadrao: TButton;
    GroupBox2: TGroupBox;
    CboSkin: TComboBox;
    LblCorFundo: TLabel;
    DlgCor: TColorDialog;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    chkConectarInternet: TCheckBox;
    Chk_ExibirDicaBotoes: TCheckBox;
    Chk_UsarApenasUmClique: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure LblCorFundoClick(Sender: TObject);
    procedure BtnPadraoClick(Sender: TObject);

    procedure LblLinkMouseEnter(Sender: TObject);
    procedure LblLinkLeave(Sender: TObject);
    procedure lblConfiguracoesFonteListaVerbeteClick(Sender: TObject);
    procedure lblConfiguracoesFonteVerbeteClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    Procedure CarregaConfiguracoes();
    Procedure SalvaConfiguracoes();
    Procedure CarregaSkins();
    procedure CboSkinClick(Sender: TObject);
    Procedure EditaConfiguracoes( sk : TSkinData );
    Procedure CarregaConfiguracoesPadrao();

  private
    { Private declarations }
    varConfiguracoes                  : TConfiguracoes;

  public
    { Public declarations }
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;

  end;

var
  FrmConfiguracoes: TFrmConfiguracoes;
  CorFundo          : TColor;
  CorLinkNormal     : TColor;
  CorLinkAtivado    : TColor;
  SkinData          : TSkinData;

  FonteLista        : TFont;
  //FonteVerbete      : TFont;

  SkinSelecionado   : String;


const
  CorTituloVerbeteComFoco : TColor = $000080;
  CorTituloVerbeteSemFoco : TColor = $808080;
  CorPadraoTexto          : TColor = clPurple;

implementation

{$R *.dfm}
procedure TFrmConfiguracoes.LblLinkMouseEnter(Sender: TObject);

begin
    try
      TLabel(Sender).Font.Color := CorLinkAtivado;
    finally

    end;
end;

procedure TFrmConfiguracoes.lblConfiguracoesFonteListaVerbeteClick(Sender: TObject);
begin
  try

    Dlgfonte.Font := FonteLista;
    Dlgfonte.Execute(self.Handle);
    FonteLista := Dlgfonte.Font;

  finally

  end;
end;

procedure TFrmConfiguracoes.lblConfiguracoesFonteVerbeteClick(Sender: TObject);
begin
  try
    (******************************
    Dlgfonte.Font := FonteVerbete;
    Dlgfonte.Execute(self.Handle);
    FonteVerbete := Dlgfonte.Font;
    ******************************)

  finally

  end;
end;

procedure TFrmConfiguracoes.LblLinkLeave(Sender: TObject);
begin
    try
      TLabel(Sender).Font.Color := CorLinkNormal;
    finally

    end;
end;

procedure TFrmConfiguracoes.BtnCancelarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFrmConfiguracoes.BtnSalvarClick(Sender: TObject);
begin

  SalvaConfiguracoes;

  self.Close;

end;

Procedure TFrmConfiguracoes.EditaConfiguracoes( sk : TSkinData );
begin
  try
      SkinData := sk;

      CarregaConfiguracoes;

  finally

  end;
end;

Procedure TFrmConfiguracoes.CarregaConfiguracoesPadrao();
begin

        FonteLista := TFont.Create;
        FonteLista.Name := 'MS Sans Serif';
        FonteLista.Size := 10;
        FonteLista.Color := clBlack;
        FonteLista.Style := [];

        (************************************
        FonteVerbete := TFont.Create;
        FonteVerbete.Name := 'MS Sans Serif';
        FonteVerbete.Size := 10;
        FonteVerbete.Color := clBlack;
        FonteVerbete.Style := [];
        ************************************)

        CboSkin.Text := 'mxskin24.skn';

        CorFundo := 8404992;

        chkConectarInternet.Checked := True;
        Chk_ExibirDicaBotoes.Checked := True;
        Chk_UsarApenasUmClique.Checked := True;


end;

Procedure TFrmConfiguracoes.CarregaConfiguracoes();
begin
  try
    //Carregando defaults
    if varConfiguracoes = nil then
      begin
        CarregaConfiguracoesPadrao();
      end
    else
      begin
        FonteLista := TFont.Create;
        if varConfiguracoes.FonteLista <> nil then
          begin
            FonteLista.Name     := varConfiguracoes.FonteLista.Name;
            FonteLista.Size     := varConfiguracoes.FonteLista.Size;
            FonteLista.Color    := varConfiguracoes.FonteLista.Color;
            FonteLista.Style    := varConfiguracoes.FonteLista.Style;
          end;

        (******************************************
        FonteVerbete := TFont.Create;
        if varConfiguracoes.varFonteLista <> nil then
          begin
            FonteVerbete.Name   := varConfiguracoes.FonteVerbete.Name ;
            FonteVerbete.Size   := varConfiguracoes.FonteVerbete.Size ;
            FonteVerbete.Color  := varConfiguracoes.FonteVerbete.Color;
            FonteVerbete.Style  := varConfiguracoes.fonteVerbete.Style;
          end;
        ******************************************)

        CboSkin.Text := varConfiguracoes.ArquivoSkin;

        CorFundo := varConfiguracoes.CorFundo;
        Panel1.Color := CorFundo;

        chkConectarInternet.Checked := varconfiguracoes.ConectarInternet;
        Chk_ExibirDicaBotoes.Checked := varconfiguracoes.ExibirDicaBotoes;
        Chk_UsarApenasUmClique.Checked := varConfiguracoes.UsarApenasUmClique;

      end;

  finally

  end;

end;

Procedure TFrmConfiguracoes.SalvaConfiguracoes();

begin
  try

    if CboSkin.text = '' Then
      varConfiguracoes.ArquivoSkin := 'mxskin24.skn'

    else
      varConfiguracoes.ArquivoSkin := CboSkin.Text ;

    varConfiguracoes.FonteLista := FonteLista;
    varConfiguracoes.CorFundo := CorFundo;
    varConfiguracoes.FonteLista := FonteLista;

    varConfiguracoes.ConectarInternet := chkConectarInternet.Checked;
    varConfiguracoes.ExibirDicaBotoes := Chk_ExibirDicaBotoes.Checked;

    varConfiguracoes.UsarApenasUmClique := Chk_UsarApenasUmClique.Checked;

    varConfiguracoes.SalvaConfiguracoes();

    varConfiguracoes.SalvaConfiguracoesFormulario();
  finally

  end;

end;

Procedure TFrmConfiguracoes.CarregaSkins();
var
  sts: Integer ;
  SR: TSearchRec;
  list: Tstringlist;

  procedure AddFile;
  begin
    list.add(sr.name);
  end;

begin
  list:=Tstringlist.create;
  sts := FindFirst( GetCurrentDir + '\Skins\*.skn' , faAnyFile , SR );
  if sts = 0 then begin
      if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then begin
          if pos('.', SR.Name) <> 0 then
            Addfile;
      end;
      while FindNext( SR ) = 0 do begin
          if ( SR.Name <> '.' ) and ( SR.Name <> '..' ) then begin
              //Put User Feedback here if desired
//              Application.ProcessMessages;
              if Pos('.', SR.Name) <> 0 then  Addfile;
          end;
      end;
  end ;
  FindClose( SR ) ;
  list.sort;
  CboSkin.items.assign(list);
  list.free;
end;

procedure TFrmConfiguracoes.CboSkinClick(Sender: TObject);
begin
  try
      SkinData.skinfile:='.\skins\' + CboSkin.text;

      if not SkinData.active then SkinData.active:=true;

  finally

  end;

end;

procedure TFrmConfiguracoes.BtnPadraoClick(Sender: TObject);
begin

  CarregaConfiguracoesPadrao();
    Panel1.Color := CorFundo;
    Groupbox1.Color := CorFundo;
    Groupbox2.Color := CorFundo;

end;

procedure TFrmConfiguracoes.LblCorFundoClick(Sender: TObject);
begin
  try

    DlgCor.Color := CorFundo;
    DlgCor.Execute(self.Handle);
    CorFundo := DlgCor.Color;

    Panel1.Color := CorFundo;
    Groupbox1.Color := CorFundo;
    Groupbox2.Color := CorFundo;

  finally

  end;
end;

procedure TFrmConfiguracoes.FormShow(Sender: TObject);
begin

  Panel1.Color := Configuracoes.CorFundo;
  Groupbox1.Color := Configuracoes.CorFundo;
  Groupbox2.Color := Configuracoes.CorFundo;

  CorLinkNormal := clSkyBlue;  //TColor($B4CBF4);
  CorLinkAtivado := clYellow;

  CarregaSkins;

end;

end.
