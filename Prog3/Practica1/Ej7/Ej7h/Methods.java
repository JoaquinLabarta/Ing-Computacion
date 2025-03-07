package Ej7.Ej7h;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class Methods {

    public static void imprimirLista(List<Integer> l){
        for (Integer num : l) {
            System.out.print(num+", ");
        }
    }

    public static int calcularSuma(LinkedList<Integer> lista) {
        return calcularSumaRecursiva(lista, 0);
    }

    private static int calcularSumaRecursiva(LinkedList<Integer> lista, int suma) {
        if (lista.isEmpty()) {
            return suma;
        }

        int primerElemento = lista.removeFirst();
        suma += primerElemento;
        return calcularSumaRecursiva(lista, suma);
    }
    
    public static void invertirArrayList(ArrayList<Integer> lista){
        if (lista.size()<=1) {
            return;
        }

        int num = lista.remove(0);
        invertirArrayList(lista);
        lista.add(num);
    }
}
