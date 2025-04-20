package Ej9;
public class Main{
    public static void main(String[] args) {
        String str = "{[()()]}";
        String str2 = "{({))]";
        if (TestBalanceo.esBalanceado(str)) {
            System.out.println("La palabra "+str+" esta balanceada");   
        } else System.out.println("La palabra "+str+" esta desbalanceada"); 

        if (TestBalanceo.esBalanceado(str2)) {
            System.out.println("La palabra "+str2+" esta balanceada");   
        } else System.out.println("La palabra "+str2+" esta desbalanceada"); 
    }
}