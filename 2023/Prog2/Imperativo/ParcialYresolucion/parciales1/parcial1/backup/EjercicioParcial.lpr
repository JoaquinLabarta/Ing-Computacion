program EjercicioParcial;
type
  {----------------------INFORMACION DADA--------------------------------------}
  str70= string[70];

  jugador = record
        DNI: longint;
	nombre_apellido: str70;
        equipo: str70;
	goles: integer;
  end;

     lista = ^nodoLista;
     nodoLista = record
	    dato: jugador;
	    sig: lista;
     end;

	fecha=record
		dia:1..31;
		mes:1..12;
		anio:integer;
	end;

    partido= record
		identificador: longint;
		local: str70;
		visitante: str70;
		fecha_partido: fecha;
                estadio: str70;
		goleadores: lista;
     end;

     listaPartidos = ^nodoPartidos;
     nodoPartidos = record
            dato: partido;
            sig: listaPartidos;
     end;

     nombres= array [1..20] of str70;

     {Completar con los tipos de datos necesarios}

  {----------------------INFORMACION AGREGADA--------------------------------------}

  // Arbol de enteros
  arbol= ^nodoA;
  nodoA = record
    dato: lista;
    HI: arbol;
    HD: arbol;
  end;

{---------------------PROCESOS Y FUNCIONES---------------------------------------}

{----------------------INFORMACION DADA--------------------------------------}
procedure cargarFecha(var f: fecha);
begin
  f.dia:= random(30)+1;
  f.mes := random(12)+1;
  if(f.mes = 2) and (f.dia > 28)then
	f.dia := 28
  else
	if((f.mes = 4) or (f.mes = 6) or (f.mes =9) or (f.mes = 11)) and (f.dia = 31)then
		f.dia := 30;
  f.anio:=2022;
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

procedure cargarEquipos(var v:nombres );
begin
     v[1]:='Atletico Tucuman';
     v[2]:='Huracan';
     v[3]:='Gimnasia LP';
     v[4]:='Godoy Cruz';
     v[5]:='Argentino Juniors';
     v[6]:='River';
     v[7]:='Boca';
     v[8]:='Racing';
     v[9]:='Platense';
     v[10]:='San Lorenzo';
     v[11]:='Patronato';
     v[12]:='Estudiantes';
     v[13]:='Union';
     v[14]:='Newells';
     v[15]:='Barracas';
     v[16]:='Tigre';
     v[17]:='Arsenal';
     v[18]:='Sarmiento';
     v[19]:='Central';
     v[20]:='Colon';
end;

procedure cargarJugadores(var l: lista; local, visitante:str70);
var
   j: jugador;
   cant, i, pos, loc_vis: integer;
   v: nombres;
begin
     cant := random(2);
     v[1]:='Lionel Perez';
     v[2]:='Martin Fernandez';
     v[3]:='Mariano Gomez';
     v[4]:='Alejandro Gonzalez';
     v[5]:='Fermin Martinez';
     v[6]:='Nicolas Castro';
     v[7]:='Gonzalo Villareal';
     v[8]:='Tadeo Parodi';
     v[9]:='Juan Pablo Silvestre';
     v[10]:='Mariano Sanchez';
     v[11]:='Alejo Monden';
     v[12]:='Agustin Paz';
     v[13]:='Juan Salto';
     v[14]:='Matias Pidone';
     v[15]:='Luis Hernandez';
     v[16]:='Cristian Herrera';
     v[17]:='Santiago Manzur';
     v[18]:='Julian Darino';
     v[19]:='Victor Abila';
     v[20]:='Luciano Segura';
     if((local='Colon')or(visitante='Colon'))then
     begin
        with(j) do begin
           DNI := 34807474;
           nombre_apellido:='Leandro Romanut';
		   equipo:='Colon';
		   goles:=random(3)+1;
        end;
        agregarJugador(l, j);
     end;
     for i:=1 to cant do
     begin
       with(j) do begin
          DNI := random(18000000)+20000000;;
          pos:= random(20)+1;
          nombre_apellido:= v[pos];
          loc_vis:= random(2)+1;
          if(loc_vis=1)then
            equipo:=local
          else
            equipo:=visitante;
	      goles:=random(3)+1;
       end;
       agregarJugador(l, j);
     end;
