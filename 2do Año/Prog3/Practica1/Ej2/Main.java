package Ej2;

import java.util.Scanner;

public class Main {
    public static void main(String[] args){
        Scanner in = new Scanner(System.in);
        System.out.println("Ingrese la dimension fisica del vector: ");
        int n = in.nextInt();
        vClass.crearV(n);
        in.close();
    }
}
