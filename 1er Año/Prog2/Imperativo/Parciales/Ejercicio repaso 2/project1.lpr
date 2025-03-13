program project1;
Uses
     sysutils;
Type

  //info interna de lista de los partidos (main)
  jug = record
    dni: integer;
    nombre: string;
    apellido: string;
    eq: string;
    cantgoles: integer;
    end;

  //lista interna de lista de los partidos (main)
  listagoles = ^nodogol;
  nodogol = record
    info: jug;
    sig: listagoles;
  end;

  fecha=record
     dia:1..31;
     mes:1..12;
     anio:integer;
    end;
  //info lista partidos
  partido = record
    idpartido: string;
    eq1: string;
    eq2: string;
    fechas: fecha;
    estadio: string;
    goljug: listagoles;
  end;

  //lista partidos
  listapartidos = ^nodopartidos;
  nodopartidos = record
    info: partido;
    sig:listapartidos;
  end;

  //lista interna arbol
  listaint = ^nodoint;
  nodoint = record
    //podria ser record la informacion
    fechas: fecha;
    cantgoles: integer;
    sig: listaint;
  end;

  //informacion del arbol
  infoarb = record
    dni: integer;
    nombre: string;
    apellido: string;
    eq: string;
  end;

  //arbol
  arbol = ^nodoa;
  nodoa = record
    info: infoarb;
    lint: listaint;
    hd: arbol;
    hi: arbol;
  end;


{----------MODULOS PROPIOS----------}

//agregar a la lista interna del arbol
Procedure agregar2(var l: listaint; cantgoles:integer; fecha:fecha);
var
   aux: listaint;
begin
     new(aux);
     aux^.cantgoles := cantgoles;
     aux^.fechas := fecha;
     aux^.sig := l;
     l:= aux;
end;

//insertar jugador en el arbol con opcion de repetido
Procedure insertar(var a: arbol; data:jug; fecha:fecha);
begin
   if (a = nil)then
    begin
      new (a);
      with(data)do begin
        a^.info.dni:=dni;
        a^.info.nombre:=nombre;
        a^.info.apellido:=apellido;
        a^.info.eq:=eq;
        a^.lint:=nil;

        agregar2(a^.lint,data.cantgoles,fecha);

       end;
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.info.dni > data.dni then
      insertar(a^.hi,data,fecha)
    else
      if a^.info.dni < data.dni then
       insertar(a^.hd,data,fecha)
    else
      agregar2(a^.lint,data.cantgoles,fecha);

  end;

//recorrer lista partidos y llama a insertar en el arbol
procedure recorrerl(var a:arbol; l:listapartidos);
var
   dnia:integer;
begin
  while(l<>nil)do begin
    while (l^.info.goljug<>nil)do begin
      dnia:=l^.info.goljug^.info.dni;
      if (dnia = l^.info.goljug^.info.dni) then begin
        insertar(a,l^.info.goljug^.info,l^.info.fechas);
        l^.info.goljug:=l^.info.goljug^.sig;
      end;
    end;
    l:=l^.sig;
  end;
end;

//recorrer lista interna del arbol para contar goles
function recorrerlista (l: listaint): integer;
var
   aux: listaint;
   cant: integer;
begin
  aux:= l;
  cant:=0;
  while (aux <> nil) do begin
    cant:= cant + aux^.cantgoles;
    aux:=aux^.sig;
  end;
  recorrerlista:=cant;
end;

//buscar y devolver el maximo goleador con su equipo, podria ser funcion pero tengo que preguntar si puedo devolver un string
Procedure maximogoleador(a: arbol; var max: integer; var eq: string );
var
   cant: integer;
begin
  if ( a <> nil ) then begin
    cant:= recorrerlista(a^.lint);
    if(a^.lint^.cantgoles>=max)then begin
      max:=cant;
      eq:=a^.info.eq;
    end;
    maximogoleador(a^.hi,max,eq);
    maximogoleador(a^.hd,max,eq);
