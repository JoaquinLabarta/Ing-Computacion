public abstract class Vehiculo{
   private int año;
   private int importeBasico;
   private Propietario propietario;
   
   public Vehiculo(){
       
   }
   
   public Vehiculo(int año, Propietario propietario, int importeBasico){
       this.setAño(año);
       this.setImporteBasico(importeBasico);
       this.setPropietario(propietario);
   }
   
    public void setPropietario(Propietario propietario){
        this.propietario=propietario;
    }
    
    public void setAño(int año){
        this.año=año;
    }
    
    public void setImporteBasico(int importeBasico){
        this.importeBasico=importeBasico;
    }
    
    public int getAño(){
        return año;
    }
    
    public int getImporteBasico(){
        return importeBasico;
    }
    
    public Propietario getPropietario(){
        return propietario;
    }   
    
    abstract int calcularCosto();
}
