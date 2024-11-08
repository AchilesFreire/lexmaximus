unit Global;


interface

uses Classes, strUtils, SysUtils, StdCtrls, Controls, ADODB, windows;

procedure Split (const Delimiter: Char; Input: string;  const Strings: TStrings) ;
function LeftPad(S: string; Ch: Char; Len: Integer): string;
function RightPad(S: string; Ch: Char; Len: Integer): string;
function isDate ( const DateString: string ): boolean;
function isNUmeric(const s: string): boolean;
function Alfabetico(const s: string): boolean;

function DifHora(Inicio,Fim : String):String;
procedure CarregaComboBox( rcd : TADODataSet; cbo : TCombobox ; var ListaCodigos : TStringList );
Function Matchstrings(Source, pattern: string): Boolean;

procedure PostKeyEx32(key: Word; const shift: TShiftState; specialkey: Boolean) ;


function limpa_caracteres(texto: string): string;
function extractnonhtml(texto: string): string;
function DateTimeDiff(Start, Stop : TDateTime) : int64;

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

function Alfabetico(const s: string): boolean;
var
 i: integer;
 Q: integer;
 t : String;
 Letras : String;
begin

  Letras := 'ABCEDFGHIJKLMNOPQRSTUVWXYZ�������������������' ;
  
  if trim(s) = ''  then
    Result := False
  else
    begin
      Result := True;
      Q := length(s);

      for i:=1 to Q do
        t := AnsiUpperCase(s[i]);
        if Not AnsiContainsText (  Letras , t  ) then
          begin
            Result := False;
            exit;
          end;
    end;
    
end;

function DifHora(Inicio,Fim : String):String;
{Retorna a diferen�a entre duas horas}
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

procedure CarregaComboBox( rcd : TADODataSet; cbo : TCombobox ; var ListaCodigos : TStringList );
begin
  try

    ListaCodigos := TStringList.Create;

    while not rcd.Recordset.Eof do
      begin
        cbo.Items.Add(rcd.Fields[1].Value);

        ListaCodigos.Add ( IntToStr( rcd.Fields[0].Value ) );

        rcd.Next;
      end;

  except

  end;

end;

function Matchstrings(Source, pattern: string): Boolean;
var
  pSource: array [0..255] of Char;
  pPattern: array [0..255] of Char;

  function MatchPattern(element, pattern: PChar): Boolean;

    function IsPatternWild(pattern: PChar): Boolean;
    var
      t: Integer;
    begin
      Result := StrScan(pattern, '*') <> nil;
      if not Result then Result := StrScan(pattern, '?') <> nil;
    end;
  begin
    if 0 = StrComp(pattern, '*') then
      Result := True
    else if (element^ = Chr(0)) and (pattern^ <> Chr(0)) then
      Result := False
    else if element^ = Chr(0) then
      Result := True
    else 
    begin
      case pattern^ of
        '*': if MatchPattern(element, @pattern[1]) then
            Result := True
          else
            Result := MatchPattern(@element[1], pattern);
          '?': Result := MatchPattern(@element[1], @pattern[1]);
        else
          if element^ = pattern^ then
            Result := MatchPattern(@element[1], @pattern[1])
          else
            Result := False;
      end;
    end;
  end;
begin
  StrPCopy(pSource,   copy(  Source  , 1 , 255));

  StrPCopy(pPattern,  copy(  pattern , 1 , 255));
  
  Result := MatchPattern(pSource, pPattern);
end;

procedure PostKeyEx32(key: Word; const shift: TShiftState; specialkey: Boolean) ;
{ 
Parameters : 
* key : virtual keycode of the key to send. For printable keys this is simply the ANSI code (Ord(character)) . 
* shift : state of the modifier keys. This is a set, so you can set several of these keys (shift, control, alt, mouse buttons) in tandem. The TShiftState type is declared in the Classes Unit. 
* specialkey: normally this should be False. Set it to True to specify a key on the numeric keypad, for example. 

Description: 
Uses keybd_event to manufacture a series of key events matching the passed parameters. The events go to the control with focus. Note that for characters key is always the upper-case version of the character. Sending without any modifier keys will result in a lower-case character, sending it with [ ssShift ] will result in an upper-case character! 
} 
type
   TShiftKeyInfo = record
     shift: Byte ;
     vkey: Byte ;
   end;
   ByteSet = set of 0..7 ;
const
   shiftkeys: array [1..3] of TShiftKeyInfo =
     ((shift: Ord(ssCtrl) ; vkey: VK_CONTROL),
     (shift: Ord(ssShift) ; vkey: VK_SHIFT),
     (shift: Ord(ssAlt) ; vkey: VK_MENU)) ;
var
   flag: DWORD;
   bShift: ByteSet absolute shift;
   j: Integer;
