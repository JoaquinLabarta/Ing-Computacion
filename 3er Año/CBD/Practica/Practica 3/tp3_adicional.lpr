{Baja de Archivos
Se desea manejar un archivo con información de turnos médicos. Los datos que contiene el archivo son: DNI,
apellido, nombre, especialista y fecha.
Se sabe que el archivo utiliza la técnica de lista invertida para aprovechamiento de espacio. Es decir las bajas se
realizan apilando registros borrados y las altas reutilizando registros borrados. Se debe utilizar el campo DNI en
negativo, para enlazar los registros y así diferenciar de los registros válidos.
Realizar las declaraciones de tipos necesarias y desarrollar un programa que permita realizar altas y bajas.
Las altas se realizan de a una, leyendo los datos de teclado.
Las bajas se hacen a partir de datos de un archivo de texto llamado bajas_del_dia.txt, el archivo de texto puede
tener varias bajas con los siguientes datos: dni, fecha, nombre y apellido (apellido, nombre, especialista y fecha
son strings), tenga en cuenta que ninguno de los dos archivos está ordenado.}
program tp3_adicional;
const valorAlto=99999999;
type
  tPaciente = record
    dni: LongInt;
    ape: string[15];
    nom: string[20];
    esp: string[20];
    fecha: string[10];
  end;
  tArch = file of tPaciente;
var
  archB: tArch;
  archT: Text;
  pac: tPaciente;
  opc: integer;
procedure leer(var arch: tArch; var dato: tPaciente);
begin
  if (not EOF(arch)) then read(arch,dato)
  else dato.dni:=valorAlto;
end;
procedure alta(var arch: tArch; pac: tPaciente);
var
    cab, libre: tPaciente;
  begin
    reset(archB);
    leer(arch,cab);
    if(cab.dni=-1) then seek(arch,filesize(arch))
    else begin
      seek(arch,cab.dni);
      leer(arch,libre);
      seek(arch,0);
      write(arch,libre);
      seek(arch,cab.dni);
    end;
    write(arch,pac);
    close(archB);
end;
procedure baja(var arch:tArch; pac: tPaciente);
var
  cab,p: tPaciente;
  pos: integer;
begin
  reset(archB);
  leer(arch,p);
  cab:=p;
  while((p.dni<>valorAlto) and (p.dni<>pac.dni)) do leer(arch,p);
  if(p.dni=pac.dni) then begin
    pos := filepos(arch)-1;
    seek(arch,pos);
    write(arch,cab);
    p.dni:=-1;
    seek(arch,0);
    write(arch,p);
  end;
  close(archB);
end;
begin
  assign(archB,'Pacientes.dat');
  assign(archT,'bajas_del_dia.txt');
  readln(opc);
  while (opc<>0) do begin
    if(opc=1) then begin
      readln(pac.dni);
      if pac.dni<0 then readln(pac.dni);
      readln(pac.ape);
      readln(pac.nom);
      readln(pac.fecha);
      alta(archB,pac);
    end
    else if (opc = 2) then begin
      reset(archT);
      readln(archT,pac.dni);
      while(pac.dni<>valorAlto) do begin
        readln(archT,pac.fecha);
        readln(archT,pac.esp);
        readln(archT,pac.nom);
        readln(archT,pac.ape);
        baja(archB,pac);
        readln(archT,pac.dni);
      end;
      close(archT);
    end
    else readln(opc);
  end;
end.

