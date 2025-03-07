package Ej9;

import java.util.Stack;

public class TestBalanceo {

    public static boolean esBalanceado(String palabra) {
        Stack<Character> pila = new Stack<>();

        // Iterar sobre cada carácter en la palabra
        for (char c : palabra.toCharArray()) {
            // Si el carácter es un paréntesis de apertura, agrégalo a la pila
            if (c == '(' || c == '[' || c == '{') {
                pila.push(c);
            }
            // Si el carácter es un paréntesis de cierre
            else if (c == ')' || c == ']' || c == '}') {
                // Si la pila está vacía, significa que hay un paréntesis de cierre sin su correspondiente de apertura
                if (pila.isEmpty()) {
                    return false;
                }
                // Obtener el último paréntesis de apertura desde la pila
                char apertura = pila.pop();
                // Verificar si el paréntesis de cierre coincide con el de apertura
                if ((c == ')' && apertura != '(') || (c == ']' && apertura != '[') || (c == '}' && apertura != '{')) {
                    return false;
                }
            }
        }
        // Al final, si la pila está vacía, significa que todos los paréntesis tienen su par de apertura correspondiente
        return pila.isEmpty();
    }
}