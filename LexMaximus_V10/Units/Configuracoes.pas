unit Configuracoes;


interface

uses
  SysUtils, Classes, inifiles, StrUtils,  Graphics, Windows,
  Funcoes,
  CompressaoDados;

type

TiposLicenca = (
  TL_Indefinido   = 0,
  TL_DemoAno      = 1,
  TL_Demo3Usos    = 2
);


 TConfiguracoes = class(TObject)
    private

      //BancoDados
      VarStringConexao                  : string;
      varFonteLista                     : Tfont;

      //Aparencia
      varArquivoSkin                    : string;
      varLeft                           : Integer;
      varTop                            : Integer;
      varWidth                          : Integer;
      varHeight                         : Integer;
      varWindowState                    : string;

      varTipoLicenca                    : TiposLicenca;
      varDataLimiteUso                  : String;

      varPaginaInicial                  : String;
      varBanner                         : String;
      VarAtivacao_DescricaoUso          : string;
      VarAtivacao_EnderecoEmail         : string;
      VarAtivacao_Telefone1             : string;
      VarAtivacao_Telefone2             : string;
      VarAtivacao_WebSite               : string;
      VarAtivacao_Advertencia           : string;
      varCorFundo                       : TColor;
      varVersaoSistema                  : string;
      varVersaoAtualizacao              : string;
      varVersaoBaseDados                : string;
      varConectarInternet               : Boolean;

      varListaBannerLocal               : TStringList;
      varListaBannerInternet            : TStringList;

      varListaLinkLocal               : TStringList;
      varListaLinkInternet            : TStringList;

      varModoEdicao                     : Boolean;
      varExecutarCD                     : Boolean;

      varDiretorioTrabalho              : String;

    protected

    public

      constructor Create() ; overload;

      property StringConexao                  : string        read VarStringConexao             write VarStringConexao ;
      property FonteLista                     : Tfont         read varFonteLista                write varFonteLista;
      Property ArquivoSkin                    : string        read varArquivoSkin               write varArquivoSkin ;
      property CorFundo                       : TColor        read varCorFundo                  write varCorFundo default $202020;
      Property Left                           : Integer       read varLeft                      write varLeft ;
      Property Top                            : Integer       read varTop                       write varTop ;
      Property Width                          : Integer       read varWidth                     write varWidth ;
      Property Height                         : Integer       read varHeight                    write varHeight ;
      Property WindowState                    : string        read varWindowState               write varWindowState ;
      Property TipoLicenca                    : TiposLicenca  read varTipoLicenca               write varTipoLicenca ;
      Property DataLimiteUso                  : string        read varDataLimiteUso             write varDataLimiteUso ;
      Property PaginaInicial                  : string        read varPaginaInicial             write varPaginaInicial ;
      Property Banner                         : string        read varBanner                    write varBanner ;
      property Ativacao_DescricaoUso          : string        read varAtivacao_DescricaoUso     write varAtivacao_DescricaoUso ;
      property Ativacao_EnderecoEmail         : string        read varAtivacao_EnderecoEmail    write varAtivacao_EnderecoEmail ;
      property Ativacao_Telefone1             : string        read varAtivacao_Telefone1        write varAtivacao_Telefone1 ;
      property Ativacao_Telefone2             : string        read varAtivacao_Telefone2        write varAtivacao_Telefone2 ;
      property Ativacao_WebSite               : string        read VarAtivacao_WebSite          write VarAtivacao_WebSite ;
      property Ativacao_Advertencia           : string        read VarAtivacao_Advertencia      write VarAtivacao_Advertencia ;
      property VersaoSistema                  : string        read varVersaoSistema             write varVersaoSistema;
      property VersaoAtualizacao              : string        read varVersaoAtualizacao         write varVersaoAtualizacao;
      property VersaoBaseDados                : string        read varVersaoBaseDados           write varVersaoBaseDados;
      property ConectarInternet               : Boolean       read varConectarInternet          write varConectarInternet ;

      property ListaBannerLocal               : TStringList   read varListaBannerLocal          write varListaBannerLocal ;
      property ListaBannerInternet            : TStringList   read varListaBannerInternet       write varListaBannerInternet ;

      property ListaLinkLocal               : TStringList   read varListaLinkLocal          write varListaLinkLocal ;
      property ListaLinkInternet            : TStringList   read varListaLinkInternet       write varListaLinkInternet ;

      property ModoEdicao                     : Boolean       read varModoEdicao                write varModoEdicao ;
      property ExecutarCD                     : Boolean       read varExecutarCD                write varExecutarCD ;

      procedure CarregaConfiguracoes();
      procedure SalvaConfiguracoes();
      procedure SalvaConfiguracoesFormulario();

      function RetornaDiretorioTemporario() : String;
      function RetornaDiretorioTrabalho() : String;

      function RetornaDiretorioAplicacoes() : String;

 end;

 implementation

