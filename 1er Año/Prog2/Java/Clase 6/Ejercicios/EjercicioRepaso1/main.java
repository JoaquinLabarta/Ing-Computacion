import java.util.Scanner;
public class main{
    public static void main(String[]args) {
        int DIMF = 2;
        int DIML = 0;
        Scanner in = new Scanner(System.in);
        Ejemplar[] vec = new Ejemplar[DIMF];
        cargarEjemplar(vec,DIML,DIMF);
        for(int i = 0; i < DIMF; i++){
            System.out.println(vec[i].informe());
        }
        in.close();
    }
    
    public static void cargarEjemplar(Ejemplar[] vec, int DIML, int DIMF){
        Scanner in = new Scanner(System.in);
        for(int i = 0; i < DIMF; i++){
            System.out.println("Ingrese si es libro o revista");
            String queEs = in.next();
            if(queEs.equals("libro")){
                leerLibro(vec,i,DIML);
            } else if(queEs.equals("revista")){
                leerRevista(vec,i,DIML);
            }
        }
    }
    
    public static void leerLibro(Ejemplar[] vec, int i, int DIML){
        Scanner in = new Scanner(System.in);
        System.out.println("Datos del autor del libro");
        Autor a = leerAutor();
        System.out.println("Ingrese el ID del libro");
        String ID = in.next();
        System.out.println("Ingrese la cantidad de paginas del libro");
        int cantPag = in.nextInt();
        System.out.println("Escriba el resumen del libro");
        String resumen = in.next();
        System.out.println("El libro esta publicado?");
        boolean publico = in.nextBoolean();
        System.out.println("Ingrese el titulo del libro");
        String titulo = in.next();
        System.out.println("Ingrese la cantidad de capitulos del libro");
        int cantCap = in.nextInt();
        System.out.println("El libro es de bolsillo?");
        boolean bolsillo = in.nextBoolean();
        if(publico){
            System.out.println("Ingrese el año de publicacion");
            int año = in.nextInt();
            Libro l = new Libro(ID,cantPag,resumen,a,publico,año,titulo,cantCap,bolsillo);
            vec[i] = l;
            DIML++;
        } else {
            Libro l = new Libro(ID,cantPag,resumen,a,publico,titulo,cantCap,bolsillo);
            vec[i] = l;
            DIML++;
        }
        
    }
    
    public static void leerRevista(Ejemplar[] vec, int i, int DIML){
        Scanner in = new Scanner(System.in);
        System.out.println("Datos del autor de la revista");
        Autor a = leerAutor();
        System.out.println("Ingrese el ID de la revista");
        String ID = in.next();
        System.out.println("Ingrese la cantidad de paginas de la revista");
        int cantPag = in.nextInt();
        System.out.println("Escriba el resumen de la revista");
        String resumen = in.next();
        System.out.println("La revista esta publicada?");
        boolean publico = in.nextBoolean();
        System.out.println("Ingrese el nombre de la revista");
        String nombre = in.next();
        System.out.println("Ingrese la cantidad de articulos de la revista");
        int cantArt = in.nextInt();
        int nroVol = Generador.getNroVolumen();
        if(publico){
            System.out.println("Ingrese el año de publicacion");
            int año = in.nextInt();
            Revista r = new Revista(ID,cantPag,resumen,a,publico,año,nombre,nroVol,cantArt);
            vec[i] = r;
            DIML++;    
        } else {
            Revista r = new Revista(ID,cantPag,resumen,a,publico,nombre,nroVol,cantArt);
            vec[i] = r;
            DIML++;
        }
    }
    
    public static Autor leerAutor(){
        Scanner in = new Scanner(System.in);
        System.out.println("Ingrese el nombre del autor");
        String nombreApellido = in.next();
        System.out.println("Ingrese el dni del autor");
        int dni = in.nextInt();
        Autor a = new Autor(dni,nombreApellido);
        return a;
    }
}
