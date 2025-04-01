{Se necesita contabilizar los CD vendidos por una discográfica. Para ello se dispone de
un archivo con la siguiente información: código de autor, nombre del autor, nombre
disco, género y la cantidad vendida de ese CD. Realizar un programa que muestre un
listado como el que se detalla a continuación. Dicho listado debe ser mostrado en
pantalla y además listado en un archivo de texto. En el archivo de texto se debe listar
nombre del disco, nombre del autor y cantidad vendida. El archivo origen está
ordenado por código de autor, género y nombre disco.
Autor: _____
Género: ----------
Nombre Disco: ---------- cantidad vendida: ------------
Nombre Disco: ---------- cantidad vendida: ------------
Total Género:
Género:----------
Nombre Disco: ---------- cantidad vendida: ------------
…….
Total Autor:
Total Discográfica:
}
program tp2_ej2;
const valoralto=9999;
type
  tReg = record
    cod: integer;
    nom: string[50];
    nomDisco: string[30];
    genero: string[12];
    ventas: integer;
  end;
  tArch = file of tReg;
var
  archivo: tArch;
  archivoTexto: Text;
  reg,aux: tReg;
  totalGen,totalAutor,totalDisco: integer;
// Procedimiento para leer archivo
procedure leer(var archivo: tArch; var dato: tReg);
begin
  if (not EOF(archivo)) then read(archivo,dato)
  else dato.cod:=valoralto;
end;
// Programa principal
begin
  assign(archivo,'Detalle');
  assign(archivoTexto,'Archivo de texto.dat');
  reset(archivo);
  rewrite(archivoTexto);
  leer(archivo,reg);
  totalDisco:=0;

  // Mientras haya registros
  while (reg.cod<>valoralto) do begin
    aux:=reg; // Aux con nuevo autor
    totalAutor:=0;
    writeln('Autor: ' + aux.nom);

    // Mientras sea mismo autor
    while ((reg.cod<>valoralto) and (reg.cod=aux.cod)) do begin
      aux:=reg; // Aux con nuevo genero
      totalGen:=0;
      writeln('Genero: ' + aux.genero);

      // Mientras sea el mismo genero
      while ((reg.cod<>valoralto) and (reg.cod=aux.cod) and (reg.genero=aux.genero)) do begin
        totalGen:=totalGen+reg.ventas;
        writeln('Nombre del disco: ' + reg.nomDisco + ' cantidad vendida: ', reg.ventas);
        // Escribo en archivo de texto y leo
        writeln(archivoTexto,reg.nomDisco,',',reg.nom,',',reg.ventas);
        leer(archivo,reg);
      end;
      // Cambio de genero
      totalAutor:=totalAutor+totalGen;
      writeln('Total Genero: ',totalGen);
      writeln('----------------------------------------');
    end;
    // Cambio de autor
    totalDisco:=totalDisco+totalAutor;
    writeln('Total Autor: ',totalAutor);
    writeln('----------------------------------------');
  end;
  // No hay mas registros
  writeln('Total discografica: ',totalDisco);
  close(archivo);
  close(archivoTexto);
  readln();
end.