constructor TConfiguracoes.create ();
begin

  varDiretorioTrabalho := '';

  CarregaConfiguracoes();

end;

procedure TConfiguracoes.CarregaConfiguracoes();
var
  IniFile : TIniFile;
  temp : String;
  val : Integer;
  comp : TCompressaoDados;

  Indice : Integer;
  NomeBanner : String;

  Banner : String;
  DiretorioBase : String;
  Arquivo : String;

  NomeLink : String;
  Link      : String;

  ArquivoVerificacaoCD : String;

begin
  try

    comp := TCompressaoDados.Create();

    varTipoLicenca := TL_DemoAno;       //Copia do Sérgio
    varDataLimiteUso := '31/12/2011';

    /////varTipoLicenca := TL_Demo3Usos;     //Copia do Felix


    //se este arquivo existir no diretorio do programa, entao a execução sera pelo CD
    ArquivoVerificacaoCD := GetCurrentDir() +  '\ExecucaoCD.Dat';
    varExecutarCD := FileExists(ArquivoVerificacaoCD);


    //Abrindo o arquivo de configuracoes
    if varExecutarCD then
      begin
        Arquivo := Self.RetornaDiretorioTrabalho() + '\LexMaximus.dat';
        if Not FileExists(Arquivo) then
          Arquivo := getCurrentdir() + '\LexMaximus.dat';
      end
    else
      begin
        Arquivo := getCurrentdir() + '\LexMaximus.dat';
      end;

    comp.ArquivoComprimido := Arquivo;
    comp.ArquivoDescomprimido := comp.DiretorioDescompressao + 'dc123e12d12.ini';
    comp.DescomprimeArquivo();

    IniFile := TIniFile.Create( comp.ArquivoDescomprimido );

    temp := IniFile.ReadString  ( 'UsoInterno' , 'ModoEdicao' , 'N'  )  ;
    varModoEdicao := (temp = 'S');

    varModoEdicao := TRUE;

    temp := IniFile.ReadString  ( 'BancoDados' , 'StringConexao' , ''  )  ;

    if varExecutarCD then
      begin

        DiretorioBase := Self.RetornaDiretorioTrabalho();
        if Copy(DiretorioBase , Length(DiretorioBase) , 1) = '\' then
          DiretorioBase := Copy(DiretorioBase, 1 , Length(DiretorioBase)-1 );
      end
    else
      DiretorioBase := Getcurrentdir();

    temp := ReplaceText(temp,'%PATH%', DiretorioBase );

    VarStringConexao := temp;

    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    
    varArquivoSkin := IniFile.ReadString  ( 'Aparencia' , 'ArquivoSkin' , 'mxskin24.skn'  );
    if varArquivoSkin = '' then
      varArquivoSkin := 'mxskin24.skn';

    temp := IniFile.ReadString  ( 'Aparencia' , 'Left' , '0'  )  ;
    if isnumeric(temp) then
      varLeft := StrToInt(temp);

    temp := IniFile.ReadString  ( 'Aparencia' , 'Top' , '0'  )  ;
    if isnumeric(temp) then
      varTop := StrToInt(temp);

    temp := IniFile.ReadString  ( 'Aparencia' , 'Width' , '800'  )  ;
    if isnumeric(temp) then
      varWidth := StrToInt(temp);

    temp := IniFile.ReadString  ( 'Aparencia' , 'Height' , '500'  )  ;
    if isnumeric(temp) then
      varHeight := StrToInt(temp);

    varWindowState := IniFile.ReadString  ( 'Aparencia' , 'WindowState' , 'Normal'  )  ;

    temp := IniFile.ReadString  ( 'Aparencia' , 'ConectarInternet' , 'S'  )  ;
    if temp = 'S' then
      varConectarInternet := True
    else
      varConectarInternet := False;

    temp := IniFile.ReadString  ( 'Aparencia' , 'CorFundo' , '0'  )  ;
    if isnumeric(temp) then
      if temp = '0' then
        varCorFundo := $00804410
      else
        varCorFundo := StrToInt(temp)
    else
      varCorFundo := $00804410;

    varFonteLista := TFont.Create();
    Temp:= IniFile.ReadString( 'Aparencia' , 'FonteLista-Nome' , 'Verdana' );
    varFonteLista.Name := temp;

    varFonteLista.Color := IniFile.ReadInteger( 'Aparencia' , 'FonteLista-Cor' , clBlack  );
    varFonteLista.Size := IniFile.ReadInteger( 'Aparencia' , 'FonteLista-Tamanho' , 10  );

    temp := IniFile.ReadString  ( 'Aparencia' , 'FonteLista-Estilo'  , ''  );

    if Pos( '[fsBold]' , temp ) > 0 then
      varFonteLista.Style := varFonteLista.Style + [fsBold];

    if Pos( '[fsItalic]' , temp ) > 0 then
      varFonteLista.Style := varFonteLista.Style + [fsItalic];

    if Pos( '[fsUnderLine]' , temp ) > 0 then
      varFonteLista.Style := varFonteLista.Style + [fsUnderLine];

    if Pos( '[fsStrikeOut]' , temp ) > 0 then
      varFonteLista.Style := varFonteLista.Style + [fsStrikeOut];

    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////

    varPaginaInicial := IniFile.ReadString  ( 'Browser' , 'PaginaInicial' , 'http://www.elfez.com.br/lexmaximus/pginicial.html'  )  ;
    varBanner := IniFile.ReadString  ( 'Browser' , 'Banner' , 'http://www.elfez.com.br/lexmaximus/cima.gif'  )  ;
    // http://www.elfez.com.br/lexmaximus/cima.gif

    varAtivacao_DescricaoUso    := IniFile.ReadString  ( 'Ativacao' , 'DescricaoUso'   , ''  )  ;
    varAtivacao_EnderecoEmail   := IniFile.ReadString  ( 'Ativacao' , 'EnderecoEmail'  , ''  )  ;
    varAtivacao_Telefone1       := IniFile.ReadString  ( 'Ativacao' , 'Telefone1'      , ''  )  ;
    varAtivacao_Telefone2       := IniFile.ReadString  ( 'Ativacao' , 'Telefone2'      , ''  )  ;
    varAtivacao_WebSite         := IniFile.ReadString  ( 'Ativacao' , 'WebSite'        , 'www.elfez.com.br'  )  ;
    varAtivacao_Advertencia     := IniFile.ReadString  ( 'Ativacao' , 'Advertencia'    , ''  )  ;

    ////////////////////////////////////////////////////
    // Pegando os banners locais
    ////////////////////////////////////////////////////
    varListaBannerLocal := TStringList.Create();
    varListaLinkLocal := TStringList.Create();

    Indice := 1;

    NomeBanner := 'BannerLocal-' + RightPad( IntToStr(Indice) , '0' , 2);
    Banner     := IniFile.ReadString  ( 'BannerLocal' , NomeBanner    , ''  )  ;

    NomeLink := 'LinkLocal-' + RightPad( IntToStr(Indice) , '0' , 2);
    Link     := IniFile.ReadString  ( 'LinkLocal' , NomeLink    , ''  )  ;

    Inc ( Indice , 1 );
    varListaBannerLocal.Add(Banner);
    varListaLinkLocal.Add(Link);

    while Banner <> '' do
      begin

        NomeBanner := 'BannerLocal-' + RightPad( IntToStr(Indice) , '0' , 2);
        Banner     := IniFile.ReadString  ( 'BannerLocal' , NomeBanner    , ''  )  ;

        NomeLink := 'LinkLocal-' + RightPad( IntToStr(Indice) , '0' , 2);
        Link     := IniFile.ReadString  ( 'LinkLocal' , NomeLink    , ''  )  ;

        if (Banner<>'')and(Link<>'') then
          begin
            varListaBannerLocal.Add(Banner);
            varListaLinkLocal.Add(Link);
          end;

        Inc ( Indice , 1 );
      end;

    ////////////////////////////////////////////////////
    ////////////////////////////////////////////////////
    ////////////////////////////////////////////////////


    ////////////////////////////////////////////////////
    // Pegando os banners os da internet
    ////////////////////////////////////////////////////
    varListaBannerInternet  := TStringList.Create();

    // Os links serao obtidos a partir do mesmo local onde estao os banners
    // havera um txt para cada imagem, dentro do txt havera o link
    varListaLinkInternet    := TStringList.Create();

    if Not varExecutarCD then
      begin
        Indice := 1;

        NomeBanner := 'BannerInternet-' + RightPad( IntToStr(Indice) , '0' , 2);
        Banner     := IniFile.ReadString  ( 'BannerInternet' , NomeBanner    , ''  )  ;

        NomeLink := 'LinkInternet-' + RightPad( IntToStr(Indice) , '0' , 2);
        Link     := IniFile.ReadString  ( 'LinkInternet' , NomeLink    , ''  )  ;

        if (Banner<>'')and(Link<>'') then
          begin
            varListaBannerInternet.Add(Banner);
            varListaLinkInternet.Add(Link);
          end;

        Inc ( Indice , 1 );

        while Banner <> '' do
          begin

            NomeBanner  := 'BannerInternet-' + RightPad( IntToStr(Indice) , '0' , 2);
            Banner      := IniFile.ReadString  ( 'BannerInternet' , NomeBanner    , ''  )  ;

            NomeLink := 'LinkInternet-' + RightPad( IntToStr(Indice) , '0' , 2);
            Link     := IniFile.ReadString  ( 'LinkInternet' , NomeLink    , ''  )  ;

            if (Banner<>'')and(Link<>'') then
              begin
                varListaBannerInternet.Add(Banner);
                varListaLinkInternet.Add(Link);
              end;

            Inc ( Indice , 1 );
          end;
      end;

    ////////////////////////////////////////////////////
    ////////////////////////////////////////////////////
    ////////////////////////////////////////////////////


    varVersaoSistema            := '01.00' ;
    varVersaoBaseDados          := '01.00' ;

    IniFile.Destroy;

    DeleteFile( PAnsiChar( comp.ArquivoDescomprimido ) );
    
    comp.Destroy;

  finally

  end;

