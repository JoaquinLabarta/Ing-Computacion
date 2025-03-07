package Ejercicio6;
/*6- Escriba un programa que defina una matriz de enteros de tamaño 10x10. Inicialice la matriz con los primeros 100 números pares
 * (ej: la pos. 0,0 contendrá 0; la pos. 0,1 contendrá 2; la pos. 0,2 contendrá 4; así siguiendo). 

Luego realice las siguientes operaciones: 
-    Mostrar el contenido de la matriz en consola. 
-    Calcular e informar la suma de todos los elementos almacenados entre las filas 2 y 9 y las columnas 0 y 3
-    Generar un vector de 10 posiciones donde cada posición i contiene la suma de los elementos de la columna i de la matriz.
-    Lea un valor entero e indique si se encuentra o no en la matriz. En caso de encontrarse indique su ubicación (fila y columna)
     en caso contrario imprima “No se encontró el elemento”.
*/
import java.util.Scanner;
public class ejercicio6 {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        
        //Declaracion de variables y matriz
        int DIMF = 10;
        int DIMC = 10;
        int [][] matriz;    
        matriz = new int [DIMF][DIMC];
        int num = 0;
        
        //----------------PUNTO A---------------------------------------------
        //Lleno la matriz con los datos solicitados
        for (int i = 0; i < DIMF; i++){
            for (int j = 0; j < DIMC; j++){
                matriz[i][j] = (2 * num);
                num ++;
            }
        }
        
        //----------------PUNTO B---------------------------------------------
        int suma = 0;
        for (int i = 2; i < DIMF; i++){
            for (int j = 0; j < 3; j++){
                suma = suma + matriz[i][j];
            }
        }
        
        System.out.println("La suma total es: "+suma);
        
        //----------------PUNTO C---------------------------------------------
        int DIMFV = 10;
        int [] vector;
        vector = new int [DIMF];
        int suma2 = 0;
        for (int i = 0; i < DIMC; i++){
            for (int j = 0; j < DIMF; j++){
                suma2 = suma2 + matriz[j][i];
            }
            vector[i] = suma2;
        }
        
        /*for (int i = 0; i < DIMFV; i++){
            System.out.println("La suma en la posicion "+i+ " es: "+vector[i]);
        }*/
    
        //----------------PUNTO D---------------------------------------------
        boolean encontro = false;
        
        int num2;
        System.out.println("Ingrese un numero a buscar en la matriz");
        num2 = in.nextInt();
        
        int fila = 0; int columna = 0;
        
            while ((encontro == false) && (fila < DIMF)){
                while((encontro == false) && (fila < DIMF) && (columna < DIMC)){
                    if (num2 == matriz[fila][columna] ){
                        encontro = true;
                    }
                    else {columna++;}
                 }
                if (encontro == false){
                    fila++; 
                    columna = 0;
                }
            }        
            if(encontro == true){
                System.out.println("El valor se encontro en la fila "+fila+" y columna "+columna);
            }
            else {System.out.println("No se encontro");}       
        in.close();
    }
} 