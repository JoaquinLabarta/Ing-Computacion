{El torneo de la Liga Profesional de Fútbol Argentino posee el registro de los partidos y equipos del Torneo 2022 al día
de la fecha. Para ello, dispone de una estructura que almacena la siguiente información de cada partido: identificador
de partido, equipo local, equipo visitante, fecha (día, mes y año) del partido, el estadio donde se jugó y un listado de
los jugadores que realizaron algún gol durante el partido. De cada jugador se conoce: DNI, nombre y apellido, equipo
al que pertenece y cantidad de goles efectuados.

A fines de obtener y sintetizar, de manera rápida, la información de los jugadores y sus goles, se necesita reorganizar
la información de la siguiente manera:

a) Crear una nueva estructura que almacene para cada jugador su DNI, nombre y apellido, equipo al que pertenece, y
el listado de las fechas junto a la cantidad de goles realizados en cada una de estas fechas. Esta estructura debe estar
ordenada por DNI, y debe ser eficiente para la búsqueda por dicho criterio.


Al finalizar el procesamiento de a), elijan las estructuras adecuadas para:
b) Implementar un módulo que devuelva en qué equipo está el mayor goleador del Torneo 2022.
c) Implementar un módulo que imprima los DNI, Nombre y Apellido de los jugadores cuyo número de DNI está entre
28000000 y 32000000. El listado debe estar ordenado por DNI de manera ascendente.
d) Implementar un módulo que busque y elimine de la estructura al jugador con DNI 34807474. Antes y después de
este proceso, debe mostrar la estructura para ver cómo cambió.
e) Implementar un programa principal que utilice los módulos desarrollados e informe lo que corresponda.}


Program TPGrupo05;
Uses
     sysutils;
Type
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
     // ------------TYPE PROPIO -----------------

      // Árbol con contador y lista


    jugador2 = record
             dni:integer;
             nombreApellido:string;
             equipo:string;
     end;

    partido2 = record
            f:fecha;
            cantGoles:integer;
    end;

    // LISTA DE PARTIDOS CON GOLES
    listaP = ^nodoL;
    nodoL = record
          dato:partido2;
          sig:listaP;
    end;

    // ÁRBOL DE JUGADORES
    arbol= ^nodoA;
    nodoA = record
     dato: jugador2;
     HI: arbol;
     HD: arbol;
    // cant:integer; //contador
     lista:listaP; // puntero a lista de fechas con cantidad de goles
    end;




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



{----------------------MÓDULOS PROPIOS------------------------}

// COPIAMOS DATOS
procedure CopiarDatos(d:jugador; var j:jugador2);
begin
     j.dni:= d.DNI;
     j.nombreApellido:= d.nombre_apellido;
     j.equipo:= d.equipo;
end;


//  COPIAMOS DATOS PARA INSERTAR A LISTA
procedure CopiarDatosDeLista(fe:fecha; goles:integer; var datoLista:partido2);
begin
  datoLista.f:= fe;
  datoLista.cantGoles:= goles;
end;




{-----------------------------------------------------------------------------
AgregarAdelante - Agrega nro adelante de l}
procedure agregarAdelante(var l: listaP; datoLista:partido2);
var
  aux: listaP;
begin
  new(aux);
  aux^.dato := datoLista;
  aux^.sig := l;
  l:= aux;
end;




{-----------------------------------------------------------------------------
INSERTAR AL ARBOL - tratamiento de repetidos  }

procedure Insertar(var a:arbol; j:jugador2; datoLista:partido2);
begin
     if (a = nil) then begin

        new(a);
        a^.dato:= j;
        a^.HI:= nil;
        a^.HD:= nil;
        a^.lista:=nil;     // CASO LISTA inicializamos lista
        agregarAdelante (a^.lista,datoLista);  //agregamos fecha y goles a la lista

     end
     else begin
         if (a^.dato.dni > j.dni) then
            Insertar(a^.HI,j,datoLista)
         else begin
            if (a^.dato.dni < j.dni) then
               Insertar(a^.HD,j,datoLista)
            else begin //el dato es REPETIDO
             agregarAdelante (a^.lista,datoLista);
            end;
         end;
     end;

