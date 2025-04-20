/*
a. Defina una estructura rectangulo que contenga los siguientes campos: base (float) y altura
(float).
b. Escriba una función que reciba una estructura rectangulo y la inicialice a partir de valores
ingresados por teclado.
c. Escriba una función que dada una estructura rectangulo, calcule el área.
d. Escriba un programa que defina un arreglo de 10 rectángulos (struct rectangulo) y lo
inicialice utilizando la función definida en el inciso anterior. Luego, informe el número de
rectángulo que tiene menor área.*/
#include <stdio.h>

typedef struct rectangulo {
    float base;
    float altura;
} rectangulo;

// Prototipos de funciones
void inicializarRectangulo(rectangulo *r, float base, float altura);
float calcularArea(rectangulo r);

int main() {
    rectangulo r[10];
    float base, altura, min = 99999, area;
    int minPos = -1;

    // Inicializar los 10 rectángulos y encontrar el de menor área
    for (int i = 0; i < 10; i++) {
        printf("\nIngrese un valor de base para el rectángulo %d: ", i + 1);
        scanf("%f", &base);
        printf("Ingrese un valor de altura para el rectángulo %d: ", i + 1);
        scanf("%f", &altura);

        inicializarRectangulo(&r[i], base, altura);

        area = calcularArea(r[i]);

        if (area < min) {
            minPos = i;
            min = area;
        }
    }

    // Informar el número del rectángulo con menor área
    printf("\nEl rectángulo con menor área es el número: %d\n", minPos + 1);

    return 0;
}

void inicializarRectangulo(rectangulo *r, float base, float altura) {
    r->base = base;
    r->altura = altura;
}

float calcularArea(rectangulo r) {
    return (r.base * r.altura);
}