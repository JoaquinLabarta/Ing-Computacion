package Ej7.Ej7f;

import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<Integer> l = new ArrayList<>();
        l.add(2);
        l.add(3);
        l.add(3);
        l.add(2);
   
        if (Capicua.esCapicua(l) == true) {
            System.out.println("Es capicua");
        } else System.out.println("No es capicua");
    }
}
