Program arbolesinrepetidos;
Type

  // Lista de enteros
  lista = ^nodoL;
  nodoL = record
    dato: integer;
    sig: lista;
  end;

  // Arbol de enteros
  arbol= ^nodoA;
  nodoA = Record
    dato: integer;
    HI: arbol;
    HD: arbol;
  End;

  // Lista de Arboles
  listaNivel = ^nodoN;
  nodoN = record
    info: arbol;
    sig: listaNivel;
  end;


{-----------------------------------------------------------------------------
AgregarAdelante - Agrega nro adelante de l}
procedure agregarAdelante(var l: Lista; nro: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := nro;
  aux^.sig := l;
  l:= aux;
end;



{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista con números aleatorios }
procedure crearLista(var l: Lista);
var
  n: integer;
begin
 l:= nil;
 n := random (20);
 While (n <> 0) do Begin
   agregarAdelante(L, n);
   n := random (20);
 End;
end;


{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
procedure imprimirLista(l: Lista);
begin
 While (l <> nil) do begin
   write(l^.dato, ' - ');
   l:= l^.sig;
 End;
 writeln(' ' )   ;
end;

{-----------------------------------------------------------------------------
CONTARELEMENTOS - Devuelve la cantidad de elementos de una lista l }

function ContarElementos (l: listaNivel): integer;
  var c: integer;
begin
 c:= 0;
 While (l <> nil) do begin
   c:= c+1;
   l:= l^.sig;
 End;
 contarElementos := c;
end;


{-----------------------------------------------------------------------------
AGREGARATRAS - Agrega un elemento atrás en l}

Procedure AgregarAtras (var l, ult: listaNivel; a:arbol);
 var nue:listaNivel;

 begin
 new (nue);
 nue^.info := a;
 nue^.sig := nil;
 if l= nil then l:= nue
           else ult^.sig:= nue;
 ult:= nue;
 end;


{-----------------------------------------------------------------------------
IMPRIMIRPORNIVEL - Muestra los datos del árbol a por niveles }

Procedure imprimirpornivel(a: arbol);
var
   l, aux, ult: listaNivel;
   nivel, cant, i: integer;
begin
   l:= nil;
   if(a <> nil)then begin
                 nivel:= 0;
                 agregarAtras (l,ult,a);
                 while (l<> nil) do begin
                    nivel := nivel + 1;
                    cant:= contarElementos(l);
                    write ('Nivel ', nivel, ': ');
                    for i:= 1 to cant do begin
                      write (l^.info^.dato, ' - ');
                      if (l^.info^.HI <> nil) then agregarAtras (l,ult,l^.info^.HI);
                      if (l^.info^.HD <> nil) then agregarAtras (l,ult,l^.info^.HD);
                      aux:= l;
                      l:= l^.sig;
                      dispose (aux);
                     end;
                     writeln;
                 end;
               end;
end;
 {-----------------------------------------------------------------------------
Agregar Arbol - Agrega un entero a un arbol ABO, sin repetidos }

Procedure insertar(var a: arbol; num:integer);
begin
   if (a = nil)then
    begin
      new (a);
      a^.dato:= num;
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.dato> num then
      insertar(a^.HI, num)
    else
      if a^.dato< num then
       insertar(a^.HD, num)
  end;

   Procedure enOrden( a: arbol );
begin
  if ( a <> nil ) then begin
    enOrden (a^.HI);
    write (a^.dato, '   ');
    enOrden (a^.HD)
  end;
  end;

function vermin(a:arbol):integer;
begin
 if(a<>nil)then begin
    if(a^.HI <>nil)then begin
      vermin:=vermin(a^.HI);
    end
    else
      vermin:=a^.dato;
 end;
end;

function buscar(a:arbol;numero:integer;var encontro:boolean):arbol;
begin
 if(a<>nil)then begin
    if(a^.dato=numero)then begin
      encontro:=true;
      buscar:=a;
    end
    else begin
      if(numero<a^.dato)then
       buscar(a^.HI,numero,encontro)
       else
         if(numero>a^.dato)then
           buscar(a^.HD,numero,encontro);
    end;
    end;
 if(encontro=false)then
  buscar:=nil;
 end;


procedure borrarelemento(var a:arbol;dato:integer;var resultado:boolean);
var
   auxa:arbol; encontro:boolean;
begin
 encontro:=false;
 if(a=nil)then begin resultado:=false end
 else if(a^.dato >dato)then begin borrarelemento(a^.HI,dato,resultado) end
 else if(a^.dato <dato)then begin borrarelemento(a^.HD,dato,resultado)  end
      //encontramos dato
      else if ((a^.HD = nil) and (a^.HI = nil) ) then begin
           dispose(a);
           a:=nil;

           resultado:=true;
           end
      //tiene hijo der
      else if ((a^.HD <> nil) and (a^.HI = nil) ) then begin
         auxa:=a;
         a:=a^.HD;
         dispose(auxa);
         resultado:=true end
      //tiene hijo izq
      else if  ((a^.HI <> nil) and (a^.HD = nil) ) then begin
         auxa:=a;
         a:=a^.HI;
         dispose(auxa);
         resultado:=true end
      //SI TIENE DOS HIJOS
      else begin
        auxa:=buscar(a,dato,encontro);
        auxa^.dato:=vermin(a^.HD);
        borrarelemento(a^.HD,auxa^.dato,resultado);
     end
end;


  Var

 l: lista;
 a: arbol;
 dato:integer;
 resultado:boolean;

begin
 Randomize;
 a:= nil;
 crearLista(l);
 writeln ('Lista generada: ');
 imprimirLista(l);
 while l <> nil do
 begin
   insertar(a,l^.dato);
   l:=l^.sig;
 end;
  Writeln  ('Arbol');
  imprimirpornivel (a);
  Writeln  ('Recorrido en Orden del Arbol');
  enOrden(a);
  Writeln();
  writeln('----------------borrado del arbol---------------------');
  resultado:=false;
  writeln('ingrese el dato del arbol');
  readln(dato);
  borrarelemento(a,dato,resultado);
  writeln(resultado);
  imprimirpornivel (a);
 readln;
end.
