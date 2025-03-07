
public class Micros
{
    private String patente;
    private String horario;
    private String destino;
    
    //Constructor con diml = 0
    public Micros(String patente, String horario, String destino)
    {
        this.setPatente(patente);
        this.setHorario(horario);
        this.setDestino(destino);
    }
        
    //Constructor vacio
    public Micros(){
        
    }
    
    //getters
    public void setPatente (String patente){
        this.patente = patente;
    }
    
    public void setHorario (String horario){
        this.horario = horario;
    }
    
    public void setDestino (String destino){
        this.destino = destino;
    }
    
    //setters
    public String getPatente(){
        return this.patente;
    }
    
    public String getHorario(){
        return this.horario;
    }
    
    public String getDestino(){
        return this.destino;
    }
}
