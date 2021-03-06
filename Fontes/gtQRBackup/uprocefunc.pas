//=======================================================================
// Programa: UProcEFunc.Pas
// Objetivo: Procedures e Funcoes diversas de uso geral
//=======================================================================

unit UProcEFunc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, DB, DBTables, Menus, Grids, DBGrids, ExtCtrls,
  Buttons, ShellApi, Registry;

Type
  TAlinha = set of (Direita, Esquerda, Centro);
  TFormRef = class of TForm;

{*********************************Constantes}
Const cMES : Array[1..12] of string[9] =
('Janeiro','Fevereiro','Mar�o','Abril','Maio','Junho',
'Julho','Agosto','Setembro','Outubro','Novembro','Dezembro');
      cSemana : Array[1..7] of string[7] =
('Domingo','Segunda','Ter�a','Quarta','Quinta','Sexta','S�bado');
{************************************Fun��es}

Function Limpa( s : string ) : string;
function Extenso( i : LongInt ) : string;
Function Encripta( Texto,Chave : string) : String;
Function DesEncripta( Texto,Chave : string) : String;
Function Separa( s : String; car:Char; i : byte) : String;
Function ContaPal( s : String; car:Char) : Byte;
Function StrToLongInt(s : String;d : LongInt  ) : LongInt;
Function LongIntToStr(d : LongInt ) : String;
Function AcresEspaco(s : String; tam : Byte) : String;
Function Ultimo_Dia_mes( i,ano : Word) : Byte;
Function DataValida(DataEditada: TMaskedit; MSGDataInvalida: pChar): boolean;
Function ValidarCGC(sCGC: String): boolean;
Function ValidarCPF(sCPF: String): boolean;
Function StrZero(Nro: String; Tam: Integer): String;
Function DigitaSoNumero(Key: Char): Char;
Function DigitaSoAlpha(Key: Char): Char;
Function DigitaValor(Key: Char): Char;
Function ValidaEstado(SiglaUF: String): Boolean;
Function StrToValor(sValor: String; NroDec: Integer): Double;
Function EditaValor(Mascara: String ; vValor: Double): String;
Function EditaStr(Mascara: String ; sString: String): String;
Function SendTabBuf(Key: Char): Char;
Function Space(Pos: Integer): String;
Function StrToBuffer(sTexto: String): Boolean;
Function DigitaSoLetra(Key: Char): Char;
Function DigitaSoLetraNum(Key: Char): Char;
Function RemoveNaoNro(Str: String): String;
Function StrVr(dblValor:double):String;
Function AlignStr(Str : String; Tam : Integer; Pos : TAlinha; Carac : Char):String;
Function iif(Condicao:Boolean; retornaTrue, retornaFalse:Variant):Variant;
Function CalculaIdade(dtNasc, dtAtual : Double) : String ;
Function Idade(dtNasc, dtCalc : TDateTime) : ShortInt;
function DoForm(ptrFrm : Pointer; frmRef : TFormref): Boolean;
function GetBuildInfo:string;
function LogUser : String;
function CheckCC(c: string): Integer;
function SerialDiscoHexa : String;
function SerialDiscoInt : Integer;
{*********************************Procedimentos}
Procedure Delay ( i : Word );
procedure Edita_limpar(Formulario: TForm);

implementation


function DoForm(ptrFrm : Pointer; frmRef : TFormref): Boolean;
var
   Form : TForm;
begin
  if ptrFrm = nil then
  begin
     Form := frmRef.Create(Application.MainForm);
     Form.Show;
  end
  else
  begin
    TForm(ptrFrm).Show;
    TForm(ptrFrm).WindowState := wsNormal;
  end;
  Result:=true;
end;

function Idade(dtNasc, dtCalc : TDateTime) : ShortInt;
var nAno, nMes, nDia,
    cAno, cMes, cDia : Word;
    Anos : ShortInt;
begin
  DecodeDate(dtNasc, nAno, nMes, nDia);
  DecodeDate(dtCalc, cAno, cMes, cDia);
  if cAno > nAno then
  begin
    Anos := CAno - nAno;
    if nMes < cMes then
      Result := Anos - 1
    else
      if nMes = cMes then
        if nDia < cDia then
          Result := Anos - 1
        else
          Result := Anos;
  end
  else
    Result := 0;
end;



//============================================================================
// Funcao..: Calcula idade
// Paramet.: dtNasc = Data de nascimento
//           dtAtual = Data limite
// Retorno.: String 'Anos:Meses:Dias' ou vazio
//============================================================================

Function CalculaIdade(dtNasc, dtAtual : Double) : String ;
var
   nAno, nMes, nDia : word;
   aAno, aMes, aDia : word;
   cAno, cMes, cDia, xdia : Integer;
   {dtAux : TDateTime;}
