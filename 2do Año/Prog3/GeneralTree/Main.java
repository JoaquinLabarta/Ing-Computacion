package Practica3;

import java.util.LinkedList;
import java.util.List;

import Practica3.Ej4.AnalizadorArbol;

public class Main {
    public static void main(String[] args) {
        List<GeneralTree<Integer>> children2 = new LinkedList<GeneralTree<Integer>>();
        children2.add(new GeneralTree<Integer>(2));
        children2.add(new GeneralTree<Integer>(26));
        children2.add(new GeneralTree<Integer>(14));
        children2.add(new GeneralTree<Integer>(19));
        GeneralTree<Integer> a2 = new GeneralTree<Integer>(21, children2);

        List<GeneralTree<Integer>> children3 = new LinkedList<GeneralTree<Integer>>();
        children3.add(new GeneralTree<Integer>(1));
        GeneralTree<Integer> a3 = new GeneralTree<Integer>(23, children3);

        List<GeneralTree<Integer>> children4 = new LinkedList<GeneralTree<Integer>>();
        GeneralTree<Integer> a4 = new GeneralTree<Integer>(52, children4);

        List<GeneralTree<Integer>> childen = new LinkedList<GeneralTree<Integer>>();
        childen.add(a2);childen.add(a3);childen.add(a4);

        GeneralTree<Integer> a = new GeneralTree<Integer>(13, childen);
        System.out.println("Lista: " + a.porNiveles(a));

        AnalizadorArbol an = new AnalizadorArbol();
        System.out.println("MaxTardanza: "+ an.devolverMaximoPromedio(a));
    }
}