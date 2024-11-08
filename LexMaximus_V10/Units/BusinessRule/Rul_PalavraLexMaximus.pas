unit Rul_PalavraLexMaximus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin,
  Conexoes, DBXpress, DB, SqlExpr,
  cls_PalavraLexMaximus;

Type
  TRul_PalavraLexMaximus = class(TObject)
    private
      varPalavraLexMaximus      : integer;
      varNome         : string;
      varDataInclusao : String;
      varMensagem     : string;
      varNovoRegistro : Boolean;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParPalavraLexMaximus : integer) ; overload;
      constructor Create(ParNome : String) ; overload;

      procedure ClearFields();

      Property PalavraLexMaximus       : integer         read varPalavraLexMaximus        write varPalavraLexMaximus;
      Property Nome                   : String          read varNome                    write varNome;
      Property DataInclusao   : String    read varDataInclusao    write varDataInclusao;

      property Mensagem     : string          read varMensagem     Write varMensagem;

      property NovoRegistro : Boolean         read varNovoRegistro Write varNovoRegistro;

      function Validate()       : Boolean;
      function ValidateInsert() : Boolean;
      function ValidateUpdate() : Boolean;
      function ValidateDelete() : Boolean;

      Function Load() : Boolean;
      function GetAll() : TSQLDataSet; overload;
      function GetAll(DataInicio : String ; DataFim  : String ) : TSQLDataSet; overload;

    end;

implementation

constructor TRul_PalavraLexMaximus.create ();
begin

  ClearFields();

end;

constructor TRul_PalavraLexMaximus.create (  ParPalavraLexMaximus : integer);
begin
  try

    ClearFields();

    varPalavraLexMaximus      := ParPalavraLexMaximus;

    varNovoRegistro := (Not Self.Load() );

  finally
  end;
end;

constructor TRul_PalavraLexMaximus.create (  ParNome : String);
begin
  try

    ClearFields();

    varNome      := ParNome;

    varNovoRegistro := (Not Self.Load() );

  finally
  end;
end;

procedure TRul_PalavraLexMaximus.ClearFields();
begin
  varPalavraLexMaximus      := -1;
  varNome         := '';
  varDataInclusao := '';

  varMensagem     := '';

  varNovoRegistro := False;
  
end;

function TRul_PalavraLexMaximus.Validate() : Boolean;
begin
  try

    varMensagem := '';

    //if varPalavraLexMaximus = -1         then  varMensagem := 'Campo PalavraLexMaximus precisa ser preenchido';
    //if trim(varNome) = ''         	then  varMensagem := 'Campo Nome precisa ser preenchido';
    //if trim(varDescricao) = ''        then  varMensagem := 'Campo Descricao precisa ser preenchido';

    Result := (VarMensagem = '');

  finally
  end;
end;

function TRul_PalavraLexMaximus.ValidateInsert() : Boolean;
var
  registro  : TCls_PalavraLexMaximus;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_PalavraLexMaximus.Create();

    registro.PalavraLexMaximus      := varPalavraLexMaximus;
    registro.Nome         := varNome;

    varMensagem := '';

    result := registro.Insert;

    varPalavraLexMaximus := registro.PalavraLexMaximus;
    varMensagem := registro.Mensagem;

  except
    on ex : Exception do
      begin
        varMensagem := ex.Message;
        Result := False;

      end;

  end;
end;

function TRul_PalavraLexMaximus.ValidateUpdate() : Boolean;

var
  registro  : TCls_PalavraLexMaximus;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_PalavraLexMaximus.Create();

    registro.PalavraLexMaximus      := varPalavraLexMaximus;
    registro.Nome               := varNome;

    varMensagem := '';

    
    result := registro.Update;

    varMensagem := registro.Mensagem;

  except
    on ex : Exception do
      begin
        varMensagem := ex.Message;
        Result := False;

      end;

  end;
end;

function TRul_PalavraLexMaximus.ValidateDelete() : Boolean;

var
  registro  : TCls_PalavraLexMaximus;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_PalavraLexMaximus.Create();

    registro.PalavraLexMaximus      := varPalavraLexMaximus;
    registro.Nome               := varNome;

    varMensagem := '';

    result := registro.Delete;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_PalavraLexMaximus.Load() : Boolean;

var
  registro  : TCls_PalavraLexMaximus;

begin
  try
    registro  := TCls_PalavraLexMaximus.Create();

    registro.PalavraLexMaximus      := varPalavraLexMaximus;
    registro.Nome := varnome;

    ClearFields;

    if registro.Load() then
      begin
        varPalavraLexMaximus        := registro.PalavraLexMaximus;
        varNome           := registro.Nome;
        varDataInclusao := registro.dataInclusao;

        varMensagem := '';
        Result := True;
      end
    else
      begin
        varMensagem := 'Método load não retornou 1 registro';
        Result := False;
      end;


  finally
  end;
end;

function TRul_PalavraLexMaximus.GetAll() : TSQLDataSet;

var
  registro  : TCls_PalavraLexMaximus;

begin

    registro  := TCls_PalavraLexMaximus.Create();

    registro.PalavraLexMaximus        := varPalavraLexMaximus;
    registro.Nome                 := varNome;


    result := registro.getall();

    self.Mensagem := registro.Mensagem;

end;

function TRul_PalavraLexMaximus.GetAll(DataInicio : String ; DataFim  : String) : TSQLDataSet;

var
  registro  : TCls_PalavraLexMaximus;

begin

    registro  := TCls_PalavraLexMaximus.Create();

    registro.PalavraLexMaximus        := varPalavraLexMaximus;
    registro.Nome                 := varNome;


    result := registro.getall( DataInicio  , DataFim);

    self.Mensagem := registro.Mensagem;

end;

end.

