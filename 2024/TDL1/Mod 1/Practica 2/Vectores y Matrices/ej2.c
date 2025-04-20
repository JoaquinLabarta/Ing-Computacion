/*2. Escriba 3 funciones que reciban un arreglo unidimensional de float y que:
a. retorne el promedio de sus valores.
b. retorne el mínimo de sus valores.
c. retorne la posición del máximo de sus valores.*/

#include <stdio.h>
#define NUM 5
float minimo(float []);
float promedio(float []);
int posMaximo(float []);

int main(){
    float v[NUM] = {4,5,1,1,3};
    printf("El promedio es: %.1f. El minimo es: %.1f. La posicion del maximo es: %d",promedio(v),minimo(v),posMaximo(v));
    return 0;
}

float promedio(float v[]){
    float suma = 0;
    for (int i=0;i<NUM;i++){
        suma+=v[i];
    }
    return (suma/(float)NUM);
}
float minimo(float v[]){
    float min = 9999;
    for(int i=0;i<NUM;i++){
        if(v[i]<min) min=v[i];
    }
    return min;
}
int posMaximo(float v[]){
    float max=-1;
    int j=-1;
    for(int i=0;i<NUM;i++){
        if(v[i]>max){
            max = v[i];
            j = i;
        }
    }
    return j;
}