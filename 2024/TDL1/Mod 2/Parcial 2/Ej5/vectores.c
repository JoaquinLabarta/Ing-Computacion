#include <stdio.h>
#include "vectores.h"
float suma(float vec[],int cant){
    float total = 0;
    for (int i=0;i<cant; i++)
    {
        total+=vec[i];
    }
    return total;
}

float promedio(float v[],int cant){
    float prom, sumatoria = suma(v,cant);
    prom = sumatoria/(float)cant;
    return prom;
}