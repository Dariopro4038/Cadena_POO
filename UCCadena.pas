unit UCCadena;

interface
Uses SysUtils;

Const
     MaxC = 1024;
     const numlit:array[1..60] of string=('uno','dos','tres','cuatro','cinco','seis','siete','ocho','nueve','diez','once','doce','trece','catorce','quince','dieciseis','diecisiete','dieciocho','diecinueve','veinte','veintiuno','veintidos','veintitres','veinticuatro','veinticinco','veintiseis','veintisiete','veintiocho','veintinueve','treinta','treinta y uno','treinta y dos','treinta y tres','treinta y cuatro','treinta y cinco','treinta y seis','treinta y siete','treinta y ocho','treinta y nueve','cuarenta','cuarenta y uno' ,'cuarenta y dos' ,'cuarenta y tres' ,'cuarenta y cuatro' ,'cuarenta y cinco' ,'cuarenta y seis' ,'cuarenta y siete' ,'cuarenta y ocho' ,'cuarenta y nueve' ,'cincuenta','cincuenta y uno','cincuenta y dos','cincuenta y tres','cincuenta y cuatro','cincuenta y cinco','cincuenta y seis','cincuenta y siete','cincuenta y ocho','cincuenta y nueve','sesenta');
     const numero=['1','2','3','4','5','6','7','8','9','0','.'];
     const Mayus='ABCDEFGHIJKLMN�OPQRSTUVWXYZ';
     const minus='abcdefghijklmn�opqrstuvwxyz';
     const letras= 'ABCDEFGHIJKLMN�OPQRSTUVWXYZabcdefghijklmn�opqrstuvwxyz';
     const vocal=['a','A','e','E','i','I','o','O','u','U'];
     const separador=['+','-','*','/','_','�','?','(',')','{','}','[',']','�','!',',',' ',';',':','<','>','|'];
Type
    Cadena = Class
  Private
    LongCad : Word;
    Chars : Array[1..MaxC] of Char;
  Public
    Procedure SetText(x:string);
    Function GetChar(x:word):char;
    Function GetText():string;
    Procedure AddChars(c:string);
    Function GetLength():word;
    Procedure ModChar(x:word; c:char);
    Procedure InsertChar(x:word; c:char);
    Procedure DelChar(x:word);
    Procedure DelChars(c:char);
    Procedure Uppercase();
    Procedure Lowercase();
    Procedure InvText();
    Function CantPal(): word;
    Function NextWord(var i:word):string;
    Function nWord(p:word):string;
    Function ResolExp():string;
    Function ResolExpEquis(x:integer):string;
    {Procedure Examen();}
    Function Iniciales():string;
    Procedure ReChar(c1,c2:char);
    Procedure InvCase();
    Procedure EjerGuido1();
    Function EsMayus(c:char):boolean;
    Function EsMinus(c:char):boolean;
    Function HacerHora():string;
    Function Examen(subcad:String):String;
  end;
implementation

{ Cadena }

procedure Cadena.AddChars(c: string);
var lim,i:word;
begin
  i:=1; lim:=length(c);
  while i<=lim do begin
    chars[longcad+i]:=c[i];
    inc(i);
  end;
  longcad:=longcad+lim;
end;

procedure Cadena.SetText(x: string);
var i,lim:word;
begin
  lim:=length(x);   i:=1;
  while i<=lim do begin
    Chars[i]:=x[i];
    i:=i+1;
  end;
  Longcad:=lim;
end;

procedure Cadena.Uppercase;
var str:string; a:integer;
  i: Integer;
begin
  str:=gettext;
  for i := 1 to longcad do begin
    a:=ord(str[i]);
    if ((a>96) and (a<123)) then begin
      a:=a-32;
      Chars[i]:=chr(a);
    end else begin
      if a=241 then begin
        a:=209;
        Chars[i]:=chr(a);
      end;
    end;
  end
end;

function Cadena.GetText: string;
var str:string; i:word;
begin
  i:=1; str:='';
  while i<=Longcad do begin
    str:=str+chars[i];
    i:=i+1;
  end;
  result:=str;
