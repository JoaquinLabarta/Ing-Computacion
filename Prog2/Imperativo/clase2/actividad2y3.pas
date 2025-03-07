program actividad2y3;


function potencia1(x,n:integer):real;
begin
  if(n=0)then
    potencia1:=1
  else
    potencia1:=x*potencia1(x,n-1);
end;

{PROGRAMA PRINCIPAL}
var
   n, x: integer;
   resultado:real;

begin

     write ('Ingrese base: ');
     Readln (x);
     write ('Ingrese exponente: ');
     Readln (n);
     resultado:=potencia1(x,n);
     writeln(resultado:2:2);
     readln;
end.
