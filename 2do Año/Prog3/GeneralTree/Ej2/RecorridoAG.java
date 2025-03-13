package Practica3.Ej2;

import java.util.LinkedList;
import java.util.List;

import Ej8.Queue;
import Practica3.GeneralTree;

public class RecorridoAG {
    public List<Integer> numerosImparesMayoresQuePreOrden (GeneralTree <Integer> a, Integer n){
        List<Integer> lista = new LinkedList<Integer>();
        this.numerosImparesMayoresQuePreOrden(a,n,lista);
        return lista;
    }
    private void numerosImparesMayoresQuePreOrden(GeneralTree<Integer> a, Integer n, List<Integer> lista){
        if (a!=null) {
            if ((a.getData() % 2 != 0) && (a.getData()>n)) {
                lista.add(a.getData());
            }
            if (a.hasChildren()) {
                for (GeneralTree<Integer> child : a.getChildren()) {
                    this.numerosImparesMayoresQuePreOrden(child, n, lista);
                }
            }
        }
    }
    
    public List<Integer> numerosImparesMayoresQuePostOrden (GeneralTree <Integer> a, Integer n){
        List<Integer> lista = new LinkedList<Integer>();
        this.numerosImparesMayoresQuePostOrden(a,n,lista);
        return lista;
    }

    private void numerosImparesMayoresQuePostOrden(GeneralTree<Integer> a, Integer n, List<Integer> lista){
        if (a!=null) {
            if (a.hasChildren()) {
                for (GeneralTree<Integer> child : a.getChildren()) {
                    this.numerosImparesMayoresQuePostOrden(child, n, lista);
                }
            }
            if ((a.getData() % 2 != 0) && (a.getData()>n)) {
                lista.add(a.getData());
            }
        }
    }

    public List<Integer> numerosImparesMayoresQueInOrden (GeneralTree <Integer> a, Integer n){
        List<Integer> lista = new LinkedList<Integer>();
        this.numerosImparesMayoresQueInOrden(a,n,lista);
        return lista;
    }

    private void numerosImparesMayoresQueInOrden(GeneralTree<Integer> a, Integer n, List<Integer> lista){
        if (a!=null) {
            if (a.hasChildren()) {
                for (GeneralTree<Integer> child : a.getChildren()) {
                    this.numerosImparesMayoresQueInOrden(child, n, lista);
                }
            }

            if ((a.getData() % 2 != 0) && (a.getData()>n)) {
                lista.add(a.getData());
            }
        }
    }

    public List<Integer> numerosImparesMayoresQuePorNiveles(GeneralTree<Integer> a, Integer n) {
        List<Integer> lista = new LinkedList<>();
        if (a == null) {    
            return lista;
        }

        Queue<GeneralTree<Integer>> cola = new Queue<>();
        cola.enqueue(a);

        while (!cola.isEmpty()) {
            int size = cola.size();
            for (int i = 0; i < size; i++) {
                GeneralTree<Integer> nodoActual = cola.dequeue();

                if (nodoActual.hasChildren()) {
                    for (GeneralTree<Integer> child : nodoActual.getChildren()) {
                        cola.enqueue(child);
                    }
                }
                
                if ((nodoActual.getData() % 2 != 0) && (nodoActual.getData() > n)) {
                    lista.add(nodoActual.getData());
                }
            }
        }
        return lista;
    }
}