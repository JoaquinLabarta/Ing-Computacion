program biblioteca;
type
  libro = record
    titulo: string;
    isbn: integer;
    clase: string;
  end;
  arbol = ^nodo;
  nodo = record
    dato: libro;
    HI: arbol;
    HD: arbol;
  end;

procedure leerlibro(var l: libro);
begin
  with (l) do begin
    writeln('Ingrese el isbn dle libro');
    readln(isbn);
    if (isbn <> 0) then begin
      writeln('Ingrese titulo del libro');
      readln(titulo);
      writeln('Ingrese clase del libro');
      readln(clase);
    end;
  end;
end;

Procedure insertar(var a: arbol; l:libro);
begin
   if (a = nil)then begin
      new (a);
      a^.dato:=l;
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.dato.isbn > l.isbn then
      insertar(a^.HI, l)
    else
      if a^.dato.isbn < l.isbn then
       insertar(a^.HD, l)
  end;

Procedure buscarclase(a: arbol; dato:string; var cant: integer);
begin
  if (a<>nil) then begin
     if (a^.dato.clase = dato) then cant:=cant+1;
     buscarclase (a^.HI,dato,cant);
     buscarclase (a^.HD,dato,cant);
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

function buscartitulo(a:arbol; dato:string):boolean;
var
  exito:boolean;
begin
  while((a<>nil) and (exito = false))do begin
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
  a: arbol;
  l: libro;
  isbnbusq: integer;
  exito: boolean;
  clasebusq: string;
  cantclase: integer;
  titulobusq: string;
begin
  a:=nil;

  //Punto a
  leerlibro(l);
  while (l.isbn<>0) do begin
    insertar(a,l);
    leerlibro(l);
  end;

  //Punto B
  writeln('Ingrese un isbn a buscar');
  readln(isbnbusq);
  {exito:=false;
  buscarisbn(a,isbnbusq,exito); }
  if (acotado(a,isbnbusq-1,isbnbusq+1) = true) then writeln ('El libro existe')
  else writeln('El libro no existe');

  //Punto C
  writeln('Ingrese la clase a buscar');
  readln(clasebusq);
  cantclase:=0;
  buscarclase(a,clasebusq,cantclase);
  writeln('La cantidad de veces que aparece la clase buscada es: ',cantclase);

  //Punto D
  writeln('Ingrese titulo del libro a buscar');
  readln(titulobusq);
  if(buscartitulo(a,titulobusq) = true) then writeln('Se encontro el titulo')
  else writeln('No se encontro el titulo');

  readln();
end.