end;


//--------------------------------- PUNTO B -----------------------------------------

 procedure RecorrerListaInterna (l:listaP; var cantG: integer);  //recorre lista de fechas con cantidad de goles

    begin
        while (l <> nil) do begin
            cantG:= cantG + l^.dato.cantGoles;
            l:=l^.sig;
        end;
    end;



{-----------------------------------------------------------------------------
 BUSCA EL PUNTAJE MAXIMO ENTRE LOS DATOS EN ARBOL CON LISTA INTERNA}

procedure MaximoGoles(a:arbol; var max:integer; var nombreMax:string);
var
   cantG:integer;
begin

  cantG:=0;
  if ( a <> nil ) then begin 

    RecorrerListaInterna(a^.lista,cantG);
    if (cantG > max) then begin // guardamos la cantidad de goles en el maximo
       max:= cantG;
       nombreMax:= a^.dato.equipo;
       MaximoGoles(a^.HI,max,nombreMax);
       MaximoGoles(a^.HD,max,nombreMax);
    end
    else begin  // como no es mayor seguimos buscando
       MaximoGoles(a^.HI,max,nombreMax);
       MaximoGoles(a^.HD,max,nombreMax);
    end;
  end;

end;



function MejorEquipo(a:arbol):string;
var
   max:integer;
   nombreMax:string;

begin
    max:= -1;
    MaximoGoles(a,max,nombreMax);
    MejorEquipo:= nombreMax;
end;



//---------------------------PUNTO C------------------------------------

{-----------------------------------------------------------------------------
BUSCA VALOR EN RANGO - imprime }
procedure RecorridoAcotado(a: arbol; inf:integer; sup:integer);
begin
    writeln('entro al RECORRIDO ACOTADO');
  if (a <> nil) then // mientras no se termine el arbol
    if (a^.dato.dni >= inf) then BEGIN // si el valor en arbol es mayor o igual al lim inferior
        writeln('ENTROOOOO ');
      if (a^.dato.dni <= sup) then begin // si el valor en arbol es menor o igual al lim superior
        writeln('El dni del jugador ',a^.dato.nombreApellido, 'es: ', a^.dato.dni, ' ');
        RecorridoAcotado(a^.HD, inf, sup); //le cambie que arranque con HD
        RecorridoAcotado (a^.HI, inf, sup); //aca con HI

      end
      else
        RecorridoAcotado(a^.HI, inf, sup)
    end
    else
      RecorridoAcotado(a^.HD,inf,sup)
end;

//?????????????? REVISAR SI IMPRIME DE MANERA ASCENDENTE O DESCENDENTE

//------------------- PUNTO D --------------------------------------------

{-----------------------------------------------------------------------------
IMRPIME EL ARBOL en orden - izq, raíz, derecho - Menor a Mayor}

procedure enOrden(a:arbol);
begin
     if (a <> nil) then begin
        enOrden(a^.HI);
        writeln('JUGADOR: ');
        writeln(a^.dato.dni,' ');
        writeln(a^.dato.nombreApellido,' ');
        writeln(a^.dato.equipo,' ');
        writeln();
        enOrden(a^.HD);
     end;
end;

{-----------------------------------------------------------------------------
BUSCA VALOR EN EL ARBOL}
function buscar(a: arbol; dato: integer): arbol;
begin
    if (a <> nil) then begin
        if (a^.dato.dni = dato) then buscar:= a
        else if (dato < a^.dato.dni) then buscar:= buscar(a^.HI, dato)
        else if (dato > a^.dato.dni) then buscar:= buscar(a^.HD, dato);
    end else buscar:= nil;
end;

{-----------------------------------------------------------------------------
BUSCA VALOR MÍNIMO DEL ARBOL}
function verMin(a:arbol):integer;
begin
     if (a <> nil) then
        if (a^.HI = nil) then begin  //caso base
           verMin:=a^.dato.dni
        end
        else begin
           verMin:= verMin(a^.HI);
     end
     else begin
         verMin:= -1
     end;
