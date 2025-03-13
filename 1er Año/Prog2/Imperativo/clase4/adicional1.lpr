program adicional1;
type
  alumno=record
    nombre:string;
    apellido:string;
    dni:integer;
  end;
// Arbol de alumno
  arbol= ^nodoA;
  nodoA = Record
    dato: alumno;
    HI: arbol;
    HD: arbol;
  End;


procedure lectura(var alu:alumno);
begin
  with alu do begin
    writeln('ingrese el nombre del alumno');
    readln(nombre);
    if(nombre<>'ZZZ')then begin
      writeln('ingrese el apellido del alumno');
      readln(apellido);
      writeln('ingrese el dni del alumno');
      readln(dni);
    end;
  end;
end;

//Agregar Arbol - Agrega un entero a un arbol ABO, sin repetidos }

Procedure insertar(var a: arbol; alu:alumno);
begin
   if (a = nil)then
    begin
      new (a);
      a^.dato:= alu;
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.dato.dni> alu.dni then
      insertar(a^.HI, alu)
    else
      if a^.dato.dni< alu.dni then
       insertar(a^.HD, alu)
  end;

Procedure PreOrden( a: arbol );
begin
  if ( a <> nil ) then begin
    write (a^.dato.dni, '   ');
    preOrden(a^.HI);
    preOrden(a^.HD);
  end;
end;

procedure Acotado(a:arbol;inf:integer;sup:integer);
begin
  if(a<>nil)then
   if(a^.dato.dni>inf)then
    if(a^.dato.dni<sup)then begin
     with a^.dato do begin
       writeln('el nombre es : ',nombre);
       writeln('el apellido es : ',apellido);
       writeln('el dni es : ',dni);
      end
     end
    else
    acotado(a^.HI,inf,sup)
   else
    acotado(a^.HD,inf,sup);
end;

procedure buscarapellido(a:arbol;apeb:string);
begin
  if ( a <> nil ) then begin
    if(a^.dato.apellido=apeb)then begin
     with a^.dato do begin
       writeln('el nombre es : ',nombre);
       writeln('el apellido es : ',apellido);
       writeln('el dni es : ',dni);
      end
    end;
    buscarapellido(a^.HI,apeb);
    buscarapellido(a^.HD,apeb);
  end;
end;

var
  alu:alumno;
  a:arbol;
  numero:integer;
  apeb:string;
begin
  a:=nil;
  lectura(alu);
  while(alu.nombre<>'ZZZ')do begin
    insertar(a,alu);
    lectura(alu);
  end;
  //PreOrden(a);
  writeln('ingrese el valor a ser buscado');
  readln(numero);
  Acotado(a,numero-1,numero+1);
  writeln('ingrese el apellido a ser buscado');
  readln(apeb);
  buscarapellido(a,apeb);
  readln();
end.

