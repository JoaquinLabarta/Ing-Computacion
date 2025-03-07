public class Automotor extends Vehiculo{
    private String patente;
    private int importeAño;
    private String descripcion;
    
    public Automotor(int año, Propietario propietario, int importeBasico,String patente, int importeAño, String descripcion){
        super(año,propietario,importeBasico);
        this.setPatente(patente);
        this.setImporteAño(importeAño);
        this.setDescripcion(descripcion);
    }
    
    public Automotor(){
        
    }
    
    public void setPatente(String patente){
        this.patente = patente;
    }
    
    public void setImporteAño(int importeAño){
        this.importeAño = importeAño;
    }
    
    public void setDescripcion(String descripcion){
        this.descripcion = descripcion;
    }
    
    public String getPatente(){
        return this.patente;
    }
    
    public int getImporteAño(){
        return this.importeAño;
    }
    
    public String getDescripcion(){
        return this.descripcion;
    }
    
    public int calcularCosto(){
        int costoTotal = (getImporteBasico() + getImporteAño());
        return costoTotal;
    }
}