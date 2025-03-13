
/**
 * Write a description of class main here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.Scanner;
public class main
{          
   public static void main(String[]args)
   {
       Scanner in = new Scanner(System.in);
       System.out.println("ingrese su edad");
       int miEdad = in.nextInt();
       System.out.println("ingrese su dni");
       int miDni1 = in.nextInt();
       System.out.println("ingrese su nombre");
       String miNom = in.next();
       Persona p = new Persona();
       p.setDNI(miDni1);
       p.setEdad(miEdad);
       p.setNombre(miNom);
       System.out.println(p.toString());
       in.close();
    }
}
