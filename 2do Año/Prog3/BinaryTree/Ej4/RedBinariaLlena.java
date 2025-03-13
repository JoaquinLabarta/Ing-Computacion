package Practica2.Ej4;

import Practica2.BinaryTree;

public class RedBinariaLlena {
    public static int retardoReenvio(BinaryTree<Integer> ab) {
		if(ab!=null&&!ab.isEmpty()) {
			/*Utilizo recorrido postOrden para llegar a las hojas y a partir
			de ahí subo enviando el dato del nodo más el su hijo con mayor valor
			*/
			int izq = retardoReenvio(ab.getLeftChild());
			int der = retardoReenvio(ab.getRightChild());
			return (izq>der?(ab.getData()+izq):(ab.getData()+der));
		}
		return 0;
	}
}
