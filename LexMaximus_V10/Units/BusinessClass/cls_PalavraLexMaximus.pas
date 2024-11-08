unit cls_PalavraLexMaximus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, Conexoes,
  DBXpress, DB, SqlExpr;

Type
  TCls_PalavraLexMaximus = class(TObject)
    private
      varPalavraLexMaximus       : integer;
      varNome                   : String;
      varDataInclusao : String;

      varMensagem     : string;



    protected

    public

      constructor Create() ; overload;
      constructor Create ( ParPalavraLexMaximus : integer); overload;
      constructor Create(ParNome : String) ; overload;

      procedure ClearFields();

      Property PalavraLexMaximus       : integer         read varPalavraLexMaximus        write varPalavraLexMaximus;
      Property Nome                   : String          read varNome                    write varNome;
      Property DataInclusao   : String    read varDataInclusao    write varDataInclusao;

      property Mensagem     : string          read varMensagem     Write varMensagem;

      function ProximoCodigoPalavraLexMaximus() : integer;
      function Insert() : Boolean;
      function Update() : Boolean;
      function Delete() : Boolean;
      Function Load()   : Boolean;
      function GetAll() : TSQLDataSet; overload;
      function GetAll(DataInicio : String ; DataFim  : String ) : TSQLDataSet; overload;
      

    end;

implementation

constructor TCls_PalavraLexMaximus.create ();
begin
  try

    ClearFields();

  finally
  end;
end;

constructor TCls_PalavraLexMaximus.create ( ParPalavraLexMaximus : integer);
begin
  try

      ClearFields();

      varPalavraLexMaximus      := ParPalavraLexMaximus;

      Self.Load;

  finally
  end;
end;

constructor TCls_PalavraLexMaximus.create ( ParNome : String);
begin
  try

      ClearFields();

      varNome      := ParNome;

      Self.Load;

  finally
  end;
end;

procedure TCls_PalavraLexMaximus.ClearFields();
begin

  varPalavraLexMaximus       := -1;
  varNome                   := '';
  varDataInclusao := '';

  varMensagem     := '';

end;

function TCls_PalavraLexMaximus.ProximoCodigoPalavraLexMaximus() : integer;

var
  Query   : string;

  Retorno : integer;
  Rcd : TSQLDataSet;

begin
  try
    Query := 'Select';
    Query := Query + ' max(PalavraLexMaximus)';
    Query := Query + ' From PalavraLexMaximus';

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

function TCls_PalavraLexMaximus.Insert() : Boolean;

var
  Query       : TstringList;
  retorno     : integer;
  //CodigoPalavraLexMaximus : integer;
  SQLInsert : TSQLQuery;