end;

procedure TConfiguracoes.SalvaConfiguracoes();
var
  IniFile : TIniFile;
  comp : TCompressaoDados;
  ArquivoINI : String;
  DiretorioBase : String;


begin
  try

    comp := TCompressaoDados.Create();

    ArquivoINI := comp.DiretorioDescompressao + '\3in2323frge.ini';

    if varExecutarCD then
      begin
        DiretorioBase := Self.RetornaDiretorioTrabalho();
        if Copy(DiretorioBase , Length(DiretorioBase) , 1) = '\' then
          DiretorioBase := Copy(DiretorioBase, 1 , Length(DiretorioBase)-1 );
      end
    else
      DiretorioBase := getCurrentdir();

    comp.ArquivoComprimido := DiretorioBase  + '\LexMaximus.dat';
    comp.ArquivoDescomprimido := ArquivoINI;
    comp.DescomprimeArquivo();

    IniFile := TIniFile.Create( comp.ArquivoDescomprimido );

    IniFile.WriteString  ( 'Aparencia' , 'ArquivoSkin'   , varArquivoSkin  );

    IniFile.WriteInteger  ( 'Aparencia' , 'Left'        ,  varLeft );
    IniFile.WriteInteger  ( 'Aparencia' , 'Top'         , varTop  );
    IniFile.WriteInteger  ( 'Aparencia' , 'Width'       , varWidth  );
    IniFile.WriteInteger  ( 'Aparencia' , 'Height'      , varHeight  );
    IniFile.WriteString   ( 'Aparencia' , 'WindowState'   , varWindowState  );

    IniFile.Destroy;

    comp.ArquivoComprimido := DiretorioBase  + '\LexMaximus.dat';
    comp.ArquivoDescomprimido := ArquivoINI;
    comp.ComprimeArquivo();

    Comp.destroy();

    DeleteFile( PAnsiChar(ArquivoINI) );

  finally

  end;

