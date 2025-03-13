/* Escriba un programa que lea un número entero n y luego reserve memoria en forma dinámica para
un arreglo de n elementos double. Inicialice las posiciones del arreglo a partir de valores ingresados
por teclado y a continuación imprima el promedio de todos ellos.
a. Empleando notación de arreglos.
b. Empleando notación de punteros.
Por último, libere la memoria reservada.
Nota: modularice la reserva de memoria, la inicialización, el cálculo del promedio y la liberación de
memoria. */
#include <stdio.h>
#include <stdlib.h>

void reservarMemoriaPunteros(double **, int);
void inicializarArrayPunteros(double *, int);
double calcularPromedioPunteros(double *, int);
void liberarMemoriaPunteros(double *);

int main() {
    int n;
    double *vec;
    printf("Ingrese el tamaño del vector: \n");
    scanf("%d", &n);
    reservarMemoriaPunteros(&vec, n);
    inicializarArrayPunteros(vec, n);
    printf("El promedio del arreglo es: %lf\n", calcularPromedioPunteros(vec, n));
    liberarMemoriaPunteros(vec);
    return 0;
}

void reservarMemoriaPunteros(double **vec, int n) {
    *vec = (double *)malloc(n * sizeof(double));
}

void inicializarArrayPunteros(double *vec, int n) {
    int i;
    for (i = 0; i < n; i++) {
        printf("Ingrese un valor para la posición: %d\n", i);
        scanf("%lf", &vec[i]);
    }
}

double calcularPromedioPunteros(double *vec, int n) {
    double prom, suma = 0;
    for (int i = 0; i < n; i++) {
        suma += vec[i];
    }
    prom = suma / (double)n;
    return prom;
}

void liberarMemoriaPunteros(double *vec) {
    free(vec);
}
