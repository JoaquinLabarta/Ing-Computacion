/*Defina una clase Java denominada ContadorArbol cuya función principal es proveer métodos de
validación sobre árboles binarios de enteros. Para ello la clase tiene como variable de instancia un
BinaryTree<Integer>. Implemente en dicha clase un método denominado numerosPares() que
devuelve en una estructura adecuada (sin ningún criterio de orden) todos los elementos pares del
árbol (divisibles por 2).
a) Implemente el método realizando un recorrido InOrden.
b) Implemente el método realizando un recorrido PostOrden. */

package Practica2.Ej3;

import Practica2.BinaryTree;
import Practica2.Queue;

public class Test {
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
        
        Queue<Integer> cola = new Queue<>();
        ContadorArbol.numerosParesPostOrden(arbol,cola);
        System.out.println(cola.toString());
    }
}
