{Twitter dispone de una lista simple con los tweets realizados durante los últimos
5 segundos. De cada tweet se conoce: el código y nombre de usuario que lo
generó, el contenido del mensaje y si el mismo es o no un retweet. Esta
información no tiene ningún orden y se debe tener en cuenta que podrían
existir en la lista varios tweets del mismo usuario.

Se pide:
a)Realice un módulo que reciba la lista con los tweets y genere una nueva
estructura donde para cada usuario se almacene la cantidad de mensajes
publicados. Esta estructura debe estar ordenada por código de usuario y
debe ser eficiente para la búsqueda por dicho criterio.

Una vez generado el árbol:
b)Informar la cantidad de tweets de los usuarios con código entre
100 y 700.
c)Informar el nombre del usuario con mayor cantidad de tweets.
¿Qué cambiaría del ejercicio implementado si la lista inicial
         fuera una lista de listas? (Del usuario y sus tweets)}
program Parcial2;
Uses
     sysutils;
Type
     tweet = record
	      codigoUsuario: integer;
	      nombreUsuario: string;
	      mensaje: string;
	      esRetweet: boolean;
     end;

     listaTweets = ^nodoLista;
     nodoLista = record
               dato: tweet;
               sig: listaTweets;
     end;
{Completar agregando aquí las estructuras de datos necesarias en el ejercicio}
arbol= ^nodoA;
  nodoA = Record
    dato: listaTweets;
    HI: arbol;
    HD: arbol;
  End;

{---------------------PROCESOS Y FUNCIONES----------------------------------}

{agregarAdelante - Agrega nro adelante de l}
Procedure agregarAdelante(var l: listaTweets; t: tweet);
var
   aux: listaTweets;
begin
     new(aux);
     aux^.dato := t;
     aux^.sig := l;
     l:= aux;
end;



{crearLista - Genera una lista con tweets aleatorios}
procedure crearLista(var l: listaTweets);
var
   t: tweet;
   texto: string;
   v : array [1..10] of string;
begin
     v[1]:= 'juan';
     v[2]:= 'pedro';
     v[3]:= 'carlos';
     v[4]:= 'julia';
     v[5]:= 'mariana';
     v[6]:= 'gonzalo';
     v[7]:='alejandro';
     v[8]:= 'silvana';
     v[9]:= 'federico';
     v[10]:= 'ruth';

     t.codigoUsuario := random(11);
     while (t.codigoUsuario <> 0) do Begin
          texto:= Concat(v[t.codigoUsuario], '-mensaje-', IntToStr(random (200)));
          t.nombreUsuario := v[t.codigoUsuario];
          t.mensaje := texto;
          t.esRetweet := (random(2)=0);
          agregarAdelante(l, t);
          t.codigoUsuario := random(11);
     end;
end;


{imprimir - Muestra en pantalla el tweet}
procedure imprimir(t: tweet);
begin
     with (t) do begin
          write('Tweet del usuario @', nombreUsuario, ' con codigo ',codigoUsuario, ': ', mensaje, ' RT:');
          if(esRetweet)then
               writeln(' Si')
          else
               writeln('No ');
     end;
end;


{imprimirLista - Muestra en pantalla la lista l}
procedure imprimirLista(l: listaTweets);
begin
     while (l <> nil) do begin
          imprimir(l^.dato);
          l:= l^.sig;
     end;
end;


{agregarElemento - Resuelve la inserción de la estructura ordenada}
procedure agregarOrdenado(var pri:listaTweets; t:tweet);
var
   nuevo, anterior, actual: listaTweets;
begin
     new (nuevo);
     nuevo^.dato:= t;
     nuevo^.sig := nil;
     if (pri = nil) then
          pri := nuevo
     else
     begin
          actual := pri;
          anterior := pri;
          while (actual<>nil) and (actual^.dato.nombreUsuario < nuevo^.dato .nombreUsuario) do begin
               anterior := actual;
               actual:= actual^.sig;
          end;
          if (anterior = actual) then
               pri := nuevo
          else
               anterior^.sig := nuevo;
          nuevo^.sig := actual;
     end;
end;


