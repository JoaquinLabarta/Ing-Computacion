program listlist;
type
     ListaInt = ^nodoInt;
     nodoInt = record
              datos:char;
              sig:ListaInt;
              end;

      DatoListaOrd= record
                   list:ListaInt;
                   nodon:integer;
                   end;

     ListaOrd = ^nodo;
     nodo = record
          datos:DatoListaOrd;
          sig:ListaOrd;
          end;


procedure AgregarAlFinal (var pri: ListaInt; c: char);
var act, nue : ListaInt;
begin
new (nue);
nue^.datos:= c;
nue^.sig := NIL;
if pri <> Nil then begin
 act := pri ;
 while (act^.sig <> NIL ) do act := act^.sig ;
 act^.sig := nue ;
 end
 else
 pri:= nue;
end;

procedure AgregarAlFinal2 (var pri: ListaOrd; n: integer);
var act, nue : ListaOrd;
begin
  new (nue);
  nue^.datos.nodon:= n;
  nue^.sig:=nil;
  if pri <> Nil then begin
    act := pri ;
    while (act^.sig <> NIL ) do act := act^.sig ;
      act^.sig := nue ;
  end
  else
    pri:= nue;
end;

procedure RecorrerLista(var ListaO:ListaOrd);
var
  i:integer;act:ListaOrd;caracter:char;
begin
  act:=ListaO;
  for i:= 1 to 2 do begin
    AgregarAlFinal2(act,i);
    act^.datos.list := NIL;
    writeln('ingrese caracter');
    readln(caracter);
    while (caracter<>'z') do begin
      AgregarAlFinal(act^.datos.list,caracter);
      writeln('ingrese caracter');
      readln(caracter);
    end;
  end;
end;

procedure imprimirListinterna (l: ListaInt);
begin
writeln ('Imprime lista nueva ----------');
	while (l<>nil)  do begin
                 writeln(l^.datos);
                 l:= l^.sig;
           end;
end;

procedure ImprimirListaOrdenada(ListaO:ListaOrd);

begin

     while (ListaO <> nil) do begin

           writeln('La marca es ', ListaO^.datos.nodon);
           imprimirListinterna (Listao^.datos.list);
           ListaO:= ListaO^.sig;

     end;

end;


var
  ListaO:ListaOrd;
begin

  ListaO:=nil;
  writeln ('generando lista nueva');

  RecorrerLista(ListaO);

  writeln();
  writeln('Lista nueva');
  ImprimirListaOrdenada(ListaO);
  readln();

end.