begin
   // verifica dados de entrada
   if ((dtNasc = 0) or (dtAtual = 0)) or (dtNasc > dtAtual) then
   begin
      CalculaIdade := '';
      exit;
   end;

   // Converte DtNasc e DtAtual em anos meses e dias
   DecodeDate(dtNasc, nAno, nMes, nDia);
   DecodeDate(dtAtual, aAno, aMes, aDia);
   cAno := 0;
   cMes := 0;
   cDia := 0;
      
   xDia := nDia;
   while EncodeDate(nAno, nMes, nDia) < dtAtual do 
   begin
      Inc(cAno);
      Inc(nAno);
      nDia := xDia;
      try 
         {dtAux := EncodeDate(nAno, nMes, nDia);}
         EncodeDate(nAno, nMes, nDia);
      except
         Dec(nDia);
      end;
   end;
   Dec(nAno);
   Dec(cAno);
   
   while EncodeDate(nAno, nMes, nDia) < dtAtual do 
   begin
      Inc(cMes);
      Inc(nMes);
      if nMes > 12 then
      begin
         Inc(nAno);
         nMes := 1;
      end;
      nDia := xDia;
      try 
         {dtAux := EncodeDate(nAno, nMes, nDia);}
         EncodeDate(nAno, nMes, nDia);
      except
         Dec(nDia);
         try
            {dtAux := EncodeDate(nAno, nMes, nDia);}
            EncodeDate(nAno, nMes, nDia);
         except
            Dec(nDia);
            try 
               {dtAux := EncodeDate(nAno, nMes, nDia);}
               EncodeDate(nAno, nMes, nDia);
            except
               Dec(nDia);
            end;
         end;
      end;
   end;
   Dec(cMes);
   If nMes = 1 then
     nMes := 12
   else  
     Dec(nMes);
   nDia := xDia;

   if nDia >= aDia then
      cDia := -1;

   while EncodeDate(nAno, nMes, nDia) < dtAtual do
   begin
      Inc(cDia);
      Inc(nDia);
      try 
         {dtNasc := EncodeDate(nAno, nMes, nDia);}
         EncodeDate(nAno, nMes, nDia);
       except
         nDia := 1;
         Inc(nMes);
         if cMes = 12 then
         begin
            nMes := 1;
            Inc(nAno);
         end;
       end;
   end;

   try
      DecodeDate(EncodeDate(cAno, cMes, cDia) +1, aAno, aMes, aDia);
      if aMes <> cMes then
      begin
         Inc(cMes);
         cDia := 0;
         if cMes = 12 then
         begin
            cMes := 0;
            Inc(cAno);
         end;   
      end;
    except
    end;
   
   CalculaIdade := Concat(IntToStr(cAno), ':', IntToStr(cMes), ':', IntToStr(cDia));
end;



//=======================================================================
// Objetivo..: testa campo se data digitada � valida ou nao
// Parametros: DataEditada     = Objeto MaskEdit de Data
//             MSGDataInvalida = Mensagem a ser exibida se data invalida
//                               Se mensage = brancos sera exibida o default
// Retorno...: True = Data Valida  ou  False
Function DataValida(DataEditada: TMaskedit;MSGDataInvalida: pChar): boolean;
begin
     // inicializa funcao
     DataValida := True;

     // testa se data digitada � v�lida ou n�o
     Try
        if Length(DataEditada.Text) = 8 then
           DataEditada.Text := FormatDateTime('dd/mm/yy', StrToDate(DataEditada.Text))
        else
           DataEditada.Text := FormatDateTime('dd/mm/yyyy', StrToDate(DataEditada.Text));
     Except
           On EConvertError Do
              begin
                   if  MSGDataInvalida = '' then
                       // mostra mensagem default
                       MessageBox(0, 'Data inv�lida!','Valida��o de Data',
                               mb_TaskModal + mb_iconInformation + mb_OK)
                   else
                       // mostra mensagem requerida pelo usuario}
                       MessageBox(0, MSGDataInvalida,'Valida��o de Data',
                              mb_TaskModal + mb_iconInformation + mb_OK);

                   // atualiza funcao
                   DataValida := False;
              end;
     end;

end;


//=======================================================================
// Objetivo..: Testa digito verificador do CGC (modulo 11)
// Parametros: sCGC = String com 14 digitos a ser verificada
// Retorno...: True = Digito CGC ok   ou False
Function ValidarCGC(sCGC: String): boolean;
var
   wRes : Integer; // resto da divisao por 11
begin
     // inicializa funcao
     ValidarCGC := True;

     // Calculo do primeiro digito verificador
     wRes := (StrToInt(Copy(sCgc,01,1)) * 50 +
              StrToInt(Copy(sCgc,02,1)) * 40 +
              StrToInt(Copy(sCgc,03,1)) * 30 +
              StrToInt(Copy(sCgc,04,1)) * 20 +
              StrToInt(Copy(sCgc,05,1)) * 90 +
              StrToInt(Copy(sCgc,06,1)) * 80 +
              StrToInt(Copy(sCgc,07,1)) * 70 +
              StrToInt(Copy(sCgc,08,1)) * 60 +
              StrToInt(Copy(sCgc,09,1)) * 50 +
              StrToInt(Copy(sCgc,10,1)) * 40 +
              StrToInt(Copy(sCgc,11,1)) * 30 +
              StrToInt(Copy(sCgc,12,1)) * 20) mod 11;

     if wRes > 9 then wRes := 0;

     // compara primeiro digito
     if IntToStr(wRes) <> Copy(sCgc,13,1) then
        begin
             // atualiza funcao e retorna
             ValidarCGC := False;
             exit;
        end;

     // Calculo do segundo digito verificador
     wRes := (StrToInt(Copy(sCgc,01,1)) * 60 +
              StrToInt(Copy(sCgc,02,1)) * 50 +
              StrToInt(Copy(sCgc,03,1)) * 40 +
              StrToInt(Copy(sCgc,04,1)) * 30 +
              StrToInt(Copy(sCgc,05,1)) * 20 +
              StrToInt(Copy(sCgc,06,1)) * 90 +
              StrToInt(Copy(sCgc,07,1)) * 80 +
              StrToInt(Copy(sCgc,08,1)) * 70 +
              StrToInt(Copy(sCgc,09,1)) * 60 +
              StrToInt(Copy(sCgc,10,1)) * 50 +
              StrToInt(Copy(sCgc,11,1)) * 40 +
              StrToInt(Copy(sCgc,12,1)) * 30 +
              StrToInt(Copy(sCgc,13,1)) * 20) mod 11;

     if wRes > 9 then wRes := 0;

     // Compara segundo digito
     if IntToStr(wRes) <> Copy(sCGC,14,1) then
        ValidarCGC := False; // atualiza funcao