{generarNuevaEstructura - Resuelve la generación estructura ordenada}
procedure generarNuevaEstructura (lT: listaTweets; VAR listaOrdenada: listaTweets);
begin
     listaOrdenada := nil;
     while(lT <> nil) do begin
          agregarOrdenado(listaOrdenada, lT^.dato);
          lT := lT^.sig;
     end;
end;


Procedure insertar(var a: arbol; t:tweet);
begin
   if (a = nil)then
    begin
      new (a);
      a^.dato:= nil;
      agregarAdelante(a^.dato,t);
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.dato^.dato.codigoUsuario> t.codigoUsuario then
      insertar(a^.HI, t)
    else
      if a^.dato^.dato.codigoUsuario< t.codigoUsuario then
       insertar(a^.HD, t)
    else
      agregarAdelante(a^.dato,t);

  end;


procedure recorrerlista(var a:arbol;l:listaTweets);
begin
     while(l<>nil)do begin
          insertar(a,l^.dato);//agarro el dato y lo meto en el arbol
          l:=l^.sig;
     end;
end;

Procedure enOrden( a: arbol );
begin
  if ( a <> nil ) then begin
    enOrden (a^.HI);
    write (a^.dato^.dato.codigoUsuario);
    write(' Y SU NOMBRE ES : ');
    writeln (a^.dato^.dato.nombreUsuario);
    enOrden (a^.HD)
  end;
end;

procedure acotado(a:arbol;inf:integer;sup:integer;var cant:integer);
begin
  if(a<>nil)then
   if(a^.dato^.dato.codigoUsuario>=inf)then
    if(a^.dato^.dato.codigoUsuario<=sup)then begin
      cant:=cant+1;
      acotado(a^.HI,inf,sup,cant);
      acotado(a^.HD,inf,sup,cant);
    end
    else acotado(a^.HI,inf,sup,cant)
   else acotado(a^.HD,inf,sup,cant);
  end;

function contar(l:listaTweets):integer;
var
   cant:integer;
begin
  cant:=0;
  while(l<>nil)do begin
       cant:=cant+1;
       l:=l^.sig;
  end;
  contar:=cant;
end;

procedure recorroarbol(a:arbol;var nomu:string;var cantweets:integer);
begin
  if ( a <> nil ) then begin
    recorroarbol (a^.HI,nomu,cantweets);
    if(cantweets<contar(a^.dato))then begin
      cantweets:=contar(a^.dato);
      nomu:=a^.dato^.dato.nombreUsuario;
    end;
    recorroarbol (a^.HD,nomu,cantweets)
  end;
end;


var
  l, l_ordenada: listaTweets;
  a:arbol;
  cant:integer;
  nomu:string;
  cantweets:integer;

begin
     Randomize;

     l:= nil;
     crearLista(l);
     writeln ('Lista generada: ');
     imprimirLista(l);

     {Se crea la estructura ordenada}
     l_ordenada:= nil;
     generarNuevaEstructura(l,l_ordenada);
     writeln ('Lista ordenada: ');
     imprimirLista(l_ordenada);

     {Completar el programa}
     writeln('-----------------------------------------------------------------');
     writeln();
     writeln('PUNTO A');
     writeln();
     a:=nil;
     recorrerlista(a,l);//recorre lista y agrega informacion al arbol
     enOrden(a);
     writeln('-----------------------------------------------------------------');
     writeln();
     cant:=0;
     writeln('PUNTO B');
     writeln();
     acotado(A,1,7,cant);
     writeln('LA CANTIDAD DE TWEET QUE ESTAN EN EL INTERVALO ES :',cant);
     writeln('-----------------------------------------------------------------');
     cantweets:=0;
     writeln();
     writeln('PUNTO C');
     writeln();
     recorroarbol(a,nomu,cantweets);
     writeln('EL NOMBRE DE USUARIO QUE TIENE MAS TWEETS ES : ',nomu, '  Y SU CANTIDAD DE TWEETS SON ',cantweets);
     writeln('-----------------------JUSTIFICACION QUE NO PIERDO PUNTEROS------------------------------------------');
     writeln();
     writeln('JUSTIFICACION QUE NO PIERDO PUNTEROS');
     writeln();
     imprimirLista(l);
     readln();

end.

