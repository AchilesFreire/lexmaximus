unit cls_Lei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin,
  Conexoes, DBXpress, DB, SqlExpr,
  Funcoes;
  
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
      varLegislacao : Integer;
      varMensagem : string;
      varDataInclusao : String;
      varDataAlteracao : String;
      varHoraAlteracao  : String;

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

      Property Legislacao          : integer   read varLegislacao           write varLegislacao;

      Property DataInclusao   : String    read varDataInclusao    write varDataInclusao;
      Property DataAlteracao       : String    read varDataAlteracao        write varDataAlteracao;
      Property HoraAlteracao       : String    read varHoraAlteracao        write varHoraAlteracao;

      property Mensagem             : string    read varMensagem              Write varMensagem;

      function ProximoCodigoLei() : integer;
      function Insert() : Boolean;
      function Update() : Boolean;
      function Delete() : Boolean;
      Function Load()   : Boolean;
      function GetAll() : TSQLDataSet; overload;
      function GetAll(Condicao : String) : TSQLDataSet; overload;
      function GetAll(TiposLeiSelecionados : String; CondicaoSelecaoSubNode : String; CondicaoSelecaoLei : String) : TSQLDataSet; overload;
      function GetAll(DataInicio : String ; DataFim : String) : TSQLDataSet; overload;

      function RetornaLegislacao() : Integer;
      function RetornaLeiPeloNumero(Numero : Integer; TipoLei : Integer) : TSQLDataSet;

      procedure ApagaListaPalavras();

    end;

implementation

constructor TCls_Lei.create ();
begin
  try

    ClearFields();

  finally
  end;
end;

constructor TCls_Lei.create (  ParLei : integer);
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
  varLegislacao       := -1;
  varDataInclusao     := '';
  varDataAlteracao    := '';
  varHoraAlteracao    := '';

  varMensagem     := '';
  
end;

function TCls_Lei.ProximoCodigoLei() : integer;

var
  Query   : string;
  Rcd     : TSQLDataSet;
  Retorno : integer;
