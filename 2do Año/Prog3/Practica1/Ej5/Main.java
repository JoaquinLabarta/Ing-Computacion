package Ej5;

import java.util.Scanner;

public class Main {
    public static void main (String[] args){
        Scanner in = new Scanner(System.in);
        //---------------------Carga del vector---------------------
        int[] v = new int[3];
        for (int i = 0; i < v.length; i++) {
            System.out.println("Ingrese un numero para la posicion " +i);
            v[i] = in.nextInt();
        }

        System.out.println("------------asReturn------------");
        Parametros p = asReturn(v); 
        System.out.println("Maximo: "+p.getMaximo()+" Minimo: "+p.getMinimo()+" Prom: "+p.getProm());

        System.out.println("------------asParameter------------");
        p.reiniciar();

        in.close();
    }

    static Parametros asReturn(int[] v) {
        Parametros p = new Parametros();
        for (int i=0; i<v.length; i++) {
            if(p.getMaximo() < v[i]) p.setMaximo(v[i]);
            if(p.getMinimo() > v[i]) p.setMinimo(v[i]);
            p.setSuma(v[i]);
        }
        p.setProm((float)p.getSuma()/v.length);
        return p;
    }
}