end;


//=======================================================================
// Objetivo..: Testa digito verificador do CPF (modulo 11)
// Parametros: sCPF = String com 11 digitos a ser verificada
// Retorno...: True = Digito CPF ok   ou False
Function ValidarCPF(sCPF: String): boolean;
var
   wRes : Integer; // resto da divisao por 11
begin
     // inicializa funcao
     ValidarCPF := True;

     // Calculo do primeiro digito verificador
     wRes := (StrToInt(Copy(sCpf,1,1)) * 100 +
              StrToInt(Copy(sCpf,2,1)) * 90 +
              StrToInt(Copy(sCpf,3,1)) * 80 +
              StrToInt(Copy(sCpf,4,1)) * 70 +
              StrToInt(Copy(sCpf,5,1)) * 60 +
              StrToInt(Copy(sCpf,6,1)) * 50 +
              StrToInt(Copy(sCpf,7,1)) * 40 +
              StrToInt(Copy(sCpf,8,1)) * 30 +
              StrToInt(Copy(sCpf,9,1)) * 20) mod 11;

     if wRes > 9 then wRes := 0;

     // compara primeiro digito
     if IntToStr(wRes) <> Copy(sCpf,10,1) then
        begin
             // atualiza funcao e retorna
             ValidarCPF := False;
             exit;
        end;

     // Calculo do segundo digito verificador
     wRes := (StrToInt(Copy(sCpf,1,1)) * 110 +
              StrToInt(Copy(sCpf,2,1)) * 100 +
              StrToInt(Copy(sCpf,3,1)) * 90 +
              StrToInt(Copy(sCpf,4,1)) * 80 +
              StrToInt(Copy(sCpf,5,1)) * 70 +
              StrToInt(Copy(sCpf,6,1)) * 60 +
              StrToInt(Copy(sCpf,7,1)) * 50 +
              StrToInt(Copy(sCpf,8,1)) * 40 +
              StrToInt(Copy(sCpf,9,1)) * 30 +
              StrToInt(Copy(sCpf,10,1)) * 20) mod 11;

     if wRes > 9 then wRes := 0;

     // Compara o segundo digito
     if IntToStr(wRes) <> Copy(sCpf,11,1) then
        ValidarCPF := False; // atualiza funcao

end;

//=======================================================================
// Objetivo..: Preenche com zeros a esquerda do numero
// Parametros: Nro = String com digitos a ser transformada
//             Tam = Tamanho da string de digitos a transformar
// Retorno...: String de digitos transformada
Function StrZero(Nro: String; Tam: Integer): String;
var
   wZeros : String[20];
   wCont  : Integer;
begin
     // Monta string com zeros de tamanho da "Tam"
     wZeros := '';
     for wCont := 1 to tam do
         wZeros := wZeros + '0';

     // concatena zeros com o "Nro" requerido
     Nro := wZeros + Nro;

     // extrai "Tam" posicoes mais a direita e retorna
     StrZero := Copy(Nro, length(Nro) - (Tam - 1), Tam);
end;


//=======================================================================
// Objetivo..: Verifica se tecla pressionada � digito numerico
// Parametros: Key = Valor da tecla pressionada
// Retorno...: Tecla pressionada   ou Tecla nulo se invalida
Function DigitaSoNumero(Key: Char): Char;
begin
     // permite digitar somente numeros
     Case Key of
     '0'..'9', chr(8) :  DigitaSoNumero := Key; // tecla valida
     else
         DigitaSoNumero := Chr(0) // tecla invalida
     end;
end;


//=======================================================================
// Objetivo..: Verifica se tecla pressionada diferente de caracter especial
// Parametros: Key = Valor da tecla pressionada
// Retorno...: Tecla pressionada   ou Tecla nulo se invalida
Function DigitaSoAlpha(Key: Char): Char;
begin
     // permite digitar somente caracter alpha
     case Key of
        'A'..'Z', 'a'..'z', ' '..' ', chr(8): DigitaSoAlpha := key
     else
         DigitaSoAlpha := Chr(0) // tecla invalida
     end;
end;


//=======================================================================
// Objetivo..: Verifica se tecla pressionada � digito numerico
//             ou ponto decimal
// Parametros: Key = Valor da tecla pressionada
// Retorno...: Tecla pressionada   ou Tecla nulo se invalida
Function DigitaValor(Key: Char): Char;
begin
     // permite digitar somente numeros e ponto decimal
     Case Key of
     '0'..'9', ',', chr(8) :  DigitaValor := Key; // tecla valida
     '.' : DigitaValor := ',' ; // troca ponto por virgula decimal
     else
         DigitaValor := Chr(0) // tecla invalida
     end;
