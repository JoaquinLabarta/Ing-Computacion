{Una tienda de indumentaria desea almacenar sus productos en un archivo de datos para la
posterior actualización de stock con las compras y ventas de indumentario. Para ello cuenta
con un archivo de texto donde tiene almacenada la siguiente información: código de producto,
nombre, descripción y stock.}
program tp3_ej3;
const valorAlto=9999;
type
  tProd = record
    cod: integer;
    nomb: string[40];
    desc: string[100];
    stock: integer;
  end;
  tArch = file of tProd;
var
  archB: tArch;
  archT: Text;
procedure leer(var arch: tArch; var dato: tProd);
begin
    if (not EOF(arch)) then read(arch,dato)
    else dato.cod:=valorAlto;
end;

{a. Deberá realizar un procedimiento que tomando como entrada el archivo de texto,
genere el correspondiente archivo binario de datos.}
procedure textToBinary(var archB: tArch; var archT: Text);
var
  prod: tProd;
begin
    reset(archT);
    rewrite(archB);
    while not EOF(archT) do
      begin
        readln(archT, prod.cod,prod.stock);
        readln(archT, prod.nomb);
        readln(archT, prod.desc);
        write(archB,prod);
      end;
    close(archT);
    close(archB);
end;

{b. Se reciben por pantalla códigos de indumentaria obsoletos, los cuales deben
eliminarse del archivo de datos, utilizando una marca de borrado. La marca de
borrado consiste en poner valor negativo al stock. Realice el procedimiento
correspondiente}
procedure eliminarCod(var archB: tArch; codProd: integer);
var
  prod: tProd;
begin
  seek(archB,0);
  leer(archB,prod);
  while ((prod.cod<>valorAlto) and (prod.cod<>codProd)) do leer(archB,prod);
  if(prod.cod=codProd) then begin
    prod.stock:=-1;
    prod.cod:=-1;
    seek(archB,Filepos(ArchB)-1);
    write(archB,prod);
  end;
end;

{c. A continuación, se solicita realizar un procedimiento que permita realizar el alta de
una nueva indumentaria con los valores obtenidos por teclado.}
procedure agregarProd(var archB: tArch; prod: tProd);
begin
  seek(archB,Filesize(archB));
  write(archB,prod);
end;

{d. Realice un nuevo procedimiento de baja, suponiendo que la creación del archivo
supuso la utilización de la técnica de lista invertida para reutilización de espacio
(dejó un registro obsoleto al comienzo del archivo como cabecera de lista).}
procedure bajaReut(var archB: tArch; codProd: integer);
var
  prod, cab: tProd;
  pos: integer;
begin
  seek(archB,0);
  leer(archB, prod);
  cab:=prod;
  while ((prod.cod<>valorAlto) and (prod.cod<>codProd)) do leer(archB,prod);
  if (prod.cod=codProd) then begin
    pos:=filepos(archB)-1;
    seek(archB,pos);
    write(archB,cab);
    prod.stock:=pos;
    seek(archB,0);
    write(archB,prod);
  end;
end;

{e. Re implemente c, sabiendo que se utiliza la técnica de lista en invertida.}
procedure agregarReut(var archB: tArch; prod: tProd);
var
  aux, libre: tProd;
begin
  seek(archB,0);
  leer(archB,aux);
  if(aux.stock=-1) then seek(archB,filesize(archB))
  else begin
    seek(archB,aux.stock);
    leer(archB,libre);
    seek(archB,0);
    write(archB,libre);
    seek(archB,aux.stock);
  end;
  write(archB,prod);
end;

{f. Re implementa a, para poder utilizar la técnica de lista invertida.}
procedure textToBinaryReut(var archB: tArch; var archT: Text);
var
  prod: tProd;
begin
    reset(archT);
    rewrite(archB);
    prod.stock:=-1;
    write(archB,prod);
    while not EOF(archT) do
      begin
        readln(archT, prod.cod,prod.stock);
        readln(archT, prod.nomb);
        readln(archT, prod.desc);
        write(archB,prod);
      end;
    close(archT);
    close(archB);
end;
begin
  readln();
end.