begin
  try

    Query := 'Select';
    Query := Query + ' max(Lei)';
    Query := Query + ' From Lei';

    Rcd := TSQLDataSet.Create(nil);
    rcd.SQLConnection := DMConexoes.Conexao;
    Rcd.CommandText := Query;
    Rcd.CommandType := ctQuery;
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
      Query.Add(' CodigoLei,');
      Query.Add(' Nome,');
      Query.Add(' Ano,');
      Query.Add(' TipoLei,');
      Query.Add(' Publicacao, ');
      Query.Add(' Ementa, ');

      Query.Add(' NumeroLei, ');
      Query.Add(' TipoDocumento, ');
      Query.Add(' Legislacao, ');
      Query.Add(' DataInclusao ');

      Query.Add(' )');

      Query.Add(' Values');

      Query.Add(' (');
      Query.Add(' ' + IntToStr(CodigoLei) + ',' );
      Query.Add(' 1,');
      Query.Add(' ''' + varNome + ''',' );
      Query.Add(' ''' + varAno + ''',' );
      Query.Add(' ' + IntToStr(varTipoLei) + ',' );
      Query.Add(' ''' + varPublicacao + ''',' );
      Query.Add(' ''' + varEmenta + ''',' );
      Query.Add(' ''' + varNumeroLei + ''',' );
      Query.Add(' ''' + varTipoDocumento + ''',' );
      Query.Add(' ' + IntToStr(varLegislacao) + ',' );
      Query.Add(' current_date'  );

      Query.Add(' )');

      retorno := DMConexoes.Conexao.ExecuteDirect( Query.Text);

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
      Query.Add(' Ementa= ''' + varEmenta + ''',' );
      Query.Add(' NumeroLei= ''' + varNumeroLei + ''',' );
      Query.Add(' TipoDocumento= ''' + varTipoDocumento + ''',' );
      Query.Add(' Legislacao = ' + IntToStr(varLegislacao) + ',' );
      Query.Add(' DataAlteracao =  current_date,' );
      Query.Add(' HoraAlteracao =  current_time' );
      Query.Add(' Where Lei = ' + IntToStr(varLei)   );

      retorno := DMConexoes.Conexao.ExecuteDirect( Query.Text);

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
      Query.Add('Delete From Lei');
      Query.Add(' Where Lei = ' + IntToStr(Lei)  );

      retorno := DMConexoes.Conexao.ExecuteDirect( Query.Text);

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

procedure TCls_Lei.ApagaListaPalavras();
begin

  DMConexoes.Conexao.ExecuteDirect('Delete From PalavraLexMaximus');
  DMConexoes.Conexao.ExecuteDirect('commit');

end;

Function TCls_Lei.Load()   : Boolean;
var
  Query   : TstringList;
  Rcd     : TSQLDataSet;
  Clausula : String;
  Total : Integer;

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
      Query.Add(' NumeroLei, ');      // 06
      Query.Add(' TipoDocumento,');   // 07
      Query.Add(' Legislacao,');      // 08
      Query.Add(' DataInclusao,');    // 09
      Query.Add(' DataAlteracao,');   // 10
      Query.Add(' HoraAlteracao');    // 11

      Query.Add(' From Lei') ;

      Clausula := ' Where ';
      
      if varlei <> -1 then
        begin
          Query.Add(' ' + Clausula + ' Lei = ' + IntToStr(Lei)) ;
          Clausula := ' And ';
        end;

      if varAno <> '' then
        begin
          Query.Add(' ' + Clausula + ' ano = ''' + varAno + '''') ;
          Clausula := ' And ';
        end;

      if varTipolei <> -1 then
        begin
          Query.Add(' ' + Clausula + ' Tipolei = ' + IntToStr(varTipolei)) ;
          Clausula := ' And ';
        end;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;
      rcd.Open;

      ClearFields();

      Total := 0;
      while not rcd.Eof do
      
        begin
          varLei      :=  Rcd.Fields[0].Value;

          if Rcd.Fields[1].Value  <> null then  varNome               :=  Trim(Rcd.Fields[1].Value);
          if Rcd.Fields[2].Value  <> null then  varAno                :=  Trim(Rcd.Fields[2].Value);
          if Rcd.Fields[3].Value  <> null then  varTipoLei            :=  Rcd.Fields[3].AsInteger;
          if Rcd.Fields[4].Value  <> null then  varPublicacao         :=  Trim(Rcd.Fields[4].Value);
          if Rcd.Fields[5].Value  <> null then  varEmenta             :=  Trim(Rcd.Fields[5].Value);
          if Rcd.Fields[6].Value  <> null then  varNumeroLei          :=  Trim(Rcd.Fields[6].Value);
          if Rcd.Fields[7].Value  <> null then  varTipoDocumento      :=  Trim(Rcd.Fields[7].Value);
          if Rcd.Fields[8].Value  <> null then  varLegislacao         :=  Rcd.Fields[8].AsInteger;
          if Rcd.Fields[9].Value  <> null then  varDataInclusao       :=  Rcd.Fields[9].AsString;
          if Rcd.Fields[10].Value  <> null then  varDataAlteracao     :=  Rcd.Fields[10].AsString;
          if Rcd.Fields[11].Value  <> null then  varHoraAlteracao     :=  Rcd.Fields[11].AsString;

          Result := True;

          Rcd.Next;

          Inc(Total);
        end;

      Result := (Total =1);

      Query.Destroy;

      rcd.Close;

      rcd.Free;

  finally
  end;
end;

function TCls_Lei.GetAll() : TSQLDataSet;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLDataSet;

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
    Query.Add(' NumeroLei, ');        // 07
    Query.Add(' TipoDocumento, ');    // 08
    Query.Add(' Legislacao,');      // 09
    Query.Add(' DataInclusao,');    // 10
    Query.Add(' DataAlteracao,');   // 11
    Query.Add(' HoraAlteracao');    // 12
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

      if VarTipoLei <> -1 then
        begin
          Query.Add( Clausula + ' TipoLei = ' + IntToStr(VarTipoLei));
          Clausula := ' And ';
        end;
        
      if VarLegislacao <> -1 then
        begin
          Query.Add( Clausula + ' Legislacao = ' + IntToStr(VarLegislacao));
          Clausula := ' And ';
        end;

      if varNumeroLei <> '' then
        begin
          Query.Add( Clausula + ' NumeroLei = ''' + varNumeroLei + '''');
          Clausula := ' And ';
        end;

      Query.Add( ' Order By NumeroLei') ;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;
      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := nil;
  end;
end;

function TCls_Lei.GetAll(Condicao : String) : TSQLDataSet;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLDataSet;

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
      Query.Add(' TipoDocumento, ');    // 08
      Query.Add(' Legislacao,');      // 09
      Query.Add(' DataInclusao,');    // 10
      Query.Add(' DataAlteracao,');   // 11
      Query.Add(' HoraAlteracao');    // 12
      Query.Add(' From Lei');

      if Condicao <> '' then
        begin
          Query.Add( Clausula + ' ' + Condicao);
          Clausula := ' And ';
        end;


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

      if Condicao <> '' then
        begin
          Query.Add( Clausula + Condicao) ;
          Clausula := ' And ';
        end;
      if VarLegislacao <> -1 then
        begin
          Query.Add( Clausula + ' Legislacao = ' + IntToStr(VarLegislacao));
          Clausula := ' And ';
        end;

      if varNumeroLei <> '' then
        begin
          Query.Add( Clausula + ' NumeroLei = ''' + varNumeroLei + '''');
          Clausula := ' And ';
        end;

      Query.Add( ' Order By Lei') ;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;
      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := nil;
  end;
end;

function TCls_Lei.GetAll(TiposLeiSelecionados : String; CondicaoSelecaoSubNode : String; CondicaoSelecaoLei : String) : TSQLDataSet;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLDataSet;

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
      Query.Add(' TipoDocumento, ');    // 08
      Query.Add(' Legislacao,');      // 09
      Query.Add(' DataInclusao,');    // 10
      Query.Add(' DataAlteracao,');   // 11
      Query.Add(' HoraAlteracao');    // 12
      Query.Add(' From Lei');

      if CondicaoSelecaoLei <> '' then
        begin

          Query.Add(  Clausula + ' ( Lei in (' + CondicaoSelecaoLei + ') ) ');
          Clausula := ' OR ';
        end;

      if TiposLeiSelecionados <> '' then
        begin

          Query.Add( Clausula + ' ( TipoLei in (' + TiposLeiSelecionados + ') ) ');
          Clausula := ' OR ';
        end;
      if CondicaoSelecaoSubNode <> '' then
        begin
          Query.Add(  Clausula + '( ' + CondicaoSelecaoSubNode + ' ) ');
          Clausula := ' OR ';
        end;

      Query.Add( ' Order By Lei') ;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;
      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := nil;
  end;
end;

function TCls_Lei.GetAll(DataInicio : String ; DataFim : String) : TSQLDataSet;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLDataSet;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');        //  00
      Query.Add(' Nome,');       //  01
      Query.Add(' Ano,');        //  02
      Query.Add(' Lei.TipoLei,');    //  04
      Query.Add(' Publicacao,'); //  05
      Query.Add(' Ementa, ');    //  06
      Query.Add(' NumeroLei, ');      // 07
      Query.Add(' TipoDocumento, ');    // 08
      Query.Add(' Legislacao,');      // 09
      Query.Add(' DataInclusao,');    // 10
      Query.Add(' DataAlteracao,');   // 11
      Query.Add(' HoraAlteracao,');    // 12
      Query.Add(' (Select nome from TipoLei where Lei.TipoLei = TipoLei.TipoLei) NomeTipoLei ');    // 13

      Query.Add(' From Lei');

      if (DataInicio <> '') and (DataFim <> '') then
        begin
          Query.Add( Clausula + ' ( DataInclusao >= ''' + DataInicio + '''');
          Query.Add(  ' And DataInclusao <= ''' + DataFim + ''')');

          Query.Add( ' OR ( DataAlteracao >= ''' + DataInicio + '''');
          Query.Add(  ' And DataAlteracao <= ''' + DataFim + ''')');

          Clausula := ' And ';
        end;

      if varAno <> '' then
        begin
          Query.Add( Clausula + ' Ano = ''' + varAno + '''') ;
          Clausula := ' And ';
        end;

      if VarTipoLei <> -1 then
        begin
          Query.Add( Clausula + ' TipoLei = ' + IntToStr(VarTipoLei));
          Clausula := ' And ';
        end;

      Query.Add( ' Order By Lei') ;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;
      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except
    on ex : exception do
      begin
        self.Mensagem := ex.Message;
        result := nil;
      end;
  end;
end;

function TCls_Lei.RetornaLegislacao() : integer;
var
  Query : String;
  Rcd : TSQLDataSet;
  retorno : String;
  temp : integer;
  Sequencial : String;


begin
  // 1 TT AAA
  Retorno := '1';
  Retorno := Retorno + RightPad(IntToStr(varTipoLei),'0', 2);

  // Pegando o ano, para obter o sequencial
  Query := 'Select top 1';
  Query := Query + ' Legislacao';
  Query := Query + ' From Lei';
  Query := Query + ' Where tipoLei = ' + intToStr(varTipoLei) ;
  Query := Query + ' And ano = ''' + varano + '''';

  Rcd := TSQLDataSet.Create(nil);
  rcd.SQLConnection := DMConexoes.Conexao;
  Rcd.CommandText := Query;
  Rcd.CommandType := ctQuery;
  rcd.Open;

  if rcd.Eof then
    begin

      rcd.Close;

      Query := 'Select ';
      Query := Query + ' Max(Legislacao)';
      Query := Query + ' From Lei';
      Query := Query + ' Where tipoLei = ' + intToStr(varTipoLei) ;

      Rcd := TSQLDataSet.Create( nil );
      rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.CommandText := Query;
      Rcd.CommandType := ctQuery;
      rcd.Open;

      Sequencial := rcd.Fields[0].AsString;
      Sequencial := Copy( Sequencial , 4);

      temp := StrToInt(Sequencial);

      inc(temp , 1 );

      Sequencial := RightPad(IntToStr(temp),'0', 2);
      

      
    end
  else
    begin
      Sequencial := rcd.Fields[0].AsString;
      Sequencial := Copy( Sequencial , 4);
    end;
  rcd.Close;
  rcd.Destroy;


  Retorno := Retorno + Sequencial;

  Result := StrToInt(Retorno);




end;

function TCls_Lei.RetornaLeiPeloNumero(Numero : Integer; TipoLei : Integer) : TSQLDataSet;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLDataSet;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');        //  00
      Query.Add(' Nome,');       //  01
      Query.Add(' Ano,');        //  02
      Query.Add(' Link, ');      //  03
      Query.Add(' TipoLei,');    //  04
      Query.Add(' Publicacao,'); //  05
      Query.Add(' Ementa, ');    //  06
      Query.Add(' NumeroLei, ');      // 07
      Query.Add(' TipoDocumento, ');   // 08
      Query.Add(' Legislacao,');      // 09
      Query.Add(' DataInclusao,');    // 10
      Query.Add(' DataAlteracao,');   // 11
      Query.Add(' HoraAlteracao');    // 12
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

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;
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

