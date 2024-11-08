unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, ShellAPI, StrUtils;

type
  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    LblEtapa1: TLabel;
    LblEtapa2: TLabel;
    Label2: TLabel;
    LblArquivoAndamento: TLabel;
    LblMensagem: TLabel;
    Label3: TLabel;
    Animate1: TAnimate;
    LblEtapa3: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ProcessamentoIniciado : boolean;
    //ProcessamentoCancelado : Boolean;

    DiretorioOrigem       : String;
    DiretorioDestino      : String;
    ParametroInstalacao   : String;
    LogInstalacao         : TStringList;

    ListaArquivosInstalados         : TStringList;
    ListaDiretoriosCriados         : TStringList;

    InstalacaoDesinstalacao : Boolean;

    procedure DetectaDiretoriosInstalacao();
    procedure PreparaProcessamento();
    procedure IniciaProcessamento();
    procedure IniciaDesinstalacao();
    procedure CopiaConteudoPastaDados();

    procedure CopiaConteudoPastaDiversos();
    procedure CopiaConteudoPastaBrowser();

    Function ComprimePasta ( Handle :Cardinal;  Pasta : String ; ArquivoZIP : String) : Boolean;
    Function DescomprimePasta ( Handle :Cardinal;  Pasta : String ; ArquivoZIP : String) : Boolean;

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  canClose := (not ( ProcessamentoIniciado ) );
end;

procedure TFrmPrincipal.PreparaProcessamento();
begin
  if ParamCount >=1 then
    begin
      if (ParamStr(1) = 'Soibelman') OR (ParamStr(1) = 'LexMaximus')  then
        begin
          if ParamStr(1) = 'Soibelman' then
            ParametroInstalacao := 'Enciclopedia Soibelman';

          if ParamStr(1) = 'LexMaximus' then
            ParametroInstalacao := 'LexMaximus';


          if PAramCount = 1 then
            begin
              InstalacaoDesinstalacao := True;
            end
          else
            begin
              if ParamStr(2) = '/Install' then
                InstalacaoDesinstalacao := True;

              if ParamStr(2) = '/Uninstall' then
                InstalacaoDesinstalacao := False;
            end;

          LogInstalacao  := TStringList.Create;

          DetectaDiretoriosInstalacao();

          if InstalacaoDesinstalacao then
            IniciaProcessamento()
          else
            begin
              Label3.Caption:= 'Aguarde enquanto os arquivos são desinstalados';

              IniciaDesinstalacao();
            end;

          //////////////LogInstalacao.SaveToFile( DiretorioDestino + 'LogInstalacaoBase.txt' );
        end
      else
        LblMensagem.Caption := 'Parametro inválido: ' + ParamStr(1);
    end
  else
    LblMensagem.Caption := 'Número de parametros inválido';

end;

procedure TFrmPrincipal.IniciaProcessamento();
begin

  try
    ProcessamentoIniciado := True;

    ListaArquivosInstalados := TStringList.Create();
    ListaDiretoriosCriados := TStringList.Create();

    if FileExists( GetCurrentDir + '\AnimacaoCopia.avi') then
      begin
        Animate1.Active := False;
        Animate1.FileName := GetCurrentDir + '\AnimacaoCopia.avi';
        Animate1.Active := True;
        Application.ProcessMessages;
      end;

    Application.ProcessMessages;

    if ParametroInstalacao = 'Enciclopédia Soibelman' then
      LblMensagem.Caption := 'Instalando base de Legislação da Enciclopédia';

    if ParametroInstalacao = 'LexMaximus' then
      LblMensagem.Caption := 'Instalando base de Legislação do Lexmaximus';

    LblEtapa1.Font.Style := [fsbold];
    Application.ProcessMessages;
    CopiaConteudoPastaDados();

    Application.ProcessMessages;

    LblEtapa2.Font.Style := [fsbold];
    Application.ProcessMessages;
    CopiaConteudoPastaDiversos();

    Application.ProcessMessages;

    LblEtapa3.Font.Style := [fsbold];
    Application.ProcessMessages;
    CopiaConteudoPastaBrowser();

    Application.ProcessMessages;

    ListaArquivosInstalados.SaveToFile( DiretorioDestino+  '\ListaArquivosInstalados.txt');
    ListaDiretoriosCriados.SaveToFile( DiretorioDestino+  '\ListaDiretoriosCriados.txt');

  except


  end;

end;

procedure TFrmPrincipal.IniciaDesinstalacao();
var
  I : Integer;
  Q : Integer;
  Linha : String;
  Conteudo1: TStringList;
  Conteudo2: TStringList;

