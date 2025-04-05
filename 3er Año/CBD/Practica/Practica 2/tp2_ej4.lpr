{Una cadena de cines de renombre desea administrar la asistencia del público a las
diferentes películas que se exhiben actualmente. Para ello cada cine genera
semanalmente un archivo indicando: código de película, nombre de la película, género,
director, duración, fecha y cantidad de asistentes a la función. Se sabe que la cadena
tiene 20 cines. Escriba las declaraciones necesarias y un procedimiento que reciba los
20 archivos y un String indicando la ruta del archivo maestro y genere el archivo
maestro de la semana a partir de los 20 detalles (cada película deberá aparecer una
vez en el maestro con los datos propios de la película y el total de asistentes que tuvo
durante la semana). Todos los archivos detalles vienen ordenados por código de
película. Tenga en cuenta que en cada detalle la misma película aparecerá tantas
veces como funciones haya dentro de esa semana.
}
program ej4_tp2;
const N = 20; valorAlto = 9999;
type
  tPelicula = record
    cod: integer;
    nom: string[40];
    gen: string[10];
    dir: string[50];
    dur: integer;
    fec: string[10];
    cant: integer;
  end;
  tArchDet = file of tPelicula;
  tDet = array[1..N] of tArchDet;
  tArchMae = file of tPelicula;
  tRegDet = array[1..N] of tPelicula;
var
  mae: tArchMae;
  det: tDet;
  i:integer;
procedure leer(var arch: tArchDet; var dato:tPelicula);
begin
  if (not EOF(arch)) then read(arch,dato)
  else dato.cod:=valorAlto;
end;
procedure minimo(var arch: tDet; var arRegDet:tRegDet; var min:tPelicula);
var
  posMin,i:integer;
begin
  posMin:=1;
  min:=arRegDet[1];
  for i:=2 to N do begin
    if(arRegDet[i].cod<min.cod) then begin
      min:=arRegDet[i];
      posMin:=i;
    end;
  end;
  leer(arch[posMin],arRegDet[posMin]);
end;
procedure crearMaestro(var mae:tArchMae; var det:tDet; ruta: string);
var
  arRegDet: tRegDet;
  min,pel: tPelicula;
  i,cant:integer;
  nom: string;
begin
  assign(mae,ruta);
  rewrite(mae);
  for i:=1 to N do begin
    Str(i,nom);
    assign(det[i],nom);
    reset(det[i]);
    leer(det[i],pel);
    arRegDet[i]:=pel;
  end;
  minimo(det,arRegDet,min);
  while min.cod<>valorAlto do begin
    pel:=min;
    cant:=0;
    while ((min.cod <> valorAlto) and (min.cod=pel.cod)) do begin
      cant:=cant + pel.cant;
      minimo(det,arRegDet,min);
    end;
    pel.cant:=cant;
    write(mae,pel);
  end;
end;
begin
  crearMaestro(mae,det,'C:\CarpetaMaestro\Archivos\Maestro.dat');
  close(mae);
  for i:=1 to N do begin
    close(det[i]);
  end;
  readln();
end.

