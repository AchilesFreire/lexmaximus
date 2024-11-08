unit cls_Lei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, DBXpress, DB, SqlExpr,
  conexoes;

Type
  TCls_Lei = class(TObject)
    private
      varLei      : integer;
      varNome     : String;
      varAno       : String;
      varTipoLei  : integer;
      varPublicacao : String;
      varEmenta     : String;
      varNumeroLei  : String;
      varTipoDocumento : String;

      varMensagem : string;
      varConexao  : TSQLConnection;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParLei : integer) ; overload;

      procedure ClearFields();

      Property Lei          : integer   read varLei           write varLei;
      Property Nome         : String    read varNome          write varNome;
      Property Ano          : String    read varAno           write varAno;
      Property TipoLei      : integer   read varTipoLei       write varTipoLei;
      Property Publicacao   : String    read varPublicacao    write varPublicacao;
      Property Ementa       : String    read varEmenta        write varEmenta;

      Property NumeroLei       : String    read varNumeroLei        write varNumeroLei;
      Property TipoDocumento   : String    read varTipoDocumento        write varTipoDocumento;

      property Mensagem             : string    read varMensagem              Write varMensagem;

      property Conexao      : TSQLConnection  read varConexao                 Write varConexao;

      function ProximoCodigoLei() : integer;
      function Insert() : Boolean;
      function Update() : Boolean;
      function Delete() : Boolean;
      Function Load()   : Boolean;
      function GetAll() : TSQLQuery;
      function RetornaLeiPeloNumero(Numero : Integer; TipoLei : Integer) : TSQLQuery;
      function RetornaLeiPeloTipoLei(TiposLeiSelecionados :String ; CondicaoSubNodes : String ; CondicaoLei : String ; ListaPalavras : TStringList ; TipoPesquisa : integer ) : TSQLQuery;
    end;

implementation


constructor TCls_Lei.create ();
begin
  try

    ClearFields();

  finally
  end;
end;

constructor TCls_Lei.create (ParLei : integer);
begin
  try
      ClearFields();

      varLei      := ParLei;

      Self.Load;

  finally
  end;
end;

procedure TCls_Lei.ClearFields();
begin

  varLei              := -1;
  varNome             := '';
  varAno              := '';
  varTipoLei          := -1;
  varPublicacao       := '';
  varEmenta           := '';
  varNumeroLei        := '';
  varTipoDocumento    := '';


  varMensagem     := '';
  
end;

function TCls_Lei.ProximoCodigoLei() : integer;

var
  Query   : string;
  Rcd     : TSQLQuery;
  Retorno : integer;

begin
  try
    Query := 'Select';
    Query := Query + ' max(Lei)';
    Query := Query + ' From Lei';

    Rcd := TSQLQuery.Create( nil );
    Rcd.SQLConnection := DMConexoes.Conexao;
    Rcd.sql.Text := Query;

    rcd.Open;


    if Rcd.Fields[0].Value = null then
      Retorno :=   1
    else
      Retorno :=  Rcd.Fields[0].Value + 1;

    rcd.Close;
    rcd.Destroy;

    result := retorno;

  except
    result := -1;
  end;
end;

function TCls_Lei.Insert() : Boolean;

var
  Query       : TstringList;
  retorno     : integer;
  CodigoLei : integer;