begin

  LblEtapa1.Caption := 'Desinstalando os Arquivos';
  LblEtapa2.Caption := '';
  LblEtapa3.Caption := '';
  Application.ProcessMessages;

  if FileExists(DiretorioDestino+  '\ListaArquivosInstalados.txt') then
    begin
      Conteudo1:= TStringList.Create;
      Conteudo1.LoadFromFile(DiretorioDestino+  '\ListaArquivosInstalados.txt');
      Q := Conteudo1.Count-1;
      for I := 0 to Q do
        begin
          Linha := trim(Conteudo1[i]);
          if FileExists(Linha) then
            begin
              try
                DeleteFile(Linha);
              except

              end;
            end;
          Application.ProcessMessages;
        end;
      FreeAndNil(Conteudo1);
      DeleteFile(DiretorioDestino+  '\ListaArquivosInstalados.txt');
    end;

  if FileExists(DiretorioDestino+  '\ListaDiretoriosCriados.txt') then
    begin
      Conteudo2:= TStringList.Create;
      Conteudo2.LoadFromFile(DiretorioDestino+  '\ListaDiretoriosCriados.txt');
      Q := Conteudo2.Count-1;
      for I := 0 to Q do
        begin
          Linha := trim(Conteudo2[i]);
          if DirectoryExists(Linha) then
            begin
              try
                RmDir(Linha);
              except

              end;
            end;
          Application.ProcessMessages;
        end;
      DeleteFile(DiretorioDestino+  '\ListaDiretoriosCriados.txt');
    end;

  LblEtapa1.Font.Style := [fsbold];
  Application.ProcessMessages;


end;

procedure TFrmPrincipal.DetectaDiretoriosInstalacao();
var
  path32 : String;
  path64 : String;
begin

  DiretorioOrigem := ExtractFilePath( Application.ExeName);

  // se o sistema operacional suportar esta pasta, deve-se instalar nela
  path64 := GetEnvironmentVariable('ProgramFiles(x86)');

  path32 := GetEnvironmentVariable('ProgramFiles');

  if path64 = ''  then
    DiretorioDestino := path32
  else
    DiretorioDestino := path64;

  DiretorioDestino := DiretorioDestino + '\' + ParametroInstalacao + '\';

  LogInstalacao.Add('Diretorio de Origem:' + DiretorioOrigem);
  LogInstalacao.Add('Diretorio de Destino:' + DiretorioDestino);

end;

procedure TFrmPrincipal.CopiaConteudoPastaDados();
var
  ArquivoOrigem : String;
  ArquivoDestino : String;
  MySearch: TSearchRec;
  NomeArquivo : String;
  ListaArquivos : TStringList;
  I : Integer;
  Q : Integer;
  Extensao : String;

