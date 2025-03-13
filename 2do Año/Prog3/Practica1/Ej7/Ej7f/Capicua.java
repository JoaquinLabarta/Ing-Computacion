/*Escriba un método que devuelva verdadero o falso si la secuencia almacenada en la
lista es o no capicúa:
public boolean esCapicua(ArrayList<Integer> lista)
Ejemplo:
● El método devuelve verdadero si la secuencia ingresada es: 2 5 2
● El método devuelve falso si la secuencia ingresada es: 4 5 6 3 4 */

package Ej7.Ej7f;
import java.util.ArrayList;

public class Capicua {
    public static boolean esCapicua(ArrayList<Integer> lista){
        int last = lista.size()-1;
        for (int i = 0; i < lista.size()/2; i++) {
            if (!(lista.get(i).equals(lista.get(last)))) {
                return false;
            }  
            last--;
        }
        return true;
    }
}
