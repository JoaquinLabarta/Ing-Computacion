#include <stdlib.h>

typedef struct {
    unsigned char r; // Componente roja (Red)
    unsigned char g; // Componente verde (Green)
    unsigned char b; // Componente azul (Blue)
} PixelRGB;

typedef struct {
    int tamaño;       // Tamaño del icono (número de píxeles en un lado)
    PixelRGB **píxeles; // Matriz dinámica para almacenar los píxeles RGB
} IconoRGB;

IconoRGB crear_icono(int n) {
    IconoRGB icono;
    icono.tamaño = n;

    // Asignar memoria para la matriz de píxeles RGB
    icono.píxeles = (PixelRGB **)malloc(n * sizeof(PixelRGB *));
    for (int i = 0; i < n; i++) {
        icono.píxeles[i] = (PixelRGB *)malloc(n * sizeof(PixelRGB));
    }

    // Inicializar los píxeles RGB (esto puede ser opcional según tus necesidades)
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            icono.píxeles[i][j].r = 0; // Componente roja inicializada a 0
            icono.píxeles[i][j].g = 0; // Componente verde inicializada a 0
            icono.píxeles[i][j].b = 0; // Componente azul inicializada a 0
        }
    }

    return icono;
}

void liberar_icono(IconoRGB icono) {
    // Liberar memoria de la matriz de píxeles RGB
    for (int i = 0; i < icono.tamaño; i++) {
        free(icono.píxeles[i]);
    }
    free(icono.píxeles);
}

int main() {
    int tamaño = 5; // Tamaño del icono
    IconoRGB mi_icono = crear_icono(tamaño);

    // Realizar operaciones con el icono...

    liberar_icono(mi_icono); // Liberar memoria al finalizar el uso del icono

    return 0;
}
