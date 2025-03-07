package Ej7.Ej7a;

import java.util.Stack;

public class Main {
    public static void main(String[] args) {
        Stack<Integer> pilaNumeros = new Stack<>();
        pilaNumeros.push(10);
        pilaNumeros.push(20);
        pilaNumeros.push(30);
        pilaNumeros.push(100);
        TestArrayList T = new TestArrayList(pilaNumeros);
        T.imprimir();
    }
}
