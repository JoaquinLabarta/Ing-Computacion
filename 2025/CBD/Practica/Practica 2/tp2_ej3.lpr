{Una zapatería cuenta con 20 locales de ventas. Cada local de ventas envía un listado
con los calzados vendidos indicando: código de calzado, número y cantidad vendida
del mismo.
El archivo maestro almacena la información de cada uno de los calzados que se
venden, para ello se registra el código de calzado, número, descripción, precio unitario,
color, el stock de cada producto y el stock mínimo.
Escriba el programa principal con la declaración de tipos necesaria y realice un
proceso que reciba los 20 detalles y actualice el archivo maestro con la información
proveniente de los archivos detalle. Tanto el maestro como los detalles se encuentran
ordenados por el código de calzado y el número.
Además, se deberá informar qué calzados no tuvieron ventas y cuáles quedaron por
debajo del stock mínimo. Los calzados sin ventas se informan por pantalla, mientras
que los calzados que quedaron por debajo del stock mínimo se deben informar en un
archivo de texto llamado calzadosinstock.txt.
Nota: tenga en cuenta que no se realizan ventas si no se posee stock.
}
program tp2_ej3;
const valoralto=9999; cant = 20;
type
  tDet = record
    codCalz: integer;
    numero: integer;
    ventas: integer;
  end;
  tMae = record
    codCalz: integer;
    numero: integer;
    desc: string[100];
    prec: integer;
    color: string[8];
    stock: integer;
    minStock: integer;
  end;
  archDet = file of tDet;
  archMae = file of tMae;
  aDet = array[1..cant] of archDet;
  aregDet = array[1..cant] of tDet;
var
  det: aDet;
  mae: archMae;
  rMae: tMae;
  rDet,min: tDet;
  regDetArray: aregDet;
  archTexto: Text;
  i: integer;
  nombre: string;
  cantVentas: integer;
procedure leer(var archivo: archDet; var dato: tDet);
begin
  if(not EOF(archivo)) then read(archivo,dato)
  else dato.codCalz:=valoralto;
end;
procedure leerM(var archivo: archMae; var dato: tMae);
begin
  if(not EOF(archivo)) then read(archivo,dato)
  else dato.codCalz:=valoralto;
end;
procedure minimo(var det: aDet; var rdet: aregDet; var min: tDet);
var
  posMin,i: integer;
begin
  posMin:=1;
  min := rdet[1];
  for i:=2 to cant do begin
    if((rdet[i].codCalz < min.codCalz) or ((rdet[i].codCalz=min.codCalz) and (rdet[i].numero<min.numero))) then begin
      min:= rdet[i];
      posMin:=i;
    end;
  end;
  leer(det[posMin],rdet[posMin]);
end;
begin
  // Asignacion y creacion
  assign(mae,'Archivo maestro');
  reset(mae);
  assign(archTexto,'calzadosinstock.txt');
  rewrite(archTexto);
  for i:=1 to 20 do begin
    writeln('Ingrese nombre para detalle');
    readln(nombre);
    assign(det[i],nombre);
    reset(det[i]);
    leer(det[i],regDetArray[i]);
  end;

  minimo(det,regDetArray,min);
  while (min.codCalz<>valoralto) do begin
    leerM(mae,rMae);
    while (rMae.codCalz<min.codCalz) do begin    // No tuvo ventas
      writeln('El calzado con codigo: ',rMae.codCalz,' y numero: ',rMae.numero,' no tiene ventas');
      leerM(mae,rMae);
    end;
    cantVentas:=0;
    while (min.codCalz<>valoralto) and (rMae.codCalz=min.codCalz) and (rMae.numero=min.numero) do begin
      cantVentas:=cantVentas+min.ventas;
      minimo(det,regDetArray,min);
    end;
    if ((cantVentas-rMae.stock)<0) then writeln(archTexto,rMae.codCalz,rMae.numero)
    else begin
      rMae.stock:=rMae.stock-cantVentas;
      seek(mae,Filepos(mae)-1);
      write(mae,rMae);
    end;
  end;
  // completar y cerrar
end.

