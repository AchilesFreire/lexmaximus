unit Ativacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Htmlview, ControleLicenca,  ShellApi, Message,
  inifiles, GifImage, Buttons, ClipBrd, CompressaoDados, Configuracoes, StrUtils, MAPI;

type
  TFrmAtivacao = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    TxtChave1: TEdit;
    TxtChave2: TEdit;
    TxtChave3: TEdit;
    TxtChave4: TEdit;
    TxtSenha1: TEdit;
    TxtSenha2: TEdit;
    TxtSenha3: TEdit;
    TxtSenha4: TEdit;
    Label3: TLabel;
    LblLinkEmail: TLabel;
    Label5: TLabel;
    LblEmail: TLabel;
    LblTelefone1: TLabel;
    LblTelefone2: TLabel;
    BtnOk: TButton;
    BtnCancelar: TButton;
    Label8: TLabel;
    LblLink: TLabel;
    LBlResta: TLabel;
    LblQuantidadeExecucoes: TLabel;
    LblExecucoes: TLabel;
    TxtSenha5: TEdit;
    LblVersaoSistema: TLabel;
    Label11: TLabel;
    TxtChave5: TEdit;
    LblDescricaoUso: TLabel;
    BtnCopiarChave: TButton;
    BtnColarSenha: TButton;
    LblAdvertencia: TLabel;
    Image1: TImage;
    procedure LblLinkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnColarSenhaClick(Sender: TObject);
    procedure BtnCopiarChaveClick(Sender: TObject);
    procedure LblLinkEmailClick(Sender: TObject);
    procedure TxtSenha5Change(Sender: TObject);
    procedure TxtSenha4Change(Sender: TObject);
    procedure TxtSenha3Change(Sender: TObject);
    procedure TxtSenha2Change(Sender: TObject);
    procedure TxtSenha1Change(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);

  private
    { Private declarations }
    varSistemaValidado                : Boolean;
    varControleLicenca                : TControleLicenca;
    varSerialCliente                  : string;
    varDiretorioDocumentos            : string;
    varConfiguracoes                  : TConfiguracoes;

    procedure CarregaTextos();

  public
    { Public declarations }
    property SistemaValidado: Boolean read varSistemaValidado write varSistemaValidado;
    property ControleLicenca: TControleLicenca read varControleLicenca write varControleLicenca;
    property SerialCliente: string read varSerialCliente write varSerialCliente;

    property DiretorioDocumentos: string read varDiretorioDocumentos write varDiretorioDocumentos;
    property Configuracoes: TConfiguracoes read varConfiguracoes write varConfiguracoes;

    procedure ConfiguraJanela();
    function GeraSerialCliente() : Boolean;
    procedure Mensagem( Mensagem : String ; Titulo : String);
    function EnviaEMailMAPI(const Subject, Body, FileName, SenderName, SenderEMail, RecepientName, RecepientEMail: String) : Integer;

  end;

var
  FrmAtivacao: TFrmAtivacao;
  DescricaoUso  : string;
  EnderecoEmail : string;
  Telefone1     : string;
  Telefone2     : string;
  Advertencia   : string;
  Link          : string;

implementation

{$R *.dfm}
procedure TFrmAtivacao.TxtSenha1Change(Sender: TObject);
begin

  if length(TxtSenha1.Text) = 4 then
    TxtSenha2.SetFocus;
end;

procedure TFrmAtivacao.TxtSenha2Change(Sender: TObject);
begin

  if length(TxtSenha2.Text) = 4 then
    TxtSenha3.SetFocus;

end;

procedure TFrmAtivacao.TxtSenha3Change(Sender: TObject);
begin

  if length(TxtSenha3.Text) = 4 then
    TxtSenha4.SetFocus;
end;

procedure TFrmAtivacao.TxtSenha4Change(Sender: TObject);
begin

  if length(TxtSenha4.Text) = 4 then
    TxtSenha5.SetFocus;

end;

procedure TFrmAtivacao.TxtSenha5Change(Sender: TObject);
begin

  if length(TxtSenha5.Text) = 4 then
    BtnOk.SetFocus;

end;

procedure TFrmAtivacao.CarregaTextos();
    // Esta procedure configura os campos:
    //  LblEmail
    //   LblTelefone1
    //   LblTelefone2

