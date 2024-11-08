unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdTime, IdDayTime;

type
  TFrmPrincipal = class(TForm)
    Label1: TLabel;
    LblHoraServidor: TLabel;
    Label3: TLabel;
    LblHoraLocal: TLabel;
    Btnok: TBitBtn;
    Timer_Local: TTimer;
    Timer_Servidor: TTimer;
    IdDayTime1: TIdDayTime;
    procedure FormCreate(Sender: TObject);
    procedure Timer_ServidorTimer(Sender: TObject);
    procedure Timer_LocalTimer(Sender: TObject);
    procedure BtnokClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnokClick(Sender: TObject);
begin
self.close();

end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin

  //IdDayTime1.Connect();

end;

procedure TFrmPrincipal.Timer_LocalTimer(Sender: TObject);
begin
  LblHoraLocal.Caption := FormatDateTime('dd/mm/yyyy hh:mm:ss' , now );
end;

procedure TFrmPrincipal.Timer_ServidorTimer(Sender: TObject);
var
datahora : String;
begin


  IdDayTime1.Connect;
  datahora := IdDayTime1.DayTimeStr;
  LblHoraServidor.Caption := datahora ; //FormatDateTime('dd/mm/yyyy hh:mm:ss' , datahora);
  IdDayTime1.Disconnect
  
end;

end.
