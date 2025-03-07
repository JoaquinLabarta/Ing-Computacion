/*Se dispone de un arreglo con informaci�n de las precipitaciones de todos los d�as de todos los meses de los �ltimos 10 a�os.
Se desea conocer para cada a�o el mes en que menos llovi� y tambi�n cual es el a�o que tuvo menor precipitaci�n promedio.
Nota: por simplicidad asuma que todos los meses tienen 30 d�as. */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ANIO 10
#define MES 12
#define DIA 30

void buscarMin(int[], int[ANIO][MES][DIA], int*);

int main() {
    srand(time(NULL));
    int mesMenosLluvia[ANIO];
    int precipitacion[ANIO][MES][DIA];
    int anioConMayorPromedio;
    int maxPromedio = -1;

    /* Llenado de la matriz con datos aleatorios */
    for (int k = 0; k < ANIO; k++) {
        for (int i = 0; i < MES; i++) {
            for (int j = 0; j < DIA; j++) {
                precipitacion[k][i][j] = rand() % 100;
            }
        }
    }

    /* Proceso para encontrar el mes con menos lluvia y el a�o con el mayor promedio */
    buscarMin(mesMenosLluvia, precipitacion, &anioConMayorPromedio);

    printf("El a�o con el mayor promedio fue: %d\n", anioConMayorPromedio + 1);

    for (int i = 0; i < ANIO; i++) {
        printf("El mes que menos llovi� para el a�o %d fue el mes %d\n", i + 1, mesMenosLluvia[i] + 1);
    }

    return 0;
}

void buscarMin(int mesMenosLluvia[], int precipitacion[ANIO][MES][DIA], int* anioConMayorPromedio) {
    int min = 99999;

    for (int k = 0; k < ANIO; k++) {
        int sumaAnual = 0;
        int promAnual = 0;
        int prom = 0;

        for (int i = 0; i < MES; i++) {
            int sumaMes = 0;

            for (int j = 0; j < DIA; j++) {
                sumaMes += precipitacion[k][i][j];
            }

            if (sumaMes < min) {
                min = sumaMes;
                mesMenosLluvia[k] = i;
            }

            sumaAnual += sumaMes;
        }

        promAnual = sumaAnual / MES;

        if (promAnual > prom) {
            prom = promAnual;
            *anioConMayorPromedio = k;
        }
    }
}
