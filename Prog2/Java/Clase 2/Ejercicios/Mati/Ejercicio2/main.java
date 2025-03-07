
/**
 * Write a description of class main here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
import java.util.Scanner;
public class main
{          
   public static void main2(String[]args)
   {
       Persona [] vPersona;
       vPersona = new Persona[2];
       Scanner in = new Scanner(System.in);
       int i;
       int contador=0;
       
       for (i=0;i<2;i++){
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
         vPersona[i]=p;
       }
       in.close();
       //PUNTO A 
       for (i=0;i<2;i++){
          System.out.println(vPersona[i].toString());}
       in.close();
       //PUNTO B
       int cant65= 0;
       for (i=0;i<2;i++){
          if(vPersona[i].getEdad()>65){
              cant65++;
          }
        }
        System.out.println("la cantidad de personas mayores de 65 es :"+cant65);
       //PUNTO C
       Persona Dnimin =new Persona();
       Dnimin.setDNI(10000000);
       for (i=0;i<2;i++){
          if(vPersona[i].getDNI()<Dnimin.getDNI()){
              Dnimin=vPersona[i];
          }
        }
       System.out.println("la persona con el dni mas chico es :"+Dnimin.toString()); 
        
    }
}
