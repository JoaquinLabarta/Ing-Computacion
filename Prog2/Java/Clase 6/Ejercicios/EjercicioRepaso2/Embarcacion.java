public class Embarcacion extends Vehiculo{
    private int codRey;
    private String Nombre;
    private String tipoEmbarcacion;
    private int Eslora;
    private int Peso;
    private int precioTotal;
    
    public Embarcacion(){
        
    }
    
    public Embarcacion(int año, Propietario propietario, int importeBasico,int codRey, String Nombre, String tipoEmbarcacion, int Eslora, int Peso, int precioTotal){
        super(año,propietario,importeBasico);
        this.setCodRey(codRey);
        this.setNombre(Nombre);
        this.setTipoEmbarcacion(tipoEmbarcacion);
        this.setEslora(Eslora);
        this.setPeso(Peso);
        this.setPrecioTotal(precioTotal);
    }
    
    public void setCodRey(int codRey){
        this.codRey = codRey;
    }
    
    public void setNombre(String Nombre){
        this.Nombre = Nombre;
    }
    
    public void setTipoEmbarcacion(String tipoEmbarcacion){
        this.tipoEmbarcacion = tipoEmbarcacion;
    }
    
    public void setEslora(int Eslora){
        this.Eslora = Eslora;
    }
    
    public void setPeso(int Peso){
        this.Peso = Peso;
    }
    
    public void setPrecioTotal(int precioTotal){
        this.precioTotal = precioTotal;
    }
    
    public int getCodRey(){
        return this.codRey;
    }
    
    public String getNombre(){
        return this.Nombre;
    }
    
    public String getTipoEmbarcacion(){
        return this.tipoEmbarcacion;
    }
    
    public int getEslora(){
        return this.Eslora;
    }
    
    public int getPeso(){
        return this.Peso;
    }
    
    public int getPrecioTotal(){
        return this.precioTotal;
    }
    
    public int calcularCosto(){
        int costoTotal;
        if(getPrecioTotal() < 6000){
            costoTotal = (4*getPrecioTotal())/100;
        } else if (getPrecioTotal() < 18000){
            costoTotal = (2*getPrecioTotal())/100;
        } else {
            costoTotal = (5*getPrecioTotal())/100;
        }
        return costoTotal;
    }
}