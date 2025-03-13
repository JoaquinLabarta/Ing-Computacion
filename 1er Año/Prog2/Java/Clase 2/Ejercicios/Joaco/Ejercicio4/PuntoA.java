
import java.util.Scanner;
public class PuntoA{
    public static Partido[] cargarvector(Partido vec[], int dimf){
        Scanner in = new Scanner(System.in);
        for (int i = 0; i < dimf; i++){
            System.out.println("Ingrese el equipo local");
            String eqloc = in.next();
            System.out.println("Ingrese el equipo visitante");
            String eqvis = in.next();
            System.out.println("Ingrese la cantidad de goles del equipo local");
            int golloc = in.nextInt();
            System.out.println("Ingrese la cantidad de goles del equipo visitante");
            int golvis = in.nextInt();
            vec[i] = new Partido(eqloc,eqvis,golloc,golvis);
        }
        in.close();
        return vec;
    }
}