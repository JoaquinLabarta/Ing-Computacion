program ejercicio6;
{Realizar un programa que permita:
a. Crear un archivo binario a partir de la información almacenada en un
archivo de texto. El nombre del archivo de texto es: “libros.txt”
b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
agregar un libro y modificar uno existente. Las búsquedas se realizan por
ISBN.
NOTA: La información en el archivo de texto consiste en: ISBN (nro de 13 dígitos),
título del libro, género, editorial y año de edición. Cada libro se almacena en tres líneas
en el archivo de texto. La primera línea contendrá la información de ISBN y título del
libro, la segunda línea almacenará el año de edición y la editorial y en la tercera línea el
género del libro.}
type
  tBook = record
    ISBN: Int64;
    titulo: string[50];
    genero: string[15];
    editorial: string[30];
    anioEdic: integer;
  end;
  tFile = File of tBook;
function leerLibro(): tBook;
  var
    book: tBook;
  begin
    writeln('Ingrese el ISBN (13 digitos): ');
    readln(book.ISBN);
    while (book.ISBN<1000000000000) or (book.ISBN>9999999999999) do
      begin
        writeln('El ISBN no contiene 13 digitos, ingresar nuevamente: ');
        readln(book.ISBN);
      end;
    writeln('Ingrese el titulo del libro: ');
    readln(book.titulo);
    writeln('Ingrese el genero del libro: ');
    readln(book.genero);
    writeln('Ingrese la editorial del libro: ');
    readln(book.editorial);
    writeln('Ingrese el anio de edicion: ');
    readln(book.anioEdic);
    while (book.anioEdic<0) or (book.anioEdic>2025) do
      begin
        writeln('Anio de edicion invalido, ingresar nuevamente: ');
        readln(book.anioEdic);
      end;
    writeln('Libro leido correctamente');
    leerLibro:=book;
  end;
procedure addBook(var binaryFile: tFile; book: tBook);
  begin
    reset(binaryFile);
    seek(binaryFile,filesize(binaryfile));
    write(binaryfile,book);
    writeln('Libro agregado correctamente');
    close(binaryFile);
  end;
procedure modifyBook(var binaryFile: tFile);
  var
    opc,pos: integer;
    isbn: Int64;
    book: tBook;
    bool: boolean;
  begin
   reset(binaryFile);
       writeln('Indique el ISBN del libro a modificar: ');
       readln(isbn);
       while (isbn<1000000000000) or (isbn>9999999999999) do
        begin
          writeln('El ISBN no contiene 13 digitos, ingresar nuevamente: ');
          readln(isbn);
        end;
       bool:=false;
       while (not EOF(binaryFile) and not bool) do
        begin
          read(binaryFile,book);
          if book.ISBN = isbn then
             begin
                  bool:=true;
                  pos:=filepos(binaryFile)-1;
             end;
        end;
       if bool then
          begin
             writeln('Indique la opcion a modificar: ');
             writeln('1: ISBN');
             writeln('2: Titulo');
             writeln('3: Genero');
             writeln('4: Editorial');
             writeln('5: Anio de edicion');
             writeln('Opcion: ');
             read(opc);
             case opc of
               1: begin
                   writeln('Ingrese el nuevo ISBN: ');
                   readln(book.ISBN);
                   while (book.ISBN<1000000000000) or (book.ISBN>9999999999999) do
                    begin
                      writeln('El ISBN no contiene 13 digitos, ingresar nuevamente: ');
                      readln(book.ISBN);
                    end;
                  end;
               2: begin
                   writeln('Ingrese el nuevo titulo: ');
                   readln(book.titulo);
                  end;
               3: begin
                   writeln('Ingrese el nuevo genero: ');
                   readln(book.genero);
                  end;
               4: begin
                   writeln('Ingrese la nueva editorial: ');
                   readln(book.editorial);
                  end;
               5: begin
                   writeln('Ingrese el nuevo anio: ');
                   readln(book.anioEdic);
                   while (book.anioEdic<0) or (book.anioEdic>2025) do
                    begin
                      writeln('Anio de edicion invalido, ingresar nuevamente: ');
                      readln(book.anioEdic);
                    end;
                  end;
             end;
             seek(binaryFile,pos);
             write(binaryFile,book);
             writeln('El archivo se modifico correctamente');
          end
       else writeln('No se encontro el ISBN');
   close(binaryFile);
  end;

function textToBinary(var textFile: Text; var binaryFile: tFile): boolean;
  var
    book: tBook;
    ok: boolean;
  begin
    ok:=false;
    reset(textFile);
    rewrite(binaryFile);
    while not EOF(textFile) do
      begin
        readln(textFile, book.ISBN, book.titulo);
        readln(textFile, book.anioEdic, book.editorial);
        readln(textFile, book.genero);
        write(binaryFile,book);
      end;
    if filesize(binaryFile)>0 then
       begin
            writeln('Archivo binario generado correctamente');
            ok:=true;
       end
    else writeln('Error al crear archivo');
    writeln('------------------------------------------------------------');
    close(textFile);
    close(binaryFile);
    textToBinary:=ok;
  end;
begin
  readln();
end.

