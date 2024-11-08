unit LimpaRegistro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSkinStore, WinSkinData, ExtCtrls, Registry;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    SkinData1: TSkinData;
    BtnFechar: TButton;
    BtnLimpar: TButton;
    LblMensagem: TLabel;
    CboVersao: TComboBox;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    function RetornaNumeroUtilizacoes() : Integer;
    procedure SalvaUtilizacoes();
  private
    { Private declarations }
    PrimeiraUtilizacao : Boolean;
    NumeroUtilizacoes : Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  Chave = 'LogData';

implementation

{$R *.dfm}

procedure TForm1.BtnFecharClick(Sender: TObject);
begin

  self.Close;

end;

procedure TForm1.BtnLimparClick(Sender: TObject);

Var
  VersaoSistema : String;
  Chave1 : String;
  Chave2 : String;
  Chave3 : String;
  reg1   : TRegistry;
  reg2   : TRegistry;
  reg3   : TRegistry;




begin

  Application.ProcessMessages;
  SalvaUtilizacoes();

  reg1   := TRegistry.Create;
  reg2   := TRegistry.Create;
  reg3   := TRegistry.Create;

  if CboVersao.ItemIndex = -1 then
    begin
      LblMensagem.Caption := 'Selecione a versão';
      exit;
    end;

  VersaoSistema := CboVersao.Items[CboVersao.ItemIndex];

  Chave1 := 'Microsoft.JScript.InternetExplorer';
  Chave2 := 'JavaScript.1.1.DefaultClass';
  Chave3 := 'Software\Classes\DirectXActiveX';

  if Chave1 <> '' then
    begin
      reg1.RootKey := HKEY_CLASSES_ROOT;
      reg1.DeleteKey(Chave1);
    end;

  if Chave2 <> '' then
    begin
      reg2.RootKey := HKEY_CLASSES_ROOT;
      reg2.DeleteKey(Chave2);
    end;

  if Chave3 <> '' then
    begin
      reg3.RootKey := HKEY_LOCAL_MACHINE;
      reg3.DeleteKey(Chave3);
    end;

  LblMensagem.Caption := 'Registros excluidos';

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  valor : String;
begin
  PrimeiraUtilizacao := False;

  NumeroUtilizacoes := -1;
  if ParamCount = 1 then
    begin
      if paramstr(1) = '/*ELFEZ#LexMaximus@2008*unlock#limit@time' then
        begin
          NumeroUtilizacoes := 0 ;
        end;
    end;

  if NumeroUtilizacoes = -1 then
    NumeroUtilizacoes := RetornaNumeroUtilizacoes();

  if NumeroUtilizacoes > 2 then
    begin
      lblMensagem.Caption := 'Voce ja excedeu o número de utilizações deste programa';
      BtnLimpar.Enabled := False;
      BtnLimpar.Visible := false;
    end;

  CboVersao.ItemIndex := 1;

end;

function TForm1.RetornaNumeroUtilizacoes() : Integer;
Var
  reg   : TRegistry;
  resultado  : string;

begin

  try
    reg   := TRegistry.Create();
    reg.RootKey := HKEY_CLASSES_ROOT;
    if reg.OpenKey(Chave, False) then
      begin
        resultado := reg.ReadString('AppInfo' );
        reg.CloseKey;
      end
    else
      resultado := '';


    if resultado = '' Then
      begin
        reg.CreateKey(Chave);
        Application.ProcessMessages;

        if reg.OpenKey(Chave, False) then
          reg.WriteString('AppInfo'  , '0');

        result := 0;

      end
    else
      begin
        try
          result := StrToInt(resultado);
        except
          result := 3;
        end;
      end;
    reg.CloseKey;
    reg.Destroy;
  except
    on ex : Exception do
      begin
        result := 100;
      end;
    end;

end;



procedure TForm1.SalvaUtilizacoes();
Var
  reg   : TRegistry;
  resultado  : integer;
begin
    try
    reg   := TRegistry.Create();

    reg.RootKey := HKEY_CLASSES_ROOT;

    if reg.OpenKey(Chave, False) then
      begin
      
        resultado := StrToInt(  reg.readString('AppInfo' ) ) ;

        reg.WriteString('AppInfo'  , IntToStr( resultado + 1 )  ) ;
        
        reg.CloseKey;
        reg.Destroy;
      end;


    except
    end;

end;
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SalvaUtilizacoes();
end;

end.