var

  Quebra    : string;

begin

  try

    Panel1.Color := Configuracoes.CorFundo;

    DescricaoUso   := Configuracoes.Ativacao_DescricaoUso;
    EnderecoEmail  := Configuracoes.Ativacao_EnderecoEmail;
    Telefone1      := Configuracoes.Ativacao_Telefone1;
    Telefone2      := Configuracoes.Ativacao_Telefone2;
    Advertencia    := Configuracoes.Ativacao_Advertencia;
    Link           := Configuracoes.Ativacao_WebSite;

    Quebra := chr(13) + chr(10);

    if Advertencia <> '' then
      begin
        Advertencia := StringReplace(Advertencia , '$13' , Quebra , [rfReplaceAll, rfIgnoreCase]);
      end;

    if DescricaoUso = '' then
      begin
        DescricaoUso := '';
        DescricaoUso := DescricaoUso + 'Antes de ser colocada a senha a enciclopédia pode ser utilizada por três' + Quebra;
        DescricaoUso := DescricaoUso + 'vezes, bastando, para isto, clicar em "OK" ou "Cancelar" para iniciar seu uso.' + Quebra;
        DescricaoUso := DescricaoUso + '' + Quebra;
        DescricaoUso := DescricaoUso + 'Se a Enciclopédia foi paga clique no link de email e nos' + Quebra;
        DescricaoUso := DescricaoUso + 'envie o nome de quem pagou bem como a chave abaixo e lhe' + Quebra;
        DescricaoUso := DescricaoUso + 'retornaremos a senha.' + Quebra;
        DescricaoUso := DescricaoUso + '' + Quebra;
        DescricaoUso := DescricaoUso + 'A senha de um computador não serve para outro.' + Quebra;
        DescricaoUso := DescricaoUso + '' + Quebra;
        DescricaoUso := DescricaoUso + 'Caso não tenha pago, preencha os campos que aparecerão no email e' + Quebra;
        DescricaoUso := DescricaoUso + 'lhe enviaremos boleto para pagamento.'

      end
    else
      begin
        DescricaoUso := StringReplace(DescricaoUso , '$13' , Quebra , [rfReplaceAll, rfIgnoreCase]);
      end;

    if EnderecoEmail = '' then
      EnderecoEmail := 'elfez@elfez.com.br';

    if Telefone1 = '' then
      Telefone1 := '(0xx21) 3816-2560';

    //if Telefone2 = '' then
    //  Telefone2 := '(0xx21) 3548-6213';

    // Esta procedure configura os campos:


    if Advertencia = '' then
      begin
        LblDescricaoUso.Top := 66;
        LblAdvertencia.Visible := false;
      end
    else
      begin
        LblDescricaoUso.Top := 10;
        LblAdvertencia.Visible := True;
      end;

    
    LblAdvertencia.Caption := Advertencia;
    LblDescricaoUso.Caption := DescricaoUso;
    LblEmail.Caption        := EnderecoEmail;
    LblTelefone1.Caption    := Telefone1;
    LblTelefone2.Caption    := Telefone2;
    LblLink.Caption         := Link;

  finally
  end;



end;

procedure TFrmAtivacao.ConfiguraJanela();

var
  ID          : string;
  quantidade  : integer;
  v1          : string;
  v2          : string;

begin

  if varControleLicenca <> nil then
    begin

      ID := varControleLicenca.IdentificacaoComputador;

      (****************************************************
      //Adicionando o numero da versao no inicio e no fom da identificacao, para tornar menos visível
      v1 := Copy( varControleLicenca.CodigoVersaoSistema,0,2);
      v2 := Copy( varControleLicenca.CodigoVersaoSistema,3,2);

      ID := V1 + ID + V2;
      ****************************************************)

      txtChave1.Text := Copy (ID , 1, 4);
      txtChave2.Text := Copy (ID , 5, 4);
      txtChave3.Text := Copy (ID , 9, 4);
      txtChave4.Text := Copy (ID , 13, 4);
      txtChave5.Text := Copy (ID , 17, 4);

      ////////TxtChave5.Text := varControleLicenca.CodigoVersaoSistema;


      LblVersaoSistema.Caption := v1 + '.' + v2;

      quantidade := 3 - varControleLicenca.QuantidadeUtilizacoes ;
      if quantidade = 1 then
        begin
          LBlResta.Caption := 'Resta';
          LblQuantidadeExecucoes.Caption := IntToStr(quantidade) ;
          LblExecucoes.Caption := 'Execução';
        end
      else
        begin
          if quantidade = 0 then
            begin
              LBlResta.Caption := 'O período de testes deste sistema ja acabou';
              LBlResta.Font.Color := clRed;
              LblQuantidadeExecucoes.Caption := '' ;
              LblExecucoes.Caption := '';
            end
          else
            begin
              LBlResta.Caption := 'Restam';
              LblQuantidadeExecucoes.Caption := IntToStr(quantidade) ;
              LblExecucoes.Caption := 'Execuções';
            end;
        end;

    end;

