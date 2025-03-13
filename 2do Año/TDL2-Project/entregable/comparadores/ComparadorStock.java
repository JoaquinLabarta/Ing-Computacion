package entregable.comparadores;

import entregable.clases.Criptomoneda;
import java.util.Comparator;

public class ComparadorStock implements Comparator<Criptomoneda> {
    @Override
    public int compare(Criptomoneda c1, Criptomoneda c2) {
        return Double.compare(c1.getStock(), c2.getStock()); // Ordenar descendente
    }
}
