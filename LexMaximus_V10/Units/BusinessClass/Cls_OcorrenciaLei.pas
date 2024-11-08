unit Cls_OcorrenciaLei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, Conexoes,
  DBXpress, DB, SqlExpr;  

Type
  TCls_OcorrenciaLei = class(TObject)
    private
      varLei      : integer;
      varPalavras_Ementa     : String;
      varPalavras_Texto       : String;

      varMensagem : string;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParLei : integer) ; overload;

      procedure ClearFields();

      Property Lei          : integer   read varLei           write varLei;
      Property Palavras_Ementa         : String    read varPalavras_Ementa          write varPalavras_Ementa;
      Property Palavras_Texto          : String    read varPalavras_Texto           write varPalavras_Texto;

      property Mensagem             : string    read varMensagem              Write varMensagem;

      function Insert() : Boolean; overload;
      function Insert(ArqEmenta : String; ArqTexto : String) : Boolean; overload;
      function Update() : Boolean;
      function Delete() : Boolean;
      Function Load()   : Boolean;  overload;
      Function Load(ArquivoEmenta : String  ; ArquivoTexto : String  )   : Boolean; overload;
      function GetAll() : TSQLDataSet;
    end;

implementation

constructor TCls_OcorrenciaLei.create ();
begin
  try

    ClearFields();

  finally
  end;
end;

constructor TCls_OcorrenciaLei.create (ParLei : integer);
begin
  try
      ClearFields();

      varLei      := ParLei;

  finally
  end;
end;


procedure TCls_OcorrenciaLei.ClearFields();
begin

  varLei        := -1;
  varPalavras_Ementa       := '';
  varPalavras_Texto        := '';
  varMensagem     := '';
  
end;

function TCls_OcorrenciaLei.Insert() : Boolean;

var
  Query       : TstringList;
  retorno     : integer;

begin
  try

      Query := TstringList.Create;

      DMConexoes.SQLQuery_Insert_OcorrenciaLei.Close;

      DMConexoes.SQLQuery_Insert_OcorrenciaLei.SQLConnection := DMConexoes.Conexao;

      DMConexoes.SQLQuery_Insert_OcorrenciaLei.ParamByName('CodLei').AsInteger:= varLei;
      DMConexoes.SQLQuery_Insert_OcorrenciaLei.ParamByName('Ementa').Text := varPalavras_Ementa;
      DMConexoes.SQLQuery_Insert_OcorrenciaLei.ParamByName('Texto').Text := varPalavras_Texto;

      retorno := DMConexoes.SQLQuery_Insert_OcorrenciaLei.ExecSQL();

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
    on ex : exception do
      begin
        self.Mensagem := ex.Message;
        result := false;
      end;
  end;
end;


function TCls_OcorrenciaLei.Insert(ArqEmenta : String; ArqTexto : String) : Boolean;

var
  Query       : TstringList;
  retorno     : integer;

begin
  try

      Query := TstringList.Create;

      DMConexoes.SQLQuery_Insert_OcorrenciaLei.Close;

      DMConexoes.SQLQuery_Insert_OcorrenciaLei.SQLConnection := DMConexoes.Conexao;

      DMConexoes.SQLQuery_Insert_OcorrenciaLei.ParamByName('CodLei').AsInteger:= varLei;
      DMConexoes.SQLQuery_Insert_OcorrenciaLei.ParamByName('Ementa').LoadFromFile(ArqEmenta, ftBlob);
      DMConexoes.SQLQuery_Insert_OcorrenciaLei.ParamByName('Texto').LoadFromFile(ArqTexto, ftBlob);

      retorno := DMConexoes.SQLQuery_Insert_OcorrenciaLei.ExecSQL();


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
    on ex : exception do
      begin
        self.Mensagem := ex.Message;
        result := false;
      end;
  end;
end;



