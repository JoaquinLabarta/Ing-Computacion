package Practica3.Ej4;

import Practica2.Queue;
import Practica3.GeneralTree;

public class AnalizadorArbol {
    public int devolverMaximoPromedio(GeneralTree<Integer> arbol) {
    if (arbol.isEmpty()) {
        return -1;
    }
    
    Queue<GeneralTree<Integer>> cola = new Queue<>();
    cola.enqueue(arbol); 

    int maxPromedio = -1; 
    
    while (!cola.isEmpty()) {
        int size = cola.size();
        int suma = 0;
        
        for (int i = 0; i < size; i++) {
            GeneralTree<Integer> nodo = cola.dequeue(); 
            suma += nodo.getData();

            for (GeneralTree<Integer> hijo : nodo.getChildren()) {
                cola.enqueue(hijo);
            }
        }
        
        int promedio = suma / size;

        if (promedio > maxPromedio) {
            maxPromedio = promedio;
        }
    }
    
    return maxPromedio;
}
}
