/*3- Escriba un programa que imprima en consola el factorial de un número N (ingresado por teclado, N > 0).  
Ejemplo: para N=5 debería imprimir 5! = 120*/
import java.util.Scanner;
public class ClaseMain
{          
   public static void main(String[]args)
   {
       Scanner in = new Scanner(System.in);
       int x;
       int i;
       System.out.println("leer valor que desea sacar factorial");
       x=in.nextInt();
       for (i=x-1;i>0;i--)
          x=x*i;
       System.out.print(x);   
       in.close();    
   }
}
