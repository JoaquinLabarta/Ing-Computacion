package Ej1;
public class Funciones {
    public static void caminoFor(int a, int b){
        for (int i = a; i <= b; i++) {
            System.out.println("Numero " +  i);
        }
    }

    public static void caminoWhile(int a, int b){
        do {
            System.out.println("Numero " + a);
            a++;
        } while (a<=b);
    }

    public static void sinStruct(int a, int b){
        if (a<=b) {
            System.out.println("Numero " + a);
            sinStruct(a+1,b);
        }
    }
}
