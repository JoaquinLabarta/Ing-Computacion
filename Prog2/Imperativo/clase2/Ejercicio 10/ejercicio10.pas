Program ejercicio10;
uses
    crt;
Type
  Lista= ^Nodo;
  Nodo= Record
           Datos: integer;
           Sig: Lista;
        End;


Procedure AgregarAdelante (var L:lista; num:integer);
Var nue:Lista;
  Begin
    New(nue);
    nue^.datos:=num;
    nue^.sig:=L;
    L:=nue;
  End;


Procedure Imprimir (pri:lista);
Begin
   while (pri <> NIL) do begin
     write (pri^.datos, ' ');
     pri:= pri^.sig
  end;
  writeln;
end;

function minimo(L:Lista; min:integer):integer;
begin
     if (L = nil) then
        minimo:=min    //caso base
     else begin
          if (L^.datos < min) then
             min:= L^.datos;
          min:= minimo(L^.sig,min);
     end;
     minimo:=min;
end;

procedure ImprimirRecursivo(L:Lista);
begin
     if (L <> nil) then begin
        write(L^.datos,' ');
        ImprimirRecursivo(L^.sig);
     end;
end;



Var
 L: Lista;
 n:integer;
 min: integer;

begin
 L:=nil;
 randomize;
 n := random (100);
 While (n<>0) do Begin
   AgregarAdelante (L, n);
   n := random (100);
 End;
 writeln ('Lista generada: ');
 imprimir (L);

 min:=9999;
 writeln('El minino numero en la lista ', minimo(L,min));

 writeln('Imprime con modulo recursivo ');
 ImprimirRecursivo(L);

 readkey();
end.

