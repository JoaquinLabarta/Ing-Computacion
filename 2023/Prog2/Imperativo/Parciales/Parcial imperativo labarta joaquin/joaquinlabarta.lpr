program joaquinlabarta;
type
 //fechas
 fechas = record
   dia: 1..31;
   mes: 1..12;
   anio: integer;
 end;

 //informacion de la lista main
 mascota = record
   id: integer;
   animal: string;
   peso: integer;
   fecha: fechas;
   cantint: integer;
   dni: longint;
   nombreapellido: string;
   direccion: string;
 end;

 //lista main
 lista = ^nodo;
 nodo = record
   info: mascota;
   sig: lista;
 end;

 //informacion de la lista interna del cliente en el arbol
 mascotaint = record
   id: integer;
   animal: string;
   peso: integer;
   fecha: fechas;
   cantint: integer;
 end;

 //lista interna del cliente en arbol
 listaint = ^nodoint;
 nodoint = record
   dato: mascotaint;
   sig: listaint;
 end;

 //informacion principal del arbol
 cliente = record
   dni: longint;
   nombreapellido: string;
   direccion: string;
   lista: listaint;
 end;

 //arbol
 arbol = ^nodoarb;
 nodoarb = record
   info: cliente;
   HI: arbol;
   HD: arbol;
   end;

//Leo manualmente la informacion de las mascotas y de su dueño
procedure leermascota (var m:mascota);
begin
  with (m) do begin
    writeln('Ingrese el dni del dueno');
    readln(dni);

    //Aplico corte de control para no cargar datos innecesarios
    if (dni<>90909090) then begin
        writeln('Ingrese el nombreapellido del dueno');
        readln(nombreapellido);
        writeln('Ingrese la direccion del dueno');
        readln(direccion);
        writeln('Ingrese el id de la mascota');
        readln(id);
        writeln('Ingrese el tipo de animal');
        readln(animal);
        writeln('Ingrese el peso de la mascota');
        readln(peso);
        writeln('Ingrese el dia de ingreso de la mascota');
        readln(fecha.dia);
        writeln('Ingrese el mes de ingreso de la mascota');
        readln(fecha.mes);
        writeln('Ingrese el anio de ingreso de la mascota');
        readln(fecha.anio);
        writeln('Ingrese la cantidad de intervenciones');
        readln(cantint);
      end;
    end;
  end;

//Agrego adelante cada mascota en la lista original
Procedure agregarlista(var l: lista; m: mascota);
var
   aux: lista;
begin
     new(aux);
     aux^.info:= m;
     aux^.sig := l;
     l:= aux;
end;

//Agrego mascota a la lista interna del cliente
procedure agregaradelantearbol(var l: listaint; dato:mascota);
var
   aux: listaint;
begin
  new(aux);
  aux^.dato.id:=dato.id;
  aux^.dato.animal:=dato.animal;
  aux^.dato.cantint:=dato.cantint;
  aux^.dato.peso:=dato.peso;
  aux^.dato.fecha:=dato.fecha;
  aux^.sig:=l;
  l:=aux;
end;

//Inserto los datos necesarios en el arbol
Procedure insertar(var a: arbol; dato:mascota);
begin
   if (a = nil)then begin
      //Agrego cliente nuevo al arbol
      new (a);
      a^.info.dni:=dato.dni;
      a^.info.nombreapellido:=dato.nombreapellido;
      a^.info.direccion:=dato.direccion;
      //Agrego datos de la mascota en el nodo de su dueño
      agregaradelantearbol(a^.info.lista,dato);
      a^.HI := nil;
      a^.HD := nil;
    end
   //Si ingreso cliente, evaluo en que posicion del arbol debe ir
   else
     if a^.info.dni > dato.dni then
      insertar(a^.HI,dato)
    else
      if a^.info.dni < dato.dni then
       insertar(a^.HD,dato)
    //Si el cliente ya se encuentra registrado en el arbol, solo ingreso la mascota a su lista interna
    else
     agregaradelantearbol(a^.info.lista,dato);
  end;

procedure recorrerlistainterna(l: listaint; var cant: integer);
var
   aux: listaint;
begin
  //Recorro la lista con un auxiliar para no perder el puntero inicial
  aux:=l;
  while(aux<>nil) do begin
    //Sumo cantidad de intervenciones
    cant:=cant+aux^.dato.cantint;
    aux:=aux^.sig;
  end;