begin
  try

      Query := TstringList.Create;

      CodigoLei := ProximoCodigoLei();

      Query.Add('Insert into Lei ');
      Query.Add(' (');
      Query.Add(' Lei,');
      Query.Add(' Nome,');
      Query.Add(' Ano,');
      Query.Add(' TipoLei,');
      Query.Add(' Publicacao, ');
      Query.Add(' Ementa, ');

      Query.Add(' NumeroLei, ');
      Query.Add(' TipoDocumento ');

      Query.Add(' )');

      Query.Add(' Values');

      Query.Add(' (');
      Query.Add(' ' + IntToStr(CodigoLei) + ',' );
      Query.Add(' ''' + varNome + ''',' );
      Query.Add(' ''' + varAno + ''',' );
      Query.Add(' ' + IntToStr(varTipoLei) + ',' );
      Query.Add(' ''' + varPublicacao + ''',' );
      Query.Add(' ''' + varEmenta + ''',' );

      Query.Add(' ''' + varNumeroLei + ''',' );
      Query.Add(' ''' + varTipoDocumento + '''' );

      Query.Add(' )');

      //Result := false;

      retorno := DMConexoes.Conexao.ExecuteDirect(  Query.Text  );

      if retorno = 1 then
        begin
          self.Lei := CodigoLei;
          result := True;
          Mensagem := '';
        end
      else
        begin
          self.Lei := -1;
          result := False;
          Mensagem := 'Erro de inclusão';
        end;

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := false;
  end;
end;

function TCls_Lei.Update() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try

      Query := TStringList.Create();

      Query.Add('Update Lei  set ');
      Query.Add(' Nome= ''' + varNome + ''',' );
      Query.Add(' Ano= ''' + varAno + ''',' );
      Query.Add(' TipoLei = ' + IntToStr(varTipoLei) + ',' );
      Query.Add(' Publicacao= ''' + varPublicacao + ''',' );
      Query.Add(' Ementa= ''' + varEmenta + '''' );
      Query.Add(' Where Lei = ' + IntToStr(varLei)  );

      retorno :=DMConexoes.Conexao.ExecuteDirect(  Query.Text  );

      if retorno = 1 then
        begin
          result := True;
          Mensagem := '';
        end
      else
        begin
          result := False;
          Mensagem := 'Erro de Alteração';
        end;

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := false;
  end;
end;

function TCls_Lei.Delete() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try
      Query := TStringList.Create();
      Query.Add('Delete Lei');
      Query.Add(' Where Lei = ' + IntToStr(Lei)  );

      retorno := DMConexoes.Conexao.ExecuteDirect(  Query.Text  );

      if retorno = 1 then
        begin
          result := True;
          Mensagem := '';
        end
      else
        begin
          result := False;
          Mensagem := 'Erro de Exclusão';
        end;

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := false;
  end;
end;

Function TCls_Lei.Load()   : Boolean;
var
  Query   : TstringList;
  Rcd     : TSQLQuery;
  //Retorno : integer;

begin
  try

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');             //  00
      Query.Add(' Nome,');            //  01
      Query.Add(' Ano,');             //  02
      Query.Add(' TipoLei,');         //  03
      Query.Add(' Publicacao,');      //  04
      Query.Add(' Ementa, ');         //  05
      Query.Add(' NumeroLei, ');      //  06
      Query.Add(' TipoDocumento ');   //  07
      Query.Add(' From Lei') ;
      Query.Add(' Where Lei = ' + IntToStr(Lei)) ;

      Rcd := TSQLQuery.Create( nil );
      Rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.sql.Text := Query.Text;

      rcd.Open;

      ClearFields();

      if not rcd.eof then
        begin
          varLei      :=  Rcd.Fields[0].Value;

          if Rcd.Fields[1].Value  <> null then  varNome               :=  Trim(Rcd.Fields[1].Value);
          if Rcd.Fields[2].Value  <> null then  varAno                :=  Trim(Rcd.Fields[2].Value);
          if Rcd.Fields[3].Value  <> null then  varTipoLei             :=  Rcd.Fields[3].AsInteger;
          if Rcd.Fields[4].Value  <> null then  varPublicacao          :=  Trim(Rcd.Fields[4].Value);
          if Rcd.Fields[5].Value  <> null then  varEmenta             :=  Trim(Rcd.Fields[5].Value);
          if Rcd.Fields[6].Value  <> null then  varNumeroLei          :=  Trim(Rcd.Fields[6].Value);
          if Rcd.Fields[7].Value  <> null then  varTipoDocumento      :=  Trim(Rcd.Fields[7].Value);


          Result := True;
        end
      else
        begin

          Result := False;
        end;

      Query.Destroy;

      rcd.Close;

      rcd.Free;

  finally
  end;
end;

function TCls_Lei.GetAll() : TSQLQuery;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLQuery;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' Select '); //Achiles: 25/08/2010 Retirada a clausula Distinct que nao existe no firebird
      Query.Add(' Lei,');        //  00
      Query.Add(' Nome,');       //  01
      Query.Add(' Ano,');        //  02
      Query.Add(' TipoLei,');    //  04
      Query.Add(' Publicacao,'); //  05
      Query.Add(' Ementa, ');    //  06
      Query.Add(' NumeroLei, ');      // 07
      Query.Add(' TipoDocumento, ');   // 08
      Query.Add('  cast (NumeroLei as integer)  ');    // 09
      //Query.Add(' Val(NumeroLei) ');    // 09

      Query.Add(' From Lei');

      if varLei <> -1 then
        begin
          Query.Add( Clausula + ' Lei = ' + IntToStr(Lei));
          Clausula := ' And ';
        end;
      if varNome <> '' then
        begin
          Query.Add( Clausula + ' Nome = ''' + varNome + '''') ;
          Clausula := ' And ';
        end;
      if varAno <> '' then
        begin
          Query.Add( Clausula + ' Ano = ''' + varAno + '''') ;
          Clausula := ' And ';
        end;
      if varTipoLei <> -1 then
        begin
          Query.Add( Clausula + ' TipoLei = ' + IntToStr(varTipoLei));
          Clausula := ' And ';
        end;

      //Query.Add( ' Order By Val(NumeroLei) Desc, Lei Asc') ;
      Query.Add( ' Order By cast (NumeroLei as integer)  Desc, Lei Asc') ;
      Rcd := TSQLQuery.Create( nil );
      Rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.sql.Text := Query.Text;

      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := nil;
  end;
end;

function TCls_Lei.RetornaLeiPeloNumero(Numero : Integer; TipoLei : Integer) : TSQLQuery;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLQuery;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');        //  00
      Query.Add(' Nome,');       //  01
      Query.Add(' Ano,');        //  02
      Query.Add(' TipoLei,');    //  04
      Query.Add(' Publicacao,'); //  05
      Query.Add(' Ementa, ');    //  06
      Query.Add(' NumeroLei, ');      // 07
      Query.Add(' TipoDocumento ');   // 08

      Query.Add(' From Lei');

      if Numero <> -1 then
        begin
          Query.Add( Clausula + ' NumeroLei = ''' + IntToStr(Numero) + '''');
          Clausula := ' And ';
        end;
      if TipoLei <> -1 then
        begin
          Query.Add( Clausula + ' TipoLei = ' + IntToStr(TipoLei) ) ;
          Clausula := ' And ';
        end;

      Query.Add( ' Order By Lei') ;

      Rcd := TSQLQuery.Create( nil );
      Rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.sql.Text := Query.Text;

      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := nil;
  end;
end;

function TCls_Lei.RetornaLeiPeloTipoLei(TiposLeiSelecionados :String ; CondicaoSubNodes : String ; CondicaoLei : String ; ListaPalavras : TStringList ; TipoPesquisa : integer) : TSQLQuery;

var
  Query       : TstringList;
  Clausula    : string;
  Rcd         : TSQLQuery;
  Filtro      : String;
  Condicao    : String;
  I           : Integer;
  Q           : Integer;


begin
  try

      Clausula := ' Where ';          // Clausula para juncao condicoes referentes as colunas da tabela
      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei.Lei,');        //  00
      Query.Add(' Lei.Nome,');       //  01
      Query.Add(' Lei.Ano,');        //  02
      Query.Add(' Lei.TipoLei,');    //  03
      Query.Add(' Lei.Publicacao,'); //  04
      Query.Add(' Lei.Ementa, ');    //  05
      Query.Add(' Lei.NumeroLei, ');      // 06
      Query.Add(' Lei.TipoDocumento ');   // 07
      Query.Add(' From Lei ');
      if (TipoPesquisa=1) OR (TipoPesquisa=2) OR (TipoPesquisa=3) Then
        begin
          Query.Add(' , OcorrenciaLei');
          Query.Add(' Where Lei.Lei = OcorrenciaLei.Lei');
        end;
      Clausula := '';
      Filtro := '';

      if CondicaoLei <> '' then
        begin
          Filtro := Filtro + Clausula + ' ( Lei.Lei in (' + CondicaoLei + ') ) ';
          Clausula := ' OR ';
        end;

      if TiposLeiSelecionados <> '' then
        begin
          Filtro := Filtro + Clausula + ' ( Lei.TipoLei in (' + TiposLeiSelecionados + ') ) ';
          Clausula := ' OR ';
        end;
      if CondicaoSubNodes <> '' then
        begin
          Filtro := Filtro + Clausula + '( ' + CondicaoSubNodes + ' ) ';
          Clausula := ' OR ';
        end;

      if Filtro <> '' then
        Query.Add(' AND (' + Filtro + ') ' );

      if (TipoPesquisa= 1) or (TipoPesquisa=2) then
        begin
          Q := ListaPalavras.Count-1;
          Condicao := ' (';
          for i := 0 to Q do
            begin
              Condicao := Condicao + ' OcorrenciaLei.Palavras_Texto like ''%' + ListaPalavras[i] + '%'' ';
              if I < Q then
                begin
                  if (TipoPesquisa=1) then
                    begin
                      Condicao := Condicao + ' AND ';
                    end;
                   if (TipoPesquisa=2) then
                    begin
                      Condicao := Condicao + ' OR ';
                    end;
               end;

            end;
          Condicao := Condicao + ' )';
        end;

      if TipoPesquisa = 3 then
        begin
          Condicao := Condicao + ' OcorrenciaLei.Palavras_Texto like ''%' + ListaPalavras[0] + '%'' ';
        end;

      Query.Add( ' And ' + Condicao );

      Query.Add( ' Order By Lei.TipoLei, Lei.Lei') ;

      Rcd := TSQLQuery.Create( nil );
      Rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.sql.Text := Query.Text;

      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := nil;
  end;
end;


end.

