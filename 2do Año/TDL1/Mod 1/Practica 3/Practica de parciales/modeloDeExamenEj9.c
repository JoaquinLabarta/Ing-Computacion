#include <stdio.h>
#include <string.h>
#define PI 3.14
enum {CIR, TRI, CUA};

typedef struct figura {
    char color[10];
    union {
        int radio;
        int ladosT[2]; 
        int ladoC;
    } lado;
} figura;

float calcularArea(figura f, int tipo) {
    float area = 0.0;
    switch (tipo) {
    case CIR:
        area = PI * f.lado.radio * f.lado.radio;
        break;
    case TRI:
        area = (f.lado.ladosT[0] * f.lado.ladosT[1]) / 2.0;
        break;
    case CUA:
        area = f.lado.ladoC * f.lado.ladoC;
        break;
    default:
        break;
    }
    return area;
}

void imprimir(figura f, int tipo) {
    char nom[10];
    float area = calcularArea(f, tipo);
    switch (tipo) {
    case CIR:
        strcpy(nom, "circulo");
        break;
    case TRI:
        strcpy(nom, "triangulo");
        break;
    case CUA:
        strcpy(nom, "cuadrado");
        break;
    default:
        break;
    }
    printf("\nEl color del %s es %s y su area es %f", nom, f.color, area);
    return;
}