begin

    ListaArquivos := TStringList.Create;

    if not DirectoryExists(DiretorioDestino + 'Dados') then
      begin
        mkdir (DiretorioDestino + 'Dados');
        LogInstalacao.Add('Criando a pasta ' + DiretorioDestino + 'Dados');
        ListaDiretoriosCriados.Add(DiretorioDestino + 'Dados');
      end;

    FindFirst(DiretorioOrigem + 'Dados\*.*' , faAnyFile, MySearch);
    ArquivoOrigem := MySearch.Name;

    if ( ArquivoOrigem <> '') and (ArquivoOrigem <> '.') and ( ArquivoOrigem <> '..') then
      ListaArquivos.Add(ArquivoOrigem);

    while FindNext(MySearch)=0 do
      begin
        ArquivoOrigem := MySearch.Name;
        if ( ArquivoOrigem <> '') and (ArquivoOrigem <> '.') and ( ArquivoOrigem <> '..') then
          ListaArquivos.Add(ArquivoOrigem);
      end;
    FindClose(MySearch);

    Q := ListaArquivos.Count-1;
    for I := 0 to Q do
      begin
          NomeArquivo := ListaArquivos[i];

          LblArquivoAndamento.Caption := AnsiLowerCase(NomeArquivo);
          Application.ProcessMessages;

          ArquivoOrigem := DiretorioOrigem + 'Dados\' + NomeArquivo;
          ArquivoDestino := DiretorioDestino + 'Dados\' + NomeArquivo;

          if FileExists(ArquivoOrigem) then
            begin
              if FileExists(ArquivoDestino) then
                DeleteFile(ArquivoDestino);

              CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(ArquivoDestino) , False  );

              Application.ProcessMessages;

              LogInstalacao.Add('Copiando arquivo ' + ArquivoOrigem + ' para ' + ArquivoDestino) ;

               if not SetFileAttributes(PChar(ArquivoDestino), FILE_ATTRIBUTE_NORMAL) then
                begin
                  MessageBox ( Self.Handle, PAnsiChar('Arquivo esta como ''somente leitura''' + ArquivoDestino), ' ', MB_OK or MB_ICONERROR);
                end;

               if FileExists(ArquivoDestino) then
                begin

                 Extensao := AnsiLowerCase( ExtractFileExt(ArquivoDestino));
                 if (Extensao = '.zip') OR (Extensao = '.rar')  then
                  begin
                    if FileExists(DiretorioDestino + 'Dados\ENCICLOPEDIA.GDB') then
                      DeleteFile (DiretorioDestino + 'Dados\ENCICLOPEDIA.GDB');

                    DescomprimePasta(Self.Handle,   DiretorioDestino + 'Dados\' , ArquivoDestino);
                    ListaArquivosInstalados.Add(DiretorioDestino + 'Dados\ENCICLOPEDIA.GDB');

                    Application.ProcessMessages;

                    DeleteFile (ArquivoDestino);
                  end
                 else
                  ListaArquivosInstalados.Add(ArquivoDestino);
                  
                end;

            end
          else
            begin
              LogInstalacao.Add('Arquivo ' + ArquivoOrigem + ' não existe ') ;

            end;
          Application.ProcessMessages;
          
      end;
    Application.ProcessMessages;

end;

procedure TFrmPrincipal.CopiaConteudoPastaDiversos();
var
  ArquivoOrigem : String;
  ArquivoDestino : String;
  MySearch: TSearchRec;
  NomeArquivo : String;
  ListaArquivos : TStringList;
  I : Integer;
  Q : Integer;

begin
    ListaArquivos := TStringList.Create();

    FindFirst(DiretorioOrigem + 'Diversos\*.*' , faAnyFile, MySearch);
    ArquivoOrigem := MySearch.Name;

    if ( ArquivoOrigem <> '') and (ArquivoOrigem <> '.') and ( ArquivoOrigem <> '..') then
      ListaArquivos.Add(ArquivoOrigem);

    while FindNext(MySearch)=0 do
      begin
        ArquivoOrigem := MySearch.Name;
        if ( ArquivoOrigem <> '') and (ArquivoOrigem <> '.') and ( ArquivoOrigem <> '..') then
          ListaArquivos.Add(ArquivoOrigem);

        Application.ProcessMessages;

      end;
    FindClose(MySearch);

    Application.ProcessMessages;

    Q := ListaArquivos.Count-1;
    for I := 0 to Q do
      begin
          NomeArquivo := ListaArquivos[i];

          LblArquivoAndamento.Caption := AnsiLowerCase(NomeArquivo);
          Application.ProcessMessages;

          ArquivoOrigem := DiretorioOrigem + 'Diversos\' + NomeArquivo;
          ArquivoDestino := DiretorioDestino + '\' + NomeArquivo;

          if FileExists(ArquivoOrigem) then
            begin
              CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(ArquivoDestino) , False  );

              ListaArquivosInstalados.Add(ArquivoDestino);

              LogInstalacao.Add('Copiando arquivo ' + ArquivoOrigem + ' para ' + ArquivoDestino) ;

               if not SetFileAttributes(PChar(ArquivoDestino), FILE_ATTRIBUTE_NORMAL) then
                begin
                  MessageBox ( Self.Handle, PAnsiChar('Arquivo esta como ''somente leitura''' + ArquivoDestino), ' ', MB_OK or MB_ICONERROR);
                end;
            end
          else
            begin
              LogInstalacao.Add('Arquivo ' + ArquivoOrigem + ' não existe ') ;

            end;

          Application.ProcessMessages;

      end;
    Application.ProcessMessages;
end;

procedure TFrmPrincipal.CopiaConteudoPastaBrowser();
var
  ArquivoOrigem : String;
  ArquivoDestino : String;
  MySearch: TSearchRec;
  NomeArquivo : String;
  ListaArquivos : TStringList;
  I : Integer;
  Q : Integer;

