package Ej7.Ej7h;

import java.util.ArrayList;
import java.util.LinkedList;

public class Main {
    public static void main(String[] args) {
        //----------Variables y carga----------
        ArrayList<Integer> lista = new ArrayList<>();
        LinkedList<Integer> lista2 = new LinkedList<>();

        for (int i = 0; i < 10; i++) {
            lista.add(i, i);
        }

        for (int j = 0; j < 10; j++) {
            lista2.add(j, j);
        }

        //----------Resultados----------
        System.out.println("ArrayList original: ");
        Methods.imprimirLista(lista);
        Methods.invertirArrayList(lista);
        System.out.println();
        System.out.println("ArrayList invertida: ");
        Methods.imprimirLista(lista);
        System.out.println();
        System.out.println("LinkedList: ");
        Methods.imprimirLista(lista2);
        System.out.println();
        System.out.println("Suma de la LinkedList: "+Methods.calcularSuma(lista2));

    }
}
