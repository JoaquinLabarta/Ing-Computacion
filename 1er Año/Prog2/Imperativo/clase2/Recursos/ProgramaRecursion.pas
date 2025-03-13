program Recursion;

var 
  num: integer; maximo:integer;


function digitoMaximo(n: integer):integer;
var
  dig: integer; max:integer;
begin
  if(n=0) then begin
    max:=0;
  end
  else  begin
    max:=digitoMaximo(n div 10);
    dig:= n mod 10;
    if (dig > max) then
       max:= dig;

    end;
  digitoMaximo:=max;
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

