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
               sig: listaTweets;
               dato: tweet;
     end;

     {Completar agregando aquí las estructuras de datos necesarias en el ejercicio}

     usuario = record
               codigoUser: integer;
               canttw: integer;
     end;

     arbol = ^nodoa;
     nodoa = record
               info: usuario;
               HI:arbol;
               HD:arbol;
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
begin
     t.codigoUsuario := random(2000);
     while (t.codigoUsuario <> 0) do Begin
          texto:= Concat(IntToStr(t.codigoUsuario), '-mensaje-', IntToStr(random (200)));
          t.nombreUsuario := Concat('Usuario-',IntToStr(t.codigoUsuario));
          t.mensaje := texto;
          t.esRetweet := (random(2)=0);
          agregarAdelante(l, t);
          t.codigoUsuario := random(2000);
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

{insertar datos en el arbol}
Procedure insertar(var a: arbol; cod:integer);
begin
   if (a = nil)then begin
      new (a);
      a^.info.codigoUser:=cod;
      a^.info.canttw:=1;
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.info.codigoUser > cod then
      insertar(a^.HI, cod)
    else
      if a^.info.codigoUser < cod then
       insertar(a^.HD, cod)
    else
      a^.info.canttw:=a^.info.canttw+1;
  end;

{recorre lista main y llama a insertar}
procedure recorrerl(var a:arbol; l:listaTweets);
begin
   while (l<>nil) do begin
        insertar(a,l^.dato.codigoUsuario);
        l:=l^.sig;
   end;
end;

{busqueda de un valor maximo en el arbol}
Procedure maximo( a: arbol; var max: integer; var cod: integer );
begin
  if ( a <> nil ) then begin
     if (a^.info.canttw > max) then begin
        max:=a^.info.canttw;
        cod:=a^.info.codigoUser;
     end;
  maximo (a^.HI,max,cod);
  maximo (a^.HD,max,cod);
  end;
end;

{recorrido acotado del arbol}
procedure Acotado(a:arbol;inf:integer;sup:integer);
begin
  if(a<>nil)then
   if(a^.info.codigoUser>inf)then
    if(a^.info.codigoUser<sup)then begin
     with a^.info do begin
       writeln('el codigo es : ',codigoUser);
       writeln('la cantidad de tweet es : ',canttw);
      end;
        Acotado(a^.HI,inf,sup);
        Acotado(a^.HD,inf,sup);
     end
    else
    Acotado(a^.HI,inf,sup)
   else
    Acotado(a^.HD,inf,sup);
end;



var
   l: listaTweets;
   a: arbol;
   aux:listaTweets;
   max: integer;
   codmax: integer;
begin
     Randomize;

     l:= nil;
     crearLista(l);
     writeln ('Lista generada: ');
     imprimirLista(l);

     {Completar el programa}
     a:=nil;
     aux:=l;
     {inserto en arbol}
     recorrerl(a,aux);
     {busco acotado}
     acotado(a,100,700);
     {declaro maxs}
     max:=-1;
     codmax:=0;
     maximo(a,max,codmax);
     writeln('El codigo con mas tw es: ',codmax, ' con ',max,' tweets');


     writeln('Fin del programa');
     readln;
end.
