/*
 3- A- Modifique la clase Persona (del ejercicio 2 de la clase 2) para representar entrenadores de un club de fútbol. 
 Un entrenador se caracteriza por su nombre, sueldo básico y la cantidad de campeonatos ganados.
	* Defina métodos para obtener/modificar el valor de cada atributo.
	* Defina el método calcularSueldoACobrar que calcula y devuelve el sueldo a cobrar por el entrenador. 
        El sueldo se compone del sueldo básico, al cual se le adiciona un plus por campeonatos ganados 
        (5000$ si ha ganado entre 1 y 4 campeonatos; $30.000 si ha ganado entre 5 y 10 campeonatos; 50.000$ si ha ganado más de 10 campeonatos). 

    B- Realizar un programa principal que instancie un entrenador, cargándole datos leídos desde teclado. 
       Pruebe el correcto funcionamiento de cada método implementado.
 */
public class Persona {
    private String nombre;
    private int sueldo;
    private int cantcamp; 
    
    public Persona(String unNombre, int torneos){
        nombre = unNombre;
        cantcamp = torneos; 
        sueldo = setSueldo();
    }
    
    public Persona (){
        
    }
    
    public int setSueldo() {
        if ((cantcamp >= 1) && (cantcamp <=4)){
            sueldo = 5000;
        } else if ((cantcamp>4) && (cantcamp<=10)){
            sueldo = 30000;
        } else {
            sueldo = 50000;
        }
        return sueldo;
    }
    
    public String toString(){
        String aux; 
        aux = "El nombre  del dt es " + nombre + ", gano " + cantcamp + " y cobra $" + sueldo;
        return aux;
    }   
}
