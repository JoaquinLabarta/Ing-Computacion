/*5- Escriba un programa que lea las alturas de los 15 jugadores de un equipo de básquet y las almacene en un vector.  Luego informe: 
    • la altura promedio
    • la cantidad de jugadores con altura por encima del promedio
NOTA: Dispone de un esqueleto para este programa en Ej05Jugadores.java */
import java.util.Scanner;
public class ClaseMain
{          
   public static void main(String[]args)
   {
       int jugador;
       int [] vector = new int[15];
       int altura;
       Scanner in = new Scanner(System.in);
       for (jugador=0;jugador<=14;jugador++){
         System.out.println("Ingrese la altura del jugador: ");
         altura=in.nextInt();
         vector[jugador]=altura;
       }
       in.close();
       for (jugador=0;jugador<=14;jugador++){
         System.out.println(vector[jugador]);
       }
       

}
}
