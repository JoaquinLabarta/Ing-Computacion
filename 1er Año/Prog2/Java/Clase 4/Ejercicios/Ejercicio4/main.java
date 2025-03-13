import java.util.Scanner;

public class main {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        flota f = new flota();
        Micros m = new Micros();
        leermicro(m);
        //--------------------------------------------------------------------------------------
        while ((!m.getPatente().equals("ZZZ000")) && (f.flotaCompleta() == false)){
            f.agregarMicro(m);
            m = new Micros();
            leermicro(m);
        }
        //--------------------------------------------------------------------------------------
        System.out.println("Ingrese la patente del micro a eliminar");
        if (f.eliminarMicro(in.next())){
            System.out.println("El micro se elimino con exito!");
        } else {System.out.println("No hubo exito");}
        
        //Compruebo que se haya eliminado todo ok
        for (int i = 0; i < 15; i++ ){
            System.out.println(f.getMicro(i));
        }
        //--------------------------------------------------------------------------------------
        System.out.println("Ingrese el destino del micro");
        String desbus = in.next();;
        System.out.println("La patente del micro con destino a " +desbus+ " es "+f.buscarMicroDestino(desbus).getPatente()+ " y su horario es "+f.buscarMicroDestino(desbus).getHorario());
        in.close();
    }
    
    public static void leermicro(Micros m){
        Scanner in = new Scanner(System.in);
        System.out.println("Ingrese la patente del micro");
        m.setPatente(in.next());
        if(!m.getPatente().equals("ZZZ000")){
            System.out.println("Ingrese el destino del micro");
            m.setDestino(in.next());
            System.out.println("Ingrese el horario del micro");
            m.setHorario(in.next());
        }
    }
}