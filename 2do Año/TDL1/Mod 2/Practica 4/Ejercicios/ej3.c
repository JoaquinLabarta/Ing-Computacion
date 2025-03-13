#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int* reservarMemoria(int nro);
void llenarArreglo(int nro, int* ptr);
int maximo(int nro, int* ptr);

int main()
{
    srand(time(0)); // Para generar números aleatorios
    int nro, *ptr;
    printf("Ingrese un numero mayor que cero: ");
    scanf("%d",&nro);
    ptr = reservarMemoria(nro);
    llenarArreglo(nro, ptr);
    printf("El maximo numero dentro del arreglo es: %d\n", maximo(nro, ptr));
    free(ptr); // Liberar la memoria reservada
    return 0;
}

int* reservarMemoria(int nro)
{
    int* ptr = malloc(nro * sizeof(int));
    return ptr;
}

void llenarArreglo(int nro, int* ptr)
{
    for(int i = 0; i < nro; i++){
        ptr[i] = rand() % 100; // Genera números aleatorios entre 0 y 99
        printf("%d ", ptr[i]); // Imprime los números generados
    }
    printf("\n");
}

int maximo(int nro, int* ptr)
{
    int max = -1;
    for(int i = 0; i < nro; i++){
        if(ptr[i] >= max) max = ptr[i];
    }
    return max;
}
