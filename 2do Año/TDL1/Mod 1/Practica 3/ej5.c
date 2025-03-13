#include <stdio.h>

// Definición de la unión para representar un rectángulo
union Rectangulo {
    struct {
        int x;
        int y;
        int ancho;
        int alto;
    };
    struct {
        int punto1[2];
        int punto2[2];
    };
    int rect[4];
};

int main() {
    // Ejemplo de uso de la unión
    union Rectangulo ventana;

    // Acceso a través de todas separadas (x, y, ancho, alto)
    ventana.x = 10;
    ventana.y = 20;
    ventana.ancho = 100;
    ventana.alto = 50;

    printf("Forma separada: x = %d, y = %d, ancho = %d, alto = %d\n", ventana.x, ventana.y, ventana.ancho, ventana.alto);

    // Acceso como dos puntos ([x1, y1], [x2, y2])
    ventana.punto1[0] = 5;
    ventana.punto1[1] = 10;
    ventana.punto2[0] = 15;
    ventana.punto2[1] = 30;

    printf("Dos puntos: [%d, %d], [%d, %d]\n", ventana.punto1[0], ventana.punto1[1], ventana.punto2[0], ventana.punto2[1]);

    // Acceso como un rectángulo ([x, y, ancho, alto])
    ventana.rect[0] = 50;
    ventana.rect[1] = 60;
    ventana.rect[2] = 120;
    ventana.rect[3] = 80;

    printf("Rectángulo: [x = %d, y = %d, ancho = %d, alto = %d]\n", ventana.rect[0], ventana.rect[1], ventana.rect[2], ventana.rect[3]);

    return 0;
}
