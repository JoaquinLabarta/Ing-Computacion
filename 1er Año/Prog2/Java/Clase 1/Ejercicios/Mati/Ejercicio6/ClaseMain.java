
/**
scriba un programa que defina una matriz de enteros de tamaño 10x10.
 Inicialice la matriz con los primeros 100 números
 pares (ej: la pos. 0,0 contendrá 0; la pos. 0,1 contendrá 2; la pos. 0,2 contendrá 4; así siguiendo). 
Luego realice las siguientes operaciones: 
    b• Mostrar el contenido de la matriz en consola. 
    c• Calcular e informar la suma de todos los elementos almacenados entre las filas 2 y 9 y las columnas 0 y 3
    d• Generar un vector de 10 posiciones donde cada posición i contiene la suma de los elementos de la columna i de la matriz.
    e• Lea un valor entero e indique si se encuentra o no en la matriz. En caso de encontrarse indique su
    ubicación (fila y columna) en caso contrario imprima “No se encontró el elemento”.*/
import java.util.Scanner;
public class ClaseMain
{          
   public static void main(String[]args)
   {
    // -----------------PUNTO A----------------------------------------------------------------------
          System.out.println("punto A");
          int num=0;
          int [][] tabla = new int[10][10];
          int i, j;
          for (i=0;i<10;i++)
            for (j=0;j<10;j++){
              num=num+2;
              tabla[i][j]=num;
            }
    // -----------------PUNTO B----------------------------------------------------------------------
    System.out.println("punto B");
    for (i=0;i<10;i++)
            for (j=0;j<10;j++){
                System.out.println(tabla[i][j]);  
            }
    // -----------------PUNTO C----------------------------------------------------------------------
          System.out.println("punto C");
          for (i=2;i<10;i++)
            for (j=0;j<10;j++){
                System.out.println(tabla[i][j]);  
            }
          for (i=0;i<10;i++)
            for (j=0;j<3;j++){
                System.out.println(tabla[i][j]);  
            }  
    // -----------------PUNTO D----------------------------------------------------------------------
          System.out.println("punto D");
          int suma=0;
          int suma2=0;
          int DIMF;
          int DIMC;
          int []vector = new int[10];
          for (DIMF=0;DIMF<10;DIMF++){
            suma=0;  
            for (DIMC=0;DIMC<10;DIMC++){
              suma=suma+tabla[DIMF][DIMC];
            }
            vector[DIMF]=suma;
        }
        
        for (DIMF=0;DIMF<10;DIMF++){
            suma=0;  
            for (DIMC=0;DIMC<10;DIMC++){
              suma=suma+tabla[DIMF][DIMC];
            }
            vector[DIMF]=suma;
        }
        for (j=0;j<10;j++){
          System.out.println(vector[j]); 
       }
       // -----------------PUNTO E----------------------------------------------------------------------
         /*
          System.out.println("punto E");
          Scanner in = new Scanner(System.in);
          int buscar=0;
          DIMC=0;
          System.out.println("ingrese el valor a buscar");
          buscar=in.nextInt();
          boolean encontro=false;
          while((encontro==false) && ((DIMF<10)||(DIMC<10))){
                for (DIMF=0;DIMF<10;DIMF++){
                  suma=0;  
                  for (DIMC=0;DIMC<10;DIMC++){
                    if(buscar==tabla[DIMF][DIMC])
                      encontro=true;
            }
            vector[DIMF]=suma;
        }
        }
        System.out.println(encontro);
        */
        // -----------------PUNTO E----------------------------------------------------------------------
          System.out.println("punto E con whilesss");
          DIMC=0;
          Scanner in = new Scanner(System.in);
          System.out.println("ingrese el valor a buscar");
          int buscar=in.nextInt();
          boolean encontro=false;
          int fila=0;
          int colomna=0;
          while((fila<10)&&(encontro==false)){
            while((colomna<10)&&(encontro==false)){
                if(buscar==tabla[fila][colomna])
                  encontro=true;
                if(colomna<10)
                  colomna++;
                }
            if(fila<10)
                  fila++;
            colomna=0;      
          }
          System.out.println("se encontro o no : "+encontro+"en la fila "+fila+"en la columna "+colomna);
        }
  }
