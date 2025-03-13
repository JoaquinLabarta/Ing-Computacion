
import java.util.Scanner;
public class main {
    public static void main(String[]args){
        //Variables
        entrenador ent = new entrenador();
        jugador jug = new jugador();
        //Cuerpo
        Scanner in = new Scanner(System.in);
        leerEntrenador(ent);
        System.out.println(ent.toString());
        leerJugador(jug);
        System.out.println(jug.toString());
        in.close();    
    }
    
    public static void leerEntrenador(entrenador ent){
        Scanner in = new Scanner(System.in);
        System.out.println("Creacion del Entrenador");
        System.out.println("Ingrese el nombre");
        ent.setNombre(in.next());
        System.out.println("Ingrese la edad");
        ent.setEdad(in.nextInt());
        System.out.println("Ingrese el dni");
        ent.setDni(in.nextInt());
        System.out.println("Ingrese el sueldo");
        ent.setSueldo(in.nextDouble());
        System.out.println("Ingrese la cantidad de torneos ganados");
        ent.setTorneos(in.nextInt());
    }
    
     public static void leerJugador(jugador jug){
        Scanner in = new Scanner(System.in);
        System.out.println("Creacion del Jugador");
        System.out.println("Ingrese el nombre");
        jug.setNombre(in.next());
        System.out.println("Ingrese la edad");
        jug.setEdad(in.nextInt());
        System.out.println("Ingrese el dni");
        jug.setDni(in.nextInt());
        System.out.println("Ingrese el sueldo");
        jug.setSueldo(in.nextDouble());
        System.out.println("Ingrese la cantidad de partidos jugados");
        jug.setPart(in.nextInt());
        System.out.println("Ingrese la cantidad de goles anotados");
        jug.setGoles(in.nextInt());
    }
}