unit cls_Conexao;

interface

uses
    SysUtils, Classes, inifiles, ADODB;

type
 TCls_Conexao = class(TObject)
    private
      varStringConexao    : string;

      varMensagem         : string;
      IndiceErros         : Integer;
    protected
    public
      Conexao             : TADOConnection;
      constructor Create() ; overload;
      destructor Destroy() ; overload;
      Function ExecutaComando(Query : String) : Integer ;
      Function AbreDataSet(Query : String) : TAdoDataSet ;
      function AbreConexao() : TADOConnection;
      property StringConexao    : string          read varStringConexao     Write varStringConexao;
      property Mensagem         : string          read varMensagem     Write varMensagem;
 end;

implementation

constructor TCls_Conexao.Create ();
begin
  try
    IndiceErros := 1;
  finally
  end;
end;

destructor TCls_Conexao.Destroy ();
begin
  //inherited Destroy;

  try



    if Conexao <> nil then
      begin
        conexao.Close;
      end;

    inherited destroy;

  finally
  end;
end;

Function TCls_Conexao.ExecutaComando(Query : String) : Integer ;
var
  retorno : Integer;
  Comando : TStringList;
begin
    try

    self.AbreConexao();

    Conexao.Execute(Query,retorno );
    result := retorno;

    except
      On Ex: Exception do
        begin
          Comando := TStringList.Create;
          Comando.Add( ex.Message );
          Comando.Add( Query );
          Comando.Add( '----------------------' );

          Comando.SaveToFile( GetCurrentDir + '\Logs\Erro-' + FormatDateTime('yyyy-mm-dd hh-mm-ss', now) + '.txt' );
          Inc ( IndiceErros , 1 );

          Comando.Clear;
          Comando.Destroy;

          result := 0;
          self.Mensagem := ex.Message;
        end;
    end;
end;

Function TCls_Conexao.AbreDataSet(Query : String) : TAdoDataSet ;
var
  Rcd : TADODataSet;
begin
    try

    self.AbreConexao;
    
    Rcd := TADODataSet.Create( Conexao );
    Rcd.Connection := Conexao;

    Rcd.CommandText := Query;
    Rcd.CommandType := cmdText;
    Rcd.CursorType := ctStatic;
    rcd.CursorLocation := clUseClient;

    rcd.Open;

    result := rcd;


    except
      On Ex: Exception do
        begin
          result := nil;
          self.Mensagem := ex.Message;
        end;
    end;
end;

function TCls_Conexao.AbreConexao() : TADOConnection;

begin
  try
  Mensagem := '';
  if conexao = nil then
    begin
      Conexao := TADOConnection.Create(nil);

      Conexao.ConnectionString := Self.StringConexao;
      Conexao.LoginPrompt := False;
      Conexao.CommandTimeout := 0;
      Conexao.Open;
    end;

  Result := Conexao;
  
  except
    on ex : Exception do
      begin
          Mensagem := ex.Message;
          result := nil;
      end;

  end;
end;
end.
