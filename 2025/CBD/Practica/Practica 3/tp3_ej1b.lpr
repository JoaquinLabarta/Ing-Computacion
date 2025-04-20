{1. Se cuenta con un archivo que almacena información sobre especies de plantas originarias de
Europa, de cada especie se almacena: código especie, nombre vulgar, nombre científico, altura
promedio, descripción y zona geográfica. El archivo no está ordenado por ningún criterio.
Realice un programa que elimine especies de plantas trepadoras. Para ello se recibe por
teclado los códigos de especies a eliminar.
b. Implemente otra alternativa donde para quitar los registros se deberá copiar el
último registro del archivo en la posición del registro a borrar y luego eliminar del
archivo el último registro de forma tal de evitar registros duplicados.}
program tp3_ej1b;
const fin=10000; valorAlto=30000;
type
  especie = record
    cod: integer;
    nomV: string[20];
    nomC: string[50];
    alt: integer;
    desc: string[100];
    zona: string[10];
  end;
  tArch = file of especie;
var
  arch: tArch;
  dato: especie;
  pos,cod: integer;
procedure leer(var arch: tArch; var dato: especie);
begin
  if (not EOF(arch)) then read(arch,dato)
  else dato.cod:=valorAlto;
end;
begin
  // Creacion de archivos
  assign(arch,'Archivo_maestro.dat');
  reset(arch);
  // Ingresar codigo a borrar, fin para cerrar
  writeln('Ingrese el codigo a eliminar: ');
  readln(cod);
  // Si no lo encuentra sigue leyendo
  while (cod<>fin)do begin
    seek(arch,0);
    leer(arch,dato);
    while (dato.cod<>valorAlto) and (dato.cod<>cod) do begin
      leer(arch,dato); // Si no lo encuentra sigue leyendo
    end;
    if (dato.cod = cod) then begin
      pos := filePos(arch) - 1;
      // Chequeo que no sea el ultimo
      if (pos = Filesize(arch) - 1) then truncate(arch)
      else begin
        seek(arch, Filesize(arch) - 1);
        leer(arch, dato);
        seek(arch, pos);
        write(arch, dato);
        seek(arch, Filesize(arch) - 1);
        truncate(arch);
      end;
      writeln('Registro eliminado.');
    end
    else writeln('Código no encontrado.');
    writeln('Ingrese el nuevo codigo a eliminar: ');
    readln(cod);
  end;
  // Cerrar archivos
  close(arch);
end.


