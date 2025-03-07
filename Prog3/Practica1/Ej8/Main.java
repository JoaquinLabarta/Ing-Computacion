package Ej8;

public class Main {
    public static void main(String[] args) {
        CircularQueue<Integer> cola = new CircularQueue<>();
        for (int i = 0; i < 10; i++) {
            cola.enqueue(i);
        }
        System.out.println(cola.toString());
        for (int i = 0; i < cola.size()-1; i++) {
            cola.shift();
        }
        System.out.println(cola.toString());
    }
}
