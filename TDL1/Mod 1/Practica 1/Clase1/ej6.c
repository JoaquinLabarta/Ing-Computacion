/* Escriba un programa que, a partir de un número flotante leído desde teclado, el cual representa una distancia en kilómetros,
imprima su equivalente en millas. Nota: 1,61 Km ≈ 1 milla. */
#include <stdio.h>
int main(){
    float nro;
    printf ("Ingrese los km \n");
    scanf("%f",&nro);
    printf("Los km en millas son: %f",(nro/1.61));
}
