/*Escriba un programa que genere 50 números enteros en forma pseudoaleatoria y que los almacene en
un arreglo unidimensional. Luego de realizada la carga, informar la cantidad de números pares que
se encuentran en posiciones impares del arreglo y también la cantidad de números impares que se
encuentran en posiciones pares.*/
#include <stdio.h>
#include <time.h>

void calcular(int * ,int *,int []);
void cargarVector(int []);

int main(){
    int v[50];
    cargarVector(v);
    int cantPares = 0, cantImpares = 0;
    calcular(&cantPares,&cantImpares,v);
    printf("La cantidad de numeros pares en posiciones impares es: %d, mientras que la cantidad de numeros impares en posicines pares es: %d",cantPares,cantImpares);
    return 0;
}

void calcular(int * cp,int * ci,int v[]){
    for (int i=0;i<50; i++){
        if((i%2 == 0) && (v[i]%2 != 0)) (*ci)++;
        else if((i%2 != 0) && (v[i]%2 == 0)) (*cp)++;
    }
    return;
}

void cargarVector(int v[]){
    srand(time(NULL));
    for (int i=0;i<50; i++)
    {
        v[i] = rand() % 100;
    }
    return;
}