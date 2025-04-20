package Practica2.Ej5;
import Practica2.*;

public class ProfundidadDeArbolBinario {
    private BinaryTree<Integer> arbol;

    public ProfundidadDeArbolBinario(BinaryTree<Integer> arbol) {
        this.arbol = arbol;
    }

    public int sumaElementosProfundidad(int p) {
        if (arbol == null || p < 0) {
            return 0;
        }
        return sumaElementosProfundidad(arbol, p, 0);
    }

    private int sumaElementosProfundidad(BinaryTree<Integer> nodo, int p, int profundidadActual) {
        if (nodo == null) {
            return 0;
        }
        if (profundidadActual == p) {
            return nodo.getData();
        }
        return sumaElementosProfundidad(nodo.getLeftChild(), p, profundidadActual + 1)
                + sumaElementosProfundidad(nodo.getRightChild(), p, profundidadActual + 1);
    }
}