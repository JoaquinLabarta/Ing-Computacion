/*Escriba un programa que lea desde teclado un valor entero n y reserve memoria para una matriz 
triangular inferior de orden n de enteros. Como se desea ahorrar espacio de almacenamiento, 
no se deben almacenar los elementos cuyo valor es 0, es decir, sólo se reservará memoria para los 
valores del triángulo inferior de la matriz. Luego, inicialice la estructura con valores aleatorios 
entre 0 y 20 e imprímala en pantalla. Por último, libere la memoria reservada.
Nota: modularice la reserva de memoria, la inicialización, la impresión y la liberación de memoria.*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void reservarMemoria(int ***, int);
void inicializarMatriz(int ***, int);
void imprimirMatriz(int **, int);
void liberarMemoria(int **, int);

int main() {
    srand(time(NULL));
    int n, **matriz;
    printf("Ingrese un valor n: \n");
    scanf("%d", &n);
    reservarMemoria(&matriz, n);
    inicializarMatriz(&matriz, n);
    imprimirMatriz(matriz, n);
    liberarMemoria(matriz, n);
    return 0;
}

void reservarMemoria(int ***m, int n) {
    *m = (int **)malloc(n * sizeof(int *));
    for (int i = 0; i < n; i++) {
        (*m)[i] = (int *)malloc((i + 1) * sizeof(int));
    }
}

void inicializarMatriz(int ***m, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= i; j++) {
            (*m)[i][j] = rand() % 21;
        }
    }
}

void imprimirMatriz(int **m, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= i; j++) {
            printf(" %d ", m[i][j]);
        }
        printf("\n");
    }
}

void liberarMemoria(int **m, int n) {
    for (int i = 0; i < n; i++) {
        free(m[i]);
    }
    free(m);
}
