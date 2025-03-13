 

import java.util.Scanner;

public class ejercicio1 {
    public static void main(String[] args) {
        // Declaracion de variables
        double a;
        double b;
        double c;
        double perimetro;

        Scanner in = new Scanner(System.in);
        // Lectura de datos
        System.out.println("Ingrese el lado a: ");
        a = in.nextDouble();
        System.out.println("Ingrese el lado b: ");
        b = in.nextDouble();
        System.out.println("Ingrese el lado c: ");
        c = in.nextDouble();
        // Condicion y resolucion
        if ((a < b + c) && (b < a + c) && (c < a + b)) {
            perimetro = a + b + c;
            System.out.println("El triangulo es valido, su perimetro es: " + perimetro);
        } else
            System.out.println("Triangulo no valido");
        in.close();
    }
}
