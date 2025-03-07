Program ejercicio1REALIZADO; 
Uses
     sysutils;
Type
     str10= string[10];
     jugador = record
              dni: longint;
	          nombreApellido: string;
	          posicion: str10;
              puntaje: integer;
     end;

     lista = ^nodoLista;
     nodoLista = record
               dato: jugador;
               sig: lista;
     end;

     partido= record
               estadio: string;
               equipoLocal: string;
               equipoVisitante: string;
               fecha: str10;
               jugadores: lista;
     end;

     listaPartidos = ^nodoPartido;
     nodoPartido = record
               dato: partido;
               sig: listaPartidos;
     end;



     infoj =record
               dni: integer;
               nombreApellido: string;
               posicion:str10;
     end;
     partido2= record
               fecha: str10;
               puntaje: integer;
     end;
     lista2 = ^nodoLista2;
     nodoLista2 = record
               data: partido2;
               sig: lista2;
     end;
     // Arbol de enteros
  arbol= ^nodoA;
  nodoA = Record
    info: infoj;
    l2:lista2;
    HI: arbol;
    HD: arbol;
  End;

procedure cargarFecha(var s: str10);
var
  dia, mes: integer;
begin
  dia := random(30)+1;
  mes := random(12)+1;
  if(mes = 2) and (dia > 28)then
	dia := 31;
  if((mes = 4) or (mes = 6) or (mes =9) or (mes = 11)) and (dia = 31)then
	dia := 30;
  s := Concat('2022/',IntToStr(mes),'/',IntToStr(dia));
end;

Procedure agregar(var l: listaPartidos; p: partido);
var
   aux: listaPartidos;
begin
     new(aux);
     aux^.dato := p;
     aux^.sig := l;
     l:= aux;
end;

Procedure agregarJugador(var l: lista; j: jugador);
var
   aux: lista;
begin
     new(aux);
     aux^.dato := j;
     aux^.sig := l;
     l:= aux;
end;

procedure cargarJugadores(var l: lista);
var
   j: jugador;
   cant, i, pos: integer;
begin
     cant := random(10)+22;
     for i:=1 to cant do
     begin
          with(j) do begin
              dni := random(36000000)+20000000;
	      nombreApellido:= Concat('Jugador-', IntToStr(dni));
	      pos:= random(4)+1;
              case pos of
                1: posicion:= 'arquero';
                2: posicion:= 'defensa';
                3: posicion:= 'mediocampo';
                4: posicion:= 'delantero';
              end;
              puntaje:= random(10)+1;
          end;
          agregarJugador(l, j);
     end;
end;

procedure crearLista(var l: listaPartidos);
var
   p: partido;
   cant, i: integer;
begin
     cant := random(10);
     for i:=1 to cant do
     begin
          with(p) do begin
               estadio:= Concat('Estadio-', IntToStr(random (500)+1));
               equipoLocal:= Concat('Equipo-', IntToStr(random (200)+1));
               equipoVisitante:= Concat('Equipo-', IntToStr(random (200)+1));
               cargarFecha(fecha);
               jugadores:= nil;
               cargarJugadores(jugadores);
          end;
          agregar(l, p);
     end;
end;



procedure imprimirJugador(j: jugador);
begin
     with (j) do begin
          writeln('Jugador: ', nombreApellido, ' con dni ',dni, ' en posicion: ', posicion, ' y puntaje: ', puntaje);
     end;
end;

procedure imprimirJugadores(l: lista);
begin
     while (l <> nil) do begin
          imprimirJugador(l^.dato);
          l:= l^.sig;
     end;
end;

procedure imprimir(p: partido);
begin
     with (p) do begin
          writeln('');
          writeln('Partido en el ', estadio, ' entre ',equipoLocal, ' y ', equipoVisitante, ' jugado el: ', fecha, ' por los siguientes jugadores: ');
          imprimirJugadores(jugadores);
     end;
end;