end;

procedure TConfiguracoes.SalvaConfiguracoesFormulario();
var
  IniFile         : TIniFile;
  comp            : TCompressaoDados;
  ArquivoINI      : String;
  Estilo          : string;
  DiretorioBase   : String;
  
begin

    comp := TCompressaoDados.Create();

    ArquivoINI := comp.DiretorioDescompressao + '\3in2323frge.ini';

    if varExecutarCD then
      begin
        DiretorioBase := Self.RetornaDiretorioTrabalho();
        if Copy(DiretorioBase , Length(DiretorioBase) , 1) = '\' then
          DiretorioBase := Copy(DiretorioBase, 1 , Length(DiretorioBase)-1 );
      end
    else
      DiretorioBase := getCurrentdir();

    comp.ArquivoComprimido := DiretorioBase  + '\LexMaximus.dat';

    comp.ArquivoDescomprimido := ArquivoINI;
    comp.DescomprimeArquivo();

    IniFile := TIniFile.Create( comp.ArquivoDescomprimido );

    IniFile.WriteString( 'Aparencia' , 'ArquivoSkin' , varArquivoSkin  );

    IniFile.WriteString( 'Aparencia' , 'CorFundo' , IntToStr(CorFundo)  );

    if varConectarInternet then
      IniFile.WriteString( 'Aparencia' , 'ConectarInternet' , 'S'  )
    else
      IniFile.WriteString( 'Aparencia' , 'ConectarInternet' , 'N'  );

    if varFonteLista <> nil then
      begin
        IniFile.WriteString( 'Aparencia' , 'FonteLista-Nome' , varFonteLista.Name  );
        IniFile.WriteInteger( 'Aparencia' , 'FonteLista-Cor' , varFonteLista.Color  );
        IniFile.WriteInteger( 'Aparencia' , 'FonteLista-Tamanho' , varFonteLista.Size  );

        Estilo := '';
        if fsBold in varFonteLista.Style then
          Estilo := Estilo + '[fsBold]';

        if fsItalic  in varFonteLista.Style then
          Estilo := Estilo + '[fsItalic]';

        if fsUnderLine  in varFonteLista.Style then
          Estilo := Estilo + '[fsUnderLine]';

        if fsStrikeOut  in varFonteLista.Style then
          Estilo := Estilo + '[fsStrikeOut]';

        IniFile.WriteString( 'Aparencia' , 'FonteLista-Estilo' , Estilo  );
      end;

    IniFile.Destroy;

    comp.ArquivoComprimido := DiretorioBase  + '\LexMaximus.dat';
    comp.ArquivoDescomprimido := ArquivoINI;
    comp.ComprimeArquivo();

    Comp.destroy();

    DeleteFile( PAnsiChar(ArquivoINI) );
      
end;

function TConfiguracoes.RetornaDiretorioTemporario() : String;
begin
  Result := GetEnvironmentVariable('TEMP') + '\';
end;

function TConfiguracoes.RetornaDiretorioAplicacoes() : String;
begin

  Result := GetEnvironmentVariable('APPDATA');
  if Result = '' then
    Result := GetEnvironmentVariable('USERPROFILE');
end;


function TConfiguracoes.RetornaDiretorioTrabalho() : String;
var
  DiretorioAplicacoes : String;
begin

  if varDiretorioTrabalho = '' then
    begin
      DiretorioAplicacoes := GetEnvironmentVariable('APPDATA');
      if DiretorioAplicacoes = '' then
        DiretorioAplicacoes := GetEnvironmentVariable('USERPROFILE');


      varDiretorioTrabalho := DiretorioAplicacoes + '\LexMaximus\';

      if not DirectoryExists(varDiretorioTrabalho) then
        mkdir (varDiretorioTrabalho);
    end;

  result := varDiretorioTrabalho;

end;

end.