end;


//=======================================================================
// Objetivo..: Verifica se sigla de estado valida
// Parametros: SiglaUF = Sigla a ser verificada
// Retorno...: True se valida    ou False
Function ValidaEstado(SiglaUF: String): Boolean;
Const
   UFS : String = 'RS,SC,PR,SP,RJ,ES,GO,MS,MT,BA,SE,AL,MG,'+ // constante
                  'PA,PI,PB,RN,CE,AM,AP,RO,RR,AC,TO,PE,DF,MA';  // de UF�s
var
   X : Integer;  // contador auxiliar
begin
     // inicializa funcao
     ValidaEstado := True;

     // Verifica se sigla esta contida na constante
     if SiglaUF <> '' then
        begin
              // extrai UF da constante e compara
              for X := 1 to 27 do
                  if Copy(UFS,X*3-2,2) = SiglaUF then
                     break;
              // atualiza funcao
              if X > 27 then
                 ValidaEstado := False;
        end;
end;


//=======================================================================
// Objetivo..: Transforma string numerica extraindo pontos de milhar
//             ou qquer caracter nao numerico e casas decimais excedentes
//             em um numero do tipo Double
// Parametros: sValor = String numerica a ser transformada
//             NroDec = Numero de casas decimais a ser considerada
// Retorno...: Numero transformado
Function StrToValor(sValor: String; NroDec: Integer): Double;
var
   wPos, wTam, wDec : Integer;
   wNovoStr, wNro : String[30];
   wOk : Boolean;
begin
     // Verifica se string a transformar � nula
     if sValor = '' then
        begin
             StrToValor := 0;
             exit;
        end;

     // inicializa funcao
     wOk  := False;
     wDec := 0;
     wTam := length(sValor);
     wNovoStr := '';

     for wPos := 1 to wTam do
         begin
              // extrai a substring a adicionar no novo string
              wNro := Copy(sValor,wPos,1);

              // verifica se ja passou pelo ponto decimal
              if wOk then  wDec := wDec + 1;

              // verifica qtde de decimais requerida
              if wDec > NroDec then break;

              // verifica existencia de mais de um ponto decimal
              if (wNro = ',') and (wOk) then break;

              // ativa passagem pelo ponto decimal
              if wNro = ',' then wOk := True;

              // adiciona no novo string somente os numeros e o pto decimal
              if ((wNro >= '0') and (wNro <= '9')) or (wNro = ',') then
                 wNovoStr := wNovoStr + wNro;
         end;

     // atualiza funcao e retorna
     StrToValor := StrToFloat(wNovoStr);
end;


//=======================================================================
// Objetivo..: Insere tecla [Tab] no buffer de teclado
//             se [Enter] for pressionado, e anula a tecla
// Parametros: Key = Tecla pressionada a ser avaliada
// Retorno...: Tecla pressionada   ou Nula se [Enter]
Function SendTabBuf(Key: Char): Char;
begin
     // verifica se teclou [Enter]
     if Key = chr(vk_Return) then
        begin
             // insere tecla {Tab} no buffer de teclado
             Keybd_Event(vk_Tab,0,0,0);
             // e anula tecla pressionada
             SendTabBuf := chr(0);
        end
     else
         // senao retorna o mesmo
         SendTabBuf := Key;
end;


//=======================================================================
// Objetivo..: Formata valor numerico no tamanho da mascara definida
// Parametros: Mascara = Formato de apresentacao
//             vValor  = Valor numerico a ser adequada na Mascara
// Retorno...: String formatada do vValor no tamanho da mascara definida
// Observacao: Adequar o tipo de fonte utilizado senao o mesmo
//             nao tera resultado desejado  ex: Currie New
Function EditaValor(Mascara: String; vValor: Double): String;
var
   sValor : String[30];
begin
     // Transfoma vValor em String no formato Mascara
     sValor := FormatFloat(Mascara, vValor);
     // Preenche com brancos a esquerda
     sValor := '                  ' + sValor;
     // Extrai substring mais a direita no tamanho da mascara
     EditaValor := Copy(sValor,length(sValor)-(Length(Mascara)-1),Length(Mascara));
end;


//=======================================================================
// Objetivo..: Formata string na mascara definida
// Parametros: Mascara = Formato de apresentacao
//             sString = String a ser adequada na Mascara
// Retorno...: String formatada na mascara definida
// Observa��o: Serao considerados separadores apenas (.,/-) e espaco
Function EditaStr(Mascara: String ; sString: String): String;
var
   Cont1, Cont2, Max : Integer;
   sNovo, sPos1, sPos2 : String[30];
begin
     // inicializa novo string
     sNovo := '';
     // tamanho maximo da string enviada
     Max := Length(sString);
     // Verifica se tamanho da string e maior que o tamanho da mascara
     if Max > length(Mascara) then
        begin
             editaStr := '';
        end;

     Cont1 := 1;
     Cont2 := 1;
     while Cont1 <= Max do
         begin
              // Extrai substring da sString e da mascara
              sPos1 := Copy(sString,Cont1,1);
              sPos2 := Copy(Mascara,Cont2,1);
              // verifica se posicao da mascara contem caracter separador
              if (((sPos2 = '.') or (sPos2 = ',')) or
                 ((sPos2 = '/') or (sPos2 = '-'))) or
                 (sPos2 = ' ') then
                 begin
                      // adiciona o separador e incrementa a
                      // posicao da mascara
                      sNovo := sNovo + sPos2;
                      Cont2 := Cont2 + 1;
                 end;

              // adiciona substring da sString
              sNovo := sNovo + sPos1;
              Cont1 := Cont1 + 1;
              Cont2 := Cont2 + 1;
         end;
     // atualiza funcao
     EditaStr := sNovo;
