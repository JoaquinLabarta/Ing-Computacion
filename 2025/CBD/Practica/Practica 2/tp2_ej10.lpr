{Se desea administrar el stock de los productos de una tienda de electrodomésticos con
varias sucursales en el país. Para ello se cuenta con un archivo maestro donde figuran
todos los productos que comercializa. De cada producto se almacena la siguiente
información: código de producto, nombre comercial, descripción, precio de venta,
cantidad vendida, y mayor cantidad vendida en un mes. Mensualmente se genera un
archivo detalle en cada sucursal en el que registran todas las ventas de productos. De
cada venta se registra el código de producto y la cantidad de unidades vendidas.
Mensualmente la empresa recibe un archivo detalle de cada sucursal (son 8
sucursales) y debe actualizar el archivo maestro. Se pide realizar un programa que
realice la declaración de tipos e invoque un proceso que actualice el archivo maestro
con los archivos detalle sabiendo que:
a. Todos los archivos están ordenados por código de producto.
b. Cada registro del archivo maestro puede ser actualizado por 0, 1 ó más registros de
los archivos detalle.
c. Los archivos detalle sólo contienen ventas de productos que están en el archivo
maestro.
Además si la cantidad vendida en el mes actual supera a la mayor cantidad vendida en un mes
previo, se debe actualizar este dato y también se debe informar en pantalla el código del producto,
nombre, mayor cantidad vendida hasta el mes anterior (la del archivo maestro) y cantidad vendida
en el mes actual.
Nota: deberá implementar el programa principal, todos los procedimientos y los tipos de
datos necesarios.
}
program tp2_ej10;
const N=8; valorAlto=9999;
type
  tProdMae = record
    cod: integer;
    nom: string[20];
    desc: string[100];
    prec: real;
    cantVend: integer;
    mayorVenta: integer;
  end;
  tProdDet = record
    cod: integer;
    cantVend: integer;
  end;
  tMae = file of tProdMae;
  tDet = file of tProdDet;
  tAdet = array[1..N] of tDet;
  tRegDet = array[1..N] of tProdDet;
var
  mae: tMae;
  det: tAdet;
  prodM: tProdMae;
  arRegDet: tRegDet;
  strNum: string;
  min: tProdDet;
  i,ventas:integer;
procedure leerD(var arch: tDet; var dato: tProdDet);
begin
  if (not EOF(arch)) then read(arch,dato)
  else dato.cod:=valorAlto;
end;
procedure leerM(var arch: tMae; var dato: tProdMae);
begin
  if (not EOF(arch)) then read(arch,dato)
  else dato.cod:=valorAlto;
end;
procedure minimo(var det: tAdet; var arRegDet: tRegDet; var min: tProdDet);
var
  posMin,i: integer;
begin
  posMin:=1;
  min:=arRegDet[1];
  for i:=2 to N do begin
    if(arRegDet[i].cod < min.cod) then begin
      min:=arRegDet[i];
      posMin:=i;
    end;
  end;
  leerD(det[posMin], arRegDet[posMin]);
end;
begin
  assign(mae,'Archivo_maestro.dat');
  reset(mae);
  for i:=1 to N do begin
    Str(i,strNum);
    assign(det[i], 'Archivo_detalle ' + strNum + '.dat');
    reset(det[i]);
    leerD(det[i],arRegDet[i]);
  end;
  read(mae,prodM);
  while (prodM.cod <> valorAlto) do begin
    ventas:=0;
    minimo(det,arRegDet,min);
    while ((min.cod > prodM.cod) and (prodM.cod <> valorAlto) and (min.cod <> valorAlto)) do leerM(mae,prodM); // Me aseguro que si no hay registros para ese codigo no lo actualizo
    while ((min.cod <> valorAlto) and (min.cod = prodM.cod)) do begin
      ventas:=min.cantVend+ventas;
      minimo(det,arRegDet,min);
    end;
    if(prodM.mayorVenta<ventas) then begin
      writeln('Es mes el producto: ',prodM.cod, 'supero el record de ventas de: ', prodM.mayorVenta, ' con un total de: ', ventas);
      prodM.mayorVenta:=ventas;
    end;
    prodM.cantVend:=prodM.cantVend + ventas;
    seek(mae,Filepos(mae)-1);
    write(mae,prodM);
    leerM(mae,prodM);
  end;
  close(mae);
  for i:=1 to N do close(det[i]);
end.

