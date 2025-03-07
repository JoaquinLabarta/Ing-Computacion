program ejercicio2;
type

  datol=record
    cvuelo:string;
    clase:string;
    cantm:integer;
  end;

  lista = ^nodo;
  nodo = record
              info:datol;
              sig:lista;
  end;

  datoarb=record
     nombre: string;
     apellido: string;
     dni:integer;
     total: integer;
     l:lista;
  end;

  // Arbol de enteros
  arbol= ^nodoA;
  nodoA = Record
    dato: datoarb;
    HI: arbol;
    HD: arbol;
  End;


 Procedure agregarAdelante(var l: lista; t: datol);
 var
      aux: lista;
 begin
        new(aux);
        aux^.info := t;
        aux^.sig := l;
        l:= aux;
 end;

procedure leerdatos(var venta:datol);
begin
  writeln('ingrese codigo de vuelo');
  readln(venta.cvuelo);
  if(venta.cvuelo<>'zzz')then begin
    venta.cantm:=random(100);
    writeln('La cantidad de millas es: ',venta.cantm);
    writeln('ingrese clase');
    readln(venta.clase);
  end;
end;

Procedure insertar(var a: arbol; info:datol;var dni:integer);
begin
   if (a = nil)then
    begin
      new (a);
      a^.dato.total:=0;
      writeln('ingrese el nombre');
      readln(a^.dato.nombre);
      writeln('ingrese el apellido');
      readln(a^.dato.apellido);
      a^.dato.dni:=dni;
      a^.dato.l:=nil;
      agregarAdelante(a^.dato.l,info);
      a^.HI := nil;
      a^.HD := nil;
    end
   else
     if a^.dato.dni> dni then
      insertar(a^.HI, info,dni)
    else
      if a^.dato.dni< dni then
       insertar(a^.HD, info,dni)
    else begin
       if(info.clase='turista')then
         a^.dato.total:=a^.dato.total+info.cantm*25
       else
         a^.dato.total:=a^.dato.total+info.cantm*100;
       agregarAdelante(a^.dato.l,info);
    end;
end;

Procedure maximo( a: arbol; var max, dnimax: integer );
begin
  if ( a <> nil ) then begin
    if(a^.dato.total>max)then begin
      max:=a^.dato.total;
      dnimax:=a^.dato.dni;
    end;
    maximo(a^.HI,max,dnimax);
    maximo(a^.HD,max,dnimax);
end;

end;
var
  a:arbol;
  venta:datol;
  dni:integer;
  max:integer;
  dnimax:integer;
begin
  randomize();
  a:=nil;
  leerdatos(venta);
  while(venta.cvuelo<>'zzz')do begin
    dni:=random(5);
    writeln('El dni es: ', dni);
    insertar(a,venta,dni);
    leerdatos(venta);
  end;
  maximo(a,max,dnimax);
  writeln('el dni que contiene el maximo es : ',dnimax,' la cantidad es :',max);
  readln();
end.

