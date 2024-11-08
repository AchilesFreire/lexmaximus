unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ShellAPI;

type
  TFrmPrincipal = class(TForm)
    Image1: TImage;
    Image2: TImage;
    BtnExecutar: TButton;
    BtnInstalar: TButton;
    Button3: TButton;
    procedure BtnInstalarClick(Sender: TObject);
    procedure BtnExecutarClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnExecutarClick(Sender: TObject);
var
  Diretorio : String;
  Arquivo : String;
begin

  Diretorio  := ExtractFilePath( Application.exename);
  Arquivo := Diretorio + 'LexMaximus.exe';
  
    if FileExists(Arquivo) then
      ShellExecute (  Self.Handle, '', PAnsiChar( Arquivo),  '', PAnsiChar( Diretorio ), 1)
    else
      begin
        MessageBox(Self.Handle, 'O Lexmaximus não foi encontrado' , 'LexMaximus' , MB_OK or MB_ICONERROR);
      end;

end;

procedure TFrmPrincipal.BtnInstalarClick(Sender: TObject);
var
  Diretorio : String;
  Arquivo : String;

  begin
  
  Diretorio  := ExtractFilePath( Application.exename);
  Arquivo := Diretorio + 'Instalar.exe';
  
    if FileExists(Arquivo) then
      ShellExecute (  Self.Handle, '', PAnsiChar( Arquivo),  '', PAnsiChar( Diretorio ), 1)
    else
      begin
        MessageBox(Self.Handle, 'Arquivo de Instalação não foi encontrado' , 'LexMaximus' , MB_OK or MB_ICONERROR);
      end;
end;

procedure TFrmPrincipal.Button3Click(Sender: TObject);
begin
  self.close();
end;

end.
