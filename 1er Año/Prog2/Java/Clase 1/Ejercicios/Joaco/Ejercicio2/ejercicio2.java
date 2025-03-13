/*
 2 - Escriba un programa para restringir la entrada de autos al centro de la ciudad: sólo pasarán aquellos 
 con patente par. Para ello se leen números de patentes, por cada una debe informar en consola si el auto 
 tiene o no permitido el paso.  La lectura finaliza cuando se ingresa la patente 0. Al finalizar, 
 informar el porcentaje de autos que ingresaron respecto al total de autos. 
 */
package Ejercicio2;

import java.util.Scanner;

public class ejercicio2 {
    public static void main(String[] args) {
        // declaracion de variables
        int patente;
        int autostotal;
        int autosentraron;
        Scanner in = new Scanner(System.in);
        autostotal = 0;
        autosentraron = 0;
        System.out.println("Ingrese la patente del auto");
        patente = in.nextInt();
        while (patente != 0) {
            autostotal++;
            if (patente % 2 == 0) {
                System.out.println(" El auto de patente " + patente + " Entró");
                autosentraron++;
            } else
                System.out.println(" El auto de patente " + patente + " No entró");
            System.out.println("Ingrese la patente del auto");
            patente = in.nextInt();
        }
        System.out.println("El porcentaje de autos que entraron con respecto a los que pasaron es de: "
                + (autosentraron * 100 / autostotal));
        in.close();
    }
}
