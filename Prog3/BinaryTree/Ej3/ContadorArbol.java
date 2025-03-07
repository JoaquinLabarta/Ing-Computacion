package Practica2.Ej3;

import Practica2.BinaryTree;
import Practica2.Queue;

public class ContadorArbol{

    public static Queue<Integer> numerosParesPreOrden(BinaryTree<Integer> arbol) {
        if (arbol == null) {
            return null;
        }
    
        Queue<Integer> colaPares = new Queue<>();
        Queue<BinaryTree<Integer>> colaArbol = new Queue<>();
        colaArbol.enqueue(arbol);
    
        while (!colaArbol.isEmpty()) {
            BinaryTree<Integer> nodoActual = colaArbol.dequeue();
    
            if (nodoActual.getData() % 2 == 0) {
                colaPares.enqueue(nodoActual.getData());
            }
    
            if (nodoActual.hasLeftChild()) {
                colaArbol.enqueue(nodoActual.getLeftChild());
            }
            if (nodoActual.hasRightChild()) {
                colaArbol.enqueue(nodoActual.getRightChild());
            }
        }
    
        return colaPares;
    }

    public static void numerosParesInOrden(BinaryTree<Integer> nodo, Queue<Integer> colaPares) {
        if (nodo == null) {
            return;
        }

        if (nodo.hasLeftChild()) {
            numerosParesInOrden(nodo.getLeftChild(), colaPares);   
        }

        if (nodo.getData() % 2 == 0) {
            colaPares.enqueue(nodo.getData());
        }

        if (nodo.hasRightChild()) {
            numerosParesInOrden(nodo.getRightChild(), colaPares);   
        }
    }

    public static void numerosParesPostOrden(BinaryTree<Integer> nodo, Queue<Integer> colaPares) {
        if (nodo == null) {
            return;
        }

        if (nodo.hasLeftChild()) {
            numerosParesPostOrden(nodo.getLeftChild(), colaPares);   
        }

        if (nodo.hasRightChild()) {
            numerosParesPostOrden(nodo.getRightChild(), colaPares);   
        }

        if (nodo.getData() % 2 == 0) {
            colaPares.enqueue(nodo.getData());
        }
    }

    
}