unit Rul_OcorrenciaLei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, Conexoes,
  DBXpress, DB, SqlExpr,
  Cls_OcorrenciaLei;

Type
  TRul_OcorrenciaLei = class(TObject)
    private
      varLei       : integer;
      varPalavras_Ementa      : String;
      varPalavras_Texto       : String;

      varMensagem  : string;

      varNovoRegistro         : Boolean;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParLei : integer) ; overload;
      constructor Create(ParLei : integer ; ArquivoEmenta : String  ; ArquivoTexto : String) ; overload;

      procedure ClearFields();

      Property Lei          : integer   read varLei           write varLei;
      Property Palavras_Ementa         : String    read varPalavras_Ementa          write varPalavras_Ementa;
      Property Palavras_Texto          : String    read varPalavras_Texto           write varPalavras_Texto;

      property Mensagem             : string            read varMensagem              Write varMensagem;
      property NovoRegistro         : Boolean           read varNovoRegistro          Write varNovoRegistro;

      function Validate()       : Boolean;
      function ValidateInsert() : Boolean; overload;
      function ValidateInsert(ArqEmenta : String; ArqTexto : String) : Boolean; overload;
      function ValidateUpdate() : Boolean;
      function ValidateDelete() : Boolean;

      Function Load() : Boolean; overload;
      function Load(ArquivoEmenta : String  ; ArquivoTexto : String  ) : Boolean; overload;
      function GetAll() : TSQLDataSet;

    end;

implementation

constructor TRul_OcorrenciaLei.create ();
begin

  ClearFields();

end;

constructor TRul_OcorrenciaLei.create (ParLei : integer);
begin
  try

    ClearFields();

    varLei      := ParLei;

    if varLei <> -1 then
      varNovoRegistro := (Not Self.Load() );

  finally
  end;
end;

constructor TRul_OcorrenciaLei.Create(ParLei : integer ; ArquivoEmenta : String  ; ArquivoTexto : String) ;
 begin
  try

    ClearFields();

    varLei      := ParLei;

    if varLei <> -1 then
      varNovoRegistro := (Not Self.Load(ArquivoEmenta , ArquivoTexto) );

  finally
  end;
end;

procedure TRul_OcorrenciaLei.ClearFields();
begin

  varLei        := -1;
  varPalavras_Ementa       := '';
  varPalavras_Texto        := '';

  varMensagem     := '';

  varNovoRegistro         := False;
  
end;

function TRul_OcorrenciaLei.Validate() : Boolean;
begin
  try

    varMensagem := '';

    //if varLei = -1         then  varMensagem := 'Campo Lei precisa ser preenchido';
    //if trim(varPalavras_Ementa) = ''         	then  varMensagem := 'Campo Palavras_Ementa precisa ser preenchido';
    //if trim(varDescricao) = ''        then  varMensagem := 'Campo Descricao precisa ser preenchido';

    Result := (VarMensagem = '');

  finally
  end;
end;

function TRul_OcorrenciaLei.ValidateInsert() : Boolean;

var
  registro  : TCls_OcorrenciaLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_OcorrenciaLei.Create();

    registro.Lei        := varLei;
    registro.Palavras_Ementa       := varPalavras_Ementa;
    registro.Palavras_Texto        := varPalavras_Texto;

    varMensagem := '';

    result := registro.Insert;

    varLei := registro.Lei;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro incluindo';
    Result := False;

  end;
end;


function TRul_OcorrenciaLei.ValidateInsert(ArqEmenta : String; ArqTexto : String) : Boolean;

var
  registro  : TCls_OcorrenciaLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_OcorrenciaLei.Create();

    registro.Lei        := varLei;
    registro.Palavras_Ementa       := varPalavras_Ementa;
    registro.Palavras_Texto        := varPalavras_Texto;

    varMensagem := '';

    result := registro.Insert(ArqEmenta, ArqTexto);

    varLei := registro.Lei;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro incluindo';
    Result := False;

  end;
end;


function TRul_OcorrenciaLei.ValidateUpdate() : Boolean;

var
  registro  : TCls_OcorrenciaLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_OcorrenciaLei.Create();

    registro.Lei        := varLei;
    registro.Palavras_Ementa       := varPalavras_Ementa;
    registro.Palavras_Texto        := varPalavras_Texto;

    varMensagem := '';

    result := registro.Update;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_OcorrenciaLei.ValidateDelete() : Boolean;

var
  registro  : TCls_OcorrenciaLei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_OcorrenciaLei.Create();

    registro.Lei        := varLei;
    registro.Palavras_Ementa       := varPalavras_Ementa;
    registro.Palavras_Texto        := varPalavras_Texto;

    varMensagem := '';

    result := registro.Delete;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_OcorrenciaLei.Load() : Boolean;

var
  registro  : TCls_OcorrenciaLei;

begin
  try
    registro  := TCls_OcorrenciaLei.Create();

    registro.Lei      := varLei;

    ClearFields;

    if registro.Load() then
      begin
        varLei          := registro.Lei;
        varPalavras_Ementa         := registro.Palavras_Ementa;
        varPalavras_Texto          := registro.Palavras_Texto;

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

function TRul_OcorrenciaLei.Load( ArquivoEmenta : String  ; ArquivoTexto : String ) : Boolean;

var
  registro  : TCls_OcorrenciaLei;

begin
  try
    registro  := TCls_OcorrenciaLei.Create();

    registro.Lei      := varLei;

    ClearFields;

    if registro.Load(ArquivoEmenta , ArquivoTexto) then
      begin
        varLei          := registro.Lei;
        varPalavras_Ementa         := registro.Palavras_Ementa;
        varPalavras_Texto          := registro.Palavras_Texto;

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
function TRul_OcorrenciaLei.GetAll() : TSQLDataSet;

var
  registro  : TCls_OcorrenciaLei;


begin

    registro  := TCls_OcorrenciaLei.Create();

    registro.Lei        := varLei;
    registro.Palavras_Ementa       := varPalavras_Ementa;
    registro.Palavras_Texto        := varPalavras_Texto;
    
    result := registro.getall();

    self.Mensagem := registro.Mensagem;

end;




end.

