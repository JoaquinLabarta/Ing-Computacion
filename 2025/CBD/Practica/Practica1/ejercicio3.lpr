program ejercicio3;
{Realizar un programa que permita crear un archivo de texto. El archivo se debe
cargar con la información ingresada mediante teclado. La información a cargar
representa los tipos de dinosaurios que habitaron en Sudamérica. La carga finaliza
al procesar el nombre ‘zzz’ que no debe incorporarse al archivo}
const
  fin = 'zzz';
var
  archivo: Text;
  nombreArch,tipo: string[15];
begin
  writeln('Ingrese el nombre del archivo a crear: ');
  readln(nombreArch);
  Assign(archivo, nombreArch + '.dat');
  rewrite(archivo);
  writeln('Ingrese el tipo de dinosaurio (zzz para terminar): ');
  readln(tipo);
  while tipo <> fin do
    begin
      writeln(archivo, tipo);
      writeln('Ingrese el tipo de dinosaurio (zzz para terminar): ');
      readln(tipo);
    end;
  Close(archivo);
  readln();
end.

