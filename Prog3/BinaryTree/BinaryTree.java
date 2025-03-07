
public class BinaryTree<T> {
    private T data;
	private BinaryTree<T> leftChild;   
	private BinaryTree<T> rightChild; 
	
	public BinaryTree() {
		super();
	}

	public BinaryTree(T data) {
		this.data = data;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}
	/**
	 * Preguntar antes de invocar si hasLeftChild()
	 * @return
	 */
	public BinaryTree<T> getLeftChild() {
		return this.leftChild;
	}
	/**
	 * Preguntar antes de invocar si hasRightChild()
	 * @return
	 */
	public BinaryTree<T> getRightChild() {
		return this.rightChild;
	}

	public void addLeftChild(BinaryTree<T> child) {
		this.leftChild = child;
	}

	public void addRightChild(BinaryTree<T> child) {
		this.rightChild = child;
	}

	public void removeLeftChild() {
		this.leftChild = null;
	}

	public void removeRightChild() {
		this.rightChild = null;
	}

	public boolean isEmpty(){
		return (this.isLeaf() && this.getData() == null);
	}

	public boolean isLeaf() {
		return (!this.hasLeftChild() && !this.hasRightChild());

	}
		
	public boolean hasLeftChild() {
		return this.leftChild!=null;
	}

	public boolean hasRightChild() {
		return this.rightChild!=null;
	}
	@Override
	public String toString() {
		return this.getData().toString();
	}

	public static int contarHojas(BinaryTree<Integer> a) {
        //Arbol vacio
        if (a == null) {
            return 0;
        }

        if (a.isLeaf()) {
            return 1;
        }

        int cant = 0;

        if (a.hasLeftChild()) {
            cant += contarHojas(a.leftChild);   
        }

        if (a.hasRightChild()) {
            cant += contarHojas(a.rightChild);   
        }

        return cant;
    }
		
    public BinaryTree<T> espejo(BinaryTree<T> a){ 	
        if (a == null) {
            return null;
        }
        
        if (a.isLeaf()) {
            return a;
        }

        BinaryTree<T> a2 = new BinaryTree<T>(a.getData());

        if (a.hasLeftChild()) {
            a2.addRightChild(a2.espejo(a.getLeftChild()));;
        }

        if (a.hasRightChild()) {
            a2.addLeftChild(a2.espejo(a.getRightChild()));
        }

        return a2;
    }

    public void porNiveles(BinaryTree<T> arbol) {

        if (isEmpty()) {
            System.out.println("El arbol esta vacio.");
            return;
        }

        Queue<BinaryTree<T>> cola = new Queue<>();
        cola.enqueue(arbol);

        while (!cola.isEmpty()) {
            int nivelActualSize = cola.size();

            for (int i = 0; i < nivelActualSize; i++) {
                BinaryTree<T> nodoActual = cola.dequeue();

                System.out.print(nodoActual.getData() + " ");

                if (nodoActual.hasLeftChild()) {
                    cola.enqueue(nodoActual.getLeftChild());
                }
                if (nodoActual.hasRightChild()) {
                    cola.enqueue(nodoActual.getRightChild());
                }
            }

            System.out.println();
        }
    }

    public void entreNiveles(BinaryTree<T> arbol,int n, int m) {
        if (isEmpty()) {
            System.out.println("El arbol esta vacio.");
            return;
        }
    
        Queue<BinaryTree<T>> cola = new Queue<>();
        cola.enqueue(arbol);
    
        int nivelActual = 0;
    
        while (!cola.isEmpty() && nivelActual <= m) {
            int nivelActualSize = cola.size();
    
            for (int i = 0; i < nivelActualSize; i++) {
                BinaryTree<T> nodoActual = cola.dequeue();
    
                if (nivelActual >= n && nivelActual <= m) {
                    System.out.print(nodoActual.getData() + " ");
                }

                if (nodoActual.hasLeftChild()) {
                    cola.enqueue(nodoActual.getLeftChild());
                }
                if (nodoActual.hasRightChild()) {
                    cola.enqueue(nodoActual.getRightChild());
                }
            }

            nivelActual++;

            if (nivelActual >= n && nivelActual <= m) {
                System.out.println();
            }
        }
    }
}