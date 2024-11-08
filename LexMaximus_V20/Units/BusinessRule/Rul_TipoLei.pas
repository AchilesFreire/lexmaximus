unit Rul_TipoLei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, ADODB,
  cls_TipoLei;

Type
  TRul_TipoLei = class(TObject)
    private
      varTipoLei      : integer;
      varNome         : string;

      varMensagem     : string;
      varNovoRegistro : Boolean;

      varConexao      : TADOConnection;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParTipoLei : integer) ; overload;
      constructor create (ParConexao : TADOConnection;  ParTipoLei : integer) ; overload;

      procedure ClearFields();

      Property TipoLei       : integer         read varTipoLei        write varTipoLei;
      Property Nome                   : String          read varNome                    write varNome;

      property Mensagem     : string          read varMensagem     Write varMensagem;

      property NovoRegistro : Boolean         read varNovoRegistro Write varNovoRegistro;

      property Conexao      : TADOConnection  read varConexao     Write varConexao;

      function Validate()       : Boolean;
      function ValidateInsert() : Boolean;
      function ValidateUpdate() : Boolean;
      function ValidateDelete() : Boolean;

      Function Load() : Boolean;
      function GetAll() : TADODataSet; overload;

      function RetornaAnos() : TADODataSet;

    end;

implementation

constructor TRul_TipoLei.create ();
begin

  ClearFields();

end;

constructor TRul_TipoLei.create (ParTipoLei : integer);
begin
  try

    ClearFields();

    varTipoLei      := ParTipoLei;

  finally
  end;
end;

constructor TRul_TipoLei.create (ParConexao : TADOConnection;  ParTipoLei : integer);
begin
  try

    ClearFields();

    varTipoLei      := ParTipoLei;
    varConexao      := ParConexao;

    varNovoRegistro := (Not Self.Load() );

  finally
  end;
end;

procedure TRul_TipoLei.ClearFields();
begin
  varTipoLei      := -1;
  varNome         := '';

  varMensagem     := '';

  varNovoRegistro := False;
  
end;

function TRul_TipoLei.Validate() : Boolean;
begin
  try

    varMensagem := '';

    //if varTipoLei = -1         then  varMensagem := 'Campo TipoLei precisa ser preenchido';
    //if trim(varNome) = ''         	then  varMensagem := 'Campo Nome precisa ser preenchido';
    //if trim(varDescricao) = ''        then  varMensagem := 'Campo Descricao precisa ser preenchido';

    Result := (VarMensagem = '');

  finally
  end;
end;

function TRul_TipoLei.ValidateInsert() : Boolean;

var
  registro  : TCls_TipoLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_TipoLei.Create();

    registro.TipoLei      := varTipoLei;
    registro.Nome         := varNome;

    varMensagem := '';

    registro.Conexao := varConexao;

    result := registro.Insert;

    varMensagem := registro.Mensagem;

  except
    on ex : Exception do
      begin
        varMensagem := ex.Message;
        Result := False;

      end;

  end;
end;

function TRul_TipoLei.ValidateUpdate() : Boolean;

var
  registro  : TCls_TipoLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_TipoLei.Create();

    registro.TipoLei      := varTipoLei;
    registro.Nome               := varNome;

    varMensagem := '';

    registro.Conexao := varConexao;
    
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

function TRul_TipoLei.ValidateDelete() : Boolean;

var
  registro  : TCls_TipoLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_TipoLei.Create();

    registro.TipoLei      := varTipoLei;
    registro.Nome               := varNome;

    varMensagem := '';

    registro.Conexao := varConexao;

    result := registro.Delete;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_TipoLei.Load() : Boolean;

var
  registro  : TCls_TipoLei;

begin
  try
    registro  := TCls_TipoLei.Create();

    registro.Conexao := varConexao;

    registro.TipoLei      := varTipoLei;

    ClearFields;

    if registro.Load() then
      begin
        varTipoLei        := registro.TipoLei;
        varNome           := registro.Nome;

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

function TRul_TipoLei.GetAll() : TADODataSet;

var
  registro  : TCls_TipoLei;


begin

    registro  := TCls_TipoLei.Create();
    registro.Conexao := varConexao;

    registro.TipoLei        := varTipoLei;
    registro.Nome                 := varNome;

    result := registro.getall();

    self.Mensagem := registro.Mensagem;

end;

function TRul_TipoLei.RetornaAnos() : TADODataSet;

var
  registro  : TCls_TipoLei;

begin

    registro  := TCls_TipoLei.Create();
    registro.Conexao := varConexao;

    registro.TipoLei        := varTipoLei;
    registro.Nome                 := varNome;

    result := registro.RetornaAnos();

    self.Mensagem := registro.Mensagem;

end;


end.

