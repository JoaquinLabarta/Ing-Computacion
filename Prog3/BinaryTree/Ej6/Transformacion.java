/*Cree una clase Java llamada Transformacion que tenga como variable de instancia un árbol
binario de números enteros y un método de instancia suma (): BinaryTree<Integer> el cuál
devuelve el árbol en el que se reemplazó el valor de cada nodo por la suma de todos los
elementos presentes en su subárbol izquierdo y derecho. Asuma que los valores de los subárboles
vacíos son ceros. */
package Practica2.Ej6;

import Practica2.BinaryTree;

public class Transformacion {
    private BinaryTree<Integer> arbol;

    public Transformacion(BinaryTree<Integer> ab){
        this.arbol = ab;
    }

    public BinaryTree<Integer> suma(){
		BinaryTree<Integer> aux = new BinaryTree<Integer>();
		sumaP(this.arbol,aux);
		return aux;
	}
	private int sumaP(BinaryTree<Integer> ab,BinaryTree<Integer> copia){
		if(ab!=null) {
			BinaryTree<Integer> aux_ab= new BinaryTree<Integer>();
			copia.addLeftChild(aux_ab); //Creo un arbol de la misma forma a medida que recorro el otro
			int a = sumaP(ab.getLeftChild(),copia.getLeftChild());//Guardo la suma de mi hijo izq junto con todo su hijos
			aux_ab= new BinaryTree<Integer>();
			copia.addRightChild(aux_ab);
			int b = sumaP(ab.getRightChild(),copia.getRightChild());//Guardo la suma de mi hijo der junto con todo su hijos
			copia.setData(a+b);//Seteo el valor de la suma de mis hijos en mi arbol copia
			return ab.getData()+a+b;//Retorno la suma del nodo más sus hijos al padre
		}
		return 0;
	}
}