end;


//=======================================================================
// Objetivo..: Monta String com Espacos
// Parametros: Pos = Quantidade de posicoes
// Retorno...: String em branco com tamanho de Pos
Function Space(Pos: Integer): String;
var
   Brancos : String;
   Cont : Integer;
begin
     Brancos := '';
     for Cont := 1 to Pos do
         Brancos := Brancos + ' ';
     Space := Brancos;
end;

//=======================================================================
// Objetivo..: Insere Texto no buffer de teclado
// Parametros: Texto = String a ser inserido
// Retorno...: True = ok ou false

Function StrToBuffer(sTexto: String): Boolean;
var
   aResult : Array[0..254] of Char;
   iPos, iTam : Integer;
begin
     iTam := Length(sTexto); // String resultado
     StrPCopy(aResult, sTexto);      // converte pascal -> nul terminated
     // carrega string no buffer de teclado
     for iPos := 1 to iTam do
         Keybd_Event(Ord(aResult[iPos-1]), iPos,0,0);
     StrToBuffer := True;
end;


//=======================================================================
// Objetivo..: Verifica se tecla pressionada � uma Letra
// Parametros: Key = Valor da tecla pressionada
// Retorno...: Tecla pressionada   ou Tecla nulo se invalida
Function DigitaSoLetra(Key: Char): Char;
begin
   // permite digitar somente numeros
   Case Key of
   'A'..'Z', 'a'..'z', chr(8): DigitaSoLetra := key
   else
       DigitaSoLetra := Chr(0) // tecla invalida
   end;
end;

//=======================================================================
// Objetivo..: Verifica se tecla pressionada � Letra, Numero ou Espa�o
// Parametros: Key = Valor da tecla pressionada
// Retorno...: Tecla pressionada   ou Tecla nulo se invalida
Function DigitaSoLetraNum(Key: Char): Char;
begin
   // permite digitar somente caracter alpha
   case Key of
      '0'..'9','A'..'Z','a'..'z',' '..' ', chr(8) : DigitaSoLetraNum := key
   else
       DigitaSoLetraNum := Chr(0) // tecla invalida
   end;
end;

//=======================================================================
// Objetivo..: Remove todos os Caracteres n�o n�mericos
// Parametros: String
// Retorno...: String s� com N�meros, se a string inicial for vazia
//             o retorno ser� 0
Function RemoveNaoNro(Str: String): String;
var
   iCont : Integer;
   str2  : String;
begin
   Str := (trim(Str));
   if (trim(Str)) = '' then
      RemoveNaoNro := '0'
   else
   begin
      str2 := '';
      for iCont:= 1 to(Length(Str)) do
        case Str[iCont] of
          '0'..'9',',' : Str2 := Str2 + Str[iCont];
        end;
      if Str2 = '' then RemoveNaoNro := '0'
      else RemoveNaoNro := Str2;
   end;
end;

//=======================================================================
// Objetivo..: Transforma em String com mascara de Valor Monet�rio
// Parametros: Double
// Retorno...: String no formato monet�rio nacional
Function StrVr(dblValor: Double): String;
var
   iPosPonto, iAuxTam : integer;
   strAux, strNumber, strNumber2, strDecimais : String;
begin
   strAux := trim(format('%14.2f',[dblValor]));
   iPosPonto := (pos(',',strAux));
   strNumber := '';
   strNumber2 := (trim(copy(strAux,1,(iPosPonto-1))));
   strDecimais := '';
   if (iPosPonto > 0) then
      strDecimais := copy(strAux,(iPosPonto+1),2);
   while (length(strDecimais)) < 2 do
      strDecimais := strDecimais + '0';
   iAuxTam := length(strNumber2);
   iPosPonto := (pos('.',strNumber2));
   if (iAuxTam > 3) then
   begin
      repeat
         if iPosPonto = 0 then
            insert('.',strNumber2,(iAuxTam-3+1))
         else
            insert('.',strNumber2,(iPosPonto-3));
         iAuxTam := length(strNumber2);
         iPosPonto := (pos('.',strNumber2));
      until (length((copy(strNumber2,1,(iPosPonto-1)))) <= 3);
   end;
   StrVr := (trim(StrNumber2 + ',' + strDecimais));
end;

Function AlignStr(Str : String; Tam : Integer; Pos : TAlinha; Carac : Char):String;
Var
   I, N : Integer;
   Texto : String;
Begin
  Texto := '';
  If Centro in Pos then
  Begin
    I := Round((Tam-Length(Str))/2);
    For N := 1 to I do
      Texto := Texto + Carac;
    AlignStr := Texto + Str + Texto;
  End
  Else If Direita in Pos then
       Begin
         I := (Tam - length(Str));
         For N := 1 to I do
           Texto := Texto + Carac;
         AlignStr := Texto + Str;
       End
       Else If Esquerda in Pos then
            Begin
              I := (Tam - length(Str));
              For N := 1 to I do
                Texto := Texto + Carac;
                AlignStr := Str + Texto;
            End;

