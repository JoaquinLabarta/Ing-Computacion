/*
 * Un triángulo se caracteriza por el tamaño de sus 3 lados (double), el color de relleno (String) y el color de línea (String). 
 */
public class Triangulo
{
    //Declaracion variables
    private double miladoUno;
    private double miladoDos;
    private double miladoTres; 
    private String micolorRelleno;
    private String micolorLinea;
    
    //Metodo por si viene con datos
    public Triangulo(double ladoUno, double ladoDos, double ladoTres, String colorRelleno, String colorLinea){
        //Inicializo variables locales
        miladoUno = ladoUno;
        miladoDos = ladoDos;
        miladoTres = ladoTres;
        micolorRelleno = colorRelleno;
        micolorLinea = colorLinea;
    }
    
    //Metodo por si viene vacio
    public Triangulo()
    {  
        
    }
    
    //Getters y Setters
    public double getladoUno() {
        return miladoUno;
    }

    public double getladoDos() {
        return miladoDos;
    }
    
    public double getladoTres() {
        return miladoTres;
    }
    
    public String getcolorRelleno() {
        return micolorRelleno;
    }
    
    public String getcolorLinea() {
        return micolorLinea;
    }
    
    public void setmiladoUno(double ladoUno) {
        miladoUno = ladoUno;
    }

    public void setmiladoDos(double ladoDos) {
        miladoDos = ladoDos;
    }
    
    public void setmiladoTres(double ladoTres) {
        miladoTres = ladoTres;
    }
    
    public void setmicolorRelleno(String colorRelleno) {
        micolorRelleno = colorRelleno;
    }
    
    public void setmicolorLinea(String colorLinea) {
        micolorLinea = colorLinea;
    }
    
    public String toString(){
        String aux = "El lado uno mide " + miladoUno + ", el lado dos mide " + miladoDos + ", el lado tres mide " + miladoTres +
        ", el color de relleno es " + micolorRelleno + ", y el color de linea es " + micolorLinea ;
        return aux;
    }
}