end;

function Cadena.HacerHora: string;
var pal,acum,pal2:string; i,i2,c:integer;
begin
c:=1; i2:=1; pal:='';  acum:=''; i:=1;
  while c<=cantpal do begin
  pal:=nword(c);
    repeat
    if pal<>numlit[i] then inc(i);
    until (pal=Numlit[i]) or (i>=60);
    if pal=numlit[i] then begin

    if (i>=30) and (nword(c+1)='y') then begin
    pal2:=nword(c+2);
      repeat
        if pal2<>numlit[i2] then begin
          i2:=i2+1;
        end;                            // cinco y cincuenta y cuatro =05:05:
      until (pal2=Numlit[i2]) or (i2>=60);
      i:=i2+i;
      c:=c+2;
    end;

      if i<10 then begin
        acum:=acum+'0'+inttostr(i)+':';
      end else begin
        acum:=acum+inttostr(i)+':';
      end;
    end;
    i:=1;
    i2:=1;
  inc(c);
  end;
  delete(acum,length(acum),1);
  Result:=acum;
end;

function Cadena.Iniciales: string;
var i,c:word; acum,cadn:string;
begin
  c:=cantpal();
  i:=1;
  Repeat
    cadn:=nWord(i);
    acum :=acum+Upcase(cadn[1])+'.';
    i:=i+1;
  Until i>c;
  Delete(acum,length(acum),1);
  Result:=acum;
end;

procedure Cadena.InsertChar(x: word; c: char);
var i:integer;
begin
    i:=0;
  if (x>0)and(x<=Longcad) then begin
    inc(longcad);
      for i := Longcad downto x+1 do  Chars[i]:=Chars[i-1];
    Chars[i]:=c;
  end else raise Exception.Create('Fuera de rango, verifique la longitud de cadena');

end;

procedure Cadena.InvCase;
var i,lim:word; sv:integer;
begin
  i:=1; lim:=longcad; sv:=0;
  for i := 1 to longcad do begin

  // lowercase
    if (ord(Chars[i])>64) and (ord(Chars[i])<91) then begin
      sv:=ord(chars[i])+32;
      chars[i]:=chr(sv);
    end else begin
    // uppercase
      if (ord(Chars[i])>96) and (ord(Chars[i])<123) then begin
        sv:=ord(chars[i])-32;
        chars[i]:=chr(sv);
      end;
    end;

      if (ord(Chars[i])=209) then begin
        chars[i]:=chr(241);
      end else begin
        if (ord(Chars[i])=241) then begin
          chars[i]:=chr(209);
        end;
      end;
      sv:=0;
  end;
end;

procedure Cadena.InvText;
var i,lim:word; c:char;
begin
  i:=1;  lim:=longcad;
  while i<lim do begin
    c:=chars[i];
    chars[i]:=chars[lim];
    Chars[lim]:=c;
    inc(i); dec(lim);
  end;
end;

procedure Cadena.Lowercase;
var str:string; a:integer;
  i: Integer;
begin
  str:=gettext;
  for i := 1 to longcad do begin
    a:=ord(str[i]);
    if ((a>64) and (a<91)) then begin
      a:=a+32;
      Chars[i]:=chr(a);
    end else begin
      if a=209 then begin
        a:=241;
        Chars[i]:=chr(a);
      end;
    end;
  end
end;

procedure Cadena.ModChar(x:word; c:char);
begin
  if (x<=longcad) and (x>=1) then begin
    Chars[x]:=c;
  end else begin
    raise Exception.Create('Fuera de rango, verifique la longitud de cadena');
  end;
end;

function Cadena.NextWord(var i:word): string;
var pal:string;
begin
  while (i<=longcad) and(chars[i]in Separador) do i:=i+1;
  pal:='';
  while (i<=longcad)and not(Chars[i]in Separador) do begin
    pal:=pal+Chars[i];
    i:=i+1;
  end;
  Result:=pal;