begin
    ListaArquivos := TStringList.Create();

    if not DirectoryExists(DiretorioDestino + 'Browser') then
      begin
        mkdir (DiretorioDestino + 'Browser');
        LogInstalacao.Add('Criando a pasta ' + DiretorioDestino + 'Browser');
        ListaDiretoriosCriados.Add(DiretorioDestino + 'Browser');
      end;

    FindFirst(DiretorioOrigem + 'Browser\*.*' , faAnyFile, MySearch);
    ArquivoOrigem := MySearch.Name;

    if ( ArquivoOrigem <> '') and (ArquivoOrigem <> '.') and ( ArquivoOrigem <> '..') then
      ListaArquivos.Add(ArquivoOrigem);

    while FindNext(MySearch)=0 do
      begin
        ArquivoOrigem := MySearch.Name;
        if ( ArquivoOrigem <> '') and (ArquivoOrigem <> '.') and ( ArquivoOrigem <> '..') then
          ListaArquivos.Add(ArquivoOrigem);

        Application.ProcessMessages;

      end;
    FindClose(MySearch);

    Q := ListaArquivos.Count-1;
    for I := 0 to Q do
      begin
          NomeArquivo := ListaArquivos[i];

          LblArquivoAndamento.Caption := AnsiLowerCase(NomeArquivo);
          Application.ProcessMessages;

          ArquivoOrigem := DiretorioOrigem + 'Browser\' + NomeArquivo;
          ArquivoDestino := DiretorioDestino + 'Browser\' + NomeArquivo;

          if FileExists(ArquivoOrigem) then
            begin
              CopyFile( PAnsiChar(ArquivoOrigem) , PAnsiChar(ArquivoDestino) , False  );

              ListaArquivosInstalados.Add(ArquivoDestino);

              LogInstalacao.Add('Copiando arquivo ' + ArquivoOrigem + ' para ' + ArquivoDestino) ;

               if not SetFileAttributes(PChar(ArquivoDestino), FILE_ATTRIBUTE_NORMAL) then
                begin
                  MessageBox ( Self.Handle, PAnsiChar('Arquivo esta como ''somente leitura''' + ArquivoDestino), ' ', MB_OK or MB_ICONERROR);
                end;
            end
          else
            begin
              LogInstalacao.Add('Arquivo ' + ArquivoOrigem + ' não existe ') ;

            end;

          Application.ProcessMessages;

      end;
    Application.ProcessMessages;
end;

Function TFrmPrincipal.ComprimePasta ( Handle :Cardinal;  Pasta : String ; ArquivoZIP : String) : Boolean;

var
  SEInfo          : TShellExecuteInfo;
  ExitCode        : DWORD;
  Parametros : String;
begin

  //Parametros  := ' a -m5 -e "' + ArquivoZIP + '" "' + pasta + '"' ;
  Parametros  := ' a -m5 -e "' + ArquivoZIP + '"';

  FillChar(SEInfo, SizeOf(SEInfo), 0) ;
  SEInfo.cbSize := SizeOf(TShellExecuteInfo) ;
  SEInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  SEInfo.Wnd := Handle;
  SEInfo.lpFile := PChar(GetcurrentDir + '\rar.exe') ;
  SEInfo.nShow := SW_Hide;
  SEInfo.lpParameters := PAnsiChar( Parametros );
  SEInfo.lpDirectory := PChar(Pasta);

  ShellExecuteEx(@SEInfo);

  repeat
    Application.ProcessMessages;
    GetExitCodeProcess(SEInfo.hProcess, ExitCode) ;

    Application.ProcessMessages;

  until (ExitCode <> STILL_ACTIVE) or Application.Terminated;

  result := True;

end;

Function TFrmPrincipal.DescomprimePasta ( Handle :Cardinal;  Pasta : String ; ArquivoZIP : String) : Boolean;

var
  SEInfo          : TShellExecuteInfo;
  ExitCode        : DWORD;
  Parametros : String;
  Diretorio : String;
begin

  Diretorio := Utf8ToAnsi(ArquivoZIP);

  Parametros  := ' e "' + Diretorio + '"';

  FillChar(SEInfo, SizeOf(SEInfo), 0) ;
  SEInfo.cbSize := SizeOf(TShellExecuteInfo) ;
  SEInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  SEInfo.Wnd := Handle;
  SEInfo.lpFile := PChar(GetcurrentDir + '\unrar.exe') ;
  SEInfo.nShow := SW_Hide;
  SEInfo.lpParameters := PAnsiChar( Parametros );
  SEInfo.lpDirectory := PChar(Pasta);

  ShellExecuteEx(@SEInfo);

  repeat
    Application.ProcessMessages;
    GetExitCodeProcess(SEInfo.hProcess, ExitCode) ;

    Application.ProcessMessages;

  until (ExitCode <> STILL_ACTIVE) or Application.Terminated;

  result := True;

end;

end.
