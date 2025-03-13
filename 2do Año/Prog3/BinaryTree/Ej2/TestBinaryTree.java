package Practica2.Ej2;

import Practica2.BinaryTree;

public class TestBinaryTree {
    public static void main(String[] args) {
        BinaryTree<Integer> arbol = new BinaryTree<>(1);

        arbol.addLeftChild(new BinaryTree<Integer>(2));
        arbol.getLeftChild().addLeftChild(new BinaryTree<>(4));
        arbol.getLeftChild().addRightChild(new BinaryTree<>(6));
        arbol.addRightChild(new BinaryTree<Integer>(3));
        arbol.getRightChild().addLeftChild(new BinaryTree<Integer>(5));
        arbol.getRightChild().addRightChild(new BinaryTree<Integer>(7));
        arbol.porNiveles(arbol);
        System.out.println();
        arbol.entreNiveles(arbol, 0, 1);
        System.out.println();


        BinaryTree<Integer> a2 = new BinaryTree<>();
        a2 = a2.espejo(arbol);
        System.out.println();
        a2.porNiveles(a2);
    }
}
