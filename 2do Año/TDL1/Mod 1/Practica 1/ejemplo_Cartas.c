#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NUM_PALOS 4
#define NUM_CARTAS 12

int main() {
    // Inicializar el generador de números aleatorios
    srand(time(NULL));

    // Crear e inicializar el mazo de cartas
    int mazo[NUM_PALOS][NUM_CARTAS] = {0};
    int palosCompletos, numeroElegido;

    do {
        // Elegir un número al azar
        numeroElegido = rand() % NUM_CARTAS;

        // Extraer una carta de cada palo con el número elegido
        for (int i = 0; i < NUM_PALOS; i++) {
            mazo[i][numeroElegido] = 1;
        }

        // Verificar si se han completado los 4 palos con el número elegido
        palosCompletos = 1;
        for (int i = 0; i < NUM_PALOS; i++) {
            if (mazo[i][numeroElegido] == 0) {
                palosCompletos = 0;
                break;
            }
        }
    } while (palosCompletos == 0);

    // Imprimir el número que completó los 4 palos
    printf("El número que completó los 4 palos es: %d\n", numeroElegido + 1);

    return 0;
}