function TCls_OcorrenciaLei.Update() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try

      Query := TStringList.Create();

      Query.Add('Update Palavras  set ');
      Query.Add(' Palavras_Ementa= ''' + varPalavras_Ementa + ''',' );
      Query.Add(' Palavras_Texto= ''' + varPalavras_Texto + '''' );
      Query.Add(' Where Lei = ' + IntToStr(varLei)  );

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
    on ex : exception do
      begin
        self.Mensagem := ex.Message;
        result := false;
      end;
  end;
end;

function TCls_OcorrenciaLei.Delete() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;
  SQLInsert : TSQLQuery;

begin
  try
      Query := TStringList.Create();
      Query.Add('Delete From OcorrenciaLei');
      Query.Add(' Where Lei = ' + IntToStr(Lei)  );

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
          Mensagem := 'Erro de Exclusão';
        end;

      Query.Destroy;

  except
    on ex : exception do
      begin
        self.Mensagem := ex.Message;
        result := false;
      end;
  end;
end;

Function TCls_OcorrenciaLei.Load()   : Boolean;
var
  Query   : TstringList;
  Rcd     : TSQLDataSet;
  Quantidade : Integer;

begin
  try

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');                  //  00
      Query.Add(' Palavras_Ementa,');   //  01
      Query.Add(' Palavras_Texto');     //  02
      Query.Add(' From OcorrenciaLei ');

      Query.Add(' Where Lei = ' + IntToStr(Lei)) ;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;

      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;

      rcd.Open;

      //rcd.Open;

      ClearFields();

      Quantidade := 0;
      while not rcd.Eof do
        begin
          varLei      :=  Rcd.Fields[0].Value;

          if Rcd.Fields[1].Value  <> null then  varPalavras_Ementa       :=  Trim(Rcd.Fields[1].Value);
          if Rcd.Fields[2].Value  <> null then  varPalavras_Texto        :=  Trim(Rcd.Fields[2].Value);

          Inc(Quantidade);
          Result := True;

          rcd.Next();
        end;

      Result := (Quantidade =1);

      Query.Destroy;

      rcd.Close;

      rcd.Free;

  finally
  end;
end;


Function TCls_OcorrenciaLei.Load(ArquivoEmenta : String  ; ArquivoTexto : String  )   : Boolean;
var
  Query   : TstringList;
  Rcd     : TSQLDataSet;
  Quantidade : Integer;
  bfEmenta      : TBlobField;
  bfTexto      : TBlobField;

begin
  try

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');                  //  00
      Query.Add(' Palavras_Ementa,');   //  01
      Query.Add(' Palavras_Texto');     //  02
      Query.Add(' From OcorrenciaLei ');

      Query.Add(' Where Lei = ' + IntToStr(Lei)) ;

      Rcd := TSQLDataSet.Create(nil);
      rcd.SQLConnection := DMConexoes.Conexao;

      Rcd.CommandText := Query.Text;
      Rcd.CommandType := ctQuery;

      rcd.Open;

      //rcd.Open;

      ClearFields();

      Quantidade := 0;
      while not rcd.Eof do
        begin
          varLei      :=  Rcd.Fields[0].Value;

          if Rcd.Fields[1].Value  <> null then  varPalavras_Ementa       :=  Trim(Rcd.Fields[1].Value);
          if Rcd.Fields[2].Value  <> null then  varPalavras_Texto        :=  Trim(Rcd.Fields[2].Value);

           bfEmenta := Rcd.Fields[1] as TBlobField;
           if FileExists(ArquivoEmenta) then
            DeleteFile(ArquivoEmenta);
           bfEmenta.SaveToFile( ArquivoEmenta );

           bfTexto := Rcd.Fields[2] as TBlobField;
           if FileExists(ArquivoTexto) then
            DeleteFile(ArquivoTexto);
           bfTexto.SaveToFile( ArquivoTexto );
          
          Inc(Quantidade);
          Result := True;

          rcd.Next();
        end;

      Result := (Quantidade =1);

      Query.Destroy;

      rcd.Close;

      rcd.Free;

  finally
  end;
end;


function TCls_OcorrenciaLei.GetAll() : TSQLDataSet;

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
      Query.Add(' Palavras_Ementa,');       //  01
      Query.Add(' Palavras_Texto');        //  02
      Query.Add(' From OcorrenciaLei');

      if varLei <> -1 then
        begin
          Query.Add( Clausula + ' Lei = ' + IntToStr(Lei));
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