end;

procedure TFrmAtivacao.BtnOkClick(Sender: TObject);
begin

    If GeraSerialCliente() Then
      begin
        varSistemaValidado := True;
        Mensagem( 'Senha liberada com sucesso.' + chr(13) + ' Este programa já está liberado para uso.' + chr(13) + 'Obrigado por sua aquisição!', 'Ativação');
      end
    else
        varSistemaValidado := False;

    self.close;

end;

procedure TFrmAtivacao.BtnCancelarClick(Sender: TObject);
begin

  varSistemaValidado := false;
  self.close;

end;

function TFrmAtivacao.GeraSerialCliente() : Boolean;

var
id : String;
i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_H, i_I, i_J : String;
s_A, s_B, s_C, s_D, s_E, s_F, s_G, s_H, s_I, s_J : String;
d_1, d_2, m_1, m_2, y_1, y_2, h_1, h_2, n_1, n_2 : String;

DataHora : String;
Serial : String;
CodigoErro : String;

begin

  id := txtChave1.Text + txtChave2.Text + txtChave3.Text + txtChave4.Text + txtChave5.Text;
  Serial := txtSenha1.Text + txtSenha2.Text + txtSenha3.Text + txtSenha4.Text + TxtSenha5.Text;

  If Length(id) <> 20 Then
	  begin
      Mensagem( 'O Serial informado esta incompleto.', 'Ativação');
      GeraSerialCliente := False;
      Exit;
	  end;

  id := id + varControleLicenca.CodigoVersaoSistema;

  id := UpperCase(id);
  Serial := UpperCase(Serial);

  If Length(Serial) <> 20 Then
    begin
      Mensagem( 'A Senha informada esta incompleta.', 'Ativação');
      GeraSerialCliente := False;
      Exit;
    end;

  //Obtendo dados do Id
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

  // Obtendo os dados do serial
  s_A := Copy(Serial, 4, 1);
  s_B := Copy(Serial, 7, 1);
  s_C := Copy(Serial, 19, 1);
  s_D := Copy(Serial, 11, 1);
  s_E := Copy(Serial, 16, 1);

  s_F := Copy(Serial, 13, 1);
  s_G := Copy(Serial, 1, 1);
  s_H := Copy(Serial, 9, 1);
  s_I := Copy(Serial, 3, 1);
  s_J := Copy(Serial, 18, 1);

  //Obtendo dados da data solicitação
  d_1 := Copy(Serial, 2, 1);
  d_2 := Copy(Serial, 15, 1);

  m_1 := Copy(Serial, 8, 1);
  m_2 := Copy(Serial, 10, 1);

  y_1 := Copy(Serial, 17, 1);
  y_2 := Copy(Serial, 5, 1);

  h_1 := '1';
  h_2 := '2';

  n_1 := '0';
  n_2 := '0';

  //Obtendo dados do serial

  DataHora := d_1 + d_2 + '/' + m_1 + m_2 + '/' + y_1 + y_2 + ' ' + h_1 + h_2 + ':' + n_1 + n_2 ;

  CodigoErro := '';

    //If Not IsDate(DataHora) Then
    //    CodigoErro := '0001';

    //caracteres da senha que devem conhecidir com o ID
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
        

    
    If s_A <> i_A Then
        CodigoErro := '0417';

    
    If s_B <> i_B Then
        CodigoErro := '0719';

        
    If s_C <> i_C Then
        CodigoErro := '1912';

        
    If s_D <> i_D Then
        CodigoErro := '1104';

        
    If s_E <> i_E Then
        CodigoErro := '1615';

               
    If s_F <> i_F Then
        CodigoErro := '1307';

        
    If s_G <> i_G Then
        CodigoErro := '0110';

        
    If s_H <> i_H Then
        CodigoErro := '0918';

        
    If s_I <> i_I Then
        CodigoErro := '09302';

        
    If s_J <> i_J Then
        CodigoErro := '1809';

    If CodigoErro = '' Then
	    begin
        GeraSerialCliente := True;
        varSerialCliente := Serial;
    	end

    Else
  	  begin
        Mensagem( 'A Senha informada esta incorreta, Codigo do erro:' + CodigoErro, 'Ativação');
        GeraSerialCliente := False;

	      varSerialCliente := '';
    	end;



