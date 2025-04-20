/* Escriba un programa que lea desde teclado un valor entero n y reserve memoria para una matriz
triangular inferior de orden n de enteros. Como se desea ahorrar espacio de almacenamiento, no se
deben almacenar los elementos cuyo valor es 0, es decir, sólo se reservará memoria para los valores
del triángulo inferior de la matriz. Luego, inicialice la estructura con valores aleatorios entre 0 y 20
e imprímala en pantalla. Por último, libere la memoria reservada.
Nota: modularice la reserva de memoria, la inicialización, la impresión y la liberación de memoria */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void reservarMemoria(int ***,int);
void inicializarMatriz(int **,int);
void imprimirMatriz(int **,int);
void liberarMemoria(int **,int);

int main(){
    int **mat,f;   
    printf("Ingrese la cantidad de filas ");
    scanf("%d",&f);
    reservarMemoria(&mat,f);
    inicializarMatriz(mat,f);
    imprimirMatriz(mat,f);
    liberarMemoria(mat,f);
    return 0;
}

void reservarMemoria(int ***mat,int f){
    *mat=(int **)calloc(f,sizeof(int*));
    for (int i = 0; i < f; i++)
    {
        (*mat)[i]=(int *)calloc((i+1),sizeof(int));
    }
}

void inicializarMatriz(int **mat, int f){
    srand(time(0));
    for (int i=0;i<f; i++) //podria agregar otro for para hacer mat[i][j]
    {
        mat[i][i]= rand() % 21;
    }
    
}

void imprimirMatriz(int **mat,int f){
    for (int i=0;i<f; i++){
        for (int j = 0; j < f; j++){
            if(j<=i){
                printf(" %d ",mat[i][j]);
            }
            else printf(" 0 ");
        }
        printf("\n");
    }
    
}

void liberarMemoria(int **mat,int f){
    for (int i = 0; i < f; i++){
        free(mat[i]);
    }
    free(mat);
}