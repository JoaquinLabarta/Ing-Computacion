program tp3_ej2;
const
  valorAlto = 9999;
type
  tVehiculo = record
    codigoVehiculo: integer;
    patente: string[10];
    motor: string[20];
    cantidadPuertas: integer;
    precio: real;
    descripcion: string[10];  // Para '0' o posición libre (ej: '123')
  end;
  tArchivo = file of tVehiculo;
var
  arch: tArchivo;
  vehiculo: tVehiculo;
procedure leer(var arch: tArchivo; var dato: tVehiculo);
begin
  if (not EOF(arch)) then read(arch,dato)
  else dato.codigoVehiculo:=valorAlto;
end;

procedure agregar(var arch: tArchivo; vehiculo: tVehiculo);
var
  veh: tVehiculo;
  posLibre: integer;
begin
  seek(arch,0);
  leer(arch,veh); // Leo la cabecera
  if (veh.descripcion = '0') then seek(arch,Filesize(arch))
  else begin
    Val(veh.descripcion,posLibre);
    seek(arch,posLibre);
    leer(arch,veh);
    seek(arch,0);
    write(arch,veh);
    seek(arch,posLibre);
    end;
  write(arch,vehiculo);
end;
{   regBorrado.descripcion := cab.descripcion;
    write(arch, regBorrado);

    // 2. La cabecera ahora apunta a este nuevo espacio libre
    Str(pos, sLibre);
    cab.descripcion := sLibre;
    seek(arch, 0);
    write(arch, cab);

    writeln('Vehículo eliminado correctamente.');
  end
  else
    writeln('Error: Código de vehículo no encontrado.');

  close(arch);
end;}
procedure eliminar(var arch: tArchivo; codigoVehiculo:integer);
var
  veh,cab: tVehiculo;
  pos: integer;
  posLibreStr: String;
begin
  seek(arch,0);
  leer(arch,cab);
  veh:=cab;
  while ((veh.codigoVehiculo<>valorAlto) or (veh.codigoVehiculo<>codigoVehiculo)) do leer(arch,veh);
  if (veh.codigoVehiculo=codigoVehiculo) then begin
    pos:=Filepos(arch)-1;
    seek(arch,pos);
    write(arch,cab);
    Str(pos,posLibreStr);
    veh.descripcion:=posLibreStr;
    seek(arch,0);
    write(arch,veh);
  end
  else writeln('No se encontro el codigo de vehiculo');
end;

begin
end.

