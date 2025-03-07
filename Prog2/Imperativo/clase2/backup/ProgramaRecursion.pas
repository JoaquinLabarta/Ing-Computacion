program Recursion;

var 
  num: integer; maximo:integer;


function digitoMaximo(n: integer):integer;
var
  dig: integer; max:integer;
begin
  max:=-1;
  dig:= n mod 10;
  if ( dig > max ) then
    max:= dig;
  n:= n div 10;
  if (n <> 0) then begin
    digitoMaximo(n):=max;
    max:=digitoMaximo(n);
end;
     end;

{procedure digitoMaximo(n: integer; var max: integer);
var
  dig: integer;
begin
  dig:= n mod 10;
  if ( dig > max ) then
    max:= dig;
  n:= n div 10;
  if (n <> 0) then
    digitoMaximo(n, max);
end;}

Begin
  writeln( 'Ingrese un entero no negativo:');
  readln (num);
  maximo:=digitoMaximo (num);
  writeln ( 'El digito maximo del numero ', num, ' es: ', maximo);
  readln;
End.

