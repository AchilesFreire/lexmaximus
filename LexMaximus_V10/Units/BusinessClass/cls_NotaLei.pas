unit cls_NotaLei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, DBXpress, DB, SqlExpr, StrUtils,
  Conexoes;

Type
  Tcls_NotaLei = class(TObject)
    private
      varLei      : integer;
      varPosicao    : Integer;
      varNotaLei     : String;
      varTipoNotaLei     : String;

      varMensagem : string;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParLei : integer ; ParPosicao : integer) ; overload;

      procedure ClearFields();

      Property Lei          : integer   read varLei           write varLei;
      Property Posicao      : integer   read varPosicao       write varPosicao;
      Property NotaLei      : String    read varNotaLei       write varNotaLei;
      Property TipoNotaLei  : String    read varTipoNotaLei       write varTipoNotaLei;

      property Mensagem     : string    read varMensagem      Write varMensagem;

      function Insert() : Boolean;
      function Update() : Boolean;
      function Delete() : Boolean;
      Function Load()   : Boolean;
      function GetAll() : TSQLQuery;
      function GetAll2() : TSQLQuery;
      function GetCount() : integer;

    end;

implementation


constructor Tcls_NotaLei.create ();
begin
  try

    ClearFields();

  finally
  end;
end;

constructor Tcls_NotaLei.create (ParLei : integer ; ParPosicao : integer);
begin
  try
      ClearFields();

      varLei      := ParLei;
      if (varLei <> -1) and (varposicao <> -1) then
        Self.Load
  finally
  end;
end;



procedure Tcls_NotaLei.ClearFields();
begin

  varLei              := -1;
  varPosicao          := -1;
  varNotaLei          := '';
  varTipoNotaLei      := '';

  varMensagem     := '';
  
end;

function Tcls_NotaLei.Insert() : Boolean;

var
  Query       : TstringList;
  retorno     : integer;
  Comando : TSQLQuery;

begin
  try

    Query := TstringList.Create;

    varNotaLei := ReplaceStr(varNotaLei, '''', '');
    varNotaLei := ReplaceStr(varNotaLei, '"', '');

    Query.Add('Insert into NotaLei ');
    Query.Add(' (');
    Query.Add(' Lei,');
    Query.Add(' Posicao,');
    Query.Add(' NotaLei,');
    Query.Add(' TipoNotaLei');
    Query.Add(' )');

    Query.Add(' Values');

    Query.Add(' (');
    Query.Add(' ' + IntToStr(VarLei) + ',' );
    Query.Add(' ' + IntToStr(VarPosicao) + ',' );
    Query.Add(' ''' + varNotaLei + ''',' );
    Query.Add(' ''' + varTipoNotaLei + '''' );
    Query.Add(' )');

    Comando := TSQLQuery.Create(nil);
    Comando.SQLConnection :=  DMConexoes.Conexao;
    Comando.SQL.Text := Query.Text;

    retorno :=Comando.ExecSQL(True);

    //  retorno := DMConexoes.Conexao.ExecuteDirect(  Query.Text  );

    if retorno = 1 then
      begin
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

function Tcls_NotaLei.Update() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try

      Query := TStringList.Create();

      varNotaLei := ReplaceStr(varNotaLei, '''', '');
      varNotaLei := ReplaceStr(varNotaLei, '"', '');

      Query.Add('Update NotaLei set ');
      Query.Add(' NotaLei= ''' + varNotaLei + ''',' );
      Query.Add(' TipoNotaLei= ''' + varTipoNotaLei + '''' );

      Query.Add(' Where Lei = ' + IntToStr(varLei)  );
      Query.Add(' And Posicao = ' + IntToStr(varPosicao)  );

      retorno := DMConexoes.Conexao.ExecuteDirect(  Query.Text  );

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

function Tcls_NotaLei.Delete() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try
      Query := TStringList.Create();
      Query.Add('Delete From NotaLei');
      Query.Add(' Where Lei = ' + IntToStr(varLei)  );
      Query.Add(' And Posicao = ' + IntToStr(varPosicao)  );

      //Result := false;

      retorno:= DMConexoes.Conexao.ExecuteDirect(  Query.Text );

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

Function Tcls_NotaLei.Load()   : Boolean;
var
  Query   : TstringList;
  Rcd     : TSQLQuery;
  //Retorno : integer;

begin
  try

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');           //  00
      Query.Add(' Posicao,');       //  01
      Query.Add(' NotaLei,');       //  02
      Query.Add(' TipoNotaLei');    //  03
      Query.Add(' From NotaLei') ;
      Query.Add(' Where Lei = ' + IntToStr(varLei)) ;
      Query.Add(' And Posicao = ' + IntToStr(varPosicao)) ;

      Rcd := TSQLQuery.Create( nil );
      Rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.sql.Text := Query.Text;
      rcd.Open;

      ClearFields();

      if not rcd.eof then
        begin
          varLei      :=  Rcd.Fields[0].Value;

          if Rcd.Fields[1].Value  <> null then  varPosicao       :=  Rcd.Fields[1].AsInteger;
          if Rcd.Fields[2].Value  <> null then  varNotaLei       :=  Trim(Rcd.Fields[2].Value);
          if Rcd.Fields[3].Value  <> null then  TipoNotaLei      :=  Trim(Rcd.Fields[3].Value);


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

function Tcls_NotaLei.GetAll() : TSQLQuery;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLQuery;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');           //  00
      Query.Add(' Posicao,');       //  01
      Query.Add(' NotaLei,');       //  02
      Query.Add(' TipoNotaLei');    //  03
      Query.Add(' From NotaLei') ;

      if varLei <> -1 then
        begin
          Query.Add( Clausula + ' Lei = ' + IntToStr(varLei));
          Clausula := ' And ';
        end;
      if varPosicao <> -1 then
        begin
          Query.Add( Clausula + ' Posicao = ' + IntToStr(varPosicao));
          Clausula := ' And ';
        end;
      if varNotaLei <> '' then
        begin
          Query.Add( Clausula + ' NotaLei = ''' + varNotaLei + '''') ;
          Clausula := ' And ';
        end;
      if varTipoNotaLei <> '' then
        begin
          Query.Add( Clausula + ' TipoNotaLei = ''' + varTipoNotaLei + '''') ;
          Clausula := ' And ';
        end;
      Query.Add( ' Order By Lei, Posicao') ;

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

function Tcls_NotaLei.GetAll2() : TSQLQuery;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLQuery;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' SELECT');
      Query.Add(' Lei,');
      Query.Add(' Nome,');
      Query.Add(' TipoLei,');
      Query.Add(' Publicacao,');
      Query.Add(' Ementa,');
      Query.Add(' NumeroLei,');
      Query.Add(' TipoDocumento,');
      Query.Add(' (Select Nome From TipoLei Where Lei.TipoLei = TipoLei.TipoLei) NomeTipoLei');
      Query.Add(' FROM Lei ');
      Query.Add(' Where Lei in ( Select distinct Lei From NotaLei )');

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

function Tcls_NotaLei.GetCount() : integer;
var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : TSQLQuery;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' SELECT count(*) FROM NotaLei ');

      Rcd := TSQLQuery.Create( nil );
      Rcd.SQLConnection := DMConexoes.Conexao;
      Rcd.sql.Text := Query.Text;
      rcd.Open;

      Result := rcd.Fields[0].AsInteger;

      Mensagem := '';

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := 0;
  end;

end;

end.

