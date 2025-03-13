
/* 
    1- A- Definir una clase para representar triángulos. Un triángulo se caracteriza por el tamaño de sus 3 lados (double), 
          el color de relleno (String) y el color de línea (String). 
    El triángulo debe saber: 
    Devolver/modificar el valor de cada uno de sus atributos (métodos get# y set#) 
    Calcular el área y devolverla (método calcularArea)
    Calcular el perímetro y devolverlo (método calcularPerimetro)
    NOTA: Calcular el área con la fórmula  Área= √(s(s-a)(s-b)(s-c))   , donde a,b y c son los lados y s=(a+b+c)/2 .
        La función raíz cuadrada es Math.sqrt(#)

    B- Realizar un programa principal que instancie un triángulo, le cargue información leída desde teclado e informe en consola el perímetro y el área. 

 */
import java.util.Scanner;
public class ejercicio1
{
    public static void main(String[]args){
        //Declaracion variables
        Scanner in = new Scanner(System.in);
        Triangulo tri = new Triangulo();
        
        //Lectura de datos
        System.out.println("Ingrese el lado uno");
        tri.setmiladoUno(in.nextDouble());
        System.out.println("Ingrese el lado dos");
        tri.setmiladoDos(in.nextDouble());
        System.out.println("Ingrese el lado tres");
        tri.setmiladoTres(in.nextDouble());
        System.out.println("Ingrese el color de relleno");
        tri.setmicolorRelleno(in.next());
        System.out.println("Ingrese el color de la linea");
        tri.setmicolorLinea(in.next());
        
        System.out.println(tri.toString() + ", su perimetro es " + calcularPerimetro(tri) + ", su area es " + calcularArea(tri));      
        in.close();
    }
    
    public static double calcularPerimetro(Triangulo tri){
        double p = tri.getladoUno() + tri.getladoDos() + tri.getladoTres();
        return p;
    }
    
    public static double calcularArea(Triangulo tri){
        double s = (tri.getladoUno() + tri.getladoDos() + tri.getladoTres()) / 2;
        double a = Math.sqrt(s*(s-tri.getladoUno()) * (s-tri.getladoDos()) * (s-tri.getladoTres()));
        return a;
    }
}
