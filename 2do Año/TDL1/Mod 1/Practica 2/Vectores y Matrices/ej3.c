/*Sea A una matriz con m filas y n columnas y c un número. La multiplicación de una matriz A por un
escalar c está dada por multiplicar cada entrada de A por c:
Escriba una función que reciba una matriz A y un número c, y que retorne en A la multiplicación
escalar cA.*/

#include <stdio.h>
#include <time.h>
#define FIL 2
#define COL 5

void llenarMatriz(int [][COL]);
void imprimirMatriz(int [][COL]);
void multiplicarMatriz(int [][COL],int);
void imprimirMatriz(int [][COL]);

int main(){
    srand(time(NULL));
    int m[FIL][COL];
    llenarMatriz(m);
    imprimirMatriz(m);
    int c = rand() % 10;
    printf("\n--- *%d ---\n",c);
    multiplicarMatriz(m,c);
    imprimirMatriz(m);
    return 0;
}

void llenarMatriz(int m[][COL]){
    srand(time(NULL));
    for (int i=0;i<FIL; i++){
        for (int j=0;j<COL;j++){
            m[i][j] = rand() % 10;
        }
    }
    return;
}

void imprimirMatriz(int m[][COL]){
    for (int i=0;i<FIL; i++){
        for (int j=0;j<COL;j++){
            printf(" %2d ",m[i][j]);
        }
        printf("\n");
    }   
}

void multiplicarMatriz(int m[][COL],int c){
    for (int i=0;i<FIL; i++){
        for (int j=0;j<COL;j++){
            m[i][j]*=c;
        }
    }
    return;
}