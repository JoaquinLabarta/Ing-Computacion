/*Realice un programa que defina una macro AREA_CIRCULO(r) que permita calcular el área de un círculo
para un radio r. El cuerpo del programa debe generar aleatoriamente 10 valores diferentes que
representan radios e imprimir el área correspondiente.*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define PI 3.14
#define AREA_CIRCULO(r) 4*PI*r
#define cant 10
int main(){
    srand(time(NULL));
    for (int i=0;i<cant; i++)
    {
        int r=rand() % 11;
        printf("El area del circulo de radio %d es %.2f\n",r,AREA_CIRCULO(r));
    }
    return 0;
}