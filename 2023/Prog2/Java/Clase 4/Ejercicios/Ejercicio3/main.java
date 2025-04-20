
import java.util.Scanner;
public class main
{
    public static void main(String[]args)
    {
        Scanner in = new Scanner(System.in);
        Micros m1 = new Micros("ABC123","5:00 am","Mar del Plata");
        System.out.println("Ingrese numero de persona");
        int num = in.nextInt();
        while ((num != -1) && (m1.lleno() == false)){
            if(m1.ocuparAsiento(num) == true){
                System.out.println("El asiento se ocupo correctamente");
            }
            else if(m1.asientoOcupado(num)){
                System.out.println("El asiento estaba ocupado anteriormente");
                System.out.println("El primer asiento libre es: " + m1.asientoLibre());
            }          
            else{
                System.out.println("El asiento no es valido");
            }
            if (!m1.lleno()){
                System.out.println("Ingrese numero de persona");
                num = in.nextInt();
            } else{
                System.out.println("Micro Lleno");
            }
        }
        System.out.println("La cantidad de asientos ocupados del micro es: " + m1.cantAsientos());
        in.close();
    }
}
