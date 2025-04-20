package Ej8;

public class CircularQueue<T> extends Queue<T> {
    public CircularQueue(){
        super();
    }

    public T shift(){
        if (super.isEmpty()) {
            return null;
        }

        T elemento = super.data.remove(0);
        super.data.add(elemento);
        return elemento;
    }
}
