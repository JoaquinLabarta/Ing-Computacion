program ejercicio2;
{Desarrollar un programa que permita la apertura de un archivo de números enteros
no ordenados. La información del archivo corresponde a la cantidad de votantes
de cada ciudad de la Provincia de Buenos Aires en una elección presidencial.
Recorriendo el archivo una única vez, informe por pantalla la cantidad mínima y
máxima de votantes. Además durante el recorrido, el programa deberá listar el
contenido del archivo en pantalla. El nombre del archivo a procesar debe ser
proporcionado por el usuario.
}
type
  tArchivo = File of integer;
var
  min,max,i: integer;
  arch: tArchivo;
  nombreArch: string[30];
begin
  min := 999999; max := -1;
  writeln('Ingrese el nombre del archivo que desea procesar: ');
  readln(nombreArch);
  Assign(arch,'Votantes.dat');
  reset(arch);
  while not EOF(arch) do
  begin
    Read(arch,i);
    Writeln('Valor leído: ', i);
    if i > max then max := i;
    if i < min then min := i;
  end;
  Close(arch);
  writeln('Finalizo la muestra, el maximo es: ',max);
  writeln('El minimo es: ',min);
  readln();
end.

