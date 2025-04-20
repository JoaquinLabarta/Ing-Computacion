{Una biblioteca quiere tener un mejor acceso a sus libros. Para ello, nos piden generar
un árbol binario de búsqueda con los datos de todos sus libros. De cada libro se
conoce: título, ISBN y clasificador bibliográfico (código alfanumérico que permite
clasificar el tema del ejemplar), que se leen desde teclado. La lectura finaliza con el
ISBN 0 (cero). Interesa poder buscar los libros eficientemente por ISBN.

Se pide:
a)Generar árbol binario de búsqueda según el enunciado.

Una vez generado el árbol:
b)Realice un módulo que reciba el árbol y un ISBN de libro, y retorne verdadero si
existe dicho libro en el árbol o falso en caso contrario.

c)Realizar un módulo que reciba el árbol y un código clasificador, y devuelva la
cantidad de veces que aparece en el árbol (el módulo debe tener en cuenta que
puede no existir).

d)Realice un módulo que reciba el árbol y un título de libro, y retorne verdadero si
existe dicho libro en el árbol o falso en caso contrario.
e)Realizar un programa que invoque a los módulos realizados e informe desde el
programa principal los datos correspondientes.}

program Parcial3;
type
  libro = record
        titulo:string;
        ISBN:integer;
        cb:string;
  end;

  arbol= ^nodoA;
  nodoA = Record
    dato: libro;
    HI: arbol;
    HD: arbol;
  End;

{-----------------------PROCESOS Y FUNCIONES------------------------------------}

Procedure insertar(var a: arbol; l:libro);
begin
   if (a = nil)then
    begin
      new (a);
      a^.dato:= l;
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.dato.ISBN> l.ISBN then
      insertar(a^.HI, l)
    else
      if a^.dato.ISBN< l.ISBN then
       insertar(a^.HD, l)
  end;


procedure cargar(var l:libro);
begin
  writeln('INGRESE EL ISBN DEL LIBRO: ');
  readln(l.ISBN);
  if(l.ISBN<>0)then begin
    writeln('INGRESE EL TITULO DEL LIBRO');
    readln(l.titulo);
    writeln('INGRESE EL CLASIFICADOR BIBLIOGRAFICO');
    readln(l.cb);
  end;
end;

procedure cargararbol(var a:arbol);
var
  l:libro;
begin
  cargar(l);
  while(l.ISBN<>0)do begin
    insertar(a,l);
    cargar(l);
  end;
end;

Procedure enOrden( a: arbol );
begin
  if ( a <> nil ) then begin
    enOrden (a^.HI);
    writeln ('EL ISBN ES : ',a^.dato.ISBN,' EL TITULO DEL LIBRO ES: ',a^.dato.titulo,' EL CLASIFICADOR BIBLIOGRAFICO ES: ',a^.dato.cb);
    enOrden (a^.HD)
  end;
end;

function acotado(a:arbol;inf:integer;sup:integer): boolean;
var
  exito:boolean;
begin
  if(a<>nil)then
   if(a^.dato.isbn>inf)then
    if(a^.dato.isbn<sup)then begin
       exito:=true;
       acotado:=exito;
     end
    else begin
        exito:=acotado(a^.HI,inf,sup);
    end
    else
        exito:=acotado(a^.HD,inf,sup);
  if(a<>nil) then acotado:=exito
  else acotado:=false;
end;

Procedure buscarclase(a: arbol; dato:string; var cant: integer);
begin
  if (a<>nil) then begin
     if (a^.dato.cb = dato) then cant:=cant+1;
     buscarclase (a^.HI,dato,cant);
     buscarclase (a^.HD,dato,cant);
  end;
end;

function buscartitulo(a:arbol; dato:string):boolean;
var
  exito:boolean;
begin
  if((a<>nil) and (exito = false))then begin
    if(a^.dato.titulo = dato)then begin
      exito:=true;
      buscartitulo:=exito;
    end
    else
       exito:=buscartitulo(a^.HI,dato);
       if (exito = false) then exito:=buscartitulo(a^.HD,dato);
  end;
  if (a<>nil) then buscartitulo:=exito
  else buscartitulo:=false;
end;


var
  a:arbol;
  buscado:integer;
  codcla:string;
  cantc:integer;
  titulo:string;
begin
  writeln('PUNTO A');
  a:=nil;
  cargararbol(a);
  writeln('ARBOL GENERADO');
  enOrden(a);
  writeln('---------------------------------------------------------------');
  writeln('PUNTO B');
  writeln();
  writeln('INGRESE EL ISBN DEL LIBRO QUE DESEA BUSCAR');
  readln(buscado);
  writeln();
  if (acotado(a,buscado-1,buscado+1) = true) then writeln ('EL LIBRO EXISTE')
  else writeln('EL LIBRO NO EXISTE');
  writeln('---------------------------------------------------------------');
  writeln();
  writeln('PUNTO C');
  writeln();
  writeln('INGRESE EL CODIGO CLASIFICADOR QUE DESEA BUSCAR');
  readln(codcla);
  buscarclase(a,codcla,cantc);
  writeln('LA CANTIDAD CON EL CODIGO DE CLASIFICACION ES :');
  writeln(cantc);
  writeln('---------------------------------------------------------------');
  writeln();
  writeln('PUNTO D');
  writeln();
  writeln('INGRESE EL TITULO QUE DESEA BUSCAR');
  readln(titulo);
  if (buscartitulo(a,titulo) = true) then writeln ('EL LIBRO EXISTE')
  else writeln('EL LIBRO NO EXISTE');
  readln();
end.

