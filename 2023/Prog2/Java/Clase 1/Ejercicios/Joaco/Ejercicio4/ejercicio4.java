/*
 * Escriba un programa que imprima en consola el factorial de todos los números entre 1 y 9. 
 * ¿Qué modificación debe hacer para imprimir el factorial de los números impares solamente?
 */
package Ejercicio4;

import java.util.Scanner;

public class ejercicio4 {
    public static void main(String[] args) {
        int facto;
        facto = 1;
        Scanner in = new Scanner(System.in);
        for (int i = 1; i <= 9; i++) {
            System.out.print("El numero a sacar el factorial es: " + i);

            for (int j = i; j > 0; j--) {
                facto = facto * j;
            }
            System.out.println(" Su factorial es: " + facto);
            facto = 1;
        }
        in.close();
    }
}
