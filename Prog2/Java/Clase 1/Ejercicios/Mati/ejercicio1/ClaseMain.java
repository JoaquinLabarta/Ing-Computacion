import java.util.Scanner;
public class ClaseMain
{          
   public static void main(String[]args)
   {
       Double a;
       Double b;
       Double c;
       boolean m;
       Scanner in = new Scanner(System.in);
       System.out.println("leer variable x");
       a=in.nextDouble();
       System.out.println("leer variable y");
       b=in.nextDouble();
       System.out.println("leer variable z");
       c=in.nextDouble();
       in.close();
       if((a<b+c)&&(b<a+c)&&(c<a+b))
         m=true;
       else
         m=false;
       if(m=true){
         System.out.println("cumple la funciones");
         System.out.println(a+b+c);}
       else
         System.out.println("no cumple la funcion");    
   }
}
