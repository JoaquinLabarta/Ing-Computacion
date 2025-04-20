
/*
2-   Utilizando la clase Persona (ya implementada). 
a) Realice un programa que almacene en un vector 15 personas. La información de cada persona debe leerse de teclado. 
Luego de almacenar la informacion:    
b) Agregue un método que devuelva la cantidad de personas mayores de 65 años.
c) Agregue un método que devuelva la representación de la persona con menor DNI.
d) Muestre desde el programa principal la cantidad de personas mayores de 65 años y
   muestre también la representación por pantalla de una persona con menor DNI.
 */

import java.util.Scanner;
public class ejercicio2 {
    public static void main(String[]args){
        //Declaracion de variables
        Scanner in = new Scanner(System.in);
        int DIMFV = 3;
        Persona vector[] = new Persona[DIMFV];
        //Esta carga pudiera hacerla con una funcion, retornando el vector cargado.
        for (int i = 0; i < DIMFV; i++){
            //Lectura de los datos.
            System.out.println("Ingrese el nombre de la persona "+i);
            String Nom = in.next();
            System.out.println("Ingrese el dni de la persona "+i);
            int Dni = in.nextInt();
            System.out.println("Ingrese la edad de la persona "+i);
            int Edad = in.nextInt();
            //Guardo datos en el vector.
            vector[i] = new Persona(Nom,Dni,Edad);
        }
        
        //--------------------------------Punto B------------------------------------------------------------
        System.out.println("La cantidad de personas con mas de 65 a�os es: "+contador(vector,DIMFV));
        
        //--------------------------------Punto C------------------------------------------------------------
        System.out.println("La informacion de la persona con el dni minimo es: "+dnimin(vector,DIMFV));
        in.close();  
    }
    
    public static int contador(Persona vec[],int dimf){ 
        int count = 0;
        for (int i = 0; i < dimf; i++){
            if (vec[i].getEdad() > 65){count ++;}
        }
        return count;
    }
    
    public static String dnimin(Persona vec[],int dimf){
        Persona menorDni = new Persona();
        menorDni.setDNI(99999999);
        for (int i = 0; i < dimf; i++){
            if (vec[i].getDNI() <= menorDni.getDNI()){menorDni = vec[i];}
        }
        return menorDni.toString();
    }
}
/*Imprimo datos
System.out.println(vector[i].toString());
System.out.println(vector[i].getDNI());
System.out.println(vector[i].getNombre());
System.out.println(vector[i].getEdad()); */