procedure imprimirLista(l: listaPartidos);
begin
     while (l <> nil) do begin
          imprimir(l^.dato);
          l:= l^.sig;
     end;
end;

Procedure agregar2(var l: lista2; punt:integer; fecha:str10);
var
   aux: lista2;
begin
     new(aux);
     aux^.data.puntaje := punt;
     aux^.data.fecha := fecha;
     aux^.sig := l;
     l:= aux;
end;

Procedure insertar(var a: arbol; data:jugador;fecha:str10);
begin
   if (a = nil)then
    begin
      new (a);
      with(data)do begin
        a^.info.dni:=dni;
        a^.info.nombreApellido:=nombreApellido;
        a^.info.posicion:=posicion;
        a^.l2:=nil;

        agregar2(a^.l2,data.puntaje,fecha);

       end;
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.info.dni > data.dni then
      insertar(a^.HI,data,fecha)
    else
      if a^.info.dni < data.dni then
       insertar(a^.HD,data,fecha)
    else
      agregar2(a^.l2,data.puntaje,fecha);

  end;

procedure recorrerl(var a:arbol;l:listapartidos);
var
   dnia:integer;
begin
  while(l<>nil)do begin
    while (l^.dato.jugadores<>nil)do begin
      dnia:=l^.dato.jugadores^.dato.dni;
      if (dnia = l^.dato.jugadores^.dato.dni) then begin
        insertar(a,l^.dato.jugadores^.dato,l^.dato.fecha);
        l^.dato.jugadores:=l^.dato.jugadores^.sig;
      end;
    end;
    l:=l^.sig;
  end;
end;
procedure imprimira(l:lista2);
begin
  while(l<>nil)do begin
    writeln('la fecha es : ',l^.data.fecha);
    writeln('el puntaje es: ',l^.data.puntaje);
    l:=l^.sig;
  end;
end;
Procedure enOrden( a: arbol );
begin
  if ( a <> nil ) then begin
    enOrden (a^.HI);
    writeln(a^.info.dni);
    imprimira(a^.l2);
    enOrden (a^.HD)
  end;
end;

procedure imprimirb(l:lista2);
var
   puntajeint:integer;
begin
  puntajeint:=0;
  while(l<>nil)do begin
    puntajeint:=puntajeint+l^.data.puntaje;
    l:=l^.sig;
  end;
  writeln(puntajeint);
end;

Procedure puntob( a: arbol; pos: str10; var cantpos: integer );
begin
  if ( a <> nil ) then begin
    if (a^.info.posicion = pos) then cantpos:=cantpos+1;
    puntob (a^.HD,pos,cantpos);
    writeln(a^.info.dni);
    writeln(a^.info.nombreApellido);
    writeln(a^.info.posicion);
    imprimirb(a^.l2);
    puntob (a^.HI,pos,cantpos)
  end;
end;

procedure acotado(a:arbol;inf:integer;sup:integer;var cant:integer);
begin
  if(a<>nil)then
   if(a^.info.dni>=inf)then
    if(a^.info.dni<=sup)then begin
      cant:=cant+1;
      acotado(a^.HI,inf,sup,cant);
      acotado(a^.HD,inf,sup,cant);
    end
    else acotado(a^.HI,inf,sup,cant)
   else acotado(a^.HD,inf,sup,cant);
  end;

var
   l: listaPartidos;a:arbol;cant:integer;cantpos:integer; pos:str10;
begin
     Randomize;
     a:=nil;
     l:= nil;
     crearLista(l); {carga automática de la estructura disponible}
     writeln ('Lista generada: ');
     //imprimirLista(l);

     {Completar el programa}
     recorrerl(a,l);
     //enOrden(a);
     writeln('----------------------------------------------------');
     cantpos:=0;
     writeln ('pos?');
     readln(pos);
     puntob(a,pos,cantpos);
     writeln('Fin del programa');
     //cant:=0;
     //acotado(a,30000000,40000000,cant);
     writeln('la cantidad de jugadores es: ',cantpos);
     readln;
end.
