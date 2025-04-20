package Ej2;

public class vClass {
    public static void crearV(int n){
        int v[] = new int[n];
        for (int i=0; i < v.length; i++) {
            v[i] = n*(i+1);
        }
        recorrerVector(v);
    }

    private static void recorrerVector(int[] v){
        for (int num : v) {
            System.out.println("Numero: " + num);
        }
    }
}
