unit Rul_NotaLei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, ADODB,
  cls_NotaLei;

Type
  TRul_NotaLei = class(TObject)
    private
      varLei      : integer;
      varPosicao    : Integer;
      varNotaLei     : String;
      varTipoNotaLei     : String;

      varMensagem  : string;

      varConexao              : TADOConnection;
      varNovoRegistro         : Boolean;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParLei : integer; ParPosicao : integer) ; overload;
      constructor create (ParConexao : TADOConnection;  ParLei : integer ; ParPosicao : integer) ; overload;

      procedure ClearFields();

      Property Lei          : integer   read varLei           write varLei;
      Property Posicao      : integer   read varPosicao       write varPosicao;
      Property NotaLei      : String    read varNotaLei       write varNotaLei;
      Property TipoNotaLei  : String    read varTipoNotaLei       write varTipoNotaLei;

      property Mensagem             : string            read varMensagem              Write varMensagem;
      property Conexao              : TADOConnection    read varConexao               Write varConexao;
      property NovoRegistro         : Boolean           read varNovoRegistro          Write varNovoRegistro;

      function Validate()       : Boolean;
      function ValidateInsert() : Boolean;
      function ValidateUpdate() : Boolean;
      function ValidateDelete() : Boolean;

      Function Load() : Boolean;
      function GetAll() : TADODataSet;
      function GetAll2() : TADODataSet;
      function GetCount() : integer;

    end;

implementation

constructor TRul_NotaLei.create ();
begin

  ClearFields();

end;

constructor TRul_NotaLei.create (ParLei : integer ; ParPosicao : integer);
begin
  try

    ClearFields();

      varLei      := ParLei;
      varPosicao := parPosicao;

  finally
  end;
end;

constructor TRul_NotaLei.create (ParConexao : TADOConnection;  ParLei : integer ; ParPosicao : integer);
begin
  try

    ClearFields();

    varLei      := ParLei;
    varPosicao := parPosicao;
    
    varConexao      := ParConexao;
    
    if (varLei <> -1) and (varposicao <> -1) then
      varNovoRegistro := (Not Self.Load() );

  finally
  end;
end;

procedure TRul_NotaLei.ClearFields();
begin

  varLei              := -1;
  varPosicao          := -1;
  varNotaLei          := '';
  varTipoNotaLei      := '';

  varMensagem     := '';

  varNovoRegistro         := False;
  
end;

function TRul_NotaLei.Validate() : Boolean;
begin
  try

    varMensagem := '';

    //if varLei = -1         then  varMensagem := 'Campo Lei precisa ser preenchido';
    //if trim(varNotaLei) = ''         	then  varMensagem := 'Campo NotaLei precisa ser preenchido';
    //if trim(varDescricao) = ''        then  varMensagem := 'Campo Descricao precisa ser preenchido';

    Result := (VarMensagem = '');

  finally
  end;
end;

function TRul_NotaLei.ValidateInsert() : Boolean;

var
  registro  : TCls_NotaLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_NotaLei.Create();

    registro.Lei            := varLei;
    registro.Posicao        := varPosicao;
    registro.NotaLei        := varNotaLei;
    registro.TipoNotaLei    := varTipoNotaLei;

    varMensagem := '';

    registro.Conexao := varConexao;

    result := registro.Insert;

    varLei := registro.Lei;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro incluindo';
    Result := False;

  end;
end;

function TRul_NotaLei.ValidateUpdate() : Boolean;

var
  registro  : TCls_NotaLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_NotaLei.Create();

    registro.Lei            := varLei;
    registro.Posicao        := varPosicao;
    registro.NotaLei        := varNotaLei;
    registro.TipoNotaLei    := varTipoNotaLei;

    varMensagem := '';

    registro.Conexao := varConexao;
    
    result := registro.Update;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_NotaLei.ValidateDelete() : Boolean;

var
  registro  : TCls_NotaLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_NotaLei.Create();

    registro.Lei            := varLei;
    registro.Posicao        := varPosicao;
    registro.NotaLei        := varNotaLei;
    registro.TipoNotaLei    := varTipoNotaLei;

    varMensagem := '';

    registro.Conexao := varConexao;

    result := registro.Delete;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_NotaLei.Load() : Boolean;

var
  registro  : TCls_NotaLei;

begin
  try
    registro  := TCls_NotaLei.Create();

    registro.Conexao := varConexao;

    registro.Lei      := varLei;
    registro.posicao := varposicao;

    ClearFields;

    if registro.Load() then
      begin
        varLei            := registro.Lei;
        varPosicao        := registro.Posicao;
        varNotaLei        := registro.NotaLei;
        varTipoNotaLei    := registro.TipoNotaLei;

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

function TRul_NotaLei.GetAll() : TADODataSet;

var
  registro  : TCls_NotaLei;

begin

    registro  := TCls_NotaLei.Create();
    registro.Conexao := varConexao;

    registro.Lei            := varLei;
    registro.Posicao        := varPosicao;
    registro.NotaLei        := varNotaLei;
    registro.TipoNotaLei    := varTipoNotaLei;

    result := registro.getall();

    self.Mensagem := registro.Mensagem;

end;

function TRul_NotaLei.GetAll2() : TADODataSet;

var
  registro  : TCls_NotaLei;

begin

    registro  := TCls_NotaLei.Create();
    registro.Conexao := varConexao;

    registro.Lei            := varLei;
    registro.Posicao        := varPosicao;
    registro.NotaLei        := varNotaLei;
    registro.TipoNotaLei    := varTipoNotaLei;

    result := registro.getall2();

    self.Mensagem := registro.Mensagem;

end;

function TRul_NotaLei.GetCount() : integer;
var
  registro  : TCls_NotaLei;

begin

    registro  := TCls_NotaLei.Create();
    registro.Conexao := varConexao;

    registro.Lei            := varLei;
    registro.Posicao        := varPosicao;
    registro.NotaLei        := varNotaLei;
    registro.TipoNotaLei    := varTipoNotaLei;

    result := registro.GetCount();

    self.Mensagem := registro.Mensagem;

end;

end.

