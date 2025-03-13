
public class balanza{
    private double montoTotal;
    private int prodTotal; 
    
    //Getters y Setters
    
    public void iniciarCompra(){
        montoTotal = 0;
        prodTotal = 0;        
    }
    
    public void registrarProducto(double peso, double prec){
        montoTotal += peso * prec;
        prodTotal ++;
    }
        
    public String devolverResumen(){
        String aux = "Total a pagar " + montoTotal + " por la compra de " + prodTotal + " productos";
        return aux;
    }
}