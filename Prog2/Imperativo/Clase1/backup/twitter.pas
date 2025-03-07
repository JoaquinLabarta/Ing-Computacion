Program twitter;
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

     ListaInt = ^nodoInt;
     nodoInt = record
              mensajetw:string;
              sig:ListaInt;
              end;

      DatoListaOrd= record
                   list:ListaInt;
                   nombre:string;
                   end;


     ListaOrd = ^nodo;
     nodo = record
          datos:DatoListaOrd;
          sig:ListaOrd;
          end;






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



procedure AgregarAlFinal (var pri: ListaInt; p: string);
var act, nue : ListaInt;
begin
new (nue);
p:=nue^.mensajetw;
nue^.sig := NIL;
if pri <> Nil then begin
 act := pri ;
 while (act^.sig <> NIL ) do act := act^.sig ;
 act^.sig := nue ;
 end
 else
 pri:= nue;
end;

procedure AgregarAlFinal2 (var pri: ListaOrd; m: string);
var act, nue : ListaOrd;
begin
new (nue);
nue^.datos.nombre:= m;
nue^.sig:=nil;
if pri <> Nil then begin
 act := pri ;
 while (act^.sig <> NIL ) do act := act^.sig ;
 act^.sig := nue ;
 end
 else
 pri:= nue;
end;

procedure RecorrerLista(l:listaTweets; var ListaO:ListaOrd);
var
  actnombre:string;
begin


  while (l <> nil) do begin
        actnombre:=l^.dato.nombreUsuario;
        AgregarAlFinal2(ListaO,actnombre); //marcas

        ListaO^.datos.list := NIL;
        while (l <> nil) and (actnombre = l^.dato.nombreUsuario) do begin
              AgregarAlFinal(ListaO^.datos.list,l^.dato.mensaje);
              l:=l^.sig;
              end;
     	end;
end;


procedure imprimirListinterna (l: ListaInt);
begin
writeln ('Imprime lista nueva ----------');
	while (l<>nil)  do begin
                 writeln(l^.mensajetw);
                 l:= l^.sig;
           end;
end;

procedure ImprimirListaOrdenada(ListaO:ListaOrd);

begin

     while (ListaO <> nil) do begin

           writeln('La marca es ', ListaO^.datos.marca);
           imprimirListinterna (Listao^.datos.list);
           ListaO:= ListaO^.sig;

     end;

end;


var
   l, l_ordenada: listaTweets;ListaO:ListaOrd;
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

     writeln('Fin del programa');
     readln;

     ListaO:=nil;
     writeln ('generando lista nueva');

     RecorrerLista(l_ordenada,ListaO);

     writeln();
     writeln('Lista nueva');
     ImprimirListaOrdenada(ListaO);
     readln();
end.