begin
  try

      Query := TstringList.Create;

      varPalavraLexMaximus := ProximoCodigoPalavraLexMaximus();

      Query.Add('Insert into PalavraLexMaximus ');
      Query.Add(' (');
      Query.Add(' PalavraLexMaximus,');
      Query.Add(' Nome,');
      Query.Add(' DataInclusao');
      Query.Add(' )');
      Query.Add(' Values');
      Query.Add(' (');
      Query.Add(' ' + IntToStr(varPalavraLexMaximus) + ',' );
      Query.Add(' ''' + Nome + ''',' );
      Query.Add(' current_date');
      Query.Add(' )');

      SQLInsert := TSQLQuery.Create(nil);
      SQLInsert.SQLConnection := DMConexoes.Conexao;
      SQLInsert.SQL.Text := Query.Text;
      retorno := SQLInsert.ExecSQL(True);
      
      if retorno = 1 then
        begin
          result := True;
          Mensagem := '';
        end
      else
        begin
          result := False;
          Mensagem := 'Erro de inclusão';
        end;

      Query.Destroy;

  except
    on Ex : Exception do
      begin
        self.Mensagem := ex.Message;
        result := false;
      end;
  end;
end;

function TCls_PalavraLexMaximus.Update() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try

      Query := TStringList.Create();

      Query.Add('Update PalavraLexMaximus  set ');
      Query.Add(' Nome= ''' + Nome + '''' );
      Query.Add(' Where PalavraLexMaximus = ' + IntToStr(PalavraLexMaximus)  );

      //Result := false;
      retorno := DMConexoes.Conexao.ExecuteDirect(Query.Text);

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
    on Ex : Exception do
      begin
        self.Mensagem := ex.Message;
        result := false;
      end;
  end;
end;

function TCls_PalavraLexMaximus.Delete() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try
      Query := TStringList.Create();
      Query.Add('Delete From PalavraLexMaximus');
      Query.Add(' Where PalavraLexMaximus = ' + IntToStr(PalavraLexMaximus)  );

      //Result := false;

      retorno := DMConexoes.Conexao.ExecuteDirect(Query.Text);

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
    on Ex : Exception do
      begin
        self.Mensagem := ex.Message;
        result := false;
      end;
  end;
end;

Function TCls_PalavraLexMaximus.Load()   : Boolean;
var
  Query   : TstringList;
  Clausula    : string;
  Rcd : TSQLDataSet;
  Quantidade : Integer;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' PalavraLexMaximus,');        //  00
      Query.Add(' Nome,');                    //  01
      Query.Add(' DataInclusao');                    //  02
      Query.Add(' From PalavraLexMaximus');

      if varPalavraLexMaximus <> -1 then
        begin
          Query.Add( Clausula + ' PalavraLexMaximus = ' + IntToStr(PalavraLexMaximus));
          Clausula := ' And ';
        end;
      if varNome <> '' then
        begin
          Query.Add( Clausula + ' Nome = ''' + varNome + '''') ;
          Clausula := ' And ';
        end;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;

      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;

      rcd.Open;

      ClearFields();

      Quantidade := 0;
      while not rcd.Eof do
        begin
          varPalavraLexMaximus      :=  Rcd.Fields[0].Value;

          if Rcd.Fields[1].Value  <> null then  varNome          :=  Trim(Rcd.Fields[1].Value);
          if Rcd.Fields[2].Value  <> null then  varDataInclusao  :=  Trim(Rcd.Fields[2].Value);

          Inc(Quantidade);
          rcd.Next;
        end;
        
      Result := (Quantidade =1);

      Query.Destroy;

      rcd.Close;

      rcd.Free;
  except

    on Ex : Exception do
      begin
        self.Mensagem := ex.Message;
        result := false;
      end;

  end;
end;

function TCls_PalavraLexMaximus.GetAll() : TSQLDataSet;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLDataSet;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' PalavraLexMaximus,');        //  00
      Query.Add(' Nome,');                    //  01
      Query.Add(' DataInclusao');                    //  02
      Query.Add(' From PalavraLexMaximus');

      if varPalavraLexMaximus <> -1 then
        begin
          Query.Add( Clausula + ' PalavraLexMaximus = ' + IntToStr(PalavraLexMaximus));
          Clausula := ' And ';
        end;
      if varNome <> '' then
        begin
          Query.Add( Clausula + ' Nome = ''' + varNome + '''') ;
          Clausula := ' And ';
        end;

      Query.Add( ' Order By PalavraLexMaximus') ;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;

      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;

      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except

    on Ex : Exception do
      begin
        self.Mensagem := ex.Message;
        result := nil;
      end;
  end;
end;

function TCls_PalavraLexMaximus.GetAll(DataInicio : String ; DataFim  : String ) : TSQLDataSet;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLDataSet;
  DataI : TDate;
  DataF : TDate;
  CondicaoDatas : String;


begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' PalavraLexMaximus,');        //  00
      Query.Add(' Nome,');                    //  01
      Query.Add(' DataInclusao');                    //  02
      Query.Add(' From PalavraLexMaximus');

      DataI := StrToDate(DataInicio);
      DataF := StrToDate(DataFim);

      CondicaoDatas := ' ( DataInclusao >= ''' + FormatDateTime('mm-dd-yyyy' , DataI ) + '''';
      CondicaoDatas := CondicaoDatas + ' And DataInclusao <= ''' + FormatDateTime('mm-dd-yyyy' , DataF ) + ''' )';

      Query.Add( Clausula + CondicaoDatas);
      Clausula := ' And ';


      if varPalavraLexMaximus <> -1 then
        begin
          Query.Add( Clausula + ' PalavraLexMaximus = ' + IntToStr(PalavraLexMaximus));
          Clausula := ' And ';
        end;
      if varNome <> '' then
        begin
          Query.Add( Clausula + ' Nome = ''' + varNome + '''') ;
          Clausula := ' And ';
        end;

      Query.Add( ' Order By PalavraLexMaximus') ;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;

      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;

      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except

    on Ex : Exception do
      begin
        self.Mensagem := ex.Message;
        result := nil;
      end;
  end;
end;

end.

