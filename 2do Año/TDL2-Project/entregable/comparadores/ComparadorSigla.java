package entregable.comparadores;

import entregable.clases.Moneda;
import java.util.Comparator;

public class ComparadorSigla implements Comparator<Moneda> {
    @Override
    public int compare(Moneda m1, Moneda m2) {
        return m1.getSigla().compareTo(m2.getSigla());
    }
}