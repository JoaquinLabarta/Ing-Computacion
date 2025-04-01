{el área de recursos humanos de un ministerio administra el personal del mismo
distribuido en 10 direcciones generales.
Entre otras funciones, recibe periódicamente un archivo detalle de cada una de las
direcciones conteniendo información de las licencias solicitadas por el personal.
Cada archivo detalle contiene información que indica: código de empleado, la fecha y
la cantidad de días de licencia solicitadas. El archivo maestro tiene información de
cada empleado: código de empleado, nombre y apellido, fecha de nacimiento,
dirección, cantidad de hijos, teléfono, cantidad de días que le corresponden de
vacaciones en ese periodo. Tanto el maestro como los detalles están ordenados por
código de empleado. Escriba el programa principal con la declaración de tipos
necesaria y realice un proceso que reciba los detalles y actualice el archivo maestro
con la información proveniente de los archivos detalles. Se debe actualizar la cantidad
de días que le restan de vacaciones. Si el empleado tiene menos días de los que
solicita deberá informarse en un archivo de texto indicando: código de empleado,
nombre y apellido, cantidad de días que tiene y cantidad de días que solicita.}
program tp2_ej1;
const cant_dir = 10; valoralto = 9999;
type
  tEmpleado = record
    cod: integer;
    nombre: string[20];
    apellido: string[20];
    fechaNac: string[10]; // DD-MM-AAAA
    dir: string[30];
    hij: integer;
    tel: string[10];
    cant_vac: integer;
  end;
  tDetalle = record
    cod: integer;
    fecha: string[10];
    cant_vac_solic: integer;
  end;
  archDetalle = file of tDetalle;
  archMaestro = file of tEmpleado;
  aDetalle = array[1..cant_dir] of archDetalle;
var
  det: aDetalle;
  mae: archMaestro;
  rDet: tDetalle;
  rEmp: tEmpleado;
  aux,i: integer;
  entero: string[2];
  reporte: Text;
procedure leer(var archivo:archDetalle; var dato:tDetalle);
begin
  if(not EOF(archivo)) then read(archivo,dato)
  else dato.cod:=valoralto;
end;
begin
  assign(mae,'Maestro');
  for i := 1 to cant_dir do begin
    Str(i,entero);
    assign(det[i],'Detalle' + entero);
    reset(det[i]);
  end;
  reset(mae);
  assign(reporte,'Archivo de texto.dat');
  reset(reporte);
  // Comienzo merge
  while (not EOF(mae)) do begin
    read(mae,rEmp);
    aux:=rEmp.cod;
    for i:=1 to cant_dir do begin
      leer(det[i],rDet);
      while(rDet.cod < valoralto) do begin
        if (rDet.cod = aux) then begin
          if (rEmp.cant_vac-rDet.cant_vac_solic < 0) then begin
            writeln('No tiene suficientes vacaciones');
            writeln(reporte,rEmp.cod,'-',rEmp.nombre,' ',rEmp.apellido,'-',rEmp.cant_vac,'-',rDet.cant_vac_solic);
          end
          else rEmp.cant_vac:=rEmp.cant_vac-rDet.cant_vac_solic;
        end;
        leer(det[i],rDet);
      end;
      writeln('Termina este archivo detalle');
    end;
    // Termino ese empleado en todos los detalles
    seek(mae,FilePos(mae)-1);
    write(mae,rEmp);
  end;
  // Cierro archivos
  close(mae);
  close(reporte);
  for i:=1 to cant_dir do
  begin
    close(det[i]);
  end;
  readln();
end.

