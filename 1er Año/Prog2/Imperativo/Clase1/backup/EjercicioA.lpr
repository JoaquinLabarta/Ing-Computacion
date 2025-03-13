Program productos;
Uses
     sysutils;
Type
     producto = record
          codigo: integer;
	      nombre: string;
	      marca: string;
	      anio: 2000..2022;
		  precio: real;
     end;
     informacion = record
          codigo: integer;
	  nombre: string;
	  anio: 2018..2022;
	  precio: real;
     end;

     listaProductos = ^nodoLista;
     nodoLista = record
               dato: producto;
               sig: listaProductos;
     end;

     lista2 = ^nodoLista2;

     lista3 = ^nodoLista3;
     nodoLista3 = record
       dato:informacion;
       sig:lista3;
     end;

     nodoLista2 = record
               dato: string;
               sig: lista3;
               sig2:lista2;//nil
     end;

procedure inicializar(var l2:lista2);
begin
     l2^.dato:='Abercom';
     l2^.sig2:=nil;
     l2^.sig:=nil;
end;

{procedure recorrer(l:listaProducto;var l2:lista2);
begin
     while(
end;}

Procedure agregarAdelante(var l: listaProductos; p: producto);
var
   aux: listaProductos;
begin
     new(aux);
     aux^.dato := p;
     aux^.sig := l;
     l:= aux;
end;



{crearLista - Genera una lista con productos aleatorios}
procedure crearLista(var l: listaProductos);
var
   i,j:integer;
   p: producto;

   v : array [1..10] of string;
begin
     v[1]:= 'Abercom';
     v[2]:= 'Aluminium';
     v[3]:= 'ClearWindows';
     v[4]:= 'IndArg';
     v[5]:= 'La Foret';
     v[6]:= 'Open';
     v[7]:= 'Portal';
     v[8]:= 'Puertamania';
     v[9]:= 'PVCPremium';
     v[10]:= 'Ventalum';

	 for i:=random(10) downto 1 do {for de marca}
	 begin
	     p.marca:= v[i];
		 for j:=random(5) downto 1 do {for de anio}
	     begin
		 	p.anio:= 2016+j;
			p.codigo:= random(10);
			while (p.codigo <> 0) do Begin
				p.nombre:= Concat('Producto-', IntToStr(random (200)));
				p.precio := random(1000000);
				agregarAdelante(l, p);
                p.codigo:= random(10);
		   end;
		 end;
	 end;
end;


{imprimir - Muestra en pantalla el producto}
procedure imprimir(p: producto);
begin
     with (p) do begin
          writeln('Producto', nombre, ' con codigo ',codigo, ': ', marca, ' Anio:', anio, ' Precio: ', precio:2:2);
     end;
end;


{imprimirLista - Muestra en pantalla la lista l}
procedure imprimirLista(l: listaProductos);
begin
     while (l <> nil) do begin
          imprimir(l^.dato);
          l:= l^.sig;
     end;
end;

var
   l: listaProductos;
begin
     Randomize;

     l:= nil;
     crearLista(l);
     writeln ('Lista generada: ');
     imprimirLista(l);
     //l2:=nil;
     //inicializar(l2);
     //recorrer(l,l2);
     readln;
end.