End;

procedure TFrmAtivacao.Mensagem( Mensagem : String ; Titulo : String);

var frm : TFrmMessage;

begin
  try

    frm := TFrmMessage.Create( self );

    frm.Configuracoes := Self.Configuracoes;

    frm.MensagemInformacao( Mensagem, Titulo);

    frm.Free;
  finally


    
  end;
end;

procedure TFrmAtivacao.LblLinkEmailClick(Sender: TObject);

Var
  OldCurDir         : string;
  ChaveValidacao    : string;
  Assunto           : String;
  CorpoMensagem     : String;
  //DadosMensagem     : String;
  Quebra            : String;

  Texto             : TStringList;

begin

  try

(*
Assunto : Solicitação de senha - Enciclopédia Soibelman - Versão 04.00
Mensagem:
Venho solicitar o fornecimento de senha para a versão 04.00 da
enciclopédia Soibelman para a seguinte chave:

Os meus dados são:

Número de chave de validação:
Nome:
e-mail:
CPF/CNPJ:
Endereço:
Bairro:
Cidade:
Estado:
CEP
Telefone:
Inscrição estadual  (se pessoa jurídica):
Inscrição municipal (se pessoa jurídica):
*)

  if lblemail.Caption = '' then
    begin
      exit;
    end;

    Texto             := TStringList.create;
    Texto.Add('');
    Texto.Add('');


    ChaveValidacao := TxtChave1.Text + ' ' + TxtChave2.Text + ' ' + TxtChave3.Text + ' ' + TxtChave4.Text + ' ' + TxtChave5.Text;

    Assunto := 'Solicitação de senha - Enciclopédia Soibelman - Versão ' + LblVersaoSistema.caption;

    Quebra :=  chr(10) + chr(13) ;

    CorpoMensagem     := Quebra ;
    CorpoMensagem :=  CorpoMensagem + 'Venho solicitar o fornecimento de senha para a versão 04.00 da enciclopédia Soibelman'+ Quebra;
    CorpoMensagem :=  CorpoMensagem +  Quebra;
    CorpoMensagem :=  CorpoMensagem + 'Os meus dados são:' + Quebra;;
    CorpoMensagem :=  CorpoMensagem +  Quebra;;
    CorpoMensagem :=  CorpoMensagem + 'Número de chave de validação:' + ReplaceText( ChaveValidacao, ' ', '') + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'Nome:' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'e-mail:' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'CPF/CNPJ:' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'Endereço:' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'Bairro:' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'Cidade:' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'Estado:' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'CEP:' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'Telefone:' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'Inscrição estadual  (se pessoa jurídica):' + Quebra;
    CorpoMensagem :=  CorpoMensagem + 'Inscrição municipal (se pessoa jurídica):' + Quebra;

    (*
    DadosMensagem:='mailto:' + EnderecoEmail +
      '?subject=' + Assunto +
      '&body='+ CorpoMensagem;

    if (ShellExecute(0, 'open', PChar(DadosMensagem), '', '', SW_SHOWNORMAL)<=32 ) then
      Mensagem('Falha ao enviar a mensagem','Ativação');
    *)

    OldCurDir := GetCurrentDir;

    if EnviaEMailMAPI( Assunto, CorpoMensagem,  '', '','',  '' , lblemail.Caption ) <> 0 then
      mensagem('Mensagem não foi enviada', 'Ativação');

    SetCurrentDir( OldCurDir );


  finally

  end;
end;

procedure TFrmAtivacao.BtnCopiarChaveClick(Sender: TObject);

