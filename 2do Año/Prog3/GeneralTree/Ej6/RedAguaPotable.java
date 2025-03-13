package Practica3.Ej6;
import Practica3.GeneralTree;

/*Se debe implementar una clase RedDeAguaPotable que contenga el método con la siguiente firma:
public double minimoCaudal(double caudal)
que calcule el caudal de cada nodo y determine cuál es el caudal mínimo que recibe una casa. Asuma
que la estructura de caños de la red está representada por una variable de instancia de la clase
RedAguaPotable y que es un GeneralTree.*/

public class RedAguaPotable {
    private GeneralTree<Double> arbol = new GeneralTree<Double>(null);

    public RedAguaPotable(GeneralTree<Double> a){
        arbol = a;
    }

    public double minimoCaudal(double caudal) {
        arbol.setData(caudal);
        return minimoCaudal(arbol);
    }

    private double minimoCaudal(GeneralTree<Double> arbol) {
        if (arbol.isEmpty()) {
            return Double.MAX_VALUE;
        }

        double min = arbol.getData();

        for (GeneralTree<Double> hijo : arbol.getChildren()) {
            double minHijo = minimoCaudal(hijo); 
            if (minHijo < min) { 
                min = minHijo;
            }
        }

        return min;
    }
}
