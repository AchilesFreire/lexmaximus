unit Rul_Lei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ToolWin, ADODB,
  cls_Lei;

Type
  TRul_Lei = class(TObject)
    private
      varLei       : integer;
      varNome      : String;
      varAno       : String;
      varLink      : String;
      varTipoLei   : integer;
      varPublicacao : String;
      varEmenta     : String;
      varNumeroLei  : String;
      varTipoDocumento : String;

      varMensagem  : string;

      varConexao              : TADOConnection;
      varNovoRegistro         : Boolean;

    protected

    public

      constructor Create() ; overload;
      constructor Create(ParLei : integer) ; overload;
      constructor create (ParConexao : TADOConnection;  ParLei : integer) ; overload;

      procedure ClearFields();

      Property Lei          : integer   read varLei           write varLei;
      Property Nome         : String    read varNome          write varNome;
      Property Ano          : String    read varAno           write varAno;
      Property Link         : String    read varLink          write varLink;
      Property TipoLei      : integer   read varTipoLei       write varTipoLei;
      Property Publicacao   : String    read varPublicacao    write varPublicacao;
      Property Ementa       : String    read varEmenta        write varEmenta;
      Property NumeroLei       : String    read varNumeroLei        write varNumeroLei;
      Property TipoDocumento   : String    read varTipoDocumento        write varTipoDocumento;

      property Mensagem             : string            read varMensagem              Write varMensagem;
      property Conexao              : TADOConnection    read varConexao               Write varConexao;
      property NovoRegistro         : Boolean           read varNovoRegistro          Write varNovoRegistro;

      function Validate()       : Boolean;
      function ValidateInsert() : Boolean;
      function ValidateUpdate() : Boolean;
      function ValidateDelete() : Boolean;

      Function Load() : Boolean;
      function GetAll() : TADODataSet;

      function RetornaLeiPeloNumero(Numero : Integer; TipoLei : Integer) : TADODataSet;
      function RetornaLeiPeloTipoLei(TiposLeiSelecionados :String ; CondicaoSubNodes : String ; CondicaoLei : String) : TADODataSet;

    end;

implementation

constructor TRul_Lei.create ();
begin

  ClearFields();

end;

constructor TRul_Lei.create (ParLei : integer);
begin
  try

    ClearFields();

    varLei      := ParLei;

  finally
  end;
end;

constructor TRul_Lei.create (ParConexao : TADOConnection;  ParLei : integer);
begin
  try

    ClearFields();

    varLei      := ParLei;
    varConexao      := ParConexao;
    
    if varLei <> -1 then
      varNovoRegistro := (Not Self.Load() );

  finally
  end;
end;

procedure TRul_Lei.ClearFields();
begin

  varLei              := -1;
  varNome             := '';
  varAno              := '';
  varLink             := '';
  varTipoLei          := -1;
  varPublicacao       := '';
  varEmenta           := '';
  varNumeroLei        := '';
  varTipoDocumento    := '';

  varMensagem     := '';

  varNovoRegistro         := False;
  
end;

function TRul_Lei.Validate() : Boolean;
begin
  try

    varMensagem := '';

    //if varLei = -1         then  varMensagem := 'Campo Lei precisa ser preenchido';
    //if trim(varNome) = ''         	then  varMensagem := 'Campo Nome precisa ser preenchido';
    //if trim(varDescricao) = ''        then  varMensagem := 'Campo Descricao precisa ser preenchido';

    Result := (VarMensagem = '');

  finally
  end;
end;

function TRul_Lei.ValidateInsert() : Boolean;

var
  registro  : TCls_Lei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_Lei.Create();

    registro.Lei        := varLei;
    registro.Nome       := varNome;
    registro.Ano        := varAno;
    registro.Link       := varLink;
    registro.TipoLei    := varTipoLei;
    registro.Publicacao := varPublicacao;
    registro.Ementa     := varEmenta;
    registro.NumeroLei  := varNumeroLei;
    registro.TipoDocumento    := varTipoDocumento;

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

function TRul_Lei.ValidateUpdate() : Boolean;

var
  registro  : TCls_Lei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_Lei.Create();

    registro.Lei        := varLei;
    registro.Nome       := varNome;
    registro.Ano        := varAno;
    registro.Link       := varLink;
    registro.TipoLei    := varTipoLei;
    registro.Publicacao := varPublicacao;
    registro.Ementa     := varEmenta;
    registro.NumeroLei  := varNumeroLei;
    registro.TipoDocumento    := varTipoDocumento;

    varMensagem := '';

    registro.Conexao := varConexao;
    
    result := registro.Update;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_Lei.ValidateDelete() : Boolean;

var
  registro  : TCls_Lei;

begin
  try

    Result := False;

    if not Validate() then
      exit;

    registro  := TCls_Lei.Create();

    registro.Lei        := varLei;
    registro.Nome       := varNome;
    registro.Ano        := varAno;
    registro.Link       := varLink;
    registro.TipoLei    := varTipoLei;
    registro.Publicacao := varPublicacao;
    registro.Ementa     := varEmenta;
    registro.NumeroLei  := varNumeroLei;
    registro.TipoDocumento    := varTipoDocumento;

    varMensagem := '';

    registro.Conexao := varConexao;

    result := registro.Delete;

    varMensagem := registro.Mensagem;

  except
    varMensagem := 'erro alterando';
    Result := False;

  end;
end;

function TRul_Lei.Load() : Boolean;

var
  registro  : TCls_Lei;

begin
  try
    registro  := TCls_Lei.Create();

    registro.Conexao := varConexao;

    registro.Lei      := varLei;

    ClearFields;

    if registro.Load() then
      begin
        varLei          := registro.Lei;
        varNome         := registro.Nome;
        varAno          := registro.Ano;
        varLink         := registro.Link;
        varTipoLei      := registro.TipoLei;
        varPublicacao   := registro.Publicacao;
        varEmenta       := registro.Ementa;
        varTipoDocumento    := registro.TipoDocumento;
        varNumeroLei    := registro.NumeroLei;

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

function TRul_Lei.GetAll() : TADODataSet;

var
  registro  : TCls_Lei;


begin

    registro  := TCls_Lei.Create();
    
    registro.Conexao := varConexao;

    registro.Lei        := varLei;
    registro.Nome       := varNome;
    registro.Ano        := varAno;
    registro.Link       := varLink;
    registro.TipoLei    := varTipoLei;
    registro.Publicacao := varPublicacao;
    registro.Ementa     := varEmenta;
    registro.NumeroLei  := varNumeroLei;
    registro.TipoDocumento    := varTipoDocumento;

    result := registro.getall();

    self.Mensagem := registro.Mensagem;

end;

function TRul_Lei.RetornaLeiPeloNumero(Numero : Integer; TipoLei : Integer) : TADODataSet;
var
  registro  : TCls_Lei;
begin

    registro  := TCls_Lei.Create();
    registro.Conexao := varConexao;


    result := registro.RetornaLeiPeloNumero(Numero, TipoLei);

    self.Mensagem := registro.Mensagem;
end;


 function TRul_Lei.RetornaLeiPeloTipoLei(TiposLeiSelecionados :String ; CondicaoSubNodes : String ; CondicaoLei : String) : TADODataSet;
var
  registro  : TCls_Lei;
begin

    registro  := TCls_Lei.Create();
    registro.Conexao := varConexao;

    result := registro.RetornaLeiPeloTipoLei(TiposLeiSelecionados , CondicaoSubNodes , CondicaoLei);

    self.Mensagem := registro.Mensagem;
end;

end.

