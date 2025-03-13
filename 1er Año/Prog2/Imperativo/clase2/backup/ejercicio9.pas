program ejercicio9;

const
    dimF = 8;  {Dimensión física del vector}

type

    vector = array [1..dimF] of LongInt;

    dim = 0..dimF;


{-----------------------------------------------------------------------------
CARGARVECTOR - Carga nros aleatorios entre 0 y 100 en el vector hasta que
llegue el nro 99 o hasta que se complete el vector}


Procedure cargarVector ( var vec: vector; var dimL: dim);
var
   d: integer;
begin
     Randomize;  { Inicializa la secuencia de random a partir de una semilla}
     dimL := 0;
     d:= random(100);
     while (d <> 99)  and ( dimL < dimF ) do begin
           dimL := dimL + 1;
           vec[dimL] := d;
           d:= random(100);
     end;
End;



{-----------------------------------------------------------------------------
IMPRIMIRVECTOR - Imprime todos los nros del vector }
Procedure imprimirVector ( var vec: vector; var dimL: dim );
var
   i: dim;
begin
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     write (' ');
     for i:= 1 to dimL do begin
        if(vec[i] < 9)then
            write ('0');
        write(vec[i], ' | ');
     end;
     writeln;
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     writeln;
End;

Function maximo (v:vector; dimL: dim; max:integer; i:integer): integer;


Begin
	if  (i>=dimL)  then begin //CONDICION BASE- TERMINA SU FUNCION
		maximo := max;
	end
	else begin
		if (v[i] > max) then begin
			max:= v[i];
		end;
		max:= maximo (v,dimL,max,i+1);

	end;
	maximo:= max; //VAYA GUARDANDO CUAL ES EL MAXIMO, ya que como es función no se puede pasar por referencia.

end;


function sumavector (v:vector; dimL:dim; suma:integer; i:integer): integer;
begin

	if (i>dimL) then begin
		sumavector:= suma; //condicion base, aca terminaria
	end
	else begin
		suma:= suma + v[i];
		suma:= sumavector(v,dimL,suma,i+1);
	end;
	sumavector:= suma; //va guardando cual es la suma

end;





{PROGRAMA PRINCIPAL}
var
   v: vector;
   dimL : dim;
   max:integer;
   i:integer;
   suma:integer;

begin
	max:=-1;
	i:= 1;
	suma:=0;

    cargarVector(v,dimL);

    writeln('Nros almacenados: ');
    imprimirVector(v, dimL);

	writeln ('El numero maximo es:', maximo (v,dimL, max,i));

	writeln ('La suma de los valores contenidos en el vector es: ', sumavector (v,dimL, suma, i));

    readln;
end.