end;

{-----------------------------------------------------------------------------
BORRA ELEMENTO DEL ARBOL}

procedure BorrarElemento(var a:arbol; valor:integer);
var
   aux:arbol;
begin

  if (a = nil) then
    writeln('No se encontro el dato a borrar ')
  else begin
     if (valor < a^.dato.dni) then
        BorrarElemento(a^.HI,valor)
     else begin
        if (valor > a^.dato.dni) then
          BorrarElemento(a^.HD,valor)
        else begin
          //ENCONTRÉ EL VALOR A BORRAR
          if ((a^.HD = nil) and (a^.HI = nil)) then begin // si es una hoja
             dispose(a);
             a:=nil;
             writeln('Se borro - es una hoja');
          end
          else begin
            if ((a^.HD <> nil) and (a^.HI = nil)) then begin // si tiene hijo derecho
               aux:= a;
               a:= a^.HD;
               dispose(aux);
               writeln('Se borro - hijo derecho ');
            end
            else begin
               if ((a^.HI <> nil) and (a^.HD = nil)) then begin // si tiene hijo izquierdo
                  aux:= a;
                  a:= a^.HI;
                  dispose(aux);
                  writeln('Se borro - hijo izquierdo ');
               end
               else begin // si tiene dos hijos

                 aux:= Buscar(a,valor); //guarda direc de memoria del dato a borrar
                 aux^.dato.dni:= verMin(aux^.HD); //se intercambia el valor del minimo por el q se quiere borrar (mas a la izquiera del subarbol derecho)
                 BorrarElemento(a^.HD,aux^.dato.dni);

               end;
            end;
          end;
        end;
     end;
  end;

end;






var
   l,aux: listaPartidos;
   a:arbol;
   fe:fecha;
   j:jugador2;
   datoLista:partido2;

begin
     Randomize;

     l:= nil;
     crearLista(l); {carga automatica de la estructura disponible}
     writeln ('LISTA GENERADA: ');
     imprimirLista(l);
     writeln();
     writeln('------------------------------------------------------------');
     {Completar el programa}

  //a) Crear una nueva estructura que almacene para cada jugador su DNI, nombre y apellido, equipo al que pertenece, y
  //el listado de las fechas junto a la cantidad de goles realizados en cada una de estas fechas. Esta estructura debe estar
  //ordenada por DNI, y debe ser eficiente para la búsqueda por dicho criterio.

    a:=nil;
    aux:=l;
    while(aux<>nil)do begin
      fe:= aux^.dato.fecha_partido;
      while (aux^.dato.goleadores <> nil) do begin

        CopiarDatos(aux^.dato.goleadores^.dato,j);
        CopiarDatosDeLista(fe,aux^.dato.goleadores^.dato.goles,datoLista);

        Insertar(a,j,datoLista);

        aux^.dato.goleadores:= aux^.dato.goleadores^.sig;

      end;
      aux:=aux^.sig;

    end;

   //b) Implementar un módulo que devuelva en qué equipo está el mayor goleador del Torneo 2022.

   writeln();
   writeln('El equipo en el que esta el mayor goleador es: ', MejorEquipo(a));

    //c) Implementar un módulo que imprima los DNI, Nombre y Apellido de los jugadores cuyo número de DNI está entre
    //28000000 y 32000000. El listado debe estar ordenado por DNI de manera ascendente.

     writeln();
     writeln('Imprime jugadores cuyo número de DNI está entre 28000000 y 32000000');
     writeln();
     RecorridoAcotado(a,28000000,32000000);

     //d) Implementar un módulo que busque y elimine de la estructura al jugador con DNI 34807474. Antes y después de
      //este proceso, debe mostrar la estructura para ver cómo cambió.

       writeln();
       writeln('Imprime el arbol en orden');
       enOrden(a);
       writeln();

       BorrarElemento(a,34807474);


       writeln();
       writeln('Imprime el arbol modificado en orden');
       enOrden(a);
       writeln();


     writeln('Fin del programa');
     readln;
end.
