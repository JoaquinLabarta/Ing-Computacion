
public class Libro extends Ejemplar{
    private String titulo;
    private int cantCap;
    private boolean bolsillo;
    
    public Libro(String ID, int cantPag, String resumen,Autor autor, boolean publico, int año, String titulo, int cantCap, boolean bolsillo){
        super(ID,cantPag,resumen,autor,publico,año);
        this.setBolsillo(bolsillo);
        this.setTitulo(titulo);
        this.setcantCap(cantCap);
    }
    
    public Libro(String ID, int cantPag, String resumen,Autor autor,boolean publico, String titulo, int cantCap, boolean bolsillo){
        super(ID,cantPag,resumen,autor,publico);
        this.setBolsillo(bolsillo);
        this.setTitulo(titulo);
        this.setcantCap(cantCap);
    }
    
    public Libro(){
        
    }
    
    public void setTitulo(String titulo){
        if(super.getPublico() && this.bolsillo){
            this.titulo = titulo + " -- De Bolsillo";
        } else {
            this.titulo = titulo;   
        }
    }
    
    public void setcantCap(int cantCap){
        this.cantCap = cantCap;
    }
    
    public void setBolsillo(boolean bolsillo){
        this.bolsillo = bolsillo;
    }
    
    public String getTitulo(){
        return this.titulo;
    }
    
    public int getcantCap(){
        return this.cantCap;
    }
    
    public boolean getBolsillo(){
        return this.bolsillo;
    }
    
    public String informe(){
        String aux = "El libro es: " + getTitulo() + " del autor: "+ super.getAutor() + " con ID: " + super.getID(); 
        return aux;
    }
}
