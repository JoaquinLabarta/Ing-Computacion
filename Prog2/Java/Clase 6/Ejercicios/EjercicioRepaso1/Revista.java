public class Revista extends Ejemplar{
    private String nombre;
    private int nroVol;
    private int cantArt;
    
    public Revista(String ID, int cantPag, String resumen, Autor autor, boolean publico, int año, String nombre, int nroVol, int cantArt){
        super(ID,cantPag,resumen,autor,publico,año);
        this.setNombre(nombre);
        this.setnroVol(nroVol);
        this.setcantArt(cantArt);
    }
    
    public Revista(String ID, int cantPag, String resumen, Autor autor, boolean publico, String nombre, int nroVol, int cantArt){
        super(ID,cantPag,resumen,autor,publico);
        this.setNombre(nombre);
        this.setnroVol(nroVol);
        this.setcantArt(cantArt);
    }
    
    public Revista(){
        
    }
    
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    
    public void setnroVol(int nroVol){
        this.nroVol = nroVol;
    }
    
    public void setcantArt(int cantArt){
        this.cantArt = cantArt;
    }
    
    public String getNombre(){
        return this.nombre;
    }
    
    public int getnroVol(){
        return this.nroVol;
    }
    
    public int getcantArt(){
        return this.cantArt;
    }
    
    public String informe(){
        String aux = "La revista es: " + getNombre() + " y su numero de volumen es: " + getnroVol() ; 
        return aux;
    }
}
