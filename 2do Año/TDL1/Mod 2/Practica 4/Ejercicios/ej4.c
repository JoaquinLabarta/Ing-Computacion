/* Escriba un programa que lea un número entero n desde teclado y luego reserve memoria en forma
dinámica para un arreglo de n float. Inicialícelo con valores ingresados por teclado y a continuación
calcule e imprima el promedio de todos ellos. Por último, libere la memoria reservada dinámicamente.
Nota: Modularice la reserva de memoria, la inicialización y el cálculo del promedio. */
#include <stdio.h>
#include <stdlib.h>

float* reservarMemoria(int);
void llenarArreglo(int,float *);
float calcularPromedio(int,float*);

int main(){
    int nro;
    float *ptr;
    printf("Ingrese un valor mayor a cero");
    scanf("%d",&nro);
    ptr = reservarMemoria(nro);
    llenarArreglo(nro,ptr);
    printf("El promedio entre los numeros del arreglo es: %f",calcularPromedio(nro,ptr));
    return 0;
}

float * reservarMemoria(int nro){
    float * ptr = malloc(nro*sizeof(float));
    return ptr;
}

void llenarArreglo(int nro, float * ptr){
    for (int i=0; i<nro; i++){
        printf("Ingrese un valor para la posicion: %d\n",i);
        scanf("%f",ptr+i);
    }
}

float calcularPromedio(int nro, float * ptr){
    float suma=0,prom;
    for (int i=0;i<nro;i++){
        suma+=*(ptr+i);
    }
    prom=suma/(float) nro;
    return prom;
}