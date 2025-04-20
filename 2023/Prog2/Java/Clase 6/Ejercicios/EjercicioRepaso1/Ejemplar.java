import java.util.Scanner;
public abstract class Ejemplar {
    private String ID;
    private int cantPag;
    private String resumen;
    private int año = 0;
    private Autor autor;
    private boolean publico;
    
    public Ejemplar(String ID, int cantPag, String resumen, Autor autor, boolean publico, int año){
        this.setID(ID);
        this.setcantPag(cantPag);
        this.setresumen(resumen);
        this.setAutor(autor);
        this.setPublico(publico);
        this.setAño(año);
    }
    
    public Ejemplar(String ID, int cantPag, String resumen, Autor autor, boolean publico){
        this.setID(ID);
        this.setcantPag(cantPag);
        this.setresumen(resumen);
        this.setAutor(autor);
        this.setPublico(publico);
    }
    
    public Ejemplar() {
        
    }
    
    public void setID(String ID){
        this.ID = ID;
    }
    
    public void setcantPag(int cantPag){
        this.cantPag = cantPag;
    }
    
    public void setresumen(String resumen){
        this.resumen = resumen;
    }
    
    public void setAño(int año){
        this.año = año;      
    }
        
    public void setAutor(Autor autor){
        this.autor = autor;
    }
    
    public void setPublico(boolean publico){
        Scanner in = new Scanner(System.in);
        this.publico = publico;
        in.close();
    }
    
    public String getID(){
        return this.ID;
    }
    
    public int getcantPag(){
        return this.cantPag;
    }
    
    public String getResumen(){
        return this.resumen;
    }
    
    public int getAño(){
        return this.año;
    }
    
    public String getAutor(){
        return this.autor.getnombreApellido();
    }
    
    public boolean getPublico(){
        return this.publico;
    }
    
    abstract String informe();
}
