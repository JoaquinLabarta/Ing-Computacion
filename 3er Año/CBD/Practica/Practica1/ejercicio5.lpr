program ejercicio5;
{Realizar un programa, con la declaración de tipos correspondientes que permita
crear un archivo de registros no ordenados con información de especies de flores
originarias de América. La información será suministrada mediante teclado. De
cada especie se registra: número de especie, altura máxima, nombre científico,
nombre vulgar, color y altura máxima que alcanza. La carga del archivo debe
finalizar cuando se reciba como nombre científico: ’zzz’.
Además se deberá contar con opciones del programa que posibiliten:
a) Reportar en pantalla la cantidad total de especies y la especie de menor y de
mayor altura a alcanzar.
b) Listar todo el contenido del archivo de a una especie por línea.
c) Modificar el nombre científico de la especie flores cargada como: Victoria
amazonia a: Victoria amazónica.
d) Añadir una o más especies al final del archivo con sus datos obtenidos por
teclado. La carga finaliza al recibir especie “zzz”.
e) Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”.
El archivo de texto se tiene que poder reutilizar.
}
const
  fin = 'zzz';
type
  tFlores = record
    numEspecie: integer;
    alturaMax: double;
    nomCient: string[31];
    nomVulgar: string[15];
    color: string[7];
  end;
  tArch = File of tFlores;
var
  arch: tArch;
  flor: tFlores;
  nomCient: string[31];
  opc: string[2];
  opc2: integer;
  carga: Text;
function leerFlor(nom: string): tFlores;
  var
    flor: tFlores;
  begin
    flor.nomCient:=nom;
    writeln('Ingrese el numero de la especie: ');
    readln(flor.numEspecie);
    writeln('Ingrese la altura maxima: ');
    readln(flor.alturaMax);
    writeln('Ingrese el nombre vulgar: ');
    readln(flor.nomVulgar);
    writeln('Ingrese el color: ');
    readln(flor.color);
    leerFlor:=flor;
  end;
procedure opcion1(var archivo: tArch);
var
  min,max: double;
  f: tFlores;
begin
  seek(archivo,0);
  min:=9999; max:= -1;
  while not EOF(archivo) do
    begin
      read(archivo,f);
      if(f.alturaMax > max) then max:=f.alturaMax;
      if(f.alturaMax < min) then min:=f.alturaMax;
    end;
  writeln('La altura max es: ',max);
  writeln('La altura min es: ',min);
  writeln('La cantidad total de especies es: ',filesize(archivo));
  writeln('-----------------------------------------------------');
end;
procedure opcion2(var archivo: tArch);
var
 f: tFlores;
begin
  seek(archivo,0);
  while not EOF(archivo) do
    begin
      read(archivo,f);
      writeln('Numero de especie: ',f.numEspecie);
      writeln('Altura maxima: ',f.alturaMax);
      writeln('Nombre cientifico: ',f.nomCient);
      writeln('Nombre vulgar: ',f.nomVulgar);
      writeln('Color: ',f.color);
      writeln('-----------------------------------------------------');
    end;
end;
procedure opcion3(var archivo: tArch);
var
 f: tFlores;
 encontre: boolean;
begin
  seek(archivo,0);
  encontre:=false;
  while (not EOF(archivo) and not encontre) do
    begin
      read(archivo,f);
      if (f.nomCient = 'Victoria amazonia')then
        begin
          f.nomCient:= 'Victoria amazonica';
          seek(archivo,filepos(archivo)-1);
          write(archivo,f);
          encontre:=true;
          writeln('Se modifico el registro');
        end;
    end;
    if not encontre then
      writeln('No se encontro el registro');
    writeln('-----------------------------------------------------');
end;
procedure opcion4(var archivo: tArch);
var
  f: tFlores;
  opc: string;
  nomCient: string;
begin
  seek(archivo,filesize(archivo)-1);
  opc:='si';
  while opc <> 'no' do
    begin
      writeln('Ingrese el nombre cientifico de la flor: ');
      readln(nomCient);
      f:= leerFlor(nomCient);
      Write(arch,f);
      writeln('Flor cargada con exito');
      writeln('Desea cargar otra flor? ');
      readln(opc);
    end;
  writeln('La carga finalizo');
  writeln('-----------------------------------------------------');
end;
procedure opcion5(var archivo: tArch; var carga: Text);
var
  f: tFlores;
begin
  Assign(carga,'flores.txt');
  rewrite(carga);
  seek(archivo,0);
  while not EOF(archivo) do
    begin
      read(archivo,f);
      Writeln(carga, 'Número de Especie: ', f.numEspecie);
      Writeln(carga, 'Altura Máxima: ', f.alturaMax:0:2);
      Writeln(carga, 'Nombre Científico: ', f.nomCient);
      Writeln(carga, 'Nombre Vulgar: ', f.nomVulgar);
      Writeln(carga, 'Color: ', f.color);
    end;
  close(carga);
  writeln('El archivo de texto se creo con exito');
  writeln('-----------------------------------------------------');
end;
{----------------------------------------------------------------------------------------------------------------}
begin
  Assign(arch,'Flores.dat');
  Rewrite(arch);
  writeln('Lectura de la flor');
  writeln('Ingrese el nombre cientifico de la flor: ');
  readln(nomCient);
  while nomCient <> fin do
    begin
      flor := leerFlor(nomCient);
      Write(arch,flor);
      writeln('Flor cargada con exito');
      writeln('-----------------------------------------------------');
      writeln('Ingrese el nombre cientifico de la flor: ');
      readln(nomCient);
    end;
  {cierro archivo para la parte de carga}
  close(arch);
  writeln('La carga finalizo, desea ver el menu de opciones disponibles? (si / no)');
  readln(opc);
  if opc = 'si' then
    begin
      opc2 := 0;
      reset(arch);
      while opc2 <> 6 do
        begin
          writeln('Menu de opciones');
          writeln('1: Cantidad de especies, minimos y maximos de altura');
          writeln('2: Listar todas las especies');
          writeln('3: Modificar nombre cientifico');
          writeln('4: Agregar especie');
          writeln('5: Crear archivo de texto');
          writeln('6: Salir');
          writeln('Opcion: ');
          read(opc2);
          case opc2 of
            1: opcion1(arch);
            2: opcion2(arch);
            3: opcion3(arch);
            4: opcion4(arch);
            5: opcion5(arch,carga);
          end;
        end;
    end;
  {cierro archivo para la parte de lectura}
  close(arch);
  writeln('Enter para salir');
  readln();
end.

