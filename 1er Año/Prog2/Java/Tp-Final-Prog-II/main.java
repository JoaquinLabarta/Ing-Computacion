import java.util.Scanner;

public class main {
    public static void main(String[] args) {
        Editorial e = new Editorial();

        for (int i = 0; i < 2; i++) {
            Libro l = null;
            l = leerLibro();
            e.cargarVector(l);
            System.out.println(l.toString());
        }
        System.out.println(e.toString());
    }

    public static Libro leerLibro() {
        Scanner in = new Scanner(System.in);
        Libro l = null;
        System.out.println("Ingrese el tipo de libro: ");
        String tipo = in.nextLine();

        if (tipo.equals("literatura")) {
            l = leerLiteratura(in); // Pasamos el Scanner como argumento
        } else if (tipo.equals("divulgativo")) {
            l = leerDivulgativo(in); // Pasamos el Scanner como argumento
        }
        // No cerramos el Scanner aquí
        return l;
    }

    public static Libro leerLiteratura(Scanner in) {
        System.out.println("Ingrese el ISBN del libro: ");
        String ISBN = in.nextLine();
        System.out.println("Ingrese el nombre del libro: ");
        String nombre = in.nextLine();
        System.out.println("Ingrese la cantidad de páginas del libro: ");
        int cantPag = in.nextInt();
        System.out.println("Ingrese el precio del libro: ");
        float precio = in.nextFloat();
        in.nextLine(); // Limpiar el buffer después de nextInt o nextFloat
        System.out.println("Ingrese la fecha de publicación del libro: ");
        String fecha = in.nextLine();
        System.out.println("Ingrese el género del libro: ");
        String genero = in.nextLine();
        System.out.println("Ingrese si es de bolsillo (true/false): ");
        boolean bolsillo = in.nextBoolean();
        in.nextLine(); // Limpiar el buffer después de nextBoolean

        Autor a = leerAutor(in); // Pasamos el Scanner como argumento
        return new Literatura(genero, bolsillo, ISBN, nombre, cantPag, precio, fecha, a, "literatura");
    }

    public static Libro leerDivulgativo(Scanner in) {
        System.out.println("Ingrese el ISBN del libro: ");
        String ISBN = in.nextLine();
        System.out.println("Ingrese el nombre del libro: ");
        String nombre = in.nextLine();
        System.out.println("Ingrese la cantidad de páginas del libro: ");
        int cantPag = in.nextInt();
        System.out.println("Ingrese el precio del libro: ");
        float precio = in.nextFloat();
        in.nextLine(); // Limpiar el buffer después de nextInt o nextFloat
        System.out.println("Ingrese la fecha de publicación del libro: ");
        String fecha = in.nextLine();
        System.out.println("Ingrese el tipo de divulgación: ");
        String tipoD = in.nextLine();

        Autor a = leerAutor(in); // Pasamos el Scanner como argumento
        return new Divulgativo(tipoD, ISBN, nombre, cantPag, precio, fecha, a, tipoD);
    }

    public static Autor leerAutor(Scanner in) {
        System.out.println("Ingrese el autor del libro: ");
        String nombreA = in.nextLine();
        System.out.println("Ingrese el DNI del autor: ");
        int dniA = in.nextInt();
        in.nextLine(); // Limpiar el buffer después de nextInt
        System.out.println("Ingrese la nacionalidad del autor: ");
        String nacA = in.nextLine();

        return new Autor(dniA, nombreA, nacA);
    }
}