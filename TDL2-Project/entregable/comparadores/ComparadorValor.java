package entregable.comparadores;

import entregable.clases.Moneda;
import java.util.Comparator;

public class ComparadorValor implements Comparator<Moneda> {
    @Override
    public int compare(Moneda m1, Moneda m2) {
        return Double.compare(m1.getPrecioActual(), m2.getPrecioActual());
    }
}