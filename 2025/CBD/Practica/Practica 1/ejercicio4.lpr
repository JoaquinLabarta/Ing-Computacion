program ejercicio4;
{ Crear un procedimiento que reciba como parámetro el archivo del punto 2, y
genere un archivo de texto con el contenido del mismo.
}
type
  tArchivo = File of integer;
var
  min,max,i: integer;
  arch: tArchivo;
  nombreArch: string[30];
  newArch: Text;
procedure binaryToText(var archivo: tArchivo; var newArchivo: Text);
  var
    num: integer;
  begin
    rewrite(newArchivo);
    Seek(archivo,0);
    while not EOF(archivo)do
      begin
        Read(archivo,num);
        Writeln(newArchivo,num);
      end;
    writeln('Fin de la carga, se genero el archivo de texto');
  end;
begin
  min := 999999; max := -1;
  writeln('Ingrese el nombre del archivo que desea procesar: ');
  readln(nombreArch);
  Assign(arch,nombreArch + '.dat');
  reset(arch);
  while not EOF(arch) do
  begin
    Read(arch,i);
    Writeln('Valor leído: ', i);
    if i > max then max := i;
    if i < min then min := i;
  end;
  writeln('Finalizo la muestra, el maximo es: ',max);
  writeln('El minimo es: ',min);
  Assign(newArch, 'ArchivoCreado.txt');
  binaryToText(arch,newArch);
  Close(arch);
  close(newArch);
  readln();
end.


