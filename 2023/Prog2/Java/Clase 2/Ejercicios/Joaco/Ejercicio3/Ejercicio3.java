import java.util.Scanner;
public class Ejercicio3{
    public static void main(String[]args){
        Scanner in = new Scanner (System.in);
        String saludo1=new String("hola");
        String saludo2=new String("hola");
        System.out.println(saludo1 == saludo2); //imprime false, ya que pregunta si la direccion de memoria donde se almacenan los objetos es la misma.
        System.out.println(saludo1 != saludo2); //imprime true, por la condicion anterior.
        System.out.println(saludo1.equals(saludo2)); //imprime true, ya que compara sobre el "valor" de los objetos.
        
        //-----------------------------Punto 2----------------------------------------
        Persona p1; 
        Persona p2;
        p1 = new Persona();
        p1.setNombre("Pablo Sotile");
        p1.setDNI(11200413);
        p1.setEdad(40);
        p2 = new Persona();
        p2.setNombre("Julio Toledo");
        p2.setDNI(22433516);
        p2.setEdad(51);
        p1 = p2; //Iguala las direcciones de memoria, perdiendo asi la direccion del objeto 1.
        p1.setEdad( p1.getEdad() + 1 ); //Modifica la edad de ambos objetos en una unidad.
        System.out.println(p2.toString()); //Imprime nombre + dni + (edad + 1)
        System.out.println(p1.toString()); //Imprime lo mismo
        System.out.println( (p1 == p2) ); //Imprime true, ya que contienen la misma direccion de memoria.

        in.close();
    }
}