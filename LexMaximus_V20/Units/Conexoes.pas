unit Conexoes;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DB, SqlExpr;

type
  TDMConexoes = class(TDataModule)
    Conexao: TSQLConnection;
    SQLQuery_InsertTextoLei: TSQLQuery;
    SQLQuery_Insert_OcorrenciaLei: TSQLQuery;
  private
    { Private declarations }
    _Mensagem : String;
  public
    { Public declarations }
    property Mensagem:           String           read _Mensagem           write _Mensagem;

    procedure AbreConexao();

    Function AbreDataSet( Query : String) : TSQLQuery ;

  end;

var
  DMConexoes: TDMConexoes;

implementation

procedure TDMConexoes.AbreConexao();
//var
//  Arquivo : String;
begin
  (*********************************
  try
    Arquivo := GetcurrentDir + '\dados\ENCICLOPEDIA.GDB';

    if FileExists(Arquivo) then
      begin
          Conexao.Params.Add('User_Name=SYSDBA');
          Conexao.Params.Add('Password=masterkey');
          Conexao.Params.Add('Database=' + Arquivo);
          Conexao.Connected := True;
      end
    else
      _mensagem := 'Arquivo "'  + Arquivo +'" não encontrado: ' + Arquivo;

  except
    on ex : Exception do
      begin
        _Mensagem :=  ex.Message;
      end;
  end;
  *********************************)

end;


Function TDMConexoes.AbreDataSet( Query : String) : TSQLQuery ;
var
  Rcd : TSQLQuery;
begin
    try

    Rcd := TSQLQuery.Create( nil );
    Rcd.SQLConnection := Conexao;
    Rcd.sql.Text := Query;

    rcd.Open;

    result := rcd;

    except
      On Ex: Exception do
        begin
          _Mensagem := ex.Message;
          result := nil;

        end;
    end;
end;


{$R *.dfm}

end.
