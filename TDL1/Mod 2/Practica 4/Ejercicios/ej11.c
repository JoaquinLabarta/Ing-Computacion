/* Escriba un programa que lea desde teclado dos valores enteros n y m, y luego reserve memoria en
forma dinámica para una matriz de enteros de n filas por m columnas. Inicialice la matriz creada con
valores ingresados por teclado. Una vez inicializada, imprima las posiciones de todos aquellos valores
múltiplos de 3. Por último, libere la memoria reservada.
Nota: modularice la reserva de memoria, la inicialización, la impresión de las posiciones con valores
múltiplo de 3 y la liberación de memoria. */

#include <stdio.h>
#include <stdlib.h>

void reservarMemoria(int ***,int,int);
void inicializarMatriz(int **,int,int);
void imprimirMatriz(int **,int,int);
void liberarMemoria(int **,int);

int main(){
    int n,m;
    printf("Ingrese la cantidad de filas \n");
    scanf("%d",&n);
    printf("Ingrese la cantidad de columnas \n");
    scanf("%d",&m);
    int ** mat;
    reservarMemoria(&mat,n,m);
    inicializarMatriz(mat,n,m);
    imprimirMatriz(mat,n,m);
    liberarMemoria(mat,n);
    return 0;
}

void reservarMemoria(int ***mat,int f,int c){
    *mat=(int **)malloc(f*sizeof(int*));
    for (int i = 0; i < f; i++)
    {
        (*mat)[i]=(int *)malloc(c*sizeof(int));
    }
}

void inicializarMatriz(int ** mat,int f,int c){
    for (int i=0; i<f; i++){
        for (int j=0;j<c;j++){
            printf("Ingrese un valor para la matriz en la posiciion [%d][%d] \n",i,j);
            scanf("%d",&mat[i][j]);
        }
    }
}

void imprimirMatriz (int **mat,int f,int c){
    printf("Sin multiplos \n");
    for(int i=0;i<f;i++){
        for (int j=0; j<c; j++){
            printf(" %d ",mat[i][j]); //matriz sin multiplos
        }
        printf("\n");
    }
    printf("Con multiplos\n");
    for(int i=0;i<f;i++){
        for (int j=0; j<c; j++){
            if(mat[i][j]%3 == 0){
                printf(" %d ",mat[i][j]); //matriz con multiplos
            }
        }
        printf("\n");
    }
}

void liberarMemoria(int **mat,int f){
    for(int i=0;i<f;i++){
        free(mat[i]);
    }
    free(mat);
}