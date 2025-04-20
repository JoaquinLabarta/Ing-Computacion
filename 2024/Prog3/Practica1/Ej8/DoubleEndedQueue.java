package Ej8;

import java.util.ArrayList;
import java.util.List;

public class DoubleEndedQueue<T> extends Queue<T> {
    public DoubleEndedQueue(){
        super();
    }

    public void enqueueFirst(T dato){
        if (super.data.isEmpty()) {
            super.data.add(dato);
            return;
        }

        List<T> listaNueva= new ArrayList<>();
        listaNueva.add(dato);
        
    }
}
