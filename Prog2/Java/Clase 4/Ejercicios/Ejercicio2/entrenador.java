
/*2-A– Defina un constructor para la clase Entrenador (definida en la Act. 3 - Parte 1) que reciba los datos necesarios 
         (nombre, sueldo básico, cantidad de campeonatos ganados). Además defina un constructor nulo. 
   B- Realice un programa que instancie un entrenador mediante el primer constructor. 

 */
public class entrenador {
    private String nombre;
    private int sueldo;
    private int torneos; 
    
    public entrenador(String nombre, int torneos){
        nombre = nombre;
        this.torneos = torneos; 
        this.sueldo = setSueldo();
    }
    
    public entrenador (){
        
    }
    
    public int setSueldo() {
        if ((this.torneos >= 1) && (this.torneos <=4)){
            this.sueldo = 5000;
        } else if ((this.torneos>4) && (this.torneos<=10)){
            this.sueldo = 30000;
        } else {
            this.sueldo = 50000;
        }
        return sueldo;
    }
    
    public String toString(){
        String aux; 
        aux = "El nombre  del dt es " + this.nombre + ", gano " + this.torneos + " y cobra $" + this.sueldo;
        return aux;
    }   
}