end;

procedure crearLista(var l: listaPartidos);
var
   p: partido;
   cant,i,pos,loc,vis: integer;
   v, v2: nombres;
begin
     cant := random(20)+1;
     v[1]:= 'Antonio Vespucio Liberti';
     v[2]:= 'Mario Alberto Kempes';
     v[3]:= 'Alberto Armando';
     v[4]:= 'Ciudad de La Plata';
     v[5]:= 'Presidente Peron';
     v[6]:= 'Jose Amalfitani';
     v[7]:= 'Tomas Adolfo Duco';
     v[8]:= 'Libertadores de America';
     v[9]:= 'Pedro Bidegain';
     v[10]:= 'Nestor Diaz Perez';
     v[11]:= 'Marcelo Bielsa';
     v[12]:= 'Gigante de Arroyito';
     v[13]:= 'Malvinas Argentinas';
     v[14]:= 'Brigadier General Estanislao Lopez';
     v[15]:= 'Eduardo Gallardon';
     v[16]:= 'Jose Maria Minella';
     v[17]:= 'Florencio Sola';
     v[18]:= 'Monumental Jose Fierro';
     v[19]:= 'Nueva España';
     v[20]:= 'Nuevo Francisco Urbano';
     cargarEquipos(v2);
     for i:=1 to cant do
     begin
          with(p) do begin
               identificador:= random (100000)+1;
               pos:= random(20)+1;
               estadio:= v[pos];
               loc:= random(20)+1;
               local:=v2[loc];
               vis:= random(20)+1;
               visitante:=v2[vis];
               while(local=visitante)do
               begin
                   vis:= random(20)+1;
                   visitante:=v2[vis];
               end;
               cargarFecha(fecha_partido);
               goleadores:= nil;
               cargarJugadores(goleadores, local, visitante);
          end;
          agregar(l, p);
       end;
end;


procedure imprimirJugador(j: jugador);
begin
     with (j) do begin
          writeln('JUGADOR: ', nombre_apellido, ' | DNI: ',DNI, ' | EQUIPO: ', equipo, ' | GOLES: ', goles);
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
          writeln('PARTIDO: ', identificador, ' | EQ. LOCAL: ',local, ' | EQ. VISITANTE: ', visitante, ' | FECHA: ', fecha_partido.dia,'/',fecha_partido.mes,'/',fecha_partido.anio, ' | ESTADIO: ', estadio);
          imprimirJugadores(goleadores);
     end;
end;

procedure imprimirLista(l: listaPartidos);
begin
     while (l <> nil) do begin
          imprimir(l^.dato);
          l:= l^.sig;
     end;
end;


{----------------------INFORMACION DADA--------------------------------------}

{agregarAdelante - Agrega nro adelante de l}
Procedure agregarAdelante(var l: lista; t: jugador);
var
   aux: lista;
begin
     new(aux);
     aux^.dato := t;
     aux^.sig := l;
     l:= aux;
end;


Procedure insertar(var a: arbol; inf:jugador);
begin
   if (a = nil)then
    begin
      new (a);
      a^.dato:=nil;
      agregarAdelante(a^.dato,inf);
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.dato^.dato.DNI> inf.dni then
      insertar(a^.HI, inf)
    else
      if a^.dato^.dato.DNI< inf.dni then
       insertar(a^.HD, inf)
    else
      agregarAdelante(a^.dato,inf);
  end;

procedure agregoinformacion(var a:arbol;listaint:partido);
begin
  while(listaint.goleadores<>nil)do begin// mientras la lista interna de jugadores no llegue al final
    insertar(a,listaint.goleadores^.dato);
    listaint.goleadores:=listaint.goleadores^.sig;
  end;
end;

procedure cargararbol(var a:arbol;lista:Listapartidos);
begin
  while(lista<>nil)do begin//mientras no llego al ultimo partido que avance
    agregoinformacion(a,lista^.dato);
    lista:=lista^.sig;
  end;
end;

procedure imprimirLista(l: lista);
begin
     while (l <> nil) do begin
          imprimirJugador(l^.dato);
          l:= l^.sig;
     end;
end;

