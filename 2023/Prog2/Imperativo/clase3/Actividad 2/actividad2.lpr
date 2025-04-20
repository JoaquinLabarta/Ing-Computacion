program actividad2;
Uses
     sysutils;
Type
     tweet = record   //informacion
	      codigoUsuario: integer;
	      nombreUsuario: string;
	      mensaje: string;
	      esRetweet: boolean;
     end;

     listaTweets = ^nodoLista; //lista donde se almacena la informacion
     nodoLista = record
               dato: tweet;
               sig: listaTweets;
     end;

     arbol= ^nodoA;  //arbol
     nodoA = Record
      dato: tweet;
      HI: arbol;
      HD: arbol;
    End;

     listaNivel = ^nodoN;  //lista para inprimir por nivel
       nodoN = record
       dato: arbol;
       sig: listaNivel;
  end;


procedure agregarOrdenado(var pri:listaTweets; t:tweet);   //agrega info ordenada a la lista
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


Procedure agregarAdelante(var l: listaTweets; t: tweet);      //agrega informacion a la lista
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
procedure imprimirl(t: tweet);
begin
     with (t) do begin
          write('Tweet del usuario @', nombreUsuario, ' con codigo ',codigoUsuario, ': ', mensaje, ' RT:');
          if(esRetweet)then
               writeln(' Si')
          else
               writeln('No ');
     end;
end;


function ContarElementos (l: listaNivel): integer;   //cuenta cantidad de elementos por nivel
  var c: integer;
begin
 c:= 0;
 While (l <> nil) do begin
   c:= c+1;
   l:= l^.sig;
 End;
 contarElementos := c;
end;

Procedure AgregarAtras (var l, ult: listaNivel; a:arbol);//agrega los elementos a la lista por nivel
 var nue:listaNivel;

 begin
 new (nue);
 nue^.dato := a;
 nue^.sig := nil;
 if l= nil then l:= nue
           else ult^.sig:= nue;
 ult:= nue;
 end;

procedure imprimir(t: tweet); //imprimir nodo
begin
     with (t) do begin
          write('Tweet del usuario @', nombreUsuario, ' con codigo ',codigoUsuario, ': ', mensaje, ' RT:');
          if(esRetweet)then
               writeln(' Si')
          else
               writeln('No ');
     end;
end;

Procedure imprimirpornivel(a: arbol);   //imprime el arbol por nivel
var
   l, aux, ult: listaNivel;
   nivel, cant, i: integer;
begin
   l:= nil;
   if(a <> nil)then begin
                 nivel:= 0;
                 agregarAtras (l,ult,a);
                 while (l<> nil) do begin
                    nivel := nivel + 1;
                    cant:= contarElementos(l);
                    write ('Nivel ', nivel, ': ');
                    for i:= 1 to cant do begin
                      imprimir (l^.dato^.dato);
                      if (l^.dato^.HI <> nil) then agregarAtras (l,ult,l^.dato^.HI);
                      if (l^.dato^.HD <> nil) then agregarAtras (l,ult,l^.dato^.HD);
                      aux:= l;
                      l:= l^.sig;
                      dispose (aux);
                     end;
                     writeln;
                 end;
               end;
end;

Procedure insertar(var a: arbol; twt:tweet); // agarrar nodo lista original he insertarla en el arbol
begin
   if (a = nil)then
    begin
      new (a);
      a^.dato:= twt;
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.dato.codigoUsuario> twt.codigoUsuario then
      insertar(a^.HI, twt)
    else
      if a^.dato.codigoUsuario< twt.codigoUsuario then
       insertar(a^.HD, twt)
  end;

var
l, l_ordenada: listaTweets; a: arbol;

begin
  Randomize;

     l:= nil;
     crearLista(l);
     writeln ('Lista generada: ');
     imprimirLista(l);


     {Completar el programa}
     a:=nil;
     while l <> nil do
       begin
         insertar(a,l^.dato);
         l:=l^.sig;
       end;
     imprimirpornivel(a);
     readln();

end.

