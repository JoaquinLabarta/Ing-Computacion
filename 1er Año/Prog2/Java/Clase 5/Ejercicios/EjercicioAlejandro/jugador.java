
public class jugador extends empleado{
    private int part;
    private int goles;
    private double sueldojug;
    
    public jugador(int part, int goles, double sueldojug){
        this.setPart(part);
        this.setGoles(goles);
        this.setSueldo(sueldojug);
    }
    
    public jugador(){
        
    }
    
    public void setPart(int part){
        this.part = part;
    }
    
    public void setGoles(int goles){
        this.goles = goles;
    }
    
    public void setSueldo(double sueldojug){
        this.sueldojug = sueldojug;
    }
    
    public int getPart(){
        return this.part;
    }
    
    public int getGoles(){
        return this.goles;
    }
    
    public double calcularSueldoACobrar(){    
        if((double)this.goles/this.part > 0.50){
            this.sueldojug *= 2;
        }
        return this.sueldojug;
    }
}
