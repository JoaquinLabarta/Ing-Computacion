package Ej1;

import java.util.Scanner;

public class Main {
    public static void main (String[] args){
        Scanner in = new Scanner(System.in);
        System.out.println("Ingrese el numero A: ");
        int a = in.nextInt();
        System.out.println("Ingrese el numero B: ");
        int b = in.nextInt();
        while (a>b) {
            System.out.println("El numero B es mayor que A, ingrese otro valor para B: ");
            b = in.nextInt();
        }
        System.out.println("Camino for:");
        Funciones.caminoFor(a, b);
        System.out.println("Camino while:");
        Funciones.caminoWhile(a, b);
        System.out.println("Camino recursivo:");
        Funciones.sinStruct(a, b);
        in.close();
    }
}
