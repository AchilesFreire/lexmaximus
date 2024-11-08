unit Funcoes;


interface

uses
  Forms, Classes, SysUtils, StrUtils, URLMon, ShellApi, Windows, WinInet, ClipBrd;

procedure Split (const Delimiter: Char; Input: string;  const Strings: TStrings) ;
function isDate ( const DateString: string ): boolean;
function isNUmeric(const s: string): boolean;
function DifHora(Inicio,Fim : String):String;
function DateTimeDiff(Start, Stop : TDateTime) : int64;
function InicialMaiusculo (Palavra : String) : String;
function LeftPad(S: string; Ch: Char; Len: Integer): string;
function RightPad(S: string; Ch: Char; Len: Integer): string;
function DownloadArquivo(const Origem, Destino: String): Boolean;

implementation

procedure Split (const Delimiter: Char; Input: string;  const Strings: TStrings) ;
begin
  try
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
   Assert(Assigned(Strings)) ;
  finally

  end;

end;

function LeftPad(S: string; Ch: Char; Len: Integer): string;
var
  RestLen: Integer;
begin
  Result  := S;
  RestLen := Len - Length(s);
  if RestLen < 1 then Exit;
  Result := S + StringOfChar(Ch, RestLen);
end;

function RightPad(S: string; Ch: Char; Len: Integer): string;
var
  RestLen: Integer;
begin
  Result  := S;
  RestLen := Len - Length(s);
  if RestLen < 1 then Exit;
  Result := StringOfChar(Ch, RestLen) + S;
end;


function isDate ( const DateString: string ): boolean;
begin
  try
    StrToDate ( DateString );
    result := true;
  except
    result := false;
  end;
end;

function isNUmeric(const s: string): boolean;
var
 i: integer;
begin

  if trim(s) = ''  then
    Result := False
  else
    begin
      Result := True;
      for i:=1 to length(s) do
        if (s[i]<>'0') and (s[i]<>'1') and (s[i]<>'2') and (s[i]<>'3') and (s[i]<>'4') and (s[i]<>'5') and (s[i]<>'6') and (s[i]<>'7') and (s[i]<>'8') and (s[i]<>'9') then
          begin
            Result := False;
            Break;  //Exit ?
          end;
    end;
end;

function DifHora(Inicio,Fim : String):String;
var
  FIni,FFim : TDateTime;

begin
  Fini := StrTotime(Inicio);
  FFim := StrToTime(Fim);
  If (Inicio > Fim) then
    begin
      Result := TimeToStr((StrTotime('23:59:59')-Fini)+FFim)
    end
  else
    begin
     Result := TimeToStr(FFim-Fini);
    end;
end;

function DateTimeDiff(Start, Stop : TDateTime) : int64;
var
  TimeStamp : TTimeStamp;
begin

  result := Round((Stop-Start)*24.0*60.0*60.0)

end;

function InicialMaiusculo (Palavra : String) : String;
begin

  // Retorna a primeira em maiusculo , e as demais em minusculo
  result := AnsiUpperCase( Copy(Palavra,1,1) ) +  AnsiLowerCase( Copy(Palavra,2) );

end;

function DownloadArquivo(const Origem, Destino: String): Boolean;
const BufferSize = 1024;
var 
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte; 
  BufferLen: DWORD;
  f: File; 
  sAppName: string; 
begin 
 Result   := False; 
 sAppName := ExtractFileName(Application.ExeName);
 hSession := InternetOpen(PChar(sAppName), 
                INTERNET_OPEN_TYPE_PRECONFIG, 
               nil, nil, 0); 
 try 
  hURL := InternetOpenURL(hSession, PChar(Origem), nil,0,0,0); 
  try 
   AssignFile(f, Destino); 
   Rewrite(f,1); 
   repeat 
    InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen); 
    BlockWrite(f, Buffer, BufferLen) 
   until BufferLen = 0; 
   CloseFile(f); 
   Result:=True; 
  finally 
   InternetCloseHandle(hURL) 
  end 
 finally 
  InternetCloseHandle(hSession) 
 end 
end;

end.
