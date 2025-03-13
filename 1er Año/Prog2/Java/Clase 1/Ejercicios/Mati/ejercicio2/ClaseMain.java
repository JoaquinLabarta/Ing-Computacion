import java.util.Scanner;
public class ClaseMain
{          
   public static void main(String[]args)
   {
       int patente;
       boolean pasa;
       Scanner in = new Scanner(System.in);
       System.out.println("leer patente");
       patente = in.nextInt();
       while(patente != 0){
           if(patente%2 == 0)
             System.out.println("el vehiculo pasa");
           else
             System.out.println("el vehiculo no pasa");
           System.out.println("leer variable x");
           patente=in.nextInt();     
        }
       in.close();    
   }
}
