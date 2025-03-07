/*Escriba una clase llamada TestArrayList cuyo método main recibe una secuencia de
números, los agrega a una lista de tipo ArrayList, y luego de haber agregado todos los
números a la lista, imprime el contenido de la misma iterando sobre cada elemento. */
package Ej7.Ej7a;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class TestArrayList{
    private List<Integer> listaNumeros = new ArrayList<>();

    public TestArrayList(Stack<Integer> pilaNumeros){
        agregarStack(pilaNumeros);
    }

    public void agregarStack(Stack<Integer> pilaNumeros){
        for (Integer num : pilaNumeros) {
            listaNumeros.add(num);
        }
    }

    public void imprimir(){
        System.out.println(listaNumeros.size());
        for (int j = 0; j < listaNumeros.size(); j++) {
            System.out.println("Posicion: "+j+" ,tiene el numero: "+listaNumeros.get(j));
        }
    }
}