Procedure enOrden( a: arbol );
begin
  if ( a <> nil ) then begin
    enOrden (a^.HI);
    imprimirLista(a^.dato);
    enOrden (a^.HD)
  end;
end;

Procedure enOrden2( a: arbol );
begin
  if ( a <> nil ) then begin
    enOrden2 (a^.HI);
    writeln(a^.dato^.dato.DNI);
    enOrden2 (a^.HD)
  end;
end;

procedure recorrerycontar(l:lista;var act:integer);
begin
act:=0;
while(l<>nil)do begin
       act:=act+l^.dato.goles;
       l:=l^.sig;
    end;
end;

procedure Maximog(a:arbol;var maximo:integer;var equipm:str70;var act:integer);
begin
  if ( a <> nil ) then begin
    Maximog (a^.HI,maximo,equipm,act);
    recorrerycontar(a^.dato,act);
    if(act>maximo)then begin
      maximo:=act;
      equipm:=a^.dato^.dato.equipo;
    end;
    Maximog (a^.HD,maximo,equipm,act)
  end;
end;


procedure Acotado(a:arbol;inf:longint;sup:longint);
begin
  if(a<>nil)then
   if(a^.dato^.dato.DNI>inf)then
    if(a^.dato^.dato.DNI<sup)then begin
     with a^.dato^.dato do begin
       writeln('el nombre y el apellido es : ',a^.dato^.dato.nombre_apellido);
       writeln('el dni es : ',dni);
      end
     end
    else
    acotado(a^.HI,inf,sup)
   else
    acotado(a^.HD,inf,sup);
end;



function vermin(a:arbol):integer;
begin
 if(a<>nil)then begin
    if(a^.HI <>nil)then begin
      vermin:=vermin(a^.HI);
    end
    else
      vermin:=a^.dato^.dato.DNI;
 end;
end;

function buscar(a:arbol;numero:integer;var encontro:boolean):arbol;
begin
 if(a<>nil)then begin
    if(a^.dato^.dato.DNI=numero)then begin
      encontro:=true;
      buscar:=a;
    end
    else begin
      if(numero<a^.dato^.dato.DNI)then
       buscar(a^.HI,numero,encontro)
       else
         if(numero>a^.dato^.dato.DNI)then
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
 else if(a^.dato^.dato.DNI >dato)then begin borrarelemento(a^.HI,dato,resultado) end
 else if(a^.dato^.dato.DNI<dato )then begin borrarelemento(a^.HD,dato,resultado)  end
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
        auxa^.dato^.dato.DNI:=vermin(a^.HD);
        borrarelemento(a^.HD,auxa^.dato^.dato.DNI,resultado);
     end
end;

{---------------------PROGRAMA PRINCIPAL------------------------------------------}
var
  a:arbol;
  l:Listapartidos;
  maximo:integer;
  equipm:str70;
  act:integer;
  resultado:boolean;

begin
  Randomize;
  l:= nil;
  crearLista(l); {carga automatica de la estructura disponible}
  writeln ('LISTA GENERADA: ');
  imprimirLista(l);

  //completado por mi
  {---------------------PUNTO A------------------------------------------}
  a:=nil;
  cargararbol(a,l);
  writeln();
  writeln('punto A');
  writeln();
  //imprimir arbol
  enOrden(a);
  {---------------------PUNTO B------------------------------------------}
  writeln();
  writeln('punto B');
  writeln();
  maximo:=0;
  Maximog(a,maximo,equipm,act);
  writeln('EL EQUIPO QUE CONTIENE AL GOLEADOR DEL TORNEO ES : ',equipm,' Y LA CANTIDAD DE GOLES QUE METIO ES : ',maximo);
  {---------------------PUNTO C------------------------------------------}
  writeln();
  writeln('punto C');
  writeln();
  acotado(a,28000000,32000000);
  {---------------------PUNTO D------------------------------------------}
  writeln();
  writeln('punto D');
  writeln();
  writeln('ESTE ES EL ARBOL ANTES DEL BORRADO');
  enOrden2(a);
  borrarelemento(a,34807474,resultado);
  writeln();
  writeln(resultado);
  writeln();
  writeln('ESTE ES EL ARBOL DESPUES DEL BORRADO');
  enOrden2(a);
  readln();
end.

