/*4- Escriba un programa que imprima en consola el factorial de todos los números entre 1 y 9.
     ¿Qué modificación debe hacer para imprimir el factorial de los números impares solamente?*/
import java.util.Scanner;
public class ClaseMain
{          
   public static void main(String[]args)
   {
       int y;
       int x;
       int resultado=1;
       for (y=1;y<=9;y++){  
         if(y !=1){
           resultado=1;  
           for (x=y;x>0;x--){
              resultado=resultado*x;}
           System.out.println(resultado);
        }
         else{
           System.out.println(y);} 
       }

}
}