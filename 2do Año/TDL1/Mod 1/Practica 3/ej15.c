/*.Desarrolle un programa que utilice un tipo de datos que modele las figuras geométricas
bidimensionales: circulo, elipse, triángulo, cuadrado y rectángulo con sus propiedades (radio, lado/s,
base, etc.). Implemente una única función que permita calcular la superficie de cualquier figura.
El programa debe leer por teclado los datos de una figura e imprimir su superficie.*/
#include <stdio.h>
#define pi 3.14
typedef struct circulo{
    unsigned int radio : 8;
}circulo;

typedef struct elipse{
    unsigned int ancho : 8;
    unsigned int alto : 7;
} elipse;

typedef struct triangulo{
    unsigned int base : 8;
    unsigned int altura : 7;
} triangulo;

typedef struct rectangulo{
    unsigned int alto : 8;
    unsigned int ancho : 8;
} rectangulo;

typedef union figura{
    circulo c;
    elipse e;
    triangulo t;
    rectangulo r;
} figura;

float calcularArea(figura,int);

int main(){
    figura f;
    int tipo;
    float area;
    int a,b;
    while (tipo!=4){
        printf("\nIngrese que figura desea calcular el area (0: circulo, 1: elipse, 2: triangulo, 3: rectangulo): ");
        scanf("%d",&tipo);
        switch (tipo){
        case 0:
            int r;
            printf("\nIngrese el radio del circulo: ");
            scanf("%d",&r);
            f.c.radio = r;
            area = calcularArea(f,tipo);
            break;
        case 1:
            printf("\nIngrese el alto de la elipse: ");
            scanf("%d",&a);
            printf("\nIngrese el ancho de la elipse: ");
            scanf("%d",&b);
            f.e.alto = a;
            f.e.ancho = b;
            area = calcularArea(f,tipo);
            break;
        case 2:
            printf("\nIngrese el alto del triangulo: ");
            scanf("%d",&a);
            printf("\nIngrese el ancho del triangulo: ");
            scanf("%d",&b);
            f.t.altura = a;
            f.t.base = b;
            area = calcularArea(f,tipo);
            break;
        case 3:
            printf("\nIngrese el lado 1 del rectangulo: ");
            scanf("%d",&a);
            printf("\nIngrese el lado 2 del rectangulo: ");
            scanf("%d",&b);
            f.r.alto = a;
            f.r.ancho = b;
            area = calcularArea(f,tipo);
            break;
        default:
            break;
        }

        printf("El area de la figura es: %.1f",area);
    }
    return 0;
}

float calcularArea(figura f,int tipo){
    float area;
    switch (tipo){
    case 0:
        area = pi*f.c.radio*f.c.radio;
        break;
    case 1:
        area = pi*f.e.alto*f.e.ancho;
        break;
    case 2:
        area = (f.t.altura*f.t.base)/2;
        break;
    case 3:
        area = f.r.alto * f.r.ancho;
        break;
    default:
        return -1;
    }

    return area;
}