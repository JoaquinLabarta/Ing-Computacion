
/*
 3- A- Modifique la clase Persona (del ejercicio 2 de la clase 2) para representar entrenadores de un club de fútbol. 
 Un entrenador se caracteriza por su nombre, sueldo básico y la cantidad de campeonatos ganados.
	* Defina métodos para obtener/modificar el valor de cada atributo.
	* Defina el método calcularSueldoACobrar que calcula y devuelve el sueldo a cobrar por el entrenador. 
        El sueldo se compone del sueldo básico, al cual se le adiciona un plus por campeonatos ganados 
        (5000$ si ha ganado entre 1 y 4 campeonatos; $30.000 si ha ganado entre 5 y 10 campeonatos; 50.000$ si ha ganado más de 10 campeonatos). 

    B- Realizar un programa principal que instancie un entrenador, cargándole datos leídos desde teclado. 
       Pruebe el correcto funcionamiento de cada método implementado.
 */

import java.util.Scanner;
public class main{
    public static void main (String[]args){
        //Declaracion de variables
        Scanner in = new Scanner(System.in);
        Persona p = new Persona();
        String nom;
        int camp;
        //Leer datos
        System.out.println("Ingrese el nombre del entrenador");
        nom = in.next();
        System.out.println("Ingrese la cantidad de torneos ganados");
        camp = in.nextInt();
        p = new Persona(nom,camp);
        System.out.println("Info del entrenador: " + p.toString());
    }
}