begin

   for j := 1 to 3 do
   begin
     if shiftkeys[j].shift in bShift then
       keybd_event(shiftkeys[j].vkey, MapVirtualKey(shiftkeys[j].vkey, 0), 0, 0) ;
   end;
   if specialkey then
     flag := KEYEVENTF_EXTENDEDKEY
   else
     flag := 0;

   keybd_event(key, MapvirtualKey(key, 0), flag, 0) ;
   flag := flag or KEYEVENTF_KEYUP;
   keybd_event(key, MapvirtualKey(key, 0), flag, 0) ;

   for j := 3 downto 1 do
   begin
     if shiftkeys[j].shift in bShift then
       keybd_event(shiftkeys[j].vkey, MapVirtualKey(shiftkeys[j].vkey, 0), KEYEVENTF_KEYUP, 0) ;
   end;
   
end;


function limpa_caracteres(texto: string): string;
begin
  texto:= StringReplace(texto, '&amp;','&', [rfReplaceAll]);
  texto:= StringReplace(texto, '&frasl;','/', [rfReplaceAll]);
  texto:= StringReplace(texto, '&lt;','<', [rfReplaceAll]);
  texto:= StringReplace(texto, '&gt;','>', [rfReplaceAll]);
  texto:= StringReplace(texto, '&nbsp;','', [rfReplaceAll]);
  texto:= StringReplace(texto, '&iexcl;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&cent;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&pound;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&curren;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&yen;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&brvbar;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&sect;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&uml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&copy;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ordf;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&laquo;','"', [rfReplaceAll]);
  texto:= StringReplace(texto, '&not;','', [rfReplaceAll]);
  texto:= StringReplace(texto, '&shy;','', [rfReplaceAll]);
  texto:= StringReplace(texto, '&reg;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&macr;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&deg;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&plusmn','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&sup2;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&sup3;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&acute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&micro;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&para;','', [rfReplaceAll]);
  texto:= StringReplace(texto, '&middot;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&cedil;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&sup1;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ordm;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&raquo;','"', [rfReplaceAll]);
  texto:= StringReplace(texto, '&frac14;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&frac12;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&frac34;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&iquest;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Agrave;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Aacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Acirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Atilde;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Auml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Aring;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&AElig;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Ccedil;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Egrave;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Eacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Ecirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Euml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Igrave;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Iacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Icirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Iuml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ETH;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Ntilde;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Ograve;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Oacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Ocirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Otilde;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Ouml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&times;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Oslash;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Ugrave;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Uacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Ucirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Uuml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&Yacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&THORN;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&szlig;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&agrave;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&aacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&acirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&atilde;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&auml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&aring;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&aelig;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ccedil;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&egrave;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&eacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ecirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&euml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&igrave;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&iacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&icirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&iuml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&eth;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ntilde;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ograve;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&oacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ocirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&otilde;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ouml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&divide;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&oslash;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ugrave;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&uacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ucirc;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&uuml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&yacute;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&thorn;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&yuml;','�', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ndash;',' ', [rfReplaceAll]);
  texto:= StringReplace(texto, '&ndash',' ', [rfReplaceAll]);
  texto:= StringReplace(texto, #13#10#13#10,#13, [rfReplaceAll]);
  texto:= StringReplace(texto, #13#10#13#10#13#10,#13#13, [rfReplaceAll]);
  texto:=stringreplace(texto,'AgRg no','',[rfreplaceall]);
  result:= texto;
end;


function extractnonhtml(texto: string): string;
var
Retorno : String;
begin
        Retorno := texto;
        Retorno:= StringReplace(Retorno, '<HTML>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '<BODY BGCOLOR=''#B0B0FF''>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '<Font face=''Tahoma'' Size=''3px''>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '<center>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '</center>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '<b>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '</b>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '<br>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '<p Align=''Jusfity''>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '</p>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '<Font face=''Tahoma'' Size=''3px'' color=''#0000ff'' >','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '</Font>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '<hr align=''center'' width=''99%'' color=''black''>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '</BODY>','', [rfReplaceAll,rfIgnoreCase]);
        Retorno:= StringReplace(Retorno, '</HTML>','', [rfReplaceAll,rfIgnoreCase]);

        result := retorno;

end;

function DateTimeDiff(Start, Stop : TDateTime) : int64; 
var TimeStamp : TTimeStamp; 
begin
  (*
  TimeStamp := DateTimeToTimeStamp(Stop - Start);
  Dec(TimeStamp.Date, TTimeStamp(DateTimeToTimeStamp(0)).Date);
  Result := (TimeStamp.Date*24*60*60)+(TimeStamp.Time div 1000);
  *)
  
  result := Round((Stop-Start)*24.0*60.0*60.0)

end;



end.