End;

function iif(Condicao:Boolean; retornaTrue, retornaFalse:Variant):Variant;
begin
   if Condicao then
      Result := retornaTrue
   else
      Result := retornaFalse;
end;

Function limpa ( s : string ) : string;
var i : byte;
{$IFDEF VER80}
    c : Byte;
{$ENDIF}
    resp : string;
Begin
  if length(s) > 1 then
    begin
{$IFDEF VER80}
      c:=1;
{$ELSE}
      resp:='';
{$Endif}
      i:=1;
      while i < length(s) do
      Begin
        while s[i] = ' ' do i:=i+1;
        while (s[i] <> ' ') and (I <= LENGTH(S)) do
          begin
{$IFDEF VER80}
            resp[c]:=s[i];
            inc(c);
{$ELSE}
            Resp:=resp+s[i];
{$ENDIF}
            inc(i);
          end;
{$IFDEF VER80}
        resp[c]:=s[i];
        inc(c);
{$ELSE}
        Resp:=resp+s[i];
{$ENDIF}
        inc(i);
       End;
{$IFDEF VER80}
     RESP[0]:=chr(c-2);
{$ENDIF}
     i:=length(resp);
     while resp[i] = ' ' do i:=i-1;
{$IFNDEF VER80}
     SETLENGTH(resp,i);
{$ELSE}
     resp[0]:=chr(i);
{$ENDIF}
     limpa:=resp;
    end
    else limpa:=s;
End;

Function Extenso( i : LongInt ) : string;

const unidade : array[0..19] of string =
('zero',   'um',      'dois', 'tr�s',
 'quatro', 'cinco',   'seis', 'sete', 'oito',
 'nove',   'dez',     'onze', 'doze', 'treze',
 'quatorze', 'quinze', 'dezesseis','dezessete',
 'dezoito', 'dezenove');

 const dezena : array[2..9] of string =
('vinte','trinta','quarenta','cinquenta',
 'sessenta','setenta','oitenta','noventa');

const centena : array[1..9] of string =
('cento','duzentos','trezentos','quatrocentos',
 'quinhentos','seicentos','setecentos',
 'oitocentos','novecentos');

var resp : string;
  num : LongInt;
  e : boolean;
begin
  e:=false;
  num:=i;
  if i < 0 then begin
                  Resp:='menos ';
                  num:=i*(-1);
                end
  else resp:='';
              {um bilh�o}
  if (num div 1000000000) > 0 then
   begin
     if e then resp:=resp+' ';
     if (num div 1000000000) = 1 then resp := resp+'um bilh�o' else
     resp:=resp+extenso(num div 1000000000)+' bilh�es';
     num:=num-((num div 1000000000)*1000000000);
     e:=true;
   end;       {um milh�o}
  if (num div 1000000) > 0 then
   begin
     if e then resp:=resp+' ';
     if (num div 1000000) = 1 then resp := resp+'um milh�o' else
     resp:=resp+extenso(num div 1000000)+' milh�es';
     num:=num-((num div 1000000)*1000000);
     e:=true;
   end;       {Mil}
  if (num div 1000) > 0 then
   begin
     if e then resp:=resp+' ';
     if (num div 1000) = 1 then resp := resp+'mil' else
     resp:=resp+extenso(num div 1000)+' mil';
     num:=num-((num div 1000)*1000);
     e:=true;
   end;       {cem}
  if (num div 100) > 0 then
   begin
     if e then resp:=resp+' ';
     if ((num div 100)= 1) and
     ((num-((num div 100)*100)) = 0) then resp:=resp+'cem'
     else resp:=resp+centena[num div 100];
     e:=true;
     num:=num-((num div 100)*100)
   end;
              {Dez}
  if (num div 10) > 1 then
   begin
     if e then resp:=resp+' e ';
     resp:=resp+dezena[num div 10];
     e:=true;
     num:=num-((num div 10)*10)
   end;    {Um}
  if num > 0 then
    begin
     if e then resp:=resp+' e ';
     resp:=resp+unidade[num];
    end
  else { Hum . . ., ZERO }
  if not e then resp:='zero';
  extenso:=resp;
end;

Function Encripta( Texto,Chave : string) : String;
var i,c : byte;
    resp : string;
begin
  if chave = '' then
    begin
      Encripta:=Texto;
      exit;
    end;
  resp:=Texto;
  if texto = '' then
    for i:=1 to length(chave) do resp:=resp+' ';
  i:=0;
  c:=0;
  repeat
    if c < length(chave) then c:=c+1 else c:=1;
    i:=i+1;
    if (i mod 2 = 0 )
    then resp[i]:=chr(ord(resp[i])+ord(Chave[c]))
    else resp[i]:=chr(ord(resp[i])-ord(Chave[c]));
  until i = length(Texto);
  Encripta:=Resp;
end;

Function DesEncripta( Texto,Chave : string) : String;
var i,c : byte;
    resp : string;
