/*
 * 3- Escriba un programa que imprima en consola el factorial de un número N (ingresado por teclado, N > 0).  
 * Ejemplo: para N=5 debería imprimir 5! = 120
 */
package Ejercicio3;

import java.util.Scanner;

public class ejercicio3 {
    public static void main(String[] args) {
        int valor;
        int factorial;
        Scanner in = new Scanner(System.in);
        System.out.println("Ingrese un valor");
        valor = in.nextInt();
        factorial = 1;
        if (valor > 0) {
            for (int i = valor; i > 0; i--) {
                factorial = factorial * i;
            }
        }
        System.out.println("El factorial de " + valor + " es: " + factorial);
        in.close();
    }
}
