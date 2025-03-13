
public class Autor { 
    private int DNI;
    private String nombreApellido;
    
    public Autor(int DNI, String nombreApellido){
        this.setDNI(DNI);
        this.setnombreApellido(nombreApellido);
    }
    
    public Autor() {
        
    }
    
    public void setDNI(int DNI){
        this.DNI = DNI;
    }
    
    public void setnombreApellido(String nombreApellido){
        this.nombreApellido = nombreApellido;
    }
    
    public int getDNI(){
        return this.DNI;
    }
    
    public String getnombreApellido(){
        return this.nombreApellido;
    }
    
    public String toStringAutor(){
        String aux = "El dni de " +this.nombreApellido+" es "+this.DNI;
        return aux;
    }
}
