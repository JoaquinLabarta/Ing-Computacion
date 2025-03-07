public class entrenador extends empleado{
    private int torneos;
    private double sueldoent;
    
    public entrenador(int torneos, double sueldoent){
        this.setTorneos(torneos);
        this.setSueldo(sueldoent);
    }
    
    public entrenador (){
        
    }
    
    public void setTorneos(int torneos){
        this.torneos = torneos;
    }
    
    public void setSueldo(double sueldoent){
        this.sueldoent = sueldoent;
    }
    
    public int getTorneos(){
        return this.torneos;
    }
    
    public double calcularSueldoACobrar(){       
        if ((this.torneos >= 1) && (this.torneos <=4)){
            this.sueldoent += 5000;
        } else if ((this.torneos>4) && (this.torneos<=10)){
            this.sueldoent += 30000;
        } else {
            this.sueldoent += 50000;
        }
        return this.sueldoent;
    }
}