end;

end;

//busqueda acotada por dni, no pude hacerlo descendente (¿cambiar orden de ifs?)
procedure acotado(a:arbol;inf:integer;sup:integer);
begin
  if(a<>nil)then
   if(a^.info.dni>=inf)then
    if(a^.info.dni<=sup)then begin
      writeln('Dni: ', a^.info.dni, 'Nombre y apellido: ', a^.info.nombre, a^.info.apellido);
      acotado(a^.HI,inf,sup);
      acotado(a^.HD,inf,sup);
    end
    else acotado(a^.HI,inf,sup)
   else acotado(a^.HD,inf,sup);
  end;

procedure borrarlista (var l:listaint);
var
   aux: listaint;
begin
  while (l<>nil) do begin
    aux:=l;
    l:=l^.sig;
    dispose(aux);
  end;
end;

function vermin(a:arbol):integer;
begin
 if(a<>nil)then begin
    if(a^.HI <>nil)then begin
      vermin:=vermin(a^.HI);
    end
    else
      vermin:=a^.info.dni;
 end;
end;

function buscar(a:arbol; numero:integer; var encontro:boolean):arbol;
begin
 if(a<>nil)then begin
    if(a^.info.dni=numero)then begin
      encontro:=true;
      buscar:=a;
    end
    else begin
      if(numero<a^.info.dni)then
       buscar(a^.HI,numero,encontro)
       else
         if(numero>a^.info.dni)then
           buscar(a^.HD,numero,encontro);
    end;
    end;
 if(encontro=false)then
  buscar:=nil;
 end;

//borrar elementos
procedure borrarelemento(var a:arbol;dato:integer;var resultado:boolean);
var
   auxa:arbol; encontro:boolean;
begin
 encontro:=false;
 if(a=nil)then resultado:=false

   else if(a^.info.dni > dato)then
    borrarelemento(a^.HI,dato,resultado)

   else if(a^.info.dni <dato)then
    borrarelemento(a^.HD,dato,resultado)

      //encontre dato dato
      //si sus dos hijos apuntan a nil:
      else if ((a^.HD = nil) and (a^.HI = nil) ) then begin
           borrarlista(a^.lint);
           dispose(a);
           a:=nil;
           resultado:=true;
        end

      //tiene hijo der
      else if ((a^.HD <> nil) and (a^.HI = nil) ) then begin
           auxa:=a;
           a:=a^.HD;
           dispose(auxa);
           resultado:=true
         end

      //tiene hijo izq
      else if  ((a^.HI <> nil) and (a^.HD = nil) ) then begin
           auxa:=a;
           a:=a^.HI;
           dispose(auxa);
           resultado:=true
         end

      //SI TIENE DOS HIJOS
      else begin
        auxa:= buscar(a,dato,encontro);
        auxa^.info.dni:= vermin(a^.HD);
        borrarelemento(a^.HD,auxa^.info.dni,resultado);
     end
end;


//variables main
var
  a: arbol;
  p: partido;
  lp: listapartidos;
  maxgoles: integer;
  maxeq: string;
  inf, sup: integer;
  resultado: boolean;

begin
  //Dispongo:
  {leerpartido(p);
  cargarlistapartidos(p,lp);}

  //inicializo estructuras
  lp:=nil;
  a:=nil;
  recorrerl(a,lp);

  //inicializo maximos
  maxgoles:=-1;
  maxeq:= ' ';

  //busco maximo goleador e imprimo
  maximogoleador(a,maxgoles,maxeq);
  writeln('El mayor goleador del torneo esta en: ', maxeq ,' con: ', maxgoles);

  //inicializo valores para buscar dni
  inf:=28000000;
  sup:=32000000;

  //busco e imprimo (revisar)
  acotado(a,inf,sup);

  //borrar elemento con lista dentro
  resultado:=false;
  borrarelemento(a,34807474,resultado);
  readln();
end.

