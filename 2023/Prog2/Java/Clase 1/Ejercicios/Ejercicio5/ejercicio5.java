/*
 * 5- Escriba un programa que lea las alturas de los 15 jugadores de un equipo de básquet y 
 * las almacene en un vector. Luego informe: 
    -la altura promedio
    -la cantidad de jugadores con altura por encima del promedio
NOTA: Dispone de un esqueleto para este programa en Ej05Jugadores.java
 */
package Ejercicio5;

import java.util.Scanner;

public class ejercicio5 {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);

        // Paso 1: Declarar la variable vector de alturas
        int DIMF = 15;
        int[] alturas;
        int dato;
        int suma;
        int suma2;
        double prom;
        
        alturas = new int[DIMF];
        suma = 0;
        suma2 = 0;

        // Paso 3: Declarar y crear el scanner
        for (int i = 0; i < DIMF; i++) {
            System.out.println("Ingrese la altura del jugador " + i);
            dato = in.nextInt();
            alturas[i] = dato;
            suma = suma + alturas[i];
        }
        
        prom = suma/DIMF;
        System.out.println("La altura promedio es " + (prom));
        
        // Paso 7: Recorrer el vector, contar los números que son mayores que el promedio
        for (int j = 0; j < DIMF; j++){
            if (alturas[j] > prom) suma2 ++;
        }
        
        System.out.println("La cantidad de jugadores con altura mayor al promedio son: "+suma2);
        
        in.close();
    }
}