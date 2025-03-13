package Ej7.Ej7g;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Integer> lista = FuncionRecursiva.calcularSucesion(15);
        for (Integer integer : lista) {
            System.out.print(integer+", ");
        }
    }
}
