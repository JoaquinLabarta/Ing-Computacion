/*
 * 1-A– Defina constructores para la clase Triángulo (definida en la Act. 3 - Parte 1): el primer constructor debe recibir un valor para cada lado y
     para los colores de línea y relleno; el segundo constructor no debe poseer parámetros ni código (constructor nulo). 
   B- Realice un programa que instancie un triángulo mediante los distintos constructores.
*/

public class triangulo
{
    private double lado1;
    private double lado2;
    private double lado3;
    private String colorR;
    private String colorL;
    
    public triangulo (double lado1, double lado2, double lado3, String colorR, String colorL){
        this.setlado1(lado1);
        this.setlado2(lado2);
        this.setlado3(lado3); 
        this.setcolorR(colorR);
        this.setcolorL(colorL);
    }
    public triangulo()
    {
        
    }
    
    public double getlado1(){
        return this.lado1;
    }
    
    public double getlado2(){
        return this.lado2;
    }
    
    public double getlado3(){
        return this.lado3;
    }
    
    public String getcolorR(){
        return this.colorR;
    }
    
    public String getcolorL(){
        return this.colorL;
    }
    
    public void setlado1(double lado1){
        this.lado1 = lado1;
    }
    
    public void setlado2(double lado2){
        this.lado2= lado2;
    }
    
    public void setlado3(double lado3){
        this.lado3 = lado3;
    }
    
    public void setcolorR(String colorR){
        this.colorR = colorR;
    }
    
    public void setcolorL(String colorL){
        this.colorL = colorL;
    }
    
    public String toString(){
        String aux;
        aux = "El lado 1 del triangulo mide: " +this.getlado1()+ " ,el lado 2 del triangulo mide: " +this.getlado2()+ ", el lado 3 del triangulo mide: " 
        +this.getlado3()+ " ,el color de relleno del triangulo es: " +this.getcolorR()+ " ,el color de linea del triangulo es: " +this.getcolorL(); 
        return aux;
    }
    
}