begin
  if chave = '' then
    begin
      DesEncripta:=Texto;
      exit;
    end;
  i:=0;
  c:=0;
  resp:=Texto;
  repeat
    if c < length(chave) then c:=c+1 else c:=1;
    i:=i+1;
    if (i mod 2 = 0 )
    then resp[i]:=chr(ord(resp[i])-ord(Chave[c]))
    else resp[i]:=chr(ord(resp[i])+ord(Chave[c]));
  until i = length(Texto);
  DesEncripta:=Resp;
end;
  Function ContaPal( s : String; car:Char) : Byte;
  var Resp,i : Byte;

  Begin
    resp:=0;
    i:=2;
    if s[1] = car then
       while s[i] = car do i:=i+1
    else resp:=1;
    while i < length(S) do
      begin
        While (s[i] <> car) do
          if (i < length(S)) then i:=i+1
          else break;
        if i < length(s) then
          begin
            resp:=resp+1;
            i:=i+1;
          end
        else break;
      end;
    ContaPal:=resp;
  End;

  Function Separa( s : String; car:Char; i : byte) : String;
  var Resp : string;
      c,d,cont : Byte;
  begin
    if i > ContaPal(s,car) then
    begin
      separa:='';
      exit;
    end;
    cont:=0; c:=0;
    repeat
      resp:='';
      d:=0;
      Repeat
        d:=d+1;
        c:=c+1;
{$IFNDEF VER80}
        resp:=resp+s[c];
{$ELSE}
        resp[d]:=s[c];
{$ENDIF}
      until (s[c] = car) or not(c < length(s));
      while (s[c] = car) and (c < length(s))
      do c:=c+1;
      if c = length(s) then break;
      c:=c-1;
      cont:=cont+1;
    until cont = i;
    while resp[d] = car do d:=d-1;
{$IFNDEF VER80}
      SETLENGTH(RESP,d);
{$ELSE}
      resp[0]:=chr(d);
{$ENDIF}
    separa:=resp;
  End;
Function StrToLongInt(s : String;d : LongInt ) : LongInt;
var i : Byte;
    resp : LongInt;
    Mult : LongInt;
    Negativo : Boolean;
Begin
  Negativo:=False;
  if s = '' then
  begin
    StrToLongInt:=d;
    exit;
  end;
  if s[1] = '-' then negativo:=True
  else if not (s[1] in ['0'..'9']) then
  begin
    StrToLongInt:=d;
    exit;
  end;
  for i:=2 to length(s) do
     if not (s[i] in ['0'..'9']) then
        begin
          StrToLongInt:=d;
          exit;
        end;
  resp:=0;
  mult:=1;
  for i:=length(s) downto 2 do
   begin
     resp:=resp+((ord(s[i])-48)*mult);
     mult:=mult*10;
   end;
  if negativo then StrToLongInt:=Resp * (-1)
  else begin
         resp:=resp+((ord(s[1])-48)*mult);
         StrToLongInt:=resp;
       end;
End;

//=======================================================================
// Objetivo..:
// Parametros:
// Retorno...:

Function LongInttostr(d : LongInt ) : String;
var i : Byte;
    Zero_a_esquerda : boolean;
    resp : string;
    mult,Aux : LongInt;
Begin
  if d = 0 then begin
                  LongInttostr:='0';
                  exit;
                end;
  if d < 0 then begin
                  resp:='-';
                  d:=d * (-1);
                end else resp:='';
  zero_a_esquerda:=True;
  mult:=1000000000;
  for i := 1 to 10 do
  begin
    aux:=d div mult;
    if aux <> 0 then
      begin
        zero_a_esquerda:=False;
        Resp:=resp+chr(aux+48);
      end
      else if not zero_a_esquerda then
      Resp:=resp+'0';
    d:=d-(Aux * mult);
    mult:=mult div 10;
  end;
  LongIntToStr:=resp;
End;
Procedure Delay( i : Word );
Var Hour, Min, Sec, MSec, MSec2 : WORD;
Begin
  DecodeTime(Time, Hour, Min, Sec, MSec);
  Msec2:=Msec+i+sec*1000;
  Repeat DecodeTime(Time, Hour, Min, Sec, MSec);
    msec:=msec+sec*1000;
    Application.ProcessMessages;
  Until Msec2 <= Msec;
End;

Function AcresEspaco(s : String; tam : Byte) : String;
var resp : String;
    i : Byte;
Begin
  resp:='';
  For i:=1 to tam do Resp:=Resp+' ';
  for i:=1 to length(s) do Resp[i]:=s[i];
  AcresEspaco:=Resp;
End;

//=======================================================================
// Objetivo..: Retorna o �ltimo dia do m�s
// Parametros:
// Retorno...:

Function Ultimo_Dia_mes( i, ano : Word) : Byte;
var Resp : Byte;
Begin             
  case i of
    01 :  resp:=31;
    02 :  if ((ano mod 4) = 0) and
            (((ano mod 100) <> 0) or
             ((ano mod 400) = 0))
          then resp:=29 else resp:=28;
    03 :  resp:=31;
    04 :  resp:=30;
    05 :  resp:=31;
    06 :  resp:=30;
    07 :  resp:=31;
    08 :  resp:=31;
    09 :  resp:=30;
    10 : resp:=31;
    11 : resp:=30;
    12 : resp:=31;
  else
    resp:=0
  end;
 Ultimo_Dia_mes:=REsp;
end;

//=======================================================================
// Objetivo..: Apresentar a Vers�o do Aplicativo vindo do Projeto
// Parametros:
// Retorno...: String com a vers�o do Aplicativo

