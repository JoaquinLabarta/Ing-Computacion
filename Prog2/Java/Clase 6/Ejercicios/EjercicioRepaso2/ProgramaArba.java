import java.util.Scanner;
public class ProgramaArba{
    public static void main(String[]args){
        //Declaracion de variables
        int DIMF = 10000;
        int DIML = 0;
        Vehiculo[] vec = new Vehiculo[DIMF];
        //Cuerpo principal
        Scanner in = new Scanner(System.in);
        cargarVector(DIMF,DIML,vec);
        imprimirDatos(vec,DIMF);
        in.close();
    }
    
    public static void imprimirDatos(Vehiculo[] vec, int DIMF){
        for(int i = 0; i<DIMF;i++){
            System.out.println("El monto a pagar por el vehiculo es: " + vec[i].calcularCosto());
        }
    }
    
    public static void cargarVector(int DIMF, int DIML, Vehiculo[] vec){
        Scanner in = new Scanner(System.in);
        for(int i = 0; i < DIMF; i++){
            //Cargar propietario
            System.out.println("Primero debe completar los datos del propietario");
            Propietario p = leerPropietario();
            System.out.println("Propietario cargado");
            //Cargar vehiculo
            System.out.println("Elija un vehiculo a declarar: embarcacion o automotor");
            String tipo = in.next();
            //Opciones del vehiculo
            if(tipo.equals("automotor")){
                cargarAutomotor(vec,i,p);
                DIML++;
            } else if(tipo.equals("embarcacion")){
                cargarEmbarcacion(vec,i,p);
                DIML++;
            }
        }
    }
    
    public static void cargarAutomotor(Vehiculo[] vec, int i, Propietario p){
        Scanner in = new Scanner (System.in);
        //Datos del vehiculo
        System.out.println("Ingrese el año del automotor");
        int año = in.nextInt();
        System.out.println("Ingrese el importe basico a pagar");
        int impB = in.nextInt();
        System.out.println("Ingrese la patente del automotor");
        String pat = in.next();
        System.out.println("Ingrese el importe adicional");
        int impA = in.nextInt();
        System.out.println("Ingrese una breve descripcion del vehiculo");
        String desc = in.next();
        //Cargo en el vector
        Automotor a = new Automotor(año,p,impB,pat,impA,desc);
        vec[i] = a;
    }
    
    public static void cargarEmbarcacion(Vehiculo[] vec, int i, Propietario p){
        Scanner in = new Scanner (System.in);
        //Datos del vehiculo
        System.out.println("Ingrese el año del embarcacion");
        int año = in.nextInt();
        System.out.println("Ingrese el importe basico a pagar");
        int impB = in.nextInt();
        System.out.println("Ingrese el codigo REY");
        int codRey = in.nextInt();
        System.out.println("Ingrese el nombre de la embarcacion");
        String nom = in.next();
        System.out.println("Ingrese el tipo de embarcacion");
        String tipo = in.next();
        System.out.println("Ingrese la eslora");
        int eslora = in.nextInt();
        System.out.println("Ingrese el peso del vehiculo");
        int peso = in.nextInt();
        System.out.println("Ingrese el precio del vehiculo");
        int precio = in.nextInt();
        //Cargo en el vector
        Embarcacion e = new Embarcacion(año,p,impB,codRey,nom,tipo,eslora,peso,precio);
        vec[i] = e;
    }
    
    public static Propietario leerPropietario(){
        Scanner in = new Scanner (System.in);
        System.out.println("Ingrese su CIT");
        int cit = in.nextInt();
        System.out.println("Ingrese su nombre");
        String nom = in.next();
        System.out.println("Ingrese su apellido");
        String ape = in.next();
        Propietario p = new Propietario(nom,ape,cit);
        return p;
    }
}