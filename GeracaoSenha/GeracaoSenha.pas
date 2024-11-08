unit GeracaoSenha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WinSkinData, WinSkinStore, ExtCtrls, StdCtrls, ClipBrd, Message, Buttons, ComCtrls;

type
  TFrmGeracaoSenha = class(TForm)
    Panel2: TPanel;
    PgTipoSenha: TPageControl;
    TabSenhaInstalacao: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    txtSerial1: TEdit;
    txtSerial2: TEdit;
    txtSerial3: TEdit;
    txtSerial4: TEdit;
    BtnGerarSenha: TButton;
    txtSenha1: TEdit;
    txtSenha2: TEdit;
    txtSenha3: TEdit;
    txtSenha4: TEdit;
    txtSenha5: TEdit;
    txtSerial5: TEdit;
    TabSenhaAtualizacao: TTabSheet;
    SkinData1: TSkinData;
    BtnFechar: TButton;
    TxtChaveClienteAtualizacao: TEdit;
    TxtcodigoAtualizacao: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    BtnCopiarChave: TButton;
    BtnColarSenha: TButton;
    Label6: TLabel;
    TxtSenhaClienteAtualizacao: TEdit;
    BtnColarChaveClienteAtualizacao: TButton;
    BtnCopiarSenhaAtualizacaoInstalacao: TButton;
    BtnGerarSenhaInstalacao: TButton;
    CboVersao: TComboBox;
    procedure BtnGerarSenhaInstalacaoClick(Sender: TObject);
    procedure BtnCopiarSenhaAtualizacaoInstalacaoClick(Sender: TObject);
    procedure BtnColarChaveClienteAtualizacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCopiarSenhaClick(Sender: TObject);
    procedure BtnColarChaveClick(Sender: TObject);
    procedure txtSenha4Change(Sender: TObject);
    procedure txtSenha3Change(Sender: TObject);
    procedure txtSenha2Change(Sender: TObject);
    procedure txtSenha1Change(Sender: TObject);
    procedure txtSerial4Change(Sender: TObject);
    procedure txtSerial3Change(Sender: TObject);
    procedure txtSerial2Change(Sender: TObject);
    procedure txtSerial1Change(Sender: TObject);
    procedure BtnCopiarClick(Sender: TObject);
    procedure BtnGerarSenhaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure GeraSenhaCliente();
    procedure GeraSenhaAtualizacao();
    procedure Mensagem( Mensagem : String ; Titulo : String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGeracaoSenha: TFrmGeracaoSenha;

implementation

{$R *.dfm}

procedure TFrmGeracaoSenha.BtnFecharClick(Sender: TObject);
begin

  self.Close;

end;

procedure TFrmGeracaoSenha.BtnGerarSenhaClick(Sender: TObject);
begin

  GeraSenhaCliente;

end;

procedure TFrmGeracaoSenha.BtnCopiarClick(Sender: TObject);

var
  Senha : string;

begin

  Senha := TxtSenha1.Text + ' ' + TxtSenha2.Text + ' ' + TxtSenha3.Text + ' ' + TxtSenha4.Text + ' ' + TxtSenha5.Text;

  Clipboard.AsText := Senha;

end;

procedure TFrmGeracaoSenha.txtSerial1Change(Sender: TObject);
begin

  if length(TxtSerial1.Text) = 4 then
    TxtSerial2.SetFocus;

end;

procedure TFrmGeracaoSenha.txtSerial2Change(Sender: TObject);
begin

  if length(TxtSerial2.Text) = 4 then
    TxtSerial3.SetFocus;


end;

procedure TFrmGeracaoSenha.txtSerial3Change(Sender: TObject);
begin

  if length(TxtSerial3.Text) = 4 then
    TxtSerial4.SetFocus;


end;

procedure TFrmGeracaoSenha.txtSerial4Change(Sender: TObject);
begin

  if length(TxtSerial4.Text) = 4 then
    BtnGerarSenha.SetFocus;


end;

procedure TFrmGeracaoSenha.txtSenha1Change(Sender: TObject);
begin

  if length(TxtSenha1.Text) = 4 then
    TxtSenha2.SetFocus;

end;

procedure TFrmGeracaoSenha.txtSenha2Change(Sender: TObject);
begin

  if length(TxtSenha2.Text) = 4 then
    TxtSenha3.SetFocus;


end;

procedure TFrmGeracaoSenha.txtSenha3Change(Sender: TObject);
begin

  if length(TxtSenha3.Text) = 4 then
    TxtSenha4.SetFocus;


end;

procedure TFrmGeracaoSenha.txtSenha4Change(Sender: TObject);
begin

  if length(TxtSenha4.Text) = 4 then
    TxtSenha5.SetFocus;

end;

procedure TFrmGeracaoSenha.BtnColarChaveClick(Sender: TObject);

var
  Chave : string;

begin

  Chave := Clipboard.AsText;
  
  txtSerial1.Text := Copy(Chave ,  1, 4)  ;
  txtSerial2.Text := Copy(Chave ,  5, 4)  ;
  txtSerial3.Text := Copy(Chave ,  9, 4)  ;
  txtSerial4.Text := Copy(Chave , 13, 4)  ;
  txtSerial5.Text := Copy(Chave , 17, 4)  ;

end;

procedure TFrmGeracaoSenha.BtnCopiarSenhaClick(Sender: TObject);
begin

  ClipBoard.AsText := txtSenha1.Text + txtSenha2.Text + txtSenha3.Text + txtSenha4.Text + txtSenha5.Text ;

end;

procedure TFrmGeracaoSenha.FormCreate(Sender: TObject);
begin

  CboVersao.ItemIndex := 1;
  PgTipoSenha.ActivePage := TabSenhaInstalacao;

end;

procedure TFrmGeracaoSenha.BtnColarChaveClienteAtualizacaoClick(Sender: TObject);
begin

  TxtChaveClienteAtualizacao.Text := Clipboard.AsText;

end;

procedure TFrmGeracaoSenha.BtnCopiarSenhaAtualizacaoInstalacaoClick(Sender: TObject);
begin

  Clipboard.AsText := TxtSenhaClienteAtualizacao.Text;

end;

procedure TFrmGeracaoSenha.BtnGerarSenhaInstalacaoClick(Sender: TObject);
begin

  GeraSenhaAtualizacao();


end;

//
// Esta funcao verifica se o serial foi informado, e se ele é valido
// caso seja valido, a licenca sera considerada como full
//
// Serial
// 00000000011111111112
// 12345678901234567890
// G IA  B H D F  E JC
// id
// 21111111111000000000
// 09876543210987654321
//  BHA E  C GJ F  D I
// Para que a licenca seja full os seguintes dados devem conhecidir:
//
//     SN   ID
//     --   --
// A   04   17
// B   07   19
// C   19   12
// D   11   04
// E   16   15

// F   13   07
// G   01   10
// H   09   18
// I   03   02
// J   18   09
//
// Forma de Prenchimento dos demais caracteres do Serial:
//
// 01 --
// 02 D1
// 03 --
// 04 --
// 05 Y2
// 06 H1
// 07 --
// 08 M1
// 09 --
// 10 H2
// 11 --
// 12 N1
// 13 --
// 14 N2
// 15 D2
// 16 --
// 17 Y1
// 18 --
// 19 --
// 20 M2

procedure TFrmGeracaoSenha.GeraSenhaCliente();

var
    id : String;

    i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_H, i_I, i_J : String;
    d_1, d_2, m_1, m_2, y_1, y_2, h_1, h_2, n_1, n_2 : String;

    DataHora : String;
    Senha : String;

    VersaoSistema : String;
begin

    If CboVersao.ItemIndex = -1 Then
    begin

        Mensagem( 'Versão do sistema deve ser selecionada','Geração de senha');
        Exit;
    End;

    VersaoSistema := CboVersao.Items[CboVersao.ItemIndex  ];
    VersaoSistema := StringReplace(VersaoSistema,'.', '',[rfReplaceAll]);


    id := txtSerial1.Text + txtSerial2.Text + txtSerial3.Text + txtSerial4.Text + txtSerial5.Text;

    If Length(id) <> 20 Then
    begin
        Mensagem( 'O Serial informado esta incompleto' , 'Geração de senha');
        Exit;
    End;
    
    id := id + VersaoSistema;

    //DataHora := '1009721200' ;// FormatDateTime('ddmmyyhhnn' , Now);

    DataHora := FormatDateTime('ddmmyyhhnn' , Now);

    i_A := Copy(id, 17, 1);
    i_B := Copy(id, 19, 1);
    i_C := Copy(id, 12, 1);
    i_D := Copy(id, 4, 1);
    i_E := Copy(id, 15, 1);

    i_F := Copy(id, 7, 1);
    i_G := Copy(id, 10, 1);
    i_H := Copy(id, 18, 1);
    i_I := Copy(id, 2, 1);
    i_J := Copy(id, 9, 1);

    d_1 := Copy(DataHora, 1, 1);
    d_2 := Copy(DataHora, 2, 1);
    m_1 := Copy(DataHora, 3, 1);
    m_2 := Copy(DataHora, 4, 1);
    y_1 := Copy(DataHora, 5, 1);
    y_2 := Copy(DataHora, 6, 1);
    h_1 := Copy(DataHora, 7, 1);
    h_2 := Copy(DataHora, 8, 1);
    n_1 := Copy(DataHora, 9, 1);
    n_2 := Copy(DataHora, 10, 1);

    Senha := '';
    Senha := Senha + i_G;             // 01
    Senha := Senha + d_1;             // 02
    Senha := Senha + i_I;             // 03
    Senha := Senha + i_A;             // 04
    Senha := Senha + y_2;             // 05
    Senha := Senha + h_1;             // 06
    Senha := Senha + i_B;             // 07
    Senha := Senha + m_1;             // 08
    Senha := Senha + i_H;             // 09
    Senha := Senha + m_2;             // 10

    Senha := Senha + i_D;             // 11
    Senha := Senha + n_1;             // 12
    Senha := Senha + i_F;             // 13
    Senha := Senha + n_2;             // 14
    Senha := Senha + d_2;             // 15
    Senha := Senha + i_E;             // 16
    Senha := Senha + y_1;             // 17
    Senha := Senha + i_J;             // 18
    Senha := Senha + i_C;             // 19
    Senha := Senha + m_2;             // 20


    Senha := UpperCase(Senha);

    txtSenha1.Text := Copy(Senha, 1, 4);
    txtSenha2.Text := Copy(Senha, 5, 4);
    txtSenha3.Text := Copy(Senha, 9, 4);
    txtSenha4.Text := Copy(Senha, 13, 4);
    txtSenha5.Text := Copy(Senha, 17, 4);

    Clipboard.AsText := Senha;

    mensagem('Senha gerada com sucesso ' + chr(13) +   'e copiada para a área de transferência' , 'Senha de instalação');

end;

procedure TFrmGeracaoSenha.GeraSenhaAtualizacao();

var
    id : String;

    c_A, c_B, c_C, c_D, c_E, c_F, c_G, c_H, c_I, c_J : String;
    d_1, d_2, m_1, m_2, y_1, y_2, h_1, h_2, n_1, n_2 : String;
    a_A, a_B, a_C, a_D, a_E, a_F                     : String;

    Atualizacao : string;
    DataHora  : String;
    Chave     : string;
    Senha     : String;
begin

    Atualizacao := TxtcodigoAtualizacao.Text;

    a_A := Copy(Atualizacao,  1, 1);
    a_B := Copy(Atualizacao,  2, 1);
    a_C := Copy(Atualizacao,  3, 1);
    a_D := Copy(Atualizacao,  4, 1);
    a_E := Copy(Atualizacao,  5, 1);
    a_F := Copy(Atualizacao,  6, 1);

    Chave := TxtChaveClienteAtualizacao.Text;

    c_A := Copy(Chave,  1, 1);
    c_B := Copy(Chave,  2, 1);
    c_C := Copy(Chave,  3, 1);
    c_D := Copy(Chave,  4, 1);
    c_E := Copy(Chave,  5, 1);

    c_F := Copy(Chave,  6, 1);
    c_G := Copy(Chave,  7, 1);
    c_H := Copy(Chave,  8, 1);
    c_I := Copy(Chave,  9, 1);
    c_J := Copy(Chave, 10, 1);

    DataHora := FormatDateTime('ddmmyyhhnn' , Now);

    d_1 := Copy(DataHora, 1, 1);
    d_2 := Copy(DataHora, 2, 1);
    m_1 := Copy(DataHora, 3, 1);
    m_2 := Copy(DataHora, 4, 1);
    y_1 := Copy(DataHora, 5, 1);
    y_2 := Copy(DataHora, 6, 1);
    h_1 := Copy(DataHora, 7, 1);
    h_2 := Copy(DataHora, 8, 1);
    n_1 := Copy(DataHora, 9, 1);
    n_2 := Copy(DataHora, 10, 1);

    //MUDAR TUDO
    Senha := '';
    Senha := Senha + c_a;             // 01
    Senha := Senha + d_1;             // 02
    Senha := Senha + c_f;             // 03
    Senha := Senha + c_f;             // 04

    Senha := Senha + c_b;             // 05
    Senha := Senha + d_2;             // 06
    Senha := Senha + c_g;             // 07
    Senha := Senha + a_d;             // 08

    Senha := Senha + c_c;             // 09
    Senha := Senha + m_1;             // 10
    Senha := Senha + c_h;             // 11
    Senha := Senha + a_c;             // 12

    Senha := Senha + c_d;             // 13
    Senha := Senha + m_2;             // 14
    Senha := Senha + c_i;             // 15
    Senha := Senha + a_B;             // 16

    Senha := Senha + c_e;             // 17
    Senha := Senha + y_2;             // 18
    Senha := Senha + c_j;             // 19
    Senha := Senha + a_a;             // 20

    Senha := UpperCase(Senha);

    TxtSenhaClienteAtualizacao.Text := Senha;
    
    Clipboard.AsText := Senha;

    mensagem('Senha gerada com sucesso ' + chr(13)  + ' e copiada para a área de transferência' , 'Senha de atualização');

end;

procedure TFrmGeracaoSenha.Mensagem( Mensagem : String ; Titulo : String);

var frm : TFrmMessage;

begin
  try

    frm := TFrmMessage.Create( self );

    frm.MensagemInformacao( Mensagem, Titulo);

  finally

    frm.Free;

  end;
end;

end.
