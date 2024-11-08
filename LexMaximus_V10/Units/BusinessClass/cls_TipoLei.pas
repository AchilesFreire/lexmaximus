unit cls_TipoLei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, DBXpress, DB, SqlExpr,
  Conexoes ;

Type
  TCls_TipoLei = class(TObject)
    private
      varTipoLei       : integer;
      varNome                   : String;

      varMensagem     : string;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParTipoLei : integer) ; overload;

      procedure ClearFields();

      Property TipoLei       : integer         read varTipoLei        write varTipoLei;
      Property Nome                   : String          read varNome                    write varNome;

      property Mensagem     : string          read varMensagem     Write varMensagem;

      function ProximoCodigoTipoLei() : integer;
      function Insert() : Boolean;
      function Update() : Boolean;
      function Delete() : Boolean;
      Function Load()   : Boolean;
      function GetAll() : TSQLQuery; overload;

      function RetornaAnos() : TSQLQuery; overload;

    end;

implementation

constructor TCls_TipoLei.create ();
begin
  try

    ClearFields();

  finally
  end;
end;

constructor TCls_TipoLei.create (ParTipoLei : integer);
begin
  try

      ClearFields();

      varTipoLei      := ParTipoLei;

      Self.Load;

  finally
  end;
end;

procedure TCls_TipoLei.ClearFields();
begin

  varTipoLei       := -1;
  varNome                   := '';

  varMensagem     := '';

end;

function TCls_TipoLei.ProximoCodigoTipoLei() : integer;

var
  Query   : string;
  Rcd     : TSQLQuery;
  Retorno : integer;

begin
  try
    Query := 'Select';
    Query := Query + ' max(TipoLei)';
    Query := Query + ' From TipoLei';

    rcd := DMConexoes.AbreDataSet(Query);

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

function TCls_TipoLei.Insert() : Boolean;

var
  Query       : TstringList;
  retorno     : integer;
  CodigoTipoLei : integer;

begin
  try

      Query := TstringList.Create;

      CodigoTipoLei := ProximoCodigoTipoLei();

      Query.Add('Insert into TipoLei ');
      Query.Add(' (');
      Query.Add(' TipoLei,');
      Query.Add(' Nome');
      Query.Add(' )');

      Query.Add(' Values');

      Query.Add(' (');
      Query.Add(' ' + IntToStr(CodigoTipoLei) + ',' );
      Query.Add(' ''' + Nome + '''' );
      Query.Add(' )');

      retorno := dmConexoes.Conexao.ExecuteDirect(  Query.Text );

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

function TCls_TipoLei.Update() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try

      Query := TStringList.Create();

      Query.Add('Update TipoLei  set ');
      Query.Add(' Nome= ''' + Nome + '''' );
      Query.Add(' Where TipoLei = ' + IntToStr(TipoLei)  );

      retorno := dmConexoes.Conexao.ExecuteDirect(  Query.Text );

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

function TCls_TipoLei.Delete() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try
      Query := TStringList.Create();
      Query.Add('Delete From TipoLei');
      Query.Add(' Where TipoLei = ' + IntToStr(TipoLei)  );

      retorno := dmConexoes.Conexao.ExecuteDirect(  Query.Text );

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

Function TCls_TipoLei.Load()   : Boolean;
var
  Query   : TstringList;
  Rcd     : TSQLQuery;
  //Retorno : integer;

begin
  try

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' TipoLei,');        //  00
      Query.Add(' Nome');                    //  01
      Query.Add(' From TipoLei');
      Query.Add(' Where TipoLei = ' + IntToStr(TipoLei)) ;

      Rcd := DMConexoes.AbreDataSet(Query.Text);

      ClearFields();

      if not rcd.eof then
        begin
          varTipoLei      :=  Rcd.Fields[0].Value;

          if Rcd.Fields[1].Value  <> null then  varNome                     :=  Trim(Rcd.Fields[1].Value);

          Result := True;
        end
      else
        begin

          Result := False;
        end;

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

function TCls_TipoLei.GetAll() : TSQLQuery;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLQuery;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' TipoLei,');        //  00
      Query.Add(' Nome');            //  01
      Query.Add(' From TipoLei');

      if varTipoLei <> -1 then
        begin
          Query.Add( Clausula + ' Cliente = ' + IntToStr(TipoLei));
          Clausula := ' And ';
        end;
      if varNome <> '' then
        begin
          Query.Add( Clausula + ' Nome = ''' + varNome + '''') ;
          Clausula := ' And ';
        end;

      Query.Add( ' Order By TipoLei') ;

      Rcd := DMConexoes.AbreDataSet(Query.Text);

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

function TCls_TipoLei.RetornaAnos() : TSQLQuery;
var
  Query   : TstringList;
  Rcd         : TSQLQuery;

begin
  try

      Query   := TstringList.Create;

      Query.Add(' Select Distinct');
      Query.Add(' Ano,');
      Query.Add(' Legislacao');
      Query.Add(' From Lei');
      Query.Add(' Where TipoLei = ' + IntToStr(varTipoLei));
      //Query.Add( ' Order By Legislacao') ;
      Query.Add( ' Order By Ano Desc') ;

      Rcd := DMConexoes.AbreDataSet(Query.Text);

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

