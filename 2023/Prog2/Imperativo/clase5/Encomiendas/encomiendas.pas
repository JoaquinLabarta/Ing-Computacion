Program encomiendas;
Type

   encomienda = record
                  codigo: integer;
                  peso: integer;
                end;

  // Lista de encomiendas
  lista = ^nodoL;
  nodoL = record
    dato: encomienda;
    sig: lista;
  end;

  lista2 = ^nodoL2;
  nodoL2 = record
    code: integer;
    sig: lista2;
  end;

  info = record
    l:lista2;
    p:integer;
  end;

   // Arbol de enteros
  arbol= ^nodoA;
  nodoA = Record
    dato: info;
    HI: arbol;
    HD: arbol;
  End;


{-----------------------------------------------------------------------------
AgregarAdelante - Agrega una encomienda adelante en l}
procedure agregarAdelante(var l: Lista; enc: encomienda);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := enc;
  aux^.sig := l;
  l:= aux;
end;


{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista con datos de las encomiendas }
procedure crearLista(var l: Lista);
var
  e: encomienda;
  i: integer;
begin
 l:= nil;
 for i:= 1 to 20 do begin
   e.codigo := i;
   e.peso:= random (10);
   while (e.peso = 0) do e.peso:= random (10);
   agregarAdelante(L, e);
 End;
end;


{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
procedure imprimirLista(l: Lista);
begin
 While (l <> nil) do begin
   writeln('Codigo: ', l^.dato.codigo, '  Peso: ', l^.dato.peso);
   l:= l^.sig;
 End;
end;


{-----------------------------------------------------------------------------
AgregarAdelante - Agrega una encomienda adelante en l}
procedure agregarAdelante2(var l: lista2; code: integer);
var
  aux: lista2;
begin
  new(aux);
  aux^.code := code;
  aux^.sig := l;
  l:= aux;
end;

//Agregar Arbol - Agrega un entero a un arbol ABO, sin repetidos

Procedure insertar(info:encomienda;var a: arbol);
begin
   if (a = nil)then
    begin
      new (a);
      a^.dato.p:= info.peso;
      a^.dato.l:=nil;
      agregaradelante2(a^.dato.l,info.codigo);
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.dato.p > info.peso then
      insertar(info,a^.HI )
    else
      if a^.dato.p < info.peso then
       insertar(info,a^.HD)
      else agregaradelante2(a^.dato.l,info.codigo);
end;

//IMPRIMIRLISTA - Muestra en pantalla la lista l }
procedure imprimirLista2(l: Lista2;peso:integer);
begin
 writeln('en el peso ',peso,' existen estos codigos : ');
 While (l <> nil) do begin
   writeln(l^.code);
   l:= l^.sig;
 End;
end;

Procedure PostOrden( a: arbol );
begin
  if ( a <> nil ) then begin
    PostOrden(a^.HI);
    PostOrden(a^.HD);
    imprimirLista2(a^.dato.l,a^.dato.p);
  end;
end;

Var

 l: lista;
 a:arbol;
begin
 Randomize;

 crearLista(l);
 writeln ('Lista de encomiendas generada: ');
 imprimirLista(l);
 readln;
 writeln();
 writeln('-----------------arbol------------------');
 a:=nil;
 while(l<>nil)do begin
   insertar(l^.dato,a);
   l:=l^.sig;
 end;
 PostOrden(a);
 readln();
end.
