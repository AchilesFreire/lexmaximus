unit cls_NotaLei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, ADODB, StrUtils;

Type
  Tcls_NotaLei = class(TObject)
    private
      varLei      : integer;
      varPosicao    : Integer;
      varNotaLei     : String;
      varTipoNotaLei     : String;

      varMensagem : string;
      varConexao  : TADOConnection;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParLei : integer) ; overload;
      constructor create ( ParConexao : TADOConnection ; ParLei : integer ; ParPosicao : integer); overload;

      procedure ClearFields();

      Property Lei          : integer   read varLei           write varLei;
      Property Posicao      : integer   read varPosicao       write varPosicao;
      Property NotaLei      : String    read varNotaLei       write varNotaLei;
      Property TipoNotaLei  : String    read varTipoNotaLei       write varTipoNotaLei;

      property Mensagem     : string    read varMensagem      Write varMensagem;

      property Conexao      : TADOConnection  read varConexao Write varConexao;

      function Insert() : Boolean;
      function Update() : Boolean;
      function Delete() : Boolean;
      Function Load()   : Boolean;
      function GetAll() : TADODataSet;
      function GetAll2() : TADODataSet;
      function GetCount() : integer;

    end;

implementation

uses DB;

constructor Tcls_NotaLei.create ();
begin
  try

    ClearFields();

  finally
  end;
end;

constructor Tcls_NotaLei.create (ParLei : integer);
begin
  try
      ClearFields();

      varLei      := ParLei;

  finally
  end;
end;

constructor Tcls_NotaLei.create ( ParConexao : TADOConnection ; ParLei : integer ; ParPosicao : integer);
begin
  try
      ClearFields();

      varLei      := ParLei;
      varPosicao := parPosicao;
      varConexao      := ParConexao;

      if (varLei <> -1) and (varposicao <> -1) then
        Self.Load;

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

      //Result := false;

      retorno := 0;
      varConexao.CommandTimeout := 0;
      varConexao.Execute(  Query.Text , retorno );

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

      //Result := false;
      retorno := 0;

      varConexao.Execute(  Query.Text , retorno );

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

      retorno := 0;
      varConexao.Execute(  Query.Text , retorno );

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
  Rcd     : ADODB.TADODataSet;
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


      Rcd := TADODataSet.Create( Conexao );
      Rcd.Connection := varConexao;

      Rcd.CommandText := Query.Text;
      Rcd.CommandType := cmdText;
      Rcd.CursorType := ctStatic;
      rcd.CursorLocation := clUseClient;

      rcd.Open;

      ClearFields();

      if rcd.Recordset.RecordCount = 1 then
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

function Tcls_NotaLei.GetAll() : TADODataSet;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : ADODB.TADODataSet;

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

      Rcd := TADODataSet.Create( Conexao );
      Rcd.Connection := varConexao;
      Rcd.CommandTimeout := 0;
      Rcd.CommandText := Query.Text;
      Rcd.CommandType := cmdText;
      Rcd.CursorType := ctStatic;
      rcd.CursorLocation := clUseClient;

      rcd.Open;

      result := Rcd;
      Mensagem := '';

      Query.Destroy;

  except
    self.Mensagem := 'Erro';
    result := nil;
  end;
end;

function Tcls_NotaLei.GetAll2() : TADODataSet;

var
  Query   : TstringList;
  Clausula    : string;
  Rcd         : ADODB.TADODataSet;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' SELECT');
      Query.Add(' Lei,');
      Query.Add(' Nome,');
      Query.Add(' Link,');
      Query.Add(' TipoLei,');
      Query.Add(' Publicacao,');
      Query.Add(' Ementa,');
      Query.Add(' NumeroLei,');
      Query.Add(' TipoDocumento,');
      Query.Add(' (Select Nome From TipoLei Where Lei.TipoLei = TipoLei.TipoLei)  as ''NomeTipoLei'' ');
      Query.Add(' FROM Lei ');
      Query.Add(' Where Lei in ( Select distinct Lei From NotaLei )');

      Query.Add( ' Order By Lei.TipoLei, Lei.Lei') ;

      Rcd := TADODataSet.Create( Conexao );
      Rcd.Connection := varConexao;
      Rcd.CommandTimeout := 0;
      Rcd.CommandText := Query.Text;
      Rcd.CommandType := cmdText;
      Rcd.CursorType := ctStatic;
      rcd.CursorLocation := clUseClient;

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
  Rcd         : ADODB.TADODataSet;

begin
  try

      Clausula := ' Where ';

      Query   := TstringList.Create;

      Query.Add(' SELECT count(*) FROM NotaLei ');

      Rcd := TADODataSet.Create( Conexao );
      Rcd.Connection := varConexao;
      Rcd.CommandTimeout := 0;
      Rcd.CommandText := Query.Text;
      Rcd.CommandType := cmdText;
      Rcd.CursorType := ctStatic;
      rcd.CursorLocation := clUseClient;

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

