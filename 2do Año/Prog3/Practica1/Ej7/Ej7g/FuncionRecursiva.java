package Ej7.Ej7g;

import java.util.ArrayList;
import java.util.List;

public class FuncionRecursiva {
    public static List<Integer> calcularSucesion(int n) {
        List<Integer> lista = new ArrayList<>();
        lista.add(n);
        
        if (n == 1) {
            return lista;
        }
        
        if (n % 2 == 0) {
            lista.addAll(calcularSucesion(n / 2));
        } else {
            lista.addAll(calcularSucesion((3 * n) + 1)); 
        }
        
        return lista;
    }
}
