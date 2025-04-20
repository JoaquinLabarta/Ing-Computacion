package Ej5;

public class Parametros {
    private int maximo, minimo, suma;
    private float prom;

    public Parametros(){
        maximo = -1;
        minimo = 9999;
        suma = 0;
        prom = 0;
    }

    public void reiniciar(){
        maximo = -1;
        minimo = 9999;
        suma = 0;
        prom = 0;
    }

    public void setProm(float prom) {
        this.prom = prom;
    }

    public void setMaximo(int maximo) {
        this.maximo = maximo;
    }

    public void setMinimo(int minimo) {
        this.minimo = minimo;
    }

    public float getProm() {
        return prom;
    }

    public int getMaximo() {
        return maximo;
    }

    public int getMinimo() {
        return minimo;
    }

    public int getSuma() {
        return suma;
    }

    public void setSuma(int suma) {
        this.suma+=suma;
    }
}
