/**
 a) Implemente un programa que cargue un vector con los 325 partidos disputados en la superliga 2018/2019. 
Luego de la carga realizar los métodos que considere necesarios para informar:
b) La cantidad de partidos que ganó River.
c) El total de goles que realizó Boca jugando de local.
d) El porcentaje de partidos finalizados con empate. 
 */
import java.util.Scanner;
public class main
{
    public static void main(String[]args)
   {
       Partido [] vPartidos;
       int tPartidos=2;
       vPartidos = new Partido[tPartidos];
       Scanner in = new Scanner(System.in);
       int i;
       int contador=0;
       
       for (i=0;i<tPartidos;i++){
         System.out.println("ingrese un local");
         String eLocal = in.next();
         System.out.println("ingrese un visitante");
         String eVisitante = in.next();
         System.out.println("goles locales");
         int gLocales = in.nextInt();
         System.out.println("goles visitantes");
         int vLocales = in.nextInt();
         Partido p = new Partido();
         p.setLocal(eLocal);
         p.setVisitante(eVisitante);
         p.setGolesLocal(gLocales);
         p.setGolesVisitante(vLocales);
         vPartidos[i]=p;
       }
       in.close();
       //PUNTO A 
       for (i=0;i<tPartidos;i++){
          System.out.println("el equipo ganador del partido: "+i+" es  :"+vPartidos[i].getGanador());}
       in.close();
       //PUNTO B
       int wRiver=0;
       for (i=0;i<tPartidos;i++){
          if(vPartidos[i].getGanador().equals("river"))
            wRiver++;
        }
       System.out.println("la cantidad de partidos que gano river es : "+wRiver);
       //PUNTO C
       int gBocaL=0;
       for (i=0;i<tPartidos;i++){
          if(vPartidos[i].getLocal().equals("boca"))
            gBocaL=gBocaL+vPartidos[i].getGolesLocal();
        }
       System.out.println("la cantidad de goles de boca de local son : "+gBocaL);
       
       //PUNTO D
       int pEmpate=0;
       for (i=0;i<tPartidos;i++){
          if(vPartidos[i].hayEmpate())
            pEmpate++;
        }
        System.out.println("el porcentaje de partidos que resulto en empate es : "+(pEmpate * 100 / tPartidos));
       
   }
}