end;

function Cadena.nWord(p: word): string;
var c,i:word; pal:string;
begin
  if (p>0)and(p<=cantpal) then begin
    i:=1;
    while p>0 do begin
      pal:=Nextword(i);
      dec(p);
    end;
    result:=pal;
  end else raise Exception.Create('La posici�n de la palabra est� fuera de rango');
end;


procedure Cadena.ReChar(c1, c2: char);
var i,lim:word;
begin
  i:=1; lim:=longcad;
  while i<=lim do begin
    if c1=chars[i] then chars[i]:=c2;
    inc(i);
  end;
end;

function Cadena.ResolExp: string;
var i,numr,numr2,res:integer; numcad,numcad2:string; paco:integer; execute:boolean;
begin
  execute:=false; numcad:=''; numcad2:='';  numr:=0;  numr2:=0;
  {+  =1    - =2    * =3    / =4    Execute=true}
  i:=1; paco:=0;
  repeat
    repeat
     if not(chars[i] in separador) and (Chars[i] in numero) then begin

      if paco=0 then begin
        numcad:=numcad+chars[i];
        numr:=strtoint(numcad);
      end else begin
        numcad2:=numcad2+chars[i];
        numr2:=strtoint(numcad2);
      end;

     end else begin
      case (Chars[i]) of
        '+':  paco:=1;
        '-':  paco:=2;
        '*':  paco:=3;
        '/':  paco:=4;
      end;
            execute:=true;
     end;
      inc(i);

    until (execute=true)and not(chars[i] in numero);

    case paco of
      1:Begin
        numr:=numr+numr2;
        execute:=false;
        numcad2:='';
      End;
      2:Begin
        numr:=numr-numr2;
        execute:=false;
        numcad2:='';
      End;
      3:Begin
        numr:=numr*numr2;
        execute:=false;
        numcad2:='';
      End;
      4:Begin
        numr:=trunc(numr/numr2);
        execute:=false;
        numcad2:='';
      End;
    end;
  until i>=length(gettext);
Result:=inttostr(numr);

end;

function Cadena.ResolExpEquis(x:integer): string;
var i,numr,numr2,res:integer; numcad,numcad2:string; paco:integer; execute:boolean;
// Comentario: El codigo necesita un integer para darle valor a x este se coloca en el edit3.
begin
  execute:=false; numcad:=''; numcad2:='';  numr:=0;  numr2:=0;
  {+  =1    - =2    * =3    / =4    Execute=true}
  i:=1; paco:=0;
  repeat
    repeat
     if not(chars[i] in separador) and ((Chars[i] in numero)or (chars[i]='x')) then begin
      if chars[i]='x' then begin
        if paco=0 then begin
          if numr=0 then begin
            numr:=x;
          end else begin
            numr:=numr*x;
          end;
        end else begin
          if numr2=0 then begin
            numr2:=x;
          end else begin
            numr2:=numr2*x;
          end;
        end;
      end else begin
        if paco=0 then begin
          numcad:=numcad+chars[i];
          numr:=strtoint(numcad);
        end else begin
          numcad2:=numcad2+chars[i];
          numr2:=strtoint(numcad2);
        end;
      end;

     end else begin
      case (Chars[i]) of
        '+':  paco:=1;
        '-':  paco:=2;
      end;
            execute:=true;
     end;
      inc(i);

    until (execute=true)and not((chars[i] in numero)or(chars[i]='x'));

    case paco of
      1:Begin
        numr:=numr+numr2;
        execute:=false;
        numcad2:='';
        numr2:=0;
      End;
      2:Begin
        numr:=numr-numr2;
        execute:=false;
        numcad2:='';
        numr2:=0;
      End;
    end;
  until i>=length(gettext);
Result:=inttostr(numr);
end;

function Cadena.CantPal: word;
var s,i: word;
begin
  i:=1;  s:=0;
  while i<longcad do begin
    if not(chars[i] in separador) and (Chars[i+1]in separador) then inc(s);
      inc(i);
  end;
  if not (Chars[i] in separador) then s:=s+1;
  result:=s;