begin
  try
    ClipBoard.AsText := TxtChave1.Text + TxtChave2.Text + TxtChave3.Text + TxtChave4.Text + TxtChave5.Text;

  finally
  end;
end;

procedure TFrmAtivacao.BtnColarSenhaClick(Sender: TObject);

var
  senha : string;

begin
  try
    senha := ClipBoard.AsText;
    senha:= ReplaceText( senha, ' ', '');

    TxtSenha1.Text := Copy(senha, 1, 4);
    TxtSenha2.Text := Copy(senha, 5, 4);
    TxtSenha3.Text := Copy(senha, 9, 4);
    TxtSenha4.Text := Copy(senha, 13, 4);
    TxtSenha5.Text := Copy(senha, 17, 4);

  finally
  end;
end;

procedure TFrmAtivacao.FormShow(Sender: TObject);
begin

  CarregaTextos;

  ConfiguraJanela();

end;

function TFrmAtivacao.EnviaEMailMAPI(const Subject, Body, FileName, SenderName, SenderEMail, RecepientName, RecepientEMail: String) : Integer;
var
  message: TMapiMessage;
  lpSender,
  lpRecepient: TMapiRecipDesc;
  FileAttach: TMapiFileDesc;
  SM: TFNMapiSendMail;
  MAPIModule: HModule;
begin
  FillChar(message, SizeOf(message), 0);
  with message do
  begin
    if (Subject<>'') then
    begin
      lpszSubject := PChar(Subject)
    end;
    if (Body<>'') then
    begin
      lpszNoteText := PChar(Body)
    end;
    if (SenderEMail<>'') then
    begin
      lpSender.ulRecipClass := MAPI_ORIG;
      if (SenderName='') then
      begin
        lpSender.lpszName := PChar(SenderEMail)
      end
      else
      begin
        lpSender.lpszName := PChar(SenderName)
      end;
      lpSender.lpszAddress := PChar('SMTP:'+SenderEMail);
      lpSender.ulReserved := 0;
      lpSender.ulEIDSize := 0;
      lpSender.lpEntryID := nil;
      lpOriginator := @lpSender;
    end;
    if (RecepientEMail<>'') then
      begin
        lpRecepient.ulRecipClass := MAPI_TO;
        if (RecepientName='') then
          begin
            lpRecepient.lpszName := PChar(RecepientEMail)
          end
        else
          begin
            lpRecepient.lpszName := PChar(RecepientName)
          end;
        lpRecepient.lpszAddress := PChar('SMTP:'+RecepientEMail);
        lpRecepient.ulReserved := 0;
        lpRecepient.ulEIDSize := 0;
        lpRecepient.lpEntryID := nil;
        nRecipCount := 1;
        lpRecips := @lpRecepient;
      end
    else
      begin
        lpRecips := nil
      end;
    if (FileName='') then
      begin
        nFileCount := 0;
        lpFiles := nil;
      end
    else
      begin
        FillChar(FileAttach, SizeOf(FileAttach), 0);
        FileAttach.nPosition := Cardinal($FFFFFFFF);
        FileAttach.lpszPathName := PChar(FileName);
        nFileCount := 1;
        lpFiles := @FileAttach;
      end;
  end;
  MAPIModule := LoadLibrary(PChar(MAPIDLL));
  if MAPIModule=0 then
    begin
      Result := -1
    end
  else
    begin
      try
        @SM := GetProcAddress(MAPIModule, 'MAPISendMail');
        if @SM<>nil then
          begin
            Result := SM(0, Application.Handle, message, MAPI_DIALOG or MAPI_LOGON_UI, 0);
          end
        else
          begin
            Result := 1
          end;
      finally
        FreeLibrary(MAPIModule);
      end;
    end;

  (*
  if Result<>0 then
  begin
    MessageDlg('Error sending mail ('+IntToStr(Result)+').', mtError, [mbOk], 0)
  end;
  *)
  
end;

procedure TFrmAtivacao.LblLinkClick(Sender: TObject);

begin
  try

    if LblLink.caption <> '' then
      ShellExecute ( Self.Handle, 'open', PAnsiChar( LblLink.caption), '', nil, SW_SHOW) ;

  except
    on ex : exception  do
      begin
        Mensagem( ex.Message, 'Soibelman');
      end;


  end;

end;

end.
