package entregable.comparadores;

import entregable.clases.Activo_Fiat;
import java.util.Comparator;

public class ComparadorCantidadActivosFiat implements Comparator<Activo_Fiat> {
    @Override
    public int compare(Activo_Fiat c1, Activo_Fiat c2) {
        return Double.compare(c1.getCantidad(), c2.getCantidad()); // Ordenar descendente
    }
}