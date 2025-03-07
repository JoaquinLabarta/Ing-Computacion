package Practica2.Ej6;

import Practica2.BinaryTree;

public class Test{
    public static void main(String[] args) {
        BinaryTree<Integer> arbol = new BinaryTree<>(5);

        // Nivel 1
        arbol.addLeftChild(new BinaryTree<>(10));
        arbol.addRightChild(new BinaryTree<>(2));

        // Nivel 2
        arbol.getLeftChild().addLeftChild(new BinaryTree<>(13));
        arbol.getLeftChild().addRightChild(new BinaryTree<>(4));
        arbol.getRightChild().addLeftChild(new BinaryTree<>(100));


        arbol.porNiveles(arbol);

        Transformacion ab = new Transformacion(arbol);
        arbol = ab.suma();
        arbol.porNiveles(arbol);
    }
}
