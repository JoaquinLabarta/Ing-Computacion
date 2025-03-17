program ejercicio1;
{Realizar un programa que permita crear un archivo conteniendo información de
nombres de materiales de construcción, el archivo no es ordenado. Efectúe la
declaración de tipos correspondiente y luego realice un programa que permita la
carga del archivo con datos ingresados por el usuario. El nombre del archivo debe
ser proporcionado por el usuario. La carga finaliza al procesar el nombre ‘cemento’
que debe incorporarse al archivo.
}
const
  fin = 'cemento';
type
  material = string[15];
  tArchMat = File of material;
var
  archivo: tArchMat;
  nombre: material;
begin
  Assign(archivo,'Materiales.dat');
  Rewrite(archivo);
  WriteLn('Ingrese un material');
  ReadLn(nombre);
  while (nombre <> fin) do
  begin
    Write(archivo,nombre);
    WriteLn('Ingrese un material');
    ReadLn(nombre);
  end;
  WriteLn('Finalizo la carga');
  readln();
end.

