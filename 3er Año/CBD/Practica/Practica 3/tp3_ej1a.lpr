{1. Se cuenta con un archivo que almacena información sobre especies de plantas originarias de
Europa, de cada especie se almacena: código especie, nombre vulgar, nombre científico, altura
promedio, descripción y zona geográfica. El archivo no está ordenado por ningún criterio.
Realice un programa que elimine especies de plantas trepadoras. Para ello se recibe por
teclado los códigos de especies a eliminar.
a. Implemente una alternativa para borrar especies, que inicialmente marque los
registros a borrar y posteriormente compacte el archivo, creando un nuevo archivo
sin los registros eliminados.}
program tp3_ej1a;
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
  arch, archA: tArch;
  dato: especie;
  cod: integer;
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
    while (dato.cod<>valorAlto) and (dato.cod<>cod)) do begin
      leer(arch,dato); // Si no lo encuentra sigue leyendo
    end;
    // Si lo encuentra, lo marca con el codigo
    if (dato.cod=cod) then begin
      dato.cod:=-1;
      seek(arch, Filepos(arch)-1);
      write(arch,dato);
    end
    else writeln('No se encontro el codigo');
    writeln('Ingrese el nuevo codigo a eliminar: ');
    readln(cod);
  end;

  // Termino busquedas, compactar
  assign(archA,'Archivo_creado.dat');
  rewrite(archA);
  seek(arch,0);
  leer(arch,dato);
  while (dato.cod<>valorAlto) do begin
    if (dato.cod <> -1) then write(archA,dato);
    leer(arch,dato);
  end;
  // Cerrar archivos
  close(arch);
  close(archA);
end.