end;

procedure Cadena.DelChar(x: word);
var  i:word;
begin
  {str:=gettext;
  delete(str,x,1);
  longcad:=length(str);
  SetText(str);}
  if (x<=longcad) and (x>=1) then begin
    i:=1;
    repeat
      if (i>=x) then begin
        Chars[i]:=chars[i+1];
      end;
      i:=i+1;
    until i>=longcad+1;
    longcad:=longcad-1;
  end else begin
    raise Exception.Create('Fuera de rango, verifique la longitud de cadena');
  end;
end;

procedure Cadena.DelChars(c: char);
var i:word;
begin
    for i := 1 to longcad do begin
      if c=Chars[i] then delchar(i);
    end;
end;


procedure Cadena.EjerGuido1;
var pal,palact,acum:string; c1,c2:char; i,c,posi:word; sem:boolean;
begin
  i:=1; c:=1; sem:=false; acum:=''; posi:=0;  pal:=gettext;
repeat
  while sem=false do begin

  palact:=nword(c);
    c1:=nword(c)[1];
    c2:=nword(c)[length(nword(c))];
    if pal[i] in separador then begin
      i:=i+1;
    end else begin
      if (EsMayus(c1)) and (EsMinus(c2)) then begin
      posi:=pos(c1, Mayus);
        pal[i]:=Upcase(c2);
        pal[length(nword(c))]:=minus[posi];
        sem:=true;
      end else begin
        if (EsMinus(c1)) and (EsMayus(c2))then begin
        posi:=pos(c2, Mayus);
          pal[i]:=minus[posi];
          pal[length(nword(c))]:=Upcase(c1);
                  sem:=true;
        end else begin
          if (EsMayus(c1)) and (EsMayus(c2))then begin
            pal[i]:=c2;
            pal[length(nword(c))]:=c1;
                    sem:=true;
          end else begin
            if (EsMinus(c1)) and (EsMinus(c2))then begin
             pal[i]:=c2;
              pal[length(nword(c))]:=c1;
                      sem:=true;
            end;
          end;
        end;
      end;
       i:=i+length(palact);
    end;

  end;
  inc(c);
  sem:=false;

until c>cantpal;
Settext(pal);
end;

function Cadena.EsMayus(c: char): boolean;
begin
  if pos(c,Mayus)>0 then begin
    result:=true;
  end else begin
    result:=false;
  end;

end;

function Cadena.EsMinus(c: char): boolean;
begin
    if pos(c,minus)>0 then begin
    result:=true;
  end else begin
    result:=false;
  end;

end;

 Procedure Min(subcad:String);
var str:string; a:integer;
  i: Integer;
begin
  str:=subcad;
  for i := 1 to length(subcad) do begin
    a:=ord(str[i]);
    if ((a>64) and (a<91)) then begin
      a:=a+32;
      subcad[i]:=chr(a);
    end else begin
      if a=209 then begin
        a:=241;
        subcad[i]:=chr(a);
      end;
    end;
  end
end;

function Cadena.Examen(subcad: String): String;  //Matoneo a un niu, la funci�n elimina las palabras que tienen la subcadena dentro del objeto cadena
var
  I: Integer; res:String;
begin
res:='';
  for I := 1 to CantPal do begin
    if pos(subcad,nWord(i))=0 then begin
      res:=res+' '+nWord(i);
    end else begin
      Min(subcad);
      if pos(subcad,nWord(i))=0 then begin
        res:=res+' '+nWord(i);
      end;
    end;
  end;
  Trim(res);
  result:=res;
end;


function Cadena.GetChar(x: word): char;
var c:char;
begin
  if (x<=longcad)and(x>=1) then begin
    c:=Chars[x];
    result:=c;
  end else begin
    raise Exception.Create('Fuera de rango, verifique la longitud de cadena');
  end;
end;

function Cadena.GetLength: word;
begin
  result:=Longcad;
end;

end.
