unit Rul_TextoLei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin,
  Conexoes, DBXpress, DB, SqlExpr,
  cls_TextoLei,
  Funcoes;

Type
  TRul_TextoLei = class(TObject)
    private
      varLei       : integer;
      varTexto      : String;
      varArquivoComprimido  :String;

      varMensagem  : string;
      varNovoRegistro         : Boolean;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParLei : integer) ; overload;
      constructor Create(ParLei : integer ; NomeArquivo : String) ; overload;

      procedure ClearFields();

      Property Lei          : integer   read varLei           write varLei;
      Property Texto        : String    read varTexto          write varTexto;
      Property ArquivoComprimido                   : String          read varArquivoComprimido                    write varArquivoComprimido;

      property Mensagem             : string            read varMensagem              Write varMensagem;
      property NovoRegistro         : Boolean           read varNovoRegistro          Write varNovoRegistro;

      function Validate()       : Boolean;
      function ValidateInsert() : Boolean;
      function ValidateUpdate() : Boolean;
      function ValidateDelete() : Boolean;

      Function Load() : Boolean; overload;
      Function Load(NomeArquivo : String) : Boolean; overload;
      function GetAll() : TSQLDataSet; overload;
      function GetAll(Condicao : String) : TSQLDataSet; overload;

    end;

implementation

constructor TRul_TextoLei.create ();
begin

  ClearFields();

end;

constructor TRul_TextoLei.create ( ParLei : integer);
begin
  try

    ClearFields();

    varLei      := ParLei;

    if varLei <> -1 then
      varNovoRegistro := (Not Self.Load() );

  finally
  end;
end;


constructor TRul_TextoLei.create ( ParLei : integer ; NomeArquivo : String);
begin
  try

    ClearFields();

    varLei      := ParLei;

    if varLei <> -1 then
      varNovoRegistro := (Not Self.Load(NomeArquivo) );

  finally
  end;
end;

procedure TRul_TextoLei.ClearFields();
begin

  varLei              := -1;
  varTexto             := '';

  varMensagem     := '';

  varNovoRegistro         := False;
  
end;

function TRul_TextoLei.Validate() : Boolean;
begin
  try

    varMensagem := '';

    Result := (VarMensagem = '');

  finally
  end;
end;

function TRul_TextoLei.ValidateInsert() : Boolean;

var
  registro  : TCls_TextoLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_TextoLei.Create();

    registro.Lei        := varLei;
    registro.Texto       := varTexto;
    registro.ArquivoComprimido := varArquivoComprimido;

    varMensagem := '';

    result := registro.Insert;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro incluindo';
    Result := False;

  end;
end;

function TRul_TextoLei.ValidateUpdate() : Boolean;
var
  registro  : TCls_TextoLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_TextoLei.Create();

    registro.Lei        := varLei;
    registro.Texto       := varTexto;
    registro.ArquivoComprimido := varArquivoComprimido;

    varMensagem := '';

    result := registro.Update;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_TextoLei.ValidateDelete() : Boolean;

var
  registro  : TCls_TextoLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_TextoLei.Create();

    registro.Lei      := varLei;

    varMensagem := '';

    result := registro.Delete;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_TextoLei.Load() : Boolean;

var
  registro  : TCls_TextoLei;

begin
  try
    registro  := TCls_TextoLei.Create();

    registro.Lei      := varLei;

    ClearFields;

    if registro.Load() then
      begin
        varLei          := registro.Lei;
        varTexto         := registro.Texto;

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


function TRul_TextoLei.Load(NomeArquivo : String) : Boolean;

var
  registro  : TCls_TextoLei;

begin
  try
    registro  := TCls_TextoLei.Create();

    registro.Lei      := varLei;

    ClearFields;

    if registro.Load(NomeArquivo) then
      begin
        varLei          := registro.Lei;
        varTexto         := registro.Texto;

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



function TRul_TextoLei.GetAll() : TSQLDataSet;

var
  registro  : TCls_TextoLei;

begin

    registro  := TCls_TextoLei.Create();
    registro.Lei        := varLei;
    registro.Texto       := varTexto;

    result := registro.getall();

    self.Mensagem := registro.Mensagem;

end;

function TRul_TextoLei.GetAll(Condicao : String) : TSQLDataSet;

var
  registro  : TCls_TextoLei;


begin

    registro  := TCls_TextoLei.Create();

    registro.Lei        := varLei;
    registro.Texto       := varTexto;

    result := registro.getall(Condicao);

    self.Mensagem := registro.Mensagem;

end;


end.