function GetBuildInfo:string;
var
   VerInfoSize: DWORD;
   VerInfo: Pointer;
   VerValueSize: DWORD;
   VerValue: PVSFixedFileInfo;
   Dummy: DWORD;
   V1, V2, V3, V4: Word;
   Prog : string;
begin
  Prog := Application.Exename;
  VerInfoSize := GetFileVersionInfoSize(PChar(prog), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(prog), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(VerInfo, VerInfoSize);
  result := IntToStr(v1) + '.' + IntToStr(v2) + '.' +
            IntToStr(v3) + ' - Build ' +IntToStr(v4);
end;

//=======================================================================
// Objetivo..: Limpa os Objetos de Edi��o do Form
// Parametros: O Form que dever� ser limpo
// Retorno...:

procedure Edita_limpar(Formulario: TForm);
var
  n: integer;
begin
  for n:=0 to Formulario.ComponentCount-1 do
    with Formulario do
    begin
      if (Components[n] is TEdit) then
        (Components[n] as TEdit).Clear;
      if (Components[n] is TMemo) then
        (Components[n] as TMemo).Clear;
      if (Components[n] is TDBEdit) then
        (Components[n] as TDBEdit).Clear;
    end;
end;

//=======================================================================
// Objetivo..: Retornar o usu�rio Logado no Windows
// Parametros:
// Retorno...: String com a usu�rio logado

function LogUser : String;
var
 Registro: TRegistry;
begin
   Registro := TRegistry.Create;
   Registro.RootKey := HKEY_LOCAL_MACHINE;
   if Registro.OpenKey('Network\Logon', false) then
     result := Registro.ReadString('username');
   Registro.Free;
end;

//=======================================================================
// Objetivo..: A fun��o CheckCC verifica se o n�mero digitado identifica
//             um cart�o de cr�dito.
// Parametros: tring que � o n�mero do cart�o
// Retorno...: retorna um n�mero inteiro

function CheckCC(c: string): Integer;
var
   card: string[21];
   Vcard: array[0..21] of Byte absolute card;
   Xcard: Integer;
   Cstr: string[21];
   y, x: Integer;
begin
   Cstr := '';
   FillChar(Vcard, 22, #0);
   card := c;
   for x := 1 to 20 do
     if (Vcard[x] in [48..57]) then
       Cstr := Cstr + chr(Vcard[x]);
   card := '';
   card := Cstr;
   Xcard := 0;
   if not odd(Length(card)) then
     for x := (Length(card) - 1) downto 1 do
     begin
       if odd(x) then
         y := ((Vcard[x] - 48) * 2)
       else
         y := (Vcard[x] - 48);
       if (y >= 10) then
         y := ((y - 10) + 1);
       Xcard := (Xcard + y);
     end
     else
     for x := (Length(card) - 1) downto 1 do
     begin
       if odd(x) then
         y := (Vcard[x] - 48)
       else
         y := ((Vcard[x] - 48) * 2);
       if (y >= 10) then
         y := ((y - 10) + 1);
       Xcard := (Xcard + y)
     end;
     x := (10 - (Xcard mod 10));
     if (x = 10) then
       x := 0;
     if (x = (Vcard[Length(card)] - 48)) then
       Result := Ord(Cstr[1]) - Ord('2')
     else
       Result := 0
end;

//=======================================================================
// Objetivo..: Retornar o N�mero Serial do Disco
// Parametros: Nenhum
// Retorno...: N�mero Serial da Unidade C
function SerialDiscoHexa : String;
var
  SLabel, SSysName: PChar;
  Serial, FileNameLen, X: DWord;
begin
  GetMem(SLabel, 255);
  GetMem(SSysName, 255);
  try
    GetVolumeInformation('C:\', SLabel, 255,
      @Serial, FileNameLen, X, SSysName, 255);
{    with Memo1.Lines do begin
      Add('Nome do volume (Label): ' + string(SLabel));
      Add('N�mero Serial: ' + IntToHex(Serial, 8));
      Add('Tamanho m�ximo p/ nome arquivo: ' +
        IntToStr(FileNameLen));
      Add('Sistema de Arquivos: ' + string(SSysName));
    end;}
  finally
    FreeMem(SLAbel, 255);
    FreeMem(SSysName, 255);
  end;

  Result := IntToHex(Serial, 8);
end;

//=======================================================================
// Objetivo..: Retornar o N�mero Serial do Disco
// Parametros: Nenhum
// Retorno...: N�mero Serial da Unidade C
function SerialDiscoInt : Integer;
var
  SLabel, SSysName: PChar;
  Serial, FileNameLen, X: DWord;
begin
  GetMem(SLabel, 255);
  GetMem(SSysName, 255);
  try
    GetVolumeInformation('C:\', SLabel, 255,
      @Serial, FileNameLen, X, SSysName, 255);
{    with Memo1.Lines do begin
      Add('Nome do volume (Label): ' + string(SLabel));
      Add('N�mero Serial: ' + IntToHex(Serial, 8));
      Add('Tamanho m�ximo p/ nome arquivo: ' +
        IntToStr(FileNameLen));
      Add('Sistema de Arquivos: ' + string(SSysName));
    end;}
  finally
    FreeMem(SLAbel, 255);
    FreeMem(SSysName, 255);
  end;

  Result := Serial;
end;

end.