end;

Procedure recorrerarbol(a:arbol; var min:integer; var dir:string);
var
   cant: integer;
begin
  //Inicializo contador que volvera a cero cuando el arbol cambie de nodo
  cant:=0;
  if (a <> nil) then begin
     //Recorro la lista interna del cliente para sumar cantidad de intervenciones
     recorrerlistainterna(a^.info.lista,cant);
     //En el caso de que la informacion sea minima, actualizo valores por referencia
     if(cant < min) then begin
       min:= cant;
       dir:= a^.info.direccion;
      end;
     //Sigo recorriendo el arbol, ya sea si se encontro un nuevo minimo o no, debo recorrerlo hasta el final de todas formas
     recorrerarbol (a^.HI,min,dir);
     recorrerarbol (a^.HD,min,dir);
  end;
end;

//Recorrido acotado que me permite filtrar dnis
procedure acotado(a:arbol;inf:integer;sup:integer);
begin
  if (a <> nil) then
    if (a^.info.dni <= inf) then
      if (a^.info.dni >= sup) then begin
        writeln('El dni del jugador ',a^.info.nombreapellido, 'es: ', a^.info.dni, ' ');
        //Debo seguir buscando por ambos lados, aca cambie el orden del acotado original, pero no me convence que asi sea descendente
        acotado(a^.HD,inf,sup);
        acotado (a^.HI,inf,sup);
      end
      else
        acotado(a^.HI,inf,sup)
    else
      acotado(a^.HD,inf,sup);
end;

//Recorro la lista interna buscando mascotas que cumplan con las condiciones pedidas
procedure recorrerlistainternaD(l: listaint; var exito:boolean);
var
   aux: listaint;
begin
  //Utilizo variable auxiliar para no perder el puntero a la lista interna
  aux:=l;
  while (aux<>nil) do begin
    //Verifico que cumpla
    if ((aux^.dato.peso > 10) and ((aux^.dato.fecha.mes > 1) and (aux^.dato.fecha.mes < 3))) then begin
       writeln('El ',aux^.dato.animal,' con id ',aux^.dato.id,' cumple con los requisitos');
       //Actualizo boolean para imprimir el cliente
       exito:=true;
     end;
    //Continuo en la lista interna hasta final
    aux:=aux^.sig;
  end;
end;

Procedure recorridoD(a: arbol);
var
   exito:boolean;
begin
  //Declaro un boolean para saber si el cliente tiene algun animal que cumpla con los requisitos
  exito:=false;
  if (a <> nil) then begin
     //Verifico que el cliente tenga mascotas
    if (a^.info.lista<> nil) then begin
       recorrerlistainternaD(a^.info.lista,exito);
       //Imprimo datos del cliente del que ya imprimi sus mascotas que cumplen
       if(exito = true) then writeln('Esto fue para ',a^.info.nombreapellido);
      end;
    //Sigo recorriendo todo el arbol
    recorridoD (a^.HI);
    recorridoD (a^.HD)
  end;
end;

//Variables a usar
var
   l: lista;
   a: arbol;
   m: mascota;
   aux: lista;
   intmin: integer;
   dirmin: string;
begin
  //Inicializo estructuras
  l:=nil;
  a:=nil;

  //Cargo la lista manualmente con las mascotas y la informacion de su dueño
  leermascota(m);
  //Corte de control principal
  while (m.dni<>90909090) do begin
   agregarlista(l,m);
   leermascota(m);
  end;

  //Recorro la lista original con un auxiliar para no perder la informacion cargada
  aux:=l;
  while(aux<>nil) do begin
    //Inserto datos de la lista original en el arbol
    insertar(a,aux^.info);
    aux:=aux^.sig;
  end;

  //Inicializo valores para buscar minimos
  intmin:= 9999;
  dirmin:= ' ';
  //Recorro el arbol para buscar el minimo de intervenciones
  recorrerarbol(a,intmin,dirmin);
  writeln('La minima cantidad de intervenciones la tiene la direccion: ',dirmin,' con: ',intmin);

  //Busqueda acotada para imprimir clientes
  writeln('Listado de personas que cumplen con la condicion de busqueda');
  acotado(a,15000000,30000000);

  //Punto D
   recorridoD(a);
  readln();
end.

