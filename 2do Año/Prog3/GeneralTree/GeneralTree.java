package Practica3;

import java.util.List;

import Ej8.Queue;

import java.util.LinkedList;


public class GeneralTree<T> {

	private T data;
	private List<GeneralTree<T>> children = new LinkedList<GeneralTree<T>>();

	public GeneralTree(T data) {
		this.data = data;
	}

	public GeneralTree(T data, List<GeneralTree<T>> children) {
		this(data);
		this.children = children;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public void setChildren(List<GeneralTree<T>> children) {
		if (children != null)
			this.children = children;
	}

	public List<GeneralTree<T>> getChildren() {
		return this.children;
	}

	public void addChild(GeneralTree<T> child) {
		this.getChildren().add(child);
	}

	public boolean isLeaf() {
		return !this.hasChildren();
	}

	public boolean hasChildren() {
		return children != null && !children.isEmpty();
	}

	public boolean isEmpty() {
		return this.data == null && !hasChildren();
	}

	public void removeChild(GeneralTree<T> child) {
		if (this.hasChildren()) {
			List<GeneralTree<T>> children = this.getChildren();
			if (children.contains(child))
				children.remove(child);
		}
	}

	/*
	b) public int nivel(T dato) devuelve la profundidad o nivel del dato en el árbol. El nivel de un nodo
	es la longitud del único camino de la raíz al nodo.
	c) public int ancho(): int la amplitud (ancho) de un árbol se define como la cantidad de nodos que
	se encuentran en el nivel que posee la mayor cantidad de nodos.
	 */

	 public int altura() {
		int maxAlturaHijos = 0;
		for (GeneralTree<T> hijo : this.getChildren()) {
			int alturaHijo = hijo.altura();
			if (alturaHijo > maxAlturaHijos) {
				maxAlturaHijos = alturaHijo;
			}
		}
		return maxAlturaHijos + 1;
	}
	
	public int nivel(T dato) {
		if(this!=null) {
			if(this.getData()== dato) return 0;
			int aux;
			for(GeneralTree<T> nodo : this.getChildren()) {
				aux=nodo.nivel(dato);
				if(aux>=0)return aux+1;
			}
		}
		return -1;
	}
	
	public int ancho() {
		if(this!=null) {
			if(this.hasChildren()) {
				int aux;
				int max_ancho = this.getChildren().size();
				for(GeneralTree<T> nodo : this.getChildren()) {
					aux=nodo.ancho();
					if(aux>max_ancho) max_ancho=aux;
				}
				return max_ancho;
			}
		}
		return (this.isEmpty()?0:1);
	}

    public List<T> porNiveles(GeneralTree<T> tree) {
        List<T> result = new LinkedList<T>();
        GeneralTree<T> tree_aux;
        Queue<GeneralTree<T>> queue = new Queue<GeneralTree<T>>();
         queue.enqueue(tree);
         while (!queue.isEmpty()) {
         tree_aux = queue.dequeue();
         result.add(tree_aux.getData());
         List<GeneralTree<T>> children = tree_aux.getChildren();
         for (GeneralTree<T> child: children) {
         queue.enqueue(child);
         }
         }
         return result;
    }

	/*Se dice que un nodo n es ancestro de un nodo m si existe un camino desde n a m. Implemente un
	método en la clase GeneralTree con la siguiente firma:
	public boolean esAncestro(T a, T b): devuelve true si el valor “a” es ancestro del valor “b” */

	public boolean esAncestro(GeneralTree<T> a, GeneralTree<T> b){ 
		if (a.isEmpty() || b.isEmpty() || a.isLeaf() || a.equals(b)) {
			return false;
		}
		Queue<GeneralTree<T>> cola = new Queue<>();
		GeneralTree<T> aux = a;
		cola.enqueue(aux);
		
		while (!cola.isEmpty()) {
			aux = cola.dequeue();
			for (GeneralTree<T> child : aux.getChildren()) {
				cola.enqueue(child);
				if (child.equals(b)) {
					return true; //encontre camino
				}
			}		
		}
		return false;
	}
}

