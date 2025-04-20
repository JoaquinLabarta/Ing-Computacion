/*Escriba un programa que imprima la raíz cuadrada, el cuadrado y el cubo de los números enteros comprendidos en el rango 1..10.
Nota: para calcular la raíz cuadrada y la potencia de un número investigue las funciones sqrt() y pow(), ambas de la librería <math.h>. */
#include <stdio.h>
#include <math.h>
int main(){
    int cuadrado;
    float cubica,raiz;
    for (int i=1;i<=10;i++){
        printf("El cuadrado de %d ",i);
        cuadrado=pow(i,2);
        printf(" es: %d \n",cuadrado);
        //----------------------------------
        printf("La raiz cuadrada de %d ",i);
        raiz=sqrt(i);
        printf(" es: %f \n",raiz);
        //----------------------------------
        printf("La raiz cubica de %d ",i);
        cubica=pow(i,(double)1/3);
        printf(" es: %.2f \n",cubica);
    }
    return 0;
}
