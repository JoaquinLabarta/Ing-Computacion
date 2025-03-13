package Practica3.Ej7;

import java.util.ArrayList;
import java.util.List;

import Practica3.GeneralTree;

public class Caminos {
    private GeneralTree<Integer> arbol = new GeneralTree<Integer>(null);

    public Caminos(GeneralTree<Integer> a){
        arbol = a;
    }

    public List<Integer> caminoAHojaMasLejana() {
        List<Integer> caminoMasLejano = new ArrayList<>();
        List<Integer> caminoActual = new ArrayList<>();
        encontrarCaminoMasLejano(arbol, caminoActual, caminoMasLejano);
        return caminoMasLejano;
    }

    private void encontrarCaminoMasLejano(GeneralTree<Integer> nodo, List<Integer> caminoActual, List<Integer> caminoMasLejano) {
        if (nodo == null || nodo.isEmpty()) return;

        caminoActual.add(nodo.getData());

        if (nodo.isLeaf()) {
            if (caminoActual.size() > caminoMasLejano.size()) {
                caminoMasLejano.clear(); 
                caminoMasLejano.addAll(caminoActual);
            }
        }

        for (GeneralTree<Integer> hijo : nodo.getChildren()) {
            encontrarCaminoMasLejano(hijo, caminoActual, caminoMasLejano);
        }

        caminoActual.remove(caminoActual.size() - 1);
    }
}
