
/*1-A– Defina constructores para la clase Triángulo (definida en la Act. 3 - Parte 1): el primer constructor debe recibir un valor para cada lado 
        y para los colores de línea y relleno; el segundo constructor no debe poseer parámetros ni código (constructor nulo). 
   B- Realice un programa que instancie un triángulo mediante los distintos constructores.

 */
import java.util.Scanner;
public class main
{
    public static void main(String[]args) {
        Scanner in = new Scanner (System.in);
        //Primer triangulo con parametros dados
        triangulo tri1 = new triangulo(2.3, 4.2, 5.3, "azul", "amarillo");
        //Imprimo primer triangulo
        System.out.println(tri1.toString());
        //Segundo triangulo con parametros cargados
        triangulo tri2 = new triangulo();
        System.out.println("Ingrese el lado 1 del triangulo");
        tri2.setlado1(in.nextDouble());
        System.out.println("Ingrese el lado 2 del triangulo");
        tri2.setlado2(in.nextDouble());
        System.out.println("Ingrese el lado 3 del triangulo");
        tri2.setlado3(in.nextDouble());
        System.out.println("Ingrese el color de relleno del triangulo");
        tri2.setcolorR(in.next());
        System.out.println("Ingrese el color de linea del triangulo");
        tri2.setcolorL(in.next());
        //Imprimo segundo triangulo
        System.out.println(tri2.toString());
        in.close();
    }
}
