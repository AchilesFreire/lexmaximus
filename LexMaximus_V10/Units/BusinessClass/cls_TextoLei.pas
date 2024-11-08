unit cls_TextoLei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin,
  Conexoes, DBXpress, DB, SqlExpr,
  Funcoes;
  
Type
  Tcls_TextoLei = class(TObject)
    private
      varLei      : integer;
      varTexto     : String;
      varArquivoComprimido  :String;

      varMensagem : string;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParLei : integer) ; overload;

      procedure ClearFields();

      Property Lei          : integer   read varLei           write varLei;
      Property Texto         : String    read varTexto          write varTexto;
      Property ArquivoComprimido                   : String          read varArquivoComprimido                    write varArquivoComprimido;

      property Mensagem             : string    read varMensagem              Write varMensagem;

      function Insert() : Boolean;
      function Update() : Boolean;
      function Delete() : Boolean;
      Function Load()   : Boolean;  overload;
      Function Load(NomeArquivo : String)   : Boolean;  overload;
      function GetAll() : TSQLDataSet; overload;
      function GetAll(Condicao : String) : TSQLDataSet; overload;

    end;

implementation

constructor Tcls_TextoLei.create ();
begin
  try

    ClearFields();

  finally
  end;
end;

constructor Tcls_TextoLei.create (  ParLei : integer);
begin
  try
      ClearFields();

      varLei      := ParLei;

      Self.Load;

  finally
  end;
end;

procedure Tcls_TextoLei.ClearFields();
begin

  varLei              := -1;
  varTexto             := '';
  varArquivoComprimido := '';

  varMensagem     := '';
  
end;

function Tcls_TextoLei.Insert() : Boolean;

var
  Query       : TstringList;
  retorno     : integer;

begin
  try

      Query := TstringList.Create;

      DMConexoes.SQLQuery_InsertTextoLei.Close;

      DMConexoes.SQLQuery_InsertTextoLei.SQLConnection := DMConexoes.Conexao;

      DMConexoes.SQLQuery_InsertTextoLei.ParamByName('CodLei').AsInteger:= varLei;
      DMConexoes.SQLQuery_InsertTextoLei.ParamByName('TextoLei').LoadFromFile(varArquivoComprimido, ftBlob);

      retorno := DMConexoes.SQLQuery_InsertTextoLei.ExecSQL();

      if retorno = 1 then
        begin

          (******************************
          Query.Add('Update Lei set');
          Query.Add(' DataAlteracao =  current_date,' );
          Query.Add(' HoraAlteracao =  current_time' );
          Query.Add(' Where Lei = ' + IntToStr(varLei)   );

          retorno := DMConexoes.Conexao.ExecuteDirect(query.Text);
          ******************************)


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
    self.Mensagem := 'Erro';
    result := false;
  end;
end;

function Tcls_TextoLei.Update() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try

      Query := TStringList.Create();

      Query.Add('Update TextoLei  set ');
      Query.Add(' Texto= ''' + varTexto + '''' );
      Query.Add(' Where Lei = ' + IntToStr(varLei)  );

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

function Tcls_TextoLei.Delete() : Boolean;
var
  Query       : TStringList;
  retorno     : integer;

begin
  try
      Query := TStringList.Create();
      Query.Add('Delete From TextoLei');
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

Function Tcls_TextoLei.Load()   : Boolean;
var
  Query   : TstringList;
  Rcd     : TSQLDataSet;
  Clausula : String;
  Quantidade : Integer;
  Conteudo : TStringList;
  bf      : TBlobField;
  Arquivo : String;



begin
  try

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');        //  00
      Query.Add(' Texto');       //  01
      Query.Add(' From TextoLei') ;

      Clausula := ' Where ';

      if varlei <> -1 then
        begin
          Query.Add(' ' + Clausula + ' Lei = ' + IntToStr(Lei)) ;
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
          varLei      :=  Rcd.Fields[0].Value;

          if Rcd.Fields[1].Value  <> null then
            begin
               bf := Rcd.Fields[1] as TBlobField;

               Arquivo := GetCurrentDir() + '\tmp.blob';
               bf.SaveToFile( Arquivo );

               Conteudo := TStringList.Create;

               Conteudo.LoadFromFile(Arquivo);
               DeleteFile(Arquivo);

               vartexto := Conteudo.Text;

            end;

          Inc(Quantidade);
          rcd.Next;
        end;
        
      Result := (Quantidade =1);

      Query.Destroy;

      rcd.Close;

      rcd.Free;

  finally
  end;
end;


Function Tcls_TextoLei.Load(NomeArquivo : String)   : Boolean;
var
  Query   : TstringList;
  Rcd     : TSQLDataSet;
  Clausula : String;
  Quantidade : Integer;
  //Conteudo : TStringList;
  bf      : TBlobField;

begin
  try

      Query   := TstringList.Create;

      Query.Add(' Select');
      Query.Add(' Lei,');        //  00
      Query.Add(' Texto');       //  01
      Query.Add(' From TextoLei') ;

      Clausula := ' Where ';

      if varlei <> -1 then
        begin
          Query.Add(' ' + Clausula + ' Lei = ' + IntToStr(Lei)) ;
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
          varLei      :=  Rcd.Fields[0].Value;

          if Rcd.Fields[1].Value  <> null then
            begin
               bf := Rcd.Fields[1] as TBlobField;

               if FileExists(NomeArquivo) then
                DeleteFile(NomeArquivo);
                
               bf.SaveToFile( NomeArquivo );
               
               vartexto := Rcd.Fields[1].Value;

            end;

          Inc(Quantidade);
          rcd.Next;
        end;
        
      Result := (Quantidade =1);

      Query.Destroy;

      rcd.Close;

      rcd.Free;

  finally
  end;
end;

function Tcls_TextoLei.GetAll() : TSQLDataSet;

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
    Query.Add(' Texto');       //  01
    Query.Add(' From TextoLei');

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

function Tcls_TextoLei.GetAll(Condicao : String) : TSQLDataSet;

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
      Query.Add(' Texto');       //  01
      Query.Add(' From TextoLei');

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

