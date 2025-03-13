public abstract class empleado {
    private String nombre;
    private int dni;
    private int edad;
    private double sueldo;
    
    public empleado(String nombre,int dni, int edad, double sueldo){
        this.setNombre(nombre);
        this.setDni(dni);
        this.setEdad(edad);
        this.setSueldo(sueldo);
    }
    
    public empleado(){
        
    }
    
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    
    public void setDni(int dni){
        this.dni = dni;
    }
    
    public void setEdad(int edad){
        this.edad = edad;
    }
    
    public void setSueldo(double sueldo){
        this.sueldo = sueldo;
    }
    
    public int getDni(){
        return this.dni;
    }
    
    public int getEdad(){
        return this.edad;
    }
    
    public String getNombre(){
        return this.nombre;
    }
    
    abstract double calcularSueldoACobrar();
    
    public String toString(){
        String aux = "El sueldo de " + this.getNombre() + " es " + calcularSueldoACobrar(); 
        return aux;
    }
}
